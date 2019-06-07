Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334C2C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE8320652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="idQPdHad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbfFGRma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:42:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49430 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfFGRma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Isgbg3AcMVxijCLxeP5g7ucIZ+WTg+Ln6Nf1BOjCEgY=; b=idQPdHadXoPujArpWO9WKxPZQq
        EOTPbSwN8kx68ck6JsJKGAOmpF9bGmv3mUwLg2wIMPamC6Sym7+0KRjYtHhmnSWKP9LbxjJRabdGR
        7LEY46V9vbaE/sEHf0f33ZclYQYVBFYVgzYliD6PJqbd5rs4g4XlOJZiGJtrVWDYVlAlSw6GNJjYo
        kRxQq5oznlNQPUKEpvG7f4UC4RWlo8DSca3YcjLf5d7S5gNyKZ2y1mESMF4mxvGM+p4KQGCGKi/ns
        Hr/xNc8JxkJqqlUJ8bNJh8+pqFY/2XHNrUZRtPVl0qwts9/Wmq+qFCYDLr/LpYRWRJgGFNp9zomqP
        kfV8Cbcg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZIs1-00047J-Mf; Fri, 07 Jun 2019 17:41:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F11220227117; Fri,  7 Jun 2019 19:41:39 +0200 (CEST)
Date:   Fri, 7 Jun 2019 19:41:39 +0200
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
Subject: Re: [PATCH 11/15] static_call: Add inline static call infrastructure
Message-ID: <20190607174139.GL3436@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.193241464@infradead.org>
 <37CFAEC1-6D36-4A6D-8C44-F85FCFA053AA@vmware.com>
 <20190607083756.GW3419@hirez.programming.kicks-ass.net>
 <AF3846D0-01F0-4A42-AEB6-09B0902A659C@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AF3846D0-01F0-4A42-AEB6-09B0902A659C@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 04:35:42PM +0000, Nadav Amit wrote:
> > On Jun 7, 2019, at 1:37 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Thu, Jun 06, 2019 at 10:24:17PM +0000, Nadav Amit wrote:

> >>> +		if (ret) {
> >>> +			WARN(1, "Failed to allocate memory for static calls");
> >>> +			static_call_del_module(mod);
> >> 
> >> If static_call_add_module() succeeded in changing some of the calls, but not
> >> all, I don’t think that static_call_del_module() will correctly undo
> >> static_call_add_module(). The code transformations, I think, will remain.
> > 
> > Hurm, jump_labels has the same problem.
> > 
> > I wonder why kernel/module.c:prepare_coming_module() doesn't propagate
> > the error from the notifier call. If it were to do that, I think we'll
> > abort the module load and any modifications get lost anyway.
> 
> This might be a security problem, since it can leave indirect branches,
> which are susceptible to Spectre v2, in the code.

It's a correctness problem too; for both jump_label and static_call,
since if we don't patch the call site, we also don't patch the
trampoline and who knows what random code it ends up running.

I'll go stare at the module code once my migrane goes again :/
