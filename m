Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DA4C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2282E2175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbfDEPM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:12:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48908 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731600AbfDEPLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:11:18 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCQUu-0005tC-3V; Fri, 05 Apr 2019 17:11:16 +0200
Message-Id: <20190405150929.847848733@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 05 Apr 2019 17:07:14 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V2 16/29] x86/cpu: Remove orig_ist array
References: <20190405150658.237064784@linutronix.de>
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
 


