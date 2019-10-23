Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58F3CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965082086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387966AbfJWSGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:06:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50500 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfJWSGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:06:00 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNL1A-0006gN-7Y; Wed, 23 Oct 2019 20:05:56 +0200
Date:   Wed, 23 Oct 2019 20:05:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/dumpstack/64: Don't evaluate exception stacks before
 setup
In-Reply-To: <20191023135943.GK12121@uranus.lan>
Message-ID: <alpine.DEB.2.21.1910231950590.1852@nanos.tec.linutronix.de>
References: <20191019114421.GK9698@uranus.lan> <20191022142325.GD12121@uranus.lan> <20191022145619.GE12121@uranus.lan> <alpine.DEB.2.21.1910231457400.2308@nanos.tec.linutronix.de> <alpine.DEB.2.21.1910231533180.2308@nanos.tec.linutronix.de>
 <20191023135943.GK12121@uranus.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cyrill reported the following crash:

  BUG: unable to handle page fault for address: 0000000000001ff0
  #PF: supervisor read access in kernel mode
  RIP: 0010:get_stack_info+0xb3/0x148

It turns out that if the stack tracer is invoked before the exception stack
mappings are initialized in_exception_stack() can erroneously classify an
invalid address as an address inside of an exception stack:

    begin = this_cpu_read(cea_exception_stacks);  <- 0
    end = begin + sizeof(exception stacks);

i.e. any address between 0 and end will be considered as exception stack
address and the subsequent code will then try to derefence the resulting
stack frame at a non mapped address.

 end = begin + (unsigned long)ep->size;
     ==> end = 0x2000

 regs = (struct pt_regs *)end - 1;
     ==> regs = 0x2000 - sizeof(struct pt_regs *) = 0x1ff0

 info->next_sp   = (unsigned long *)regs->sp;
     ==> Crashes due to accessing 0x1ff0

Prevent this by checking the validity of the cea_exception_stack base
address and bailing out if it is zero.

Fixes: afcd21dad88b ("x86/dumpstack/64: Use cpu_entry_area instead of orig_ist")
Reported-by: Cyrill Gorcunov <gorcunov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/dumpstack_64.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -94,6 +94,13 @@ static bool in_exception_stack(unsigned
 	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
 
 	begin = (unsigned long)__this_cpu_read(cea_exception_stacks);
+	/*
+	 * Handle the case where stack trace is collected _before_
+	 * cea_exception_stacks had been initialized.
+	 */
+	if (!begin)
+		return false;
+
 	end = begin + sizeof(struct cea_exception_stacks);
 	/* Bail if @stack is outside the exception stack area. */
 	if (stk < begin || stk >= end)
