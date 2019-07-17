Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1731AC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 13:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BE721841
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563369223;
	bh=Xqoht1vFn8rUPitKVXid1g6+VEyjIdTCcUnbdyEN/Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KwJpTOwV7QqDJSrGjBmDkzsT7WlojT6BabGFBOeLUWgbE+JIiywz3pIbaKDqfgqfm
	 w3onzDq7Ii8E3KWJo4jP5Z+S/sW2aNpLOOgy4uoyfKoYWz1EHsGf/ytyijyDnmGzJK
	 iYeUMBXeHiss8R+HuaYRF7JGiPSkV4qgov8sXX10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfGQNNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 09:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:32904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfGQNNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 09:13:41 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B0621743;
        Wed, 17 Jul 2019 13:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563369220;
        bh=Xqoht1vFn8rUPitKVXid1g6+VEyjIdTCcUnbdyEN/Dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MH8EMyvuzRR3AdtPHRh/B9EOBDPW9C3hB619NuB5WE+07WuHeem3q4RbxW1+uWoaF
         4MnSPnSKrUOnwoj94JZ2i+xognQMcYVZacLIuJWYUfvk/xoOhGJFni8b/h3LQ9G6ct
         +aCbLmIe+7ZaXWkc6A5+nDme7f3Ld/6A8PgQRUlo=
Date:   Wed, 17 Jul 2019 14:13:35 +0100
From:   Will Deacon <will@kernel.org>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     linux-kernel@vger.kernel.org, longman@redhat.com, dbueso@suse.de,
        peterz@infradead.org, mingo@redhat.com
Subject: Re: [PATCH v2] locking/rwsem: add acquire barrier to read_slowpath
 exit when queue is empty
Message-ID: <20190717131335.b2ry43t2ov7ba4t4@willie-the-truck>
References: <20190716185807.GJ3402@hirez.programming.kicks-ass.net>
 <a524cf95ab0dbdd1eb65e9decb9283e73d416b1d.1563352912.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a524cf95ab0dbdd1eb65e9decb9283e73d416b1d.1563352912.git.jstancek@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 02:02:20PM +0200, Jan Stancek wrote:
> LTP mtest06 has been observed to rarely hit "still mapped when deleted"
> and following BUG_ON on arm64:
>   page:ffff7e02fa37e480 refcount:3 mapcount:1 mapping:ffff80be3d678ab0 index:0x0
>   xfs_address_space_operations [xfs]
>   flags: 0xbfffe000000037(locked|referenced|uptodate|lru|active)
>   page dumped because: VM_BUG_ON_PAGE(page_mapped(page))
>   ------------[ cut here ]------------
>   kernel BUG at mm/filemap.c:171!
>   Internal error: Oops - BUG: 0 [#1] SMP
>   CPU: 220 PID: 154292 Comm: mmap1 Not tainted 5.2.0-0ecfebd.cki #1
>   Hardware name: HPE Apollo 70 /C01_APACHE_MB , BIOS L50_5.13_1.10 05/17/2019
>   pstate: 40400089 (nZcv daIf +PAN -UAO)
>   pc : unaccount_page_cache_page+0x17c/0x1a0
>   lr : unaccount_page_cache_page+0x17c/0x1a0
>   Call trace:
>   unaccount_page_cache_page+0x17c/0x1a0
>   delete_from_page_cache_batch+0xa0/0x300
>   truncate_inode_pages_range+0x1b8/0x640
>   truncate_inode_pages_final+0x88/0xa8
>   evict+0x1a0/0x1d8
>   iput+0x150/0x240
>   dentry_unlink_inode+0x120/0x130
>   __dentry_kill+0xd8/0x1d0
>   dentry_kill+0x88/0x248
>   dput+0x168/0x1b8
>   __fput+0xe8/0x208
>   ____fput+0x20/0x30
>   task_work_run+0xc0/0xf0
>   do_notify_resume+0x2b0/0x328
>   work_pending+0x8/0x10
> 
> The extra mapcount originated from pagefault handler, which handled
> pagefault for vma that has already been detached. vma is detached
> under mmap_sem write lock by detach_vmas_to_be_unmapped(), which
> also invalidates vmacache.
> 
> When pagefault handler (under mmap_sem read lock) called find_vma(),
> vmacache_valid() wrongly reported vmacache as valid.
> 
> After rwsem down_read() returns via 'queue empty' path (as of v5.2),
> it does so without issuing read_acquire on sem->count:
>   down_read
>     __down_read
>       rwsem_down_read_failed
>         __rwsem_down_read_failed_common
>           raw_spin_lock_irq(&sem->wait_lock);
>           if (list_empty(&sem->wait_list)) {
>             if (atomic_long_read(&sem->count) >= 0) {
>               raw_spin_unlock_irq(&sem->wait_lock);
>               return sem;
> 
> Suspected problem here is that last *_acquire on down_read() side
> happens before write side issues *_release:
>   1. writer: has the lock
>   2. reader: down_read() issues *read_acquire on entry
>   3. writer: mm->vmacache_seqnum++; downgrades lock (*fetch_add_release)
>   4. reader: __rwsem_down_read_failed_common() finds it can take lock and returns
>   5. reader: observes stale mm->vmacache_seqnum
> 
> I can reproduce the problem by running LTP mtest06 in a loop and building
> kernel (-j $NCPUS) in parallel. It does reproduce since v4.20 up to v5.2
> on arm64 HPE Apollo 70 (224 CPUs, 256GB RAM, 2 nodes). It triggers reliably
> within ~hour. Patched kernel ran fine for 10+ hours with clean dmesg.
> Tests were done against v5.2, since commit cf69482d62d9 ("locking/rwsem:
> Enable readers spinning on writer") makes it much harder to reproduce.
> 
> v2: Move barrier after test (Waiman Long)
>     Use smp_acquire__after_ctrl_dep() (Peter Zijlstra)
> 
> Related: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/mtest06/mmap1.c
> Related: commit dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in munmap")
> Fixes: 4b486b535c33 ("locking/rwsem: Exit read lock slowpath if queue empty & no writer")
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> Cc: stable@vger.kernel.org # v4.20+
> Cc: Waiman Long <longman@redhat.com>
> Cc: Davidlohr Bueso <dbueso@suse.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/locking/rwsem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 37524a47f002..5ac72b60608b 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1032,6 +1032,7 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
>  		 */
>  		if (adjustment && !(atomic_long_read(&sem->count) &
>  		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
> +			smp_acquire__after_ctrl_dep();
>  			raw_spin_unlock_irq(&sem->wait_lock);
>  			rwsem_set_reader_owned(sem);
>  			lockevent_inc(rwsem_rlock_fast);

If you add a comment to the code outlining the issue (preferably as a litmus
test involving sem->count and some shared data which happens to be
vmacache_seqnum in your test)), then:

Reviewed-by: Will Deacon <will@kernel.org>

Thanks,

Will
