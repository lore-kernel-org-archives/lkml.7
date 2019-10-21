Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9622CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887AE205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WLB/R7g9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfJUJ0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:26:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54230 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfJUJ0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nz7XHn8Wn9vHGJEsHV8wPOEtsgrcQZ+NF/vEwprloJM=; b=WLB/R7g9wGR4sSGezk+xFo+vB
        qNo7wsxEmKtjxu5txmX6UJzmR3yRmLcNUXM914HztSHzfgBpmNpf4judsTy3/r4wV3qEI8kWuu4TT
        2pBiy63Z4Hut0AS5yfueZASN48g6z9iV5rR6zFsVtijo2TUUEEv7eQihEyqIPjYIzN//fG4rm/HDe
        Wj/vqVnwb8D/LHiwoR/4a6On5KNWDBX+0YTZv3Oa8Yl2OwVKibPNQwFB+jxZ02amU00Ggwp6MSXYh
        4CiNBoH+8guh5j8HOcNJ9cb8ZnWlBRHOUGL+rkll1ZhXfW/CrF5t9AXlqJOfy9dP5kowmj/PTLd1V
        Dleff4O8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMTwv-0001Nc-K9; Mon, 21 Oct 2019 09:26:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C8EA2301124;
        Mon, 21 Oct 2019 11:25:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D72662022BA0B; Mon, 21 Oct 2019 11:25:59 +0200 (CEST)
Date:   Mon, 21 Oct 2019 11:25:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v4 10/16] x86/alternative: Shrink text_poke_loc
Message-ID: <20191021092559.GB1800@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.514629541@infradead.org>
 <20191021090104.GB102207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021090104.GB102207@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 11:01:04AM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Employ the fact that all text must be within a s32 displacement of one
> > another to shrink the text_poke_loc::addr field. Make it relative to
> > _stext.
> > 
> > This then shrinks struct text_poke_loc to 16 bytes, and consequently
> > increases TP_VEC_MAX from 170 to 256.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/kernel/alternative.c |   23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> > 
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -937,7 +937,7 @@ static void do_sync_core(void *info)
> >  }
> >  
> >  struct text_poke_loc {
> > -	void *addr;
> > +	s32 rel_addr; /* addr := _stext + rel_addr */
> >  	s32 rel32;
> >  	u8 opcode;
> >  	const u8 text[POKE_MAX_OPCODE_SIZE];
> > @@ -948,13 +948,18 @@ static struct bp_patching_desc {
> >  	int nr_entries;
> >  } bp_patching;
> >  
> > +static inline void *text_poke_addr(struct text_poke_loc *tp)
> > +{
> > +	return _stext + tp->rel_addr;
> > +}
> 
> So won't this complicate the life of the big-address-space gcc model 
> build patches that for purposes of module randomization are spreading the 
> kernel and modules all across the 64-bit address space, where they might 
> not necessarily end up within a ~2GB window?
> 
> Nothing upstream yet, but I remember such patches ...

IIRC what they were doing was allow moving the 2G range further out into
the address space, such that absolute addresses no longer fit in u32 (as
they do now), but they keep the relative displacement in s32. Otherwise
we'll end up with PLT entries all over the place. That is, if we break
the s32 displacement, CALL/JMP.d32 will not longer be able to reach any
other code and we need intermediate trampolines to help them along,
which is pretty shit.
