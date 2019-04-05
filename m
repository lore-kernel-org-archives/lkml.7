Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DCCC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97F520700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554447225;
	bh=5sd2Pjd4Jh5084/FkyH61IiZeLrFS4gGpPfAfewaLs4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uLDqb5ZuRMSVvXIhL/RkWP6dzyseN970j9+ZkHDehJ5ttFc9K4cqkUqcBiuMPHSKo
	 TbxkF+g4YGnKCGxD/A7DNDKPtNeZUW8olPvMptsKR2jECo7T76ww4mKd/ciq2aixJM
	 8jJpl8z/ZYWADpNDsE6saOQ/IAEfZdpZmMwkfaiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfDEGxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 02:53:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfDEGxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 02:53:44 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DA4620700;
        Fri,  5 Apr 2019 06:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554447222;
        bh=5sd2Pjd4Jh5084/FkyH61IiZeLrFS4gGpPfAfewaLs4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1dlN7chYZS+TVmb8zdQr6iirsi6VwtQt8IR4pzV3w0HA37r0oYpWRnkTewhKqlyPs
         AudOG/7ddeElECg74621rGRo4wIFqY89JrL/9gMj+mG/AwhINo/2qQ9GWm12af8Mzn
         80dxcFVl8WIUYrGcA6H2agyRZNccmJjtc1wIWVLM=
Received: by mail-lj1-f169.google.com with SMTP id j89so4292082ljb.1;
        Thu, 04 Apr 2019 23:53:42 -0700 (PDT)
X-Gm-Message-State: APjAAAXGADyEArjusNjdEiLOoJOnPeTcL3uVuaXTjaRJfnU+hdt3NrqY
        JaJWsISpWab/8mCY+OyRWt0dCB6yoa1gGllHIiA=
X-Google-Smtp-Source: APXvYqzP23FYcD3MpcPV2oNhiADO83cgjXrxoM+e/GG258SZybDjf8TdoaYIfb7KY4sY76mhmnrnx9uZmXLX/nZMUGg=
X-Received: by 2002:a2e:5dd2:: with SMTP id v79mr5763751lje.22.1554447220691;
 Thu, 04 Apr 2019 23:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190404172224epcas2p21b449c0ae8e36f7e800ae67c18db35a2@epcas2p2.samsung.com>
 <20190404171735.12815-1-s.nawrocki@samsung.com> <20190404171735.12815-2-s.nawrocki@samsung.com>
In-Reply-To: <20190404171735.12815-2-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 5 Apr 2019 08:53:29 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdtdvQg69PLO4+aGAWjth-NzGToJUUPN0Jw6=zTCz9Bbw@mail.gmail.com>
Message-ID: <CAJKOXPdtdvQg69PLO4+aGAWjth-NzGToJUUPN0Jw6=zTCz9Bbw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/8] soc: samsung: Add exynos chipid driver support
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        pankaj.dubey@samsung.com,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2019 at 19:22, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> From: Pankaj Dubey <pankaj.dubey@samsung.com>
>
> Exynos SoCs have Chipid, for identification of product IDs and SoC
> revisions. This patch intends to provide initialization code for all
> these functionalities, at the same time it provides some sysfs entries
> for accessing these information to user-space.
>
> This driver uses existing binding for exynos-chipid.
>
> Changes by Bartlomiej:
> - fixed return values on errors
> - removed bogus kfree_const()
> - added missing Exynos4210 EVT0 id
> - converted code to use EXYNOS_MASK define
> - fixed np use after of_node_put()
> - fixed too early use of dev_info()
> - made driver fail for unknown SoC-s
> - added SPDX tag
> - updated Copyrights
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> [m.szyprowski: for suggestion and code snippet of product_id_to_soc_id]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Toy need to add your SoB here.

> ---
>  drivers/soc/samsung/Kconfig         |   5 ++
>  drivers/soc/samsung/Makefile        |   2 +
>  drivers/soc/samsung/exynos-chipid.c | 111 ++++++++++++++++++++++++++++
>  3 files changed, 118 insertions(+)
>  create mode 100644 drivers/soc/samsung/exynos-chipid.c
>
> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> index 2186285fda92..2905f5262197 100644
> --- a/drivers/soc/samsung/Kconfig
> +++ b/drivers/soc/samsung/Kconfig
> @@ -7,6 +7,11 @@ menuconfig SOC_SAMSUNG
>
>  if SOC_SAMSUNG
>
> +config EXYNOS_CHIPID
> +       bool "Exynos Chipid controller driver" if COMPILE_TEST
> +       depends on ARCH_EXYNOS || COMPILE_TEST
> +       select SOC_BUS
> +
>  config EXYNOS_PMU
>         bool "Exynos PMU controller driver" if COMPILE_TEST
>         depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
> index 29f294baac6e..3b6a8797416c 100644
> --- a/drivers/soc/samsung/Makefile
> +++ b/drivers/soc/samsung/Makefile
> @@ -1,4 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_EXYNOS_CHIPID)    += exynos-chipid.o
>  obj-$(CONFIG_EXYNOS_PMU)       += exynos-pmu.o
>
>  obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)   += exynos3250-pmu.o exynos4-pmu.o \
> diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
> new file mode 100644
> index 000000000000..5cb018807817
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos-chipid.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 Samsung Electronics Co., Ltd.
> + *           http://www.samsung.com/
> + *
> + * EXYNOS - CHIP ID support
> + * Author: Pankaj Dubey <pankaj.dubey@samsung.com>
> + * Author: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>

