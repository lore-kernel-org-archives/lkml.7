Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931A9C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B66520652
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfCIT4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:56:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45191 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfCIT4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:56:05 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29JtacV3202367
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 11:55:36 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29JtZrM3202348;
        Sat, 9 Mar 2019 11:55:35 -0800
Date:   Sat, 9 Mar 2019 11:55:35 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-76eybebzjwvgnadkm2oufrqi@git.kernel.org>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, jolsa@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, acme@redhat.com,
          adrian.hunter@intel.com, jolsa@redhat.com, tglx@linutronix.de,
          mingo@kernel.org, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: exported-sql-viewer.py:
 Factor out CallGraphModelBase
Git-Commit-ID: 254c0d820b86d7712e03750c58ab104e06e3655d
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

Commit-ID:  254c0d820b86d7712e03750c58ab104e06e3655d
Gitweb:     https://git.kernel.org/tip/254c0d820b86d7712e03750c58ab104e06e3655d
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 28 Feb 2019 15:00:30 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 1 Mar 2019 14:56:17 -0300

perf scripts python: exported-sql-viewer.py: Factor out CallGraphModelBase

Factor out a base class CallGraphModelBase from CallGraphModel, so that
CallGraphModelBase can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: https://lkml.kernel.org/n/tip-76eybebzjwvgnadkm2oufrqi@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 100 +++++++++++++----------
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
