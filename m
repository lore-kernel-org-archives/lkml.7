Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F55DC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D332184B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279638;
	bh=aY8GUASc/oObyohkVWHCuz80ViEkpUoo3Ul0PwXBp7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ByPOLFOp+xDd8b6cjijh8aMiNJ4lr9tPmMbHNKxDrGKfSeampRvgILFI4GRAN+fCe
	 guiiJ5LZc3yrQDL9Sy/IovN/vwy+SXNDioKPo9HXrqesgrJB9jVcNC2zZfq16vLS60
	 t7Wj2+xHiIjZf1k3dHTvw5oOPV7lgEwbAUj6vTYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436484AbfFKTAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405274AbfFKTAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:00:36 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C3D721871;
        Tue, 11 Jun 2019 19:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279635;
        bh=aY8GUASc/oObyohkVWHCuz80ViEkpUoo3Ul0PwXBp7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRex885G6b4aVL2xx5z2CoRxWcDyCJIqfbZoL4exgP3kSZq6S6kYtGIr2a1Qh6huy
         x50/RpbjGhRRAtHVcCP300uzsKBvO5zyioxXq9NZm5SKp/niIonZPvch9gcuF1r0FU
         G8y344bkvXphEqmCbR6JgMvNq4u00OIcX+1qFplI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 21/85] perf scripts python: exported-sql-viewer.py: Add IPC information to the Branch reports
Date:   Tue, 11 Jun 2019 15:58:07 -0300
Message-Id: <20190611185911.11645-22-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Enhance the "All branches" and "Selected branches" reports to display IPC
information if it is available.

Committer testing:

So, testing this I noticed that it all starts with the left arrow in every
line, that should mean there is some tree there, i.e. look at all those ▶
symbols:

Reports -> All Branches:

Time              CPU Command         PID   TID   Branch Type  In Tx  Insn Cnt  Cyc Cnt  IPC  Branch
▶ 187836112195670 7   simple-retpolin 23003 23003 trace begin  No     0         0        0               0 unknown (unknown) -> 7f6f33d4f110
+_start (ld-2.28.so)
▶ 187836112195987 7   simple-retpolin 23003 23003 trace end    No     0         883      0    7f6f33d4f110 _start (ld-2.28.so) -> 0 unknown
+(unknown)
▶ 187836112199189 7   simple-retpolin 23003 23003 trace begin  No     0         0        0               0 unknown (unknown) -> 7f6f33d4f110
+_start (ld-2.28.so)
▶ 187836112199189 7   simple-retpolin 23003 23003 call         No     0         0        0    7f6f33d4f113 _start+0x3 (ld-2.28.so) -> 7f6f33d4ff50
+_dl_start (ld-2.28.so)
▶ 187836112199544 7   simple-retpolin 23003 23003 trace end    No     17        996      0.02 7f6f33d4ff73 _dl_start+0x23 (ld-2.28.so) -> 0
+unknown (unknown)
▶ 187836112200939 7   simple-retpolin 23003 23003 trace begin  No     0         0        0               0 unknown (unknown) -> 7f6f33d4ff73
+_dl_start+0x23 (ld-2.28.so)
▶ 187836112201229 7   simple-retpolin 23003 23003 trace end    No     1         816      0.00 7f6f33d4ff7a _dl_start+0x2a (ld-2.28.so) -> 0
+unknown (unknown)
▶ 187836112203500 7   simple-retpolin 23003 23003 trace begin  No     0         0        0               0 unknown (unknown) -> 7f6f33d4ff7a
+_dl_start+0x2a (ld-2.28.so)

But if you click on it, that ▶ disappears and a new click doesn't make
it reappear, looks buggy, minor oddity, reported to Adrian.

Reports -> Selected Branches, then ask for branches in the ld-2.28.so
DSO:

