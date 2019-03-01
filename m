Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3F2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7008720818
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aGPYReni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389261AbfCAQyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:54:14 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33245 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389088AbfCAQyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:54:13 -0500
Received: by mail-ua1-f67.google.com with SMTP id q17so23109681uam.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 08:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jvpAI1GcXq8PLJ0rfrk/9lBgootey+psldD0iwOt4Pw=;
        b=aGPYReniyqoW65SIjJD4XKrK4Z15t4pWNomQ/U7Ker0W4fnb5/w/HvjRlbRbscmPtv
         Rd3eTIKXi7c5jhetN3GIdpwHmqZFAwWICObJW2hku+vRh7aRE2sQHkJ21DTHxKTCMg+K
         yV13dhTwaOPK3jQZNyoON0D4lhYoFWmI8sh9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvpAI1GcXq8PLJ0rfrk/9lBgootey+psldD0iwOt4Pw=;
        b=MLO784uZBM7m8Jzws/F3G9zAX2XWZ1jp95q3mz9G3ZiRDfm6iW5vi7xUJY0GCe5PX+
         Z0HJnHHrOnTN/SftJIM+kytdnNFHaGpp7JPlpZb3Hxq7+h+IBuPAm3b+67c41jkGOMen
         2GLtqa53CGWluxSIuR+G2CgfwEyYnCiq9D5Ja3i8EAjAMvqsYPVGv79Yk4eJFiOlenF8
         gaErZ0TnNVEb4orZop8Rhu41vJUnFbFrKhHNckJknis8qYz07c+w6VRBeNNQTpeEKlud
         IEaCtE/Czk8v8A8/HXXmN2yjMbhOosYiYblPILUJ9R7RNOSuX0ho4GzAtF4o1r8n+BkN
         inMw==
X-Gm-Message-State: APjAAAXXICprOUPQXX2tEFkZ5PExBEqg+OXPN57WIzv/CexKbiHkq+bA
        gDsffA6k34cd8+FYNM+sT125aTz8Kv0=
X-Google-Smtp-Source: APXvYqxMGtLsXfWy/Edu48CTfcU3OCq8FYjcP60gRpDNS5uvjqGmvQSbM9WZTYpY/b5ZuEbH8cWiKw==
X-Received: by 2002:a67:7f07:: with SMTP id a7mr2997131vsd.196.1551459251878;
        Fri, 01 Mar 2019 08:54:11 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id l14sm13951468vke.54.2019.03.01.08.54.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 08:54:11 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id e15so21935944uam.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 08:54:11 -0800 (PST)
X-Received: by 2002:a67:dc92:: with SMTP id g18mr3158769vsk.144.1551458948569;
 Fri, 01 Mar 2019 08:49:08 -0800 (PST)
MIME-Version: 1.0
References: <20190301153348.29870-1-christoph.muellner@theobroma-systems.com>
In-Reply-To: <20190301153348.29870-1-christoph.muellner@theobroma-systems.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 Mar 2019 08:48:56 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UUuQYwh2DMgB5FLuiE1BwbTMTuc9rAte1J5L_JP5qk1Q@mail.gmail.com>
Message-ID: <CAD=FV=UUuQYwh2DMgB5FLuiE1BwbTMTuc9rAte1J5L_JP5qk1Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] phy: rockchip-emmc: Allow to set drive impedance via DTS.
To:     Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Tony Xie <tony.xie@rock-chips.com>,
        Randy Li <ayaka@soulik.info>,
        Vicente Bergas <vicencb@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 1, 2019 at 7:37 AM Christoph Muellner
