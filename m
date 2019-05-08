Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A3EC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294CA21479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kVKVo365"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfEHEIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 00:08:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33058 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfEHEIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 00:08:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id m32so18622478qtf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 21:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yWv0q/m4CXezpbIlYfskiZo9emgFBrM3RwTHD33KBco=;
        b=kVKVo365dv38tjyldZmSX4x+Gspo1e9OHAtatit3DPIngDXLiouFZhBbwxWfVK/oy9
         9wtAKu2Va6gUaMEQ3PQVQMPOev3ZlUBZq4wb+aJNnCNGofPOK2hZFUbPqi26RSZmJpHG
         1Q4n64GatxtWH1Pv+cmP5qnFg55BYBEkVbzCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yWv0q/m4CXezpbIlYfskiZo9emgFBrM3RwTHD33KBco=;
        b=mV+FNC4gckGBzoFoE29r4CsyyJIRh8VCk4/lWPJND3HkjGidlPmMdq/zuPPi766WY7
         4jJQ7AxNDhFEq7Ty68yury980H0iaNabtonVi/sWjSjzo8BV6t7eb5RpXc8UaEybZgo5
         J0juD6DLjOQrMvLOeel3vhHOnEG0+anht4uUEAkqu6K3NZD1UG9udoJw+WIQr783MbDt
         jfOlmjl3EaBn1qX4ZK0D2rhWNoyU8Rq1Ltnm2KKPGC8ohpqwy0Flioo/2APmJQQUu+sy
         E6EmvYhrIKl1wQC/JlNcP5ks9iPxHWJJYvDOXTrmtkVjOfVFpqTvGJchcqSRI8hu0eJT
         36hA==
X-Gm-Message-State: APjAAAV9o9S9ZPUX73pciEDscRIo5j9VedQIFUHZKp3i2PcdJ/1m+5Mu
        AYizloUUIHVz2fpAlY1fYNQVrPpF9zaZTEa4sfPZGQ==
X-Google-Smtp-Source: APXvYqxxxSmkf9PLSz/RDL1+3qpHbxikmXEsEiHYdT0nA1jOcbmVTTLhIDmlXHumkunAFeJn7KLh/deR6khriZKWfRQ=
X-Received: by 2002:ad4:534b:: with SMTP id v11mr29123667qvs.31.1557288510019;
 Tue, 07 May 2019 21:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190507045433.542-1-hsinyi@chromium.org> <CAL_Jsq+rGeFKAPVmPvv_Z+G=BppKUK-tEUphBajZVxFtbRBJvQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+rGeFKAPVmPvv_Z+G=BppKUK-tEUphBajZVxFtbRBJvQ@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 8 May 2019 12:08:03 +0800
Message-ID: <CAJMQK-iVhScf0ybZ85kqP0B5_QPoYZ9PZt35jHRUh8FNHKvu7w@mail.gmail.com>
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

