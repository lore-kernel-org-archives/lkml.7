Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAA2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 07:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79CC2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 07:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbfC0H3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 03:29:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:5823 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfC0H3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 03:29:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 00:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,276,1549958400"; 
   d="scan'208";a="144234332"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2019 00:29:45 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf scripts python: exported-sql-viewer.py: Fix never-ending loop
Date:   Wed, 27 Mar 2019 09:28:25 +0200
Message-Id: <20190327072826.19168-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190327072826.19168-1-adrian.hunter@intel.com>
References: <20190327072826.19168-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pyside version 1 fails to handle python3 large integers in some cases,
resulting in Qt getting into a never-ending loop. This affects:
	samples Table
	samples_view Table
	All branches Report
	Selected branches Report

Add workarounds for those cases.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: beda0e725e5f ("perf script python: Add Python3 support to exported-sql-viewer.py")
---
 .../scripts/python/exported-sql-viewer.py     | 60 +++++++++++++++----
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
-- 
2.17.1

