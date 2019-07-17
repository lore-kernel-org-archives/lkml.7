Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02040C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D336821743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfGQTWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 15:22:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQTWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 15:22:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFA2830842B2;
        Wed, 17 Jul 2019 19:22:06 +0000 (UTC)
Received: from dustball.usersys.redhat.com (unknown [10.43.17.163])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 758C810027BE;
        Wed, 17 Jul 2019 19:22:03 +0000 (UTC)
Date:   Wed, 17 Jul 2019 21:22:00 +0200
From:   Jan Stancek <jstancek@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        dbueso@suse.de, peterz@infradead.org, mingo@redhat.com,
        jstancek@redhat.com
Subject: Re: [PATCH v2] locking/rwsem: add acquire barrier to read_slowpath
 exit when queue is empty
Message-ID: <20190717192200.GA17687@dustball.usersys.redhat.com>
References: <20190716185807.GJ3402@hirez.programming.kicks-ass.net>
 <a524cf95ab0dbdd1eb65e9decb9283e73d416b1d.1563352912.git.jstancek@redhat.com>
 <20190717131335.b2ry43t2ov7ba4t4@willie-the-truck>
 <21ff5905-198b-6ea5-6c2a-9fb10cb48ea7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <21ff5905-198b-6ea5-6c2a-9fb10cb48ea7@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 17 Jul 2019 19:22:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 10:19:04AM -0400, Waiman Long wrote:
>> If you add a comment to the code outlining the issue (preferably as a litmus
>> test involving sem->count and some shared data which happens to be
>> vmacache_seqnum in your test)), then:
>>
>> Reviewed-by: Will Deacon <will@kernel.org>
>>
>> Thanks,
>>
>> Will
>
>Agreed. A comment just above smp_acquire__after_ctrl_dep() on why this
>is needed will be great.
>
>Other than that,
>
>Acked-by: Waiman Long <longman@redhat.com>
>

litmus test looks a bit long, would following be acceptable?

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 37524a47f002..d9c96651bfc7 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1032,6 +1032,13 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
  		 */
  		if (adjustment && !(atomic_long_read(&sem->count) &
  		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
+			/*
+			 * down_read() issued ACQUIRE on enter, but we can race
+			 * with writer who did RELEASE only after us.
+			 * ACQUIRE here makes sure reader operations happen only
+			 * after all writer ones.
+			 */
+			smp_acquire__after_ctrl_dep();
  			raw_spin_unlock_irq(&sem->wait_lock);
  			rwsem_set_reader_owned(sem);
  			lockevent_inc(rwsem_rlock_fast);


with litmus test in commit log:
----------------------------------- 8< ------------------------------------
C rwsem

{
	atomic_t rwsem_count = ATOMIC_INIT(1);
	int vmacache_seqnum = 10;
}

P0(int *vmacache_seqnum, atomic_t *rwsem_count)
{
	r0 = READ_ONCE(*vmacache_seqnum);
	WRITE_ONCE(*vmacache_seqnum, r0 + 1);
	/* downgrade_write */
	r1 = atomic_fetch_add_release(-1+256, rwsem_count);
}

P1(int *vmacache_seqnum, atomic_t *rwsem_count, spinlock_t *sem_wait_lock)
{
	/* rwsem_read_trylock */
	r0 = atomic_add_return_acquire(256, rwsem_count);
	/* rwsem_down_read_slowpath */
	spin_lock(sem_wait_lock);
	r0 = atomic_read(rwsem_count);
	if ((r0 & 1) == 0) {
		// BUG: needs barrier
		spin_unlock(sem_wait_lock);
		r1 = READ_ONCE(*vmacache_seqnum);
	}
}
exists (1:r1=10)
----------------------------------- 8< ------------------------------------

Thanks,
Jan

