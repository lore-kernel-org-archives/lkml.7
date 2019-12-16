Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D363EC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 07:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47B820700
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 07:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F7lQExjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfLPHmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 02:42:46 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:38472 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfLPHmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 02:42:46 -0500
Received: by mail-qv1-f65.google.com with SMTP id t6so1924480qvs.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 23:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=keYwZ/CIw81Q8Cz3kuUmGzB6KcfZrFvM2y9zPZnUX3A=;
        b=F7lQExjymC0jAXQuYrfQWnEeV+li1jrHiCWUC3toxdLUvy7gryXioe76XE9KNl0EL5
         1p+DfYuFrjAwzIxXIHQQo7Di+Ta4vk88rzX/l6w7+TJkxdwoy3hPi1wNgPGTae6FZ67N
         sual9RcCfTdOqz+QoiZXw+L41K7jncfVPB3Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=keYwZ/CIw81Q8Cz3kuUmGzB6KcfZrFvM2y9zPZnUX3A=;
        b=cBoqkda9s/JZ8uR3d4khKxwJnD1opAvTRC1uJy/knzAkVkPEbNmwsZaky0oQHNJCwc
         ey9LVqD4XkUL8tu2uh2lvwb1Zs9G/tCYiLFYVoRcht3vB8XwkDS/8LrOjJ0bLdOca7Bd
         57q3xu/zF9A2o+bcdM0TsArRSmlX/g70g8RTK/NAddToLwffo4jagzHto2KS6xuNY1Hy
         yM0Pu8pECtLnWhBINmCBuz9HqfVk3e5zS3s1lyQY5gV/70O4044W8yMI1lQRWffG22uu
         pIgzldEnq/eYFYD0Dd709eaUfBbAyY9SqnS+kfbPE7fdS/VhPpKeNCg0Wzxyh+IqBA6J
         QLwA==
X-Gm-Message-State: APjAAAXkjZ+fxkklgWp3r4BhIrHyHokyfB3EAEZjtJq12wkRBBBHUjhk
        T3jeTOkyqZsI3CYtpTadflUUi1CAdTdYrbzoMbF85g==
X-Google-Smtp-Source: APXvYqzAVzG3X2eMMGzUs9utrlUgztg1oZUTm5FQxljAgX7mY47YjrCiIGyz7hJKN4AC71cnKcaj/IqsHmNdC8dIfmk=
X-Received: by 2002:a0c:b5cd:: with SMTP id o13mr25785784qvf.47.1576482165124;
 Sun, 15 Dec 2019 23:42:45 -0800 (PST)
MIME-Version: 1.0
References: <1575960413-6900-1-git-send-email-weiyi.lu@mediatek.com> <1575960413-6900-8-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1575960413-6900-8-git-send-email-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 16 Dec 2019 15:42:34 +0800
Message-ID: <CANMq1KBC=aZoXtcvEj92v1z6uUKWxFsMKHUQ++x5C8fFPWheRw@mail.gmail.com>
Subject: Re: [PATCH v9 7/9] soc: mediatek: Add MT8183 scpsys support
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

Just a minor nit, but I can't really comment on the exact register
addresses (what I could find in register table made sense).

On Tue, Dec 10, 2019 at 2:47 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> Add scpsys driver for MT8183
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>

Otherwise:

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 226 ++++++++++++++++++++++++++++++++++++++
> [snip]
> @@ -1197,6 +1409,17 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>         .bus_prot_reg_update = true,
>  };
>
> +static const struct scp_soc_data mt8183_data = {
> +       .domains = scp_domain_data_mt8183,
> +       .num_domains = ARRAY_SIZE(scp_domain_data_mt8183),
> +       .subdomains = scp_subdomain_mt8183,
> +       .num_subdomains = ARRAY_SIZE(scp_subdomain_mt8183),
> +       .regs = {
> +               .pwr_sta_offs = 0x0180,
> +               .pwr_sta2nd_offs = 0x0184

Add a comma at the end.

> +       }
> +};
> +
>  /*
>   * scpsys driver init
>   */
> @@ -1221,6 +1444,9 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .compatible = "mediatek,mt8173-scpsys",
>                 .data = &mt8173_data,
>         }, {
> +               .compatible = "mediatek,mt8183-scpsys",
> +               .data = &mt8183_data,
> +       }, {
>                 /* sentinel */
>         }
>  };
> --
> 1.8.1.1.dirty
