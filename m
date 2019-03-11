Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEE9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51692147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nmrXrFEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfCKV4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:56:43 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36600 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfCKV4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:56:43 -0400
Received: by mail-oi1-f194.google.com with SMTP id t206so419166oib.3;
        Mon, 11 Mar 2019 14:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J0SY9H+O5ksKh1g2euAqzMNvIQqAp2NPRH3/hUfSXSI=;
        b=nmrXrFECfAZa+kQV7ME+dHSTTCSJJHBIKRmpDB2RUkIv6fFcoyGyNkW2LwfiuFY5mf
         3k77Jpi0cf124K1FqmNQ0WDRSArqoHTEPMk1bfKar+EnVMx63uk56JXq2IcFD16XGBX3
         v6Ea0yqEW/WaUc6H4a2vfi8fZeHZXDfLIQM82+sHD7cTOOM1w5H/FNhaU8Uh0fnJGXBW
         Jn8VTNJRleKyUjAdm05Fy4as7Div2flRXyJsQHkVfGStWfMhsBpFfdCStB+o3lH2wu9J
         pGv9sMAp3W9NJxfFk8D+FqCX48s62SfACSAdWN1Ik7CK2xCSl8IxoZoc0i6QaQQ+ko/B
         U36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J0SY9H+O5ksKh1g2euAqzMNvIQqAp2NPRH3/hUfSXSI=;
        b=fAsuvDDdAwi0WwI1kmMOJM1GgvlprVYoCYQeLa93XgF4/2osvrlGngXJSS8L8+H4s9
         CVDXoH4U5bEQ2YizI/wC5aWpiDtHWTqogeQm7ScfDyehXNMFurtru9mdLdelKdRHuamc
         4Ug7XcPxjZpadxVvJkfR6N5hivtBSddpWjAvpmAHpMFMvlWexSpYCeiOVa8TwvKZNThh
         0rnItIjFtlorrfNN0KOwVykH76ICdVIhrKERetwkEjvq7Hl/PqvpXUN+agTL+dPccNyn
         G6hCCLISRMhxxXOd5ypu7ZZ8GLbpS4sib97t2mUDTjqH/ekXd0AMeHKpec6GtBZDJmX2
         OAQQ==
X-Gm-Message-State: APjAAAWLRLcx0gV8N/s1wwOb453C3Ln+f9HCN3ylpXy5QVY8N8V1M3wq
        9XgOEr6B9YJUIqQesGE97oeACNBzVZNnNzB7TmcXND89
X-Google-Smtp-Source: APXvYqyWTN1xngTAbvSsQbgPComY8HN376Jpmgcm2ToVxD21XHUQFW7eR3EKrIUTMaG734oMsVyd7kJ/LXEd1MAqeJA=
X-Received: by 2002:aca:c286:: with SMTP id s128mr263743oif.39.1552341401702;
 Mon, 11 Mar 2019 14:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190304103846.2060-1-narmstrong@baylibre.com> <20190304103846.2060-9-narmstrong@baylibre.com>
In-Reply-To: <20190304103846.2060-9-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 11 Mar 2019 22:56:30 +0100
Message-ID: <CAFBinCAWEEKdsG2ZGCsFd1XyTUerAJpxJFEGGF-6j3UmpOmc=Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] usb: dwc3: Add Amlogic G12A DWC3 glue
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Mar 4, 2019 at 11:41 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> +static void dwc3_meson_g12a_usb_init_mode(struct dwc3_meson_g12a *priv)
> +{
> +       if (priv->otg_phy_mode == PHY_MODE_USB_DEVICE) {
> +               regmap_update_bits(priv->regmap, USB_R0,
> +                               USB_R0_U2D_ACT, USB_R0_U2D_ACT);
> +               regmap_update_bits(priv->regmap, USB_R0,
> +                               USB_R0_U2D_SS_SCALEDOWN_MODE_MASK, 0);
> +               regmap_update_bits(priv->regmap, USB_R4,
> +                               USB_R4_P21_SLEEP_M0, USB_R4_P21_SLEEP_M0);
> +       } else {
> +               regmap_update_bits(priv->regmap, USB_R0,
> +                               USB_R0_U2D_ACT, 0);
> +               regmap_update_bits(priv->regmap, USB_R4,
> +                               USB_R4_P21_SLEEP_M0, 0);
> +       }
> +}
I was already confused by the name of this function in v1.
do you think "dwc3_meson_g12a_usb_otg_apply_mode" is a suitable name?

