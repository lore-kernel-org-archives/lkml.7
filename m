Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4EAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88042190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfCVWJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:09:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48681 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfCVWJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:09:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MM9Csj748249
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:09:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MM9BSp748246;
        Fri, 22 Mar 2019 15:09:11 -0700
Date:   Fri, 22 Mar 2019 15:09:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Jones <tipbot@zytor.com>
Message-ID: <tip-ebf6c5c181abe9309788c6241d39602a1ce18723@git.kernel.org>
Cc:     tonyj@suse.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        tglx@linutronix.de, s1seetee@linux.vnet.ibm.com,
        adrian.hunter@intel.com, hpa@zytor.com, acme@redhat.com
Reply-To: hpa@zytor.com, s1seetee@linux.vnet.ibm.com,
          adrian.hunter@intel.com, acme@redhat.com, tonyj@suse.de,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
In-Reply-To: <20190309000518.2438-4-tonyj@suse.de>
References: <20190309000518.2438-4-tonyj@suse.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script python: Add Python3 support to
 export-to-sqlite.py
Git-Commit-ID: ebf6c5c181abe9309788c6241d39602a1ce18723
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

Commit-ID:  ebf6c5c181abe9309788c6241d39602a1ce18723
Gitweb:     https://git.kernel.org/tip/ebf6c5c181abe9309788c6241d39602a1ce18723
Author:     Tony Jones <tonyj@suse.de>
AuthorDate: Fri, 8 Mar 2019 16:05:17 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 16:12:59 -0300

perf script python: Add Python3 support to export-to-sqlite.py

Support both Python2 and Python3 in the export-to-sqlite.py script

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/r/20190309000518.2438-4-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-sqlite.py | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index eb63e6c7107f..3da338243aed 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -10,6 +10,8 @@
 # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 # more details.
 
+from __future__ import print_function
+
 import os
 import sys
 import struct
@@ -60,11 +62,14 @@ perf_db_export_mode = True
 perf_db_export_calls = False
 perf_db_export_callchains = False
 
+def printerr(*args, **keyword_args):
+	print(*args, file=sys.stderr, **keyword_args)
+
 def usage():
-	print >> sys.stderr, "Usage is: export-to-sqlite.py <database name> [<columns>] [<calls>] [<callchains>]"
-	print >> sys.stderr, "where:	columns		'all' or 'branches'"
-	print >> sys.stderr, "		calls		'calls' => create calls and call_paths table"
-	print >> sys.stderr, "		callchains	'callchains' => create call_paths table"
+	printerr("Usage is: export-to-sqlite.py <database name> [<columns>] [<calls>] [<callchains>]");
+	printerr("where:	columns		'all' or 'branches'");
+	printerr("		calls		'calls' => create calls and call_paths table");
+	printerr("		callchains	'callchains' => create call_paths table");
 	raise Exception("Too few arguments")
 
 if (len(sys.argv) < 2):
@@ -100,7 +105,7 @@ def do_query_(q):
 		return
 	raise Exception("Query failed: " + q.lastError().text())
 
-print datetime.datetime.today(), "Creating database..."
+print(datetime.datetime.today(), "Creating database ...")
 
 db_exists = False
 try:
@@ -378,7 +383,7 @@ if perf_db_export_calls:
 	call_query.prepare("INSERT INTO calls VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
 
 def trace_begin():
-	print datetime.datetime.today(), "Writing records..."
+	print(datetime.datetime.today(), "Writing records...")
 	do_query(query, 'BEGIN TRANSACTION')
 	# id == 0 means unknown.  It is easier to create records for them than replace the zeroes with NULLs
 	evsel_table(0, "unknown")
@@ -397,14 +402,14 @@ unhandled_count = 0
 def trace_end():
 	do_query(query, 'END TRANSACTION')
 
-	print datetime.datetime.today(), "Adding indexes"
+	print(datetime.datetime.today(), "Adding indexes")
 	if perf_db_export_calls:
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
 		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
 
 	if (unhandled_count):
-		print datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events"
-	print datetime.datetime.today(), "Done"
+		print(datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events")
+	print(datetime.datetime.today(), "Done")
 
 def trace_unhandled(event_name, context, event_fields_dict):
 	global unhandled_count
