Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF51C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56DE2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfDCKrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:47:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32935 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDCKrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:47:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x33AjYoN1814969
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 03:45:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x33AjYF31814966;
        Wed, 3 Apr 2019 03:45:34 -0700
Date:   Wed, 3 Apr 2019 03:45:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-0975e3df30eb5849284c01be66c2ec16d8a48114@git.kernel.org>
Cc:     paulmck@linux.vnet.ibm.com, will.deacon@arm.com, mingo@kernel.org,
        dave@stgolabs.net, tglx@linutronix.de, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, arnd@arndb.de, longman@redhat.com,
        peterz@infradead.org, akpm@linux-foundation.org, hpa@zytor.com,
        bp@alien8.de, torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, bp@alien8.de, hpa@zytor.com,
          akpm@linux-foundation.org, peterz@infradead.org,
          longman@redhat.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
          dave@stgolabs.net, tglx@linutronix.de,
          tim.c.chen@linux.intel.com, will.deacon@arm.com,
          mingo@kernel.org, paulmck@linux.vnet.ibm.com
In-Reply-To: <20190322143008.21313-4-longman@redhat.com>
References: <20190322143008.21313-4-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Optimize down_read_trylock()
Git-Commit-ID: 0975e3df30eb5849284c01be66c2ec16d8a48114
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0975e3df30eb5849284c01be66c2ec16d8a48114
Gitweb:     https://git.kernel.org/tip/0975e3df30eb5849284c01be66c2ec16d8a48114
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Fri, 22 Mar 2019 10:30:08 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Apr 2019 11:42:35 +0200

locking/rwsem: Optimize down_read_trylock()

Modify __down_read_trylock() to optimize for an unlocked rwsem and make
it generate slightly better code.

Before this patch, down_read_trylock:

   0x0000000000000000 <+0>:     callq  0x5 <down_read_trylock+5>
   0x0000000000000005 <+5>:     jmp    0x18 <down_read_trylock+24>
   0x0000000000000007 <+7>:     lea    0x1(%rdx),%rcx
   0x000000000000000b <+11>:    mov    %rdx,%rax
   0x000000000000000e <+14>:    lock cmpxchg %rcx,(%rdi)
   0x0000000000000013 <+19>:    cmp    %rax,%rdx
   0x0000000000000016 <+22>:    je     0x23 <down_read_trylock+35>
   0x0000000000000018 <+24>:    mov    (%rdi),%rdx
   0x000000000000001b <+27>:    test   %rdx,%rdx
   0x000000000000001e <+30>:    jns    0x7 <down_read_trylock+7>
   0x0000000000000020 <+32>:    xor    %eax,%eax
   0x0000000000000022 <+34>:    retq
   0x0000000000000023 <+35>:    mov    %gs:0x0,%rax
   0x000000000000002c <+44>:    or     $0x3,%rax
   0x0000000000000030 <+48>:    mov    %rax,0x20(%rdi)
   0x0000000000000034 <+52>:    mov    $0x1,%eax
   0x0000000000000039 <+57>:    retq

After patch, down_read_trylock:

   0x0000000000000000 <+0>:	callq  0x5 <down_read_trylock+5>
   0x0000000000000005 <+5>:	xor    %eax,%eax
   0x0000000000000007 <+7>:	lea    0x1(%rax),%rdx
   0x000000000000000b <+11>:	lock cmpxchg %rdx,(%rdi)
   0x0000000000000010 <+16>:	jne    0x29 <down_read_trylock+41>
   0x0000000000000012 <+18>:	mov    %gs:0x0,%rax
   0x000000000000001b <+27>:	or     $0x3,%rax
   0x000000000000001f <+31>:	mov    %rax,0x20(%rdi)
   0x0000000000000023 <+35>:	mov    $0x1,%eax
   0x0000000000000028 <+40>:	retq
   0x0000000000000029 <+41>:	test   %rax,%rax
   0x000000000000002c <+44>:	jns    0x7 <down_read_trylock+7>
   0x000000000000002e <+46>:	xor    %eax,%eax
   0x0000000000000030 <+48>:	retq

By using a rwsem microbenchmark, the down_read_trylock() rate (with a
load of 10 to lengthen the lock critical section) on a x86-64 system
before and after the patch were:

                 Before Patch    After Patch
   # of Threads     rlock           rlock
   ------------     -----           -----
        1           14,496          14,716
        2            8,644           8,453
	4            6,799           6,983
	8            5,664           7,190

On a ARM64 system, the performance results were:

                 Before Patch    After Patch
   # of Threads     rlock           rlock
   ------------     -----           -----
        1           23,676          24,488
        2            7,697           9,502
        4            4,945           3,440
        8            2,641           1,603

For the uncontended case (1 thread), the new down_read_trylock() is a
little bit faster. For the contended cases, the new down_read_trylock()
perform pretty well in x86-64, but performance degrades at high
contention level on ARM64.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-c6x-dev@linux-c6x.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-um@lists.infradead.org
Cc: linux-xtensa@linux-xtensa.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: nios2-dev@lists.rocketboards.org
Cc: openrisc@lists.librecores.org
Cc: uclinux-h8-devel@lists.sourceforge.jp
Link: https://lkml.kernel.org/r/20190322143008.21313-4-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index 45ee00236e03..1f5775aa6a1d 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -174,14 +174,17 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 
 static inline int __down_read_trylock(struct rw_semaphore *sem)
 {
-	long tmp;
+	/*
+	 * Optimize for the case when the rwsem is not locked at all.
+	 */
+	long tmp = RWSEM_UNLOCKED_VALUE;
 
-	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
-		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
-				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
+	do {
+		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
+					tmp + RWSEM_ACTIVE_READ_BIAS)) {
 			return 1;
 		}
-	}
+	} while (tmp >= 0);
 	return 0;
 }
 