Time               CPU  Command          PID    TID    Branch Type        In Tx  Insn Cnt  Cyc Cnt  IPC   Branch
▶ 187836112195987  7    simple-retpolin  23003  23003  trace end          No     0         883      0     7f6f33d4f110 _start (ld-2.28.so) -> 0 unknown (unknown)
▶ 187836112199189  7    simple-retpolin  23003  23003  trace begin        No     0         0        0                0 unknown (unknown) -> 7f6f33d4f110 _start (ld-2.28.so)
▶ 187836112199189  7    simple-retpolin  23003  23003  call               No     0         0        0     7f6f33d4f113 _start+0x3 (ld-2.28.so) -> 7f6f33d4ff50 _dl_start (ld-2.28.so)
▶ 187836112199544  7    simple-retpolin  23003  23003  trace end          No     17        996      0.02  7f6f33d4ff73 _dl_start+0x23 (ld-2.28.so) -> 0 unknown (unknown)
▶ 187836112200939  7    simple-retpolin  23003  23003  trace begin        No     0         0        0                0 unknown (unknown) -> 7f6f33d4ff73 _dl_start+0x23 (ld-2.28.so)
▶ 187836112201229  7    simple-retpolin  23003  23003  trace end          No     1         816      0.00  7f6f33d4ff7a _dl_start+0x2a (ld-2.28.so) -> 0 unknown (unknown)
▶ 187836112203500  7    simple-retpolin  23003  23003  trace begin        No     0         0        0                0 unknown (unknown) -> 7f6f33d4ff7a _dl_start+0x2a (ld-2.28.so)
▶ 187836112203528  7    simple-retpolin  23003  23003  unconditional jump No     0         0        0     7f6f33d4ffe7 _dl_start+0x97 (ld-2.28.so) -> 7f6f33d5000b _dl_start+0xbb (ld-2.28.so)
▶ 187836112203528  7    simple-retpolin  23003  23003  conditional jump   No     0         0        0     7f6f33d5000f _dl_start+0xbf (ld-2.28.so) -> 7f6f33d4fffb _dl_start+0xab (ld-2.28.so)
▶ 187836112203528  7    simple-retpolin  23003  23003  conditional jump   No     0         0        0     7f6f33d5000f _dl_start+0xbf (ld-2.28.so) -> 7f6f33d4fffb _dl_start+0xab (ld-2.28.so)
▶ 187836112203539  7    simple-retpolin  23003  23003  conditional jump   No     0         0        0     7f6f33d50025 _dl_start+0xd5 (ld-2.28.so) -> 7f6f33d50210 _dl_start+0x2c0 (ld-2.28.so)
▶ 187836112203539  7    simple-retpolin  23003  23003  conditional jump   No     0         0        0     7f6f33d5021a _dl_start+0x2ca (ld-2.28.so) -> 7f6f33d50360 _dl_start+0x410 (ld-2.28.so)
▶ 187836112203539  7    simple-retpolin  23003  23003  unconditional jump No     0         0        0     7f6f33d50377 _dl_start+0x427 (ld-2.28.so) -> 7f6f33d4ffff _dl_start+0xaf (ld-2.28.so)
▶ 187836112203539  7    simple-retpolin  23003  23003  conditional jump   No     0         0        0     7f6f33d5000f _dl_start+0xbf (ld-2.28.so) -> 7f6f33d4fffb _dl_start+0xab (ld-2.28.so)
▶ 187836112203562  7    simple-retpolin  23003  23003  conditional jump   No     0         0        0     7f6f33d5000f _dl_start+0xbf (ld-2.28.so) -> 7f6f33d4fffb _dl_start+0xab (ld-2.28.so)

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-19-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 102 ++++++++++++++----
 1 file changed, 83 insertions(+), 19 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 6fe553258ce5..a607235c8cd9 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1369,11 +1369,11 @@ class FetchMoreRecordsBar():
 
 class BranchLevelTwoItem():
 
-	def __init__(self, row, text, parent_item):
+	def __init__(self, row, col, text, parent_item):
 		self.row = row
 		self.parent_item = parent_item
