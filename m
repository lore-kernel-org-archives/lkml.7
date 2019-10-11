Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C53EC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B41A214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824447;
	bh=zFzGVO23neSbXNobRbkj17p9AKHVNKVOY1lEVNXePPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jt/dzVg4l3i1IsLiW5WBttqk68f44vI7euquiZqYz76jZFiaLqF9H4yimO5xbKXno
	 BUer6O42zAYtAy3nv+vnh/FS5MR/eKIPbRUyOh47ZD7Ds+4gnpFp4ce399jj9ez7NB
	 zX8rOT3Q+rCV3cE2OGgZ996guLmAjH6wK0OE6jrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfJKUH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729255AbfJKUHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:07:25 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6149B2190F;
        Fri, 11 Oct 2019 20:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824444;
        bh=zFzGVO23neSbXNobRbkj17p9AKHVNKVOY1lEVNXePPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=swvYXPSRyR7K2HT9CIjf+deCdnuh1XikOXewep4jCqdjL+QogI3BTZBEaKe/bjJdM
         jeiRDWuGaA9huDqlrzEdaVLhDn8bQiER+wh3MrtzqADB4qLC4AiF06VhzxSIXLt9is
         rrJ5CxujI6ecYvdI1sEZo91tMKn12SRT6XNIdhM0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/69] perf scripts python: exported-sql-viewer.py: Add global time range calculations
Date:   Fri, 11 Oct 2019 17:05:01 -0300
Message-Id: <20191011200559.7156-12-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add calculations to determine a time range that encompasses all data.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20190821083216.1340-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.21.0

