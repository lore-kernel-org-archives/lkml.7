Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5F5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DA22183E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfCUU07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:26:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39397 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbfCUU0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:26:55 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h74Gt-00057y-9r; Thu, 21 Mar 2019 21:26:39 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 03/24] x86/fpu: Remove preempt_disable() in fpu__clear()
Date:   Thu, 21 Mar 2019 21:26:11 +0100
Message-Id: <20190321202632.16810-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321202632.16810-1-bigeasy@linutronix.de>
References: <20190321202632.16810-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The preempt_disable() section was introduced in commit

  a10b6a16cdad8 ("x86/fpu: Make the fpu state change in fpu__clear() scheduler-atomic")

and it was said to be temporary.

fpu__initialize() initializes the FPU struct to its "init" value and
then sets ->initialized to 1. The last part is the important one.
The content of the `state' does not matter because it gets set via
copy_init_fpstate_to_fpregs().
A preemption here has little meaning because the registers will always be
set to the same content after copy_init_fpstate_to_fpregs(). A softirq
with a kernel_fpu_begin() could also force to save FPU's registers after
fpu__initialize() without changing the outcome here.

Remove the preempt_disable() section in fpu__clear(), preemption here
does not hurt.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/fpu/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1d3ae7988f7f2..1940319268aef 100644
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
 
-- 
2.20.1

