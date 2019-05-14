Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31601C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E207320873
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTAxGgC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfENUYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:24:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34514 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfENUYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:24:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id n19so98833pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 13:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BVBCNtw4OCSkXzf6e+pUMYZpGLCjILIxG5vFuVVP94I=;
        b=kTAxGgC3T/bvSvNY297IvTzEw7QycBCSWS3tVIM+8LK1Yh7qeL7trWWTuv61tD548m
         cp0jPns5UNODon9wuZx8C3BDIOYV9FQvUqHbuaifpHlgNC+yDZFKDXwNJ5FG/RqaV4v2
         NoyUcjYiT7aSPfCzVsRid4Bfm9+cItlvdygPffCOE2ZJnOBUfSjMrG3mgQwnZCC2zGmg
         vpRXnQ0mFBiQrJkNbwhT+49dVHCCtVJQV5nwG5/K57lj8zHRltJeoQ9YYkEtOvF3oxXB
         DDEu7cbO01dc3e/0EKWJNWiEsMaRAVeO8J5xNYExDmoTlCv7NXfLDBM0v1MZ0xv5shrO
         m2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BVBCNtw4OCSkXzf6e+pUMYZpGLCjILIxG5vFuVVP94I=;
        b=pOauhv4dUTqBwXQj6vaS6B/xNxS/N7Zb/1f5QcdwmgAGokAyLqSGO6U9JOkC9y2EzC
         y6eqkUiXh8NNQ8rjggJlGF+WXjdzfa9VUIRU5HuKWW5+l01NDonPCZWP/IwRDvFXkBP7
         SzJvgrqr1uqECWmfP8eR9I1CEc0Ftgd6udIdWSgQEjq9avimH+hXKTUuAD7ZtQKiCwTD
         mPYwqxh07NgEpzN1cE7e6NSGpey8rOYvldhSVeI0VuAgIWcV0DjF1iY1rRYCMe0i6aBx
         Djyg7uv8l5XZ+Hv72OCvgEc8TRXzlcYilC+tGeEZribwUjfAgftSdvfBMpGelY11wbCM
         QIeg==
X-Gm-Message-State: APjAAAWu4vWeTOR5KeWHgbNY4QahE9At7Bc/4XlAG3Z15ij4CroCW3Y9
        dAnrY6iFIqnWt/XTzR7NauZCpODutYvoHjAvwXBMSw==
X-Google-Smtp-Source: APXvYqypyoGijJYogmMon+IZnBnO02AAnROorviN2SnTvCNN9mPldwAK/7yFGAibQD9Ds1Qa+hw+sPH8wk29RbLw56c=
X-Received: by 2002:a63:e711:: with SMTP id b17mr39800783pgi.202.1557865488608;
 Tue, 14 May 2019 13:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190513222109.110020-1-ndesaulniers@google.com>
 <20190513232910.GA30209@archlinux-i9> <CAKwvOd=W9nm04zvRQ3iu=AGHnitongZ7VQ9S32U9hBZKwNyeMw@mail.gmail.com>
 <201905141041.C38DA1B305@keescook>
In-Reply-To: <201905141041.C38DA1B305@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 May 2019 13:24:37 -0700
Message-ID: <CAKwvOdn2ESh+-T8=YFT=W=gjZHPpCY8QJVS7ytPHM04tN1v13g@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: support llvm-objcopy
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathanchance@gmail.com>,
        Jordan Rupprect <rupprecht@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 11:11 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, May 13, 2019 at 04:50:05PM -0700, Nick Desaulniers wrote:
