Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4A2C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFDE20656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YyvjUF7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfEHPGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:06:16 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40581 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfEHPGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:06:15 -0400
Received: by mail-qk1-f195.google.com with SMTP id w20so1028851qka.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 08:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDzDsVMU+LJr7Vip7FUWGFjPTFwrPecpVC+p71dwHL0=;
        b=YyvjUF7kcpOEi0nE6dzVsg/gcQTmv5N8+kMHVneU2YA724wvUKi6bG88nc2ddw8bwh
         xQWEOtv1wgEx0039HHBmyRo0mYya6XFQesGUURR537siA2xMVgsISqv6MqgcHvOE01gZ
         WUTtn0x8U7/FWPvWp3kHk1dWp4H/CicnYmdTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDzDsVMU+LJr7Vip7FUWGFjPTFwrPecpVC+p71dwHL0=;
        b=o/H4TjGnEdGv5ucBjgs/xZO8ze3AFGlxnfA18JW/TWMn8njzmMlUM+WxCD77xWcDy/
         EUrc6ez49qCWLj0exKtqPVgSeO7WsoDmJx/2D5fmpaghORRQ4Ddog+bkMgrK+c/Nfk/e
         BYebJhqnHg51P53sYmM5eABbygBkuvbUVsPJXZuAdHd9Ym5GVZdd45aAUyL2bPHd5NHd
         wCvC3umQk6tzzUBDB/I1WLeFZnkSPb9UcZPDFX7z/gsF3n+60/PhhnEY6OduVG6vcoT7
         jkdrE9E9VZSHaFk/nUWGBr+ICbnnLETmz5YH8gw8oFuuWvDL7f89CFuCOmYgOBZC2ZhT
         0lGA==
X-Gm-Message-State: APjAAAW95hRQhbYU9/I9RTf9JXOEOe81y81CU55g5JyTzRFTw2disk4k
        0ciJ6OU9faS3TnIfXt9bO0m3qRX9PpHU8w9mUGOLHg==
X-Google-Smtp-Source: APXvYqzKF9hpiQ7++7G8HoeOWq1DqYNKoDcAsjHDKXSfNfIFkZYm1Ylb5eOULOWWNB0JjrIWx70mQF4jn2aNPXQtqnc=
X-Received: by 2002:a05:620a:16c3:: with SMTP id a3mr6908351qkn.222.1557327974036;
 Wed, 08 May 2019 08:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190507045433.542-1-hsinyi@chromium.org> <CAL_Jsq+rGeFKAPVmPvv_Z+G=BppKUK-tEUphBajZVxFtbRBJvQ@mail.gmail.com>
 <CAJMQK-iVhScf0ybZ85kqP0B5_QPoYZ9PZt35jHRUh8FNHKvu7w@mail.gmail.com> <CAL_JsqJZ+mOnrLWt0Cpo_Ybr_ohxwWom1qiyV8_EFocULde7=Q@mail.gmail.com>
In-Reply-To: <CAL_JsqJZ+mOnrLWt0Cpo_Ybr_ohxwWom1qiyV8_EFocULde7=Q@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 8 May 2019 23:05:47 +0800
Message-ID: <CAJMQK-jjzYwX3NZAKJ-8ypjcN75o-ZX4iOVD=84JecEd4qV1bA@mail.gmail.com>
Subject: Re: [PATCH] arm64: add support for rng-seed
To:     Rob Herring <robh+dt@kernel.org>
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

On Wed, May 8, 2019 at 10:04 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, May 7, 2019 at 11:08 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > On Wed, May 8, 2019 at 3:47 AM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > +boot-architecture list as there was some discussion about this IIRC.
> > >
> > > On Mon, May 6, 2019 at 11:54 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > > >
> > > > Introducing a chosen node, rng-seed, which is an 64 bytes entropy
> > > > that can be passed to kernel called very early to increase device
> > > > randomness. Bootloader should provide this entropy and the value is
> > > > read from /chosen/rng-seed in DT.
> > > >
> > > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > >
> > > > ---
> > > >  Documentation/devicetree/bindings/chosen.txt | 14 +++++++++
> > >
> > > Actually, this file has been converted to json-schema and lives
> > > here[1]. I need to remove this one (or leave it with a reference to
> > > the new one).
> > >
> > > >  arch/arm64/kernel/setup.c                    |  2 ++
> > > >  drivers/of/fdt.c                             | 33 ++++++++++++++++++++
> > > >  include/linux/of_fdt.h                       |  1 +
> > > >  4 files changed, 50 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> > > > index 45e79172a646..bfd360691650 100644
> > > > --- a/Documentation/devicetree/bindings/chosen.txt
> > > > +++ b/Documentation/devicetree/bindings/chosen.txt
> > > > @@ -28,6 +28,20 @@ mode) when EFI_RNG_PROTOCOL is supported, it will be overwritten by
> > > >  the Linux EFI stub (which will populate the property itself, using
> > > >  EFI_RNG_PROTOCOL).
> > > >
> > > > +rng-seed
> > > > +-----------
> > > > +
> > > > +This property served as an entropy to add device randomness. It is parsed
> > > > +as a 64 byte value, e.g.
> > >
> > > Why only 64-bytes?
> > We can also not specify size and read what bootloader can provide.
> > >
> > > > +
> > > > +/ {
> > > > +       chosen {
> > > > +               rng-seed = <0x31951b3c 0xc9fab3a5 0xffdf1660 ...>
> > > > +       };
> > > > +};
> > > > +
> > > > +This random value should be provided by bootloader.
> > > > +
> > > >  stdout-path
> > > >  -----------
> > > >
> > > > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > > > index 413d566405d1..ade4261516dd 100644
> > > > --- a/arch/arm64/kernel/setup.c
> > > > +++ b/arch/arm64/kernel/setup.c
> > > > @@ -292,6 +292,8 @@ void __init setup_arch(char **cmdline_p)
> > > >         early_fixmap_init();
> > > >         early_ioremap_init();
> > > >
> > > > +       early_init_dt_rng_seed(__fdt_pointer);
> > > > +
> > >
> > > I'm trying to reduce or eliminate all these early_init_dt_* calls.
> > >
> > > Why is this arch specific and why can't this be done after
> > > unflattening? It doesn't look like add_device_randomness() needs
> > > anything early.
> > Currently unflattening is called after setup_machine_fdt(), which
> > called fixmap_remap_fdt() //__fixmap_remap_fdt(dt_phys, &size,
> > PAGE_KERNEL_RO), and we can't modify DT after that since it's read
> > only. But we need to clear (eg. write 0 to it) the rng-seed after
> > reading from DT.
>
> Why do you need to clear it? That wasn't necessary for kaslr-seed.
I think it's for security purpose. If we know the random seed, it's
more likely we can predict randomness.
Currently on arm64, kaslr-seed will be wiped out (in
arch/arm64/kernel/kaslr.c#get_kaslr_seed(), it's set to 0) so we can't
read from sysfs (eg. /sys/firmware/devicetree/.../kaslr-seed)
I'm not sure on other arch if it will be wiped out.
>
> Why not change the mapping to RW? It would be nice if this worked on
> more than one arch.
>
> Rob