<christoph.muellner@theobroma-systems.com> wrote:
>
> The rockchip-emmc PHY can be configured with different
> drive impedance values. Currenlty a value of 50 Ohm is
> hard coded into the driver.
>
> This patch introduces the DTS property 'drive-impedance-ohm'
> for the rockchip-emmc phy node, which uses the value from the DTS
> to setup the drive impedance accordingly.
>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-emmc.c | 38 ++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
> index 19bf84f0bc67..5413fa73dd45 100644
> --- a/drivers/phy/rockchip/phy-rockchip-emmc.c
> +++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
> @@ -87,6 +87,7 @@ struct rockchip_emmc_phy {
>         unsigned int    reg_offset;
>         struct regmap   *reg_base;
>         struct clk      *emmcclk;
> +       unsigned int drive_impedance;
>  };
>
>  static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
> @@ -281,10 +282,10 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
>  {
>         struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
>
> -       /* Drive impedance: 50 Ohm */
> +       /* Drive impedance: from DTS */
>         regmap_write(rk_phy->reg_base,
>                      rk_phy->reg_offset + GRF_EMMCPHY_CON6,
> -                    HIWORD_UPDATE(PHYCTRL_DR_50OHM,
> +                    HIWORD_UPDATE(rk_phy->drive_impedance,
>                                    PHYCTRL_DR_MASK,
>                                    PHYCTRL_DR_SHIFT));
>
> @@ -314,6 +315,28 @@ static const struct phy_ops ops = {
>         .owner          = THIS_MODULE,
>  };
>
> +static u32 convert_drive_impedance_ohm(struct platform_device *pdev, u32 dr_ohm)
> +{
> +       switch (dr_ohm) {
> +       case 100:
> +               return PHYCTRL_DR_100OHM;
> +       case 66:
> +               return PHYCTRL_DR_66OHM;
> +       case 50:
> +               return PHYCTRL_DR_50OHM;
> +       case 40:
> +               return PHYCTRL_DR_40OHM;
> +       case 33:
> +               return PHYCTRL_DR_33OHM;
> +       }
> +
> +       dev_warn(&pdev->dev,
> +               "Invalid value %u for drive-impedance-ohm. "
> +               "Falling back to 50 Ohm.\n",
> +               dr_ohm);
> +       return PHYCTRL_DR_50OHM;
> +}
> +
>  static int rockchip_emmc_phy_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -322,6 +345,7 @@ static int rockchip_emmc_phy_probe(struct platform_device *pdev)
>         struct phy_provider *phy_provider;
>         struct regmap *grf;
>         unsigned int reg_offset;
> +       u32 val;
>
>         if (!dev->parent || !dev->parent->of_node)
>                 return -ENODEV;
> @@ -345,6 +369,16 @@ static int rockchip_emmc_phy_probe(struct platform_device *pdev)
>         rk_phy->reg_offset = reg_offset;
>         rk_phy->reg_base = grf;
>
> +       if (of_property_read_u32(dev->of_node, "drive-impedance-ohm", &val)) {
> +               dev_info(dev,
> +                       "Missing drive-impedance-ohm property in node %s "
> +                       "Falling back to 50 Ohm.\n",
> +                       dev->of_node->name);

This is awfully noisy for something that pretty much all existing
boards will run.  debug level instead of info level?  Also:

* Don't split strings
across lines

* There's a magic % thing to get the name of an OF node.  Use that.


> +               rk_phy->drive_impedance = PHYCTRL_DR_50OHM;
> +       } else {
> +               rk_phy->drive_impedance = convert_drive_impedance_ohm(pdev, val);
> +       }

It's been a long time since I looked at this, but I could have sworn
that it was more complicated than that.  Specifically I though you
were supposed to query the eMMC card for what it supported and then
resolve that with what the host could support.

Assuming that this is supposed to be queried from the card (which is
how I remember it) then you definitely don't want it in the device
tree since you want to be able to stuff various different eMMC parts
and we should be able to figure out the impedance at runtime.


NOTE: IIRC the old value of 50 ohms is required to be supported by all
hosts and cards and is specified to be the default.


I do see at least the summary of what I thought of this before at
<https://patchwork.kernel.org/patch/9086541/>


(Sorry if the above is wrong and feel free to correct me--I don't have
time at the moment to do all the full research but hopefully you can
dig more based on my pointers.  Feel free to call me on my BS)


-Doug
