Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854D8C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445C0227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IiaVVoIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfLTFLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 00:11:39 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38376 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfLTFLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 00:11:39 -0500
Received: by mail-qv1-f68.google.com with SMTP id t6so3175659qvs.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 21:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3zWGDL/rJJvF4OGWHgWe2M4m9MBg78+Q3j/Wyllah+s=;
        b=IiaVVoIq8oepGs9n62+pph8JnNyoebo7WEO1vMBGFj+1u17MTAcQkANj77APhy5ThQ
         s89VHwe9+wqueL6iQdTaxyHB7duKUVpEqLLg4Jw0COQ01PuWUEcDrcP6LMdIO2hKe6+J
         U8I+f0QrhFndop3oYFVY/hOfW2z7Q9iCHwzCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3zWGDL/rJJvF4OGWHgWe2M4m9MBg78+Q3j/Wyllah+s=;
        b=H0VbxN/y6Ttl/f2owWCKcW4YujmflsQx9M67abxQXuKhSekSpqbSf4cusGfXF8mGFq
         /IZY24fb7CeYtmkG4i0NvKJ869Kc6RSWe/32KVXpX3wgQgPkb5sB/OCa/hMLlacje1ov
         +nr760b+w6M3lKZTXU7ua18USPvvjcW5awz+cqYegMSXZKe6+7BZoQrKR3Oehd5KOW7L
         AT+13D083rAuCjw3zZ4RMlDmc/uOOgyrUVgB9X1LLdCj27TOELdcWfjgjlaGnNYWegL3
         sXCxDARbkMepzBcunqbR2ZpSgygLgdmx1cDve8oAmvEyzFbmlC0RrEP1smA9GmS/PfD4
         QGmA==
X-Gm-Message-State: APjAAAVZOkl8fFhcBVeX6Gef0WG7dboAY6ywWiy9pUNtGv85svnovy7i
        dFzuKa5wOZQggkH08vmXR6lDToJzvrG3Iu5wpD65Kw==
X-Google-Smtp-Source: APXvYqwz3qzVGEJocSaVXlW0xpE4ZpN2+r+dt+k/eZcevA/dcgNmWOhM7zMTdu1zQPv9PRQ5La5jJ5CiXUwDdoRK8Z4=
X-Received: by 2002:a0c:f703:: with SMTP id w3mr10940876qvn.6.1576818697391;
 Thu, 19 Dec 2019 21:11:37 -0800 (PST)
MIME-Version: 1.0
References: <1576813564-23927-1-git-send-email-weiyi.lu@mediatek.com> <1576813564-23927-9-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1576813564-23927-9-git-send-email-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 20 Dec 2019 13:11:26 +0800
Message-ID: <CANMq1KATUJxEAvMMbF7C24BXW6RkzugWDLzT47SEyKSVRHH51g@mail.gmail.com>
Subject: Re: [PATCH v11 08/10] soc: mediatek: Add MT8183 scpsys support
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
> Add scpsys driver for MT8183
> And minor fix to add a comma at the end

I'll leave it up to the maintainer, but those minor fixes outside of
new mt8183 code should probably be done as a separate CL.

