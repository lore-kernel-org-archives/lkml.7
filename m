Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2BEC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2FA2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FWU2ckqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfEGFIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:08:02 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42393 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGFIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:08:01 -0400
Received: by mail-qt1-f194.google.com with SMTP id p20so746445qtc.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 22:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFWNJh8Q67igevp3wGeWjad6EnoMTokEua3uDsOHdyc=;
        b=FWU2ckqSzrtkezLe5i9S7DhYYZxFLuwSlgKhkpbkwrD1ArbxVNuvN7yK/FkqAxpraK
         U7g1w6q5r686tRdRVc+zVc4z5gxUl6fK1PTaK/2TP2SEJzwQTP3uog8xJFI1hnjY+W1/
         vFD/gWov2BcerLdSKb9MhJFoUUAaIXsTIREHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFWNJh8Q67igevp3wGeWjad6EnoMTokEua3uDsOHdyc=;
        b=Wn7Ulj3O7JOxXd+9NbAEKgkyG/AMavuPoVmT0JXyYAKT/EZ2CFs5z7TFnBss/jBaFH
         p+Iah9wMHUmXAjhfOySZg9BCfi6aTw4484t2ob6qd4+6Rd6fub24IYHyw1+1/ACP6V1y
         UhWR9dZagA6Z5MBsq+J0LNZ2R2+1T8AOwySvLtj6DB04w8haPfTud2V/ccGf6Y/OZpDQ
         e2z9ZY246rBkUqUSpDTsQwxR6SH0t0N3LeFN5l8Yq1HLpeeTfvkTs8acWi/Apmv2rlPP
         ig8q89itvvvbJ0MC8BJ1jjTx0NCosgsgQblitdiZpVQhLYxBKLPS4g2Nb1YpPvhj0yxP
         8WcQ==
X-Gm-Message-State: APjAAAXETO6McrY3GEAZUmmQJ1hWX+sTHC/CIPgq2vl5kIYeKkNTC5QP
        8cishpN/W5zgtyNGxm/IkeTTauMSLSIml+ipBxwLqJt2cq0=
X-Google-Smtp-Source: APXvYqyqgf+inXjhIv4SWh98ejK1sBShVQi8TKhwrV5Ewd9dAEqv+4GfSUwGADj50buZ8JcfocZen86m+oo25/Bd1gU=
X-Received: by 2002:ac8:2963:: with SMTP id z32mr25018141qtz.236.1557205680295;
 Mon, 06 May 2019 22:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190507045433.542-1-hsinyi@chromium.org>
In-Reply-To: <20190507045433.542-1-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 7 May 2019 13:07:34 +0800
Message-ID: <CAJMQK-hc8WLmxr0YVCu-czL6pXfhgG83=4gvL4=ozQyLd73Q-A@mail.gmail.com>
Subject: Re: [PATCH] arm64: add support for rng-seed
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 12:54 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
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
Currently this can only be called before setup_machine_fdt(). Since
setup_machine_fdt() called fixmap_remap_fdt() //
__fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO), we can't modify DT
after that. And rng-seed needs to be wiped out after read.
Another option is to called earlier, at arch/arm64/kernel/head.S,
similar to kaslr_early_init.

> +
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
