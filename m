Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474BBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1522A20854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LAVIaGfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfCSMDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:03:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34834 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfCSMDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:03:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id h39so21734766qte.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 05:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZqLVNyhuH+gUXvfssxaTdgTzYRiUdeA2xUAwVxHGvEI=;
        b=LAVIaGfec8dONJ1VTXxF7gBiLMpqGzXW2dJdolK1EJrYvh8QMQBDdfgEWNnz/keF7/
         wdkW238FPXfEQwnJNcx6uVQ2llO2Cy23LUSvTueaiyltcg37+VGSjtWkA59/k27q4w8e
         FNZ9h/a5h3GeJiyT/5VP+QCKScidqResRDOQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZqLVNyhuH+gUXvfssxaTdgTzYRiUdeA2xUAwVxHGvEI=;
        b=sE6i4wibzTEaYgQA8NBeK1uAgd+HHyFEZA7W7s/YyQ8RwNOhfI0Y3+8AdCA+taWtlu
         JBSOvPNVfwgo+qVQXjCQerkeh3+mn2bvJzITSceMtpcuaAlAP7Q3Ex4FxCzPYOgYz3DL
         AzRhc1Di0XN5powJbCFnyyWV3U8IPkBkzfeBIAW2fQomhLKpJfKrThmbEfPjWLgzwI1X
         loRQJhvvM8aDXQOHOa5gZ9wDieBevQPPRj/Qj+6u7NxNqq3J0GUG54zIGAarM/8fWXTC
         JWeaZoxn+0/0xHdV48bij85JZJjHAU8YUKuvzGwMjgP/ZLhYezf+meTfxlI2NMy2qoxn
         bsxg==
X-Gm-Message-State: APjAAAUACJ7wDIxVqD2Eg1cS+DxWJFik7U0vuOD1b0M2wcswqWplq/HN
        w6nJ431KcxRzTryXyHD0p6mlo3ufPs43TmOygzUbSVBho3B8fA==
X-Google-Smtp-Source: APXvYqxFEYKEFnolK3fOin61K12SCmnRiEBy9eD/gw8GJcODjbSx5qNxj4Q0z0eyw2hvm3g0HnV5NTbnDZbW3T+dW0A=
X-Received: by 2002:ac8:1884:: with SMTP id s4mr1616722qtj.339.1552996984945;
 Tue, 19 Mar 2019 05:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190319080140.24055-1-weiyi.lu@mediatek.com> <20190319080140.24055-7-weiyi.lu@mediatek.com>
In-Reply-To: <20190319080140.24055-7-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 19 Mar 2019 20:02:53 +0800
Message-ID: <CANMq1KCxhnn+fKaxS1RbpYYJ7pcXzD8XkqTBJHiauHbfrYVTGA@mail.gmail.com>
Subject: Re: [PATCH v5 06/14] soc: mediatek: Refactor clock control
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
> Put clock enable and disable control in separate function.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 49 ++++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 765ad4a5e5df..3e9be07a2627 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -208,6 +208,33 @@ static int scpsys_regulator_disable(struct scp_domain *scpd)
>         return regulator_disable(scpd->supply);
>  }
>
> +static int scpsys_clk_enable(struct clk *clk[], int max_num)
> +{
> +       int i, ret = 0;
> +
> +       for (i = 0; i < max_num && clk[i]; i++) {
> +               ret = clk_prepare_enable(clk[i]);
> +               if (ret) {
> +                       for (--i; i >= 0; i--)
> +                               clk_disable_unprepare(clk[i]);

Would it be simpler to just call scpsys_clk_disable(clk, i) ?

> +
> +                       break;
> +               }
> +       }
> +
> +       return ret;
> +}

Maybe not for this series, but could you use clk_bulk_prepare_enable
instead? The only issue is that it'd still call clk_prepare_enable on
NULL clocks, but that does nothing, so it's just a little less
efficient...

> +
> +static void scpsys_clk_disable(struct clk *clk[], int max_num)
> +{
> +       int i;
> +
> +       for (i = max_num - 1; i >= 0; i--) {
> +               if (clk[i])

if test not needed, clk_disable_unprepare ignores NULL parameters.

> +                       clk_disable_unprepare(clk[i]);
> +       }
> +}

ditto: clk_bulk_disable_unprepare

> +
>  static int scpsys_power_on(struct generic_pm_domain *genpd)
>  {
>         struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
> @@ -216,21 +243,14 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>         u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
>         u32 val;
>         int ret, tmp;
> -       int i;
>
>         ret = scpsys_regulator_enable(scpd);
>         if (ret < 0)
>                 return ret;
>
> -       for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++) {
> -               ret = clk_prepare_enable(scpd->clk[i]);
> -               if (ret) {
> -                       for (--i; i >= 0; i--)
> -                               clk_disable_unprepare(scpd->clk[i]);
> -
> -                       goto err_clk;
> -               }
> -       }
> +       ret = scpsys_clk_enable(scpd->clk, MAX_CLKS);
> +       if (ret)
> +               goto err_clk;
>
>         val = readl(ctl_addr);
>         val |= PWR_ON_BIT;
> @@ -283,10 +303,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>         return 0;
>
>  err_pwr_ack:
> -       for (i = MAX_CLKS - 1; i >= 0; i--) {
> -               if (scpd->clk[i])
> -                       clk_disable_unprepare(scpd->clk[i]);
> -       }
> +       scpsys_clk_disable(scpd->clk, MAX_CLKS);
>  err_clk:
>         scpsys_regulator_disable(scpd);
>
> @@ -303,7 +320,6 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>         u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
>         u32 val;
>         int ret, tmp;
> -       int i;
>
>         if (scpd->data->bus_prot_mask) {
>                 ret = mtk_infracfg_set_bus_protection(scp->infracfg,
> @@ -344,8 +360,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>         if (ret < 0)
>                 goto out;
>
> -       for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++)
> -               clk_disable_unprepare(scpd->clk[i]);
> +       scpsys_clk_disable(scpd->clk, MAX_CLKS);
>
>         ret = scpsys_regulator_disable(scpd);
>         if (ret < 0)
> --
> 2.18.0
>
