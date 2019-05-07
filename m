Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AAAC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934692053B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfEGN0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:26:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:38144 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726321AbfEGN0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:26:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7384DADF0;
        Tue,  7 May 2019 13:26:38 +0000 (UTC)
Date:   Tue, 7 May 2019 15:26:32 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rik van Riel <riel@surriel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86 FPU changes for 5.2
Message-ID: <20190507132632.GB26655@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the latest x86-fpu-for-linus tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus

This branch contains work started by Rik van Riel and brought to
fruition by Sebastian Andrzej Siewior with the main goal to optimize
when to load FPU registers: only when returning to userspace and not on
every context switch (while the task remains in the kernel).

In addition, this optimization makes kernel_fpu_begin() cheaper by
requiring registers saving only on the first invocation and skipping
that in following ones.

What is more, this series cleans up and streamlines many aspects of the
already complex FPU code, hopefully making it more palatable for future
improvements and simplifications.

Finally, there's a __user annotations fix from Jann Horn.

Thx.

---
The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus

for you to fetch changes up to d9c9ce34ed5c892323cbf5b4f9a4c498e036316a:

  x86/fpu: Fault-in user stack if copy_fpstate_to_sigframe() fails (2019-05-06 09:49:40 +0200)

----------------------------------------------------------------
Jann Horn (1):
      x86/fpu: Fix __user annotations

Rik van Riel (5):
      x86/fpu: Add an __fpregs_load_activate() internal helper
      x86/fpu: Eager switch PKRU state
      x86/fpu: Always store the registers in copy_fpstate_to_sigframe()
      x86/fpu: Prepare copy_fpstate_to_sigframe() for TIF_NEED_FPU_LOAD
      x86/fpu: Defer FPU state load until return to userspace

Sebastian Andrzej Siewior (23):
      x86/fpu: Remove fpu->initialized usage in __fpu__restore_sig()
      x86/fpu: Remove fpu__restore()
      x86/fpu: Remove preempt_disable() in fpu__clear()
      x86/fpu: Always init the state in fpu__clear()
      x86/fpu: Remove fpu->initialized usage in copy_fpstate_to_sigframe()
      x86/fpu: Don't save fxregs for ia32 frames in copy_fpstate_to_sigframe()
      x86/fpu: Remove fpu->initialized
      x86/fpu: Remove user_fpu_begin()
      x86/fpu: Make __raw_xsave_addr() use a feature number instead of mask
      x86/fpu: Use a feature number instead of mask in two more helpers
      x86/pkeys: Provide *pkru() helpers
      x86/fpu: Only write PKRU if it is different from current
      x86/pkeys: Don't check if PKRU is zero before writing it
      x86/entry: Add TIF_NEED_FPU_LOAD
      x86/fpu: Update xstate's PKRU value on write_pkru()
      x86/fpu: Inline copy_user_to_fpregs_zeroing()
      x86/fpu: Restore from kernel memory on the 64-bit path too
      x86/fpu: Merge the two code paths in __fpu__restore_sig()
      x86/fpu: Add a fastpath to __fpu__restore_sig()
      x86/fpu: Add a fastpath to copy_fpstate_to_sigframe()
      x86/fpu: Restore regs in copy_fpstate_to_sigframe() in order to use the fastpath
      x86/pkeys: Add PKRU value to init_fpstate
      x86/fpu: Fault-in user stack if copy_fpstate_to_sigframe() fails

 Documentation/preempt-locking.txt    |   1 -
 arch/x86/entry/common.c              |  10 +-
 arch/x86/ia32/ia32_signal.c          |  17 ++-
 arch/x86/include/asm/fpu/api.h       |  31 ++++++
 arch/x86/include/asm/fpu/internal.h  | 133 +++++++++++++++++------
 arch/x86/include/asm/fpu/signal.h    |   2 +-
 arch/x86/include/asm/fpu/types.h     |   9 --
 arch/x86/include/asm/fpu/xstate.h    |   8 +-
 arch/x86/include/asm/pgtable.h       |  29 ++++-
 arch/x86/include/asm/special_insns.h |  19 +++-
 arch/x86/include/asm/thread_info.h   |   2 +
 arch/x86/include/asm/trace/fpu.h     |  13 +--
 arch/x86/kernel/cpu/common.c         |   5 +
 arch/x86/kernel/fpu/core.c           | 195 ++++++++++++++++-----------------
 arch/x86/kernel/fpu/init.c           |   2 -
 arch/x86/kernel/fpu/regset.c         |  24 ++---
 arch/x86/kernel/fpu/signal.c         | 202 ++++++++++++++++++++++-------------
 arch/x86/kernel/fpu/xstate.c         |  42 ++++----
 arch/x86/kernel/process.c            |   2 +-
 arch/x86/kernel/process_32.c         |  11 +-
 arch/x86/kernel/process_64.c         |  11 +-
 arch/x86/kernel/signal.c             |  21 ++--
 arch/x86/kernel/traps.c              |   2 +-
 arch/x86/kvm/vmx/vmx.c               |   2 +-
 arch/x86/kvm/x86.c                   |  48 +++++----
 arch/x86/math-emu/fpu_entry.c        |   3 -
 arch/x86/mm/mpx.c                    |   6 +-
 arch/x86/mm/pkeys.c                  |  21 ++--
 28 files changed, 512 insertions(+), 359 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Mary Higgins, Sri Rasiah, HRB 21284 (AG Nürnberg)