> > On Mon, May 13, 2019 at 4:29 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > On Mon, May 13, 2019 at 03:21:09PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > > > With CONFIG_LKDTM=y and make OBJCOPY=llvm-objcopy, llvm-objcopy errors:
> > > > llvm-objcopy: error: --set-section-flags=.text conflicts with
> > > > --rename-section=.text=.rodata
> > > >
> > > > Rather than support setting flags then renaming sections vs renaming
> > > > then setting flags, it's simpler to just change both at the same time
> > > > via --rename-section.
> > > >
> > > > This can be verified with:
> > > > $ readelf -S drivers/misc/lkdtm/rodata_objcopy.o
> > > > ...
> > > > Section Headers:
> > > >   [Nr] Name              Type             Address           Offset
> > > >        Size              EntSize          Flags  Link  Info  Align
> > > > ...
> > > >   [ 1] .rodata           PROGBITS         0000000000000000  00000040
> > > >        0000000000000004  0000000000000000   A       0     0     4
> > > > ...
> > > >
> > > > Which shows in the Flags field that .text is now renamed .rodata, the
> > > > append flag A is set, and the section is not flagged as writeable W.
> > > >
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/448
> > > > Reported-by: Nathan Chancellor <nathanchance@gmail.com>
> > >
> > > This should be natechancellor@gmail.com (although I think I do own that
> > > email, just haven't been into it for 10+ years...)
> >
> > Sorry, I should have looked it up.  I'll just fix this, my earlier
> > mistake, and collect Kees's reviewed by tag in a v2 sent directly to
> > GKH.
>
> Sounds good.
>
> > > I ran this script to see if there was any change for GNU objcopy and it
> > > looks like .rodata's type gets changed, is this intentional? Otherwise,
> > > this works for llvm-objcopy like you show.
> > >
> > > -----------
> > >
> > > 1c1
> > > < There are 11 section headers, starting at offset 0x240:
> > > ---
> > > > There are 11 section headers, starting at offset 0x230:
> > > 8c8
> > > <   [ 1] .rodata           PROGBITS         0000000000000000  00000040
> > > ---
> > > >   [ 1] .rodata           NOBITS           0000000000000000  00000040
> > > 10c10
>
> Oh, very good catch; thank you!
>
> >
> > Interesting find.  the .rodata of vmlinux itself is marked PROGBITS,
> > so its curious that GNU binutils changes the "Type" after the rename.
> > I doubt the code in question relies on NOBITS for this section.  Kees,
> > can you clarify?  Jordan, do you know what the differences are between
> > PROGBITS vs NOBITS?
> > https://people.redhat.com/mpolacek/src/devconf2012.pdf seems to
> > suggest NOBITS zero initializes data but I'm not sure that's what this
> > code wants.
>
> Yes, the linker treats this as a zeroed section. My testing only checked that the NX protection check kicked, but in looking at the memory, the failure mode wouldn't have returned, because it got zeroed instead of seeing a "ret":
>
> Before the patch (with a two-byte target dump added):
>
>         lkdtm: attempting bad execution at ffffffff986db2b0
>         lkdtm: f3 c3
>
> After the patch:
>
>         lkdtm: attempting bad execution at ffffffff986db2b0
>         lkdtm: 00 00
>
> So, yes, this breaks the fall-back case and should not be used. It seems
> that objcopy BFD breaks the PROGBITS in this case, but llvm-objcopy
> does not...

I'm not sure I want to call it a bug in the initial implementation.  I've filed:
https://sourceware.org/bugzilla/show_bug.cgi?id=24554 for
clarification.  Jordan, I hope you can participate in any discussion
there?

>
> $ objcopy --set-section-flags .text=alloc,readonly --rename-section .text=.rodata rodata.o rodata_objcopy.o
> $ readelf -S rodata_objcopy.o | grep -A1 \.rodata
>   [ 1] .rodata           PROGBITS         0000000000000000  00000040
>        0000000000000002  0000000000000000   A       0     0     16
>
> $ objcopy --rename-section .text=.rodata,alloc,readonly rodata.o rodata_objcopy.o
> $ readelf -S rodata_objcopy.o | grep -A1 \.rodata
>   [ 1] .rodata           NOBITS           0000000000000000  00000040
>        0000000000000002  0000000000000000   A       0     0     16
>
> $ llvm-objcopy --rename-section .text=.rodata,alloc,readonly rodata.o rodata_objcopy-llvm.o
> $ readelf -S rodata_objcopy-llvm.o | grep -A1 \.rodata
>   [ 1] .rodata           PROGBITS         0000000000000000  00000040
>        0000000000000002  0000000000000000   A       0     0     16
>
>
> llvm-objcopy doesn't like doing both arguments at the same time,
> and BFD gets it wrong when using the appended flags. How about just a
> two-stage copy, like this?

Yeah, I think this should work.  What you wrote above + the link the
bug I just filed would go well in a commit message, along with:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
> index 951c984de61a..715832c844c8 100644
> --- a/drivers/misc/lkdtm/Makefile
> +++ b/drivers/misc/lkdtm/Makefile
> @@ -14,9 +14,12 @@ KASAN_SANITIZE_stackleak.o   := n
>  KCOV_INSTRUMENT_rodata.o       := n
>
>  OBJCOPYFLAGS :=
> +OBJCOPYFLAGS_rodata_flags.o    := \
> +                       --set-section-flags .text=alloc,readonly
>  OBJCOPYFLAGS_rodata_objcopy.o  := \
> -                       --set-section-flags .text=alloc,readonly \
>                         --rename-section .text=.rodata
> -targets += rodata.o rodata_objcopy.o
> -$(obj)/rodata_objcopy.o: $(obj)/rodata.o FORCE
> +targets += rodata.o rodata_flags.o rodata_objcopy.o
> +$(obj)/rodata_flags.o: $(obj)/rodata.o FORCE
> +       $(call if_changed,objcopy)
> +$(obj)/rodata_objcopy.o: $(obj)/rodata_flags.o FORCE
>         $(call if_changed,objcopy)
>
>
> --
> Kees Cook
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To post to this group, send email to clang-built-linux@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/201905141041.C38DA1B305%40keescook.
> For more options, visit https://groups.google.com/d/optout.



-- 
Thanks,
~Nick Desaulniers
