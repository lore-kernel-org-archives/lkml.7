Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC11C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F021F2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfDMUsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:48:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48379 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfDMUsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:48:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DKm23u2264995
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 13:48:02 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DKm1mr2264981;
        Sat, 13 Apr 2019 13:48:01 -0700
Date:   Sat, 13 Apr 2019 13:48:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-60e528d6ce3f60a058bbb64f8acb2a07f84b172a@git.kernel.org>
Cc:     mingo@kernel.org, mingo@redhat.com, luto@kernel.org,
        x86@kernel.org, tglx@linutronix.de, dave.hansen@intel.com,
        nstange@suse.de, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, bp@suse.de,
        rkrcmar@redhat.com, Jason@zx2c4.com, pbonzini@redhat.com,
        riel@surriel.com, kvm@vger.kernel.org
Reply-To: riel@surriel.com, kvm@vger.kernel.org, pbonzini@redhat.com,
          Jason@zx2c4.com, hpa@zytor.com, rkrcmar@redhat.com, bp@suse.de,
          bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
          nstange@suse.de, dave.hansen@intel.com, x86@kernel.org,
          tglx@linutronix.de, luto@kernel.org, mingo@kernel.org,
          mingo@redhat.com
In-Reply-To: <20190403164156.19645-4-bigeasy@linutronix.de>
References: <20190403164156.19645-4-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Remove preempt_disable() in fpu__clear()
Git-Commit-ID: 60e528d6ce3f60a058bbb64f8acb2a07f84b172a
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

Commit-ID:  60e528d6ce3f60a058bbb64f8acb2a07f84b172a
Gitweb:     https://git.kernel.org/tip/60e528d6ce3f60a058bbb64f8acb2a07f84b172a
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:32 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 9 Apr 2019 19:27:46 +0200

x86/fpu: Remove preempt_disable() in fpu__clear()

The preempt_disable() section was introduced in commit

  a10b6a16cdad8 ("x86/fpu: Make the fpu state change in fpu__clear() scheduler-atomic")

and it was said to be temporary.

fpu__initialize() initializes the FPU struct to its initial value and
then sets ->initialized to 1. The last part is the important one.
The content of the state does not matter because it gets set via
copy_init_fpstate_to_fpregs().

A preemption here has little meaning because the registers will always be
set to the same content after copy_init_fpstate_to_fpregs(). A softirq
with a kernel_fpu_begin() could also force to save FPU's registers after
fpu__initialize() without changing the outcome here.

Remove the preempt_disable() section in fpu__clear(), preemption here
does not hurt.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-4-bigeasy@linutronix.de
---
 arch/x86/kernel/fpu/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1d3ae7988f7f..1940319268ae 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -366,11 +366,9 @@ void fpu__clear(struct fpu *fpu)
 	 * Make sure fpstate is cleared and initialized.
 	 */
 	if (static_cpu_has(X86_FEATURE_FPU)) {
-		preempt_disable();
 		fpu__initialize(fpu);
 		user_fpu_begin();
 		copy_init_fpstate_to_fpregs();
-		preempt_enable();
 	}
 }
 
