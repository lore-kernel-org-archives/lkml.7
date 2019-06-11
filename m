Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE22C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B7921874
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279628;
	bh=ZljDOsc038z97SZIi1ReF86KVSpIlHtG84dx+4IB+VY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=omQb+r9WUSGeMNUmMdRrHRWr9aeFhWVzFINx/4c7oF9B3FvTZbrdhbW2OSlOTXO3k
	 s6lM75capwoAONfjuqvTEZbSWcS9q//JXfem9qmjOyAzQAqFU6DLK28RXC5wbRni42
	 U6Sz3R7koVzG94r5J6bw2O74AlBHAEo6FGAPkW7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407211AbfFKTA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389344AbfFKTA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:00:27 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 620CE218A2;
        Tue, 11 Jun 2019 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279626;
        bh=ZljDOsc038z97SZIi1ReF86KVSpIlHtG84dx+4IB+VY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBb/y5C+M64MHXudE94yp2dup+wNDbo+/wwTL9N+j4QH7RAmS6GpuyXWbvnfNWiPg
         4GpL9R2uV91NGqkjFSs2mcnojIq7rzBmSsRYbF4NX3hnos2lHpxgWQDQ31LlwnI4YA
         eePGn/dyE1GOowOv+ObdvJakjG4krj9UO6hYEm+c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 19/85] perf scripts python: export-to-sqlite.py: Export IPC information
Date:   Tue, 11 Jun 2019 15:58:05 -0300
Message-Id: <20190611185911.11645-20-acme@kernel.org>
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

Committer testing:

First runs some workload collecting intel_pt with the 'cyc' ter just for
userspace:

  [root@quaco adrian.hunter]# perf record -o simple-retpoline.perf.data -e intel_pt/cyc/u ./simple-retpoline
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.035 MB simple-retpoline.perf.data ]
  [root@quaco adrian.hunter]#

Then use the export-to-sqlite.py script to see if the changes in this
cset don't make it to break and if the changes in the db schema are the
ones expected:

  [root@quaco adrian.hunter]# perf script -i simple-retpoline.perf.data --itrace=be -s ~acme/libexec/perf-core/scripts/python/export-to-sqlite.py simple-retpoline.db branches calls
  2019-05-31 11:50:46.942710 Creating database ...
  2019-05-31 11:50:46.949663 Writing records...
  2019-05-31 11:50:47.224033 Adding indexes
  2019-05-31 11:50:47.231599 Done
  [root@quaco adrian.hunter]#

Now lets use the db:

  [root@quaco adrian.hunter]# sqlite3 simple-retpoline.db
  SQLite version 3.26.0 2018-12-01 12:34:55
  Enter ".help" for usage hints.
  sqlite> .schema samples
  CREATE TABLE samples (id integer NOT NULL PRIMARY KEY,evsel_id bigint,machine_id bigint,thread_id bigint,comm_id bigint,dso_id bigint,symbol_id bigint,sym_offset bigint,ip bigint,time bigint,cpuinteger,to_dso_id bigint,to_symbol_id bigint,to_sym_offset bigint,to_ip bigint,branch_type integer,in_tx boolean,call_path_id bigint,insn_count bigint,cyc_count bigint);
  sqlite>

Cool, the 'insn_count' and 'cyc_count' are there, now lets see if we can
use them in a query:

  sqlite> select insn_count,cyc_count from samples where cyc_count > 1500 and insn_count < 10;
  6|1507
  sqlite> select insn_count,cyc_count from samples where cyc_count > 1500;
  118|2210
  140|1516
  3783|1861
  132|1521
  6|1507
  sqlite>

Seems to work :-)

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-17-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

