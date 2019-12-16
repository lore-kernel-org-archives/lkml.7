Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970CFC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 07:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F62A2072B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 07:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e8ggX3a1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfLPH0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 02:26:32 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42599 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfLPH0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 02:26:31 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so5023254qtq.9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 23:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qev2qlm66Bfa3+rGRGT2b2yJ/ooSVkMjEt/Wv16RLPQ=;
        b=e8ggX3a1g9wX+PyY5W/KUblmVz3Y6XKLWDlsbNmE9Y5zsYpVs+bEdxp1kjs/qEwoPu
         YTjI6ralNbNsNw2/VBXUPAmvSKJkhjkLSV8gsYhzYVhEZa8htva0lrZyFmxqQQ0Rd+DM
         fr1ZpOomhPXusfqvBBFuXwULgPR0whyL1xmHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qev2qlm66Bfa3+rGRGT2b2yJ/ooSVkMjEt/Wv16RLPQ=;
        b=sWRSIL1MO6VwgycRpgbZtTjecH0Jcx6AN4IDLQPcjEFqxNBGAaPPeoMdREqQjbAbkM
         rsbK5JwLsn/J/jJUTRA05kPQxjQLqgJKPycKiA9b1VyUTQljVmcggLVkCJ63HnTT6o+U
         AcY0QZiD7lSxiOFTV+DqYaasH+wCpxuS/H0VWOHlTt2SWmaLwKZqt7vPidL7ktQiHj8G
         xN1EfQpoS5fAsRWVyHQ1gLqNDbU9iLNEse+fML4vP7Ivy+Jf1wSFKtm/n5YkOgoEEf3Q
         dKrnYKfWMb9IJaJKY7NiLLexmnKWW5P/IQVT5bPIx8qegMdapGUYJpMs+Y1imHtWiZS4
         0FXQ==
X-Gm-Message-State: APjAAAWcm8rzg6uh3Nr3nvSzjwZa6RTA3b8m2+lAvhlKy26l5N0jCHmA
        Gs4LbJ2MGwjRibZnF3WStGRuCJDXmO8K0VSB+WMLfQ==
X-Google-Smtp-Source: APXvYqxshH7WEvxYDG0MFKx4p0pn9ypNr7UaFIElKRvCHZ+6xtrrzlkv4ZXIdhS/YyGfeoNUHvUy0JxcrorzHMeRlV4=
X-Received: by 2002:ac8:3946:: with SMTP id t6mr23674125qtb.278.1576481190402;
 Sun, 15 Dec 2019 23:26:30 -0800 (PST)
MIME-Version: 1.0
References: <1575960413-6900-1-git-send-email-weiyi.lu@mediatek.com> <1575960413-6900-6-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1575960413-6900-6-git-send-email-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 16 Dec 2019 15:26:19 +0800
Message-ID: <CANMq1KDQRFzQ9=TinO_qQkXkP056uha_JZTydg0c8UYYHEw1=Q@mail.gmail.com>
Subject: Re: [PATCH v9 5/9] soc: mediatek: Add subsys clock control for bus protection
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 2:47 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> Add subsys CG control flow before/after the bus protect control
> due to bus protection need SMI bus relative CGs enabled to feedback
> its ack.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>

