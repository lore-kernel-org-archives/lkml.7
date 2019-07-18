Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2E5C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 17:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEDB208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 17:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfGRRN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 13:13:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfGRRN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 13:13:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B257189C37;
        Thu, 18 Jul 2019 17:13:27 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 872195D71A;
        Thu, 18 Jul 2019 17:13:26 +0000 (UTC)
Subject: Re: [PATCH 2/4] rwsem: Add missing ACQUIRE to read_slowpath sleep
 loop
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jan Stancek <jstancek@redhat.com>,
        dbueso@suse.de, mingo@redhat.com, jade.alglave@arm.com,
        paulmck@linux.vnet.ibm.com
References: <20190718134954.496297975@infradead.org>
 <20190718135206.012378477@infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <5279c745-f703-7037-766e-9874648a5de3@redhat.com>
Date:   Thu, 18 Jul 2019 13:13:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190718135206.012378477@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 18 Jul 2019 17:13:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/19 9:49 AM, Peter Zijlstra wrote:
> While reviewing another read_slowpath patch, both Will and I noticed
> another missing ACQUIRE, namely:
>
>   X = 0;
>
>   CPU0			CPU1
>
>   rwsem_down_read()
>     for (;;) {
>       set_current_state(TASK_UNINTERRUPTIBLE);
>
>                         X = 1;
>                         rwsem_up_write();
>                           rwsem_mark_wake()
>                             atomic_long_add(adjustment, &sem->count);
>                             smp_store_release(&waiter->task, NULL);
>
>       if (!waiter.task)
>         break;
>
>       ...
>     }
>
>   r = X;
>
> Allows 'r == 0'.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reported-by: Will Deacon <will@kernel.org>
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/locking/rwsem.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1069,8 +1069,10 @@ rwsem_down_read_slowpath(struct rw_semap
>  	/* wait to be given the lock */
>  	while (true) {
>  		set_current_state(state);
> -		if (!waiter.task)
> +		if (!smp_load_acquire(&waiter.task)) {
> +			/* Orders against rwsem_mark_wake()'s smp_store_release() */
>  			break;
> +		}
>  		if (signal_pending_state(state, current)) {
>  			raw_spin_lock_irq(&sem->wait_lock);
>  			if (waiter.task)
>
>
Acked-by: Waiman Long <longman@redhat.com>

Thanks for fixing this old problem.

This problem does not apply to x86 and we do our testing mostly on x86.
That is why we seldom notice this kind of issue. Maybe we should be
doing more testing on ARM64 and PPC.

Cheers,
Longman

