Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F73C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8A220693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfGPTJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:09:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbfGPTJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:09:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 617DBC024AFA;
        Tue, 16 Jul 2019 19:09:52 +0000 (UTC)
Received: from llong.remote.csb (ovpn-122-180.rdu2.redhat.com [10.10.122.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DAFF60C4C;
        Tue, 16 Jul 2019 19:09:51 +0000 (UTC)
Subject: Re: [PATCH] locking/rwsem: use read_acquire in read_slowpath exit
 when queue is empty
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jan Stancek <jstancek@redhat.com>, linux-kernel@vger.kernel.org,
        dbueso@suse.de, will@kernel.org, mingo@redhat.com
References: <ea7ef295bc438c9d403087943c82ced56730e6e0.1563292737.git.jstancek@redhat.com>
 <4ef66a01-7937-1eb7-c58b-0992a0142c92@redhat.com>
 <20190716185807.GJ3402@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <0ebcd9ef-d39a-604f-004e-2697d8bf25f5@redhat.com>
Date:   Tue, 16 Jul 2019 15:09:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190716185807.GJ3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 16 Jul 2019 19:09:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/19 2:58 PM, Peter Zijlstra wrote:
> On Tue, Jul 16, 2019 at 12:53:14PM -0400, Waiman Long wrote:
>> On 7/16/19 12:04 PM, Jan Stancek wrote:
> Fixes: 4b486b535c33 ("locking/rwsem: Exit read lock slowpath if queue empty & no writer")
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Davidlohr Bueso <dbueso@suse.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/locking/rwsem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 37524a47f002..757b198d7a5b 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1030,7 +1030,7 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
>  		 * exit the slowpath and return immediately as its
>  		 * RWSEM_READER_BIAS has already been set in the count.
>  		 */
> -		if (adjustment && !(atomic_long_read(&sem->count) &
> +		if (adjustment && !(atomic_long_read_acquire(&sem->count) &
>  		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
>  			raw_spin_unlock_irq(&sem->wait_lock);
>  			rwsem_set_reader_owned(sem);
>> The chance of taking this path is not that high. So instead of
>> increasing the cost of the test by adding an acquire barrier, how about
>> just adding smp_mb__after_spinlock() before spin_unlock_irq(). This
>> should have the same effect of making sure that no stale data will be
>> used in the read-lock critical section.
> That's actually more expensive on something like ARM64 I expect.
>
> The far cheaper alternative is smp_acquire__after_ctrl_dep(), however in
> general Will seems to prefer using load-acquire over separate barriers,
> and for x86 it doesn't matter anyway. For PowerPC these two are a wash,
> both end up with LWSYNC (over SYNC for your alternative).

With lock event counting turned on, my experience with this code path
was that it got hit very infrequently. It is even less frequent with the
latest reader optimistic spinning patch. That is why I prefer making it
a bit more costly when the condition is true without incurring a cost at
all when the condition is false which is the majority of the cases.
Anyway, this additional cost is for arm64 only, but it is still more
than compensated by all skipping all the waiting list manipulation and
waking up itself code.

Cheers,
Longman

