Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC83C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845DD217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554456188;
	bh=HPsEFSUCqjubps4KtGGxa4DU/YfKuyBIuMJWzTib9cE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FkwHeWanV20zJC3C78/XaG1ImmZflEHtYd6h7bKS1Rjr2ga3ldrBItnyiV0ynNeX/
	 BNg0tExtaQPl+3kdb0A/D92WOUuVLI0LICDcyAnev5kgAEL4/jCWh6crGdE6LsWmG4
	 5ktdgJ+ogOP/HxCAkHE4VlYYkGUmnOsf0Go+1uco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfDEJXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:23:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730554AbfDEJXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:23:06 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD1221850;
        Fri,  5 Apr 2019 09:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554456185;
        bh=HPsEFSUCqjubps4KtGGxa4DU/YfKuyBIuMJWzTib9cE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DQIT9FMZMjAv10Xbw009Ec8Tm5iOJU56oMAaIqaJreE1koPjhlmMo5c0WCdKkyutI
         2TyvyqHiTHK3m9xyR1O/MTnKBR9HQQBhexIOnWATMoby9tBztMkAJg0p0898JhLhQT
         lmnXWIM/FDkSS7hbEumzBFDgHPh+w9TeSfCrjFEA=
Received: by mail-lj1-f173.google.com with SMTP id v13so4616583ljk.4;
        Fri, 05 Apr 2019 02:23:04 -0700 (PDT)
X-Gm-Message-State: APjAAAWR8JPJ9mHGXy/mJ0ouTn/fsmtUwbQyd2/QgzSVQR8Rq2VLYs5D
        RhimobPiNy0PRsTKmCP+ho1qzs9vGS4Rkr45HXA=
X-Google-Smtp-Source: APXvYqyeIJh/ZsfJF5ZZcunnuxFlZUfp/le0ivhWdQv+DjpluVfoi2hw9KZWGrJh1NdMTpbHZ1qfeRxpawwNfd/9FC8=
X-Received: by 2002:a2e:74f:: with SMTP id i15mr1349530ljd.156.1554456182978;
 Fri, 05 Apr 2019 02:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190404172229epcas2p25a819e37035b26ccf53613e880bdcacf@epcas2p2.samsung.com>
 <20190404171735.12815-1-s.nawrocki@samsung.com> <20190404171735.12815-3-s.nawrocki@samsung.com>
In-Reply-To: <20190404171735.12815-3-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 5 Apr 2019 11:22:51 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcJrctz5E8GX2ke804FBifpfYm5D_=H4MguTg_Cq2CPng@mail.gmail.com>
Message-ID: <CAJKOXPcJrctz5E8GX2ke804FBifpfYm5D_=H4MguTg_Cq2CPng@mail.gmail.com>
Subject: Re: [PATCH RFC 2/8] soc: samsung: Exynos chipid driver update
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
> This patch adds definition of selected CHIP ID register offsets
> and register bit field definitions for Exynos5422 SoC.
>
> exynos_chipid_read() helper function is added to allow reading
> the CHIP ID block registers.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/soc/samsung/exynos-chipid.c | 16 +++++-----
>  drivers/soc/samsung/exynos-chipid.h | 48 +++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/soc/samsung/exynos-chipid.h
>
> diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
> index 5cb018807817..4920f0ef2c55 100644
> --- a/drivers/soc/samsung/exynos-chipid.c
> +++ b/drivers/soc/samsung/exynos-chipid.c
> @@ -16,10 +16,7 @@
>  #include <linux/slab.h>
>  #include <linux/sys_soc.h>
>
> -#define EXYNOS_SUBREV_MASK     (0xF << 4)
> -#define EXYNOS_MAINREV_MASK    (0xF << 0)
> -#define EXYNOS_REV_MASK                (EXYNOS_SUBREV_MASK | EXYNOS_MAINREV_MASK)
> -#define EXYNOS_MASK            0xFFFFF000

Create hex-addresses in first commit in lower case.

