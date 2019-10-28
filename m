Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA028CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4B220717
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GCLVOBm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbfJ1Qew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:34:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54698 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbfJ1Qew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+PJ/cpShLksxhXNNFQzNtVO1Gbe6G/ZmOiI95RIQce8=; b=GCLVOBm/AQ5lGmzipioJfLuii
        NJIAO+hNF72A3wMGAYq+jfA+4lyjSUzTMNyZuDrJvjjlNhEup02/qtXEib006wQfw1GNe9qAnhWLG
        T1CetWl1qhf9gUa67j0CWOua8ErGUPSlVApNsPYaaBp4bp8r2qp2nK1nvJe9z1a2gB7TN62XXPk1m
        eMy6SHnjhQZNoxfB+Yoq4JNTzeYu0aXZtYDOKxG2ruBlOOakyr5VB4i+k1PK6rNRSO/wJ+sRdGSIw
        rcYxAJbdzBYjG4EQzMwv3zBAQTsOciEZOJVxmGtqvDnutDhVpoSgmAajpwf+D6hEDCQRS+bbmOl1C
        LIk8Blh+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP7yK-0007uC-JH; Mon, 28 Oct 2019 16:34:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 90DC23002B0;
        Mon, 28 Oct 2019 17:33:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E173020C4EA0B; Mon, 28 Oct 2019 17:34:21 +0100 (CET)
Date:   Mon, 28 Oct 2019 17:34:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        rabin@rab.in, Mark Rutland <mark.rutland@arm.com>,
        james.morse@arm.com
Subject: Re: [PATCH v4 13/16] arm/ftrace: Use __patch_text_real()
Message-ID: <20191028163421.GI4097@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.687479693@infradead.org>
 <20191028162525.GF5576@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028162525.GF5576@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 04:25:26PM +0000, Will Deacon wrote:
> Hi Peter,
> 
> On Fri, Oct 18, 2019 at 09:35:38AM +0200, Peter Zijlstra wrote:
> > Instead of flipping text protection, use the patch_text infrastructure
> > that uses a fixmap alias where required.
> > 
> > This removes the last user of set_all_modules_text_*().
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: ard.biesheuvel@linaro.org
> > Cc: rabin@rab.in
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: james.morse@arm.com
> > ---
> >  arch/arm/kernel/ftrace.c |   16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > --- a/arch/arm/kernel/ftrace.c
> > +++ b/arch/arm/kernel/ftrace.c
> > @@ -22,6 +22,7 @@
> >  #include <asm/ftrace.h>
> >  #include <asm/insn.h>
> >  #include <asm/set_memory.h>
> > +#include <asm/patch.h>
> >  
> >  #ifdef CONFIG_THUMB2_KERNEL
> >  #define	NOP		0xf85deb04	/* pop.w {lr} */
> > @@ -31,13 +32,15 @@
> >  
> >  #ifdef CONFIG_DYNAMIC_FTRACE
> >  
> > +static int patch_text_remap = 0;
> > +
> >  static int __ftrace_modify_code(void *data)
> >  {
> >  	int *command = data;
> >  
> > -	set_kernel_text_rw();
> > +	patch_text_remap++;
> >  	ftrace_modify_all_code(*command);
> > -	set_kernel_text_ro();
> > +	patch_text_remap--;
> >  
> >  	return 0;
> >  }
> > @@ -59,13 +62,13 @@ static unsigned long adjust_address(stru
> >  
> >  int ftrace_arch_code_modify_prepare(void)
> >  {
> > -	set_all_modules_text_rw();
> > +	patch_text_remap++;
> >  	return 0;
> >  }
> >  
> >  int ftrace_arch_code_modify_post_process(void)
> >  {
> > -	set_all_modules_text_ro();
> > +	patch_text_remap--;
> >  	/* Make sure any TLB misses during machine stop are cleared. */
> >  	flush_tlb_all();
> >  	return 0;
> > @@ -97,10 +100,7 @@ static int ftrace_modify_code(unsigned l
> >  			return -EINVAL;
> >  	}
> >  
> > -	if (probe_kernel_write((void *)pc, &new, MCOUNT_INSN_SIZE))
> > -		return -EPERM;
> > -
> > -	flush_icache_range(pc, pc + MCOUNT_INSN_SIZE);
> > +	__patch_text_real((void *)pc, new, patch_text_remap);
> 
> Why can't you just pass 'true' for patch_text_remap? AFAICT, the only
> time you want to pass false is during early boot when the text is
> assumedly still writable without the fixmap.

Ah, it will also become true for module loading once we rework where we
flip the module text RO,X. See this patch:

  https://lkml.kernel.org/r/20191018074634.858645375@infradead.org

But for that to land, there's still a few other issues to fix (KLP).
