Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F5FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF6C21925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfCVWKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:10:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56229 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbfCVWKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:10:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MM9oCL748324
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:09:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MM9o1R748321;
        Fri, 22 Mar 2019 15:09:50 -0700
Date:   Fri, 22 Mar 2019 15:09:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Jones <tipbot@zytor.com>
Message-ID: <tip-49f93bbf17e6267eb34e0c12a9813f3a8723749e@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, adrian.hunter@intel.com,
        tonyj@suse.de
Reply-To: acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com, adrian.hunter@intel.com,
          tonyj@suse.de
In-Reply-To: <20190309000518.2438-5-tonyj@suse.de>
References: <20190309000518.2438-5-tonyj@suse.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script python: Add printdate function to SQL
 exporters
Git-Commit-ID: 49f93bbf17e6267eb34e0c12a9813f3a8723749e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  49f93bbf17e6267eb34e0c12a9813f3a8723749e
Gitweb:     https://git.kernel.org/tip/49f93bbf17e6267eb34e0c12a9813f3a8723749e
Author:     Tony Jones <tonyj@suse.de>
AuthorDate: Fri, 8 Mar 2019 16:05:18 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 16:13:02 -0300

perf script python: Add printdate function to SQL exporters

Introduce a printdate function to eliminate the repetitive use of
datetime.datetime.today() in the SQL exporting scripts.

Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/r/20190309000518.2438-5-tonyj@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 19 +++++++++++--------
 tools/perf/scripts/python/export-to-sqlite.py     | 13 ++++++++-----
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 00ab972a2eba..c3eae1d77d36 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -251,6 +251,9 @@ perf_db_export_callchains = False
 def printerr(*args, **kw_args):
 	print(*args, file=sys.stderr, **kw_args)
 
+def printdate(*args, **kw_args):
+        print(datetime.datetime.today(), *args, sep=' ', **kw_args)
+
 def usage():
 	printerr("Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>]")
 	printerr("where:	columns		'all' or 'branches'")
@@ -289,7 +292,7 @@ def do_query(q, s):
 		return
 	raise Exception("Query failed: " + q.lastError().text())
 
-print(datetime.datetime.today(), "Creating database...")
+printdate("Creating database...")
 
 db = QSqlDatabase.addDatabase('QPSQL')
 query = QSqlQuery(db)
@@ -582,7 +585,7 @@ if perf_db_export_calls:
 	call_file		= open_output_file("call_table.bin")
 
 def trace_begin():
-	print(datetime.datetime.today(), "Writing to intermediate files...")
+	printdate("Writing to intermediate files...")
 	# id == 0 means unknown.  It is easier to create records for them than replace the zeroes with NULLs
 	evsel_table(0, "unknown")
 	machine_table(0, 0, "unknown")
@@ -598,7 +601,7 @@ def trace_begin():
 unhandled_count = 0
 
 def trace_end():
-	print(datetime.datetime.today(), "Copying to database...")
+	printdate("Copying to database...")
 	copy_output_file(evsel_file,		"selected_events")
 	copy_output_file(machine_file,		"machines")
 	copy_output_file(thread_file,		"threads")
@@ -613,7 +616,7 @@ def trace_end():
 	if perf_db_export_calls:
 		copy_output_file(call_file,		"calls")
 
-	print(datetime.datetime.today(), "Removing intermediate files...")
+	printdate("Removing intermediate files...")
 	remove_output_file(evsel_file)
 	remove_output_file(machine_file)
 	remove_output_file(thread_file)
@@ -628,7 +631,7 @@ def trace_end():
 	if perf_db_export_calls:
 		remove_output_file(call_file)
 	os.rmdir(output_dir_name)
-	print(datetime.datetime.today(), "Adding primary keys")
+	printdate("Adding primary keys")
 	do_query(query, 'ALTER TABLE selected_events ADD PRIMARY KEY (id)')
 	do_query(query, 'ALTER TABLE machines        ADD PRIMARY KEY (id)')
 	do_query(query, 'ALTER TABLE threads         ADD PRIMARY KEY (id)')
@@ -643,7 +646,7 @@ def trace_end():
 	if perf_db_export_calls:
 		do_query(query, 'ALTER TABLE calls           ADD PRIMARY KEY (id)')
 
-	print(datetime.datetime.today(), "Adding foreign keys")
+	printdate("Adding foreign keys")
 	do_query(query, 'ALTER TABLE threads '
 					'ADD CONSTRAINT machinefk  FOREIGN KEY (machine_id)   REFERENCES machines   (id),'
 					'ADD CONSTRAINT processfk  FOREIGN KEY (process_id)   REFERENCES threads    (id)')
@@ -679,8 +682,8 @@ def trace_end():
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
