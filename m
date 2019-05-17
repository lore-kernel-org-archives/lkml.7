Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5435C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9786A21734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558121863;
	bh=CQKQBVZd9Y43DsHW6SzTWNenEyLftgynO8NkzWVGPWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tKOFcTatpMxU/lKSpcX3AOotECabL0gt0TmB8LtA1oSYv8ZlhgXypg8hb2N0wpmi1
	 BO/tP0+u9ujVRWT0tZKodIZoMo5TlnTMa0aOmcEJSoMU7qzgAfOhF/K+6Eai+Vo7p/
	 rXHdpm1Aey9UkCEA/XjMZ2hwurIy3rL1X7rAkbfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfEQThm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:37:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729211AbfEQThk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:37:40 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ECFE2166E;
        Fri, 17 May 2019 19:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121859;
        bh=CQKQBVZd9Y43DsHW6SzTWNenEyLftgynO8NkzWVGPWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hrzz81+8esmXkvpllNG+NZnV4tudq/Nm31Y8EqGO3BWv3n3vwzxji+QMsedkg8ye4
         owzWbAA8h0GYFqgfE996QEOGcW9+fJAuY+QnuHmDLTo3guBhjl7EE0MwoG6AS6506k
         j265c0UBYjXPJio6FjzNKaXh/miUGFkU7GNnTeqo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 18/73] perf scripts python: exported-sql-viewer.py: Add 'About' dialog box
Date:   Fri, 17 May 2019 16:35:16 -0300
Message-Id: <20190517193611.4974-19-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

With support for Python 2 or 3 and PySide 1 or 2 (Qt 4 or 5), it is
useful to see what versions are in use. Add an 'About' dialog box that
displays Python, PySide, Qt and database server (SQLite or PostgreSQL)
version numbers.

Committer testing:

  $ python ~acme/libexec/perf-core/scripts/python/exported-sql-viewer.py ~/c/adrian.hunter/simple-retpoline.db

  Then go to 'Help', then 'About', select all the lines with the mouse
  press 'Control+C', then, on the same terminal press control+shift+V
  which shows my current environment:

Python version:     2.7.16
PySide version:     1
Qt version:         4.8.7
SQLite version:     3.26.0

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190503120828.25326-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index affd80ebcae0..affed7d149be 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -2913,6 +2913,60 @@ class HelpOnlyWindow(QMainWindow):
 
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
@@ -3010,6 +3064,7 @@ class MainWindow(QMainWindow):
 
 		help_menu = menu.addMenu("&Help")
 		help_menu.addAction(CreateAction("&Exported SQL Viewer Help", "Helpful information", self.Help, self, QKeySequence.HelpContents))
+		help_menu.addAction(CreateAction("&About Exported SQL Viewer", "About this application", self.About, self))
 
 	def Try(self, fn):
 		win = self.mdi_area.activeSubWindow()
@@ -3095,6 +3150,10 @@ class MainWindow(QMainWindow):
 	def Help(self):
 		HelpWindow(self.glb, self)
 
+	def About(self):
+		dialog = AboutDialog(self.glb, self)
+		dialog.exec_()
+
 # XED Disassembler
 
 class xed_state_t(Structure):
-- 
2.20.1

