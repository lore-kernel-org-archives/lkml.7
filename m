Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6372C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 00:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6A2204FD
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 00:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfCIAEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 19:04:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:56166 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbfCIAEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 19:04:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6DA6CAC61;
        Sat,  9 Mar 2019 00:04:04 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        Tony Jones <tonyj@suse.de>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v3 3/4] perf script python: add Python3 support to export-to-sqlite.py
Date:   Fri,  8 Mar 2019 16:05:17 -0800
Message-Id: <20190309000518.2438-4-tonyj@suse.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190309000518.2438-1-tonyj@suse.de>
References: <20190309000518.2438-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python2 and Python3 in the export-to-sqlite.py script

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
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
-- 
2.16.4

