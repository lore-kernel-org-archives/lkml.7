Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E32C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DDF217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429011;
	bh=yqk5+woGcvyUKN15EkNQE6LysIPXR3OVtsHCMxiKPWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YUKdPRMTsJnCGeZEtQOiGGo1BgjOTLbaoJa16z1TrJlPDiOBCLeCx1UVph48yyM0Q
	 udkuY/DztFVg7Q1j39GO6njBYu3Dkix3b2k1nTjn2cTjXWy3GA85KTmfzWUx7b8NlT
	 q8yi5/v+FofnP+IJ1F7BB8lFnHtKL6Y8HJL/Q1DQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388413AbfG2Tgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730205AbfG2Tgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:36:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60A5B21773;
        Mon, 29 Jul 2019 19:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429003;
        bh=yqk5+woGcvyUKN15EkNQE6LysIPXR3OVtsHCMxiKPWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jP3ksORsSFI8G64quPMlz+bBhGQ51XZpBZuvZxVDX2tfahMpAmIPlj0SInRbdLcvd
         7SKQ4ki8/g6GqN8Hb/NjBd3Ift9QmhTBvW+t/h6HW8GhJKoo83Y++4Gci6hHDFjC70
         UH9mNCUnSr1OIb8TiN1u6pNSyKY53QEoV59UBj04=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 254/293] um: Silence lockdep complaint about mmap_sem
Date:   Mon, 29 Jul 2019 21:22:25 +0200
Message-Id: <20190729190843.909942206@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 80bf6ceaf9310b3f61934c69b382d4912deee049 ]

When we get into activate_mm(), lockdep complains that we're doing
something strange:

    WARNING: possible circular locking dependency detected
    5.1.0-10252-gb00152307319-dirty #121 Not tainted
    ------------------------------------------------------
    inside.sh/366 is trying to acquire lock:
    (____ptrval____) (&(&p->alloc_lock)->rlock){+.+.}, at: flush_old_exec+0x703/0x8d7

    but task is already holding lock:
    (____ptrval____) (&mm->mmap_sem){++++}, at: flush_old_exec+0x6c5/0x8d7

    which lock already depends on the new lock.

    the existing dependency chain (in reverse order) is:

    -> #1 (&mm->mmap_sem){++++}:
           [...]
           __lock_acquire+0x12ab/0x139f
           lock_acquire+0x155/0x18e
           down_write+0x3f/0x98
           flush_old_exec+0x748/0x8d7
           load_elf_binary+0x2ca/0xddb
           [...]

    -> #0 (&(&p->alloc_lock)->rlock){+.+.}:
           [...]
           __lock_acquire+0x12ab/0x139f
           lock_acquire+0x155/0x18e
           _raw_spin_lock+0x30/0x83
           flush_old_exec+0x703/0x8d7
           load_elf_binary+0x2ca/0xddb
           [...]

    other info that might help us debug this:

     Possible unsafe locking scenario:

           CPU0                    CPU1
           ----                    ----
      lock(&mm->mmap_sem);
                                   lock(&(&p->alloc_lock)->rlock);
                                   lock(&mm->mmap_sem);
      lock(&(&p->alloc_lock)->rlock);

     *** DEADLOCK ***

    2 locks held by inside.sh/366:
     #0: (____ptrval____) (&sig->cred_guard_mutex){+.+.}, at: __do_execve_file+0x12d/0x869
     #1: (____ptrval____) (&mm->mmap_sem){++++}, at: flush_old_exec+0x6c5/0x8d7

    stack backtrace:
    CPU: 0 PID: 366 Comm: inside.sh Not tainted 5.1.0-10252-gb00152307319-dirty #121
    Stack:
     [...]
    Call Trace:
     [<600420de>] show_stack+0x13b/0x155
     [<6048906b>] dump_stack+0x2a/0x2c
     [<6009ae64>] print_circular_bug+0x332/0x343
     [<6009c5c6>] check_prev_add+0x669/0xdad
     [<600a06b4>] __lock_acquire+0x12ab/0x139f
     [<6009f3d0>] lock_acquire+0x155/0x18e
     [<604a07e0>] _raw_spin_lock+0x30/0x83
     [<60151e6a>] flush_old_exec+0x703/0x8d7
     [<601a8eb8>] load_elf_binary+0x2ca/0xddb
     [...]

I think it's because in exec_mmap() we have

	down_read(&old_mm->mmap_sem);
...
        task_lock(tsk);
...
	activate_mm(active_mm, mm);
	(which does down_write(&mm->mmap_sem))

I'm not really sure why lockdep throws in the whole knowledge
about the task lock, but it seems that old_mm and mm shouldn't
ever be the same (and it doesn't deadlock) so tell lockdep that
they're different.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/include/asm/mmu_context.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index fca34b2177e2..129fb1d1f1c5 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -53,7 +53,7 @@ static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
 	 * when the new ->mm is used for the first time.
 	 */
 	__switch_mm(&new->context.id);
-	down_write(&new->mmap_sem);
+	down_write_nested(&new->mmap_sem, 1);
 	uml_setup_stubs(new);
 	up_write(&new->mmap_sem);
 }
-- 
2.20.1



