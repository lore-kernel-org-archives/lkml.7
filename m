Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2971AC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F247E206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fs9PDWsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfJJOF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:05:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38186 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfJJOF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HJMGdIDUdqLVB8qB2dHYqoNPThFa3sgfwA+s8un0WcY=; b=Fs9PDWsAxkehwhcU+Ti/MUQD/
        ekjV9O6rcSKqtxEMU7oKyYOCFTVpGRDf1ZPMuNpZSfbhNZCM2saoVQ4Ds3vVgxByZSXBovof6gK/N
        nfSd7z9A/bFSO11guf7om2NJ/4kd62RpoHejk33XI1K9Ok5TnPDdy/BfhescQ7VlTvDPSfOdhjwMl
        scGT852MF+OMcWlg1epmnMBBAvYHRQSUIV6jdyylD0Nqo+EMHZTkT/FsOeNsqanNotKBRYPxWh2m8
        dZioEXAZoe7tcOslHEyHAOm5HUFT7eHjfxkhkUS7wMDwpdb4gR60MXLv38xHNnVSVSnWMMqiND70h
        1zxMHSRmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIZ48-00072M-CE; Thu, 10 Oct 2019 14:05:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39855301224;
        Thu, 10 Oct 2019 16:04:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 41952202F4F4F; Thu, 10 Oct 2019 16:05:13 +0200 (CEST)
Date:   Thu, 10 Oct 2019 16:05:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191010140513.GT2311@hirez.programming.kicks-ass.net>
References: <20191007081716.07616230.8@infradead.org>
 <20191007081945.10951536.8@infradead.org>
 <20191008104335.6fcd78c9@gandalf.local.home>
 <20191009224135.2dcf7767@oasis.local.home>
 <20191010092054.GR2311@hirez.programming.kicks-ass.net>
 <20191010091956.48fbcf42@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010091956.48fbcf42@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 09:19:56AM -0400, Steven Rostedt wrote:
> On Thu, 10 Oct 2019 11:20:54 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Oct 09, 2019 at 10:41:35PM -0400, Steven Rostedt wrote:
> > > On Tue, 8 Oct 2019 10:43:35 -0400
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > >   
> > > > BTW, I'd really like to take this patch series through my tree. That
> > > > way I can really hammer it, as well as I have code that will be built
> > > > on top of it.  
> > > 
> > > I did a bit of hammering and found two bugs. One I sent a patch to fix
> > > (adding a module when tracing is enabled), but the other bug I
> > > triggered, I'm too tired to debug right now. But figured I'd mention it
> > > anyway.  
> > 
> > I'm thinking this should fix it... Just not sure this is the right plce,
> > then again, we're doing the same thing in jump_label and static_call, so
> > perhaps we should do it like this.
> > 
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -1230,10 +1230,15 @@ void text_poke_queue(void *addr, const v
> >   * dynamically allocated memory. This function should be used when it is
> >   * not possible to allocate memory.
> >   */
> > -void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
> > +void __ref text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
> >  {
> >  	struct text_poke_loc tp;
> >  
> > +	if (unlikely(system_state == SYSTEM_BOOTING)) {
> > +		text_poke_early(addr, opcode, len);
> > +		return;
> > +	}
> 
> We need a new system state. SYSTEM_UP ? (Arg, that name is confusing,
> SYSTEM_BOOTING_SMP?) Or perhaps just test num_online_cpus()?
> 
> 	if (unlikely(system_state == SYSTEM_BOOTING &&
> 		     num_online_cpus() == 1)
> 
> ?
> 
> Because we can't do the above once we have more than one CPU running.

We loose BOOTING _long_ before we gain SMP.
