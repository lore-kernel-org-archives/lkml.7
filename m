Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3004DC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0902D20717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBEWo0Nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfFERue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 13:50:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32849 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfFERub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 13:50:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id g21so9970572plq.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 10:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69gfPapSEdMi+yvUYn9H/fvtRsee0abVJTNm1kq4LuQ=;
        b=pBEWo0NcAk4QU02NxTDdbliP+YTRia8y0ucJJGA7LQ27Dml7fTz0Jj7L+hvksvcg2l
         +6IqellipsEcoKmeMDdrTqJFm7m0lWacCdNP/p+k0ieaT5Y+8FFdYD3/7betJZ0yMFTR
         FgJBwbPs28J/ge+AbH9zZeGFNqKupC2AzM0Mm0nWibG0fHrmi7G7q5eBkZjYo0xkr+uc
         oonNEwzsr1anDnJzm4Md4Wd0hsQklfvAAxHZKgH3bGpylKvdpqtbFRId2W5hfa5wESvZ
         26WDbHB3TtkefLuqlQ/90mBXhDsrtvXIydkK9xsU6eOy+gWFaMHbAJ5e07OOGRWsKOw9
         SEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69gfPapSEdMi+yvUYn9H/fvtRsee0abVJTNm1kq4LuQ=;
        b=YBAYpPEefCD45SPnMupGlbdax1n3hXxLrticVDbt6shtEwsAVS8nJOOxa34HbwsIMl
         dP+Kg8fvKoJk3oPy5A+Ue9FkjE/FCconxN9enrOh70HmO0N+5vLiqwZhVK5AR4NuH/Qc
         vV5iUz2lsVJhQoiysaApsCmQcASaqWgydZ44DcGyofxiu7P6gBuJxZXH3HMsj+yj2bhx
         IwIQlgVYPoAmfNFW2TLwUt7IdoFdNRQLfhfq9KuPfZRD80e2hlWYPLgMYzE0Nlse4aSn
         SDaqn/AWyoxiloxuawhUC6v87lbThbkOmh7xa/V5uEYHr92Q9Tj6umnd5SJpP2C3d31H
         MbGw==
X-Gm-Message-State: APjAAAXk11+WrO1wVleoixf3aoaHSgiGQWmSToeyBG/tN2OIwanstkIe
        Dvj2mr715iJ8JZUj+mcQY8ium/Er6bBLYn6wRw2t6g==
X-Google-Smtp-Source: APXvYqwLtyAX66huw+EWEn7pqEiSvsjOHxjps51TIKjDTCKg+Rlihh78XZh/riSWS22J7XfNQBK0HViRRXtXzVrELs8=
X-Received: by 2002:a17:902:b696:: with SMTP id c22mr43639929pls.119.1559757030282;
 Wed, 05 Jun 2019 10:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <779905244.a0lJJiZRjM@devpool35> <20190605162626.GA31164@kroah.com>
 <CAKwvOdnegLvkAa+-2uc-GM63HLcucWZtN5OoFvocLs50iLNJLg@mail.gmail.com>
In-Reply-To: <CAKwvOdnegLvkAa+-2uc-GM63HLcucWZtN5OoFvocLs50iLNJLg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 Jun 2019 10:50:19 -0700
Message-ID: <CAKwvOdn9g2Z=G_qz84S5xmn2GBNK7T-MWOGYT5C52sP0R=M_-Q@mail.gmail.com>
Subject: Re: Building arm64 EFI stub with -fpie breaks build of 4.9.x
 (undefined reference to `__efistub__GLOBAL_OFFSET_TABLE_')
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Rolf Eike Beer <eb@emlix.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Matthias Kaehlcke <mka@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 10:27 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Jun 5, 2019 at 9:26 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jun 05, 2019 at 05:19:40PM +0200, Rolf Eike Beer wrote:
> > > I decided to dig out a toy project which uses a DragonBoard 410c. This has
> > > been "running" with kernel 4.9, which I would keep this way for unrelated
> > > reasons. The vanilla 4.9 kernel wasn't bootable back then, but it was
> > > buildable, which was good enough.
> > >
> > > Upgrading the kernel to 4.9.180 caused the boot to suddenly fail:
> > >
> > > aarch64-unknown-linux-gnueabi-ld: ./drivers/firmware/efi/libstub/lib.a(arm64-
> > > stub.stub.o): in function `handle_kernel_image':
> > > /tmp/e2/build/linux-4.9.139/drivers/firmware/efi/libstub/arm64-stub.c:63:
> > > undefined reference to `__efistub__GLOBAL_OFFSET_TABLE_'
> > > aarch64-unknown-linux-gnueabi-ld: ./drivers/firmware/efi/libstub/lib.a(arm64-
> > > stub.stub.o): relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol
> > > `__efistub__GLOBAL_OFFSET_TABLE_' which may bind externally can not be used
> > > when making a shared object; recompile with -fPIC
> > > /tmp/e2/build/linux-4.9.139/drivers/firmware/efi/libstub/arm64-stub.c:63:
> > > (.init.text+0xc): dangerous relocation: unsupported relocation
> > > /tmp/e2/build/linux-4.9.139/Makefile:1001: recipe for target 'vmlinux' failed
> > > -make[1]: *** [vmlinux] Error 1
> > >
> > > This is caused by commit 27b5ebf61818749b3568354c64a8ec2d9cd5ecca from
> > > linux-4.9.y (which is 91ee5b21ee026c49e4e7483de69b55b8b47042be), reverting
> > > this commit fixes the build.
> > >
> > > This happens with vanilla binutils 2.32 and gcc 8.3.0 as well as 9.1.0. See
> > > the attached .config for reference.
> > >
> > > If you have questions or patches just ping me.
> >
> > Does Linus's latest tree also fail for you (or 5.1)?
> >
> > Nick, do we need to add another fix that is in mainline for this to work
> > properly?
> >
> > thanks,
> >
> > greg k-h
>
> Doesn't immediately ring any bells for me.

Upstream commits:
dd6846d77469 ("arm64: drop linker script hack to hide __efistub_ symbols")
1212f7a16af4 ("scripts/kallsyms: filter arm64's __efistub_ symbols")

Look related to __efistub__ prefixes on symbols and aren't in stable
4.9 (maybe Rolf can try cherry picks of those).
-- 
Thanks,
~Nick Desaulniers
