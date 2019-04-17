Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7E5C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B96206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="c09Ft3QB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbfDQOFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:05:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34645 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfDQOFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:05:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HE4e8j3932813
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:04:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HE4e8j3932813
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555509881;
        bh=ZU82v/0AFz6U8g36Dwdz5gwk0L3xOWGCdDCP6X5/T24=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=c09Ft3QBrG2mAVxphI4PdtZWYxEhqEzPx/q3vQ9q56gZxl3JwE8JfDZZs94zbLb1P
         fAlK8aEtCCDM7BSmJVDRnaDAAvIyPY8Rdw0fNCejvwMe3J08xH7Y8QKAN8V51ZfrHV
         ORAxNsE/E1uo9RJmRghhRWIyHEKLiMVa8Is3SCwDKsUAu/gXhRmLQUemRqzRBdoCei
         0UnYjd1nlp8Q77QrY6rg/nILBHgxfHjpMgHOrXcA/MUYGCJUCSbjA56Cag3IqqD/rA
         TWRvbq9O0YduZMy3sIRJ1DWQGP0B6bqT06GrA7EpMl3PpCy3WwIUXrGww9Fo7YRCbm
         FG+DSeixf/XqA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HE4dWe3932810;
        Wed, 17 Apr 2019 07:04:39 -0700
Date:   Wed, 17 Apr 2019 07:04:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-df835e7083bee33e98635aca26b39b63ebc6cca7@git.kernel.org>
Cc:     x86@kernel.org, bp@suse.de, luto@kernel.org,
        linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        nstange@suse.de, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, jpoimboe@redhat.com, mingo@kernel.org
Reply-To: jpoimboe@redhat.com, mingo@kernel.org,
          sean.j.christopherson@intel.com, mingo@redhat.com,
          nstange@suse.de, tglx@linutronix.de, hpa@zytor.com,
          x86@kernel.org, bp@suse.de, luto@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190414160143.961241397@linutronix.de>
References: <20190414160143.961241397@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/irq/64: Sanitize the top/bottom confusion
Git-Commit-ID: df835e7083bee33e98635aca26b39b63ebc6cca7
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

Commit-ID:  df835e7083bee33e98635aca26b39b63ebc6cca7
Gitweb:     https://git.kernel.org/tip/df835e7083bee33e98635aca26b39b63ebc6cca7
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 17:59:41 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 12:34:49 +0200

x86/irq/64: Sanitize the top/bottom confusion

On x86, stacks go top to bottom, but the stack overflow check uses it
the other way round, which is just confusing. Clean it up and sanitize
the warning string a bit.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160143.961241397@linutronix.de
---
 arch/x86/kernel/irq_64.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index f6dcc8fea5c0..cf200466d5c8 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -42,7 +42,7 @@ int sysctl_panic_on_stackoverflow;
 static inline void stack_overflow_check(struct pt_regs *regs)
 {
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
-#define STACK_TOP_MARGIN	128
+#define STACK_MARGIN	128
 	struct orig_ist *oist;
 	u64 irq_stack_top, irq_stack_bottom;
 	u64 estack_top, estack_bottom;
@@ -51,25 +51,25 @@ static inline void stack_overflow_check(struct pt_regs *regs)
 	if (user_mode(regs))
 		return;
 
-	if (regs->sp >= curbase + sizeof(struct pt_regs) + STACK_TOP_MARGIN &&
+	if (regs->sp >= curbase + sizeof(struct pt_regs) + STACK_MARGIN &&
 	    regs->sp <= curbase + THREAD_SIZE)
 		return;
 
-	irq_stack_bottom = (u64)__this_cpu_read(irq_stack_ptr);
-	irq_stack_top = irq_stack_bottom - IRQ_STACK_SIZE + STACK_TOP_MARGIN;
-	if (regs->sp >= irq_stack_top && regs->sp <= irq_stack_bottom)
+	irq_stack_top = (u64)__this_cpu_read(irq_stack_ptr);
+	irq_stack_bottom = irq_stack_top - IRQ_STACK_SIZE + STACK_MARGIN;
+	if (regs->sp >= irq_stack_bottom && regs->sp <= irq_stack_top)
 		return;
 
 	oist = this_cpu_ptr(&orig_ist);
-	estack_bottom = (u64)oist->ist[DEBUG_STACK];
-	estack_top = estack_bottom - DEBUG_STKSZ + STACK_TOP_MARGIN;
-	if (regs->sp >= estack_top && regs->sp <= estack_bottom)
+	estack_top = (u64)oist->ist[DEBUG_STACK];
+	estack_bottom = estack_top - DEBUG_STKSZ + STACK_MARGIN;
+	if (regs->sp >= estack_bottom && regs->sp <= estack_top)
 		return;
 
-	WARN_ONCE(1, "do_IRQ(): %s has overflown the kernel stack (cur:%Lx,sp:%lx,irq stk top-bottom:%Lx-%Lx,exception stk top-bottom:%Lx-%Lx,ip:%pF)\n",
+	WARN_ONCE(1, "do_IRQ(): %s has overflown the kernel stack (cur:%Lx,sp:%lx, irq stack:%Lx-%Lx, exception stack: %Lx-%Lx, ip:%pF)\n",
 		current->comm, curbase, regs->sp,
-		irq_stack_top, irq_stack_bottom,
-		estack_top, estack_bottom, (void *)regs->ip);
+		irq_stack_bottom, irq_stack_top,
+		estack_bottom, estack_top, (void *)regs->ip);
 
 	if (sysctl_panic_on_stackoverflow)
 		panic("low stack detected by irq handler - check messages\n");
