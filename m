Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87CBC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817192084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfDNQCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:02:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43291 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfDNQCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:02:49 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFhag-0002ez-MW; Sun, 14 Apr 2019 18:02:47 +0200
Message-Id: <20190414160145.151435667@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 14 Apr 2019 17:59:54 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V3 18/32] x86/cpu: Remove orig_ist array
References: <20190414155936.679808307@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users gone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h |    9 ---------
 arch/x86/kernel/cpu/common.c     |    6 ------
 2 files changed, 15 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -374,16 +374,7 @@ DECLARE_PER_CPU(unsigned long, cpu_curre
 #define cpu_current_top_of_stack cpu_tss_rw.x86_tss.sp1
 #endif
 
-/*
- * Save the original ist values for checking stack pointers during debugging
- */
-struct orig_ist {
-	unsigned long		ist[7];
-};
-
 #ifdef CONFIG_X86_64
-DECLARE_PER_CPU(struct orig_ist, orig_ist);
-
 union irq_stack_union {
 	char irq_stack[IRQ_STACK_SIZE];
 	/*
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1549,12 +1549,6 @@ void syscall_init(void)
 	       X86_EFLAGS_IOPL|X86_EFLAGS_AC|X86_EFLAGS_NT);
 }
 
-/*
- * Copies of the original ist values from the tss are only accessed during
- * debugging, no special alignment required.
- */
-DEFINE_PER_CPU(struct orig_ist, orig_ist);
-
 static DEFINE_PER_CPU(unsigned long, debug_stack_addr);
 DEFINE_PER_CPU(int, debug_stack_usage);
 


