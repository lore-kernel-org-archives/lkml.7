Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57613C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E7D20838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564645065;
	bh=sOf2S0CiEG1ZaH20+DYy2OtudWMWVUNo515WBoje4Fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DBcj6jwqG2NModkyZmtKkfmC9Df/37d0nfkUabj0ZnSTFTskfU1Q3dAi4d/0L/MGg
	 lQkyDpI3uwubDO7RkAsR/hN2mfWFCqbktlbPQz6N34DqWnZzaANiV8g5EvPppzQ8ST
	 3LancfHEmybYG0A8ozpRTA6PAVjIDVRVEFFXQjmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfHAHho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:37:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfHAHhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:37:43 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C46EC206B8;
        Thu,  1 Aug 2019 07:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564645062;
        bh=sOf2S0CiEG1ZaH20+DYy2OtudWMWVUNo515WBoje4Fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qB1YTh06fJbasGpBvg62Fur5l+pTa927ewmGW+JK8xFgsz+l9oKu1NCXMvhNd9pz/
         cUdBcq5fI/kp2K6UnIHMSqIloQX1CvMe/pi0G3KpyMW51Sozf4tWn4lpqFX7tjqQgZ
         EpuvgXEoCiN5JGif8mykFQQyloj4Ehxz2JijKmS4=
Date:   Thu, 1 Aug 2019 08:37:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dan Rue <dan.rue@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org, Matt Hart <matthew.hart@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] arm64: Make debug exception handlers visible from
 RCU
Message-ID: <20190801073737.wrhespf5xh3qudil@willie-the-truck>
References: <156404254387.2020.886452004489353899.stgit@devnote2>
 <156404257493.2020.7940525305482369976.stgit@devnote2>
 <20190731172602.36hdk3yb3w6uihbu@willie-the-truck>
 <20190801143225.e61e38ce7a701407b19f8008@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801143225.e61e38ce7a701407b19f8008@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Thu, Aug 01, 2019 at 02:32:25PM +0900, Masami Hiramatsu wrote:
> On Wed, 31 Jul 2019 18:26:03 +0100
> Will Deacon <will@kernel.org> wrote:
> > On Thu, Jul 25, 2019 at 05:16:15PM +0900, Masami Hiramatsu wrote:
> > > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > > index 9568c116ac7f..ed6c55c87fdc 100644
> > > --- a/arch/arm64/mm/fault.c
> > > +++ b/arch/arm64/mm/fault.c
> > > @@ -777,6 +777,42 @@ void __init hook_debug_fault_code(int nr,
> > >  	debug_fault_info[nr].name	= name;
> > >  }
> > >  
> > > +/*
> > > + * In debug exception context, we explicitly disable preemption.
> > 
> > Maybe add "despite having interrupts disabled"?
> 
> OK, I'll add it.
> 
> > > + * This serves two purposes: it makes it much less likely that we would
> > > + * accidentally schedule in exception context and it will force a warning
> > > + * if we somehow manage to schedule by accident.
> > > + */
> > > +static void debug_exception_enter(struct pt_regs *regs)
> > > +{
> > > +	if (user_mode(regs)) {
> > > +		RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> > > +	} else {
> > > +		/*
> > > +		 * We might have interrupted pretty much anything.  In
> > > +		 * fact, if we're a debug exception, we can even interrupt
> > > +		 * NMI processing. We don't want this code makes in_nmi()
> > > +		 * to return true, but we need to notify RCU.
> > > +		 */
> > > +		rcu_nmi_enter();
> > > +	}
> > > +
> > > +	preempt_disable();
> > 
> > If you're addingt new functions for entry/exit, maybe move the
> > trace_hardirqs_{on,off}() calls in here too?
> 
> OK, let's move it in these functions.

Brill, thanks. Please just resend this patch, as I can pick the other three
up as they are.

Will
