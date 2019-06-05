Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8092AC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE2C206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="brFnAQBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfFER1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 13:27:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43623 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfFER1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 13:27:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so12759317pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 10:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3Lwn5KZOUsmk/CRmt27tCNdDcr83HnHWyJ2IYSv5hU=;
        b=brFnAQBTHCmizluyZdMy/yCOBe4bRtDcpPheZP3WtwvWtaQLm6jSU5flAYbI3SyF/X
         NsSQ9cLWedTCWdSwLhFp9cCmNYDn1Del4bCQMvTIPxMeiIbXKwTdUcquEn7WTs1H/8pa
         lZggkmglMEYZFLnYzbg4r0SSdLGRyY918JaArc+/bhECb+Tdsokcp6QeBaAkrLv+qIvU
         usqKESIHK+0J2y16O/WpW867KbjhpP01d840yg7p9JAjtqLrVM0QtS9ef+RzQ/42215F
         MSeK8RpwOE2dQadDwMNvwIbstYHxZdGNrn5MBBL1t2TFeoaFDeEz2zmsQMBr6XVOgwep
         mFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3Lwn5KZOUsmk/CRmt27tCNdDcr83HnHWyJ2IYSv5hU=;
        b=AxGMi90AljRb9ICd5AV+00C2UvddoNzXlppvpuAXjq1Ik8P4DWgWY9swOxQMjFFe+k
         DB8bVZe/1kVLCFdK03RKJ00fBQ94EDyMRWuaypySktUZ0Tt1tkJSy0DZxHyz4aGoMCSP
         VdGYSZ2QD0q3LoCw46RR/Uq2F2BcgdI3zebqwnA3vdGIOaePo13SPsNTMPt9BwV4BQ/m
         BfwvXhIFp+EmrOcX/6/mreRWZdEa2TdYcyHU4/K/kvjaYk8uLmsp0kKYY4afbbu1rbvD
         cBeL9pBbApG3mUGyiRna16dWUmcJvVnyhfrJmoA1DNhacq/LYBorXPG5u7CI878KAQLN
         CtcQ==
X-Gm-Message-State: APjAAAVe61OPZzvtv/68N6/WrdzoFit0Cm4F+ZJK0CGese6jXtf6Hc8W
        HZBH5K5AqXRwGXfi8tT9cshQjc2XRfLmxP5rEOfQzQ==
X-Google-Smtp-Source: APXvYqwxZIYD2tLmmhQv3OzjZw27K48ikdGJtfISMIYl3KxAF7Me2oDV7nlo+eCZNjc9maLRAaXhTwTP5NQEEUdDxAw=
X-Received: by 2002:a62:1b85:: with SMTP id b127mr48116131pfb.165.1559755663352;
 Wed, 05 Jun 2019 10:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <779905244.a0lJJiZRjM@devpool35> <20190605162626.GA31164@kroah.com>
In-Reply-To: <20190605162626.GA31164@kroah.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 Jun 2019 10:27:32 -0700
Message-ID: <CAKwvOdnegLvkAa+-2uc-GM63HLcucWZtN5OoFvocLs50iLNJLg@mail.gmail.com>
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
        Matthias Kaehlcke <mka@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 9:26 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 05, 2019 at 05:19:40PM +0200, Rolf Eike Beer wrote:
> > I decided to dig out a toy project which uses a DragonBoard 410c. This has
> > been "running" with kernel 4.9, which I would keep this way for unrelated
> > reasons. The vanilla 4.9 kernel wasn't bootable back then, but it was
> > buildable, which was good enough.
> >
> > Upgrading the kernel to 4.9.180 caused the boot to suddenly fail:
> >
> > aarch64-unknown-linux-gnueabi-ld: ./drivers/firmware/efi/libstub/lib.a(arm64-
> > stub.stub.o): in function `handle_kernel_image':
> > /tmp/e2/build/linux-4.9.139/drivers/firmware/efi/libstub/arm64-stub.c:63:
> > undefined reference to `__efistub__GLOBAL_OFFSET_TABLE_'
> > aarch64-unknown-linux-gnueabi-ld: ./drivers/firmware/efi/libstub/lib.a(arm64-
> > stub.stub.o): relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol
> > `__efistub__GLOBAL_OFFSET_TABLE_' which may bind externally can not be used
> > when making a shared object; recompile with -fPIC
> > /tmp/e2/build/linux-4.9.139/drivers/firmware/efi/libstub/arm64-stub.c:63:
> > (.init.text+0xc): dangerous relocation: unsupported relocation
> > /tmp/e2/build/linux-4.9.139/Makefile:1001: recipe for target 'vmlinux' failed
> > -make[1]: *** [vmlinux] Error 1
> >
> > This is caused by commit 27b5ebf61818749b3568354c64a8ec2d9cd5ecca from
> > linux-4.9.y (which is 91ee5b21ee026c49e4e7483de69b55b8b47042be), reverting
> > this commit fixes the build.
> >
> > This happens with vanilla binutils 2.32 and gcc 8.3.0 as well as 9.1.0. See
> > the attached .config for reference.
> >
> > If you have questions or patches just ping me.
>
> Does Linus's latest tree also fail for you (or 5.1)?
>
> Nick, do we need to add another fix that is in mainline for this to work
> properly?
>
> thanks,
>
> greg k-h

Doesn't immediately ring any bells for me.

+mka@ who helped test 91ee5b21ee026c49e4e7483de69b55b8b47042be.
Nothing in that series
(https://lore.kernel.org/lkml/20170818194947.19347-5-ard.biesheuvel@linaro.org/T/#u)
is immediately obvious.

Rolf, can you please email me your config so I can see if I can
reproduce?  Also, which version of GCC are you using, and binutils?
(would be good to know if you hit this in mainline too, as if not
maybe there's an existing fix to be backported to stable).
-- 
Thanks,
~Nick Desaulniers
