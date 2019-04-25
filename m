Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB371C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C5320811
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ggS9cc5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbfDYLkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:40:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60176 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfDYLkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i27pNU4gtFSUV+Ch6/4ivziTAQZGvDM0QL4gWkRhIeg=; b=ggS9cc5Db2P8hpZu8vCB+PHp3
        s5YMfbvMpXvVM+WdNhHA8YIDyUDmGuuQ7g08Xp6RTcTOTS52zJsMpmggWUjhB+GWLMDT21+6b+Pol
        Mrv7G9jhPKgSAQ3yIpxGMN+qvJAy9CD4iKPdO+znlNa6KlKcjHsXMSmiJ5y0nyI+bQoNQbBj73eyV
        9YPRwyjMvRSveaCNwr27QxXIFm6PwO3GpFC0WtvvCKi+0QkpWXHOCIonfxYJZZpelR+lOc/44M0og
        9fg7kA3/RuaTROT+31ciVIt63aTdOJ32YtZQZizwXwwp1Fnz1L6rPCkvxt7V02X/pkmtU+0PEub8k
        N+T5osPcg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJcjW-0002kj-RC; Thu, 25 Apr 2019 11:40:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E66F20D0A201; Thu, 25 Apr 2019 13:40:04 +0200 (CEST)
Date:   Thu, 25 Apr 2019 13:40:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: x86/paravirt: Detect over-sized patching bugs in
 paravirt_patch_call()
Message-ID: <20190425114004.GN4038@hirez.programming.kicks-ass.net>
References: <20190424134115.091452807@linutronix.de>
 <20190424134223.690835713@linutronix.de>
 <20190425065209.GA89582@gmail.com>
 <alpine.DEB.2.21.1904250921010.1762@nanos.tec.linutronix.de>
 <20190425081012.GA115378@gmail.com>
 <20190425091717.GA72229@gmail.com>
 <20190425092131.GL4038@hirez.programming.kicks-ass.net>
 <20190425095039.GC115378@gmail.com>
 <20190425102210.GM4038@hirez.programming.kicks-ass.net>
 <20190425105745.GA29840@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425105745.GA29840@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 12:57:45PM +0200, Ingo Molnar wrote:
> * Peter Zijlstra <peterz@infradead.org> wrote:
> > On Thu, Apr 25, 2019 at 11:50:39AM +0200, Ingo Molnar wrote:
> > > * Peter Zijlstra <peterz@infradead.org> wrote:
> > > > On Thu, Apr 25, 2019 at 11:17:17AM +0200, Ingo Molnar wrote:
> > > > > It basically means that we silently won't do any patching and the kernel 
> > > > > will crash later on in mysterious ways, because paravirt patching is 
> > > > > usually relied on.
> > > > 
> > > > That's OK. The compiler emits an indirect CALL/JMP to the pv_ops
> > > > structure contents. That _should_ stay valid and function correctly at
> > > > all times.
> > > 
> > > It might result in a correctly executing kernel in terms of code 
> > > generation, but it doesn't result in a viable kernel: some of the places 
> > > rely on the patching going through and don't know what to do when it 
> > > doesn't and misbehave or crash in interesting ways.
> > > 
> > > Guess how I know this. ;-)
> > 
> > What sites would that be? It really should work AFAIK.
> 
> So for example I tried to increasing the size of one of the struct 
> patch_xxl members:
> 
> --- a/arch/x86/kernel/paravirt_patch.c
> +++ b/arch/x86/kernel/paravirt_patch.c
> @@ -28,7 +28,7 @@ struct patch_xxl {
>  	const unsigned char	irq_restore_fl[2];
>  # ifdef CONFIG_X86_64
>  	const unsigned char	cpu_wbinvd[2];
> -	const unsigned char	cpu_usergs_sysret64[6];
> +	const unsigned char	cpu_usergs_sysret64[60];
>  	const unsigned char	cpu_swapgs[3];
>  	const unsigned char	mov64[3];
>  # else

So this then fails to patch the immediate; but the compiler emitted:

175:       ff 25 00 00 00 00       jmpq   *0x0(%rip)        # 17b <syscall_return_via_sysret+0x75>
		177: R_X86_64_PC32      pv_ops+0xfc

and pv_ops+0xfc is (+4 because of reloc magic):

void               (*usergs_sysret64)(void);                             /* 0x100   0x8 */

which defaults to:

arch/x86/kernel/paravirt.c:     .cpu.usergs_sysret64    = native_usergs_sysret64,

which in turn reads like:

0000000000000000 <native_usergs_sysret64>:
0:       0f 01 f8                swapgs
3:       48 0f 07                sysretq

So I _really_ don't understand how:

> Which with the vanilla kernel crashes on boot much, much later:
> 
> [    2.478026] PANIC: double fault, error_code: 0x0

happens.

> But in any case, even if many of the others will work if the patching 
> fails silently, is there any case where we'd treat patching failure as an 
> acceptable case?

It really should just work. And we need to figure out why it comes
unstuck. Can you print the code when it fails patching?

> BUG_ON() in paravirt kernels is an easily debuggable condition and beats 
> the above kinds of symptoms. But I can turn it into a WARN_ON_ONCE() if 
> you think that's better?

Not patching should be a performance issue; not a correctness issue, as
per the above. So WARN is the right thing.

