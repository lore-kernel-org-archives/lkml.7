Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F622C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C70207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389043AbfFJSz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 14:55:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388069AbfFJSz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:55:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2DEBC5AFD9;
        Mon, 10 Jun 2019 18:55:24 +0000 (UTC)
Received: from treble (ovpn-121-189.rdu2.redhat.com [10.10.121.189])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03B1E1001DC0;
        Mon, 10 Jun 2019 18:55:14 +0000 (UTC)
Date:   Mon, 10 Jun 2019 13:55:13 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 13/15] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20190610185513.pbtc7udpkfd5jsuu@treble>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.313688119@infradead.org>
 <20190610183357.zj6rwdpgw36anpfc@treble>
 <40096B8A-C063-4219-89FC-A8E42981BF28@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40096B8A-C063-4219-89FC-A8E42981BF28@vmware.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 10 Jun 2019 18:55:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 06:45:52PM +0000, Nadav Amit wrote:
> > On Jun 10, 2019, at 11:33 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> > On Wed, Jun 05, 2019 at 03:08:06PM +0200, Peter Zijlstra wrote:
> >> --- a/arch/x86/include/asm/static_call.h
> >> +++ b/arch/x86/include/asm/static_call.h
> >> @@ -2,6 +2,20 @@
> >> #ifndef _ASM_STATIC_CALL_H
> >> #define _ASM_STATIC_CALL_H
> >> 
> >> +#include <asm/asm-offsets.h>
> >> +
> >> +#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
> >> +
> >> +/*
> >> + * This trampoline is only used during boot / module init, so it's safe to use
> >> + * the indirect branch without a retpoline.
> >> + */
> >> +#define __ARCH_STATIC_CALL_TRAMP_JMP(key, func)				\
> >> +	ANNOTATE_RETPOLINE_SAFE						\
> >> +	"jmpq *" __stringify(key) "+" __stringify(SC_KEY_func) "(%rip) \n"
> >> +
> >> +#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
> > 
> > I wonder if we can simplify this (and drop the indirect branch) by
> > getting rid of the above cruft, and instead just use the out-of-line
> > trampoline as the default for inline as well.
> > 
> > Then the inline case could fall back to the out-of-line implementation
> > (by patching the trampoline's jmp dest) before static_call_initialized
> > is set.
> 
> I must be missing some context - but what guarantees that this indirect
> branch would be exactly 5 bytes long? Isn’t there an assumption that this
> would be the case? Shouldn’t there be some handling of the padding?

We don't patch the indirect branch.  It's just part of a temporary
trampoline which is called by the call site, and which does "jmp
key->func" during boot until static call initialization is done.

(Though I'm suggesting removing that.)

-- 
Josh
