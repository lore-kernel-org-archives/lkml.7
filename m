Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FEEC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A9421849
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfGQTjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 15:39:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfGQTji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 15:39:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 53D59300C728;
        Wed, 17 Jul 2019 19:39:38 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD72760922;
        Wed, 17 Jul 2019 19:39:37 +0000 (UTC)
Subject: Re: [PATCH v2] locking/rwsem: add acquire barrier to read_slowpath
 exit when queue is empty
To:     Jan Stancek <jstancek@redhat.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        dbueso@suse.de, peterz@infradead.org, mingo@redhat.com
References: <20190716185807.GJ3402@hirez.programming.kicks-ass.net>
 <a524cf95ab0dbdd1eb65e9decb9283e73d416b1d.1563352912.git.jstancek@redhat.com>
 <20190717131335.b2ry43t2ov7ba4t4@willie-the-truck>
 <21ff5905-198b-6ea5-6c2a-9fb10cb48ea7@redhat.com>
 <20190717192200.GA17687@dustball.usersys.redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1950f8bd-e0f4-9b65-fee6-701ecf531d1c@redhat.com>
Date:   Wed, 17 Jul 2019 15:39:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190717192200.GA17687@dustball.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 17 Jul 2019 19:39:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/19 3:22 PM, Jan Stancek wrote:
> On Wed, Jul 17, 2019 at 10:19:04AM -0400, Waiman Long wrote:
>>> If you add a comment to the code outlining the issue (preferably as
>>> a litmus
>>> test involving sem->count and some shared data which happens to be
>>> vmacache_seqnum in your test)), then:
>>>
>>> Reviewed-by: Will Deacon <will@kernel.org>
>>>
>>> Thanks,
>>>
>>> Will
>>
>> Agreed. A comment just above smp_acquire__after_ctrl_dep() on why this
>> is needed will be great.
>>
>> Other than that,
>>
>> Acked-by: Waiman Long <longman@redhat.com>
>>
>
> litmus test looks a bit long, would following be acceptable?
>
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 37524a47f002..d9c96651bfc7 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1032,6 +1032,13 @@ static inline bool
> rwsem_reader_phase_trylock(struct rw_semaphore *sem,
>           */
>          if (adjustment && !(atomic_long_read(&sem->count) &
>               (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
> +            /*
> +             * down_read() issued ACQUIRE on enter, but we can race
> +             * with writer who did RELEASE only after us.
> +             * ACQUIRE here makes sure reader operations happen only
> +             * after all writer ones.
> +             */


How about that?

                /*
                 * Add an acquire barrier here to make sure no stale data
                 * acquired before the above test where the writer may still
                 * be holding the lock will be reused in the reader
critical
                 * section.
                 */

Thanks,
Longman


