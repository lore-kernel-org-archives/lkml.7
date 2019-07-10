Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F53C004EF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A2620693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfGJI7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:59:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:35469 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbfGJI7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:59:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 01:59:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="186102544"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2019 01:59:37 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/21] perf scripts python: export-to-postgresql.py: Export comm details
Date:   Wed, 10 Jul 2019 11:57:59 +0300
Message-Id: <20190710085810.1650-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710085810.1650-1-adrian.hunter@intel.com>
References: <20190710085810.1650-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add table columns for thread id, comm start time and exec flag.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 92713d93e956..01f37877f5bb 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -353,7 +353,10 @@ do_query(query, 'CREATE TABLE threads ('
 		'tid		integer)')
 do_query(query, 'CREATE TABLE comms ('
 		'id		bigint		NOT NULL,'
-		'comm		varchar(16))')
+		'comm		varchar(16),'
+		'c_thread_id	bigint,'
+		'c_time		bigint,'
+		'exec_flag	boolean)')
 do_query(query, 'CREATE TABLE comm_threads ('
 		'id		bigint		NOT NULL,'
 		'comm_id	bigint,'
@@ -763,7 +766,7 @@ def trace_begin():
 	evsel_table(0, "unknown")
 	machine_table(0, 0, "unknown")
 	thread_table(0, 0, 0, -1, -1)
-	comm_table(0, "unknown")
+	comm_table(0, "unknown", 0, 0, 0)
 	dso_table(0, 0, "unknown", "unknown", "")
 	symbol_table(0, 0, 0, 0, 0, "unknown")
 	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
@@ -851,6 +854,8 @@ def trace_end():
 	do_query(query, 'ALTER TABLE threads '
 					'ADD CONSTRAINT machinefk  FOREIGN KEY (machine_id)   REFERENCES machines   (id),'
 					'ADD CONSTRAINT processfk  FOREIGN KEY (process_id)   REFERENCES threads    (id)')
+	do_query(query, 'ALTER TABLE comms '
+					'ADD CONSTRAINT threadfk   FOREIGN KEY (c_thread_id)  REFERENCES threads    (id)')
 	do_query(query, 'ALTER TABLE comm_threads '
 					'ADD CONSTRAINT commfk     FOREIGN KEY (comm_id)      REFERENCES comms      (id),'
 					'ADD CONSTRAINT threadfk   FOREIGN KEY (thread_id)    REFERENCES threads    (id)')
@@ -935,11 +940,11 @@ def thread_table(thread_id, machine_id, process_id, pid, tid, *x):
 	value = struct.pack("!hiqiqiqiiii", 5, 8, thread_id, 8, machine_id, 8, process_id, 4, pid, 4, tid)
 	thread_file.write(value)
 
-def comm_table(comm_id, comm_str, *x):
+def comm_table(comm_id, comm_str, thread_id, time, exec_flag, *x):
 	comm_str = toserverstr(comm_str)
 	n = len(comm_str)
-	fmt = "!hiqi" + str(n) + "s"
-	value = struct.pack(fmt, 2, 8, comm_id, n, comm_str)
+	fmt = "!hiqi" + str(n) + "s" + "iqiqiB"
+	value = struct.pack(fmt, 5, 8, comm_id, n, comm_str, 8, thread_id, 8, time, 1, exec_flag)
 	comm_file.write(value)
 
 def comm_thread_table(comm_thread_id, comm_id, thread_id, *x):
-- 
2.17.1

