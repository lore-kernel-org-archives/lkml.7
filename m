Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A132C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696322133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050029;
	bh=q7Ktd/1EMZh56zfzGNa94jsr/FtFhWXZ4rD8X+6dKl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=da5AcIkZpDKf2dHNoICbL3sw6f280u1xM02tciiu1nP7BHiiAyAt4+rBkB1qrvOJ+
	 Danz1ldzbYCS/YscQUN7gGyAxfXNMdMHiuZfcyhAtZmkgmTeOLnntQJK6doJqbXn2s
	 o8nFCueENlBRtpalCdlEjdmeGR5azIgdbOdg4kIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfCHNA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:00:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbfCHNAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:00:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77F6521019;
        Fri,  8 Mar 2019 13:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552050023;
        bh=q7Ktd/1EMZh56zfzGNa94jsr/FtFhWXZ4rD8X+6dKl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tycpiZnn/B4yhl8KqM9wQMGtundLvIcpAS4RdrlCzFEeiUygc2rtohFJ2716HKGKO
         UxvO9+fRO2ITrPP1KYLnIoUyhobNYL+iCvtekecDLzCtLHnVFDH6ZlU/FYaodrEiOT
         YxUD2D6Y7NWW8jkqn0IZaKCd4Bgvox1eBjEHcdQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bart Van Assche <bvanassche@acm.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.19 59/68] aio: Fix locking in aio_poll()
Date:   Fri,  8 Mar 2019 13:50:29 +0100
Message-Id: <20190308124913.494213881@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

commit d3d6a18d7d351cbcc9b33dbedf710e65f8ce1595 upstream.

wake_up_locked() may but does not have to be called with interrupts
disabled. Since the fuse filesystem calls wake_up_locked() without
disabling interrupts aio_poll_wake() may be called with interrupts
enabled. Since the kioctx.ctx_lock may be acquired from IRQ context,
all code that acquires that lock from thread context must disable
interrupts. Hence change the spin_trylock() call in aio_poll_wake()
into a spin_trylock_irqsave() call. This patch fixes the following
lockdep complaint:

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
5.0.0-rc4-next-20190131 #23 Not tainted
-----------------------------------------------------
syz-executor2/13779 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
0000000098ac1230 (&fiq->waitq){+.+.}, at: spin_lock include/linux/spinlock.h:329 [inline]
0000000098ac1230 (&fiq->waitq){+.+.}, at: aio_poll fs/aio.c:1772 [inline]
0000000098ac1230 (&fiq->waitq){+.+.}, at: __io_submit_one fs/aio.c:1875 [inline]
0000000098ac1230 (&fiq->waitq){+.+.}, at: io_submit_one+0xedf/0x1cf0 fs/aio.c:1908

and this task is already holding:
000000003c46111c (&(&ctx->ctx_lock)->rlock){..-.}, at: spin_lock_irq include/linux/spinlock.h:354 [inline]
000000003c46111c (&(&ctx->ctx_lock)->rlock){..-.}, at: aio_poll fs/aio.c:1771 [inline]
000000003c46111c (&(&ctx->ctx_lock)->rlock){..-.}, at: __io_submit_one fs/aio.c:1875 [inline]
000000003c46111c (&(&ctx->ctx_lock)->rlock){..-.}, at: io_submit_one+0xeb6/0x1cf0 fs/aio.c:1908
which would create a new lock dependency:
 (&(&ctx->ctx_lock)->rlock){..-.} -> (&fiq->waitq){+.+.}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&(&ctx->ctx_lock)->rlock){..-.}

... which became SOFTIRQ-irq-safe at:
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3826
  __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
  _raw_spin_lock_irq+0x60/0x80 kernel/locking/spinlock.c:160
  spin_lock_irq include/linux/spinlock.h:354 [inline]
  free_ioctx_users+0x2d/0x4a0 fs/aio.c:610
  percpu_ref_put_many include/linux/percpu-refcount.h:285 [inline]
  percpu_ref_put include/linux/percpu-refcount.h:301 [inline]
  percpu_ref_call_confirm_rcu lib/percpu-refcount.c:123 [inline]
  percpu_ref_switch_to_atomic_rcu+0x3e7/0x520 lib/percpu-refcount.c:158
  __rcu_reclaim kernel/rcu/rcu.h:240 [inline]
  rcu_do_batch kernel/rcu/tree.c:2486 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2799 [inline]
  rcu_core+0x928/0x1390 kernel/rcu/tree.c:2780
  __do_softirq+0x266/0x95a kernel/softirq.c:292
  run_ksoftirqd kernel/softirq.c:654 [inline]
  run_ksoftirqd+0x8e/0x110 kernel/softirq.c:646
  smpboot_thread_fn+0x6ab/0xa10 kernel/smpboot.c:164
  kthread+0x357/0x430 kernel/kthread.c:247
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

