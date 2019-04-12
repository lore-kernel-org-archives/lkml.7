Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB768C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21FA206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfDLLkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:40:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:12704 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbfDLLju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:39:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 04:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,341,1549958400"; 
   d="scan'208";a="336687241"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2019 04:39:49 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] perf scripts python: exported-sql-viewer.py: Use argparse module for argument parsing
Date:   Fri, 12 Apr 2019 14:38:24 +0300
Message-Id: <20190412113830.4126-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412113830.4126-1-adrian.hunter@intel.com>
References: <20190412113830.4126-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

argparse makes it easier to add new arguments.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/exported-sql-viewer.py     | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index a3f1d05c9d4b..0fb0acc94058 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -91,6 +91,7 @@
 from __future__ import print_function
 
 import sys
+import argparse
 import weakref
 import threading
 import string
@@ -3035,18 +3036,26 @@ class DBRef():
 # Main
 
 def Main():
-	if (len(sys.argv) < 2):
-		printerr("Usage is: exported-sql-viewer.py {<database name> | --help-only}");
-		raise Exception("Too few arguments")
-
-	dbname = sys.argv[1]
-	if dbname == "--help-only":
+	usage_str =	"exported-sql-viewer.py [--pyside-version-1] <database name>\n" \
+			"   or: exported-sql-viewer.py --help-only"
+	ap = argparse.ArgumentParser(usage = usage_str, add_help = False)
+	ap.add_argument("dbname", nargs="?")
+	ap.add_argument("--help-only", action='store_true')
+	args = ap.parse_args()
+
+	if args.help_only:
 		app = QApplication(sys.argv)
 		mainwindow = HelpOnlyWindow()
 		mainwindow.show()
 		err = app.exec_()
 		sys.exit(err)
 
+	dbname = args.dbname
+	if dbname is None:
+		ap.print_usage()
+		print("Too few arguments")
+		sys.exit(1)
+
 	is_sqlite3 = False
 	try:
 		f = open(dbname, "rb")
-- 
2.17.1

