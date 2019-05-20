Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C27C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4AF20645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733202AbfETLiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:38:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:48121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733178AbfETLiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:38:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 04:38:07 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2019 04:38:06 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 17/22] perf scripts python: export-to-postgresql.py: Export IPC information
Date:   Mon, 20 May 2019 14:37:23 +0300
Message-Id: <20190520113728.14389-18-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520113728.14389-1-adrian.hunter@intel.com>
References: <20190520113728.14389-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export cycle and instruction counts on samples and calls tables.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/export-to-postgresql.py    | 36 ++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index b2f481b0d28d..93225c02117e 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -394,7 +394,9 @@ if branches:
 		'to_ip		bigint,'
 		'branch_type	integer,'
 		'in_tx		boolean,'
-		'call_path_id	bigint)')
+		'call_path_id	bigint,'
+		'insn_count	bigint,'
+		'cyc_count	bigint)')
 else:
 	do_query(query, 'CREATE TABLE samples ('
 		'id		bigint		NOT NULL,'
@@ -418,7 +420,9 @@ else:
 		'data_src	bigint,'
 		'branch_type	integer,'
 		'in_tx		boolean,'
-		'call_path_id	bigint)')
+		'call_path_id	bigint,'
+		'insn_count	bigint,'
+		'cyc_count	bigint)')
 
 if perf_db_export_calls or perf_db_export_callchains:
 	do_query(query, 'CREATE TABLE call_paths ('
@@ -439,7 +443,9 @@ if perf_db_export_calls:
 		'return_id	bigint,'
 		'parent_call_path_id	bigint,'
 		'flags		integer,'
-		'parent_id	bigint)')
+		'parent_id	bigint,'
+		'insn_count	bigint,'
+		'cyc_count	bigint)')
 
 do_query(query, 'CREATE VIEW machines_view AS '
 	'SELECT '
@@ -521,6 +527,9 @@ if perf_db_export_calls:
 			'return_time,'
 			'return_time - call_time AS elapsed_time,'
 			'branch_count,'
+			'insn_count,'
+			'cyc_count,'
+			'CASE WHEN cyc_count=0 THEN CAST(0 AS NUMERIC(20, 2)) ELSE CAST((CAST(insn_count AS FLOAT) / cyc_count) AS NUMERIC(20, 2)) END AS IPC,'
 			'call_id,'
 			'return_id,'
 			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE CAST ( flags AS VARCHAR(6) ) END AS flags,'
@@ -546,7 +555,10 @@ do_query(query, 'CREATE VIEW samples_view AS '
 		'to_sym_offset,'
 		'(SELECT short_name FROM dsos WHERE id = to_dso_id) AS to_dso_short_name,'
 		'(SELECT name FROM branch_types WHERE id = branch_type) AS branch_type_name,'
-		'in_tx'
+		'in_tx,'
+		'insn_count,'
+		'cyc_count,'
+		'CASE WHEN cyc_count=0 THEN CAST(0 AS NUMERIC(20, 2)) ELSE CAST((CAST(insn_count AS FLOAT) / cyc_count) AS NUMERIC(20, 2)) END AS IPC'
 	' FROM samples')
 
 
@@ -618,10 +630,10 @@ def trace_begin():
 	comm_table(0, "unknown")
 	dso_table(0, 0, "unknown", "unknown", "")
 	symbol_table(0, 0, 0, 0, 0, "unknown")
-	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
+	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
 	if perf_db_export_calls or perf_db_export_callchains:
 		call_path_table(0, 0, 0, 0)
-		call_return_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
+		call_return_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
 
 unhandled_count = 0
 
@@ -772,11 +784,11 @@ def branch_type_table(branch_type, name, *x):
 	value = struct.pack(fmt, 2, 4, branch_type, n, name)
 	branch_type_file.write(value)
 
-def sample_table(sample_id, evsel_id, machine_id, thread_id, comm_id, dso_id, symbol_id, sym_offset, ip, time, cpu, to_dso_id, to_symbol_id, to_sym_offset, to_ip, period, weight, transaction, data_src, branch_type, in_tx, call_path_id, *x):
+def sample_table(sample_id, evsel_id, machine_id, thread_id, comm_id, dso_id, symbol_id, sym_offset, ip, time, cpu, to_dso_id, to_symbol_id, to_sym_offset, to_ip, period, weight, transaction, data_src, branch_type, in_tx, call_path_id, insn_cnt, cyc_cnt, *x):
 	if branches:
-		value = struct.pack("!hiqiqiqiqiqiqiqiqiqiqiiiqiqiqiqiiiBiq", 18, 8, sample_id, 8, evsel_id, 8, machine_id, 8, thread_id, 8, comm_id, 8, dso_id, 8, symbol_id, 8, sym_offset, 8, ip, 8, time, 4, cpu, 8, to_dso_id, 8, to_symbol_id, 8, to_sym_offset, 8, to_ip, 4, branch_type, 1, in_tx, 8, call_path_id)
+		value = struct.pack("!hiqiqiqiqiqiqiqiqiqiqiiiqiqiqiqiiiBiqiqiq", 20, 8, sample_id, 8, evsel_id, 8, machine_id, 8, thread_id, 8, comm_id, 8, dso_id, 8, symbol_id, 8, sym_offset, 8, ip, 8, time, 4, cpu, 8, to_dso_id, 8, to_symbol_id, 8, to_sym_offset, 8, to_ip, 4, branch_type, 1, in_tx, 8, call_path_id, 8, insn_cnt, 8, cyc_cnt)
 	else:
-		value = struct.pack("!hiqiqiqiqiqiqiqiqiqiqiiiqiqiqiqiqiqiqiqiiiBiq", 22, 8, sample_id, 8, evsel_id, 8, machine_id, 8, thread_id, 8, comm_id, 8, dso_id, 8, symbol_id, 8, sym_offset, 8, ip, 8, time, 4, cpu, 8, to_dso_id, 8, to_symbol_id, 8, to_sym_offset, 8, to_ip, 8, period, 8, weight, 8, transaction, 8, data_src, 4, branch_type, 1, in_tx, 8, call_path_id)
+		value = struct.pack("!hiqiqiqiqiqiqiqiqiqiqiiiqiqiqiqiqiqiqiqiiiBiqiqiq", 24, 8, sample_id, 8, evsel_id, 8, machine_id, 8, thread_id, 8, comm_id, 8, dso_id, 8, symbol_id, 8, sym_offset, 8, ip, 8, time, 4, cpu, 8, to_dso_id, 8, to_symbol_id, 8, to_sym_offset, 8, to_ip, 8, period, 8, weight, 8, transaction, 8, data_src, 4, branch_type, 1, in_tx, 8, call_path_id, 8, insn_cnt, 8, cyc_cnt)
 	sample_file.write(value)
 
 def call_path_table(cp_id, parent_id, symbol_id, ip, *x):
@@ -784,7 +796,7 @@ def call_path_table(cp_id, parent_id, symbol_id, ip, *x):
 	value = struct.pack(fmt, 4, 8, cp_id, 8, parent_id, 8, symbol_id, 8, ip)
 	call_path_file.write(value)
 
-def call_return_table(cr_id, thread_id, comm_id, call_path_id, call_time, return_time, branch_count, call_id, return_id, parent_call_path_id, flags, parent_id, *x):
-	fmt = "!hiqiqiqiqiqiqiqiqiqiqiiiq"
-	value = struct.pack(fmt, 12, 8, cr_id, 8, thread_id, 8, comm_id, 8, call_path_id, 8, call_time, 8, return_time, 8, branch_count, 8, call_id, 8, return_id, 8, parent_call_path_id, 4, flags, 8, parent_id)
+def call_return_table(cr_id, thread_id, comm_id, call_path_id, call_time, return_time, branch_count, call_id, return_id, parent_call_path_id, flags, parent_id, insn_cnt, cyc_cnt, *x):
+	fmt = "!hiqiqiqiqiqiqiqiqiqiqiiiqiqiq"
+	value = struct.pack(fmt, 14, 8, cr_id, 8, thread_id, 8, comm_id, 8, call_path_id, 8, call_time, 8, return_time, 8, branch_count, 8, call_id, 8, return_id, 8, parent_call_path_id, 4, flags, 8, parent_id, 8, insn_cnt, 8, cyc_cnt)
 	call_file.write(value)
-- 
2.17.1

