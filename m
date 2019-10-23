Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB026CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8382E20663
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406114AbfJWNsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:48:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49458 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403782AbfJWNsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:48:01 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNGzV-0002uQ-RP; Wed, 23 Oct 2019 15:47:57 +0200
Date:   Wed, 23 Oct 2019 15:47:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [BUG -tip] kmemleak and stacktrace cause page faul
In-Reply-To: <alpine.DEB.2.21.1910231457400.2308@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1910231533180.2308@nanos.tec.linutronix.de>
References: <20191019114421.GK9698@uranus.lan> <20191022142325.GD12121@uranus.lan> <20191022145619.GE12121@uranus.lan> <alpine.DEB.2.21.1910231457400.2308@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019, Thomas Gleixner wrote:
> On Tue, 22 Oct 2019, Cyrill Gorcunov wrote:
> Ergo ep must be a valid pointer pointing to the statically allocated and
> statically initialized estack_pages array.
> 
>         /* Guard page? */
>         if (!ep->size)
> 
> How on earth can dereferencing ep crash the machine?
> 
>                 return false;
> 
> That does not make any sense.
> 
> Surely, we should not even try to decode exception stack when
> cea_exception_stacks is not yet initialized, but that does not explain
> anything what you are observing.

So looking at your actual crash:

[    0.027246] BUG: unable to handle page fault for address: 0000000000001ff0

So this derefences the stack pointer address.

[    0.082275] stk 0x1010 k 1 begin 0x0 end 0xd000 estack_pages 0xffffffff82014880 ep
0xffffffff82014888

ep is pointing correctly to estack_pages[1] which is bogus because 0x1010
is not a valid stack value, but dereferencing ep does not make it crash.

The crash farther down:

    	end = begin + (unsigned long)ep->size;

==> end = 0x2000

        regs = (struct pt_regs *)end - 1;

==> regs = 0x2000 - sizeof(struct pt_regs *) = 0x1ff0

        info->type      = ep->type;
        info->begin     = (unsigned long *)begin;
        info->end       = (unsigned long *)end;

---->	info->next_sp   = (unsigned long *)regs->sp;

	This is the crashing instruction trying to access 0x1ff0

And you are right this happens because cea_exception_stacks is not yet
initialized which makes begin = 0 and therefore point into nirvana.

So the fix is trivial.

Thanks,

	tglx

8<------------
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

