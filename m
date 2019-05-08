Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE09C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883A1205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557331646;
	bh=te54V3NhPkNW+a43eelFgW7lbyLaibO+I4GVSEk3qXw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t3sD+GvXMSq8dYujRW1QI5unuKpb9T52EgJmAhvWbaI/Tax/m3L1IK/E7dazUJoyi
	 oPj++M6/9fo6RH9LZoZYI4cf5SLt2JMelALe+N0BKzhcMdWCXe+flv0I6mOTb0jT7o
	 UhueO6qlWONf69wt6lz/sWbUmVMsMAb1DMSZ/XL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfEHQHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbfEHQHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:07:25 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87689205ED;
        Wed,  8 May 2019 16:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557331643;
        bh=te54V3NhPkNW+a43eelFgW7lbyLaibO+I4GVSEk3qXw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q+o+ivGOYKnJ6b9ykMfgbS4vzA3BGLl54ww2Xofcm0UOV9TJSpmuz5F9D3Va8ADqc
         csApdokkVNkGQ2FL4NZXGAqKizZZW74HoBvJ9kxmVsGFAzM9suNf1IYrZH0x+/2xBl
         B57SZ8QwTMsU1/WC+f4/5t4RKXpohO4l0bKdkDS4=
Received: by mail-qk1-f169.google.com with SMTP id z6so3173391qkl.10;
        Wed, 08 May 2019 09:07:23 -0700 (PDT)
X-Gm-Message-State: APjAAAXBQxbitoNuPL/CfG9OuOIE5MZZNxiB99Je5qWAwJT9j2SeHN7c
        oe9KMmYm84f//UBXJpUgRK9eWMm1i0gb7o7Njg==
X-Google-Smtp-Source: APXvYqwEF0OtcZ6zJJFdozw4W+iSEB9XlfGbMQuQNP+kKQQ/TIN/ccVX5EntxaCaQHOQ+VPuQmHdYBurhou8rFCVTgc=
X-Received: by 2002:a37:4a12:: with SMTP id x18mr29573795qka.184.1557331642793;
 Wed, 08 May 2019 09:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190507045433.542-1-hsinyi@chromium.org> <CAL_Jsq+rGeFKAPVmPvv_Z+G=BppKUK-tEUphBajZVxFtbRBJvQ@mail.gmail.com>
 <CAJMQK-iVhScf0ybZ85kqP0B5_QPoYZ9PZt35jHRUh8FNHKvu7w@mail.gmail.com>
 <CAL_JsqJZ+mOnrLWt0Cpo_Ybr_ohxwWom1qiyV8_EFocULde7=Q@mail.gmail.com> <CAJMQK-jjzYwX3NZAKJ-8ypjcN75o-ZX4iOVD=84JecEd4qV1bA@mail.gmail.com>