to a SOFTIRQ-irq-unsafe lock:
 (&fiq->waitq){+.+.}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3826
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
  spin_lock include/linux/spinlock.h:329 [inline]
  flush_bg_queue+0x1f3/0x3c0 fs/fuse/dev.c:415
  fuse_request_queue_background+0x2d1/0x580 fs/fuse/dev.c:676
  fuse_request_send_background+0x58/0x120 fs/fuse/dev.c:687
  fuse_send_init fs/fuse/inode.c:989 [inline]
  fuse_fill_super+0x13bb/0x1730 fs/fuse/inode.c:1214
  mount_nodev+0x68/0x110 fs/super.c:1392
  fuse_mount+0x2d/0x40 fs/fuse/inode.c:1239
  legacy_get_tree+0xf2/0x200 fs/fs_context.c:590
  vfs_get_tree+0x123/0x450 fs/super.c:1481
  do_new_mount fs/namespace.c:2610 [inline]
  do_mount+0x1436/0x2c40 fs/namespace.c:2932
  ksys_mount+0xdb/0x150 fs/namespace.c:3148
  __do_sys_mount fs/namespace.c:3162 [inline]
  __se_sys_mount fs/namespace.c:3159 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3159
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&fiq->waitq);
                               local_irq_disable();
                               lock(&(&ctx->ctx_lock)->rlock);
                               lock(&fiq->waitq);
  <Interrupt>
    lock(&(&ctx->ctx_lock)->rlock);

 *** DEADLOCK ***

1 lock held by syz-executor2/13779:
 #0: 000000003c46111c (&(&ctx->ctx_lock)->rlock){..-.}, at: spin_lock_irq include/linux/spinlock.h:354 [inline]
 #0: 000000003c46111c (&(&ctx->ctx_lock)->rlock){..-.}, at: aio_poll fs/aio.c:1771 [inline]
 #0: 000000003c46111c (&(&ctx->ctx_lock)->rlock){..-.}, at: __io_submit_one fs/aio.c:1875 [inline]
 #0: 000000003c46111c (&(&ctx->ctx_lock)->rlock){..-.}, at: io_submit_one+0xeb6/0x1cf0 fs/aio.c:1908

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
-> (&(&ctx->ctx_lock)->rlock){..-.} {
   IN-SOFTIRQ-W at:
                    lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3826
                    __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
                    _raw_spin_lock_irq+0x60/0x80 kernel/locking/spinlock.c:160
                    spin_lock_irq include/linux/spinlock.h:354 [inline]
                    free_ioctx_users+0x2d/0x4a0 fs/aio.c:610
                    percpu_ref_put_many include/linux/percpu-refcount.h:285 [inline]
                    percpu_ref_put include/linux/percpu-refcount.h:301 [inline]
                    percpu_ref_call_confirm_rcu lib/percpu-refcount.c:123 [inline]
                    percpu_ref_switch_to_atomic_rcu+0x3e7/0x520 lib/percpu-refcount.c:158
                    __rcu_reclaim kernel/rcu/rcu.h:240 [inline]
                    rcu_do_batch kernel/rcu/tree.c:2486 [inline]
                    invoke_rcu_callbacks kernel/rcu/tree.c:2799 [inline]
                    rcu_core+0x928/0x1390 kernel/rcu/tree.c:2780
                    __do_softirq+0x266/0x95a kernel/softirq.c:292
                    run_ksoftirqd kernel/softirq.c:654 [inline]
                    run_ksoftirqd+0x8e/0x110 kernel/softirq.c:646
                    smpboot_thread_fn+0x6ab/0xa10 kernel/smpboot.c:164
                    kthread+0x357/0x430 kernel/kthread.c:247
                    ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
   INITIAL USE at:
                   lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3826
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
                   _raw_spin_lock_irq+0x60/0x80 kernel/locking/spinlock.c:160
                   spin_lock_irq include/linux/spinlock.h:354 [inline]
                   __do_sys_io_cancel fs/aio.c:2052 [inline]
                   __se_sys_io_cancel fs/aio.c:2035 [inline]
                   __x64_sys_io_cancel+0xd5/0x5a0 fs/aio.c:2035
                   do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
                   entry_SYSCALL_64_after_hwframe+0x49/0xbe
 }
 ... key      at: [<ffffffff8a574140>] __key.52370+0x0/0x40
 ... acquired at:
   lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3826
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
   spin_lock include/linux/spinlock.h:329 [inline]
   aio_poll fs/aio.c:1772 [inline]
   __io_submit_one fs/aio.c:1875 [inline]
   io_submit_one+0xedf/0x1cf0 fs/aio.c:1908
   __do_sys_io_submit fs/aio.c:1953 [inline]
   __se_sys_io_submit fs/aio.c:1923 [inline]
   __x64_sys_io_submit+0x1bd/0x580 fs/aio.c:1923
   do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
