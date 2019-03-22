Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C893AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9800721900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfCVWMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:12:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52213 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfCVWMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:12:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMCRSL748870
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:12:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMCQ6K748865;
        Fri, 22 Mar 2019 15:12:26 -0700
Date:   Fri, 22 Mar 2019 15:12:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-e87e548126cdc66fd4f194b38b59f351b6e5d3e8@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, acme@redhat.com, jolsa@kernel.org,
        ak@linux.intel.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
          ak@linux.intel.com, linux-kernel@vger.kernel.org,
          acme@redhat.com, hpa@zytor.com
In-Reply-To: <20190311144502.15423-2-andi@firstfloor.org>
References: <20190311144502.15423-2-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Filter COMM/FORK/.. events by CPU
Git-Commit-ID: e87e548126cdc66fd4f194b38b59f351b6e5d3e8
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

Commit-ID:  e87e548126cdc66fd4f194b38b59f351b6e5d3e8
Gitweb:     https://git.kernel.org/tip/e87e548126cdc66fd4f194b38b59f351b6e5d3e8
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Mon, 11 Mar 2019 07:44:52 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 16:13:05 -0300

perf script: Filter COMM/FORK/.. events by CPU

The --cpu option only filtered samples. Filter other perf events, such
as COMM, FORK, SWITCH by the CPU too.

Reported-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190311144502.15423-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 71 ++++++++++++++++++++++++++++++---------------
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
