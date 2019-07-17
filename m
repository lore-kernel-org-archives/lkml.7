Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8977CC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFBA2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfGQPdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 11:33:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfGQPdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:33:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F7863082E06;
        Wed, 17 Jul 2019 15:33:51 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7862D5D71D;
        Wed, 17 Jul 2019 15:33:50 +0000 (UTC)
Subject: Re: [PATCH v2] locking/rwsem: add acquire barrier to read_slowpath
 exit when queue is empty
To:     Jan Stancek <jstancek@redhat.com>, linux-kernel@vger.kernel.org
Cc:     dbueso@suse.de, will@kernel.org, peterz@infradead.org,
        mingo@redhat.com
References: <20190716185807.GJ3402@hirez.programming.kicks-ass.net>
 <a524cf95ab0dbdd1eb65e9decb9283e73d416b1d.1563352912.git.jstancek@redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <5313e3de-ca8d-3f7c-eff0-620803303a28@redhat.com>
Date:   Wed, 17 Jul 2019 11:33:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a524cf95ab0dbdd1eb65e9decb9283e73d416b1d.1563352912.git.jstancek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 17 Jul 2019 15:33:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/19 8:02 AM, Jan Stancek wrote:
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

The corresponding change for 5.2 or earlier kernels are:

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index fbe96341beee..2fbbb2d46396 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -246,6 +246,7 @@ __rwsem_down_read_failed_common(struct rw_semaphore
*sem, in
                 * been set in the count.
                 */
                if (atomic_long_read(&sem->count) >= 0) {
+                       smp_acquire__after_ctrl_dep();
                        raw_spin_unlock_irq(&sem->wait_lock);
                        return sem;
                }

-Longman

