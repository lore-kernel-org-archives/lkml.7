Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C13C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF23206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfDLLjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:39:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:12704 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfDLLjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:39:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 04:39:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,341,1549958400"; 
   d="scan'208";a="336687244"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2019 04:39:50 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] perf scripts python: exported-sql-viewer.py: Add support for pyside2
Date:   Fri, 12 Apr 2019 14:38:25 +0300
Message-Id: <20190412113830.4126-4-adrian.hunter@intel.com>
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
 .../scripts/python/exported-sql-viewer.py     | 28 ++++++++++++++-----
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 0fb0acc94058..c586abfb2b46 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -105,10 +105,23 @@ except ImportError:
 	glb_nsz = 16
 import re
 import os
-from PySide.QtCore import *
-from PySide.QtGui import *
-from PySide.QtSql import *
+
 pyside_version_1 = True
+if not "--pyside-version-1" in sys.argv:
+	try:
+		from PySide2.QtCore import *
+		from PySide2.QtGui import *
+		from PySide2.QtSql import *
+		from PySide2.QtWidgets import *
+		pyside_version_1 = False
+	except:
+		pass
+
+if pyside_version_1:
+	from PySide.QtCore import *
+	from PySide.QtGui import *
+	from PySide.QtSql import *
+
 from decimal import *
 from ctypes import *
 from multiprocessing import Process, Array, Value, Event
@@ -2502,7 +2515,7 @@ class WindowMenu():
 			action = self.window_menu.addAction(label)
 			action.setCheckable(True)
 			action.setChecked(sub_window == self.mdi_area.activeSubWindow())
-			action.triggered.connect(lambda x=nr: self.setActiveSubWindow(x))
+			action.triggered.connect(lambda a=None,x=nr: self.setActiveSubWindow(x))
 			self.window_menu.addAction(action)
 			nr += 1
 
@@ -2793,14 +2806,14 @@ class MainWindow(QMainWindow):
 			event = event.split(":")[0]
 			if event == "branches":
 				label = "All branches" if branches_events == 1 else "All branches " + "(id=" + dbid + ")"
-				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda x=dbid: self.NewBranchView(x), self))
+				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda a=None,x=dbid: self.NewBranchView(x), self))
 				label = "Selected branches" if branches_events == 1 else "Selected branches " + "(id=" + dbid + ")"
-				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda x=dbid: self.NewSelectedBranchView(x), self))
+				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda a=None,x=dbid: self.NewSelectedBranchView(x), self))
 
 	def TableMenu(self, tables, menu):
 		table_menu = menu.addMenu("&Tables")
 		for table in tables:
-			table_menu.addAction(CreateAction(table, "Create a new window containing a table view", lambda t=table: self.NewTableView(t), self))
+			table_menu.addAction(CreateAction(table, "Create a new window containing a table view", lambda a=None,t=table: self.NewTableView(t), self))
 
 	def NewCallGraph(self):
 		CallGraphWindow(self.glb, self)
@@ -3039,6 +3052,7 @@ def Main():
 	usage_str =	"exported-sql-viewer.py [--pyside-version-1] <database name>\n" \
 			"   or: exported-sql-viewer.py --help-only"
 	ap = argparse.ArgumentParser(usage = usage_str, add_help = False)
+	ap.add_argument("--pyside-version-1", action='store_true')
 	ap.add_argument("dbname", nargs="?")
 	ap.add_argument("--help-only", action='store_true')
 	args = ap.parse_args()
-- 
2.17.1

