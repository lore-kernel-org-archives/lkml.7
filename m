Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C25C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB7B206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfDCMoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:44:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39456 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCMoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:44:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A537D1596;
        Wed,  3 Apr 2019 05:44:14 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DEAA3F59C;
        Wed,  3 Apr 2019 05:44:13 -0700 (PDT)
Date:   Wed, 3 Apr 2019 13:44:10 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        shenghui <shhuiw@foxmail.com>
Subject: Re: [PATCH] locking/lockdep: Zap lock classes even with lock
 debugging disabled
Message-ID: <20190403124410.GE16362@fuggles.cambridge.arm.com>
References: <20190326195912.43316-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326195912.43316-1-bvanassche@acm.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 12:59:12PM -0700, Bart Van Assche wrote:
> Commit a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer
> in use") changed the behavior of lockdep_free_key_range() from
> unconditionally zapping lock classes into only zapping lock classes if
> debug_lock == true. Since the new behavior can cause cat /proc/lockdep to
> crash due to a NULL pointer dereference, restore the pre-v5.1 behavior.

Can you elaborate on this NULL dereference please, and why this patch fixes
it?

> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: shenghui <shhuiw@foxmail.com>
> Reported-by: shenghui <shhuiw@foxmail.com>
> Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use") # v5.1-rc1.
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  kernel/locking/lockdep.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 34cdcbedda49..70480e4f8f5d 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -4689,8 +4689,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
>  		return;
>  
>  	raw_local_irq_save(flags);
> -	if (!graph_lock())
> -		goto out_irq;
> +	arch_spin_lock(&lockdep_lock);

This also throws out the recursion counting. Is that ok?

Will
