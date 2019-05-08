Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8799C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9688020675
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557324265;
	bh=KlTf0lMaCe47EgBjCnPByj4hDErmqmcJfE6SdzLc12M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HJK2lWrj8DiWRaaOuF43Z+YWNELNCiFyrt2MwMdQptD1DfCvJHruMRPAZ+RjvqwSp
	 ulANbx5caYMDAd/gKmP3u0gCRXfiPS17G9vDu06scAPvwiKv4kPpkskvDhHgaukD7z
	 H6zJJDJqXtarwMfx+G0hgSwK9bLDnRD301GAOepg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfEHOEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 10:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfEHOEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:04:24 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B663B20675;
        Wed,  8 May 2019 14:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557324262;
        bh=KlTf0lMaCe47EgBjCnPByj4hDErmqmcJfE6SdzLc12M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2buYcneBmgQ5V4Iw6o/K3ZrNV0b77ofTlHXyAj0b4jQdn9AtpAzSTjEwoAqk1h+gT
         ueccm04t06vQFNAXTBQ+YbLu1GfVVzYoBQuoRJdtEiSMwzKRKD8Oe//WdpKM+50KYZ
         3ke6V30/bQeBnbleUiNNiV6w6lxABp63FSReE2gM=
Received: by mail-qk1-f170.google.com with SMTP id g190so3412175qkf.8;
        Wed, 08 May 2019 07:04:22 -0700 (PDT)
X-Gm-Message-State: APjAAAW0AV67+XHzAeoLmJgw1+ZmTBsRolfVgFVwH+2ehtXyBt2MT6/7
        ltmqXgZLW4/EZugC0aX/ezH6VIWTvzoCmKnb2w==
X-Google-Smtp-Source: APXvYqwcHIVFkIoGCXVZq2f5fTsv1WzR50s06Zc88lHoMFN67drmKMqTiFVbYH/8xeLwoA2P5feUPfU7TuRdlEMoJ30=
X-Received: by 2002:a37:4711:: with SMTP id u17mr29663919qka.326.1557324261976;
 Wed, 08 May 2019 07:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190507045433.542-1-hsinyi@chromium.org> <CAL_Jsq+rGeFKAPVmPvv_Z+G=BppKUK-tEUphBajZVxFtbRBJvQ@mail.gmail.com>
 <CAJMQK-iVhScf0ybZ85kqP0B5_QPoYZ9PZt35jHRUh8FNHKvu7w@mail.gmail.com>
In-Reply-To: <CAJMQK-iVhScf0ybZ85kqP0B5_QPoYZ9PZt35jHRUh8FNHKvu7w@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 8 May 2019 09:04:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJZ+mOnrLWt0Cpo_Ybr_ohxwWom1qiyV8_EFocULde7=Q@mail.gmail.com>
Message-ID: <CAL_JsqJZ+mOnrLWt0Cpo_Ybr_ohxwWom1qiyV8_EFocULde7=Q@mail.gmail.com>
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

On Tue, May 7, 2019 at 11:08 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Wed, May 8, 2019 at 3:47 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > +boot-architecture list as there was some discussion about this IIRC.
> >
> > On Mon, May 6, 2019 at 11:54 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > >
> > > Introducing a chosen node, rng-seed, which is an 64 bytes entropy
> > > that can be passed to kernel called very early to increase device
> > > randomness. Bootloader should provide this entropy and the value is
> > > read from /chosen/rng-seed in DT.
> > >
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > >
> > > ---
> > >  Documentation/devicetree/bindings/chosen.txt | 14 +++++++++
> >
> > Actually, this file has been converted to json-schema and lives
> > here[1]. I need to remove this one (or leave it with a reference to
> > the new one).
> >
> > >  arch/arm64/kernel/setup.c                    |  2 ++
> > >  drivers/of/fdt.c                             | 33 ++++++++++++++++++++
> > >  include/linux/of_fdt.h                       |  1 +
> > >  4 files changed, 50 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> > > index 45e79172a646..bfd360691650 100644
> > > --- a/Documentation/devicetree/bindings/chosen.txt
> > > +++ b/Documentation/devicetree/bindings/chosen.txt
> > > @@ -28,6 +28,20 @@ mode) when EFI_RNG_PROTOCOL is supported, it will be overwritten by
> > >  the Linux EFI stub (which will populate the property itself, using
> > >  EFI_RNG_PROTOCOL).
> > >
> > > +rng-seed
> > > +-----------
> > > +
> > > +This property served as an entropy to add device randomness. It is parsed
> > > +as a 64 byte value, e.g.
> >
> > Why only 64-bytes?
> We can also not specify size and read what bootloader can provide.
> >
> > > +
> > > +/ {
> > > +       chosen {
> > > +               rng-seed = <0x31951b3c 0xc9fab3a5 0xffdf1660 ...>
> > > +       };
> > > +};
> > > +
> > > +This random value should be provided by bootloader.
> > > +
> > >  stdout-path
> > >  -----------
> > >
> > > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > > index 413d566405d1..ade4261516dd 100644
> > > --- a/arch/arm64/kernel/setup.c
> > > +++ b/arch/arm64/kernel/setup.c
> > > @@ -292,6 +292,8 @@ void __init setup_arch(char **cmdline_p)
> > >         early_fixmap_init();
> > >         early_ioremap_init();
> > >
> > > +       early_init_dt_rng_seed(__fdt_pointer);
> > > +
> >
> > I'm trying to reduce or eliminate all these early_init_dt_* calls.
> >
> > Why is this arch specific and why can't this be done after
> > unflattening? It doesn't look like add_device_randomness() needs
> > anything early.
> Currently unflattening is called after setup_machine_fdt(), which
> called fixmap_remap_fdt() //__fixmap_remap_fdt(dt_phys, &size,
> PAGE_KERNEL_RO), and we can't modify DT after that since it's read
> only. But we need to clear (eg. write 0 to it) the rng-seed after
> reading from DT.

Why do you need to clear it? That wasn't necessary for kaslr-seed.

Why not change the mapping to RW? It would be nice if this worked on
more than one arch.

Rob
