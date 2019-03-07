Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41506C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B86C20661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980749;
	bh=2WqXGTKru1BBuIhRD6D+tn/6ReEhhnKQUJ3b9t9U43o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xX3el2a2l4yK9z2V5qLjmaPDVJzqmxGjyUaK9awXbXj4l8doy1347XQDjNdxhPnWy
	 Oonjv1y5PF0YOydTSGr8kETcO4AqzpEbRxRrnVw5yR5Jnga8OalCSSNekFIgyLXVmY
	 iu45ndcLSbNLMUEs4XcXX0c/8KtHLrgPnHcUowZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfCGRpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:45:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfCGRpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:45:45 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06C302087C;
        Thu,  7 Mar 2019 17:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980745;
        bh=2WqXGTKru1BBuIhRD6D+tn/6ReEhhnKQUJ3b9t9U43o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1TDeYEQfpCd9gWFS/krKKv+d1KjEU0eZnhhA/2JZmZQPcJZMtRa9NbgBNbF3vn+YV
         snTtSkuioK7HgSyImC099NhDvCeDFJybrKkOeW6GBDQ7ijjsjG25i64wW3EEhp3DYc
         qSvfwpPMuLVnk1cYO5X6OTDMl6/Ksg/NVTNp5N9I=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/35] perf scripts python: exported-sql-viewer.py: Factor out CallGraphModelBase
Date:   Thu,  7 Mar 2019 14:44:12 -0300
Message-Id: <20190307174433.28819-15-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Factor out a base class CallGraphModelBase from CallGraphModel, so that
CallGraphModelBase can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: https://lkml.kernel.org/n/tip-76eybebzjwvgnadkm2oufrqi@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 100 ++++++++++--------
 1 file changed, 55 insertions(+), 45 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index b2a22525549d..c4a2134d85f5 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -558,26 +558,12 @@ class CallGraphRootItem(CallGraphLevelItemBase):
 			self.child_items.append(child_item)
 			self.child_count += 1
 
-# Context-sensitive call graph data model
+# Context-sensitive call graph data model base
 
-class CallGraphModel(TreeModel):
+class CallGraphModelBase(TreeModel):
 
 	def __init__(self, glb, parent=None):
-		super(CallGraphModel, self).__init__(glb, parent)
-
-	def GetRoot(self):
-		return CallGraphRootItem(self.glb)
-
-	def columnCount(self, parent=None):
-		return 7
-
-	def columnHeader(self, column):
-		headers = ["Call Path", "Object", "Count ", "Time (ns) ", "Time (%) ", "Branch Count ", "Branch Count (%) "]
-		return headers[column]
-
-	def columnAlignment(self, column):
-		alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
-		return alignment[column]
+		super(CallGraphModelBase, self).__init__(glb, parent)
 
 	def FindSelect(self, value, pattern, query):
 		if pattern:
@@ -597,34 +583,7 @@ class CallGraphModel(TreeModel):
 				match = " GLOB '" + str(value) + "'"
 		else:
 			match = " = '" + str(value) + "'"
-		QueryExec(query, "SELECT call_path_id, comm_id, thread_id"
-						" FROM calls"
-						" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
-						" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
-						" WHERE symbols.name" + match +
-						" GROUP BY comm_id, thread_id, call_path_id"
-						" ORDER BY comm_id, thread_id, call_path_id")
-
-	def FindPath(self, query):
-		# Turn the query result into a list of ids that the tree view can walk
-		# to open the tree at the right place.
-		ids = []
-		parent_id = query.value(0)
-		while parent_id:
-			ids.insert(0, parent_id)
-			q2 = QSqlQuery(self.glb.db)
-			QueryExec(q2, "SELECT parent_id"
-					" FROM call_paths"
-					" WHERE id = " + str(parent_id))
-			if not q2.next():
-				break
-			parent_id = q2.value(0)
-		# The call path root is not used
-		if ids[0] == 1:
-			del ids[0]
-		ids.insert(0, query.value(2))
-		ids.insert(0, query.value(1))
-		return ids
+		self.DoFindSelect(query, match)
 
 	def Found(self, query, found):
 		if found:
@@ -678,6 +637,57 @@ class CallGraphModel(TreeModel):
 	def FindDone(self, thread, callback, ids):
 		callback(ids)
 
+# Context-sensitive call graph data model
+
+class CallGraphModel(CallGraphModelBase):
+
+	def __init__(self, glb, parent=None):
+		super(CallGraphModel, self).__init__(glb, parent)
+
+	def GetRoot(self):
+		return CallGraphRootItem(self.glb)
+
+	def columnCount(self, parent=None):
+		return 7
+
+	def columnHeader(self, column):
+		headers = ["Call Path", "Object", "Count ", "Time (ns) ", "Time (%) ", "Branch Count ", "Branch Count (%) "]
+		return headers[column]
+
+	def columnAlignment(self, column):
+		alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
+		return alignment[column]
+
+	def DoFindSelect(self, query, match):
+		QueryExec(query, "SELECT call_path_id, comm_id, thread_id"
+						" FROM calls"
+						" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
+						" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
+						" WHERE symbols.name" + match +
+						" GROUP BY comm_id, thread_id, call_path_id"
+						" ORDER BY comm_id, thread_id, call_path_id")
+
+	def FindPath(self, query):
+		# Turn the query result into a list of ids that the tree view can walk
+		# to open the tree at the right place.
+		ids = []
+		parent_id = query.value(0)
+		while parent_id:
+			ids.insert(0, parent_id)
+			q2 = QSqlQuery(self.glb.db)
+			QueryExec(q2, "SELECT parent_id"
+					" FROM call_paths"
+					" WHERE id = " + str(parent_id))
+			if not q2.next():
+				break
+			parent_id = q2.value(0)
+		# The call path root is not used
+		if ids[0] == 1:
+			del ids[0]
+		ids.insert(0, query.value(2))
+		ids.insert(0, query.value(1))
+		return ids
+
 # Vertical widget layout
 
 class VBox():
-- 
2.20.1

