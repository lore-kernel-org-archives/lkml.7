Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58761C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8F320850
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BnRnycVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfEMXuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 19:50:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34459 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfEMXuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 19:50:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id n19so8056411pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 16:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eVB0b08V+iV97wPIWUm2BRD09cpVNg8KttImvAT945c=;
        b=BnRnycVRBLCcbjrO+DCabev1FN748p3YJ4sVMKSBouwL48K02qdjRru2FcOMGm6jht
         8bXzR6QB/blHX/FCRqCNMCXA576i4K97masi2yfqN3RTZyAamAUlP2hIBzbFfuMHNayg
         wSiqAMQFppjSPwK4chAhTk4KzwABjkbN2ridwapx+aqzCgiuubguSr5PSYRoeklJOp0b
         BoYNI24HXEqR7sjxrSqR8KApLaj0qXY7UEQVOlH+w6VQb+uGQfwPASX7/g3fgPAXqXfQ
         NvHLm0/lmq9A6B3i1vzRpoXaydziUd2Ivo/JaOZi4LB+kFBOC2wV9nZ0bAIXvh6jundU
         UWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVB0b08V+iV97wPIWUm2BRD09cpVNg8KttImvAT945c=;
        b=pVgJ8Kqe8U5mwDeqnz/FK86byZmnp9B9dt3k3Lj+r+i55oRTOvsjNBGKyB/OhPXDs0
         TV4APRz/vfRY3jvD59zGHBtaWC4zzYHUiqMhu2y75TMB9YFqvV7ZDZ2XhI6Ob+5gXEUO
         CFcP/NG1w92JJ7M51ESth3thNTMWvJjn26r3Raa7wdKawAMkpwTnmAtUAnupzccRjsM6
         MNBzkT14qE+JqghaJxj+GUdLmLew8ftyamCS6tTp2uYesrf+K1g8x3nqQ0+afE21bHoD
         m6sJmkrXFM8bge2qts67XP2fmD/+8ie7qXLKbbkv/BEm1AObypUnxFif4SaWZI4uvd4G
         JPyg==
X-Gm-Message-State: APjAAAUU2AXLm9DNhCGI4wy4s0xX/hKwRHzlZp2c9Kwkg4goXkcF22H+
        sJE5+RHcXk7CT724cAO771INIbRtaLh05f6iX2ePVg==
X-Google-Smtp-Source: APXvYqxNP6fvuZQfd2Rf+OGnDB3qVc+HsVu1E1p4H7T1IEnsHAvCO+yqIdlErr0QXoOUAfPnWG59mWmcFkLJWSnsa0o=
X-Received: by 2002:a63:fd4a:: with SMTP id m10mr35345718pgj.302.1557791417272;
 Mon, 13 May 2019 16:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190513222109.110020-1-ndesaulniers@google.com> <20190513232910.GA30209@archlinux-i9>
In-Reply-To: <20190513232910.GA30209@archlinux-i9>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 May 2019 16:50:05 -0700
Message-ID: <CAKwvOd=W9nm04zvRQ3iu=AGHnitongZ7VQ9S32U9hBZKwNyeMw@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: support llvm-objcopy
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
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

On Mon, May 13, 2019 at 4:29 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, May 13, 2019 at 03:21:09PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > With CONFIG_LKDTM=y and make OBJCOPY=llvm-objcopy, llvm-objcopy errors:
> > llvm-objcopy: error: --set-section-flags=.text conflicts with
> > --rename-section=.text=.rodata
> >
> > Rather than support setting flags then renaming sections vs renaming
> > then setting flags, it's simpler to just change both at the same time
> > via --rename-section.
> >
> > This can be verified with:
> > $ readelf -S drivers/misc/lkdtm/rodata_objcopy.o
> > ...
> > Section Headers:
> >   [Nr] Name              Type             Address           Offset
> >        Size              EntSize          Flags  Link  Info  Align
> > ...
> >   [ 1] .rodata           PROGBITS         0000000000000000  00000040
> >        0000000000000004  0000000000000000   A       0     0     4
> > ...
> >
> > Which shows in the Flags field that .text is now renamed .rodata, the
> > append flag A is set, and the section is not flagged as writeable W.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/448
> > Reported-by: Nathan Chancellor <nathanchance@gmail.com>
>
> This should be natechancellor@gmail.com (although I think I do own that
> email, just haven't been into it for 10+ years...)

Sorry, I should have looked it up.  I'll just fix this, my earlier
mistake, and collect Kee's reviewed by tag in a v2 sent directly to
GKH.

>
> > Suggested-by: Jordan Rupprect <rupprecht@google.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  drivers/misc/lkdtm/Makefile | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
> > index 951c984de61a..89dee2a9d88c 100644
> > --- a/drivers/misc/lkdtm/Makefile
> > +++ b/drivers/misc/lkdtm/Makefile
> > @@ -15,8 +15,7 @@ KCOV_INSTRUMENT_rodata.o    := n
> >
> >  OBJCOPYFLAGS :=
> >  OBJCOPYFLAGS_rodata_objcopy.o        := \
> > -                     --set-section-flags .text=alloc,readonly \
> > -                     --rename-section .text=.rodata
> > +                     --rename-section .text=.rodata,alloc,readonly
> >  targets += rodata.o rodata_objcopy.o
> >  $(obj)/rodata_objcopy.o: $(obj)/rodata.o FORCE
> >       $(call if_changed,objcopy)
> > --
> > 2.21.0.1020.gf2820cf01a-goog
> >
>
> I ran this script to see if there was any change for GNU objcopy and it
> looks like .rodata's type gets changed, is this intentional? Otherwise,
> this works for llvm-objcopy like you show.
>
> -----------
>
> 1c1
> < There are 11 section headers, starting at offset 0x240:
> ---
> > There are 11 section headers, starting at offset 0x230:
> 8c8
> <   [ 1] .rodata           PROGBITS         0000000000000000  00000040
> ---
> >   [ 1] .rodata           NOBITS           0000000000000000  00000040
> 10c10

Interesting find.  the .rodata of vmlinux itself is marked PROGBITS,
so its curious that GNU binutils changes the "Type" after the rename.
I doubt the code in question relies on NOBITS for this section.  Kees,
can you clarify?  Jordan, do you know what the differences are between
PROGBITS vs NOBITS?
https://people.redhat.com/mpolacek/src/devconf2012.pdf seems to
suggest NOBITS zero initializes data but I'm not sure that's what this
code wants.

>
> -----------
>
> #!/bin/bash
>
> TMP1=$(mktemp)
> TMP2=$(mktemp)
>
> git checkout next-20190513
>
> make -j$(nproc) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=out mrproper allyesconfig drivers/misc/lkdtm/
> readelf -S out/drivers/misc/lkdtm/rodata_objcopy.o > ${TMP1}
>
> curl -LSs https://lore.kernel.org/lkml/20190513222109.110020-1-ndesaulniers@google.com/raw | git am -3
>
> make -j$(nproc) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=out mrproper allyesconfig drivers/misc/lkdtm/
> readelf -S out/drivers/misc/lkdtm/rodata_objcopy.o > ${TMP2}
>
> diff ${TMP1} ${TMP2}



-- 
Thanks,
~Nick Desaulniers
