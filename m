Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99886C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77760206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfHNNnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:43:22 -0400
Received: from foss.arm.com ([217.140.110.172]:55032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfHNNnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:43:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1971A28;
        Wed, 14 Aug 2019 06:43:21 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF3B83F706;
        Wed, 14 Aug 2019 06:43:18 -0700 (PDT)
Subject: Re: [PATCH 0/9] kthread detection cleanup
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, akpm@linux-foundation.org,
        bigeasy@linutronix.de, bp@suse.de, catalin.marinas@arm.com,
        davem@davemloft.net, hch@lst.de, kan.liang@intel.com,
        mingo@kernel.org, peterz@infradead.org, riel@surriel.com,
        will@kernel.org, Mel Gorman <mgorman@techsingularity.net>
References: <20190814104131.20190-1-mark.rutland@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <c189d01c-3a46-40e2-cee1-e021504cec6e@arm.com>
Date:   Wed, 14 Aug 2019 14:43:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190814104131.20190-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2019 11:41, Mark Rutland wrote:
> A reasonable amount of kernel code looks at task_struct::mm to determine
> whether a thread is a kthread or a real user task. This isn't quite right,
> since kthreads can have a non-NULL mm when calling use_mm().
> 
> The correct way to check whether a task is a kthread is to check whether
> PF_KTHREAD is set in task_struct::flags, but doing so is a bit unwieldy.
> 
> To make this a bit nicer, this series adds a new is_kthread(tsk) helper,
> converts existing code to make use of it, and fixes up a number of erroneous
> checks of current->mm.  Hopefully this will push people to use the right
> approach in future.
> 
> I'm sure there are other instances in the kernel tree where we don't check this
> correctly. In this series I'm just trying to fix the instances I'm reasonably
> confident are incorrect.
> 

I've only found one extra location in kernel/sched/ that seems like it
wants to use is_kthread(), included below. I can send it out separately
after this gets merged.

-----8<-----
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4c4a0494c39b..0956972f6ea7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1964,11 +1964,10 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 out:
 	if (state != cpuset) {
 		/*
-		 * Don't tell them about moving exiting tasks or
-		 * kernel threads (both mm NULL), since they never
-		 * leave kernel.
+		 * Don't tell them about moving exiting tasks (NULL mm) or
+		 * kernel threads since they never leave kernel.
 		 */
-		if (p->mm && printk_ratelimit()) {
+		if ((!is_kthread(p) && p->mm) && printk_ratelimit()) {
 			printk_deferred("process %d (%s) no longer affine to cpu%d\n",
 					task_pid_nr(p), p->comm, cpu);
 		}
----->8-----

Regarding sched/fair.c, I am quite convinced all of the p->mm checks are
genuine (as in they don't care if it's a kthread or not) - those are all
about NUMA balancing. Maybe Rik/Mel can correct me if I'm wrong.

Cheers,
Valentin
