Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3012C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927332084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfCKOqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:46:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:49543 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727480AbfCKOpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:45:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP; 11 Mar 2019 07:45:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="139825119"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Mar 2019 07:45:10 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 06B04300237; Mon, 11 Mar 2019 07:45:10 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v6 01/11] perf tools script: Filter COMM/FORK/.. events by CPU
Date:   Mon, 11 Mar 2019 07:44:52 -0700
Message-Id: <20190311144502.15423-2-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311144502.15423-1-andi@firstfloor.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
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
v3: Move checking to function
---
 tools/perf/builtin-script.c | 71 ++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 111787e83784..b695b20ffc8a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1933,6 +1933,13 @@ static int cleanup_scripting(void)
 	return scripting_ops ? scripting_ops->stop_script() : 0;
 }
 
+static bool filter_cpu(struct perf_sample *sample)
+{
+	if (cpu_list)
+		return !test_bit(sample->cpu, cpu_bitmap);
+	return false;
+}
+
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
@@ -1967,7 +1974,7 @@ static int process_sample_event(struct perf_tool *tool,
 	if (al.filtered)
 		goto out_put;
 
-	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
+	if (filter_cpu(sample))
 		goto out_put;
 
 	if (scripting_ops)
@@ -2052,9 +2059,11 @@ static int process_comm_event(struct perf_tool *tool,
 		sample->tid = event->comm.tid;
 		sample->pid = event->comm.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel,
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
 				   PERF_RECORD_COMM, stdout);
-	perf_event__fprintf(event, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	ret = 0;
 out:
 	thread__put(thread);
@@ -2088,9 +2097,11 @@ static int process_namespaces_event(struct perf_tool *tool,
 		sample->tid = event->namespaces.tid;
 		sample->pid = event->namespaces.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_NAMESPACES, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_NAMESPACES, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	ret = 0;
 out:
 	thread__put(thread);
@@ -2122,9 +2133,11 @@ static int process_fork_event(struct perf_tool *tool,
 		sample->tid = event->fork.tid;
 		sample->pid = event->fork.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_FORK, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_FORK, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	thread__put(thread);
 
 	return 0;
@@ -2152,9 +2165,11 @@ static int process_exit_event(struct perf_tool *tool,
 		sample->tid = event->fork.tid;
 		sample->pid = event->fork.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_EXIT, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_EXIT, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 
 	if (perf_event__process_exit(tool, event, sample, machine) < 0)
 		err = -1;
@@ -2188,9 +2203,11 @@ static int process_mmap_event(struct perf_tool *tool,
 		sample->tid = event->mmap.tid;
 		sample->pid = event->mmap.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_MMAP, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_MMAP, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	thread__put(thread);
 	return 0;
 }
@@ -2220,9 +2237,11 @@ static int process_mmap2_event(struct perf_tool *tool,
 		sample->tid = event->mmap2.tid;
 		sample->pid = event->mmap2.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_MMAP2, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_MMAP2, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	thread__put(thread);
 	return 0;
 }
@@ -2247,9 +2266,11 @@ static int process_switch_event(struct perf_tool *tool,
 		return -1;
 	}
 
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_SWITCH, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_SWITCH, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	thread__put(thread);
 	return 0;
 }
@@ -2270,9 +2291,11 @@ process_lost_event(struct perf_tool *tool,
 	if (thread == NULL)
 		return -1;
 
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_LOST, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_LOST, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	thread__put(thread);
 	return 0;
 }
-- 
2.20.1

