Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EE4C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D684520645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733187AbfETLiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:38:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:48121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733170AbfETLiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:38:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 04:38:05 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2019 04:38:04 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 16/22] perf scripts python: export-to-sqlite.py: Export IPC information
Date:   Mon, 20 May 2019 14:37:22 +0300
Message-Id: <20190520113728.14389-17-adrian.hunter@intel.com>
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
 tools/perf/scripts/python/export-to-sqlite.py | 36 ++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index f617e518332f..4542ce89034b 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -218,7 +218,9 @@ if branches:
 		'to_ip		bigint,'
 		'branch_type	integer,'
 		'in_tx		boolean,'
-		'call_path_id	bigint)')
+		'call_path_id	bigint,'
+		'insn_count	bigint,'
+		'cyc_count	bigint)')
 else:
 	do_query(query, 'CREATE TABLE samples ('
 		'id		integer		NOT NULL	PRIMARY KEY,'
@@ -242,7 +244,9 @@ else:
 		'data_src	bigint,'
 		'branch_type	integer,'
 		'in_tx		boolean,'
-		'call_path_id	bigint)')
+		'call_path_id	bigint,'
+		'insn_count	bigint,'
+		'cyc_count	bigint)')
 
 if perf_db_export_calls or perf_db_export_callchains:
 	do_query(query, 'CREATE TABLE call_paths ('
@@ -263,7 +267,9 @@ if perf_db_export_calls:
 		'return_id	bigint,'
 		'parent_call_path_id	bigint,'
 		'flags		integer,'
-		'parent_id	bigint)')
+		'parent_id	bigint,'
+		'insn_count	bigint,'
+		'cyc_count	bigint)')
 
 # printf was added to sqlite in version 3.8.3
 sqlite_has_printf = False
@@ -359,6 +365,9 @@ if perf_db_export_calls:
 			'return_time,'
 			'return_time - call_time AS elapsed_time,'
 			'branch_count,'
+			'insn_count,'
+			'cyc_count,'
+			'CASE WHEN cyc_count=0 THEN CAST(0 AS FLOAT) ELSE ROUND(CAST(insn_count AS FLOAT) / cyc_count, 2) END AS IPC,'
 			'call_id,'
 			'return_id,'
 			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE flags END AS flags,'
@@ -384,7 +393,10 @@ do_query(query, 'CREATE VIEW samples_view AS '
 		'to_sym_offset,'
 		'(SELECT short_name FROM dsos WHERE id = to_dso_id) AS to_dso_short_name,'
 		'(SELECT name FROM branch_types WHERE id = branch_type) AS branch_type_name,'
-		'in_tx'
+		'in_tx,'
+		'insn_count,'
+		'cyc_count,'
+		'CASE WHEN cyc_count=0 THEN CAST(0 AS FLOAT) ELSE ROUND(CAST(insn_count AS FLOAT) / cyc_count, 2) END AS IPC'
 	' FROM samples')
 
 do_query(query, 'END TRANSACTION')
@@ -407,15 +419,15 @@ branch_type_query = QSqlQuery(db)
 branch_type_query.prepare("INSERT INTO branch_types VALUES (?, ?)")
 sample_query = QSqlQuery(db)
 if branches:
-	sample_query.prepare("INSERT INTO samples VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
+	sample_query.prepare("INSERT INTO samples VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
 else:
-	sample_query.prepare("INSERT INTO samples VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
+	sample_query.prepare("INSERT INTO samples VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
 if perf_db_export_calls or perf_db_export_callchains:
 	call_path_query = QSqlQuery(db)
 	call_path_query.prepare("INSERT INTO call_paths VALUES (?, ?, ?, ?)")
 if perf_db_export_calls:
 	call_query = QSqlQuery(db)
-	call_query.prepare("INSERT INTO calls VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
+	call_query.prepare("INSERT INTO calls VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
 
 def trace_begin():
 	printdate("Writing records...")
@@ -427,10 +439,10 @@ def trace_begin():
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
 
@@ -486,14 +498,14 @@ def sample_table(*x):
 	if branches:
 		for xx in x[0:15]:
 			sample_query.addBindValue(str(xx))
-		for xx in x[19:22]:
+		for xx in x[19:24]:
 			sample_query.addBindValue(str(xx))
 		do_query_(sample_query)
 	else:
-		bind_exec(sample_query, 22, x)
+		bind_exec(sample_query, 24, x)
 
 def call_path_table(*x):
 	bind_exec(call_path_query, 4, x)
 
 def call_return_table(*x):
-	bind_exec(call_query, 12, x)
+	bind_exec(call_query, 14, x)
-- 
2.17.1

