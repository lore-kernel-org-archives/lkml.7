Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D009EC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 01:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F3F2075B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 01:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfCBBSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 20:18:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:47684 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727885AbfCBBSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 20:18:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05036ADE3;
        Sat,  2 Mar 2019 01:18:15 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v2 7/7] perf script python: add printdate function to SQL exporters
Date:   Fri,  1 Mar 2019 17:19:03 -0800
Message-Id: <20190302011903.2416-8-tonyj@suse.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190302011903.2416-1-tonyj@suse.de>
References: <20190302011903.2416-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a printdate function to eliminate the repetitive use of
datetime.datetime.today() in the SQL exporting scripts.

Signed-off-by: Tony Jones <tonyj@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 19 +++++++++++--------
 tools/perf/scripts/python/export-to-sqlite.py     | 13 ++++++++-----
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 439bbbf1e036..515dc5506427 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -249,6 +249,9 @@ perf_db_export_callchains = False
 def printerr(*args, **kw_args):
 	print(*args, file=sys.stderr, **kw_args)
 
+def printdate(*args, **kw_args):
+        print(datetime.datetime.today(), *args, sep=' ', **kw_args)
+
 def usage():
 	printerr("Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>]")
 	printerr("where:	columns		'all' or 'branches'")
@@ -287,7 +290,7 @@ def do_query(q, s):
 		return
 	raise Exception("Query failed: " + q.lastError().text())
 
-print(datetime.datetime.today(), "Creating database...")
+printdate("Creating database...")
 
 db = QSqlDatabase.addDatabase('QPSQL')
 query = QSqlQuery(db)
@@ -580,7 +583,7 @@ if perf_db_export_calls:
 	call_file		= open_output_file("call_table.bin")
 
 def trace_begin():
-	print(datetime.datetime.today(), "Writing to intermediate files...")
+	printdate("Writing to intermediate files...")
 	# id == 0 means unknown.  It is easier to create records for them than replace the zeroes with NULLs
 	evsel_table(0, "unknown")
 	machine_table(0, 0, "unknown")
@@ -596,7 +599,7 @@ def trace_begin():
 unhandled_count = 0
 
 def trace_end():
-	print(datetime.datetime.today(), "Copying to database...")
+	printdate("Copying to database...")
 	copy_output_file(evsel_file,		"selected_events")
 	copy_output_file(machine_file,		"machines")
 	copy_output_file(thread_file,		"threads")
@@ -611,7 +614,7 @@ def trace_end():
 	if perf_db_export_calls:
 		copy_output_file(call_file,		"calls")
 
-	print(datetime.datetime.today(), "Removing intermediate files...")
+	printdate("Removing intermediate files...")
 	remove_output_file(evsel_file)
 	remove_output_file(machine_file)
 	remove_output_file(thread_file)
@@ -626,7 +629,7 @@ def trace_end():
 	if perf_db_export_calls:
 		remove_output_file(call_file)
 	os.rmdir(output_dir_name)
-	print(datetime.datetime.today(), "Adding primary keys")
+	printdate("Adding primary keys")
 	do_query(query, 'ALTER TABLE selected_events ADD PRIMARY KEY (id)')
 	do_query(query, 'ALTER TABLE machines        ADD PRIMARY KEY (id)')
 	do_query(query, 'ALTER TABLE threads         ADD PRIMARY KEY (id)')
@@ -641,7 +644,7 @@ def trace_end():
 	if perf_db_export_calls:
 		do_query(query, 'ALTER TABLE calls           ADD PRIMARY KEY (id)')
 
-	print(datetime.datetime.today(), "Adding foreign keys")
+	printdate("Adding foreign keys")
 	do_query(query, 'ALTER TABLE threads '
 					'ADD CONSTRAINT machinefk  FOREIGN KEY (machine_id)   REFERENCES machines   (id),'
 					'ADD CONSTRAINT processfk  FOREIGN KEY (process_id)   REFERENCES threads    (id)')
@@ -677,8 +680,8 @@ def trace_end():
 		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
 
 	if (unhandled_count):
-		print(datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events")
-	print(datetime.datetime.today(), "Done")
+		printdate("Warning: ", unhandled_count, " unhandled events")
+	printdate("Done")
 
 def trace_unhandled(event_name, context, event_fields_dict):
 	global unhandled_count
diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index 3da338243aed..3b71902a5a21 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -65,6 +65,9 @@ perf_db_export_callchains = False
 def printerr(*args, **keyword_args):
 	print(*args, file=sys.stderr, **keyword_args)
 
+def printdate(*args, **kw_args):
+        print(datetime.datetime.today(), *args, sep=' ', **kw_args)
+
 def usage():
 	printerr("Usage is: export-to-sqlite.py <database name> [<columns>] [<calls>] [<callchains>]");
 	printerr("where:	columns		'all' or 'branches'");
@@ -105,7 +108,7 @@ def do_query_(q):
 		return
 	raise Exception("Query failed: " + q.lastError().text())
 
-print(datetime.datetime.today(), "Creating database ...")
+printdate("Creating database ...")
 
 db_exists = False
 try:
@@ -383,7 +386,7 @@ if perf_db_export_calls:
 	call_query.prepare("INSERT INTO calls VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
 
 def trace_begin():
-	print(datetime.datetime.today(), "Writing records...")
+	printdate("Writing records...")
 	do_query(query, 'BEGIN TRANSACTION')
 	# id == 0 means unknown.  It is easier to create records for them than replace the zeroes with NULLs
 	evsel_table(0, "unknown")
@@ -402,14 +405,14 @@ unhandled_count = 0
 def trace_end():
 	do_query(query, 'END TRANSACTION')
 
-	print(datetime.datetime.today(), "Adding indexes")
+	printdate("Adding indexes")
 	if perf_db_export_calls:
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
 		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
 
 	if (unhandled_count):
-		print(datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events")
-	print(datetime.datetime.today(), "Done")
+		printdate("Warning: ", unhandled_count, " unhandled events")
+	printdate("Done")
 
 def trace_unhandled(event_name, context, event_fields_dict):
 	global unhandled_count
-- 
2.16.4