> +#include "exynos-chipid.h"
>
>  static const struct exynos_soc_id {
>         const char *name;
> @@ -40,6 +37,13 @@ static const struct exynos_soc_id {
>         { "EXYNOS5433", 0xE5433000 },
>  };
>
> +static void __iomem *exynos_chipid_base;

No, this was removed in Pankaj's version v6 -> v7 and I do not want it
to be file-scope. Having it file-scope is error prone and prevents
having multiple instances (I do not expect having more than one but
still code should be rather nicely generic).

> +
> +unsigned int exynos_chipid_read(unsigned int offset)
> +{
> +       return readl_relaxed(exynos_chipid_base + offset);
> +}
> +
>  static const char * __init product_id_to_soc_id(unsigned int product_id)
>  {
>         int i;
> @@ -53,7 +57,6 @@ static const char * __init product_id_to_soc_id(unsigned int product_id)
>  int __init exynos_chipid_early_init(void)
>  {
>         struct soc_device_attribute *soc_dev_attr;
> -       void __iomem *exynos_chipid_base;
>         struct soc_device *soc_dev;
>         struct device_node *root;
>         struct device_node *np;
> @@ -73,9 +76,8 @@ int __init exynos_chipid_early_init(void)
>                 return -ENXIO;
>         }
>
> -       product_id = readl_relaxed(exynos_chipid_base);
> +       product_id = exynos_chipid_read(EXYNOS_CHIPID_REG_PRO_ID);
>         revision = product_id & EXYNOS_REV_MASK;
> -       iounmap(exynos_chipid_base);
>
>         soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
>         if (!soc_dev_attr)
> diff --git a/drivers/soc/samsung/exynos-chipid.h b/drivers/soc/samsung/exynos-chipid.h
> new file mode 100644
> index 000000000000..826a12c25fa2
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos-chipid.h
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 Samsung Electronics Co., Ltd.
> + *           http://www.samsung.com/
> + *
> + * EXYNOS - CHIP ID support
> + */
> +
> +#define EXYNOS_CHIPID_REG_PRO_ID       0x00
> + #define EXYNOS_SUBREV_MASK            (0xf << 4)
> + #define EXYNOS_MAINREV_MASK           (0xf << 0)
> + #define EXYNOS_REV_MASK               (EXYNOS_SUBREV_MASK | \
> +                                        EXYNOS_MAINREV_MASK)
> + #define EXYNOS_MASK                   0xfffff000
> +
> +#define EXYNOS_CHIPID_REG_PKG_ID       0x04

Can you comment that these are fields from this register?
The same in second one.

Best regards,
Krzysztof

> + #define EXYNOS5422_IDS_OFFSET         24
> + #define EXYNOS5422_IDS_MASK           0xff
> + #define EXYNOS5422_USESG_OFFSET       3
> + #define EXYNOS5422_USESG_MASK         0x01
> + #define EXYNOS5422_SG_OFFSET          0
> + #define EXYNOS5422_SG_MASK            0x07
> + #define EXYNOS5422_TABLE_OFFSET       8
> + #define EXYNOS5422_TABLE_MASK         0x03
> + #define EXYNOS5422_SG_A_OFFSET                17
> + #define EXYNOS5422_SG_A_MASK          0x0f
> + #define EXYNOS5422_SG_B_OFFSET                21
> + #define EXYNOS5422_SG_B_MASK          0x03
> + #define EXYNOS5422_SG_BSIGN_OFFSET    23
> + #define EXYNOS5422_SG_BSIGN_MASK      0x01
> + #define EXYNOS5422_BIN2_OFFSET                12
> + #define EXYNOS5422_BIN2_MASK          0x01
> +
> +#define EXYNOS_CHIPID_REG_LOT_ID       0x14
> +
> +#define EXYNOS_CHIPID_AUX_INFO         0x1c
> + #define EXYNOS5422_TMCB_OFFSET                0
> + #define EXYNOS5422_TMCB_MASK          0x7f
> + #define EXYNOS5422_ARM_UP_OFFSET      8
> + #define EXYNOS5422_ARM_UP_MASK                0x03
> + #define EXYNOS5422_ARM_DN_OFFSET      10
> + #define EXYNOS5422_ARM_DN_MASK                0x03
> + #define EXYNOS5422_KFC_UP_OFFSET      12
> + #define EXYNOS5422_KFC_UP_MASK                0x03
> + #define EXYNOS5422_KFC_DN_OFFSET      14
> + #define EXYNOS5422_KFC_DN_MASK                0x03
> +
> +unsigned int exynos_chipid_read(unsigned int offset);
> --
> 2.17.1
>
