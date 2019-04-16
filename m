Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F39C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685D52077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfDPLdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:33:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46341 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfDPLdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:33:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GBX2Ht3427966
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 04:33:02 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GBX2pR3427953;
        Tue, 16 Apr 2019 04:33:02 -0700
Date:   Tue, 16 Apr 2019 04:33:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Stephane Eranian <tipbot@zytor.com>
Message-ID: <tip-c68d224e5ed15605e651e2482c6ffd95915ddf58@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        vincent.weaver@maine.edu, eranian@google.com, acme@redhat.com,
        hpa@zytor.com, mingo@kernel.org, torvalds@linux-foundation.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org
Reply-To: mingo@kernel.org, torvalds@linux-foundation.org,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          vincent.weaver@maine.edu, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, jolsa@redhat.com, acme@redhat.com,
          eranian@google.com, hpa@zytor.com
In-Reply-To: <20190408173252.37932-2-eranian@google.com>
References: <20190408173252.37932-2-eranian@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core: Add perf_pmu_resched() as global
 function
Git-Commit-ID: c68d224e5ed15605e651e2482c6ffd95915ddf58
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

Commit-ID:  c68d224e5ed15605e651e2482c6ffd95915ddf58
Gitweb:     https://git.kernel.org/tip/c68d224e5ed15605e651e2482c6ffd95915ddf58
Author:     Stephane Eranian <eranian@google.com>
AuthorDate: Mon, 8 Apr 2019 10:32:51 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 12:19:34 +0200

perf/core: Add perf_pmu_resched() as global function

This patch add perf_pmu_resched() a global function that can be called
to force rescheduling of events for a given PMU. The function locks
both cpuctx and task_ctx internally. This will be used by a subsequent
patch.

Signed-off-by: Stephane Eranian <eranian@google.com>
[ Simplified the calling convention. ]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: kan.liang@intel.com
Cc: nelson.dsouza@intel.com
Cc: tonyj@suse.com
Link: https://lkml.kernel.org/r/20190408173252.37932-2-eranian@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/perf_event.h |  3 +++
 kernel/events/core.c       | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 085a95e2582a..f3864e1c5569 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -888,6 +888,9 @@ extern void perf_sched_cb_dec(struct pmu *pmu);
 extern void perf_sched_cb_inc(struct pmu *pmu);
 extern int perf_event_task_disable(void);
 extern int perf_event_task_enable(void);
+
+extern void perf_pmu_resched(struct pmu *pmu);
+
 extern int perf_event_refresh(struct perf_event *event, int refresh);
 extern void perf_event_update_userpage(struct perf_event *event);
 extern int perf_event_release_kernel(struct perf_event *event);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 30a572e4c6f1..abbd4b3b96c2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2478,6 +2478,16 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	perf_pmu_enable(cpuctx->ctx.pmu);
 }
 
+void perf_pmu_resched(struct pmu *pmu)
+{
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
+	struct perf_event_context *task_ctx = cpuctx->task_ctx;
+
+	perf_ctx_lock(cpuctx, task_ctx);
+	ctx_resched(cpuctx, task_ctx, EVENT_ALL|EVENT_CPU);
+	perf_ctx_unlock(cpuctx, task_ctx);
+}
+
 /*
  * Cross CPU call to install and enable a performance event
  *