[...]
> +static int dwc3_meson_g12a_otg_mode_set(struct dwc3_meson_g12a *priv,
> +                                       enum phy_mode mode)
> +{
> +       int ret;
> +
> +       if (!priv->phys[USB2_OTG_PHY])
> +               return -EINVAL;
> +
> +       if (mode == PHY_MODE_USB_HOST)
> +               dev_info(priv->dev, "switching to Host Mode\n");
> +       else
> +               dev_info(priv->dev, "switching to Device Mode\n");
> +
> +       if (priv->vbus) {
> +               if (mode == PHY_MODE_USB_DEVICE)
> +                       ret = regulator_disable(priv->vbus);
> +               else
> +                       ret = regulator_enable(priv->vbus);
do we need to track the regulator status (whether it's enabled or not)?
the regulator framework WARN()s if it detects "unbalanced disables for
<regulator>"
(I haven't tested this on one of my boards yet, so maybe it works
because the callers of dwc3_meson_g12a_otg_mode_set() protect against
this by not calling this function if the mode doesn't change)

> +               if (ret)
> +                       return ret;
> +               }
> +
> +               priv->otg_phy_mode = mode;
> +
> +               dwc3_meson_g12a_usb2_set_mode(priv, USB2_OTG_PHY, mode);
> +
> +               dwc3_meson_g12a_usb_init_mode(priv);
> +
> +               return phy_set_mode(priv->phys[USB2_OTG_PHY], mode);
> + }
this is the only place where phy_set_mode is called
I'm fine with keeping it but then it should be consistent at least for
all USB2 PHYs.
I suggest to either move the phy_set_mode call to
dwc3_meson_g12a_usb2_set_mode or to remove it.

[...]
> +static int dwc3_meson_g12a_role_set(struct device *dev, enum usb_role role)
> +{
> +       struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
> +       enum phy_mode mode;
> +
> +       if (role == USB_ROLE_NONE)
> +               return 0;
> +
> +       mode = role == USB_ROLE_HOST ? PHY_MODE_USB_HOST : PHY_MODE_USB_DEVICE;
(without surrounding parens I find the "role == USB_ROLE_HOST" part
hard to distinguish from the "mode =" operation. if more people think
this way then please speak up - otherwise it's probably just my
personal taste)

[...]
> +static struct device *dwc3_meson_g12_find_child(struct device *dev,
> +                                               const char *compatible)
> +{
> +       struct platform_device *pdev;
> +       struct device_node *np;
> +
> +       np = of_find_compatible_node(dev->of_node, NULL, compatible);
> +       if (!np)
> +               return NULL;
> +
> +       pdev = of_find_device_by_node(np);
maybe switch to of_get_compatible_child() here? This was done for the
MMC driver in c483a5cc9d09f4 ("mmc: meson-mx-sdio: fix OF child-node
lookup"), but I'm not sure if the problem described there also applies
to dwc3_meson_g12_find_child

[...]
> +static int dwc3_meson_g12a_probe(struct platform_device *pdev)
> +{
> +       struct dwc3_meson_g12a  *priv;
> +       struct device           *dev = &pdev->dev;
> +       struct device_node      *np = dev->of_node;
> +       void __iomem *base;
> +       struct resource *res;
> +       enum phy_mode otg_id;
> +       int ret, i;
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       priv->regmap = devm_regmap_init_mmio(dev, base,
> +                                            &phy_meson_g12a_usb3_regmap_conf);
> +       if (IS_ERR(priv->regmap))
> +               return PTR_ERR(priv->regmap);
> +
> +       priv->vbus = devm_regulator_get_optional(dev, "vbus");
> +       if (IS_ERR(priv->vbus)) {
> +               if (PTR_ERR(priv->vbus) == -EPROBE_DEFER)
> +                       return PTR_ERR(priv->vbus);
> +               priv->vbus = NULL;
> +       }
> +
> +       priv->clk = devm_clk_get(dev, NULL);
> +       if (IS_ERR(priv->clk))
> +               return PTR_ERR(priv->clk);
> +
> +       ret = clk_prepare_enable(priv->clk);
> +       if (ret)
> +               return ret;
> +
> +       platform_set_drvdata(pdev, priv);
> +       priv->dev = dev;
> +
> +       priv->reset = devm_reset_control_get(dev, NULL);
> +       if (IS_ERR(priv->reset)) {
> +               ret = PTR_ERR(priv->reset);
> +               dev_err(dev, "failed to get device reset, err=%d\n", ret);
> +               return ret;
> +       }
clk_prepare_enable is called a few lines above but this (and a few
more) error-paths don't call clk_disable_unprepare.
Jerome suggested in the dwmac-meson8b driver that I use something
like, which will even allow you to drop the clk_disable_unprepare call
from dwc3_meson_g12a_remove and catch all error cases in
dwc3_meson_g12a_probe at the same time:
  devm_add_action_or_reset(dev, (void(*)(void
*))clk_disable_unprepare, priv->clk);
(if you go with this then you also need to remove the
clk_disable_unprepare after of_platform_populate)

[...]
> +static int dwc3_meson_g12a_remove(struct platform_device *pdev)
> +{
> +       struct dwc3_meson_g12a *priv = platform_get_drvdata(pdev);
> +       struct device *dev = &pdev->dev;
> +       int i;
> +
> +       usb_role_switch_unregister(priv->role_switch);
> +
> +       of_platform_depopulate(dev);
> +
> +       for (i = 0 ; i < PHY_COUNT ; ++i) {
> +               phy_power_off(priv->phys[i]);
> +               phy_exit(priv->phys[i]);
> +               phy_put(priv->phys[i]);
> +       }
> +
> +       clk_disable_unprepare(priv->clk);
> +       clk_put(priv->clk);
priv->clk is obtained with devm_clk_get so the common clock framework
will call clk_put for us automatically

[...]
> +static int __maybe_unused dwc3_meson_g12a_suspend(struct device *dev)
> +{
> +       struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
> +       int i;
> +
> +       for (i = 0 ; i < PHY_COUNT ; ++i)
> +               if (priv->phys[i])
> +                       phy_exit(priv->phys[i]);
phy_init is NULL-safe, so you can drop the NULL-check above

> +
> +       reset_control_assert(priv->reset);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused dwc3_meson_g12a_resume(struct device *dev)
> +{
> +       struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
> +       int i, ret;
> +
> +       reset_control_deassert(priv->reset);
> +
> +       dwc3_meson_g12a_usb_init(priv);
> +
> +       /* Init PHYs */
> +       for (i = 0 ; i < PHY_COUNT ; ++i) {
> +               if (priv->phys[i]) {
> +                       ret = phy_init(priv->phys[i]);
phy_init is NULL-safe, so you can drop the NULL-check above


Regards
Martin