>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 233 +++++++++++++++++++++++++++++++++++++-
>  drivers/soc/mediatek/scpsys-ext.h |  28 +++++
>  2 files changed, 255 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 1972726..b8b72fa 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -19,6 +19,7 @@
>  #include <dt-bindings/power/mt7622-power.h>
>  #include <dt-bindings/power/mt7623a-power.h>
>  #include <dt-bindings/power/mt8173-power.h>
> +#include <dt-bindings/power/mt8183-power.h>
>
>  #define MTK_POLL_DELAY_US   10
>  #define MTK_POLL_TIMEOUT    USEC_PER_SEC
> @@ -1082,12 +1083,218 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>         {MT8173_POWER_DOMAIN_MFG_2D, MT8173_POWER_DOMAIN_MFG},
>  };
>
> +/*
> + * MT8183 power domain support
> + */
> +
> +static const struct scp_domain_data scp_domain_data_mt8183[] = {
> +       [MT8183_POWER_DOMAIN_AUDIO] = {
> +               .name = "audio",
> +               .sta_mask = PWR_STATUS_AUDIO,
> +               .ctl_offs = 0x0314,
> +               .sram_pdn_bits = GENMASK(11, 8),
> +               .sram_pdn_ack_bits = GENMASK(15, 12),
> +               .basic_clk_name = {"audio", "audio1", "audio2"},
> +       },
> +       [MT8183_POWER_DOMAIN_CONN] = {
> +               .name = "conn",
> +               .sta_mask = PWR_STATUS_CONN,
> +               .ctl_offs = 0x032c,
> +               .sram_pdn_bits = 0,
> +               .sram_pdn_ack_bits = 0,
> +               .bp_table = {
> +                       BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
> +                               MT8183_TOP_AXI_PROT_EN_CONN),
> +               },
> +       },
> +       [MT8183_POWER_DOMAIN_MFG_ASYNC] = {
> +               .name = "mfg_async",
> +               .sta_mask = PWR_STATUS_MFG_ASYNC,
> +               .ctl_offs = 0x0334,
> +               .sram_pdn_bits = 0,
> +               .sram_pdn_ack_bits = 0,
> +               .basic_clk_name = {"mfg"},
> +       },
> +       [MT8183_POWER_DOMAIN_MFG] = {
> +               .name = "mfg",
> +               .sta_mask = PWR_STATUS_MFG,
> +               .ctl_offs = 0x0338,
> +               .sram_pdn_bits = GENMASK(8, 8),
> +               .sram_pdn_ack_bits = GENMASK(12, 12),
> +       },
> +       [MT8183_POWER_DOMAIN_MFG_CORE0] = {
> +               .name = "mfg_core0",
> +               .sta_mask = BIT(7),
> +               .ctl_offs = 0x034c,
> +               .sram_pdn_bits = GENMASK(8, 8),
> +               .sram_pdn_ack_bits = GENMASK(12, 12),
> +       },
> +       [MT8183_POWER_DOMAIN_MFG_CORE1] = {
> +               .name = "mfg_core1",
> +               .sta_mask = BIT(20),
> +               .ctl_offs = 0x0310,
> +               .sram_pdn_bits = GENMASK(8, 8),
> +               .sram_pdn_ack_bits = GENMASK(12, 12),
> +       },
> +       [MT8183_POWER_DOMAIN_MFG_2D] = {
> +               .name = "mfg_2d",
> +               .sta_mask = PWR_STATUS_MFG_2D,
> +               .ctl_offs = 0x0348,
> +               .sram_pdn_bits = GENMASK(8, 8),
> +               .sram_pdn_ack_bits = GENMASK(12, 12),
> +               .bp_table = {
> +                       BUS_PROT(IFR_TYPE, 0x2a8, 0x2ac, 0, 0x258,
> +                               MT8183_TOP_AXI_PROT_EN_1_MFG),
> +                       BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
> +                               MT8183_TOP_AXI_PROT_EN_MFG),
> +               },
> +       },
> +       [MT8183_POWER_DOMAIN_DISP] = {
> +               .name = "disp",
> +               .sta_mask = PWR_STATUS_DISP,
> +               .ctl_offs = 0x030c,
> +               .sram_pdn_bits = GENMASK(8, 8),
> +               .sram_pdn_ack_bits = GENMASK(12, 12),
> +               .basic_clk_name = {"mm"},
> +               .subsys_clk_prefix = "mm",
> +               .bp_table = {
> +                       BUS_PROT(IFR_TYPE, 0x2a8, 0x2ac, 0, 0x258,
> +                               MT8183_TOP_AXI_PROT_EN_1_DISP),
> +                       BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
> +                               MT8183_TOP_AXI_PROT_EN_DISP),
> +                       BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
> +                               MT8183_SMI_COMMON_SMI_CLAMP_DISP),
> +               },
> +       },
> +       [MT8183_POWER_DOMAIN_CAM] = {
> +               .name = "cam",
> +               .sta_mask = BIT(25),
> +               .ctl_offs = 0x0344,
> +               .sram_pdn_bits = GENMASK(9, 8),
> +               .sram_pdn_ack_bits = GENMASK(13, 12),
> +               .basic_clk_name = {"cam"},
> +               .subsys_clk_prefix = "cam",
> +               .bp_table = {
> +                       BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> +                               MT8183_TOP_AXI_PROT_EN_MM_CAM),
> +                       BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
> +                               MT8183_TOP_AXI_PROT_EN_CAM),
> +                       BUS_PROT_IGN(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> +                               MT8183_TOP_AXI_PROT_EN_MM_CAM_2ND),
> +                       BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
> +                               MT8183_SMI_COMMON_SMI_CLAMP_CAM),
> +               },
> +       },
> +       [MT8183_POWER_DOMAIN_ISP] = {
> +               .name = "isp",
> +               .sta_mask = PWR_STATUS_ISP,
> +               .ctl_offs = 0x0308,
> +               .sram_pdn_bits = GENMASK(9, 8),
> +               .sram_pdn_ack_bits = GENMASK(13, 12),
> +               .basic_clk_name = {"isp"},
> +               .subsys_clk_prefix = "isp",
> +               .bp_table = {
> +                       BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> +                               MT8183_TOP_AXI_PROT_EN_MM_ISP),
> +                       BUS_PROT_IGN(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> +                               MT8183_TOP_AXI_PROT_EN_MM_ISP_2ND),
> +                       BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
> +                               MT8183_SMI_COMMON_SMI_CLAMP_ISP),
> +               },
> +       },
> +       [MT8183_POWER_DOMAIN_VDEC] = {
> +               .name = "vdec",
> +               .sta_mask = BIT(31),
> +               .ctl_offs = 0x0300,
> +               .sram_pdn_bits = GENMASK(8, 8),
> +               .sram_pdn_ack_bits = GENMASK(12, 12),
> +               .bp_table = {
> +                       BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
> +                               MT8183_SMI_COMMON_SMI_CLAMP_VDEC),
> +               },
> +       },
> +       [MT8183_POWER_DOMAIN_VENC] = {
> +               .name = "venc",
> +               .sta_mask = PWR_STATUS_VENC,
> +               .ctl_offs = 0x0304,
> +               .sram_pdn_bits = GENMASK(11, 8),
> +               .sram_pdn_ack_bits = GENMASK(15, 12),
> +               .bp_table = {
> +                       BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
> +                               MT8183_SMI_COMMON_SMI_CLAMP_VENC),
> +               },
> +       },
> +       [MT8183_POWER_DOMAIN_VPU_TOP] = {
> +               .name = "vpu_top",
> +               .sta_mask = BIT(26),
> +               .ctl_offs = 0x0324,
> +               .sram_pdn_bits = GENMASK(8, 8),
> +               .sram_pdn_ack_bits = GENMASK(12, 12),
> +               .basic_clk_name = {"vpu", "vpu1"},
> +               .subsys_clk_prefix = "vpu",
> +               .bp_table = {
> +                       BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> +                               MT8183_TOP_AXI_PROT_EN_MM_VPU_TOP),
> +                       BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
> +                               MT8183_TOP_AXI_PROT_EN_VPU_TOP),
> +                       BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> +                               MT8183_TOP_AXI_PROT_EN_MM_VPU_TOP_2ND),
> +                       BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
> +                               MT8183_SMI_COMMON_SMI_CLAMP_VPU_TOP),
> +               },
> +       },
> +       [MT8183_POWER_DOMAIN_VPU_CORE0] = {
> +               .name = "vpu_core0",
> +               .sta_mask = BIT(27),
> +               .ctl_offs = 0x33c,
> +               .sram_iso_ctrl = true,
> +               .sram_pdn_bits = GENMASK(11, 8),
> +               .sram_pdn_ack_bits = GENMASK(13, 12),
> +               .basic_clk_name = {"vpu2"},
> +               .bp_table = {
> +                       BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
> +                               MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE0),
> +                       BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
> +                               MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE0_2ND),
> +               },
> +       },
> +       [MT8183_POWER_DOMAIN_VPU_CORE1] = {
> +               .name = "vpu_core1",
> +               .sta_mask = BIT(28),
> +               .ctl_offs = 0x0340,
> +               .sram_iso_ctrl = true,
> +               .sram_pdn_bits = GENMASK(11, 8),
> +               .sram_pdn_ack_bits = GENMASK(13, 12),
> +               .basic_clk_name = {"vpu3"},
> +               .bp_table = {
> +                       BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
> +                               MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE1),
> +                       BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
> +                               MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE1_2ND),
> +               },
> +       },
> +};
> +
> +static const struct scp_subdomain scp_subdomain_mt8183[] = {
> +       {MT8183_POWER_DOMAIN_MFG_ASYNC, MT8183_POWER_DOMAIN_MFG},
> +       {MT8183_POWER_DOMAIN_MFG, MT8183_POWER_DOMAIN_MFG_2D},
> +       {MT8183_POWER_DOMAIN_MFG, MT8183_POWER_DOMAIN_MFG_CORE0},
> +       {MT8183_POWER_DOMAIN_MFG, MT8183_POWER_DOMAIN_MFG_CORE1},
> +       {MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_CAM},
> +       {MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_ISP},
> +       {MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_VDEC},
> +       {MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_VENC},
> +       {MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_VPU_TOP},
> +       {MT8183_POWER_DOMAIN_VPU_TOP, MT8183_POWER_DOMAIN_VPU_CORE0},
> +       {MT8183_POWER_DOMAIN_VPU_TOP, MT8183_POWER_DOMAIN_VPU_CORE1},
> +};
> +
>  static const struct scp_soc_data mt2701_data = {
>         .domains = scp_domain_data_mt2701,
>         .num_domains = ARRAY_SIZE(scp_domain_data_mt2701),
>         .regs = {
>                 .pwr_sta_offs = SPM_PWR_STATUS,
> -               .pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> +               .pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
>         },
>  };
>
> @@ -1098,7 +1305,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>         .num_subdomains = ARRAY_SIZE(scp_subdomain_mt2712),
>         .regs = {
>                 .pwr_sta_offs = SPM_PWR_STATUS,
> -               .pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> +               .pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
>         },
>  };
>
> @@ -1109,7 +1316,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>         .num_subdomains = ARRAY_SIZE(scp_subdomain_mt6797),
>         .regs = {
>                 .pwr_sta_offs = SPM_PWR_STATUS_MT6797,
> -               .pwr_sta2nd_offs = SPM_PWR_STATUS_2ND_MT6797
> +               .pwr_sta2nd_offs = SPM_PWR_STATUS_2ND_MT6797,
>         },
>  };
>
> @@ -1118,7 +1325,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>         .num_domains = ARRAY_SIZE(scp_domain_data_mt7622),
>         .regs = {
>                 .pwr_sta_offs = SPM_PWR_STATUS,
> -               .pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> +               .pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
>         },
>  };
>
> @@ -1127,7 +1334,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>         .num_domains = ARRAY_SIZE(scp_domain_data_mt7623a),
>         .regs = {
>                 .pwr_sta_offs = SPM_PWR_STATUS,
> -               .pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> +               .pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
>         },
>  };
>
> @@ -1138,10 +1345,21 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>         .num_subdomains = ARRAY_SIZE(scp_subdomain_mt8173),
>         .regs = {
>                 .pwr_sta_offs = SPM_PWR_STATUS,
> -               .pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> +               .pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
>         },
>  };
>
> +static const struct scp_soc_data mt8183_data = {
> +       .domains = scp_domain_data_mt8183,
> +       .num_domains = ARRAY_SIZE(scp_domain_data_mt8183),
> +       .subdomains = scp_subdomain_mt8183,
> +       .num_subdomains = ARRAY_SIZE(scp_subdomain_mt8183),
> +       .regs = {
> +               .pwr_sta_offs = 0x0180,
> +               .pwr_sta2nd_offs = 0x0184,
> +       }
> +};
> +
>  /*
>   * scpsys driver init
>   */
> @@ -1166,6 +1384,9 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .compatible = "mediatek,mt8173-scpsys",
>                 .data = &mt8173_data,
>         }, {
> +               .compatible = "mediatek,mt8183-scpsys",
> +               .data = &mt8183_data,
> +       }, {
>                 /* sentinel */
>         }
>  };
> diff --git a/drivers/soc/mediatek/scpsys-ext.h b/drivers/soc/mediatek/scpsys-ext.h
> index 458b2c5..0f90e5d 100644
> --- a/drivers/soc/mediatek/scpsys-ext.h
> +++ b/drivers/soc/mediatek/scpsys-ext.h
> @@ -43,6 +43,34 @@
>  #define MT8173_TOP_AXI_PROT_EN_MFG_M1          BIT(22)
>  #define MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT   BIT(23)
>
> +#define MT8183_TOP_AXI_PROT_EN_DISP                    (BIT(10) | BIT(11))
> +#define MT8183_TOP_AXI_PROT_EN_CONN                    (BIT(13) | BIT(14))
> +#define MT8183_TOP_AXI_PROT_EN_MFG                     (BIT(21) | BIT(22))
> +#define MT8183_TOP_AXI_PROT_EN_CAM                     BIT(28)
> +#define MT8183_TOP_AXI_PROT_EN_VPU_TOP                 BIT(27)
> +#define MT8183_TOP_AXI_PROT_EN_1_DISP                  (BIT(16) | BIT(17))
> +#define MT8183_TOP_AXI_PROT_EN_1_MFG                   GENMASK(21, 19)
> +#define MT8183_TOP_AXI_PROT_EN_MM_ISP                  (BIT(3) | BIT(8))
> +#define MT8183_TOP_AXI_PROT_EN_MM_ISP_2ND              BIT(10)
> +#define MT8183_TOP_AXI_PROT_EN_MM_CAM                  (BIT(4) | BIT(5) | \
> +                                                        BIT(9) | BIT(13))
> +#define MT8183_TOP_AXI_PROT_EN_MM_VPU_TOP              (GENMASK(9, 6) | \
> +                                                        BIT(12))
> +#define MT8183_TOP_AXI_PROT_EN_MM_VPU_TOP_2ND          (BIT(10) | BIT(11))
> +#define MT8183_TOP_AXI_PROT_EN_MM_CAM_2ND              BIT(11)
> +#define MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE0_2ND       (BIT(0) | BIT(2) | \
> +                                                        BIT(4))
> +#define MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE1_2ND       (BIT(1) | BIT(3) | \
> +                                                        BIT(5))
> +#define MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE0           BIT(6)
> +#define MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE1           BIT(7)
> +#define MT8183_SMI_COMMON_SMI_CLAMP_DISP               GENMASK(7, 0)
> +#define MT8183_SMI_COMMON_SMI_CLAMP_VENC               BIT(1)
> +#define MT8183_SMI_COMMON_SMI_CLAMP_ISP                BIT(2)
> +#define MT8183_SMI_COMMON_SMI_CLAMP_CAM                (BIT(3) | BIT(4))
> +#define MT8183_SMI_COMMON_SMI_CLAMP_VPU_TOP            (BIT(5) | BIT(6))
> +#define MT8183_SMI_COMMON_SMI_CLAMP_VDEC               BIT(7)
> +
>  enum regmap_type {
>         INVALID_TYPE = 0,
>         IFR_TYPE,
> --
> 1.8.1.1.dirty