I'm not a clock expert but this one looks ok.

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 72 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 70 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 466bb749..2bbf907 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -108,6 +108,7 @@ enum clk_id {
>  };
>
>  #define MAX_CLKS       3
> +#define MAX_SUBSYS_CLKS 10
>
>  /**
>   * struct scp_domain_data - scp domain data for power on/off flow
> @@ -120,6 +121,8 @@ enum clk_id {
>   * @clk_id: The basic clocks required by this power domain.
>   * @basic_clk_id: provide the same purpose with field "clk_id"
>   *                by declaring basic clock prefix name rather than clk_id.
> + * @subsys_clk_prefix: The prefix name of the clocks need to be enabled
> + *                     before releasing bus protection.
>   * @caps: The flag for active wake-up action.
>   * @bp_table: The mask table for multiple step bus protection.
>   */
> @@ -132,6 +135,7 @@ struct scp_domain_data {
>         u32 bus_prot_mask;
>         enum clk_id clk_id[MAX_CLKS];
>         const char *basic_clk_id[MAX_CLKS];
> +       const char *subsys_clk_prefix;
>         u8 caps;
>         struct bus_prot bp_table[MAX_STEPS];
>  };
> @@ -142,6 +146,7 @@ struct scp_domain {
>         struct generic_pm_domain genpd;
>         struct scp *scp;
>         struct clk *clk[MAX_CLKS];
> +       struct clk *subsys_clk[MAX_SUBSYS_CLKS];
>         const struct scp_domain_data *data;
>         struct regulator *supply;
>  };
> @@ -349,16 +354,22 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>         val |= PWR_RST_B_BIT;
>         writel(val, ctl_addr);
>
> -       ret = scpsys_sram_enable(scpd, ctl_addr);
> +       ret = scpsys_clk_enable(scpd->subsys_clk, MAX_SUBSYS_CLKS);
>         if (ret < 0)
>                 goto err_pwr_ack;
>
> +       ret = scpsys_sram_enable(scpd, ctl_addr);
> +       if (ret < 0)
> +               goto err_sram;
> +
>         ret = scpsys_bus_protect_disable(scpd);
>         if (ret < 0)
> -               goto err_pwr_ack;
> +               goto err_sram;
>
>         return 0;
>
> +err_sram:
> +       scpsys_clk_disable(scpd->subsys_clk, MAX_SUBSYS_CLKS);
>  err_pwr_ack:
>         scpsys_clk_disable(scpd->clk, MAX_CLKS);
>  err_clk:
> @@ -385,6 +396,8 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>         if (ret < 0)
>                 goto out;
>
> +       scpsys_clk_disable(scpd->subsys_clk, MAX_SUBSYS_CLKS);
> +
>         /* subsys power off */
>         val = readl(ctl_addr);
>         val |= PWR_ISO_BIT;
> @@ -422,6 +435,48 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>         return ret;
>  }
>
> +static int init_subsys_clks(struct platform_device *pdev,
> +               const char *prefix, struct clk **clk)
> +{
> +       struct device_node *node = pdev->dev.of_node;
> +       u32 prefix_len, sub_clk_cnt = 0;
> +       struct property *prop;
> +       const char *clk_name;
> +
> +       if (!node) {
> +               dev_err(&pdev->dev, "Cannot find scpsys node: %ld\n",
> +                       PTR_ERR(node));
> +               return PTR_ERR(node);
> +       }
> +
> +       prefix_len = strlen(prefix);
> +
> +       of_property_for_each_string(node, "clock-names", prop, clk_name) {
> +               if (!strncmp(clk_name, prefix, prefix_len) &&
> +                               (clk_name[prefix_len] == '-')) {
> +                       if (sub_clk_cnt >= MAX_SUBSYS_CLKS) {
> +                               dev_err(&pdev->dev,
> +                                       "subsys clk out of range %d\n",
> +                                       sub_clk_cnt);
> +                               return -ENOMEM;
> +                       }
> +
> +                       clk[sub_clk_cnt] = devm_clk_get(&pdev->dev,
> +                                               clk_name);
> +
> +                       if (IS_ERR(clk[sub_clk_cnt])) {
> +                               dev_err(&pdev->dev,
> +                                       "Subsys clk get fail %ld\n",
> +                                       PTR_ERR(clk[sub_clk_cnt]));
> +                               return PTR_ERR(clk[sub_clk_cnt]);
> +                       }
> +                       sub_clk_cnt++;
> +               }
> +       }
> +
> +       return sub_clk_cnt;
> +}
> +
>  static void init_clks(struct platform_device *pdev, struct clk **clk)
>  {
>         int i;
> @@ -509,6 +564,7 @@ static struct scp *init_scp(struct platform_device *pdev,
>                 struct scp_domain *scpd = &scp->domains[i];
>                 struct generic_pm_domain *genpd = &scpd->genpd;
>                 const struct scp_domain_data *data = &scp_domain_data[i];
> +               int clk_cnt;
>
>                 pd_data->domains[i] = genpd;
>                 scpd->scp = scp;
> @@ -537,6 +593,18 @@ static struct scp *init_scp(struct platform_device *pdev,
>                                                 data->basic_clk_id[j]);
>                 }
>
> +               if (data->subsys_clk_prefix) {
> +                       clk_cnt = init_subsys_clks(pdev,
> +                                       data->subsys_clk_prefix,
> +                                       scpd->subsys_clk);
> +                       if (clk_cnt < 0) {
> +                               dev_err(&pdev->dev,
> +                                       "%s: subsys clk unavailable\n",
> +                                       data->name);
> +                               return ERR_PTR(clk_cnt);
> +                       }
> +               }
> +
>                 genpd->name = data->name;
>                 genpd->power_off = scpsys_power_off;
>                 genpd->power_on = scpsys_power_on;
> --
> 1.8.1.1.dirty
