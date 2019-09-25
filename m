Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F254C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63AD21D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ReGJW3sd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390521AbfIYQfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 12:35:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40143 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388566AbfIYQfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 12:35:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so87712pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 09:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mPt8nETl12RMHNEm39NI8Pt00xmglqOV/flAb9Vcyeo=;
        b=ReGJW3sdE/VTfIUENvL+niL/4F1/GnzTwqVvSJTIO9/XpMAw1uvQ0IdZLov1RRgOXn
         b6yj6L8xV2Ka0z7DEzUrEL5mxxU1bWlZSWQHuSyFea2co2/olTtzS2j+ntIvdsfp5aO9
         Pi3ZCjJLoKPMenwwR6aGQYnWzObYvoCCgSMogxhPQMhjN6cezjNO/BbCDyzGYb9KEL/u
         F6WFWvTmCfExHWO56mqQNWggFN1DupqYpQdxg/LXcA+58jUn9RoOmdm2nyw+21DF3o0R
         ghaJ/B8EOaVLRg132Bm9Q6UyWPNAGhuKGXlokYHeZKZ06OJXAGGUP2FK1v9T8SFAGHB6
         iPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mPt8nETl12RMHNEm39NI8Pt00xmglqOV/flAb9Vcyeo=;
        b=tzFHffbvlwchzP4lZzUHFNwHyIM/thHgP1fXw5NBOOrtM+08xagjdS3HOL60uzPMB2
         8Y892gZyXiv7Lxmk6+5QddPPfMV7TgizksVP9Kw9rdgAoaKs3vol1/Vvx+1BGpuGG0y+
         tuPnv+MMOf8sAy9uYFULsQDO0G+Ju41Wx5Xz785gWy78n2OaUzmtFHuLYLIIvENPS4oH
         ertH4kOXML84O9rZYitqircaN9kXRRvePHJl5W7ZfAHxS07iZzuyfxvkhhk0i6lAWrPi
         RXJgVay1O4k8NPEyS43NdXSzsvKTElevtKB7QqKaXF99CDN5QQkwdYxZre4yJXWoVWZ2
         ueuQ==
X-Gm-Message-State: APjAAAVSrcNSnO+piCr3AWe+xV/7XTz28HsLNKHu1NhAtkFEJ7oZjDkc
        eENC17yG99DV4cfIg5SdZI9eq2WDC8x6ia/zn/wt5g==
X-Google-Smtp-Source: APXvYqwYq8+L73SVhEe3D3YBp4dgCxMIF9vqvVXmHNM6vME53NmqKSx1P/bKg4aMw46AEow+92+ZehYtVSVTbeFTj48=
X-Received: by 2002:a63:d908:: with SMTP id r8mr191790pgg.263.1569429336296;
 Wed, 25 Sep 2019 09:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmFqPSyeKn-0th_ca9B3QU63G__kEJ=X0tfjhE+1_p=FQ@mail.gmail.com>
 <20190924193310.132104-1-ndesaulniers@google.com> <20190925102041.GB3891@zn.tnic>
In-Reply-To: <20190925102041.GB3891@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Sep 2019 09:35:24 -0700
Message-ID: <CAKwvOdneE7kMupFzxZC-6c=ps_98FP+Nz88fCXQ74z90hmaaXQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86, realmode: explicitly set entry via command line
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Jarkko Sakkinen <jarkko.sakkinen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Tri Vo <trong@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh@kernel.org>,
        George Rimar <grimar@accesssoftek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Fangrui Song <maskray@google.com>,
        Peter Smith <Peter.Smith@arm.com>, Rui Ueyama <ruiu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Fangrui, Peter, Rui, George (LLD)

On Wed, Sep 25, 2019 at 3:20 AM Borislav Petkov <bp@alien8.de> wrote:
>
> + some more people who did the unified realmode thing.
>
> On Tue, Sep 24, 2019 at 12:33:08PM -0700, Nick Desaulniers wrote:
> > Linking with ld.lld via $ make LD=ld.lld produces the warning:
> > ld.lld: warning: cannot find entry symbol _start; defaulting to 0x1000
> >
> > Linking with ld.bfd shows the default entry is 0x1000:
> > $ readelf -h arch/x86/realmode/rm/realmode.elf | grep Entry
> >   Entry point address:               0x1000
> >
> > While ld.lld is being pedantic, just set the entry point explicitly,
> > instead of depending on the implicit default.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/216
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> > Changes V1 -> V2:
> > * Use command line flag, rather than linker script, as ld.bfd produces a
> >   syntax error for `ENTRY(0x1000)` but is happy with `-e 0x1000`
> >
> >  arch/x86/realmode/rm/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
> > index f60501a384f9..338a00c5257f 100644
> > --- a/arch/x86/realmode/rm/Makefile
> > +++ b/arch/x86/realmode/rm/Makefile
> > @@ -46,7 +46,7 @@ $(obj)/pasyms.h: $(REALMODE_OBJS) FORCE
> >  targets += realmode.lds
> >  $(obj)/realmode.lds: $(obj)/pasyms.h
> >
> > -LDFLAGS_realmode.elf := -m elf_i386 --emit-relocs -T
> > +LDFLAGS_realmode.elf := -m elf_i386 --emit-relocs -e 0x1000 -T
>
> So looking at arch/x86/realmode/rm/realmode.lds.S: what's stopping
> people from adding more sections before the first
>
> . = ALIGN(PAGE_SIZE);
>
> which, with enough bytes to go above the first 4K, would cause that
> alignment to go to 0x2000 and then your hardcoded address would be
> wrong, all of a sudden.

Thanks for the consideration Boris.  So IIUC if the preceding sections
are larger than 0x1000 altogether, setting the entry there will be
wrong?

Currently, .text looks like it's currently at 0x1000 for a defconfig,
and I assume that could move in the case I stated above?
$ readelf -S arch/x86/realmode/rm/realmode.elf | grep text
  [ 3] .text             PROGBITS        00001000 201000 000f51 00  AX
 0   0 4096
...

In that case, it seems that maybe I should set the ENTRY in the linker
script as:
diff --git a/arch/x86/realmode/rm/realmode.lds.S
b/arch/x86/realmode/rm/realmode.lds.S
index 3bb980800c58..64d135d1ee63 100644
--- a/arch/x86/realmode/rm/realmode.lds.S
+++ b/arch/x86/realmode/rm/realmode.lds.S
@@ -11,6 +11,7 @@

 OUTPUT_FORMAT("elf32-i386")
 OUTPUT_ARCH(i386)
+ENTRY(pa_text_start)

 SECTIONS
 {

-- 
Thanks,
~Nick Desaulniers
