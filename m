Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B7DC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B697321582
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kdo+GJdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfLSDyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 22:54:31 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:39993 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfLSDyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 22:54:31 -0500
Received: by mail-qv1-f68.google.com with SMTP id dp13so1696643qvb.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 19:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F3u9kGaQk+7+mvvGSN3GLe2hFj+Kn5FQzP51xZCsUKo=;
        b=Kdo+GJdX7tYzhXquSDc0xGVNiOOg5TeySqELrQ2yuh9FWPf5ylwA3V6z7XSfLZl2re
         St7zg+5OfREjsHKCXhtwSSiw5wPLn2LgGO44RUPigiSQTeMaC5jNE5ghGGw5vG87ssPx
         vV1He9TBFtYLo9BR3a0fBxWAEAus5wwPrQcLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3u9kGaQk+7+mvvGSN3GLe2hFj+Kn5FQzP51xZCsUKo=;
        b=iBo+pjAWxF/Wqgd8UX05RlntJy//ygOxFo4MfDBIbpJSS+ag3ICRhs6x8QajWWnRYV
         rL6gAXa3/Ua2bjxmgf/LvvXEM67JyCsQSZm7GTA5c2Aexk6GSj0+cLL5QEh192Xk4Bz+
         ynBREyzgFOiMH5HWxKFK1wuD6hmWino9hfvFitBmy1dXZmY2JCYMXiO9gpEuokZ6MJet
         MEIsbT/fw46qlG0lPbcIlt2m3yjHRLLKLJIdoPci2vGTLcJbMOx7TXLHI7TXk7OW146J
         pqS4AjzgedVV6cyXbWzkcNPwEWzXcXHJAwQZGzb+IHlXTvQC/6m6Ydu15ypuuQOirXit
         YtKw==
X-Gm-Message-State: APjAAAWdeASSAU1oObsiEl3Dg6fwzmRaXC6H/Wi8naHUylRhPM0uE42q
        RhPPgYns52R+ri64cUlf5mHM3Hg5CAr7gBS0cUguOQ==
X-Google-Smtp-Source: APXvYqwuyAXa2Jdb5SI5NjuVCqpwCGL57AeIkrWFebqCOrV3nUWLdEqBGI7lMw4kze/n/yjz3JdwZP26fwmXaNefFDc=
X-Received: by 2002:a05:6214:42c:: with SMTP id a12mr5659443qvy.172.1576727669559;
 Wed, 18 Dec 2019 19:54:29 -0800 (PST)
MIME-Version: 1.0
References: <1576657848-14711-1-git-send-email-weiyi.lu@mediatek.com> <1576657848-14711-7-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1576657848-14711-7-git-send-email-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 19 Dec 2019 11:54:18 +0800
Message-ID: <CANMq1KCbmwY_nZTfZcbxYQm27CXdADD48RWQOx0JuTmGBn=y=g@mail.gmail.com>
Subject: Re: [PATCH v10 06/12] soc: mediatek: Use bp_table for all compatibles
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
> Only use bp_table for bus protection of all compatibles,
> instead of mixing bus_prot_mask and bus_prot_reg_update.

ditto, I'd just squash in the previous patch.

> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 94 ++++++++++++++++++++-------------------
>  1 file changed, 48 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 5699d9f..c438c53 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -11,7 +11,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/regulator/consumer.h>
> -#include <linux/soc/mediatek/infracfg.h>
>  #include <linux/soc/mediatek/scpsys-ext.h>
>
>  #include <dt-bindings/power/mt2701-power.h>
> @@ -88,7 +87,6 @@
>   * @ctl_offs: The offset for main power control register.
>   * @sram_pdn_bits: The mask for sram power control bits.
>   * @sram_pdn_ack_bits: The mask for sram power control acked bits.
> - * @bus_prot_mask: The mask for single step bus protection.
>   * @basic_clk_name: The basic clocks required by this power domain.
>   * @caps: The flag for active wake-up action.
>   * @bp_table: The mask table for multiple step bus protection.
> @@ -99,7 +97,6 @@ struct scp_domain_data {
>         int ctl_offs;
>         u32 sram_pdn_bits;
>         u32 sram_pdn_ack_bits;
> -       u32 bus_prot_mask;
>         const char *basic_clk_name[MAX_CLKS];
>         u8 caps;
>         struct bus_prot bp_table[MAX_STEPS];
> @@ -128,7 +125,6 @@ struct scp {
>         struct regmap *infracfg;
>         struct regmap *smi_common;
>         struct scp_ctrl_reg ctrl_reg;
> -       bool bus_prot_reg_update;
>  };
>
>  struct scp_subdomain {
> @@ -142,7 +138,6 @@ struct scp_soc_data {
>         const struct scp_subdomain *subdomains;
>         int num_subdomains;
>         const struct scp_ctrl_reg regs;
> -       bool bus_prot_reg_update;
>  };
>
>  static int scpsys_domain_is_on(struct scp_domain *scpd)
> @@ -256,12 +251,6 @@ static int scpsys_bus_protect_enable(struct scp_domain *scpd)
>  {
>         struct scp *scp = scpd->scp;
>
> -       if (scpd->data->bus_prot_mask) {
> -               return mtk_infracfg_set_bus_protection(scp->infracfg,
> -                               scpd->data->bus_prot_mask,
> -                               scp->bus_prot_reg_update);
> -       }
> -
>         return mtk_scpsys_ext_set_bus_protection(scpd->data->bp_table,
>                         scp->infracfg, scp->smi_common);
>  }
> @@ -270,12 +259,6 @@ static int scpsys_bus_protect_disable(struct scp_domain *scpd)
>  {
>         struct scp *scp = scpd->scp;
>
> -       if (scpd->data->bus_prot_mask) {
> -               return mtk_infracfg_clear_bus_protection(scp->infracfg,
> -                               scpd->data->bus_prot_mask,
> -                               scp->bus_prot_reg_update);
> -       }
> -
>         return mtk_scpsys_ext_clear_bus_protection(scpd->data->bp_table,
>                         scp->infracfg, scp->smi_common);
>  }
> @@ -412,8 +395,7 @@ static int init_basic_clks(struct platform_device *pdev, struct clk **clk,
>
>  static struct scp *init_scp(struct platform_device *pdev,
>                         const struct scp_domain_data *scp_domain_data, int num,
> -                       const struct scp_ctrl_reg *scp_ctrl_reg,
> -                       bool bus_prot_reg_update)
> +                       const struct scp_ctrl_reg *scp_ctrl_reg)
>  {
>         struct genpd_onecell_data *pd_data;
>         struct resource *res;
> @@ -427,8 +409,6 @@ static struct scp *init_scp(struct platform_device *pdev,
>         scp->ctrl_reg.pwr_sta_offs = scp_ctrl_reg->pwr_sta_offs;
>         scp->ctrl_reg.pwr_sta2nd_offs = scp_ctrl_reg->pwr_sta2nd_offs;
>
> -       scp->bus_prot_reg_update = bus_prot_reg_update;
> -
>         scp->dev = &pdev->dev;
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -549,8 +529,10 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .name = "conn",
>                 .sta_mask = PWR_STATUS_CONN,
>                 .ctl_offs = SPM_CONN_PWR_CON,
> -               .bus_prot_mask = MT2701_TOP_AXI_PROT_EN_CONN_M |
> -                                MT2701_TOP_AXI_PROT_EN_CONN_S,
> +               .bp_table = {
> +                       BUS_PROT(IFR_TYPE, 0, 0, 0x220, 0x228,
> +                               BIT(2) | BIT(8), BIT(2) | BIT(8)),
> +               },

I'm a bit sad we lose the information about the BIT meaning.

Of course this looks ugly and verbose:
                      BUS_PROT(IFR_TYPE, 0, 0, 0x220, 0x228,
                               MT2701_TOP_AXI_PROT_EN_CONN_M |
MT2701_TOP_AXI_PROT_EN_CONN_S,
                               MT2701_TOP_AXI_PROT_EN_CONN_M |
MT2701_TOP_AXI_PROT_EN_CONN_S),

But if you make "check_clr_mask" a boolean, you wouldn't have to
repeat the mask twice and you could keep the nice register bit
definitions.

[snip, many similar occurences below]
