Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05DBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 23:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9702089E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 23:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfHWXTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 19:19:12 -0400
Received: from foss.arm.com ([217.140.110.172]:39548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfHWXTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 19:19:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F35328;
        Fri, 23 Aug 2019 16:19:11 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 665A43F246;
        Fri, 23 Aug 2019 16:19:10 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: don't assign runtime for throttled cfs_rq
To:     bsegall@google.com, Liangyan <liangyan.peng@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, shanpeic@linux.alibaba.com,
        xlpang@linux.alibaba.com
References: <20190814180021.165389-1-liangyan.peng@linux.alibaba.com>
 <xm26d0gvirdg.fsf@bsegall-linux.svl.corp.google.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <942ae15c-ffa5-74da-208b-7e82df917e16@arm.com>
Date:   Sat, 24 Aug 2019 00:19:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xm26d0gvirdg.fsf@bsegall-linux.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2019 21:00, bsegall@google.com wrote:
[...]
> Could you mention in the message that this a throttled cfs_rq can have
> account_cfs_rq_runtime called on it because it is throttled before
> idle_balance, and the idle_balance calls update_rq_clock to add time
> that is accounted to the task.
> 

Mayhaps even a comment for the extra condition.

> I think this solution is less risky than unthrottling
> in this area, so other than that:
> 
> Reviewed-by: Ben Segall <bsegall@google.com>
> 

If you don't mind squashing this in:

-----8<-----
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b1d9cec9b1ed..b47b0bcf56bc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4630,6 +4630,10 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
 		if (!cfs_rq_throttled(cfs_rq))
 			goto next;
 
+		/* By the above check, this should never be true */
+		WARN_ON(cfs_rq->runtime_remaining > 0);
+
+		/* Pick the minimum amount to return to a positive quota state */
 		runtime = -cfs_rq->runtime_remaining + 1;
 		if (runtime > remaining)
 			runtime = remaining;
----->8-----

I'm not adamant about the extra comment, but the WARN_ON would be nice IMO.


@Ben, do you reckon we want to strap

Cc: <stable@vger.kernel.org>
Fixes: ec12cb7f31e2 ("sched: Accumulate per-cfs_rq cpu usage and charge against bandwidth")

to the thing? AFAICT the pick_next_task_fair() + idle_balance() dance you
described should still be possible on that commit.


Other than that,

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

[...]
