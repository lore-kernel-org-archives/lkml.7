Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7A4C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DCE20578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557258459;
	bh=H9Pa58GpFX4BokZ1UWZ8tTsFNDuLeFOIEWPBcJy1heE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=c/OPRD0i2JPguJIN0OOjDG9LEdBk547szbIEpIvTIC9mmCjwFNI6zgtnSVqNQjnks
	 X7kJUeOy4L+lSORNDcVZp0dp1/VY74OsIohXfgj5IG6TCinhXiOGfPxrB7yyQDS3z3
	 QwzhPxPOdUdY3Lpl1ho8rwijn5htmsQhuTzpBA8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfEGTri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 15:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfEGTri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:47:38 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A549208C4;
        Tue,  7 May 2019 19:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557258456;
        bh=H9Pa58GpFX4BokZ1UWZ8tTsFNDuLeFOIEWPBcJy1heE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LkL+jhljELw+1Vjy7SQO2B7SG/ZFkBAa66k5eCcSYVMV8KkTPmaFy0x2zCQw1NIku
         iYKl3D0T+eWNhu1FYvlzM8Wz3tpXXQTbhxBG2r4mGRDmAEQY8BP5vzqJ0DkALLJ1uN
         wiiQwrL5TQYgFWKI3NTFoUzsA/gc6WuFuDOxOM4k=
Received: by mail-qt1-f170.google.com with SMTP id f24so10092417qtk.11;
        Tue, 07 May 2019 12:47:36 -0700 (PDT)
X-Gm-Message-State: APjAAAUb9C3R0l66Eqp1dhMt42DDBzLvxbmnWBF6mHQh78Z08UMvLAKa
        YK+Idgq3TGsrEUuNmI01vTj5iIUKOyKuxAX+KQ==
X-Google-Smtp-Source: APXvYqy49GlAiANz6VDO2OHCA7oetEwsRwSl/TppflexiHOPW7nabAFldrLAb3/DPpRad19efNzXP4bp5t0xr+vd/14=
X-Received: by 2002:ac8:66d3:: with SMTP id m19mr27729011qtp.359.1557258455708;
 Tue, 07 May 2019 12:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190507045433.542-1-hsinyi@chromium.org>
In-Reply-To: <20190507045433.542-1-hsinyi@chromium.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 7 May 2019 14:47:00 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+rGeFKAPVmPvv_Z+G=BppKUK-tEUphBajZVxFtbRBJvQ@mail.gmail.com>
Message-ID: <CAL_Jsq+rGeFKAPVmPvv_Z+G=BppKUK-tEUphBajZVxFtbRBJvQ@mail.gmail.com>
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

+boot-architecture list as there was some discussion about this IIRC.

On Mon, May 6, 2019 at 11:54 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Introducing a chosen node, rng-seed, which is an 64 bytes entropy
> that can be passed to kernel called very early to increase device
> randomness. Bootloader should provide this entropy and the value is
> read from /chosen/rng-seed in DT.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>
> ---
>  Documentation/devicetree/bindings/chosen.txt | 14 +++++++++

Actually, this file has been converted to json-schema and lives
here[1]. I need to remove this one (or leave it with a reference to
the new one).

>  arch/arm64/kernel/setup.c                    |  2 ++
>  drivers/of/fdt.c                             | 33 ++++++++++++++++++++
>  include/linux/of_fdt.h                       |  1 +
>  4 files changed, 50 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> index 45e79172a646..bfd360691650 100644
> --- a/Documentation/devicetree/bindings/chosen.txt
> +++ b/Documentation/devicetree/bindings/chosen.txt
> @@ -28,6 +28,20 @@ mode) when EFI_RNG_PROTOCOL is supported, it will be overwritten by
>  the Linux EFI stub (which will populate the property itself, using
>  EFI_RNG_PROTOCOL).
>
> +rng-seed
> +-----------
> +
> +This property served as an entropy to add device randomness. It is parsed
> +as a 64 byte value, e.g.

Why only 64-bytes?

> +
> +/ {
> +       chosen {
> +               rng-seed = <0x31951b3c 0xc9fab3a5 0xffdf1660 ...>
> +       };
> +};
> +
> +This random value should be provided by bootloader.
> +
>  stdout-path
>  -----------
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 413d566405d1..ade4261516dd 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -292,6 +292,8 @@ void __init setup_arch(char **cmdline_p)
>         early_fixmap_init();
>         early_ioremap_init();
>
> +       early_init_dt_rng_seed(__fdt_pointer);
> +

I'm trying to reduce or eliminate all these early_init_dt_* calls.

Why is this arch specific and why can't this be done after
unflattening? It doesn't look like add_device_randomness() needs
anything early.

>         setup_machine_fdt(__fdt_pointer);
>
>         parse_early_param();
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index de893c9616a1..74e2c0c80b91 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -22,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/libfdt.h>
>  #include <linux/debugfs.h>
> +#include <linux/random.h>
>  #include <linux/serial_core.h>
>  #include <linux/sysfs.h>
>
> @@ -1117,6 +1118,38 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>         return 1;
>  }
>
> +extern void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size,
> +                                      pgprot_t prot);
> +
> +void __init early_init_dt_rng_seed(u64 dt_phys)
> +{
> +       void *fdt;
> +       int node, size, i;
> +       fdt64_t *prop;
> +       u64 rng_seed[8];
> +
> +       fdt = __fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL);
> +       if (!fdt)
> +               return;
> +
> +       node = fdt_path_offset(fdt, "/chosen");
> +       if (node < 0)
> +               return;
> +
> +       prop = fdt_getprop_w(fdt, node, "rng-seed", &size);
> +       if (!prop || size != sizeof(u64) * 8)
> +               return;
> +
> +       for (i = 0; i < 8; i++) {
> +               rng_seed[i] = fdt64_to_cpu(*(prop + i));
> +               /* clear seed so it won't be found. */
> +               *(prop + i) = 0;
> +       }
> +       add_device_randomness(rng_seed, size);
> +
> +       return;
> +}
> +
>  #ifndef MIN_MEMBLOCK_ADDR
>  #define MIN_MEMBLOCK_ADDR      __pa(PAGE_OFFSET)
>  #endif
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index a713e5d156d8..a4548dd6351e 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -71,6 +71,7 @@ extern uint32_t of_get_flat_dt_phandle(unsigned long node);
>
>  extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
>                                      int depth, void *data);
> +extern void early_init_dt_rng_seed(u64 dt_phys);
>  extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
>                                      int depth, void *data);
>  extern int early_init_dt_scan_chosen_stdout(void);
> --
> 2.20.1
>
