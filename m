Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CD7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CA120818
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389183AbfCAQvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:51:17 -0500
Received: from foss.arm.com ([217.140.101.70]:38936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbfCAQvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:51:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D39680D;
        Fri,  1 Mar 2019 08:51:16 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DAFA3F575;
        Fri,  1 Mar 2019 08:51:12 -0800 (PST)
Subject: Re: [PATCH 1/3] phy: rockchip-emmc: Allow to set drive impedance via
 DTS.
To:     Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        shawn.lin@rock-chips.com
Cc:     devicetree@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Randy Li <ayaka@soulik.info>,
        Douglas Anderson <dianders@chromium.org>,
        Vicente Bergas <vicencb@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-rockchip@lists.infradead.org,
        Tony Xie <tony.xie@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190301153348.29870-1-christoph.muellner@theobroma-systems.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1347b956-5682-1f86-b38c-7768bb9ffd23@arm.com>
Date:   Fri, 1 Mar 2019 16:51:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190301153348.29870-1-christoph.muellner@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2019 15:33, Christoph Muellner wrote:
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
>   drivers/phy/rockchip/phy-rockchip-emmc.c | 38 ++++++++++++++++++++++++++++++--
>   1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
> index 19bf84f0bc67..5413fa73dd45 100644
> --- a/drivers/phy/rockchip/phy-rockchip-emmc.c
> +++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
> @@ -87,6 +87,7 @@ struct rockchip_emmc_phy {
>   	unsigned int	reg_offset;
>   	struct regmap	*reg_base;
>   	struct clk	*emmcclk;
> +	unsigned int drive_impedance;
>   };
>   
>   static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
> @@ -281,10 +282,10 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
>   {
>   	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
>   
> -	/* Drive impedance: 50 Ohm */
> +	/* Drive impedance: from DTS */
>   	regmap_write(rk_phy->reg_base,
>   		     rk_phy->reg_offset + GRF_EMMCPHY_CON6,
> -		     HIWORD_UPDATE(PHYCTRL_DR_50OHM,
> +		     HIWORD_UPDATE(rk_phy->drive_impedance,
>   				   PHYCTRL_DR_MASK,
>   				   PHYCTRL_DR_SHIFT));
>   
> @@ -314,6 +315,28 @@ static const struct phy_ops ops = {
>   	.owner		= THIS_MODULE,
>   };
>   
> +static u32 convert_drive_impedance_ohm(struct platform_device *pdev, u32 dr_ohm)
> +{
> +	switch (dr_ohm) {
> +	case 100:
> +		return PHYCTRL_DR_100OHM;
> +	case 66:
> +		return PHYCTRL_DR_66OHM;
> +	case 50:
> +		return PHYCTRL_DR_50OHM;
> +	case 40:
> +		return PHYCTRL_DR_40OHM;
> +	case 33:
> +		return PHYCTRL_DR_33OHM;
> +	}
> +
> +	dev_warn(&pdev->dev,
> +		"Invalid value %u for drive-impedance-ohm. "
> +		"Falling back to 50 Ohm.\n",
> +		dr_ohm);
> +	return PHYCTRL_DR_50OHM;
> +}
> +
>   static int rockchip_emmc_phy_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -322,6 +345,7 @@ static int rockchip_emmc_phy_probe(struct platform_device *pdev)
>   	struct phy_provider *phy_provider;
>   	struct regmap *grf;
>   	unsigned int reg_offset;
> +	u32 val;
>   
>   	if (!dev->parent || !dev->parent->of_node)
>   		return -ENODEV;
> @@ -345,6 +369,16 @@ static int rockchip_emmc_phy_probe(struct platform_device *pdev)
>   	rk_phy->reg_offset = reg_offset;
>   	rk_phy->reg_base = grf;
>   
> +	if (of_property_read_u32(dev->of_node, "drive-impedance-ohm", &val)) {
> +		dev_info(dev,
> +			"Missing drive-impedance-ohm property in node %s "
> +			"Falling back to 50 Ohm.\n",
> +			dev->of_node->name);

I think we're aiming to use %pOF for node names now, but here it looks 
redundant anyway - dev_info() will already show the device name, which 
for an of_platform device is the same thing.

> +		rk_phy->drive_impedance = PHYCTRL_DR_50OHM;
> +	} else {
> +		rk_phy->drive_impedance = convert_drive_impedance_ohm(pdev, val);
> +	}

FWIW, if you initialise val to the default (i.e. 50) then you could get 
rid of the "else" case and just do the conversion unconditionally. 
That's a fairly common idiom for reading optional properties.

Robin.

> +
>   	generic_phy = devm_phy_create(dev, dev->of_node, &ops);
>   	if (IS_ERR(generic_phy)) {
>   		dev_err(dev, "failed to create PHY\n");
> 
