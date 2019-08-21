Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFC6C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C8A22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfHUIdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 04:33:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:34007 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbfHUIdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:33:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 01:33:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="195953478"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2019 01:33:33 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] perf scripts python: exported-sql-viewer.py: Add global time range calculations
Date:   Wed, 21 Aug 2019 11:32:13 +0300
Message-Id: <20190821083216.1340-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821083216.1340-1-adrian.hunter@intel.com>
References: <20190821083216.1340-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add calculations to determine a time range that encompasses all data.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/exported-sql-viewer.py     | 113 +++++++++++++++++-
 1 file changed, 109 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 9767a5f802e5..0dcc9a03b1b0 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -2088,10 +2088,8 @@ class SampleTimeRangesDataItem(LineEditDataItem):
 		QueryExec(query, "SELECT id, time FROM samples ORDER BY id DESC LIMIT 1")
 		if query.next():
 			self.last_id = int(query.value(0))
-			self.last_time = int(query.value(1))
-		QueryExec(query, "SELECT time FROM samples WHERE time != 0 ORDER BY id LIMIT 1")
-		if query.next():
-			self.first_time = int(query.value(0))
+		self.first_time = int(glb.HostStartTime())
+		self.last_time = int(glb.HostFinishTime())
 		if placeholder_text:
 			placeholder_text += ", between " + str(self.first_time) + " and " + str(self.last_time)
 
@@ -3500,6 +3498,9 @@ class Glb():
 			self.have_disassembler = True
 		except:
 			self.have_disassembler = False
+		self.host_machine_id = 0
+		self.host_start_time = 0
+		self.host_finish_time = 0
 
 	def FileFromBuildId(self, build_id):
 		file_name = self.buildid_dir + build_id[0:2] + "/" + build_id[2:] + "/elf"
@@ -3532,6 +3533,110 @@ class Glb():
 			except:
 				pass
 
+	def GetHostMachineId(self):
+		query = QSqlQuery(self.db)
+		QueryExec(query, "SELECT id FROM machines WHERE pid = -1")
+		if query.next():
+			self.host_machine_id = query.value(0)
+		else:
+			self.host_machine_id = 0
+		return self.host_machine_id
+
+	def HostMachineId(self):
+		if self.host_machine_id:
+			return self.host_machine_id
+		return self.GetHostMachineId()
+
+	def SelectValue(self, sql):
+		query = QSqlQuery(self.db)
+		try:
+			QueryExec(query, sql)
+		except:
+			return None
+		if query.next():
+			return Decimal(query.value(0))
+		return None
+
+	def SwitchesMinTime(self, machine_id):
+		return self.SelectValue("SELECT time"
+					" FROM context_switches"
+					" WHERE time != 0 AND machine_id = " + str(machine_id) +
+					" ORDER BY id LIMIT 1")
+
+	def SwitchesMaxTime(self, machine_id):
+		return self.SelectValue("SELECT time"
+					" FROM context_switches"
+					" WHERE time != 0 AND machine_id = " + str(machine_id) +
+					" ORDER BY id DESC LIMIT 1")
+
+	def SamplesMinTime(self, machine_id):
+		return self.SelectValue("SELECT time"
+					" FROM samples"
+					" WHERE time != 0 AND machine_id = " + str(machine_id) +
+					" ORDER BY id LIMIT 1")
+
+	def SamplesMaxTime(self, machine_id):
+		return self.SelectValue("SELECT time"
+					" FROM samples"
+					" WHERE time != 0 AND machine_id = " + str(machine_id) +
+					" ORDER BY id DESC LIMIT 1")
+
+	def CallsMinTime(self, machine_id):
+		return self.SelectValue("SELECT calls.call_time"
+					" FROM calls"
+					" INNER JOIN threads ON threads.thread_id = calls.thread_id"
+					" WHERE calls.call_time != 0 AND threads.machine_id = " + str(machine_id) +
+					" ORDER BY calls.id LIMIT 1")
+
+	def CallsMaxTime(self, machine_id):
+		return self.SelectValue("SELECT calls.return_time"
+					" FROM calls"
+					" INNER JOIN threads ON threads.thread_id = calls.thread_id"
+					" WHERE calls.return_time != 0 AND threads.machine_id = " + str(machine_id) +
+					" ORDER BY calls.return_time DESC LIMIT 1")
+
+	def GetStartTime(self, machine_id):
+		t0 = self.SwitchesMinTime(machine_id)
+		t1 = self.SamplesMinTime(machine_id)
+		t2 = self.CallsMinTime(machine_id)
+		if t0 is None or (not(t1 is None) and t1 < t0):
+			t0 = t1
+		if t0 is None or (not(t2 is None) and t2 < t0):
+			t0 = t2
+		return t0
+
+	def GetFinishTime(self, machine_id):
+		t0 = self.SwitchesMaxTime(machine_id)
+		t1 = self.SamplesMaxTime(machine_id)
+		t2 = self.CallsMaxTime(machine_id)
+		if t0 is None or (not(t1 is None) and t1 > t0):
+			t0 = t1
+		if t0 is None or (not(t2 is None) and t2 > t0):
+			t0 = t2
+		return t0
+
+	def HostStartTime(self):
+		if self.host_start_time:
+			return self.host_start_time
+		self.host_start_time = self.GetStartTime(self.HostMachineId())
+		return self.host_start_time
+
+	def HostFinishTime(self):
+		if self.host_finish_time:
+			return self.host_finish_time
+		self.host_finish_time = self.GetFinishTime(self.HostMachineId())
+		return self.host_finish_time
+
+	def StartTime(self, machine_id):
+		if machine_id == self.HostMachineId():
+			return self.HostStartTime()
+		return self.GetStartTime(machine_id)
+
+	def FinishTime(self, machine_id):
+		if machine_id == self.HostMachineId():
+			return self.HostFinishTime()
+		return self.GetFinishTime(machine_id)
+
 # Database reference
 
 class DBRef():
-- 
2.17.1

