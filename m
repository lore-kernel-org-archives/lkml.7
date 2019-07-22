Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB981C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA3C21955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uY2n8ftA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbfGVW75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:59:57 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36907 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbfGVW74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:59:56 -0400
Received: by mail-io1-f66.google.com with SMTP id q22so77701272iog.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 15:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWzObsdwU3i63gvAqqM5ECXti3xb+XhH33+pC1nlaaE=;
        b=uY2n8ftAPZVkAr8jdXWBsvcA8yE2U1CfjtybqA2v1jcwqs41Rc5uWFaGUn8oPnRXaX
         3lfZTk36mp9FamG+/DoyegTCUAwZSZzYFBBhFjtXWGcaBzThO2TQSdiwihiIBMXW/4Bh
         OyNV8TZnwhmrWcqfgwn6lLrY49qviOAuTzMEMw1ai8KBzKf4Hb90sDAXpnFAFZGlvq6Z
         Gcy11kj1ZRl+XlYxCYZaQCFUfG266OQOPGCqPlxSKXFf5NS4hIQKQWJLxTk/FZZmkjKq
         GluMQ/svUi8OOMHmTlk/Nl24kVdeYwQYcmD/C9fLaJlyekSE24i/n1i/VDnmljBh/aHi
         fsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWzObsdwU3i63gvAqqM5ECXti3xb+XhH33+pC1nlaaE=;
        b=VSXbsiFxsMixPWVzoflzDraGQbzcFQFmNxf2l6EF0h72Mn7kaDfNqhlAZXHkK2A33e
         MzQwKgLEW4zVxEVNEekUZL09HibmQ9tR4Mo+Cj493oNJu6vuiWFNgKNPrjVgyK7gdw4w
         JyXLd8M9uKqrdzoR+uCy+ndjBH3tg5eoVsS9msoJakww3hbmfEb3TgBeilEpgiE5KT9H
         MZYfVFHZzyMrLuozcmAftTC/1lZlBK4Q/upDSouFPABuOr4p2l2sQ7KhZtlyTYHPMkFQ
         NQT+aQKb7axDvFXqUxFkj66bMrJGvqKXOpdiT7AdG3+YDWorCjcVv9okw8Pif3ExYtBa
         7mFQ==
X-Gm-Message-State: APjAAAV5P59YkyT4UaTepvwnuuaKTYxjH6+hNWOfc+RLVxxZlaT0Fp6W
        OMzDCta3A6QKzUqNqzp3nOpY1KgEa339ah51+HHA3Q==
X-Google-Smtp-Source: APXvYqy6QBLbVbywHf8Q6h+aeZbSlkdjm2Xi4/FetLBdPWhaZz7AKFhhp5qclvY2nAoZq7qq7j1xVayXRZfBYRWpDFI=
X-Received: by 2002:a02:ad15:: with SMTP id s21mr78069681jan.47.1563836395727;
 Mon, 22 Jul 2019 15:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190722213250.238685-1-ndesaulniers@google.com>
 <20190722213250.238685-2-ndesaulniers@google.com> <CAKwvOdm3iyeJfuivhQJqXB9FfC0zHgrfgoN_qW4poEyfcw3C9A@mail.gmail.com>
In-Reply-To: <CAKwvOdm3iyeJfuivhQJqXB9FfC0zHgrfgoN_qW4poEyfcw3C9A@mail.gmail.com>
From:   Vaibhav Rustagi <vaibhavrustagi@google.com>
Date:   Mon, 22 Jul 2019 15:59:44 -0700
Message-ID: <CAMVonLjd3DoKQatdraG0t8X_F9Au-fA_vL2RSNfNPNbqvXWCDA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/purgatory: use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 3:10 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Jul 22, 2019 at 2:33 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > KBUILD_CFLAGS is very carefully built up in the top level Makefile,
> > particularly when cross compiling or using different build tools.
> > Resetting KBUILD_CFLAGS via := assignment is an antipattern.
> >
> > The comment above the reset mentions that -pg is problematic.  Other
> > Makefiles like arch/x86/xen/vdso/Makefile use
> > `CFLAGS_REMOVE_file.o = -pg` when CONFIG_FUNCTION_TRACER is set. Prefer
> > that pattern to wiping out all of the important KBUILD_CFLAGS then
> > manually having to re-add them.
> >
> > Fixes: 8fc5b4d4121c ("purgatory: core purgatory functionality")
> > Reported-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> > Rather than manually add -mno-sse, -mno-mmx, -mno-sse2, prefer to filter
> > -pg flags.
> >
> >  arch/x86/purgatory/Makefile | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> > index 91ef244026d2..56bcabca283f 100644
> > --- a/arch/x86/purgatory/Makefile
> > +++ b/arch/x86/purgatory/Makefile
> > @@ -20,11 +20,13 @@ KCOV_INSTRUMENT := n
> >
> >  # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
> >  # in turn leaves some undefined symbols like __fentry__ in purgatory and not
> > -# sure how to relocate those. Like kexec-tools, use custom flags.
> > -
> > -KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-zero-initialized-in-bss -fno-builtin -ffreestanding -c -Os -mcmodel=large
> > -KBUILD_CFLAGS += -m$(BITS)
>
> Is purgatory/kexec supported for CONFIG_X86_32?  Should I be keeping
> `-m$(BITS)`?  arch/x86/purgatory/Makefile mentions
> `setup-x86_$(BITS).o` which I assume is broken as there is no
> arch/x86/purgatory/setup-x86_32.S?
>
> > -KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
> > +# sure how to relocate those.
> > +ifdef CONFIG_FUNCTION_TRACER
> > +CFLAGS_REMOVE_sha256.o = -pg
> > +CFLAGS_REMOVE_purgatory.o = -pg
> > +CFLAGS_REMOVE_string.o = -pg
> > +CFLAGS_REMOVE_kexec-purgatory.o = -pg
> > +endif
> >

The changes suggested will cause undefined symbols while loading the new kernel.
On doing 'nm purgatory.ro', I found below undefined symbols:

U bmcp
U __stack_chk_fail

> >  $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
> >                 $(call if_changed,ld)
> > --
> > 2.22.0.657.g960e92d24f-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
