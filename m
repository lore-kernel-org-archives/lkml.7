Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD7BC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0702184B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279632;
	bh=MHOCwvvRRibffimaH8MR2Q0R2tOVXLjzwZSaXHCRXrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jKTkh2l1E02ssxppvV/DpecWKrTByO1duICZ26tKvJ45/dXfkuDM1ffj5bHDa3BLp
	 meQkTW2JhvVJsRTeiJypLpa/koIFfxA41ZR/XVgz4b/blHryWDroxbYQaN2gsnR3vS
	 u3h29omowYPJ4e+FQxzH4ykljc51YtOHdCANLBUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436474AbfFKTAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407212AbfFKTAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:00:31 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53FB22184D;
        Tue, 11 Jun 2019 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279629;
        bh=MHOCwvvRRibffimaH8MR2Q0R2tOVXLjzwZSaXHCRXrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCAby+NvrhdaZ2MCXfEFygbJwyqThtjMSUdM3Nfpyi5kSLAqEAFFhrCoKzoWTEtCs
         anQLQhPm73njZur4/CnQSUcSuIn7CsByBdEOAGqsZWn88G1CzTe8yrhFbnR/sUgP3U
         2jLqC+LNhogilLx/GyNVnxLAYrukFvOyj9MxyArs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/85] perf scripts python: export-to-postgresql.py: Export IPC information
Date:   Tue, 11 Jun 2019 15:58:06 -0300
Message-Id: <20190611185911.11645-21-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Export cycle and instruction counts on samples and calls tables.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-18-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

