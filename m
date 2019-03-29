Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D195DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FFD218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfC2UmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:42:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52545 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbfC2UmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:42:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2TKfwPA3938563
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 13:41:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2TKfvtE3938560;
        Fri, 29 Mar 2019 13:41:57 -0700
Date:   Fri, 29 Mar 2019 13:41:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-8453c936db20489dbf0957187dca9a2656a2a7b6@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, adrian.hunter@intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        mingo@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, adrian.hunter@intel.com,
          jolsa@redhat.com, linux-kernel@vger.kernel.org, acme@redhat.com,
          mingo@kernel.org
In-Reply-To: <20190327072826.19168-2-adrian.hunter@intel.com>
References: <20190327072826.19168-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: exported-sql-viewer.py: Fix
 never-ending loop
Git-Commit-ID: 8453c936db20489dbf0957187dca9a2656a2a7b6
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

Commit-ID:  8453c936db20489dbf0957187dca9a2656a2a7b6
Gitweb:     https://git.kernel.org/tip/8453c936db20489dbf0957187dca9a2656a2a7b6
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 27 Mar 2019 09:28:25 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 28 Mar 2019 14:41:21 -0300

perf scripts python: exported-sql-viewer.py: Fix never-ending loop

pyside version 1 fails to handle python3 large integers in some cases,
resulting in Qt getting into a never-ending loop. This affects:
	samples Table
	samples_view Table
	All branches Report
	Selected branches Report

Add workarounds for those cases.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Fixes: beda0e725e5f ("perf script python: Add Python3 support to exported-sql-viewer.py")
Link: http://lkml.kernel.org/r/20190327072826.19168-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 60 ++++++++++++++++++++----
 1 file changed, 50 insertions(+), 10 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index e38518cdcbc3..0cf30956064a 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -107,6 +107,7 @@ import os
 from PySide.QtCore import *
 from PySide.QtGui import *
 from PySide.QtSql import *
+pyside_version_1 = True
 from decimal import *
 from ctypes import *
 from multiprocessing import Process, Array, Value, Event
@@ -1526,6 +1527,19 @@ def BranchDataPrep(query):
 			" (" + dsoname(query.value(15)) + ")")
 	return data
 
+def BranchDataPrepWA(query):
+	data = []
+	data.append(query.value(0))
+	# Workaround pyside failing to handle large integers (i.e. time) in python3 by converting to a string
+	data.append("{:>19}".format(query.value(1)))
+	for i in xrange(2, 8):
+		data.append(query.value(i))
+	data.append(tohex(query.value(8)).rjust(16) + " " + query.value(9) + offstr(query.value(10)) +
+			" (" + dsoname(query.value(11)) + ")" + " -> " +
+			tohex(query.value(12)) + " " + query.value(13) + offstr(query.value(14)) +
+			" (" + dsoname(query.value(15)) + ")")
+	return data
+
 # Branch data model
 
 class BranchModel(TreeModel):
@@ -1553,7 +1567,11 @@ class BranchModel(TreeModel):
 			" AND evsel_id = " + str(self.event_id) +
 			" ORDER BY samples.id"
 			" LIMIT " + str(glb_chunk_sz))
-		self.fetcher = SQLFetcher(glb, sql, BranchDataPrep, self.AddSample)
+		if pyside_version_1 and sys.version_info[0] == 3:
+			prep = BranchDataPrepWA
+		else:
+			prep = BranchDataPrep
+		self.fetcher = SQLFetcher(glb, sql, prep, self.AddSample)
 		self.fetcher.done.connect(self.Update)
 		self.fetcher.Fetch(glb_chunk_sz)
 
@@ -2079,14 +2097,6 @@ def IsSelectable(db, table, sql = ""):
 		return False
 	return True
 
-# SQL data preparation
-
-def SQLTableDataPrep(query, count):
-	data = []
-	for i in xrange(count):
-		data.append(query.value(i))
-	return data
-
 # SQL table data model item
 
 class SQLTableItem():
@@ -2110,7 +2120,7 @@ class SQLTableModel(TableModel):
 		self.more = True
 		self.populated = 0
 		self.column_headers = column_headers
-		self.fetcher = SQLFetcher(glb, sql, lambda x, y=len(column_headers): SQLTableDataPrep(x, y), self.AddSample)
+		self.fetcher = SQLFetcher(glb, sql, lambda x, y=len(column_headers): self.SQLTableDataPrep(x, y), self.AddSample)
 		self.fetcher.done.connect(self.Update)
 		self.fetcher.Fetch(glb_chunk_sz)
 
@@ -2154,6 +2164,12 @@ class SQLTableModel(TableModel):
 	def columnHeader(self, column):
 		return self.column_headers[column]
 
+	def SQLTableDataPrep(self, query, count):
+		data = []
+		for i in xrange(count):
+			data.append(query.value(i))
+		return data
+
 # SQL automatic table data model
 
 class SQLAutoTableModel(SQLTableModel):
@@ -2182,8 +2198,32 @@ class SQLAutoTableModel(SQLTableModel):
 			QueryExec(query, "SELECT column_name FROM information_schema.columns WHERE table_schema = '" + schema + "' and table_name = '" + select_table_name + "'")
 			while query.next():
 				column_headers.append(query.value(0))
+		if pyside_version_1 and sys.version_info[0] == 3:
+			if table_name == "samples_view":
+				self.SQLTableDataPrep = self.samples_view_DataPrep
+			if table_name == "samples":
+				self.SQLTableDataPrep = self.samples_DataPrep
 		super(SQLAutoTableModel, self).__init__(glb, sql, column_headers, parent)
 
+	def samples_view_DataPrep(self, query, count):
+		data = []
+		data.append(query.value(0))
+		# Workaround pyside failing to handle large integers (i.e. time) in python3 by converting to a string
+		data.append("{:>19}".format(query.value(1)))
+		for i in xrange(2, count):
+			data.append(query.value(i))
+		return data
+
+	def samples_DataPrep(self, query, count):
+		data = []
+		for i in xrange(9):
+			data.append(query.value(i))
+		# Workaround pyside failing to handle large integers (i.e. time) in python3 by converting to a string
+		data.append("{:>19}".format(query.value(9)))
+		for i in xrange(10, count):
+			data.append(query.value(i))
+		return data
+
 # Base class for custom ResizeColumnsToContents
 
 class ResizeColumnsToContentsBase(QObject):
