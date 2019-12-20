Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC16C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB56E2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfLTT7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:59:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34151 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfLTT7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:59:14 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iiOQU-00081G-OF; Fri, 20 Dec 2019 20:59:06 +0100
Date:   Fri, 20 Dec 2019 20:59:06 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] x86/fpu: Deacticate FPU state after failure during state load
Message-ID: <20191220195906.plk6kpmsrikvbcfn@linutronix.de>
References: <20191212210855.19260-1-yu-cheng.yu@intel.com>
 <20191212210855.19260-4-yu-cheng.yu@intel.com>
 <20191218155449.sk4gjabtynh67jqb@linutronix.de>
 <587463c4e5fa82dff8748e5f753890ac390e993e.camel@intel.com>
 <20191219142217.axgpqlb7zzluoxnf@linutronix.de>
 <19a94f88f1bc66bb81dbf5dd72083d03ca5090e9.camel@intel.com>
 <20191219171635.phdsfkvsyazwaq7s@linutronix.de>
 <1607597639a6c6255127fef07704ee9193e33166.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1607597639a6c6255127fef07704ee9193e33166.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __fpu__restore_sig() we need to reset `fpu_fpregs_owner_ctx' if the
FPU state was not fully restored. Otherwise the following may happen
(on the same CPU):

Task A                     Task B               fpu_fpregs_owner_ctx
*active*                                        A.fpu
__fpu__restore_sig()
                           ctx switch           load B.fpu
                           *active*             B.fpu
fpregs_lock()
copy_user_to_fpregs_zeroing()
  copy_kernel_to_xregs() *modify*
  copy_user_to_xregs() *fails*
fpregs_unlock()
                          ctx switch            skip loading B.fpu,
                          *active*              B.fpu

In the succeess case we set `fpu_fpregs_owner_ctx' to the current task.
In the failure case we *might* have modified the FPU state because we
loaded the init state. In this case we need to reset
`fpu_fpregs_owner_ctx' to ensure that the FPU state of the following
task is loaded from saved state (and not skip because it was the
previous state).

Reset `fpu_fpregs_owner_ctx' after a failure during restore occured to
ensure that the FPU state for the next task is always loaded.

Fixes: 5f409e20b7945 ("x86/fpu: Defer FPU state load until return to userspace")
Reported-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Debugged-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 0071b794ed193..400a05e1c1c51 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -352,6 +352,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			fpregs_unlock();
 			return 0;
 		}
+		fpregs_deactivate(fpu);
 		fpregs_unlock();
 	}
 
@@ -403,6 +404,8 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	}
 	if (!ret)
 		fpregs_mark_activate();
+	else
+		fpregs_deactivate(fpu);
 	fpregs_unlock();
 
 err_out:
-- 
2.24.1