On Wed, May 8, 2019 at 3:47 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> +boot-architecture list as there was some discussion about this IIRC.
>
> On Mon, May 6, 2019 at 11:54 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > Introducing a chosen node, rng-seed, which is an 64 bytes entropy
> > that can be passed to kernel called very early to increase device
> > randomness. Bootloader should provide this entropy and the value is
> > read from /chosen/rng-seed in DT.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> >
> > ---
> >  Documentation/devicetree/bindings/chosen.txt | 14 +++++++++
>
> Actually, this file has been converted to json-schema and lives
> here[1]. I need to remove this one (or leave it with a reference to
> the new one).
>
> >  arch/arm64/kernel/setup.c                    |  2 ++
> >  drivers/of/fdt.c                             | 33 ++++++++++++++++++++
> >  include/linux/of_fdt.h                       |  1 +
> >  4 files changed, 50 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> > index 45e79172a646..bfd360691650 100644
> > --- a/Documentation/devicetree/bindings/chosen.txt
> > +++ b/Documentation/devicetree/bindings/chosen.txt
> > @@ -28,6 +28,20 @@ mode) when EFI_RNG_PROTOCOL is supported, it will be overwritten by
> >  the Linux EFI stub (which will populate the property itself, using
> >  EFI_RNG_PROTOCOL).
> >
> > +rng-seed
> > +-----------
> > +
> > +This property served as an entropy to add device randomness. It is parsed
> > +as a 64 byte value, e.g.
>
> Why only 64-bytes?
We can also not specify size and read what bootloader can provide.
>
> > +
> > +/ {
> > +       chosen {
> > +               rng-seed = <0x31951b3c 0xc9fab3a5 0xffdf1660 ...>
> > +       };
> > +};
> > +
> > +This random value should be provided by bootloader.
> > +
> >  stdout-path
> >  -----------
> >
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index 413d566405d1..ade4261516dd 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -292,6 +292,8 @@ void __init setup_arch(char **cmdline_p)
> >         early_fixmap_init();
> >         early_ioremap_init();
> >
> > +       early_init_dt_rng_seed(__fdt_pointer);
> > +
>
> I'm trying to reduce or eliminate all these early_init_dt_* calls.
>
> Why is this arch specific and why can't this be done after
> unflattening? It doesn't look like add_device_randomness() needs
> anything early.
Currently unflattening is called after setup_machine_fdt(), which
called fixmap_remap_fdt() //__fixmap_remap_fdt(dt_phys, &size,
PAGE_KERNEL_RO), and we can't modify DT after that since it's read
only. But we need to clear (eg. write 0 to it) the rng-seed after
reading from DT.
>
> >         setup_machine_fdt(__fdt_pointer);
> >
> >         parse_early_param();
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index de893c9616a1..74e2c0c80b91 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/libfdt.h>
> >  #include <linux/debugfs.h>
> > +#include <linux/random.h>
> >  #include <linux/serial_core.h>
> >  #include <linux/sysfs.h>
> >
> > @@ -1117,6 +1118,38 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
> >         return 1;
> >  }
> >
> > +extern void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size,
> > +                                      pgprot_t prot);
> > +
> > +void __init early_init_dt_rng_seed(u64 dt_phys)
> > +{
> > +       void *fdt;
> > +       int node, size, i;
> > +       fdt64_t *prop;
> > +       u64 rng_seed[8];
> > +
> > +       fdt = __fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL);
> > +       if (!fdt)
> > +               return;
> > +
> > +       node = fdt_path_offset(fdt, "/chosen");
> > +       if (node < 0)
> > +               return;
> > +
> > +       prop = fdt_getprop_w(fdt, node, "rng-seed", &size);
> > +       if (!prop || size != sizeof(u64) * 8)
> > +               return;
> > +
> > +       for (i = 0; i < 8; i++) {
> > +               rng_seed[i] = fdt64_to_cpu(*(prop + i));
> > +               /* clear seed so it won't be found. */
> > +               *(prop + i) = 0;
> > +       }
> > +       add_device_randomness(rng_seed, size);
> > +
> > +       return;
> > +}
> > +
> >  #ifndef MIN_MEMBLOCK_ADDR
> >  #define MIN_MEMBLOCK_ADDR      __pa(PAGE_OFFSET)
> >  #endif
> > diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> > index a713e5d156d8..a4548dd6351e 100644
> > --- a/include/linux/of_fdt.h
> > +++ b/include/linux/of_fdt.h
> > @@ -71,6 +71,7 @@ extern uint32_t of_get_flat_dt_phandle(unsigned long node);
> >
> >  extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
> >                                      int depth, void *data);
> > +extern void early_init_dt_rng_seed(u64 dt_phys);
> >  extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
> >                                      int depth, void *data);
> >  extern int early_init_dt_scan_chosen_stdout(void);
> > --
> > 2.20.1
> >
