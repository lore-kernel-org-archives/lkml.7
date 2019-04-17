Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0FDC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49EC21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UAUB5Ort"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbfDQOCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:02:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41447 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbfDQOCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:02:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HE2QEK3930805
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:02:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HE2QEK3930805
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555509746;
        bh=ioEnpzsmtY4lHaW23ea0rdzCceY3etrElCrxJOJL1uk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=UAUB5OrtTWHMNH2qJb+bYsWbimCe36LvypO5RXpSit2fcDiWbfPxJ3A3G5x3GPKWr
         FKQqcQVoCyBOfkn/ILHIdY7daEUlpJfPTiQay4Xz4E2YI7xDbUxr8IyGrrZ9+v+BD0
         MBkgkugIhAJuBrokF73J3769wmawT6nXXmtStIdjmp0OY00jqbEBBSaSEycq7wK50e
         6gFrzeu4Vdn1GR7H21GCxxVLR8IVKYuU1fd9B4lkBdY9/kl8Pi9FJ0aD3e4XrK7F/4
         ZEZZDE8O533QG/1tlwnWPg9PVPS2hylJiwG7iU1EIgnMLbG0pYKjsTnuib43I4RyBu
         BiJqb0qIfHH1A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HE2PA83930800;
        Wed, 17 Apr 2019 07:02:25 -0700
Date:   Wed, 17 Apr 2019 07:02:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-7dbcf2b0b770eeb803a416ee8dcbef78e6389d40@git.kernel.org>
Cc:     luto@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        tglx@linutronix.de, sean.j.christopherson@intel.com,
        nstange@suse.de, bp@suse.de, mitsuo.hayasaka.hu@hitachi.com,
        x86@kernel.org, hpa@zytor.com, mingo@kernel.org, mingo@redhat.com
Reply-To: jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
          luto@kernel.org, sean.j.christopherson@intel.com,
          tglx@linutronix.de, nstange@suse.de,
          mitsuo.hayasaka.hu@hitachi.com, bp@suse.de, x86@kernel.org,
          mingo@redhat.com, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20190414160143.682135110@linutronix.de>
References: <20190414160143.682135110@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/irq/64: Limit IST stack overflow check to #DB
 stack
Git-Commit-ID: 7dbcf2b0b770eeb803a416ee8dcbef78e6389d40
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

Commit-ID:  7dbcf2b0b770eeb803a416ee8dcbef78e6389d40
Gitweb:     https://git.kernel.org/tip/7dbcf2b0b770eeb803a416ee8dcbef78e6389d40
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 17:59:38 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 12:06:56 +0200

x86/irq/64: Limit IST stack overflow check to #DB stack

Commit

  37fe6a42b343 ("x86: Check stack overflow in detail")

added a broad check for the full exception stack area, i.e. it considers
the full exception stack area as valid.

That's wrong in two aspects:

 1) It does not check the individual areas one by one

 2) #DF, NMI and #MCE are not enabling interrupts which means that a
    regular device interrupt cannot happen in their context. In fact if a
    device interrupt hits one of those IST stacks that's a bug because some
    code path enabled interrupts while handling the exception.

Limit the check to the #DB stack and consider all other IST stacks as
'overflow' or invalid.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Mitsuo Hayasaka <mitsuo.hayasaka.hu@hitachi.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160143.682135110@linutronix.de
---
 arch/x86/kernel/irq_64.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index 0469cd078db1..b50ac9c7397b 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -26,9 +26,18 @@ int sysctl_panic_on_stackoverflow;
 /*
  * Probabilistic stack overflow check:
  *
- * Only check the stack in process context, because everything else
- * runs on the big interrupt stacks. Checking reliably is too expensive,
- * so we just check from interrupts.
+ * Regular device interrupts can enter on the following stacks:
+ *
+ * - User stack
+ *
+ * - Kernel task stack
+ *
+ * - Interrupt stack if a device driver reenables interrupts
+ *   which should only happen in really old drivers.
+ *
+ * - Debug IST stack
+ *
+ * All other contexts are invalid.
  */
 static inline void stack_overflow_check(struct pt_regs *regs)
 {
@@ -53,8 +62,8 @@ static inline void stack_overflow_check(struct pt_regs *regs)
 		return;
 
 	oist = this_cpu_ptr(&orig_ist);
-	estack_top = (u64)oist->ist[0] - EXCEPTION_STKSZ + STACK_TOP_MARGIN;
-	estack_bottom = (u64)oist->ist[N_EXCEPTION_STACKS - 1];
+	estack_bottom = (u64)oist->ist[DEBUG_STACK];
+	estack_top = estack_bottom - DEBUG_STKSZ + STACK_TOP_MARGIN;
 	if (regs->sp >= estack_top && regs->sp <= estack_bottom)
 		return;
 