In-Reply-To: <CAJMQK-jjzYwX3NZAKJ-8ypjcN75o-ZX4iOVD=84JecEd4qV1bA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 8 May 2019 11:07:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLnmedF5cJYH+91U2Q_WX755O8TQs6Ue9mqtEiFKcjGWQ@mail.gmail.com>
Message-ID: <CAL_JsqLnmedF5cJYH+91U2Q_WX755O8TQs6Ue9mqtEiFKcjGWQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: add support for rng-seed
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Architecture Mailman List <boot-architecture@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 10:06 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Wed, May 8, 2019 at 10:04 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Tue, May 7, 2019 at 11:08 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > >
> > > On Wed, May 8, 2019 at 3:47 AM Rob Herring <robh+dt@kernel.org> wrote:
> > > >
> > > > +boot-architecture list as there was some discussion about this IIRC.
> > > >
> > > > On Mon, May 6, 2019 at 11:54 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > > > >
> > > > > Introducing a chosen node, rng-seed, which is an 64 bytes entropy
> > > > > that can be passed to kernel called very early to increase device
> > > > > randomness. Bootloader should provide this entropy and the value is
> > > > > read from /chosen/rng-seed in DT.
> > > > >
> > > > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > > >
> > > > > ---
> > > > >  Documentation/devicetree/bindings/chosen.txt | 14 +++++++++
> > > >
> > > > Actually, this file has been converted to json-schema and lives
> > > > here[1]. I need to remove this one (or leave it with a reference to
> > > > the new one).
> > > >
> > > > >  arch/arm64/kernel/setup.c                    |  2 ++
> > > > >  drivers/of/fdt.c                             | 33 ++++++++++++++++++++
> > > > >  include/linux/of_fdt.h                       |  1 +
> > > > >  4 files changed, 50 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> > > > > index 45e79172a646..bfd360691650 100644
> > > > > --- a/Documentation/devicetree/bindings/chosen.txt
> > > > > +++ b/Documentation/devicetree/bindings/chosen.txt
> > > > > @@ -28,6 +28,20 @@ mode) when EFI_RNG_PROTOCOL is supported, it will be overwritten by
> > > > >  the Linux EFI stub (which will populate the property itself, using
> > > > >  EFI_RNG_PROTOCOL).
> > > > >
> > > > > +rng-seed
> > > > > +-----------
> > > > > +
> > > > > +This property served as an entropy to add device randomness. It is parsed
> > > > > +as a 64 byte value, e.g.
> > > >
> > > > Why only 64-bytes?
> > > We can also not specify size and read what bootloader can provide.
> > > >
> > > > > +
> > > > > +/ {
> > > > > +       chosen {
> > > > > +               rng-seed = <0x31951b3c 0xc9fab3a5 0xffdf1660 ...>
> > > > > +       };
> > > > > +};
> > > > > +
> > > > > +This random value should be provided by bootloader.
> > > > > +
> > > > >  stdout-path
> > > > >  -----------
> > > > >
> > > > > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > > > > index 413d566405d1..ade4261516dd 100644
> > > > > --- a/arch/arm64/kernel/setup.c
> > > > > +++ b/arch/arm64/kernel/setup.c
> > > > > @@ -292,6 +292,8 @@ void __init setup_arch(char **cmdline_p)
> > > > >         early_fixmap_init();
> > > > >         early_ioremap_init();
> > > > >
> > > > > +       early_init_dt_rng_seed(__fdt_pointer);
> > > > > +
> > > >
> > > > I'm trying to reduce or eliminate all these early_init_dt_* calls.
> > > >
> > > > Why is this arch specific and why can't this be done after
> > > > unflattening? It doesn't look like add_device_randomness() needs
> > > > anything early.
> > > Currently unflattening is called after setup_machine_fdt(), which
> > > called fixmap_remap_fdt() //__fixmap_remap_fdt(dt_phys, &size,
> > > PAGE_KERNEL_RO), and we can't modify DT after that since it's read
> > > only. But we need to clear (eg. write 0 to it) the rng-seed after
> > > reading from DT.
> >
> > Why do you need to clear it? That wasn't necessary for kaslr-seed.
> I think it's for security purpose. If we know the random seed, it's
> more likely we can predict randomness.
> Currently on arm64, kaslr-seed will be wiped out (in
> arch/arm64/kernel/kaslr.c#get_kaslr_seed(), it's set to 0) so we can't
> read from sysfs (eg. /sys/firmware/devicetree/.../kaslr-seed)
> I'm not sure on other arch if it will be wiped out.

The difference is if I have the kaslr seed, I can calculate the kernel
base address.

In your case, you are feeding an RNG which continually has entropy
added to it. I can't see that knowing one piece of the entropy data is
a security hole. It looks more like you've just copied what what done
for kaslr-seed.

> > Why not change the mapping to RW? It would be nice if this worked on
> > more than one arch.

Still wondering on this question. Mapping it R/W would mean rng-seed
could be handled later and completely out of the arch code and so
could the zeroing of the kaslr-seed. Also, we generally assume the FDT
is modifiable for any fixups. This happens on arm32 and powerpc, but I
guess we haven't needed that yet on arm64.

Rob
