Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F53C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1762120740
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GKlBMroY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfL0REr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:04:47 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42062 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfL0REq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:04:46 -0500
Received: by mail-ed1-f68.google.com with SMTP id e10so25797005edv.9;
        Fri, 27 Dec 2019 09:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BoVbc5pFxgDga02d7WpROu4QcXo0Jnx36QL7mAbHE+o=;
        b=GKlBMroYHKZ+NeE9hZTwNpzDD2un2MsXbWFiIqXLUAlw4zHJf04GITHmWpvNDseB8q
         Bqz59shO329cyZVFllXLlGDUGpRZYX76XIM7ABBWAWEPOeZL32U3z/idBD0dKFyhDWiQ
         oIcbi38+6nV4daU80bI/u+HYvi2+fCTk3D0hIiCeD6wauLvlZxum7/KLwq9Xx2tMR9Ld
         0oUIE7SNzoo8g+yibPu98/Ks5OOEhrRUQ1t4uBWXMiOq45e+PkJJnFlZXbOn/CPOeISi
         c8sDROdDLLtOZtVqSAzwODofVPqJfrD9YGnYQ01cLL5KTF4tjMFXDEsJQPiDqxUsgBT6
         LJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BoVbc5pFxgDga02d7WpROu4QcXo0Jnx36QL7mAbHE+o=;
        b=QKnUlslOe0gAKJJ6oCdUITlObQ/wnx/4vso3xSXH0Cm2pmQmBI9gWpOiikekPnF4ja
         wYD7H+jpBUHm7+1wv54wLCLaa+O5YO5XAirV81q6C1kwZBsVK8Dn48sjlSCrUriObO54
         YhX1yXh3qBE+RMuJgo2abRnlthgRMc6WPnJU9lC3qBLBWmQrXHvO0+mBHpQ+xEDkoHp7
         Sl3rRUuGx1EvbI4Hn9uRqLoOrSK2JRkAg9hCZA5Aj62J6URma6fiJa2FG0QcHdFy4tOC
         T2XcTdZ+UoNFpuGvTruRTBUzdPVPh1LWeOCpH6iKtACGQFrLHI/Ew1Dskyq/crY7AI5F
         7wzw==
X-Gm-Message-State: APjAAAX2cFf7KlJamJVAEJxir7WOExXHiVuGRN9nhfknvFUC8cTU7J9p
        rRhNirZBxqv+QaO3VeCc76JHC5c7ZZd30wZL7Y4=
X-Google-Smtp-Source: APXvYqxb40zU5q6fp02+uSgYoDnGWDNjt9ky8oUSBuCmkdvIsTYbQe34JEzsFayd1/qdz0Dqt0rB7GiW2uX4tkdpQik=
X-Received: by 2002:a17:906:cc8b:: with SMTP id oq11mr56006300ejb.193.1577466284880;
 Fri, 27 Dec 2019 09:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20191227094606.143637-1-jian.hu@amlogic.com> <20191227094606.143637-4-jian.hu@amlogic.com>
In-Reply-To: <20191227094606.143637-4-jian.hu@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 27 Dec 2019 18:04:33 +0100
Message-ID: <CAFBinCB2XF1unfEGbApuoXR3ZBRMwgc4EuqSjgKWKm_2G16S5g@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] clk: meson: a1: add support for Amlogic A1 PLL
 clock driver
To:     Jian Hu <jian.hu@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jian,

On Fri, Dec 27, 2019 at 10:46 AM Jian Hu <jian.hu@amlogic.com> wrote:
[...]
> +               .parent_data = &(const struct clk_parent_data){
> +                       .fw_name = "xtal_fixpll",
> +               },
in the Meson8b and G12A (I assume it's the same on GXBB, I didn't
check it) we have a space between " clk_parent_data)" and "{"
this applies to at least one more occurrence below

[...]
> +               /*
> +                * This clock is used by APB bus which setted in Romcode
nit-pick: I'm not sure about the grammar here: setted -> "is set"?
and to make sure I understand this correctly: do you mean the "boot
ROM" with "Romcode"?

[...]
> +static int meson_a1_pll_probe(struct platform_device *pdev)
> +{
> +       const struct meson_eeclkc_data *data;
what do you need this "data" variable for?

> +       struct device *dev = &pdev->dev;
> +       struct resource *res;
> +       void __iomem *base;
> +       struct regmap *map;
> +       int ret, i;
> +
> +       data = of_device_get_match_data(dev);
> +       if (!data)
> +               return -EINVAL;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +       base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       map = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
> +       if (IS_ERR(map))
> +              return PTR_ERR(map);
> +
> +       /* Populate regmap for the regmap backed clocks */
> +       for (i = 0; i < data->regmap_clk_num; i++)
> +               data->regmap_clks[i]->map = map;
why can't we use a1_pll_regmaps directly here?

> +
> +       for (i = 0; i < data->hw_onecell_data->num; i++) {
> +               /* array might be sparse */
> +               if (!data->hw_onecell_data->hws[i])
> +                       continue;
> +
> +               ret = devm_clk_hw_register(dev, data->hw_onecell_data->hws[i]);
and why can't we use a1_pll_hw_onecell_data directly here?

[...]
> +static const struct meson_eeclkc_data a1_pll_data = {
> +               .regmap_clks = a1_pll_regmaps,
> +               .regmap_clk_num = ARRAY_SIZE(a1_pll_regmaps),
> +               .hw_onecell_data = &a1_pll_hw_onecell_data,
> +};
if _probe would access these directly then you can drop meson_eeclkc_data
that is a good thing in my opinion because I was confused by the
"eeclk" since the patch description says that there's no EE or AO
domain on the A1 SoCs


Martin
