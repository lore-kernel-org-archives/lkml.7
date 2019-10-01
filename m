Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F77C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA9D20700
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IvKL0V3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbfJAMBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:01:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60590 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfJAMBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LKr1dzgOhzScC3c310Ljy2SZqBkMLUgSVZmu3N0da8g=; b=IvKL0V3MvVcllb7C/EJZnXh0E0
        9tkkl0R8F+nCHkI/+Gv4GE/IDRgB5UH7bGvA/lUTmtZ29BhxDGndMxcnvSHuEusEIaVBnt7W6jwKs
        pE79SCg/WkMK8NlnBBdE65s7/dcW6Nc9+VGdiFu9kRTZb0e7fPJ8O83UVIefcQ1CnDmQ0i7iZyt02
        fGI5A8SWsPUKVUu+pSNyyy81/9BcKY3s7ioNyUlbCXBFL17We9QlrO/jER9y8Aogx1+vg6KEK+bAm
        aUeXMZNFRyY/5YtJh7D5yQW/aX68lK1FUm5RCv4H8R7wFilOprU7HfJkHJUO4cFjahab+U+cdKpw2
        weOLj7sg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFGpP-00061z-9X; Tue, 01 Oct 2019 12:00:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6300C30477A;
        Tue,  1 Oct 2019 13:59:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3DE8202CF69B; Tue,  1 Oct 2019 14:00:23 +0200 (CEST)
Date:   Tue, 1 Oct 2019 14:00:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nadav Amit <namit@vmware.com>,
        the arch/x86 maintainers <x86@kernel.org>,
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
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 11/15] static_call: Add inline static call infrastructure
Message-ID: <20191001120023.GQ4519@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.193241464@infradead.org>
 <37CFAEC1-6D36-4A6D-8C44-F85FCFA053AA@vmware.com>
 <20190607083756.GW3419@hirez.programming.kicks-ass.net>
 <20190610171929.3xemvsykvkswcvya@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190610171929.3xemvsykvkswcvya@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 12:19:29PM -0500, Josh Poimboeuf wrote:
> On Fri, Jun 07, 2019 at 10:37:56AM +0200, Peter Zijlstra wrote:
> > > > +}
> > > > +
> > > > +static int static_call_module_notify(struct notifier_block *nb,
> > > > +				     unsigned long val, void *data)
> > > > +{
> > > > +	struct module *mod = data;
> > > > +	int ret = 0;
> > > > +
> > > > +	cpus_read_lock();
> > > > +	static_call_lock();
> > > > +
> > > > +	switch (val) {
> > > > +	case MODULE_STATE_COMING:
> > > > +		module_disable_ro(mod);
> > > > +		ret = static_call_add_module(mod);
> > > > +		module_enable_ro(mod, false);
> > > 
> > > Doesn’t it cause some pages to be W+X ?
> 
> How so?

This is after complete_formation() which does RO,X. If we then disable
RO we end up with W+X pages, which is bad.

That said, alternatives, ftrace, dynamic_debug all run before
complete_formation() specifically such that they can directly poke text.

Possibly we should add a notifier callback for MODULE_STATE_UNFORMED,
but that is for another day.

> >> Can it be avoided?
> > 
> > I don't know why it does this, jump_labels doesn't seem to need this,
> > and I'm not seeing what static_call needs differently.
> 
> I forgot why I did this, but it's probably for the case where there's a
> static call site in module init code.  It deserves a comment.
> 
> Theoretically, jump labels need this to.
> 
> BTW, there's a change coming that will require the text_mutex before
> calling module_{disable,enable}_ro().

I can't find why it would need this (and I'm going to remove it).
Specifically complete_formation() does enable_ro(.after_init=false),
which leaves .ro_after_init writable so
{jump_label,static_call}_sort_entries() will work.

But both jump_label and static_call then use the full text_poke(), not
text_poke_early(), for modules.
