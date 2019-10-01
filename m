Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED65C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B132C20842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DS+DLd8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389245AbfJAOnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:43:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfJAOny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7XYS68JRsX31K5FNAZ0r4/kwd1UKDXQc2kjO9l53ZkQ=; b=DS+DLd8foqbMppOR2FgrfSY/c
        VNVf64l6qlMXcxd2kvJO/pgouyArI97fZZ7sYsQ31kfqbUHmfN00Kl7H2/p9OixKmaM9/Wu4avaAw
        ZP5EIznQGi7wk6xSW4olNVjNEoaKeKzpYfMc2sR5qHWTSWwHrwYmNgstn8jB4pZg8PrmKmVyMQ2HE
        MMLer0Oo8QzkZGyWotHl0nHvjLNA4HmKcaCIxfQARYEMQadcY5jho/ln0DFJ49pQWMRrSyHilYntD
        0uCHv1MQEIf0aCbySIlbz2kr6EuCSKqp+gk/FWrLi8Ydb6Su6R4ix4UceLQvyRTdBieA8oPhd0OvC
        /S6Xr9dbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFJN8-0004g6-NL; Tue, 01 Oct 2019 14:43:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E146930610C;
        Tue,  1 Oct 2019 16:42:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D96A2652AB4D; Tue,  1 Oct 2019 16:43:23 +0200 (CEST)
Date:   Tue, 1 Oct 2019 16:43:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 13/15] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20191001144323.GR4519@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.313688119@infradead.org>
 <20190610183357.zj6rwdpgw36anpfc@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610183357.zj6rwdpgw36anpfc@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 01:33:57PM -0500, Josh Poimboeuf wrote:
> On Wed, Jun 05, 2019 at 03:08:06PM +0200, Peter Zijlstra wrote:
> > --- a/arch/x86/include/asm/static_call.h
> > +++ b/arch/x86/include/asm/static_call.h
> > @@ -2,6 +2,20 @@
> >  #ifndef _ASM_STATIC_CALL_H
> >  #define _ASM_STATIC_CALL_H
> >  
> > +#include <asm/asm-offsets.h>
> > +
> > +#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
> > +
> > +/*
> > + * This trampoline is only used during boot / module init, so it's safe to use
> > + * the indirect branch without a retpoline.
> > + */
> > +#define __ARCH_STATIC_CALL_TRAMP_JMP(key, func)				\
> > +	ANNOTATE_RETPOLINE_SAFE						\
> > +	"jmpq *" __stringify(key) "+" __stringify(SC_KEY_func) "(%rip) \n"
> > +
> > +#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
> 
> I wonder if we can simplify this (and drop the indirect branch) by
> getting rid of the above cruft, and instead just use the out-of-line
> trampoline as the default for inline as well.
> 
> Then the inline case could fall back to the out-of-line implementation
> (by patching the trampoline's jmp dest) before static_call_initialized
> is set.

I think I've got that covered. I changed arch_static_call_transform() to
(always) first rewrite the trampoline and then the in-line site.

That way, when early/module crud comes in that still points at the
trampoline, it will jump to the right place.

I've not even compiled yet, but it ought to work ;-)
