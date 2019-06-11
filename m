Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955B8C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67010208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dF4SG3R9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404489AbfFKIDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:03:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404132AbfFKIDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8xxQALJN7Syi60OL02MNSn/aq6yIJ8KjUuq65xvI+7Y=; b=dF4SG3R98ldLAVUuSrWAwLhOr
        cJoQg2/9XlVlfVS3GJzSVmAzSu40cgW8v845BW//x9zPpNn3MA+f6Ii8bTnSb9IiEfab7FcUSzHec
        DYvzXonBcwNAFADC/GOvv8PMET1EvSZi2PSpoGM73+0bFZpoOtMuKSOX79OHsVCc1HHh9gZNHnZZ5
        GU4eF8n221ZOOobeCv3GivVpy1NHZpIkZ/xWDZADu9Yuo7SaUQsq1CtmsgqLg8S796dM3SCYecHz0
        9KNRzjNAM7jVRFyIHXOgHBeGM5IG00N5C8A8qtNV3QPCkRC0hFGKAT6YBI9xAeYVo1Kwxcp4LGpt4
        D2ltQDSIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1habkM-0007Gc-0A; Tue, 11 Jun 2019 08:03:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8FE96202173E0; Tue, 11 Jun 2019 10:03:07 +0200 (CEST)
Date:   Tue, 11 Jun 2019 10:03:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20190611080307.GN3436@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.005681046@infradead.org>
 <20190608004708.7646b287151cf613838ce05f@kernel.org>
 <20190607173427.GK3436@hirez.programming.kicks-ass.net>
 <3DA961AB-950B-4886-9656-C0D268D521F1@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA961AB-950B-4886-9656-C0D268D521F1@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 11:10:19AM -0700, Andy Lutomirski wrote:
> 
> 
> > On Jun 7, 2019, at 10:34 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Sat, Jun 08, 2019 at 12:47:08AM +0900, Masami Hiramatsu wrote:
> > 
> >>> This fits almost all text_poke_bp() users, except
> >>> arch_unoptimize_kprobe() which restores random text, and for that site
> >>> we have to build an explicit emulate instruction.
> >> 
> >> Hm, actually it doesn't restores randome text, since the first byte
> >> must always be int3. As the function name means, it just unoptimizes
> >> (jump based optprobe -> int3 based kprobe).
> >> Anyway, that is not an issue. With this patch, optprobe must still work.
> > 
> > I thought it basically restored 5 bytes of original text (with no
> > guarantee it is a single instruction, or even a complete instruction),
> > with the first byte replaced with INT3.
> > 
> 
> I am surely missing some kprobe context, but is it really safe to use
> this mechanism to replace more than one instruction?

I'm not entirely up-to-scratch here, so Masami, please correct me if I'm
wrong.

So what happens is that arch_prepare_optimized_kprobe() <-
copy_optimized_instructions() copies however much of the instruction
stream is required such that we can overwrite the instruction at @addr
with a 5 byte jump.

arch_optimize_kprobe() then does the text_poke_bp() that replaces the
instruction @addr with int3, copies the rel jump address and overwrites
the int3 with jmp.

And I'm thinking the problem is with something like:

@addr: nop nop nop nop nop

We copy out the nops into the trampoline, overwrite the first nop with
an INT3, overwrite the remaining nops with the rel addr, but oops,
another CPU can still be executing one of those NOPs, right?

I'm thinking we could fix this by first writing INT3 into all relevant
instructions, which is going to be messy, given the current code base.
