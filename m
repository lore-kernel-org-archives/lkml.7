Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4861C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5792175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfDEVAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:00:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49838 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfDEVAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:00:20 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCVwe-0004eK-Hw; Fri, 05 Apr 2019 23:00:16 +0200
Date:   Fri, 5 Apr 2019 23:00:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch V2 09/29] x86/exceptions: Add structs for exception
 stacks
In-Reply-To: <20190405204838.GC15808@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1904052252150.1802@nanos.tec.linutronix.de>
References: <20190405150658.237064784@linutronix.de> <20190405150929.221851363@linutronix.de> <20190405204838.GC15808@linux.intel.com>
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

On Fri, 5 Apr 2019, Sean Christopherson wrote:
> On Fri, Apr 05, 2019 at 05:07:07PM +0200, Thomas Gleixner wrote:
> > +#ifdef CONFIG_X86_64
> > +
> > +/* Macro to enforce the same ordering and stack sizes */
> > +#define ESTACKS_MEMBERS(guardsize)		\
> > +	char	DF_stack[EXCEPTION_STKSZ];	\
> > +	char	DF_stack_guard[guardsize];	\
> > +	char	NMI_stack[EXCEPTION_STKSZ];	\
> > +	char	NMI_stack_guard[guardsize];	\
> > +	char	DB_stack[DEBUG_STKSZ];		\
> > +	char	DB_stack_guard[guardsize];	\
> > +	char	MCE_stack[EXCEPTION_STKSZ];	\
> > +	char	MCE_stack_guard[guardsize];	\
> 
> Conceptually, shouldn't the stack guard precede its associated stack
> since the stacks grow down?  And don't we want a guard page below the
> DF_stack?  There could still be a guard page above MCE_stack,
> e.g. IST_stack_guard or something.

Yes and no. :)

Defacto we have already a guard page below #DF. See struct
cpu_entry_area. And because I come from 8 bit microcontrollers, it's just
an instinct to spare/share stuff whereever its possible.

But yes, it looks a bit odd and we can reorder that and have an extra guard
page below the first stack.

> > +#define CEA_ESTACK_TOP(ceastp, st)			\
> > +	((unsigned long)&(ceastp)->st## _stack_guard)
> 
> IMO, using the stack guard to define the top of stack is unnecessarily
> confusing and fragile, e.g. reordering the names of the stack guards
> would break this macro.

For me it's obvious, obviously :)

> What about:
> 
> #define CEA_ESTACK_TOP(ceastp, st)			\
> 	(CEA_ESTACK_BOT(ceastp, st) + CEA_ESTACK_SIZE(st))

Yeah. No problem.

Thanks,

	tglx
