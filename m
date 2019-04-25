Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E06C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F90F217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ieMQLJgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfDYIAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:00:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47978 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfDYIAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=psogWtI1uy8YkV5hhwCdx2cClcHcsNKnUU83+auLkOs=; b=ieMQLJgsdFGVe5GV6+tfDKAOB
        EwvGWu8zv2FfjuMMgkHvV3SmHJ225pdG9SkG8BtiaSGJo2Fn8WJyuOmwLoNGMf7UfMBXa6eSboC0B
        rZYqAz54XhQbUhFSrau9G1eG4owjbhgStlDzfzYUBEeuUWxtQ6iVtNDbKNVkroFP3xsxmbGgiVXTd
        +vr+JHDPtsHj/p9oNVjVUUpbfgcYvYymEqvlzoAjeiSx9lsx85hWJwzQYSMviFZrTeAX04emStle/
        UXAV7IOSHLcWQ6pvyS3UbzJkBPvOVmNq301OThAQqR7VtWufokdeF/xh4LJLZ8JDWBT+jSGnMhTPK
        xImbMsO5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJZIp-0000rL-Rl; Thu, 25 Apr 2019 08:00:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BDED20D0A201; Thu, 25 Apr 2019 10:00:16 +0200 (CEST)
Date:   Thu, 25 Apr 2019 10:00:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xie XiuQi <xiexiuqi@huawei.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        cj.chengjian@huawei.com
Subject: Re: [PATCH] sched: fix a potential divide error
Message-ID: <20190425080016.GX11158@hirez.programming.kicks-ass.net>
References: <20190420083416.170446-1-xiexiuqi@huawei.com>
 <20190423184458.GW4038@hirez.programming.kicks-ass.net>
 <14cdc45e-7a6f-5e1f-e877-10503180ac4e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14cdc45e-7a6f-5e1f-e877-10503180ac4e@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 11:52:28AM +0800, Xie XiuQi wrote:
> On 2019/4/24 2:44, Peter Zijlstra wrote:

> > I'll try and come up with a better Changelog tomorrow.

I actually did, but forgot to send out. I have the below.
Does that work for you?

---
Subject: sched/numa: Fix a possible divide-by-zero
From: Xie XiuQi <xiexiuqi@huawei.com>
Date: Sat, 20 Apr 2019 16:34:16 +0800

sched_clock_cpu() may not be consistent between CPUs. If a task
migrates to another CPU, then se.exec_start is set to that CPU's
rq_clock_task() by update_stats_curr_start(). Specifically, the new
value might be before the old value due to clock skew.

So then if in numa_get_avg_runtime() the expression:

  'now - p->last_task_numa_placement'

ends up as -1, then the divider '*period + 1' in task_numa_placement()
is 0 and things go bang. Similar to update_curr(), check if time goes
backwards to avoid this.

Cc: mingo@redhat.com
Cc: cj.chengjian@huawei.com
Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
[peterz: simplified changelog]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190420083416.170446-1-xiexiuqi@huawei.com
---
 kernel/sched/fair.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2007,6 +2007,10 @@ static u64 numa_get_avg_runtime(struct t
 	if (p->last_task_numa_placement) {
 		delta = runtime - p->last_sum_exec_runtime;
 		*period = now - p->last_task_numa_placement;
+
+		/* Avoid backward, and prevent potential divide error */
+		if (unlikely((s64)*period < 0))
+			*period = 0;
 	} else {
 		delta = p->se.avg.load_sum;
 		*period = LOAD_AVG_MAX;
