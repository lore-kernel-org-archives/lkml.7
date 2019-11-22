Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7644C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADF520708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="25uOUAMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfKVUaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:30:16 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43554 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKVUaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PtSVgu7CIRpJXJj36+/AOwP4r/tfo46Mr3JkioDuRoU=; b=25uOUAMdfKB8bu5WLUBj94iHS
        tbIUTUftAlF1If/nOl8NmOZUf/LbaXj9/FL6cgE0WisyrRQHNW38ym7LGkdjWcHx0lvqqGg5uIwjc
        61HzTAM4QuD9MFdDyWdgDNt+AdGQppgpQ6zIGzOYbyq/+lhnv8fF8fHvIegRxtES6c7MrgVvTPZ/E
        0BTgdRdPDNt2i4Z7CBsI0D1xDXblqiCn4QPLEcdSjmMcT+eJRRRWkThtulJkEJ12QOSpYhTE3QE9M
        liEGPBM6Wx0prqr8b8RX6gOBm7zo0us2bjXcJDva0Yn08Fw2d5RWXdLUmS0ixB5sQ6c22tgMcbMg7
        i1rhNHhHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYFZC-0006De-I4; Fri, 22 Nov 2019 20:30:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B0AB3056C8;
        Fri, 22 Nov 2019 21:28:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10B4720321DB0; Fri, 22 Nov 2019 21:30:09 +0100 (CET)
Date:   Fri, 22 Nov 2019 21:30:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191122203009.GD2844@hirez.programming.kicks-ass.net>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com>
 <20191121173444.GA5581@agluck-desk2.amr.corp.intel.com>
 <20191122105141.GY4114@hirez.programming.kicks-ass.net>
 <20191122152715.GA1909@hirez.programming.kicks-ass.net>
 <20191122184457.GA31235@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122184457.GA31235@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 10:44:57AM -0800, Sean Christopherson wrote:
> On Fri, Nov 22, 2019 at 04:27:15PM +0100, Peter Zijlstra wrote:
> > On Fri, Nov 22, 2019 at 11:51:41AM +0100, Peter Zijlstra wrote:
> > 
> > > A non-lethal default enabled variant would be even better for them :-)
> > 
> > diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> > index d779366ce3f8..d23638a0525e 100644
> > --- a/arch/x86/include/asm/thread_info.h
> > +++ b/arch/x86/include/asm/thread_info.h
> > @@ -92,6 +92,7 @@ struct thread_info {
> >  #define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
> >  #define TIF_NOTSC		16	/* TSC is not accessible in userland */
> >  #define TIF_IA32		17	/* IA32 compatibility process */
> > +#define TIF_SLD			18	/* split_lock_detect */
> 
> Maybe use SLAC (Split-Lock AC) as the acronym?  I can't help but read
> SLD as "split-lock disabled".  And name this TIF_NOSLAC (or TIF_NOSLD if
> you don't like SLAC) since it's set when the task is running without #AC?

I'll take any other name, really. I was typing in a hurry and my
pick-a-sensible-name generator was definitely not running.

> > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > index bd2a11ca5dd6..c04476a1f970 100644
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -654,6 +654,9 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
> >  		/* Enforce MSR update to ensure consistent state */
> >  		__speculation_ctrl_update(~tifn, tifn);
> >  	}
> > +
> > +	if (tifp & _TIF_SLD)
> > +		switch_sld(prev_p);
> >  }
> 
> Re-enabling #AC when scheduling out the misbehaving task would also work
> well for KVM, e.g. call a variant of handle_user_split_lock() on an
> unhandled #AC in the guest.

Iinitially I thought having a timer to re-enable it, but this also
works. We really shouldn't be hitting this much. And any actual
occurence needs to be investigated and fixed anyway.

I've not thought much about guests, that's not really my thing. But I'll
think about it a bit :-)

> > +dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code)
> > +{
> > +	unsigned int trapnr = X86_TRAP_AC;
> > +	char str[] = "alignment check";
> > +	int signr = SIGBUS;
> > +
> > +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> > +
> > +	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) == NOTIFY_STOP)
> > +		return;
> > +
> > +	if (!handle_split_lock())
> 
> Pretty sure this should be omitted entirely. 

Yes, I just wanted to early exit the thing for !SUP_INTEL.

> For an #AC in the kernel,
> simply restarting the instruction will fault indefinitely, e.g. dieing is
> probably the best course of action if a (completely unexpteced) #AC occurs
> in "off" mode.  Dropping this check also lets handle_user_split_lock() do
> the right thing for #AC due to EFLAGS.AC=1 (pointed out by Tony).

Howveer I'd completely forgotten about EFLAGS.AC.

> > +		return;
> > +
> > +	if (!user_mode(regs))
> > +		die("Split lock detected\n", regs, error_code);
> > +
> > +	cond_local_irq_enable(regs);
> > +
> > +	if (handle_user_split_lock(regs, error_code))
> > +		return;
> > +
> > +	do_trap(X86_TRAP_AC, SIGBUS, "alignment check", regs,
> > +		error_code, BUS_ADRALN, NULL);
> > +}
