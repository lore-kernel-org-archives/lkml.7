Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA07FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83F6218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SxayQvWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfCUGCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 02:02:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36223 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfCUGCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 02:02:30 -0400
Received: by mail-qt1-f193.google.com with SMTP id y36so5443898qtb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 23:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3km5VzrkKtwK+4kIEccjRQTP8ZA+SvIT9ompJqty5D0=;
        b=SxayQvWmsF6bfxh81kvysGuQB1NY3I/Z+iJdzp++YBk8JD71Cp5sQNj5bHgj6CGbIW
         v3pM+eMfe8qP1dbB+U55u1f2kBhMGp0gsi0e7W4fuZqGqKC+fKIAQV/y79kExH2yI2Iw
         NslkybhulxCHOfab4tBoTQiEwE5tGLnBTjIKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3km5VzrkKtwK+4kIEccjRQTP8ZA+SvIT9ompJqty5D0=;
        b=hsnib7T8S7rvu7JjHDt8S/rF//s2ixiGrgwtXy1hdw/B/50xBGzwPktMaa/kmbCb+4
         nTrnKlmgnMJ5W0Pj3RuPkvozHPJO8e2Oo1ia3hoUb8m3/BI8EGQ4iM0++NNXRp7MpbAE
         DB1xMAwjHTs32jV/iCyb6jUCWedpawsqMNKVxXNwHEv73jMsZuXKNqGMprK/+R7GMsEI
         ICBBf6KE2wUANO8KWBuSETNJgd+o0RFGMO9WEi1MmtshYt9d5vq/4ESWRW8eqxUjpwKQ
         dG1XmyEiy/c9WCWMRRTMGNrKckxVV+rdqKowfpr+pY7zYZEt7s1x7dKkIUPfunVmQlQb
         GFKg==
X-Gm-Message-State: APjAAAVKqOKEOJChRsXWgqo6eJg+552KQxCFAKazyXn1fIN5HNtI0GLR
        uTA0uYqLvHt6stwZI10bDPZIhvx5bSn5Us4Sm1x1uw==
X-Google-Smtp-Source: APXvYqzRTqHx0ai3tiaMbxmTEkhj3DJAIicQcXTzAZ38aVKtiEji5tNr/i07g9zXYxtC2tvnG67hFqJujMebVkaHydo=
X-Received: by 2002:ac8:f3c:: with SMTP id e57mr1508707qtk.75.1553148149669;
 Wed, 20 Mar 2019 23:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190319080140.24055-1-weiyi.lu@mediatek.com> <20190319080140.24055-10-weiyi.lu@mediatek.com>
In-Reply-To: <20190319080140.24055-10-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 21 Mar 2019 14:02:18 +0800
Message-ID: <CANMq1KDf6aCK4+VX070f1pB6knPT5M0kxbW_RJ0K7PtAvKWkLQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] soc: mediatek: Add basic_clk_name to scp_power_data
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
> Try to stop extending the clk_id or clk_names if there are
> more and more new BASIC clocks. To get its own clocks by the
> basic_clk_name of each power domain.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 6bf846cb1893..c6360de4e41e 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -118,6 +118,8 @@ static const char * const clk_names[] = {
>   * @bus_prot_mask: The mask for single step bus protection.
>   * @clk_id: The basic clock needs to be enabled before enabling certain
>   *          power domains.
> + * @basic_clk_name: provide the same purpose with field "clk_id"
> + *                  by declaring basic clock prefix name rather than clk_id.
>   * @caps: The flag for active wake-up action.
>   */
>  struct scp_domain_data {
> @@ -128,6 +130,7 @@ struct scp_domain_data {
>         u32 sram_pdn_ack_bits;
>         u32 bus_prot_mask;
>         enum clk_id clk_id[MAX_CLKS];
> +       const char *basic_clk_name[MAX_CLKS];

Either call them basic_clk_id/basic_clk_name, or clk_id/clk_name.

>         u8 caps;
>  };
>
> @@ -499,16 +502,24 @@ static struct scp *init_scp(struct platform_device *pdev,
>
>                 scpd->data = data;
>
> -               for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
> -                       struct clk *c = clk[data->clk_id[j]];
> +               if (data->clk_id[0]) {

Since it's either clk_id or basic_clk_name, I wonder if it'd be good
to add a WARN_ON here, e.g.

WARN_ON(data->basic_clk_name[0]);

> +                       for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
> +                               struct clk *c = clk[data->clk_id[j]];
>
> -                       if (IS_ERR(c)) {
> -                               dev_err(&pdev->dev, "%s: clk unavailable\n",
> -                                       data->name);
> -                               return ERR_CAST(c);
> -                       }
> +                               if (IS_ERR(c)) {
> +                                       dev_err(&pdev->dev,
> +                                               "%s: clk unavailable\n",
> +                                               data->name);
> +                                       return ERR_CAST(c);
> +                               }
>
> -                       scpd->clk[j] = c;
> +                               scpd->clk[j] = c;
> +                       }
> +               } else if (data->basic_clk_name[0]) {
> +                       for (j = 0; j < MAX_CLKS &&
> +                                       data->basic_clk_name[j]; j++)
> +                               scpd->clk[j] = devm_clk_get(&pdev->dev,
> +                                               data->basic_clk_name[j]);
>                 }
>
>                 genpd->name = data->name;
> --
> 2.18.0
>
