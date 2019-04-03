Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF5BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3748B2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="k0IFccUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfDCMUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:20:54 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:59505 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDCMUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:20:53 -0400
X-Greylist: delayed 13648 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Apr 2019 08:20:51 EDT
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x33CKeWx022626;
        Wed, 3 Apr 2019 21:20:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x33CKeWx022626
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554294041;
        bh=TQlzNrWGG9CeBRdpHJD0Jy415b18W+tDfogFpAUzxj4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k0IFccUE3Y1A2HKH20rwuTzfAcWDdzMO5664eXt/L+tfA4H16944omheiMKlLlmmi
         x0g2H7a2/ErZmS+tr2aBEf5QFWUjVxkpt+tJ1AO6JDMHpPwmecGPBKQDogY8Qf/Z3r
         kiPCc0nEKwG7q+L3O1i6DeW7rbu3GNDj6qgPs9sji8D/MIB8cibxAQnmJ01u5kLBDA
         CNJCHfT8vifzybSlgya/QfN9RleH1kl9MZXC53Mo2+nqXTBpD7b3BiL6uptyAhDPZf
         AWbbTWedBGQqUColg/dT+MnSPRbcDI+Tv9s09DQBSqaXjgpTsRx7XZD6RDANZtOnRM
         mzJ2OelJ87t/Q==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id e2so9106926vsc.13;
        Wed, 03 Apr 2019 05:20:41 -0700 (PDT)
X-Gm-Message-State: APjAAAUz/UDl6tkyg9q/3XykzcZM0baYqRpz5LPR6g6ni7bnHgay0Kq/
        ziY1Eucx0ScnuRmWtZkSq1qoK9xAE0X4AnBOuAw=
X-Google-Smtp-Source: APXvYqx1JTGfLIcJwtEzBGuPv4eYn13RShHCH7HC40qEGlfWaidm3iv2N0h6gkkr8ozUJMap9lBacR4BD+xKy5WGOaY=
X-Received: by 2002:a67:c29e:: with SMTP id k30mr46197501vsj.203.1554294040230;
 Wed, 03 Apr 2019 05:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <1554280344-10741-1-git-send-email-yamada.masahiro@socionext.com> <CAKwvOdkrMB-pvjhuFXPCb-v-6nRkRcm+y5iApNcJHiTd=bdeaw@mail.gmail.com>
In-Reply-To: <CAKwvOdkrMB-pvjhuFXPCb-v-6nRkRcm+y5iApNcJHiTd=bdeaw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 3 Apr 2019 21:20:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNARbmuCKjkMP-_ZNLUm1XBjxG7RoMJf5-xcNjnv5rVwVOw@mail.gmail.com>
Message-ID: <CAK7LNARbmuCKjkMP-_ZNLUm1XBjxG7RoMJf5-xcNjnv5rVwVOw@mail.gmail.com>
Subject: Re: [PATCH] sparc: vdso: add FORCE to the build rule of %.so
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 7:36 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> $ grep -r 'call if_changed,' -B
>
> shows a few more FWIW:
>
> drivers/scsi/Makefile
> drivers/gpu/drm/radeon/Makefile
> arch/c6x/boot/Makefile
> arch/arm64/kernel/vdso/Makefile
> arch/x86/entry/vdso/Makefile
> arch/x86/entry/syscalls/Makefile
> arch/powerpc/platforms/cell/spufs/Makefile
> arch/powerpc/kernel/syscalls/Makefile
> arch/alpha/kernel/syscalls/Makefile
> arch/sparc/boot/Makefile
> arch/sparc/kernel/syscalls/Makefile
> arch/mips/kernel/syscalls/Makefile
> arch/h8300/boot/Makefile
> arch/nios2/boot/Makefile
> arch/ia64/kernel/syscalls/Makefile
> arch/microblaze/boot/dts/Makefile
> arch/microblaze/kernel/syscalls/Makefile
> arch/csky/boot/Makefile
> arch/xtensa/kernel/syscalls/Makefile
> arch/sh/boot/Makefile
> arch/sh/kernel/syscalls/Makefile
> arch/parisc/boot/compressed/Makefile
> arch/parisc/kernel/syscalls/Makefile
> arch/m68k/kernel/syscalls/Makefile
>

I sent patches for vdso Makefiles, but
lots of Makefiles are still wrong.

Your contribution is appreciated.  :)


> On Wed, Apr 3, 2019 at 3:32 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > $(call if_changed,...) must have FORCE as a prerequisite.
>
> According to Documentation/kbuild/makefiles.txt#L1064:
> ```
> Note: It is a typical mistake to forget the FORCE prerequisite.
> ```

Yeah, people often miss to add this.

There is one more thing people often miss:

 "Any target that utilises if_changed must be listed in $(targets),
  otherwise the command line check will fail, and the target will
  always be built."





> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  arch/sparc/vdso/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
> > index 74e97f7..83c4b46 100644
> > --- a/arch/sparc/vdso/Makefile
> > +++ b/arch/sparc/vdso/Makefile
> > @@ -68,7 +68,7 @@ CFLAGS_REMOVE_vdso-note.o = -pg
> >  CFLAGS_REMOVE_vclock_gettime.o = -pg
> >
> >  $(obj)/%.so: OBJCOPYFLAGS := -S
> > -$(obj)/%.so: $(obj)/%.so.dbg
> > +$(obj)/%.so: $(obj)/%.so.dbg FORCE
> >         $(call if_changed,objcopy)
> >
> >  CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
> > --
> > 2.7.4
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--
Best Regards

Masahiro Yamada
