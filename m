Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3A8ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F62A2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfJOFcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:32:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42213 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbfJOFcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:18 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRL-0000T7-1f; Tue, 15 Oct 2019 07:32:11 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5FF561C06D7;
        Tue, 15 Oct 2019 07:31:50 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:50 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf scripts python: exported-sql-viewer.py: Add
 global time range calculations
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821083216.1340-4-adrian.hunter@intel.com>
References: <20190821083216.1340-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157111751027.12254.11432163643947253055.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9a9dae36556e8f7689f68f05d169ac6c132c5f15
Gitweb:        https://git.kernel.org/tip/9a9dae36556e8f7689f68f05d169ac6c132c5f15
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 21 Aug 2019 11:32:13 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 07 Oct 2019 12:22:17 -03:00

perf scripts python: exported-sql-viewer.py: Add global time range calculations

Add calculations to determine a time range that encompasses all data.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20190821083216.1340-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 113 +++++++++++++-
 1 file changed, 109 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 9767a5f..0dcc9a0 100755
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