-> (&fiq->waitq){+.+.} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3826
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
                    spin_lock include/linux/spinlock.h:329 [inline]
                    flush_bg_queue+0x1f3/0x3c0 fs/fuse/dev.c:415
                    fuse_request_queue_background+0x2d1/0x580 fs/fuse/dev.c:676
                    fuse_request_send_background+0x58/0x120 fs/fuse/dev.c:687
                    fuse_send_init fs/fuse/inode.c:989 [inline]
                    fuse_fill_super+0x13bb/0x1730 fs/fuse/inode.c:1214
                    mount_nodev+0x68/0x110 fs/super.c:1392
                    fuse_mount+0x2d/0x40 fs/fuse/inode.c:1239
                    legacy_get_tree+0xf2/0x200 fs/fs_context.c:590
                    vfs_get_tree+0x123/0x450 fs/super.c:1481
                    do_new_mount fs/namespace.c:2610 [inline]
                    do_mount+0x1436/0x2c40 fs/namespace.c:2932
                    ksys_mount+0xdb/0x150 fs/namespace.c:3148
                    __do_sys_mount fs/namespace.c:3162 [inline]
                    __se_sys_mount fs/namespace.c:3159 [inline]
                    __x64_sys_mount+0xbe/0x150 fs/namespace.c:3159
                    do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
   SOFTIRQ-ON-W at:
                    lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3826
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
                    spin_lock include/linux/spinlock.h:329 [inline]
                    flush_bg_queue+0x1f3/0x3c0 fs/fuse/dev.c:415
                    fuse_request_queue_background+0x2d1/0x580 fs/fuse/dev.c:676
                    fuse_request_send_background+0x58/0x120 fs/fuse/dev.c:687
                    fuse_send_init fs/fuse/inode.c:989 [inline]
                    fuse_fill_super+0x13bb/0x1730 fs/fuse/inode.c:1214
                    mount_nodev+0x68/0x110 fs/super.c:1392
                    fuse_mount+0x2d/0x40 fs/fuse/inode.c:1239
                    legacy_get_tree+0xf2/0x200 fs/fs_context.c:590
                    vfs_get_tree+0x123/0x450 fs/super.c:1481
                    do_new_mount fs/namespace.c:2610 [inline]
                    do_mount+0x1436/0x2c40 fs/namespace.c:2932
                    ksys_mount+0xdb/0x150 fs/namespace.c:3148
                    __do_sys_mount fs/namespace.c:3162 [inline]
                    __se_sys_mount fs/namespace.c:3159 [inline]
                    __x64_sys_mount+0xbe/0x150 fs/namespace.c:3159
                    do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
   INITIAL USE at:
                   lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3826
                   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                   _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
                   spin_lock include/linux/spinlock.h:329 [inline]
                   flush_bg_queue+0x1f3/0x3c0 fs/fuse/dev.c:415
                   fuse_request_queue_background+0x2d1/0x580 fs/fuse/dev.c:676
                   fuse_request_send_background+0x58/0x120 fs/fuse/dev.c:687
                   fuse_send_init fs/fuse/inode.c:989 [inline]
                   fuse_fill_super+0x13bb/0x1730 fs/fuse/inode.c:1214
                   mount_nodev+0x68/0x110 fs/super.c:1392
                   fuse_mount+0x2d/0x40 fs/fuse/inode.c:1239
                   legacy_get_tree+0xf2/0x200 fs/fs_context.c:590
                   vfs_get_tree+0x123/0x450 fs/super.c:1481
                   do_new_mount fs/namespace.c:2610 [inline]
                   do_mount+0x1436/0x2c40 fs/namespace.c:2932
                   ksys_mount+0xdb/0x150 fs/namespace.c:3148
                   __do_sys_mount fs/namespace.c:3162 [inline]
                   __se_sys_mount fs/namespace.c:3159 [inline]
                   __x64_sys_mount+0xbe/0x150 fs/namespace.c:3159
                   do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
                   entry_SYSCALL_64_after_hwframe+0x49/0xbe
 }
 ... key      at: [<ffffffff8a60dec0>] __key.43450+0x0/0x40
 ... acquired at:
   lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3826
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
   spin_lock include/linux/spinlock.h:329 [inline]
   aio_poll fs/aio.c:1772 [inline]
   __io_submit_one fs/aio.c:1875 [inline]
   io_submit_one+0xedf/0x1cf0 fs/aio.c:1908
   __do_sys_io_submit fs/aio.c:1953 [inline]
   __se_sys_io_submit fs/aio.c:1923 [inline]
   __x64_sys_io_submit+0x1bd/0x580 fs/aio.c:1923
   do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

