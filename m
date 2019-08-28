Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AD0C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0923922CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfH1KQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:16:58 -0400
Received: from foss.arm.com ([217.140.110.172]:56802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbfH1KQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8CFA337;
        Wed, 28 Aug 2019 03:16:54 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D65F13F59C;
        Wed, 28 Aug 2019 03:16:53 -0700 (PDT)
Subject: Re: [PATCH v3] sched/fair: don't assign runtime for throttled cfs_rq
To:     Liangyan <liangyan.peng@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Cc:     shanpeic@linux.alibaba.com, xlpang@linux.alibaba.com
References: <20190826121633.6538-1-liangyan.peng@linux.alibaba.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <71df56cc-529b-aefb-2905-48e02de5cf86@arm.com>
Date:   Wed, 28 Aug 2019 11:16:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826121633.6538-1-liangyan.peng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2019 13:16, Liangyan wrote:
> do_sched_cfs_period_timer() will refill cfs_b runtime and call
> distribute_cfs_runtime to unthrottle cfs_rq, sometimes cfs_b->runtime
> will allocate all quota to one cfs_rq incorrectly, then other cfs_rqs
> attached to this cfs_b can't get runtime and will be throttled.
> 
> We find that one throttled cfs_rq has non-negative
> cfs_rq->runtime_remaining and cause an unexpetced cast from s64 to u64
> in snippet: distribute_cfs_runtime() {
> runtime = -cfs_rq->runtime_remaining + 1; }.
> The runtime here will change to a large number and consume all
> cfs_b->runtime in this cfs_b period.
> 
> According to Ben Segall, the throttled cfs_rq can have
> account_cfs_rq_runtime called on it because it is throttled before
> idle_balance, and the idle_balance calls update_rq_clock to add time
> that is accounted to the task.
> 
> This commit prevents cfs_rq to be assgined new runtime if it has been
> throttled until that distribute_cfs_runtime is called.
> 
> Signed-off-by: Liangyan <liangyan.peng@linux.alibaba.com>
> Reviewed-by: Ben Segall <bsegall@google.com>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

@Peter/Ingo, if we care about it I believe it can't hurt to strap

Cc: <stable@vger.kernel.org>
Fixes: d3d9dc330236 ("sched: Throttle entities exceeding their allowed bandwidth")

to the thing.