-		self.data = [""] * 8
-		self.data[7] = text
+		self.data = [""] * (col + 1)
+		self.data[col] = text
 		self.level = 2
 
 	def getParentItem(self):
@@ -1405,6 +1405,7 @@ class BranchLevelOneItem():
 		self.dbid = data[0]
 		self.level = 1
 		self.query_done = False
+		self.br_col = len(self.data) - 1
 
 	def getChildItem(self, row):
 		return self.child_items[row]
@@ -1485,7 +1486,7 @@ class BranchLevelOneItem():
 				while k < 15:
 					byte_str += "   "
 					k += 1
-				self.child_items.append(BranchLevelTwoItem(0, byte_str + " " + text, self))
+				self.child_items.append(BranchLevelTwoItem(0, self.br_col, byte_str + " " + text, self))
 				self.child_count += 1
 			else:
 				return
@@ -1536,16 +1537,37 @@ class BranchRootItem():
 	def getData(self, column):
 		return ""
 
+# Calculate instructions per cycle
+
+def CalcIPC(cyc_cnt, insn_cnt):
+	if cyc_cnt and insn_cnt:
+		ipc = Decimal(float(insn_cnt) / cyc_cnt)
+		ipc = str(ipc.quantize(Decimal(".01"), rounding=ROUND_HALF_UP))
+	else:
+		ipc = "0"
+	return ipc
+
 # Branch data preparation
 
-def BranchDataPrep(query):
-	data = []
-	for i in xrange(0, 8):
-		data.append(query.value(i))
+def BranchDataPrepBr(query, data):
 	data.append(tohex(query.value(8)).rjust(16) + " " + query.value(9) + offstr(query.value(10)) +
 			" (" + dsoname(query.value(11)) + ")" + " -> " +
 			tohex(query.value(12)) + " " + query.value(13) + offstr(query.value(14)) +
 			" (" + dsoname(query.value(15)) + ")")
+
+def BranchDataPrepIPC(query, data):
+	insn_cnt = query.value(16)
+	cyc_cnt = query.value(17)
+	ipc = CalcIPC(cyc_cnt, insn_cnt)
+	data.append(insn_cnt)
+	data.append(cyc_cnt)
+	data.append(ipc)
+
+def BranchDataPrep(query):
+	data = []
+	for i in xrange(0, 8):
+		data.append(query.value(i))
+	BranchDataPrepBr(query, data)
 	return data
 
 def BranchDataPrepWA(query):
@@ -1555,10 +1577,26 @@ def BranchDataPrepWA(query):
 	data.append("{:>19}".format(query.value(1)))
 	for i in xrange(2, 8):
 		data.append(query.value(i))
-	data.append(tohex(query.value(8)).rjust(16) + " " + query.value(9) + offstr(query.value(10)) +
-			" (" + dsoname(query.value(11)) + ")" + " -> " +
-			tohex(query.value(12)) + " " + query.value(13) + offstr(query.value(14)) +
-			" (" + dsoname(query.value(15)) + ")")
+	BranchDataPrepBr(query, data)
+	return data
+
+def BranchDataWithIPCPrep(query):
+	data = []
+	for i in xrange(0, 8):
+		data.append(query.value(i))
+	BranchDataPrepIPC(query, data)
+	BranchDataPrepBr(query, data)
+	return data
+
+def BranchDataWithIPCPrepWA(query):
+	data = []
+	data.append(query.value(0))
+	# Workaround pyside failing to handle large integers (i.e. time) in python3 by converting to a string
+	data.append("{:>19}".format(query.value(1)))
+	for i in xrange(2, 8):
+		data.append(query.value(i))
+	BranchDataPrepIPC(query, data)
+	BranchDataPrepBr(query, data)
 	return data
 
 # Branch data model
@@ -1572,10 +1610,20 @@ class BranchModel(TreeModel):
 		self.event_id = event_id
 		self.more = True
 		self.populated = 0
