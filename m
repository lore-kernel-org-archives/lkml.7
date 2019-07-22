Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73767C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0FD21955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cpwkkjOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbfGVVMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:12:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33736 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbfGVVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:12:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so17974518pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 14:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bx2/ePKA8H3cgL5H2m2rJiaOZ0YWGIns7rKdFWu1CvE=;
        b=cpwkkjOLk25nBbTGu2WNpjUDYdO+q1x07ANNm/j3n6/Ri82GyGhsmPlLyNydLB84me
         c88eJ3vF2boELtTlxfZl5HAuOq6KfFavmpEIRW81ecH92XPTLO7lPzU71NUNl+dtHtaX
         kWTBdNvHFtNYi2ySsiiFM6ZvTn1xfilyYzw7kU+bcbORNN0SHD5CAVr0dE7egLY7Tf6B
         J4uusXzpXcelhxkL8Yh2yCaLynfgNkqns22rVNk0OQg3JD9yPv2xeFdbnx0W8ZcW5euK
         XTgZLd5NBCrFenu+gJTV2jDJX+gLtOgIvPxgWCW7E/6mA2mfjlqtfPAy8PwAALWwushW
         sIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bx2/ePKA8H3cgL5H2m2rJiaOZ0YWGIns7rKdFWu1CvE=;
        b=bkoqRwU+UMXx2a9PDmGkas7mWsVTn50Xrk829WskZtvTGCLOaJGYiRc0zuKpLh9tjB
         a4kt9K9Dc2tLlGwwrZtLpldW6R0v3hcgA9EQrtWhGWauINb6VN2XhuevhuN7llolp/gY
         nq3nXMgmoOBuXGRUQOumInegItrwK8sDyCRrbV2QokM6IjYbkR21FycUE2WDxw68+gNX
         00MjltQBOxJkdl6g2Q6yZ4tm9FL98HEyiX/dn17t5FP0tDE0jj+/mYP5hnP5H1QCD6QL
         xrOB3m16Qs32n6Ieqt7RKsqHzHbhh8Ya5nNvLmKwGOxfGAuTjNZPKQBQsXTLr7MiKdDT
         +ugQ==
X-Gm-Message-State: APjAAAUbn9VShtqpnh4TexPIeudx8hkJ9C3Bh3q5cVX5+BKVVQes0Sqh
        WaFDZV1keh0b8J1uJK1v0ghIG5Satanfvpb3VazxFw==
X-Google-Smtp-Source: APXvYqzdifltGHrEL/Vim3PWtyGDjD5Rl7cxRAZMB2C1K4hdOBZNUzpow3J0+KekukdWAXzghEqoDA9TevL/JhaYMO4=
X-Received: by 2002:a65:5687:: with SMTP id v7mr74705885pgs.263.1563829939659;
 Mon, 22 Jul 2019 14:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190718000206.121392-1-vaibhavrustagi@google.com>
 <20190718000206.121392-2-vaibhavrustagi@google.com> <CAKwvOdkHHNR7utufOcDwAOgBEA9MnOLh713Gaq01R=n26EyjZw@mail.gmail.com>
 <20190719081732.GF3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190719081732.GF3419@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Jul 2019 14:12:08 -0700
Message-ID: <CAKwvOdknUgYS3R5+g0=wFb2SB3ojfhz667Zv_9UZj3nM0Z_PdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/purgatory: add -mno-sse, -mno-mmx, -mno-sse2 to Makefile
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vaibhav Rustagi <vaibhavrustagi@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 1:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jul 18, 2019 at 02:34:44PM -0700, Nick Desaulniers wrote:
> > On Wed, Jul 17, 2019 at 5:02 PM Vaibhav Rustagi
> > <vaibhavrustagi@google.com> wrote:
> > >
> > > Compiling the purgatory code with clang results in using of mmx
> > > registers.
> > >
> > > $ objdump -d arch/x86/purgatory/purgatory.ro | grep xmm
> > >
> > >      112:       0f 28 00                movaps (%rax),%xmm0
> > >      115:       0f 11 07                movups %xmm0,(%rdi)
> > >      122:       0f 28 00                movaps (%rax),%xmm0
> > >      125:       0f 11 47 10             movups %xmm0,0x10(%rdi)
> > >
> > > Add -mno-sse, -mno-mmx, -mno-sse2 to avoid generating SSE instructions.
> > >
> > > Signed-off-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
> > > ---
> > >  arch/x86/purgatory/Makefile | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> > > index 3cf302b26332..3589ec4a28c7 100644
> > > --- a/arch/x86/purgatory/Makefile
> > > +++ b/arch/x86/purgatory/Makefile
> > > @@ -20,6 +20,7 @@ KCOV_INSTRUMENT := n
> > >  # sure how to relocate those. Like kexec-tools, use custom flags.
> > >
> > >  KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-zero-initialized-in-bss -fno-builtin -ffreestanding -c -Os -mcmodel=large
> > > +KBUILD_CFLAGS += -mno-mmx -mno-sse -mno-sse2
> >
> > Yep, this is a commonly recurring bug in the kernel, observed again
> > and again for Clang builds.  The top level Makefile carefully sets
> > KBUILD_CFLAGS, then lower subdirs in the kernel wipe them away with
> > `:=` assignment. Invariably important flags don't always get re-added.
> > In this case, these flags are used in arch/x86/Makefile, but not here
> > and should be IMO.  Thanks for the patch.
>
> Should we then not fix/remove these := assignments?

Good point, it's actually pretty straightforward to do so.  It just
will invert the order of patches in the series, as then the
memcpy/memset infinite recursion is now guaranteed with
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y (without the other patch in this
series).  Did the x86 maintainers have thoughts on their favorite
implementation of memset/memcpy for me to use from the thread from the
other patch in the series? I'll just resend with this fix and maybe we
can discuss there and spin a v3 if needed.

-- 
Thanks,
~Nick Desaulniers
