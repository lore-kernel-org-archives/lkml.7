Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9904EC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742A220663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GOqCrVY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfFZIuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 04:50:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40516 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfFZIuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MnbGZyeauwdtRRBuDtpt/nX8iYBnfXaGwgsVnSG6ZVU=; b=GOqCrVY6cjwTuGPiLLiJipoUG
        x3EFIWHaOUGlDmQy/q6crK2iTtlDI6meLjoeZvQldxzMTHSDApQbrHmi5s33SJVFR0XtY2po/qWLX
        XBEZJ81BHQ0W8nsYGzgZJDaWASFzBM2iphuH8H1xKVMfPFuQyXoywBJoKTwXTYKwoPSrIcEMpx5O9
        Tz2cyvXNwTRbL9UjmJtokdq9klvyZThRw4PVYB2rYzyaY35tEaNfqKWUPdyjR0iOSb3NP5N4irZV6
        w4Op+Re7s4ahGmKtQf3jI6KYZyr8zfv9jtktAxF0tomRPJ0z8HkkhkPXJo392h0+8jt3BglCZ7g2l
        Pea/4kuhQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg3cR-0005gU-Cv; Wed, 26 Jun 2019 08:49:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 702E5209CEE63; Wed, 26 Jun 2019 10:49:27 +0200 (CEST)
Date:   Wed, 26 Jun 2019 10:49:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shawn Landden <shawn@git.icu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Chandler Carruth <chandlerc@google.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190626084927.GI3419@hirez.programming.kicks-ass.net>
References: <20190624161913.GA32270@embeddedor>
 <20190624193123.GI3436@hirez.programming.kicks-ass.net>
 <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net>
 <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net>
 <CANiq72=zzZ+Cx8uM+5UW7HeB9XtbXRhXmC2y2tz5EzPX77gHMw@mail.gmail.com>
 <CAKwvOdn5j8Hkc_jrLMbhg-4jbNya+agtMJi=c9o01RPCno1Q+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn5j8Hkc_jrLMbhg-4jbNya+agtMJi=c9o01RPCno1Q+w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 11:15:57AM -0700, Nick Desaulniers wrote:

> Unreleased versions of Clang built from source can;

I've bad experiences with using unreleased compilers; life is too short.

> We're currently planning multiple output constraint support w/ asm
> goto, and have recently implemented things like
> __GCC_ASM_FLAG_OUTPUTS__.

That's good to hear.

> If there's other features that we should
> start implementing, please let us know.

If you've got any ideas on how to make this:

  https://lkml.kernel.org/r/20190621120923.GT3463@hirez.programming.kicks-ass.net

work, that'd be nice. Basically I wanted the asm goto to emit a 2 or 5
byte JMP/NOP depending on the displacement size. We can trivially get
JMP right by using:

	jmp \l_yes

and letting the assembler sort it, but getting the NOP right has so far
eluded me:

.if \l_yes - (. + 2) < 127
	.byte 0x66, 0x90
.else
	.byte STATIC_KEY_INIT_NOP
.endif

doesn't work. We can ofcourse unconditionally emit the JMP and then
rewrite the binary afterward, and replace the emitted jumps with the
right size NOP, but that's a bit yuck.

Once it emits the variable size instruction consistently, we can update
the patching side to use the same condition to select the new
instruction (and fix objtool).
