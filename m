Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA320C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A74321582
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SjvfDYSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfLSD4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 22:56:30 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37150 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfLSD4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 22:56:30 -0500
Received: by mail-qk1-f194.google.com with SMTP id 21so3560654qky.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 19:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fHnDeCTSpOncu/mxWBmOui8QwOBoNPyxepaSQcLW2SM=;
        b=SjvfDYSrkno4KLsQVZn7YE36zb/kYQUU6iSP+XAS1HHBzNv4K1039nuqhcgERE7Svg
         7VMouNrKJ11b/gyHGMfy13Hq964YAPxPV7zheFA5D5BQAjexgjFufM2NudTJVrUWdvuP
         XRMDWD0YPI7e9kRTMug6XBiteWovQWsoHvzlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fHnDeCTSpOncu/mxWBmOui8QwOBoNPyxepaSQcLW2SM=;
        b=bvFfqoblKoT9uRLa0vLBmGaeILalZSGuHq1o6lwpSORnvNbSNHC/al+0DyrKhFu2xi
         Ymn2Cw65y2j3FDDdYaEFDPI32BjfIhdTfWulGZtc4trF5+D32khWgCwwASiyvXxwmjyy
         /y6jF7IHBUDjul/gSdrZb19mPdamfc8xwwmsnICs9059ErX9ht3HtvhCQ5338hj2TOVy
         jb/CQysH+BcLxaQmX9tWRivG4DU/uDGXZlXrivtm70+2PP5DI/j4Cjgqlv/niUr6Hxmw
         I/dh9L1MymJlmSwaLXj81BtA+XwFvfTv3/JLE+yDNPwtykoB4gEjBQLhgiq9PS46tvPJ
         DQ7w==
X-Gm-Message-State: APjAAAUgSMLHdDKXVbDooWqqwyDHVGBPhq6xV9JDGA84/zURzoqhgrkb
        goIYNpdT0YHSavRYJ5N2Suz8aSdnXck+Ky01PftfnA==
X-Google-Smtp-Source: APXvYqzDRLPuldNit7L4QrxNylEvmsH+Gp//KduZcHs9bl415QmYBGc+rcbAvLw6SBzozwRUW10u+uNhJRBTd0jH688=
X-Received: by 2002:a37:6551:: with SMTP id z78mr6478508qkb.144.1576727788462;
 Wed, 18 Dec 2019 19:56:28 -0800 (PST)