stack backtrace:
CPU: 0 PID: 13779 Comm: syz-executor2 Not tainted 5.0.0-rc4-next-20190131 #23
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x172/0x1f0 lib/dump_stack.c:113
 print_bad_irq_dependency kernel/locking/lockdep.c:1573 [inline]
 check_usage.cold+0x60f/0x940 kernel/locking/lockdep.c:1605
 check_irq_usage kernel/locking/lockdep.c:1650 [inline]
 check_prev_add_irq kernel/locking/lockdep_states.h:8 [inline]
 check_prev_add kernel/locking/lockdep.c:1860 [inline]
 check_prevs_add kernel/locking/lockdep.c:1968 [inline]
 validate_chain kernel/locking/lockdep.c:2339 [inline]
 __lock_acquire+0x1f12/0x4790 kernel/locking/lockdep.c:3320
 lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3826
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
 spin_lock include/linux/spinlock.h:329 [inline]
 aio_poll fs/aio.c:1772 [inline]
 __io_submit_one fs/aio.c:1875 [inline]
 io_submit_one+0xedf/0x1cf0 fs/aio.c:1908
 __do_sys_io_submit fs/aio.c:1953 [inline]
 __se_sys_io_submit fs/aio.c:1923 [inline]
 __x64_sys_io_submit+0x1bd/0x580 fs/aio.c:1923
 do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: <stable@vger.kernel.org>
Fixes: e8693bcfa0b4 ("aio: allow direct aio poll comletions for keyed wakeups") # v4.19
Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
[ bvanassche: added a comment ]
Reluctantly-Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/aio.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1661,6 +1661,7 @@ static int aio_poll_wake(struct wait_que
 	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
 	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
 	__poll_t mask = key_to_poll(key);
+	unsigned long flags;
 
 	req->woken = true;
 
@@ -1669,10 +1670,15 @@ static int aio_poll_wake(struct wait_que
 		if (!(mask & req->events))
 			return 0;
 
-		/* try to complete the iocb inline if we can: */
-		if (spin_trylock(&iocb->ki_ctx->ctx_lock)) {
+		/*
+		 * Try to complete the iocb inline if we can. Use
+		 * irqsave/irqrestore because not all filesystems (e.g. fuse)
+		 * call this function with IRQs disabled and because IRQs
+		 * have to be disabled before ctx_lock is obtained.
+		 */
+		if (spin_trylock_irqsave(&iocb->ki_ctx->ctx_lock, flags)) {
 			list_del(&iocb->ki_list);
-			spin_unlock(&iocb->ki_ctx->ctx_lock);
+			spin_unlock_irqrestore(&iocb->ki_ctx->ctx_lock, flags);
 
 			list_del_init(&req->wait.entry);
 			aio_poll_complete(iocb, mask);


