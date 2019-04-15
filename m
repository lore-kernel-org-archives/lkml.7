Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55A2C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CC120880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ah5+xBtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfDOPpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:45:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34468 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfDOPpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YqvxI+lKC6silkLPCrlxAscBRtOSYUbAHi3pT+AHb60=; b=ah5+xBtmwioHqxjv4b4NPrHyd
        iTzSxEUe2wuyKSr1MYUst+KVofVceBfaTeJYQExpURbeBYKN4HFXqHfuqomnuCaH4bDVvl6SrF8UB
        0PQxKe0B6k4HbfyPbf1mV52C6yH5YhTxLWLypwSLQxIlYALd4XFmVtElYvMmIlVKLJy8cJ8jwr3BC
        e5vFMd++earOmry7vCvLU/kpQsNaFhiOiB6ql+VZTsupV+Dz8M4EZSqpl1EdHOe4pNxD0ZOS9pW2K
        J5o2eUAr5rAvLt5cfhknp5zO5s5MOK2d7ShbNo91xYX8zS9MKuC+f8ITT5XD6tl67FrBqqxHtCW+q
        hSvbIz9PQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hG3nf-0002au-6y; Mon, 15 Apr 2019 15:45:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F34372038C257; Mon, 15 Apr 2019 17:45:37 +0200 (CEST)
Date:   Mon, 15 Apr 2019 17:45:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        ak@linux.intel.com, kan.liang@intel.com, mingo@elte.hu,
        nelson.dsouza@intel.com, jolsa@redhat.com, tonyj@suse.com
Subject: Re: [PATCH v2 1/2] perf/core: add perf_ctx_resched() as global
 function
Message-ID: <20190415154537.GH12232@hirez.programming.kicks-ass.net>
References: <20190408173252.37932-1-eranian@google.com>
 <20190408173252.37932-2-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408173252.37932-2-eranian@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 10:32:51AM -0700, Stephane Eranian wrote:
> This patch add perf_ctx_resched() a global function that can be called
> to force rescheduling of events based on event types. The function locks
> both cpuctx and task_ctx internally. This will be used by a subsequent patch.

I took out the task_ctx and event_type arguments.

---
Subject: perf/core: Add perf_ctx_resched() as global function
From: Stephane Eranian <eranian@google.com>
Date: Mon, 8 Apr 2019 10:32:51 -0700

This patch add perf_ctx_resched() a global function that can be called
to force rescheduling of events. The function locks both cpuctx and
task_ctx internally. This will be used by a subsequent patch.

Cc: mingo@elte.hu
Cc: ak@linux.intel.com
Cc: jolsa@redhat.com
Cc: tglx@linutronix.de
Cc: kan.liang@intel.com
Cc: nelson.dsouza@intel.com
Cc: tonyj@suse.com
Signed-off-by: Stephane Eranian <eranian@google.com>
[peterz: simplified calling convention]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190408173252.37932-2-eranian@google.com
---
 include/linux/perf_event.h |    3 +++
 kernel/events/core.c       |    9 +++++++++
 2 files changed, 12 insertions(+)

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -888,6 +888,9 @@ extern void perf_sched_cb_dec(struct pmu
 extern void perf_sched_cb_inc(struct pmu *pmu);
 extern int perf_event_task_disable(void);
 extern int perf_event_task_enable(void);
+
+extern void perf_ctx_resched(struct perf_cpu_context *cpuctx);
+
 extern int perf_event_refresh(struct perf_event *event, int refresh);
 extern void perf_event_update_userpage(struct perf_event *event);
 extern int perf_event_release_kernel(struct perf_event *event);
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2478,6 +2478,15 @@ static void ctx_resched(struct perf_cpu_
 	perf_pmu_enable(cpuctx->ctx.pmu);
 }
 
+void perf_ctx_resched(struct perf_cpu_context *cpuctx)
+{
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
