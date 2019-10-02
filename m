Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AD2C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C467C21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hw0oCQP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfJBNyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:54:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfJBNyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I+rlKx0E0VhGVcz2gnhriX/DpMY+Lt7Foh8DXUD24cY=; b=hw0oCQP24Wyb5uZtrQUsgbMSvH
        wvvHSo034IiKeD9YUDPBbW8TiWSQ9cKvlP8BktvvqGt6iW6mSz73TyMv2xwDNtZW26KrMaxzbLTHU
        qMdoQiCJGR0c+Wfv39w0EkwCfp7hOkQo7DmgFP697dzP7qdxpq9Bc2n0JAy9r9rMn7f2cYLN/ZWfI
        Nt7zHk72qQ/IbTr1QWm1pf4A0Zig3vpdQVym7PmzrpWuP2jDOxRfR8Lud6BCvJkUVn1iU1tl9z18i
        t6WITzU6xXhbx9pw5uQXybdFduZSHTQirbkfRRTukyCIWTttEnPjW1LGeIWGF8KFvq1G4o8WSinqJ
        JjYC5T0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFf5A-0000ia-FY; Wed, 02 Oct 2019 13:54:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6362C304B4C;
        Wed,  2 Oct 2019 15:53:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32BBA29CB4B64; Wed,  2 Oct 2019 15:54:17 +0200 (CEST)
Date:   Wed, 2 Oct 2019 15:54:17 +0200
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
Message-ID: <20191002135417.GS4519@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.125037517@infradead.org>
 <DD54886F-77C6-4230-A711-BF10DD44C52C@vmware.com>
 <20190607082851.GV3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190607082851.GV3419@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:28:51AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 06, 2019 at 10:44:23PM +0000, Nadav Amit wrote:
> > > + * Usage example:
> > > + *
> > > + *   # Start with the following functions (with identical prototypes):
> > > + *   int func_a(int arg1, int arg2);
> > > + *   int func_b(int arg1, int arg2);
> > > + *
> > > + *   # Define a 'my_key' reference, associated with func_a() by default
> > > + *   DEFINE_STATIC_CALL(my_key, func_a);
> > > + *
> > > + *   # Call func_a()
> > > + *   static_call(my_key, arg1, arg2);
> > > + *
> > > + *   # Update 'my_key' to point to func_b()
> > > + *   static_call_update(my_key, func_b);
> > > + *
> > > + *   # Call func_b()
> > > + *   static_call(my_key, arg1, arg2);
> > 
> > I think that this calling interface is not very intuitive.
> 
> Yeah, it is somewhat unfortunate..
> 
> > I understand that
> > the macros/objtool cannot allow the calling interface to be completely
> > transparent (as compiler plugin could). But, can the macros be used to
> > paste the key with the “static_call”? I think that having something like:
> > 
> >   static_call__func(arg1, arg2)
> > 
> > Is more readable than
> > 
> >   static_call(func, arg1, arg2)
> 
> Doesn't really make it much better for me; I think I'd prefer to switch
> to the GCC plugin scheme over this.  ISTR there being some propotypes
> there, but I couldn't quickly locate them.

How about something like:

	static_call(key)(arg1, arg2);

which is very close to the regular indirect call syntax. Furthermore,
how about we put the trampolines in .static_call.text instead of relying
on prefixes?

Also, I think I can shrink static_call_key by half:

 - we can do away with static_call_key::tramp; there are only two usage
   sites:

     o __static_call_update, the static_call() macro can provide the
       address of STATIC_CALL_TRAMP(key) directly

     o static_call_add_module(), has two cases:

       * the trampoline is from outside the module; in this case
         it will already have been updated by a previous call to
	 __static_call_update.
       * the trampoline is from inside the module; in this case
         it will have the default value and it doesn't need an
	 update.

       so in no case does static_call_add_module() need to modify a
       trampoline.

  - we can change static_call_key::site_mods into a single next pointer,
    just like jump_label's static_key.

But so far all the schemes I've come up with require 'key' to be a name,
it cannot be an actual 'struct static_call_key *' value. And therefore
usage from within structures isn't allowed.


