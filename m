Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83031C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4936F20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VaJ3+dSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfCSMHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:07:41 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44059 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCSMHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:07:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id w5so13431032qtb.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 05:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MPDV2qSug5rQAsRc5/0BwfhIaVV1mkLcVtAlJwstDms=;
        b=VaJ3+dSDOoaKxrGoJotnqNx81weGxD+/x0D2/7yj/dPRzCvLlx9Z8qSpDZVKZPleVL
         3GsMIgMxudR4kalsXKgHm3frCS1tKsrmpnOvByoD+yd1fXl2znSTWAge45oslxipMoK2
         ugySAHHiGln8Yc9f25GPedmrNgPNFZfkBZZTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPDV2qSug5rQAsRc5/0BwfhIaVV1mkLcVtAlJwstDms=;
        b=Yh3JBYqHeTkQp5xnCYKvcM9+fuli8XssCrsfItCc4Tg8b9V0X53aP8C0ciZdISBVmD
         t5btYuJHcfDNFnnGpbomFXnrqgSKYMsw3UKtTsQfzK1MlXXAR+WYBXQGqxbGdc0N7c6B
         XM4mLB6ndpBmLq9UAnfSh2OEvXK0ShMijBzaEaZgFDHmliVHNfXoUXSEiuPHzkh9umJg
         UWcag078bilEJ4uE4VymaRMgZU0aCWSbS67oQWz6FOifDbXG8ZtyBvUGQ4Fh3WEXKzj1
         y2n35lYWq4YNJGNuvFFtRdWFRwB0TrqWxsqQxoVcDyg2Qo/K2+Q7Ad3BbA2AJuoCYB2A
         SXiw==
X-Gm-Message-State: APjAAAWVvds1PfUHqITy7V7JLTKj9rIpP9xWf5WfLgVsTV8SNGfwP5FY
        IHPwRIR6sMNTeRPcL8/gWEv7PXs7soEAUTQGgkLtww==
X-Google-Smtp-Source: APXvYqy4QMgvhLtn0yULQ1Wub2vlz3HjialuTafXubZYDKXQH4jB49F84JGUuCwULc3+SGi6ERGcwJZQPLN47MqfW5M=
X-Received: by 2002:ac8:f3c:: with SMTP id e57mr1604279qtk.75.1552997259736;
 Tue, 19 Mar 2019 05:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190319080140.24055-1-weiyi.lu@mediatek.com> <20190319080140.24055-8-weiyi.lu@mediatek.com>
In-Reply-To: <20190319080140.24055-8-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 19 Mar 2019 20:07:28 +0800
Message-ID: <CANMq1KAYU8xVcdhYBDwy8Nh+=naH5bDYyJ2seZWHzvNHW=eDvw@mail.gmail.com>
Subject: Re: [PATCH v5 07/14] soc: mediatek: Refactor sram control
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
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

On Tue, Mar 19, 2019 at 4:02 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> Put sram enable and disable control in separate functions.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>

Refactoring looks ok, just a small comment.

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 79 ++++++++++++++++++++-----------
>  1 file changed, 51 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 3e9be07a2627..65b734b40098 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -235,12 +235,55 @@ static void scpsys_clk_disable(struct clk *clk[], int max_num)
>         }
>  }
>
> +static int scpsys_sram_enable(struct scp_domain *scpd, void __iomem *ctl_addr)
> +{
> +       u32 val;
> +       u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
> +       int tmp;
> +
> +       val = readl(ctl_addr) & ~scpd->data->sram_pdn_bits;
> +       writel(val, ctl_addr);
> +
> +       /* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
> +       if (MTK_SCPD_CAPS(scpd, MTK_SCPD_FWAIT_SRAM)) {
> +               /*
> +                * Currently, MTK_SCPD_FWAIT_SRAM is necessary only for
> +                * MT7622_POWER_DOMAIN_WB and thus just a trivial setup
> +                * is applied here.
> +                */
> +               usleep_range(12000, 12100);

Does the range really need to be so tight? Would 12000, 13000 also be ok?

> +       } else {
> +               /* Either wait until SRAM_PDN_ACK all 1 or 0 */
> +               int ret = readl_poll_timeout(ctl_addr, tmp,
> +                               (tmp & pdn_ack) == 0,
> +                               MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int scpsys_sram_disable(struct scp_domain *scpd, void __iomem *ctl_addr)
> +{
> +       u32 val;
> +       u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
> +       int tmp;
> +
> +       val = readl(ctl_addr) | scpd->data->sram_pdn_bits;
> +       writel(val, ctl_addr);
> +
> +       /* Either wait until SRAM_PDN_ACK all 1 or 0 */
> +       return readl_poll_timeout(ctl_addr, tmp,
> +                       (tmp & pdn_ack) == pdn_ack,
> +                       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +}
> +
>  static int scpsys_power_on(struct generic_pm_domain *genpd)
>  {
>         struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
>         struct scp *scp = scpd->scp;
>         void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
> -       u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
>         u32 val;
>         int ret, tmp;
>
> @@ -252,6 +295,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>         if (ret)
>                 goto err_clk;
>
> +       /* subsys power on */
>         val = readl(ctl_addr);
>         val |= PWR_ON_BIT;
>         writel(val, ctl_addr);
> @@ -273,24 +317,9 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>         val |= PWR_RST_B_BIT;
>         writel(val, ctl_addr);
>
> -       val &= ~scpd->data->sram_pdn_bits;
> -       writel(val, ctl_addr);
> -
> -       /* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
> -       if (MTK_SCPD_CAPS(scpd, MTK_SCPD_FWAIT_SRAM)) {
> -               /*
> -                * Currently, MTK_SCPD_FWAIT_SRAM is necessary only for
> -                * MT7622_POWER_DOMAIN_WB and thus just a trivial setup is
> -                * applied here.
> -                */
> -               usleep_range(12000, 12100);
> -
> -       } else {
> -               ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
> -                                        MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> -               if (ret < 0)
> -                       goto err_pwr_ack;
> -       }
> +       ret = scpsys_sram_enable(scpd, ctl_addr);
> +       if (ret < 0)
> +               goto err_pwr_ack;
>
>         if (scpd->data->bus_prot_mask) {
>                 ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> @@ -317,7 +346,6 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>         struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
>         struct scp *scp = scpd->scp;
>         void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
> -       u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
>         u32 val;
>         int ret, tmp;
>
> @@ -329,17 +357,12 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>                         goto out;
>         }
>
> -       val = readl(ctl_addr);
> -       val |= scpd->data->sram_pdn_bits;
> -       writel(val, ctl_addr);
> -
> -       /* wait until SRAM_PDN_ACK all 1 */
> -       ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == pdn_ack,
> -                                MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +       ret = scpsys_sram_disable(scpd, ctl_addr);
>         if (ret < 0)
>                 goto out;
>
> -       val |= PWR_ISO_BIT;
> +       /* subsys power off */
> +       val = readl(ctl_addr) | PWR_ISO_BIT;
>         writel(val, ctl_addr);
>
>         val &= ~PWR_RST_B_BIT;
> --
> 2.18.0
>
