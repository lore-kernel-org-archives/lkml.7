Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9333FC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 07:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2BD20700
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 07:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k8Jz8WhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLPHBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 02:01:44 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33746 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfLPHBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 02:01:43 -0500
Received: by mail-qk1-f196.google.com with SMTP id d71so2552021qkc.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 23:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mNxq9QEx/Y0AFfmFBHfjO9qh1l6j5wyPEAuFcOtgvko=;
        b=k8Jz8WhY1cxn9bFKXeAi5vzaTBfRitVt26Dv8N8sNlYJP+LrdDlQqaBI0DhBwVSp3j
         jqUvtkluKNvckqYdwX0zAwgdTSijpgtwIQkpJR0wV31kbIiO6lN/sqeFNJxRolylHi9z
         mkNpLYAbfL38r2dXtuppefORp2tXgISUEAbu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mNxq9QEx/Y0AFfmFBHfjO9qh1l6j5wyPEAuFcOtgvko=;
        b=gWduONo2NVATGsHelDZ+R49TFzQUdlfrbl7lE5Lylq9VRQEREbXsQSQb7poS6m7BM2
         M/lrp4Kq/c3JYWLgKQPtlLNth/uvjaJEXT1s/JFiSE+ol5hxb3pVra86+osRMrsE+0Iv
         fyCdm5nXmKxoBj6oj9gAnAT9HoD6fUWjrdpQm7kc95XH7n63C0h0Pr6a5ca3ko5/4bnf
         uct0wDepeg8yIdaOBxCNDJW3HQydFirIpvT/fL5d6V0fcIIKFCUY/9JU/mtN5ONJRP8f
         woHeaxLVvIU/tHDKjvfdFVL5i8eML507iNqPFUEMEJ7cDTCQ4Qx0PY6m4mMNXAvYN7Kr
         XTVw==
X-Gm-Message-State: APjAAAU0NNNZnK8YHpkL8LD6QjRyQDhPTpG6pyWGknPilPlF2QQPnOEf
        rUWEzWw028QSgePqpnMX5I1HkI0MX1eoII3a7qYGiA==
X-Google-Smtp-Source: APXvYqzVdceLqcG+3fAzc6E6Q5G9XbMKp+zuFLQXrq1VY+BvVu+NpyPVVDbAVBh4Vyd+Tbmbw9ZSQBEix3ZXm6HqNCo=
X-Received: by 2002:ae9:f003:: with SMTP id l3mr25598095qkg.457.1576479702489;
 Sun, 15 Dec 2019 23:01:42 -0800 (PST)
MIME-Version: 1.0
References: <1575960413-6900-1-git-send-email-weiyi.lu@mediatek.com> <1575960413-6900-4-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1575960413-6900-4-git-send-email-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 16 Dec 2019 15:01:31 +0800
Message-ID: <CANMq1KC4Qz8yKNTqfjYb335RCY8t5pdRa09Bvroo_BNXv19hWQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/9] soc: mediatek: Add basic_clk_id to scp_power_data
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
> Try to stop extending the clk_id or clk_names if there are
> more and more new BASIC clocks. To get its own clocks by the
> basic_clk_id of each power domain.

Looking at this a bit more, I'm not sure why we make this an option...

The easiest way to make this consistent with non-MT8183 scpsys drivers
is to add your missing clocks to "enum clk_id" and clk_names, but I
understand it's not desired (number of clocks would blow up).

Can we, instead, convert all existing scpsys drivers to use "char *"
clock names instead?
I made an attempt here and it seems simple enough:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1969103

>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index f669d37..915d635 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -117,6 +117,8 @@ enum clk_id {
>   * @sram_pdn_ack_bits: The mask for sram power control acked bits.
>   * @bus_prot_mask: The mask for single step bus protection.
>   * @clk_id: The basic clocks required by this power domain.
> + * @basic_clk_id: provide the same purpose with field "clk_id"
> + *                by declaring basic clock prefix name rather than clk_id.

Actually, I prefer the name clk_name, not sure why I pushed you in
that direction...

>   * @caps: The flag for active wake-up action.
>   */
>  struct scp_domain_data {
> @@ -127,6 +129,7 @@ struct scp_domain_data {
>         u32 sram_pdn_ack_bits;
>         u32 bus_prot_mask;
>         enum clk_id clk_id[MAX_CLKS];
> +       const char *basic_clk_id[MAX_CLKS];
>         u8 caps;
>  };
>
> @@ -493,16 +496,26 @@ static struct scp *init_scp(struct platform_device *pdev,
>
>                 scpd->data = data;
>
> -               for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
> -                       struct clk *c = clk[data->clk_id[j]];
> +               if (data->clk_id[0]) {
> +                       WARN_ON(data->basic_clk_id[0]);
>
> -                       if (IS_ERR(c)) {
> -                               dev_err(&pdev->dev, "%s: clk unavailable\n",
> -                                       data->name);
> -                               return ERR_CAST(c);
> -                       }
> +                       for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
> +                               struct clk *c = clk[data->clk_id[j]];
> +
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
> +               } else if (data->basic_clk_id[0]) {
> +                       for (j = 0; j < MAX_CLKS &&
> +                                       data->basic_clk_id[j]; j++)
> +                               scpd->clk[j] = devm_clk_get(&pdev->dev,
> +                                               data->basic_clk_id[j]);
>                 }
>
>                 genpd->name = data->name;
> --
> 1.8.1.1.dirty
