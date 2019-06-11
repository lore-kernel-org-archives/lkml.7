Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C66C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF132080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WEQRL6Cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391851AbfFKPxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:53:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58390 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388958AbfFKPxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n6EuzMTdIJDT3nK6a2rUq5vUyQxtQQjq8okXh4kW0Vg=; b=WEQRL6CvNrWVt30j+cbpwAsr5
        WqvdnRnKsI0LOqRP76sm6Carj8ZGQv6c7bQIlyDuOsy86iYINcqIAnDaeOC4+6ZfUjGVIxmbcMjIk
        6QlNFic2mv63k95m5dhr/Nym0sg1aBvkCeH3Z16sOxFlL652D8Z7kIoCrf2g4VsLAZoctPpnP4WH9
        dG+sPiGCY4c54r1MjC9RlMwmShf1MOce6fFnZ646ADT5dK6HuQtLISppxOhvze4GnZP6M6Shu1Kim
        kQS7jwRrttIfQgyNDXtPjbnUoNRXMr3ScYS8ALcCl0xCHQmtcgC9g3A4M6Ak3J9BHW5Nl7x01uAJo
        N71/PG5bQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haj4r-0006YT-NM; Tue, 11 Jun 2019 15:52:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10A8B20240777; Tue, 11 Jun 2019 17:52:48 +0200 (CEST)
Date:   Tue, 11 Jun 2019 17:52:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
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
Subject: Re: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20190611155248.GA3436@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.005681046@infradead.org>
 <20190611111410.366f4ced@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611111410.366f4ced@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 11:14:10AM -0400, Steven Rostedt wrote:
> On Wed, 05 Jun 2019 15:08:01 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > -void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
> > +void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
> >  {
> >  	unsigned char int3 = 0xcc;
> >  
> > -	bp_int3_handler = handler;
> > +	bp_int3_opcode = emulate ?: opcode;
> >  	bp_int3_addr = (u8 *)addr + sizeof(int3);
> >  	bp_patching_in_progress = true;
> >  
> >  	lockdep_assert_held(&text_mutex);
> >  
> >  	/*
> > +	 * poke_int3_handler() relies on @opcode being a 5 byte instruction;
> > +	 * notably a JMP, CALL or NOP5_ATOMIC.
> > +	 */
> > +	BUG_ON(len != 5);
> 
> If we have a bug on here, why bother with passing in len at all? Just
> force it to be 5.

Masami said the same.

> We could make it a WARN_ON() and return without doing anything.
> 
> This also prevents us from ever changing two byte jmps.

It doesn't; that is, we'd need to add emulation for the 3 byte jump, but
that'd be pretty trivial.
