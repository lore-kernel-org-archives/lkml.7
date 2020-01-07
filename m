Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E56C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37ED2075A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgAGMxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:53:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45336 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgAGMxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:53:01 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iooLg-00009S-7J; Tue, 07 Jan 2020 13:52:40 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D28C01C2CD0;
        Tue,  7 Jan 2020 13:52:39 +0100 (CET)
Date:   Tue, 07 Jan 2020 12:52:39 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Deactivate FPU state after failure during state load
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, "x86-ml" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191220195906.plk6kpmsrikvbcfn@linutronix.de>
References: <20191220195906.plk6kpmsrikvbcfn@linutronix.de>
MIME-Version: 1.0
Message-ID: <157840155965.30329.313988118654552721.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     bbc55341b9c67645d1a5471506370caf7dd4a203
Gitweb:        https://git.kernel.org/tip/bbc55341b9c67645d1a5471506370caf7dd4a203
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 20 Dec 2019 20:59:06 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 07 Jan 2020 13:44:42 +01:00

x86/fpu: Deactivate FPU state after failure during state load

In __fpu__restore_sig(), fpu_fpregs_owner_ctx needs to be reset if the
FPU state was not fully restored. Otherwise the following may happen (on
the same CPU):

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

In the success case, fpu_fpregs_owner_ctx is set to the current task.

In the failure case, the FPU state might have been modified by loading
the init state.

In this case, fpu_fpregs_owner_ctx needs to be reset in order to ensure
that the FPU state of the following task is loaded from saved state (and
not skipped because it was the previous state).

Reset fpu_fpregs_owner_ctx after a failure during restore occurred, to
ensure that the FPU state for the next task is always loaded.

The problem was debugged-by Yu-cheng Yu <yu-cheng.yu@intel.com>.

 [ bp: Massage commit message. ]

Fixes: 5f409e20b7945 ("x86/fpu: Defer FPU state load until return to userspace")
Reported-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191220195906.plk6kpmsrikvbcfn@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 0071b79..400a05e 100644
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