I commented Bartlomiej's patch which you included here. I did not
receive any further feedback from him so I do not know whether he
agrees with my comments or not... but if you send the same patch again
without addressing these comments, I feel like ignored.

I stopped on first ignored comment.

Therefore please address be sure that you addressed my comments from
Bartlomiej's patchset. If you do not agree with them, please let me
know. The comments are here:
https://patchwork.kernel.org/project/linux-samsung-soc/list/?series=43565&state=*

Best regards,
Krzysztof

> +#include <linux/slab.h>
> +#include <linux/sys_soc.h>
> +
> +#define EXYNOS_SUBREV_MASK     (0xF << 4)
> +#define EXYNOS_MAINREV_MASK    (0xF << 0)
> +#define EXYNOS_REV_MASK                (EXYNOS_SUBREV_MASK | EXYNOS_MAINREV_MASK)
> +#define EXYNOS_MASK            0xFFFFF000
> +
> +static const struct exynos_soc_id {
> +       const char *name;
> +       unsigned int id;
> +} soc_ids[] = {
> +       { "EXYNOS3250", 0xE3472000 },
> +       { "EXYNOS4210", 0x43200000 },   /* EVT0 revision */
> +       { "EXYNOS4210", 0x43210000 },
> +       { "EXYNOS4212", 0x43220000 },
> +       { "EXYNOS4412", 0xE4412000 },
> +       { "EXYNOS5250", 0x43520000 },
> +       { "EXYNOS5260", 0xE5260000 },
> +       { "EXYNOS5410", 0xE5410000 },
> +       { "EXYNOS5420", 0xE5420000 },
> +       { "EXYNOS5440", 0xE5440000 },
> +       { "EXYNOS5800", 0xE5422000 },
> +       { "EXYNOS7420", 0xE7420000 },
> +       { "EXYNOS5433", 0xE5433000 },
> +};
> +
> +static const char * __init product_id_to_soc_id(unsigned int product_id)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(soc_ids); i++)
> +               if ((product_id & EXYNOS_MASK) == soc_ids[i].id)
> +                       return soc_ids[i].name;
> +       return NULL;
> +}
> +
> +int __init exynos_chipid_early_init(void)
> +{
> +       struct soc_device_attribute *soc_dev_attr;
> +       void __iomem *exynos_chipid_base;
> +       struct soc_device *soc_dev;
> +       struct device_node *root;
> +       struct device_node *np;
> +       u32 product_id;
> +       u32 revision;
> +
> +       /* look up for chipid node */
> +       np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-chipid");
> +       if (!np)
> +               return -ENODEV;
> +
> +       exynos_chipid_base = of_iomap(np, 0);
> +       of_node_put(np);
> +
> +       if (!exynos_chipid_base) {
> +               pr_err("Failed to map SoC chipid\n");
> +               return -ENXIO;
> +       }
> +
> +       product_id = readl_relaxed(exynos_chipid_base);
> +       revision = product_id & EXYNOS_REV_MASK;
> +       iounmap(exynos_chipid_base);
> +
> +       soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +       if (!soc_dev_attr)
> +               return -ENOMEM;
> +
> +       soc_dev_attr->family = "Samsung Exynos";
> +
> +       root = of_find_node_by_path("/");
> +       of_property_read_string(root, "model", &soc_dev_attr->machine);
> +       of_node_put(root);
> +
> +       soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%x", revision);
> +       soc_dev_attr->soc_id = product_id_to_soc_id(product_id);
> +       if (!soc_dev_attr->soc_id) {
> +               pr_err("Unknown SoC\n");
> +               return -ENODEV;
> +       }
> +
> +       /* please note that the actual registration will be deferred */
> +       soc_dev = soc_device_register(soc_dev_attr);
> +       if (IS_ERR(soc_dev)) {
> +               kfree(soc_dev_attr->revision);
> +               kfree(soc_dev_attr);
> +               return PTR_ERR(soc_dev);
> +       }
> +
> +       /* it is too early to use dev_info() here (soc_dev is NULL) */
> +       pr_info("soc soc0: Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
> +               soc_dev_attr->soc_id, product_id, revision);
> +
> +       return 0;
> +}
> +early_initcall(exynos_chipid_early_init);
> --
> 2.17.1
>
