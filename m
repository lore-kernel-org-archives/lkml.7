Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50DEC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D5320644
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbfHORY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:24:57 -0400
Received: from foss.arm.com ([217.140.110.172]:47054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730282AbfHORY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:24:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F4E428;
        Thu, 15 Aug 2019 10:24:56 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8E643F706;
        Thu, 15 Aug 2019 10:24:55 -0700 (PDT)
Subject: Re: [PATCH] sched/rt: silence double clock update warning by using
 rq_lock wrappers
To:     Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20190815145354.27484-1-pauld@redhat.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <f094734a-eeae-02db-dd0b-d7fe7e9d5db8@arm.com>
Date:   Thu, 15 Aug 2019 18:24:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190815145354.27484-1-pauld@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2019 15:53, Phil Auld wrote:
> With WARN_DOUBLE_CLOCK enabled a false positive warning can occur in rt
> 
>         [] rq->clock_update_flags & RQCF_UPDATED
>         [] WARNING: CPU: 6 PID: 21426 at kernel/sched/core.c:225 
> 						update_rq_clock+0x90/0x130
>           [] Call Trace:
>           []  update_rq_clock+0x90/0x130
>           []  sched_rt_period_timer+0x11f/0x340
>           []  __hrtimer_run_queues+0x100/0x280
>           []  hrtimer_interrupt+0x100/0x220
>           []  smp_apic_timer_interrupt+0x6a/0x130
>           []  apic_timer_interrupt+0xf/0x20
> 
> sched_rt_period_timer does:
>                 raw_spin_lock(&rq->lock);
>                 update_rq_clock(rq);
> 
> which triggers the warning because of not using the rq_lock wrappers.
> So, use the wrappers.
> 
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>

Looks sane to me, and no missing _irqsave this time around ;)

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
