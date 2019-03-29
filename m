Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACD8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA74218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553866734;
	bh=UhmJPMkFjyovv2I6MnaFQyIuIEUz4C99GXKx91aKJwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qgb6yeUNlTM1/N44i1LMINjVzkA833Te+3WRwsJs9Ft5ndbB3g4niRcX+PrVgxsqT
	 yNMPnnh/fj93fOzIuuH4+xefBuO/iOJ5OAXWZhWKEblw7t+NpOKPij5hHcJuC4opP6
	 +DgH5pTyt6BltkWjzwlj22xFhayP1+afDCnhZzvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfC2Nix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729859AbfC2Niv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:38:51 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA4A4217F5;
        Fri, 29 Mar 2019 13:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553866730;
        bh=UhmJPMkFjyovv2I6MnaFQyIuIEUz4C99GXKx91aKJwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gG/KqEu1FfUMGc3WGUZJRiya2ql5Hu++ahkrlOKxVYMgDgVuJEujt7bzXi1QpVlIr
         vpfccnv1h9TDboPkDeli/7mA0+zihdR8VE3rOAdooXeMAPeMPXd8CigG9+tZmEh+Ft
         vyx2UYK/2Sb4Gaq+Jc8OI7P97qvk3iG4zY44PvfU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/13] perf scripts python: exported-sql-viewer.py: Fix never-ending loop
Date:   Fri, 29 Mar 2019 10:37:59 -0300
Message-Id: <20190329133801.21004-12-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329133801.21004-1-acme@kernel.org>
References: <20190329133801.21004-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
2.20.1

