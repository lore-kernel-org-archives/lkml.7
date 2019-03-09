Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDCCC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C42207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfCIF5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 00:57:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:50712 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfCIF4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 00:56:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 21:56:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,458,1544515200"; 
   d="scan'208";a="326979449"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga005.fm.intel.com with ESMTP; 08 Mar 2019 21:56:41 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 83459301CE4; Fri,  8 Mar 2019 21:56:41 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v5 03/15] perf tools script: Filter COMM/FORK/.. events by CPU
Date:   Fri,  8 Mar 2019 21:56:16 -0800
Message-Id: <20190309055628.21617-4-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190309055628.21617-1-andi@firstfloor.org>
References: <20190309055628.21617-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The --cpu option only filtered samples. Filter other perf events,
such as COMM, FORK, SWITCH by the CPU too.

Reported-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andi Kleen <ak@linux.intel.com>

---
v2: Only filter printf output
---
 tools/perf/builtin-script.c | 62 +++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index fbc440bdf880..f6b5b19b3307 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2053,9 +2053,11 @@ static int process_comm_event(struct perf_tool *tool,
 		sample->tid = event->comm.tid;
 		sample->pid = event->comm.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel,
+	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
 				   PERF_RECORD_COMM, stdout);
-	perf_event__fprintf(event, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	ret = 0;
 out:
 	thread__put(thread);
@@ -2089,9 +2091,11 @@ static int process_namespaces_event(struct perf_tool *tool,
 		sample->tid = event->namespaces.tid;
 		sample->pid = event->namespaces.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_NAMESPACES, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_NAMESPACES, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	ret = 0;
 out:
 	thread__put(thread);
@@ -2123,9 +2127,11 @@ static int process_fork_event(struct perf_tool *tool,
 		sample->tid = event->fork.tid;
 		sample->pid = event->fork.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_FORK, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_FORK, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	thread__put(thread);
 
 	return 0;
@@ -2153,9 +2159,11 @@ static int process_exit_event(struct perf_tool *tool,
 		sample->tid = event->fork.tid;
 		sample->pid = event->fork.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_EXIT, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_EXIT, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 
 	if (perf_event__process_exit(tool, event, sample, machine) < 0)
 		err = -1;
@@ -2189,9 +2197,11 @@ static int process_mmap_event(struct perf_tool *tool,
 		sample->tid = event->mmap.tid;
 		sample->pid = event->mmap.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_MMAP, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_MMAP, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	thread__put(thread);
 	return 0;
 }
@@ -2221,9 +2231,11 @@ static int process_mmap2_event(struct perf_tool *tool,
 		sample->tid = event->mmap2.tid;
 		sample->pid = event->mmap2.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_MMAP2, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_MMAP2, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	thread__put(thread);
 	return 0;
 }
@@ -2248,9 +2260,11 @@ static int process_switch_event(struct perf_tool *tool,
 		return -1;
 	}
 
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_SWITCH, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_SWITCH, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	thread__put(thread);
 	return 0;
 }
@@ -2271,9 +2285,11 @@ process_lost_event(struct perf_tool *tool,
 	if (thread == NULL)
 		return -1;
 
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_LOST, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_LOST, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	thread__put(thread);
 	return 0;
 }
-- 
2.20.1

