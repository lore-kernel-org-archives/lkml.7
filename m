Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C116EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5F820643
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GeV00N6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfCSMJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:09:27 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44512 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfCSMJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:09:27 -0400
Received: by mail-qk1-f195.google.com with SMTP id m65so4032952qkl.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 05:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UMI5Cgc11e2yU8u3j1DQCbpem4FZZKd0yljARClXFro=;
        b=GeV00N6YFNcSkdveLp3qbBsP25FpiClQyosN8YpStzmygrX9G0ko+F80dXzXIolrwp
         L9b7XW+t3wXDX8eNHpPDrCRb5gsHeoqLvRkhdsWwdJUlGpbMvPiQFng0q2R1FTpOm9dV
         Uq86ESLpoUR4Px3rhBWah3eoYPuPUCOfl3+0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMI5Cgc11e2yU8u3j1DQCbpem4FZZKd0yljARClXFro=;
        b=MC/i/vTQYH0I4lYNkuJtJYnRc1nvgvqT1xMoN+3NX+m1g4XbFSjzaA9amdmzSFKUz/
         4Iuz2D7hm0jXCiNmNRmmE1enybZ5dupcjum/nhKROfTwt4KoQ+uhTjXynYQGDs/vORcb
         aa3e/450URY4Wnt2pB+kUxgdLwFA/NEWxjTNEQA2NqzvOo46AaN0gmLj9V9spgH5DIPp
         BoiGvOipVr87Ql5xRfKXw1lHfxkusraot+r3GfHwuxhAK0nhlP3N0PgCYc1KOPUEMLNK
         26nDHqpkCBe3ZLxCxa2qIjX0iG6j9T0Hfve16Mq+fptunYykJMVgLySmnKncEBauXJm+
         fu9A==
X-Gm-Message-State: APjAAAXrYCldGc3/IQunf/chKB5y9KRkLBcU59qnlQ5hM1sKafi/JY0U
        F4iawyahi08khh1Zwl/g9J4gZNeL6raR2MWrrsSepw==
X-Google-Smtp-Source: APXvYqzDZ3VEY8iiJcPcWsfrtadH33SNqnqU817R+1Gz8ZBnrcakW2/2MK5sZSC33b3xoOrgJyDKJ+USzG2Ant1QDTk=
X-Received: by 2002:a05:620a:1428:: with SMTP id k8mr1452326qkj.185.1552997366008;
 Tue, 19 Mar 2019 05:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190319080140.24055-1-weiyi.lu@mediatek.com> <20190319080140.24055-9-weiyi.lu@mediatek.com>
In-Reply-To: <20190319080140.24055-9-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 19 Mar 2019 20:09:14 +0800
Message-ID: <CANMq1KDkzWk-CSib7NBtc-2zqmoW31vFrO5sOj1up-vFvnmhjQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] soc: mediatek: Refactor bus protection control
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
> Put bus protection enable and disable control in separate functions.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 48 ++++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 65b734b40098..6bf846cb1893 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -279,6 +279,34 @@ static int scpsys_sram_disable(struct scp_domain *scpd, void __iomem *ctl_addr)
>                         MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>  }
>
> +static int scpsys_bus_protect_enable(struct scp_domain *scpd)
> +{
> +       struct scp *scp = scpd->scp;
> +       int ret = 0;
> +
> +       if (scpd->data->bus_prot_mask) {
> +               ret = mtk_infracfg_set_bus_protection(scp->infracfg,
> +                               scpd->data->bus_prot_mask,
> +                               scp->bus_prot_reg_update);
> +       }
> +
> +       return ret;

Maybe other people have different opinions, but I prefer:

if (!scpd->data->bus_prot_mask)
    return 0;

return mtk_infracfg_set_bus_protection(...);

> +}
> +
> +static int scpsys_bus_protect_disable(struct scp_domain *scpd)
> +{
> +       struct scp *scp = scpd->scp;
> +       int ret = 0;
> +
> +       if (scpd->data->bus_prot_mask) {
> +               ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> +                               scpd->data->bus_prot_mask,
> +                               scp->bus_prot_reg_update);
> +       }
> +
> +       return ret;
> +}
> +
>  static int scpsys_power_on(struct generic_pm_domain *genpd)
>  {
>         struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
> @@ -321,13 +349,9 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>         if (ret < 0)
>                 goto err_pwr_ack;
>
> -       if (scpd->data->bus_prot_mask) {
> -               ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> -                               scpd->data->bus_prot_mask,
> -                               scp->bus_prot_reg_update);
> -               if (ret)
> -                       goto err_pwr_ack;
> -       }
> +       ret = scpsys_bus_protect_disable(scpd);
> +       if (ret < 0)
> +               goto err_pwr_ack;
>
>         return 0;
>
> @@ -349,13 +373,9 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>         u32 val;
>         int ret, tmp;
>
> -       if (scpd->data->bus_prot_mask) {
> -               ret = mtk_infracfg_set_bus_protection(scp->infracfg,
> -                               scpd->data->bus_prot_mask,
> -                               scp->bus_prot_reg_update);
> -               if (ret)
> -                       goto out;
> -       }
> +       ret = scpsys_bus_protect_enable(scpd);
> +       if (ret < 0)
> +               goto out;
>
>         ret = scpsys_sram_disable(scpd, ctl_addr);
>         if (ret < 0)
> --
> 2.18.0
>
