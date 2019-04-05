Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ACCC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D6621852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbfDEPLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:11:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48840 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731452AbfDEPLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:11:09 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCQUl-0005rD-AH; Fri, 05 Apr 2019 17:11:07 +0200
Message-Id: <20190405150928.863947812@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 05 Apr 2019 17:07:03 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V2 05/29] x86/idt: Remove unused macro SISTG
References: <20190405150658.237064784@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d8ba61ba58c8 ("x86/entry/64: Don't use IST entry for #BP stack")
removed the last user but left the macro around.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/idt.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -45,10 +45,6 @@ struct idt_data {
 #define ISTG(_vector, _addr, _ist)			\
 	G(_vector, _addr, _ist, GATE_INTERRUPT, DPL0, __KERNEL_CS)
 
-/* System interrupt gate with interrupt stack */
-#define SISTG(_vector, _addr, _ist)			\
-	G(_vector, _addr, _ist, GATE_INTERRUPT, DPL3, __KERNEL_CS)
-
 /* Task gate */
 #define TSKG(_vector, _gdt)				\
 	G(_vector, NULL, DEFAULT_STACK, GATE_TASK, DPL0, _gdt << 3)


