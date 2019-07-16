Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95478C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F7220880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbfGPQE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 12:04:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfGPQE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 12:04:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1873334C4;
        Tue, 16 Jul 2019 16:04:26 +0000 (UTC)
Received: from dustball.brq.redhat.com (unknown [10.43.17.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D5F31001B0D;
        Tue, 16 Jul 2019 16:04:22 +0000 (UTC)
From:   Jan Stancek <jstancek@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     longman@redhat.com, dbueso@suse.de, will@kernel.org,
        peterz@infradead.org, mingo@redhat.com, jstancek@redhat.com
Subject: [PATCH] locking/rwsem: use read_acquire in read_slowpath exit when queue is empty
Date:   Tue, 16 Jul 2019 18:04:14 +0200
Message-Id: <ea7ef295bc438c9d403087943c82ced56730e6e0.1563292737.git.jstancek@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 16 Jul 2019 16:04:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTP mtest06 has been observed to rarely hit "still mapped when deleted"
and following BUG_ON on arm64:
  page:ffff7e02fa37e480 refcount:3 mapcount:1 mapping:ffff80be3d678ab0 index:0x0
  xfs_address_space_operations [xfs]
  flags: 0xbfffe000000037(locked|referenced|uptodate|lru|active)
  page dumped because: VM_BUG_ON_PAGE(page_mapped(page))
  ------------[ cut here ]------------
  kernel BUG at mm/filemap.c:171!
  Internal error: Oops - BUG: 0 [#1] SMP
  CPU: 220 PID: 154292 Comm: mmap1 Not tainted 5.2.0-0ecfebd.cki #1
  Hardware name: HPE Apollo 70 /C01_APACHE_MB , BIOS L50_5.13_1.10 05/17/2019
  pstate: 40400089 (nZcv daIf +PAN -UAO)
  pc : unaccount_page_cache_page+0x17c/0x1a0
  lr : unaccount_page_cache_page+0x17c/0x1a0
  Call trace:
  unaccount_page_cache_page+0x17c/0x1a0
  delete_from_page_cache_batch+0xa0/0x300
  truncate_inode_pages_range+0x1b8/0x640
  truncate_inode_pages_final+0x88/0xa8
  evict+0x1a0/0x1d8
  iput+0x150/0x240
  dentry_unlink_inode+0x120/0x130
  __dentry_kill+0xd8/0x1d0
  dentry_kill+0x88/0x248
  dput+0x168/0x1b8
  __fput+0xe8/0x208
  ____fput+0x20/0x30
  task_work_run+0xc0/0xf0
  do_notify_resume+0x2b0/0x328
  work_pending+0x8/0x10

The extra mapcount originated from pagefault handler, which handled
pagefault for vma that has already been detached. vma is detached
under mmap_sem write lock by detach_vmas_to_be_unmapped(), which
also invalidates vmacache.

When pagefault handler (under mmap_sem read lock) called find_vma(),
vmacache_valid() wrongly reported vmacache as valid.

After rwsem down_read() returns via 'queue empty' path (as of v5.2),
it does so without issuing read_acquire on sem->count:
  down_read
    __down_read
      rwsem_down_read_failed
        __rwsem_down_read_failed_common
          raw_spin_lock_irq(&sem->wait_lock);
          if (list_empty(&sem->wait_list)) {
            if (atomic_long_read(&sem->count) >= 0) {
              raw_spin_unlock_irq(&sem->wait_lock);
              return sem;

Suspected problem here is that last *_acquire on down_read() side
happens before write side issues *_release:
  1. writer: has the lock
  2. reader: down_read() issues *read_acquire on entry
  3. writer: mm->vmacache_seqnum++; downgrades lock (*fetch_add_release)
  4. reader: __rwsem_down_read_failed_common() finds it can take lock and returns
  5. reader: observes stale mm->vmacache_seqnum

I can reproduce the problem by running LTP mtest06 in a loop and building
kernel (-j $NCPUS) in parallel. It does reproduce since v4.20 up to v5.2
on arm64 HPE Apollo 70 (224 CPUs, 256GB RAM, 2 nodes). It triggers reliably
within ~hour. Patched kernel ran fine for 5+ hours with clean dmesg.
Tests were done against v5.2, since commit cf69482d62d9 ("locking/rwsem:
Enable readers spinning on writer") makes it much harder to reproduce.

Related: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/mtest06/mmap1.c
Related: commit dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in munmap")
Fixes: 4b486b535c33 ("locking/rwsem: Exit read lock slowpath if queue empty & no writer")

Signed-off-by: Jan Stancek <jstancek@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 kernel/locking/rwsem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 37524a47f002..757b198d7a5b 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1030,7 +1030,7 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
 		 * exit the slowpath and return immediately as its
 		 * RWSEM_READER_BIAS has already been set in the count.
 		 */
-		if (adjustment && !(atomic_long_read(&sem->count) &
+		if (adjustment && !(atomic_long_read_acquire(&sem->count) &
 		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
 			raw_spin_unlock_irq(&sem->wait_lock);
 			rwsem_set_reader_owned(sem);
-- 
1.8.3.1

