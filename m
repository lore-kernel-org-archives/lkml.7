Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BFAC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF4E20828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zsvyiuxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfF0HNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:13:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54780 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfF0HNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lSiHlFbnBLT/Aqr1yB8sI7WgL+COMTbJJSCNLGcNlqQ=; b=Zsvyiuxl/xIr+jdMnz0ZgoJdZ
        57pXjTwI8FcGX/5jU3lGtg3choyPp0o2vY681bW7L1yOCfAC1BZEM/d5WX2X356XQTp3DhPA0G/5H
        Zt80Whp12zaNPOHotVxhhrKT0DlfFBRPTuw71VFA+vvlZTsi9gvBuqueoD7bjYcUk3ht1gCOSfdhO
        eGliRR/yApQpEj9aQbyid02CkQurecOMfLQ/AO6ocP51dzS/676rWtagpGCeZ0aOiKk9oEKdaEjVR
        iVjPJTmTtD6CHrB2OihZM85QgrcN11cgZdZ7XYX8HxQUfy+bFrbd/4KlC8P0IJquEweG/btkUGLUN
        BrrUKf9MQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgOaS-0007Pk-Vo; Thu, 27 Jun 2019 07:12:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 871E720A714BA; Thu, 27 Jun 2019 09:12:50 +0200 (CEST)
Date:   Thu, 27 Jun 2019 09:12:50 +0200
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
Message-ID: <20190627071250.GZ3402@hirez.programming.kicks-ass.net>
References: <20190624193123.GI3436@hirez.programming.kicks-ass.net>
 <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net>
 <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net>
 <CANiq72=zzZ+Cx8uM+5UW7HeB9XtbXRhXmC2y2tz5EzPX77gHMw@mail.gmail.com>
 <CAKwvOdn5j8Hkc_jrLMbhg-4jbNya+agtMJi=c9o01RPCno1Q+w@mail.gmail.com>
 <20190626084927.GI3419@hirez.programming.kicks-ass.net>
 <CAKwvOdkp7qnwLGY2=TOx=FQa1k2hEkdi1PO+9GfZkTQEUh49Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkp7qnwLGY2=TOx=FQa1k2hEkdi1PO+9GfZkTQEUh49Rg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 03:14:05PM -0700, Nick Desaulniers wrote:
> On Wed, Jun 26, 2019 at 1:49 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jun 25, 2019 at 11:15:57AM -0700, Nick Desaulniers wrote:
> >
> > > Unreleased versions of Clang built from source can;
> >
> > I've bad experiences with using unreleased compilers; life is too short.
> 
> Yes; but before release is when they need the help the most in order
> for testing to find regressions.
> 
> >
> > > We're currently planning multiple output constraint support w/ asm
> > > goto, and have recently implemented things like
> > > __GCC_ASM_FLAG_OUTPUTS__.
> >
> > That's good to hear.
> >
> > > If there's other features that we should
> > > start implementing, please let us know.
> >
> > If you've got any ideas on how to make this:
> >
> >   https://lkml.kernel.org/r/20190621120923.GT3463@hirez.programming.kicks-ass.net
> >
> > work, that'd be nice. Basically I wanted the asm goto to emit a 2 or 5
> > byte JMP/NOP depending on the displacement size. We can trivially get
> > JMP right by using:
> >
> >         jmp \l_yes
> >
> > and letting the assembler sort it, but getting the NOP right has so far
> > eluded me:
> >
> > .if \l_yes - (. + 2) < 127
> >         .byte 0x66, 0x90
> > .else
> >         .byte STATIC_KEY_INIT_NOP
> > .endif
> >
> > doesn't work. We can ofcourse unconditionally emit the JMP and then
> > rewrite the binary afterward, and replace the emitted jumps with the
> > right size NOP, but that's a bit yuck.
> >
> > Once it emits the variable size instruction consistently, we can update
> > the patching side to use the same condition to select the new
> > instruction (and fix objtool).
> 
> Not sure; the assembler directives and their requirements aren't
> something I'm too familiar with.

Josh came up with the following:

+		/* If the jump target is close, do a 2-byte nop: */
+		".skip -(%l[l_yes] - 1b <= 126), 0x66\n"
+		".skip -(%l[l_yes] - 1b <= 126), 0x90\n"
+		/* Otherwise do a 5-byte nop: */
+		".skip -(%l[l_yes] - 1b > 126), 0x0f\n"
+		".skip -(%l[l_yes] - 1b > 126), 0x1f\n"
+		".skip -(%l[l_yes] - 1b > 126), 0x44\n"
+		".skip -(%l[l_yes] - 1b > 126), 0x00\n"
+		".skip -(%l[l_yes] - 1b > 126), 0x00\n"

Which is a wonderfully gruesome hack :-) So I'll be playing with that
for a bit.
