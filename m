Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2A0C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41E52089F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vm2SuMXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390262AbfIWQlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:41:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43316 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387922AbfIWQlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:41:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id q17so14743795wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 09:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FXoCM+vURwhSk7IHFkXmfesD/d5r88C2Nn0FFc0Z0aM=;
        b=Vm2SuMXHk/xd1lnEb0fChTR6UpM5XZan8EO+pNLbFbsclXb5Ef2P2pRq1kyhS9Hc3K
         UKJFkK+NhlxpbYaTVPABYhL49/jJe42FkIgipI0KK4ihQ40JCsif6210uQ2SUj0N6zw6
         l0kfdVzlN+fq8ZPvB/B4Hp32ytdhYV0gCa6xF9qCjyEl1zMjscoOvQJLiUj+HaZYICcg
         uNyFf/Iq1EmgSDdGvRXauUe/O0QsFbkVChoAricMf7TIsnJYSIMS1RdakSF/LlHgcYql
         L/SFwY5IV+s/uPxMmuE68F3ddizk1TFdaCF6lB3gyHlHFNqKYQ9zBExLbto6EOX0iIJl
         jsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FXoCM+vURwhSk7IHFkXmfesD/d5r88C2Nn0FFc0Z0aM=;
        b=fwDp45w63k+N8Jgysl2zegPFc4xhaH307HvtwSNXiL8rmbL/Zp8IWRcIRCtem/WH0P
         OLhrfCyrTRe+RqnnkpOpHt7COD4gm6OV2m1w7r2TSyif9aReSxBYXvKUJkwKX39XNnK6
         NDZifDkcLfAytFOTPAI8pVTH4f+RKicTRahNmubTVMKFoZHjb0bU0ss0eh5qBuHmnHAQ
         Als+yPcBJuvU9/mPYRu5bZnzCDDmh6e7qCG7WaNt8SKhc4D82j3gbonQJffVR4E4GzjD
         dpWK9kjW67Dn5B41zwe9EbyvFzTqdAimE5ZAIeEQY++3z+pX5KXTzVKiy9nG+wBxzrX7
         10jQ==
X-Gm-Message-State: APjAAAVzjMsF/rOQIJFWq6tPuzbx/AKEymjEW4z0SJ4VBo2RagyxBrfd
        r6k0/0REF2JGcOcvlb+073hhLIpwSfRdnQ4Lxkc6yg==
X-Google-Smtp-Source: APXvYqzgcosAPmXoP1zU0OZTwImemvuu8iAhvqWwpvwmS91j9IKVfOo16gefUIf9LBA/CS7GhkMPGnIKq8gYizVfiUA=
X-Received: by 2002:adf:ee45:: with SMTP id w5mr288827wro.246.1569256902740;
 Mon, 23 Sep 2019 09:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck> <7f05a25a-36c7-929c-484d-bc964587917c@arm.com>
In-Reply-To: <7f05a25a-36c7-929c-484d-bc964587917c@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 23 Sep 2019 18:41:31 +0200
Message-ID: <CAKv+Gu9EvwM22HaFJvX55HQhptcNUoQZCxq3nxyzquUjcq6DUg@mail.gmail.com>
Subject: Re: Problems with arm64 compat vdso
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2019 at 18:33, Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Will,
>
> thank you for reporting this.
>
> On 20/09/2019 15:27, Will Deacon wrote:
> > Hi Vincenzo,
> >
> > I've been running into a few issues with the COMPAT vDSO. Please could
> > you have a look?
> >
>
> I will be at Linux Recipes next week. I will look at this with priority w=
hen I
> come back.
>

Hi all,

I noticed another issue: I build out of tree, and the VDSO gets
rebuilt every time I build the kernel, even if I haven't made any
changes to the source tree at all.

Could you please look into that as well? (once you get around to it)

Thanks,
Ard.