MIME-Version: 1.0
References: <1576657848-14711-1-git-send-email-weiyi.lu@mediatek.com> <1576657848-14711-8-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1576657848-14711-8-git-send-email-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 19 Dec 2019 11:56:17 +0800
Message-ID: <CANMq1KDSVH0kb0YVf5iiVTs=Bpc742gJWjqk3t0KU5LMzVNJSg@mail.gmail.com>
Subject: Re: [PATCH v10 07/12] soc: mediatek: Remove infracfg misc driver support
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 4:31 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> In previous patches, we introduce scpsys-ext driver that covers
> the functions which infracfg misc driver provided.
> And then replace bus_prot_mask with bp_table of all compatibles.
> Now, we're going to remove infracfg misc drvier which is no longer
> being used.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/Kconfig          | 10 -----
>  drivers/soc/mediatek/Makefile         |  3 +-
>  drivers/soc/mediatek/mtk-infracfg.c   | 79 -----------------------------------
>  include/linux/soc/mediatek/infracfg.h | 39 -----------------
>  4 files changed, 1 insertion(+), 130 deletions(-)
>  delete mode 100644 drivers/soc/mediatek/mtk-infracfg.c
>  delete mode 100644 include/linux/soc/mediatek/infracfg.h
>
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 2114b56..f837b3c 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -10,21 +10,12 @@ config MTK_CMDQ
>         depends on ARCH_MEDIATEK || COMPILE_TEST
>         select MAILBOX
>         select MTK_CMDQ_MBOX
> -       select MTK_INFRACFG
>         help
>           Say yes here to add support for the MediaTek Command Queue (CMDQ)
>           driver. The CMDQ is used to help read/write registers with critical
>           time limitation, such as updating display configuration during the
>           vblank.
>
> -config MTK_INFRACFG
> -       bool "MediaTek INFRACFG Support"
> -       select REGMAP
> -       help
> -         Say yes here to add support for the MediaTek INFRACFG controller. The
> -         INFRACFG controller contains various infrastructure registers not
> -         directly associated to any device.
> -
>  config MTK_PMIC_WRAP
>         tristate "MediaTek PMIC Wrapper Support"
>         depends on RESET_CONTROLLER
> @@ -38,7 +29,6 @@ config MTK_SCPSYS
>         bool "MediaTek SCPSYS Support"
>         default ARCH_MEDIATEK
>         select REGMAP
> -       select MTK_INFRACFG
>         select PM_GENERIC_DOMAINS if PM
>         help
>           Say yes here to add support for the MediaTek SCPSYS power domain
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index b442be9..7bf7e88 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1,5 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
> -obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o mtk-scpsys-ext.o
>  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
> -obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> +obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o mtk-scpsys-ext.o
> diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/mtk-infracfg.c
> deleted file mode 100644
> index 341c7ac..0000000
> --- a/drivers/soc/mediatek/mtk-infracfg.c
> +++ /dev/null
> @@ -1,79 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (c) 2015 Pengutronix, Sascha Hauer <kernel@pengutronix.de>
> - */
> -
> -#include <linux/export.h>
> -#include <linux/jiffies.h>
> -#include <linux/regmap.h>
> -#include <linux/soc/mediatek/infracfg.h>
> -#include <asm/processor.h>
> -
> -#define MTK_POLL_DELAY_US   10
> -#define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
> -
> -#define INFRA_TOPAXI_PROTECTEN         0x0220
> -#define INFRA_TOPAXI_PROTECTSTA1       0x0228
> -#define INFRA_TOPAXI_PROTECTEN_SET     0x0260
> -#define INFRA_TOPAXI_PROTECTEN_CLR     0x0264
> -
> -/**
> - * mtk_infracfg_set_bus_protection - enable bus protection
> - * @regmap: The infracfg regmap
> - * @mask: The mask containing the protection bits to be enabled.
> - * @reg_update: The boolean flag determines to set the protection bits
> - *              by regmap_update_bits with enable register(PROTECTEN) or
> - *              by regmap_write with set register(PROTECTEN_SET).
> - *
> - * This function enables the bus protection bits for disabled power
> - * domains so that the system does not hang when some unit accesses the
> - * bus while in power down.
> - */
> -int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
> -               bool reg_update)
> -{
> -       u32 val;
> -       int ret;
> -
> -       if (reg_update)
> -               regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask,
> -                               mask);
> -       else
> -               regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_SET, mask);
> -
> -       ret = regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTSTA1,
> -                                      val, (val & mask) == mask,
> -                                      MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> -
> -       return ret;
> -}
> -
> -/**
> - * mtk_infracfg_clear_bus_protection - disable bus protection
> - * @regmap: The infracfg regmap
> - * @mask: The mask containing the protection bits to be disabled.
> - * @reg_update: The boolean flag determines to clear the protection bits
> - *              by regmap_update_bits with enable register(PROTECTEN) or
> - *              by regmap_write with clear register(PROTECTEN_CLR).
> - *
> - * This function disables the bus protection bits previously enabled with
> - * mtk_infracfg_set_bus_protection.
> - */
> -
> -int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> -               bool reg_update)
> -{
> -       int ret;
> -       u32 val;
> -
> -       if (reg_update)
> -               regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, 0);
> -       else
> -               regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_CLR, mask);
> -
> -       ret = regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTSTA1,
> -                                      val, !(val & mask),
> -                                      MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> -
> -       return ret;
> -}
> diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> deleted file mode 100644
> index fd25f01..0000000
> --- a/include/linux/soc/mediatek/infracfg.h
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __SOC_MEDIATEK_INFRACFG_H
> -#define __SOC_MEDIATEK_INFRACFG_H
> -
> -#define MT8173_TOP_AXI_PROT_EN_MCI_M2          BIT(0)
> -#define MT8173_TOP_AXI_PROT_EN_MM_M0           BIT(1)
> -#define MT8173_TOP_AXI_PROT_EN_MM_M1           BIT(2)
> -#define MT8173_TOP_AXI_PROT_EN_MMAPB_S         BIT(6)
> -#define MT8173_TOP_AXI_PROT_EN_L2C_M2          BIT(9)
> -#define MT8173_TOP_AXI_PROT_EN_L2SS_SMI                BIT(11)
> -#define MT8173_TOP_AXI_PROT_EN_L2SS_ADD                BIT(12)
> -#define MT8173_TOP_AXI_PROT_EN_CCI_M2          BIT(13)
> -#define MT8173_TOP_AXI_PROT_EN_MFG_S           BIT(14)
> -#define MT8173_TOP_AXI_PROT_EN_PERI_M0         BIT(15)
> -#define MT8173_TOP_AXI_PROT_EN_PERI_M1         BIT(16)
> -#define MT8173_TOP_AXI_PROT_EN_DEBUGSYS                BIT(17)
> -#define MT8173_TOP_AXI_PROT_EN_CQ_DMA          BIT(18)
> -#define MT8173_TOP_AXI_PROT_EN_GCPU            BIT(19)
> -#define MT8173_TOP_AXI_PROT_EN_IOMMU           BIT(20)
> -#define MT8173_TOP_AXI_PROT_EN_MFG_M0          BIT(21)
> -#define MT8173_TOP_AXI_PROT_EN_MFG_M1          BIT(22)
> -#define MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT   BIT(23)
> -
> -#define MT2701_TOP_AXI_PROT_EN_MM_M0           BIT(1)
> -#define MT2701_TOP_AXI_PROT_EN_CONN_M          BIT(2)
> -#define MT2701_TOP_AXI_PROT_EN_CONN_S          BIT(8)
> -
> -#define MT7622_TOP_AXI_PROT_EN_ETHSYS          (BIT(3) | BIT(17))
> -#define MT7622_TOP_AXI_PROT_EN_HIF0            (BIT(24) | BIT(25))
> -#define MT7622_TOP_AXI_PROT_EN_HIF1            (BIT(26) | BIT(27) | \
> -                                                BIT(28))
> -#define MT7622_TOP_AXI_PROT_EN_WB              (BIT(2) | BIT(6) | \
> -                                                BIT(7) | BIT(8))

It was really nice to have these all defined, can we move those to
scpsys-ext.h? (and do the same for MT8183?)

> -int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
> -               bool reg_update);
> -int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> -               bool reg_update);
> -#endif /* __SOC_MEDIATEK_INFRACFG_H */
> --
> 1.8.1.1.dirty
