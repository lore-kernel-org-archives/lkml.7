Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A240CC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A95520673
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KVlCLhBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404772AbfFKIaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:30:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51766 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404559AbfFKIaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RBovmzIRHW1UWAnEqODhD/BnFZE9/ZwqhAOszC2dC+4=; b=KVlCLhBwIS/ACIowb+e8rlUuR
        deH+r5o0G7QQnmi+cnMUQWPNZelOfqwzshQppQXYl7SWMk2h4o9U94XD7b1l7BD14hhD9jTJ+rtDf
        0t8uTzymsMUCdPf4pZ3soOES0HNO8riOVJAunLDmX+ZVnpeiEJLCPdjvXTnkBQ4jxlOJfMLf1f2OC
        rWnRsVWFEOhaZB9OJOB2ozkbwIZz/tJSEAK3aZfWKvaIBP0UIlGwGX6nIz3FpAiLvrAlSWpD/wd+q
        OI6RvLq3S2KR4q4RxiZxV0BL81tRAh1eGqGPw/kwBoXzYzMOYFZoIghvmus4DHQJpTfqHPfcuvpdu
        oa6Kbk3xw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hac9s-0003S5-Dy; Tue, 11 Jun 2019 08:29:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 307C0202173E1; Tue, 11 Jun 2019 10:29:31 +0200 (CEST)
Date:   Tue, 11 Jun 2019 10:29:31 +0200
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
Subject: Re: [PATCH 14/15] static_call: Simple self-test module
Message-ID: <20190611082931.GR3436@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.373256296@infradead.org>
 <20190610172428.3t6laheazlz2y3br@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610172428.3t6laheazlz2y3br@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 12:24:28PM -0500, Josh Poimboeuf wrote:
> On Wed, Jun 05, 2019 at 03:08:07PM +0200, Peter Zijlstra wrote:
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  lib/Kconfig.debug      |    8 ++++++++
> >  lib/Makefile           |    1 +
> >  lib/test_static_call.c |   41 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 50 insertions(+)
> > 
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1955,6 +1955,14 @@ config TEST_STATIC_KEYS
> >  
> >  	  If unsure, say N.
> >  
> > +config TEST_STATIC_CALL
> > +	tristate "Test static call"
> > +	depends on m
> > +	help
> > +	  Test the static call interfaces.
> > +
> > +	  If unsure, say N.
> > +
> 
> Any reason why we wouldn't just make this a built-in boot time test?

None what so ever; but I did copy paste from the static_key stuff and
that has it for some rasin.