> > If I do the following:
> >
> > $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- defconfig
> > [...]
> > $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- menuconfig
> > [set CONFIG_CROSS_COMPILE_COMPAT_VDSO=3D"arm-linux-gnueabihf-"]
> > $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu-
> >
> > Then I see the following warning:
> >
> > arch/arm64/Makefile:62: CROSS_COMPILE_COMPAT not defined or empty, the =
compat vDSO will not be built
> >
> > even though the compat vDSO *has* been built:
> >
> > $ file arch/arm64/kernel/vdso32/vdso.so
> > arch/arm64/kernel/vdso32/vdso.so: ELF 32-bit LSB pie executable, ARM, E=
ABI5 version 1 (SYSV), dynamically linked, BuildID[sha1]=3Dc67f6c786f2d2d6f=
86c71f708595594aa25247f6, stripped
> >
> > However, I also get some warnings because arm64 headers are being inclu=
ded
> > in the compat vDSO build:
> >
> > In file included from ./arch/arm64/include/asm/thread_info.h:17:0,
> >                  from ./include/linux/thread_info.h:38,
> >                  from ./arch/arm64/include/asm/preempt.h:5,
> >                  from ./include/linux/preempt.h:78,
> >                  from ./include/linux/spinlock.h:51,
> >                  from ./include/linux/seqlock.h:36,
> >                  from ./include/linux/time.h:6,
> >                  from /usr/local/google/home/willdeacon/work/linux/lib/=
vdso/gettimeofday.c:7,
> >                  from <command-line>:0:
> > ./arch/arm64/include/asm/memory.h: In function =E2=80=98__tag_set=E2=80=
=99:
> > ./arch/arm64/include/asm/memory.h:233:15: warning: cast from pointer to=
 integer of different size [-Wpointer-to-int-cast]
> >   u64 __addr =3D (u64)addr & ~__tag_shifted(0xff);
> >                ^
> > In file included from ./arch/arm64/include/asm/pgtable-hwdef.h:8:0,
> >                  from ./arch/arm64/include/asm/processor.h:34,
> >                  from ./arch/arm64/include/asm/elf.h:118,
> >                  from ./include/linux/elf.h:5,
> >                  from ./include/linux/elfnote.h:62,
> >                  from arch/arm64/kernel/vdso32/note.c:11:
> > ./arch/arm64/include/asm/memory.h: In function =E2=80=98__tag_set=E2=80=
=99:
> > ./arch/arm64/include/asm/memory.h:233:15: warning: cast from pointer to=
 integer of different size [-Wpointer-to-int-cast]
> >   u64 __addr =3D (u64)addr & ~__tag_shifted(0xff);
> >                ^
> > Worse, if your compat binutils isn't up-to-date, you'll actually run in=
to
> > a build failure:
> >
> > /tmp/ccFCrjUg.s:80: Error: invalid barrier type -- `dmb ishld'
> > /tmp/ccFCrjUg.s:124: Error: invalid barrier type -- `dmb ishld'
> >
> > There also appears to be a problem getting the toolchain prefix from Kc=
onfig.
> > If, for example, I do:
> >
> > $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- defconfig
> > [...]
> > $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- menuconfig
> > [set CONFIG_CROSS_COMPILE_COMPAT_VDSO=3D"vincenzo"]
> > $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu-
> > arch/arm64/Makefile:64: *** vincenzogcc not found, check CROSS_COMPILE_=
COMPAT.  Stop.
> > $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- menuconfig
> > [set CONFIG_CROSS_COMPILE_COMPAT_VDSO=3D"arm-linux-gnueabihf-"]
> > $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu-
> > arch/arm64/Makefile:64: *** vincenzogcc not found, check CROSS_COMPILE_=
COMPAT.  Stop.
> > $ grep CONFIG_CROSS_COMPILE_COMPAT_VDSO .config
> > CONFIG_CROSS_COMPILE_COMPAT_VDSO=3D"arm-linux-gnueabihf-"
> >
> > which is irritating, because it seems to force a 'mrproper' if you don'=
t
> > get the prefix right first time.
> >
> > Cheers,
> >
> > Will
> >
>
> --
> Regards,
> Vincenzo
