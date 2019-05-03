Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C5EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7FA2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfECMKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 08:10:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:1063 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727840AbfECMKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 08:10:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 05:10:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="343043128"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 03 May 2019 05:10:01 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] perf scripts python: exported-sql-viewer.py: Add 'About' dialog box
Date:   Fri,  3 May 2019 15:08:28 +0300
Message-Id: <20190503120828.25326-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503120828.25326-1-adrian.hunter@intel.com>
References: <20190503120828.25326-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With support for Python 2 or 3 and PySide 1 or 2 (Qt 4 or 5), it is useful
to see what versions are in use. Add an 'About' dialog box that displays
Python, PySide, Qt and database server (SQLite or PostgreSQL) version
numbers.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/exported-sql-viewer.py     | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 421f3828ea43..6fe553258ce5 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -2927,6 +2927,60 @@ class HelpOnlyWindow(QMainWindow):
 
 		self.setCentralWidget(self.text)
 
+# PostqreSQL server version
+
+def PostqreSQLServerVersion(db):
+	query = QSqlQuery(db)
+	QueryExec(query, "SELECT VERSION()")
+	if query.next():
+		v_str = query.value(0)
+		v_list = v_str.strip().split(" ")
+		if v_list[0] == "PostgreSQL" and v_list[2] == "on":
+			return v_list[1]
+		return v_str
+	return "Unknown"
+
+# SQLite version
+
+def SQLiteVersion(db):
+	query = QSqlQuery(db)
+	QueryExec(query, "SELECT sqlite_version()")
+	if query.next():
+		return query.value(0)
+	return "Unknown"
+
+# About dialog
+
+class AboutDialog(QDialog):
+
+	def __init__(self, glb, parent=None):
+		super(AboutDialog, self).__init__(parent)
+
+		self.setWindowTitle("About Exported SQL Viewer")
+		self.setMinimumWidth(300)
+
+		pyside_version = "1" if pyside_version_1 else "2"
+
+		text = "<pre>"
+		text += "Python version:     " + sys.version.split(" ")[0] + "\n"
+		text += "PySide version:     " + pyside_version + "\n"
+		text += "Qt version:         " + qVersion() + "\n"
+		if glb.dbref.is_sqlite3:
+			text += "SQLite version:     " + SQLiteVersion(glb.db) + "\n"
+		else:
+			text += "PostqreSQL version: " + PostqreSQLServerVersion(glb.db) + "\n"
+		text += "</pre>"
+
+		self.text = QTextBrowser()
+		self.text.setHtml(text)
+		self.text.setReadOnly(True)
+		self.text.setOpenExternalLinks(True)
+
+		self.vbox = QVBoxLayout()
+		self.vbox.addWidget(self.text)
+
+		self.setLayout(self.vbox);
+
 # Font resize
 
 def ResizeFont(widget, diff):
@@ -3024,6 +3078,7 @@ class MainWindow(QMainWindow):
 
 		help_menu = menu.addMenu("&Help")
 		help_menu.addAction(CreateAction("&Exported SQL Viewer Help", "Helpful information", self.Help, self, QKeySequence.HelpContents))
+		help_menu.addAction(CreateAction("&About Exported SQL Viewer", "About this application", self.About, self))
 
 	def Try(self, fn):
 		win = self.mdi_area.activeSubWindow()
@@ -3109,6 +3164,10 @@ class MainWindow(QMainWindow):
 	def Help(self):
 		HelpWindow(self.glb, self)
 
+	def About(self):
+		dialog = AboutDialog(self.glb, self)
+		dialog.exec_()
+
 # XED Disassembler
 
 class xed_state_t(Structure):
-- 
2.17.1

