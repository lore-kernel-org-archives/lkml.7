Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0082DC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2992133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S/F5cs9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfFGI3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:29:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47742 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbfFGI3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pEikf0lz/+ehFxWTVsFBoEGGzwbfmWwbxDox14l2d24=; b=S/F5cs9mR+CktwIhwbiymklHgM
        bpALiLdQ6Snh7vv4Xw460zXM6KnF3D9kRw5/BivR7MKsgB/jAc28kA/qMIUIzhjL2PxTw/LFy2Jaj
        WR+SGfRCWmaAM4S+zgbQTyjmX8eYyIXKmApOLzpG3XxJhLTpteWUKSERMmNNv8MKfLHw7MdQ9IOC1
        KsSfJyHKSJhdGXbo+Z7U9vtA6X7ExIWk7HYT4izPT2vr09aTNiy+TGTgbQ47yA1TmCjQp62eOfK5r
        vqpwgZpwifudO5M5Oe3eo5OWDgIBp/pKG3kI0kIUMxTAQPwD0pbY8MnZ7XsCRg/DpD3GQFff5x8FM
        1I1HJ6Lw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZAF3-0006VS-8o; Fri, 07 Jun 2019 08:28:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B068620973565; Fri,  7 Jun 2019 10:28:51 +0200 (CEST)
Date:   Fri, 7 Jun 2019 10:28:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 10/15] static_call: Add basic static call infrastructure
Message-ID: <20190607082851.GV3419@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.125037517@infradead.org>
 <DD54886F-77C6-4230-A711-BF10DD44C52C@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DD54886F-77C6-4230-A711-BF10DD44C52C@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:44:23PM +0000, Nadav Amit wrote:
> > + * Usage example:
> > + *
> > + *   # Start with the following functions (with identical prototypes):
> > + *   int func_a(int arg1, int arg2);
> > + *   int func_b(int arg1, int arg2);
> > + *
> > + *   # Define a 'my_key' reference, associated with func_a() by default
> > + *   DEFINE_STATIC_CALL(my_key, func_a);
> > + *
> > + *   # Call func_a()
> > + *   static_call(my_key, arg1, arg2);
> > + *
> > + *   # Update 'my_key' to point to func_b()
> > + *   static_call_update(my_key, func_b);
> > + *
> > + *   # Call func_b()
> > + *   static_call(my_key, arg1, arg2);
> 
> I think that this calling interface is not very intuitive.

Yeah, it is somewhat unfortunate..

> I understand that
> the macros/objtool cannot allow the calling interface to be completely
> transparent (as compiler plugin could). But, can the macros be used to
> paste the key with the “static_call”? I think that having something like:
> 
>   static_call__func(arg1, arg2)
> 
> Is more readable than
> 
>   static_call(func, arg1, arg2)

Doesn't really make it much better for me; I think I'd prefer to switch
to the GCC plugin scheme over this.  ISTR there being some propotypes
there, but I couldn't quickly locate them.

> > +}
> > +
> > +#define static_call_update(key, func)					\
> > +({									\
> > +	BUILD_BUG_ON(!__same_type(func, STATIC_CALL_TRAMP(key)));	\
> > +	__static_call_update(&key, func);				\
> > +})
> 
> Is this safe against concurrent module removal?

It is for CONFIG_MODULE=n :-)
