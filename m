Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4247C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6972465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DlSUmhpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLTELf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 23:11:35 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39350 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfLTELe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 23:11:34 -0500
Received: by mail-qk1-f195.google.com with SMTP id c16so6573976qko.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 20:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QoYXPHnls44Z5wOYK4pAzny40P7lll1Gg/xWIt1DvMU=;
        b=DlSUmhpwxG7Zh4Vz6yQRkwgpLxVEgoqQNXDVLySEZ4pGT3rOCxuHgwmTzBDps/c0Pd
         oN3zqH3VECxhyYsLRqUehjcS0qR3gApcJlcIsbM5bcCsy3WnFq1EtAgQhVZk+iGMx/uQ
         gefmVJF9mXhFRiSssKsyEL6OsfPx7VUo/SaWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QoYXPHnls44Z5wOYK4pAzny40P7lll1Gg/xWIt1DvMU=;
        b=hBnPnGpOP70UJndQPAV4KQSAFGiLMCYDV9oq4zMFuy1ePmFF3RdL+Gpi1OUvd22+1Y
         TYTcG7mQHH2gpKTwSiRnI4gwKcOmURHv0cnmppjmWDbtNNwqpC/1orv99sKsqIPlTNbz
         UJZqWvyu2nB+Qwskb9AEA6u/2CUAI95IGQ69TBA53QLcmx7R60LQS3sKZnEiZPpszijC
         sY4HBTdKC7guZbUMJgHKXGQEVgW7+9SsOWBd1312Msr2cxVtva2Q24NDewzig5O2hTnm
         ZTfs/7Ks2vFeBDRTVrgcwbSIbPtldj4MahnG7HevMqnQUrOKFrkTO91PlUk0o++sSftV
         90Lw==
X-Gm-Message-State: APjAAAXbAb1t3UjowWQ4xg8/jivw+hbUN/W8h3MmDgHQdi54bF1uhWuy
        M3rTF5Bo9m3x1oRb2VYzzsU/jmTY8b1L3nOgNPrnTA==
X-Google-Smtp-Source: APXvYqx7ePPcrXRhTd+hI3MOAUTzjv0omBlqDcXJk45az0VL6N7HD4ZKjtGpVV03YNtBVxg4naVTAYbFS9HI6Bh262Q=
X-Received: by 2002:a37:6551:: with SMTP id z78mr12071941qkb.144.1576815093710;
 Thu, 19 Dec 2019 20:11:33 -0800 (PST)
MIME-Version: 1.0
References: <1576813564-23927-1-git-send-email-weiyi.lu@mediatek.com> <1576813564-23927-6-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1576813564-23927-6-git-send-email-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 20 Dec 2019 12:11:22 +0800
Message-ID: <CANMq1KBLuugcoWb1o=rUkBR7oY5Cf5rX=DCvpVP5D_6FJ8jipw@mail.gmail.com>
Subject: Re: [PATCH v11 05/10] soc: mediatek: Remove infracfg misc driver support
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

On Fri, Dec 20, 2019 at 11:46 AM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
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
> [snip]
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

Err wait, don't you need these values in patch 04/10?

> -
> -int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
> -               bool reg_update);
> -int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> -               bool reg_update);
> -#endif /* __SOC_MEDIATEK_INFRACFG_H */
> --
> 1.8.1.1.dirty