+		self.have_ipc = IsSelectable(glb.db, "samples", columns = "insn_count, cyc_count")
+		if self.have_ipc:
+			select_ipc = ", insn_count, cyc_count"
+			prep_fn = BranchDataWithIPCPrep
+			prep_wa_fn = BranchDataWithIPCPrepWA
+		else:
+			select_ipc = ""
+			prep_fn = BranchDataPrep
+			prep_wa_fn = BranchDataPrepWA
 		sql = ("SELECT samples.id, time, cpu, comm, pid, tid, branch_types.name,"
 			" CASE WHEN in_tx = '0' THEN 'No' ELSE 'Yes' END,"
 			" ip, symbols.name, sym_offset, dsos.short_name,"
 			" to_ip, to_symbols.name, to_sym_offset, to_dsos.short_name"
+			+ select_ipc +
 			" FROM samples"
 			" INNER JOIN comms ON comm_id = comms.id"
 			" INNER JOIN threads ON thread_id = threads.id"
@@ -1589,9 +1637,9 @@ class BranchModel(TreeModel):
 			" ORDER BY samples.id"
 			" LIMIT " + str(glb_chunk_sz))
 		if pyside_version_1 and sys.version_info[0] == 3:
-			prep = BranchDataPrepWA
+			prep = prep_fn
 		else:
-			prep = BranchDataPrep
+			prep = prep_wa_fn
 		self.fetcher = SQLFetcher(glb, sql, prep, self.AddSample)
 		self.fetcher.done.connect(self.Update)
 		self.fetcher.Fetch(glb_chunk_sz)
@@ -1600,13 +1648,23 @@ class BranchModel(TreeModel):
 		return BranchRootItem()
 
 	def columnCount(self, parent=None):
-		return 8
+		if self.have_ipc:
+			return 11
+		else:
+			return 8
 
 	def columnHeader(self, column):
-		return ("Time", "CPU", "Command", "PID", "TID", "Branch Type", "In Tx", "Branch")[column]
+		if self.have_ipc:
+			return ("Time", "CPU", "Command", "PID", "TID", "Branch Type", "In Tx", "Insn Cnt", "Cyc Cnt", "IPC", "Branch")[column]
+		else:
+			return ("Time", "CPU", "Command", "PID", "TID", "Branch Type", "In Tx", "Branch")[column]
 
 	def columnFont(self, column):
-		if column != 7:
+		if self.have_ipc:
+			br_col = 10
+		else:
+			br_col = 7
+		if column != br_col:
 			return None
 		return QFont("Monospace")
 
@@ -2114,10 +2172,10 @@ def GetEventList(db):
 
 # Is a table selectable
 
-def IsSelectable(db, table, sql = ""):
+def IsSelectable(db, table, sql = "", columns = "*"):
 	query = QSqlQuery(db)
 	try:
-		QueryExec(query, "SELECT * FROM " + table + " " + sql + " LIMIT 1")
+		QueryExec(query, "SELECT " + columns + " FROM " + table + " " + sql + " LIMIT 1")
 	except:
 		return False
 	return True
@@ -2854,6 +2912,12 @@ cd xed
 sudo ./mfile.py --prefix=/usr/local install
 sudo ldconfig
 </pre>
+<h3>Instructions per Cycle (IPC)</h3>
+If available, IPC information is displayed in columns 'insn_cnt', 'cyc_cnt' and 'IPC'.
+<p><b>Intel PT note:</b> The information applies to the blocks of code ending with, and including, that branch.
+Due to the granularity of timing information, the number of cycles for some code blocks will not be known.
+In that case, 'insn_cnt', 'cyc_cnt' and 'IPC' are zero, but when 'IPC' is displayed it covers the period
+since the previous displayed 'IPC'.
 <h3>Find</h3>
 Ctrl-F displays a Find bar which finds substrings by either an exact match or a regular expression match.
 Refer to Python documentation for the regular expression syntax.
-- 
2.20.1

