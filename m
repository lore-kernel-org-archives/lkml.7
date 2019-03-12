Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030BDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85D921773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552356280;
	bh=zP5HaEbyAi1/tHnsCx3bjeFJxS9yrQa45Kk4pAHlbNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RTOdqOgBmoIo2//ISHxiI9osrP+c2NyXmcoD3Sw5mmbA2vR0zlbHgEJ/bT9D8VUrl
	 lQRgBVMVuMmMO6oeybI240UEripAxWwzwJqwgtQ53g0wJEFaVYele5RjAQLZSgPyac
	 VCysQ5ezejPHdnJfmwyylt1gsruHlf97H1yzCQxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfCLCD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfCLCDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:03:24 -0400
Received: from quaco.meukeo.local (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E49214AF;
        Tue, 12 Mar 2019 02:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552356203;
        bh=zP5HaEbyAi1/tHnsCx3bjeFJxS9yrQa45Kk4pAHlbNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mINZXMO+4rOOdhz7k7LPKfxuEJCFkcsxiDsus3+AIEpFWSyVFhE3Izq2Q3CftbRTO
         iyucmsXCNIuMyBZHA3HRrYy9K4OsIWUAJ9x0zj4MOdy7TFi8hDR0KEpSTbd3sq0kNA
         byPRJ/xrwKJABDsUSiw36WWdvH28uPcfI8l/ZTXc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/30] perf script python: Add Python3 support to export-to-sqlite.py
Date:   Mon, 11 Mar 2019 23:01:51 -0300
Message-Id: <20190312020204.22092-18-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Jones <tonyj@suse.de>

Support both Python2 and Python3 in the export-to-sqlite.py script

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/r/20190309000518.2438-4-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-sqlite.py | 23 +++++++++++--------
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
2.20.1

