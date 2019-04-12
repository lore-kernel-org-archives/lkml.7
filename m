Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9409CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F482171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfDLLj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:39:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:12704 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727338AbfDLLjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:39:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 04:39:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,341,1549958400"; 
   d="scan'208";a="336687247"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2019 04:39:52 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] perf scripts python: export-to-sqlite.py: Add support for pyside2
Date:   Fri, 12 Apr 2019 14:38:26 +0300
Message-Id: <20190412113830.4126-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412113830.4126-1-adrian.hunter@intel.com>
References: <20190412113830.4126-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pyside2 is the future for pyside support.

Note pyside use Qt4 whereas pyside2 uses Qt5.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/scripts/python/export-to-sqlite.py | 44 ++++++++++++++++---
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index bf271fbc3a88..f617e518332f 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -21,6 +21,26 @@ import datetime
 # provides LGPL-licensed Python bindings for Qt.  You will also need the package
 # libqt4-sql-sqlite for Qt sqlite3 support.
 #
+# Examples of installing pyside:
+#
+# ubuntu:
+#
+#	$ sudo apt-get install python-pyside.qtsql libqt4-sql-psql
+#
+#	Alternately, to use Python3 and/or pyside 2, one of the following:
+#
+#		$ sudo apt-get install python3-pyside.qtsql libqt4-sql-psql
+#		$ sudo apt-get install python-pyside2.qtsql libqt5sql5-psql
+#		$ sudo apt-get install python3-pyside2.qtsql libqt5sql5-psql
+# fedora:
+#
+#	$ sudo yum install python-pyside
+#
+#	Alternately, to use Python3 and/or pyside 2, one of the following:
+#		$ sudo yum install python3-pyside
+#		$ pip install --user PySide2
+#		$ pip3 install --user PySide2
+#
 # An example of using this script with Intel PT:
 #
 #	$ perf record -e intel_pt//u ls
@@ -49,7 +69,16 @@ import datetime
 # difference is  the 'transaction' column of the 'samples' table which is
 # renamed 'transaction_' in sqlite because 'transaction' is a reserved word.
 
-from PySide.QtSql import *
+pyside_version_1 = True
+if not "pyside-version-1" in sys.argv:
+	try:
+		from PySide2.QtSql import *
+		pyside_version_1 = False
+	except:
+		pass
+
+if pyside_version_1:
+	from PySide.QtSql import *
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
@@ -69,11 +98,12 @@ def printdate(*args, **kw_args):
         print(datetime.datetime.today(), *args, sep=' ', **kw_args)
 
 def usage():
-	printerr("Usage is: export-to-sqlite.py <database name> [<columns>] [<calls>] [<callchains>]");
-	printerr("where:	columns		'all' or 'branches'");
-	printerr("		calls		'calls' => create calls and call_paths table");
-	printerr("		callchains	'callchains' => create call_paths table");
-	raise Exception("Too few arguments")
+	printerr("Usage is: export-to-sqlite.py <database name> [<columns>] [<calls>] [<callchains>] [<pyside-version-1>]");
+	printerr("where:  columns            'all' or 'branches'");
+	printerr("        calls              'calls' => create calls and call_paths table");
+	printerr("        callchains         'callchains' => create call_paths table");
+	printerr("        pyside-version-1   'pyside-version-1' => use pyside version 1");
+	raise Exception("Too few or bad arguments")
 
 if (len(sys.argv) < 2):
 	usage()
@@ -95,6 +125,8 @@ for i in range(3,len(sys.argv)):
 		perf_db_export_calls = True
 	elif (sys.argv[i] == "callchains"):
 		perf_db_export_callchains = True
+	elif (sys.argv[i] == "pyside-version-1"):
+		pass
 	else:
 		usage()
 
-- 
2.17.1

