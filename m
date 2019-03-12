Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1C4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4962214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552356225;
	bh=1S7Pf+owCcufgvKv8v2Deec9ybykNc5eKXr06fdrKys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0FHg461o3g5ORj9WKxkgRtaqumEUf/J0cg0HvqBLuIb4LcGAntMISW+TV02rQtu/n
	 +MFWj4+eCe9So9Fn/cVi9UWlRt6LUf5+g7IMzr4qEi/BEh7gA35jlr2NPkqPwaHiUu
	 veB22N3oD3Fwvp0yavO7mSfkvz7rxUL456UF3IvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfCLCDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:03:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbfCLCDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:03:41 -0400
Received: from quaco.meukeo.local (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F03B21773;
        Tue, 12 Mar 2019 02:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552356220;
        bh=1S7Pf+owCcufgvKv8v2Deec9ybykNc5eKXr06fdrKys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NYWkdj1UjqmufWy8Ig6XiMaK1K8jgDjFCiVn3/D3cQwVywKPk2Tx756eKZWUYVADt
         eFWGb2QjrPEv/hhFyK0PvZG5jMujujoQDhYEjn+ID1F3244l+kIoE4csG/GxEtjGWZ
         7PKxSGarZ/7Ycmnj4fpsoBjzcIL2UZpxldua/DDo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 22/30] perf script: Filter COMM/FORK/.. events by CPU
Date:   Mon, 11 Mar 2019 23:01:56 -0300
Message-Id: <20190312020204.22092-23-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The --cpu option only filtered samples. Filter other perf events, such
as COMM, FORK, SWITCH by the CPU too.

Reported-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190311144502.15423-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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

