Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FD4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EED206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iYbb7/OF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfCHTuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:50:35 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36732 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfCHTuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HDfcrrP6sA7jSKj7oyd2/tQrQUo4ZX+mc23i7Oikto8=; b=iYbb7/OFbXcUnC4E8JvuYDGZj
        YQvkJbcfL7AOUsMQIeGEZ4V+EQxwQ7J7CaP0XtndH+YLyuFlQD1CbMNeWfQDNYBAXKhQwydafcZND
        T98zOpciPNUPEpQXOhW7pf4XHYZJ02N1l3c9QZJTXTuS/430nHAHOjyRpVlL9A4ga+TWRoPjlwImA
        nrTPmnau8cuiBRA+1N/sI4sxTJfey7un0d7VsSUGWasMSZ0MPsmto/j0uqPZXhiRc/HMSJCtras0t
        rZ6Dqzy+KHA+zpJogxpALdXWlpAGrT97gNesvQhCGryfLcb0mJ5kz5zfYdDvYB7CZZRYT5uNH6CZk
        Dgg1ZWLyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2LVW-0001U8-1z; Fri, 08 Mar 2019 19:50:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A81A201C0B06; Fri,  8 Mar 2019 20:50:12 +0100 (CET)
Date:   Fri, 8 Mar 2019 20:50:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org, andrew.cooper3@citrix.com
Subject: Re: [PATCH 05/20] x86/uaccess/xen: Suppress SMAP warnings
Message-ID: <20190308195012.GE32494@hirez.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115159.530608243@infradead.org>
 <20190308190038.ehrczmqnoulfkuoe@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308190038.ehrczmqnoulfkuoe@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 01:00:38PM -0600, Josh Poimboeuf wrote:
> On Thu, Mar 07, 2019 at 12:45:16PM +0100, Peter Zijlstra wrote:
> > drivers/xen/privcmd.o: warning: objtool: privcmd_ioctl()+0x1414: call to hypercall_page() with UACCESS enabled
> > 
> > Xen needs to do HV calls with AC=1 for hysterical raisins. Make the
> > warning go away.
> > 
> > XXX: arguably we should rename ANNOTATE_NOSPEC_ALTERNATIVE to
> >      ANNOTATE_IGNORE_ALTERNATIVE.
> > 
> > Cc: andrew.cooper3@citrix.com
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/include/asm/xen/hypercall.h |   26 ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> > 
> > --- a/arch/x86/include/asm/xen/hypercall.h
> > +++ b/arch/x86/include/asm/xen/hypercall.h
> > @@ -214,6 +214,24 @@ xen_single_call(unsigned int call,
> >  	return (long)__res;
> >  }
> >  
> > +static __always_inline void __xen_stac(void)
> > +{
> > +	/*
> > +	 * This is just about as horrible as this interface; we abuse the
> > +	 * nospec alternative annotation to supress objtool seeing the
> > +	 * STAC/CLAC and getting confused about it calling random code with
> > +	 * AC=1.
> > +	 */
> > +	asm volatile(ANNOTATE_NOSPEC_ALTERNATIVE
> > +		     ASM_STAC ::: "memory", "flags");
> > +}
> > +
> > +static __always_inline void __xen_clac(void)
> > +{
> > +	asm volatile(ANNOTATE_NOSPEC_ALTERNATIVE
> > +		     ASM_CLAC ::: "memory", "flags");
> > +}
> > +
> 
> Shouldn't these be using SMAP-based alternatives like stac()/clac() do?

They are, __ASM_{ST,CL}AC are the raw instructions ASM_{ST,CL}AC are the
alternatives.
