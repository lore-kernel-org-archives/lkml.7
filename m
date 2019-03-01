Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C85AC10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140212083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbfCAQWF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:22:05 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:60526 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389010AbfCAQWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:22:02 -0500
Received: from ip092042140082.rev.nessus.at ([92.42.140.82]:56208 helo=[10.2.146.249])
        by mail.theobroma-systems.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <christoph.muellner@theobroma-systems.com>)
        id 1gzkun-0005mY-B6; Fri, 01 Mar 2019 17:21:37 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 1/3] phy: rockchip-emmc: Allow to set drive impedance via
 DTS.
From:   =?utf-8?Q?Christoph_M=C3=BCllner?= 
        <christoph.muellner@theobroma-systems.com>
In-Reply-To: <2706069.0FZLJLT2V8@phil>
Date:   Fri, 1 Mar 2019 17:21:36 +0100
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawn.lin@rock-chips.com,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Douglas Anderson <dianders@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Tony Xie <tony.xie@rock-chips.com>,
        Randy Li <ayaka@soulik.info>,
        Vicente Bergas <vicencb@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <32D33089-37C4-4086-88B1-5408A0782917@theobroma-systems.com>
References: <20190301153348.29870-1-christoph.muellner@theobroma-systems.com>
 <2706069.0FZLJLT2V8@phil>
To:     Heiko Stuebner <heiko@sntech.de>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

> On 01.03.2019, at 16:59, Heiko Stuebner <heiko@sntech.de> wrote:
> 
> Hi Christoph,
> 
> Am Freitag, 1. März 2019, 16:33:43 CET schrieb Christoph Muellner:
>> The rockchip-emmc PHY can be configured with different
>> drive impedance values. Currenlty a value of 50 Ohm is
>> hard coded into the driver.
>> 
>> This patch introduces the DTS property 'drive-impedance-ohm'
>> for the rockchip-emmc phy node, which uses the value from the DTS
>> to setup the drive impedance accordingly.
>> 
>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
>> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
>> ---
>> drivers/phy/rockchip/phy-rockchip-emmc.c | 38 ++++++++++++++++++++++++++++++--
> 
> looks good on first glance, but is missing an addition to the emmc-phy
> devicetree binding in
> 	Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt

you are right.
I've just sent that in a separate patch (DT doc changes need to be in a separate commit anyways).

Thanks,
Christoph

> 
> 
> Heiko
> 
>> 1 file changed, 36 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
>> index 19bf84f0bc67..5413fa73dd45 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-emmc.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
>> @@ -87,6 +87,7 @@ struct rockchip_emmc_phy {
>> 	unsigned int	reg_offset;
>> 	struct regmap	*reg_base;
>> 	struct clk	*emmcclk;
>> +	unsigned int drive_impedance;
>> };
>> 
>> static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
>> @@ -281,10 +282,10 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
>> {
>> 	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
>> 
>> -	/* Drive impedance: 50 Ohm */
>> +	/* Drive impedance: from DTS */
>> 	regmap_write(rk_phy->reg_base,
>> 		     rk_phy->reg_offset + GRF_EMMCPHY_CON6,
>> -		     HIWORD_UPDATE(PHYCTRL_DR_50OHM,
>> +		     HIWORD_UPDATE(rk_phy->drive_impedance,
>> 				   PHYCTRL_DR_MASK,
>> 				   PHYCTRL_DR_SHIFT));
>> 
>> @@ -314,6 +315,28 @@ static const struct phy_ops ops = {
>> 	.owner		= THIS_MODULE,
>> };
>> 
>> +static u32 convert_drive_impedance_ohm(struct platform_device *pdev, u32 dr_ohm)
>> +{
>> +	switch (dr_ohm) {
>> +	case 100:
>> +		return PHYCTRL_DR_100OHM;
>> +	case 66:
>> +		return PHYCTRL_DR_66OHM;
>> +	case 50:
>> +		return PHYCTRL_DR_50OHM;
>> +	case 40:
>> +		return PHYCTRL_DR_40OHM;
>> +	case 33:
>> +		return PHYCTRL_DR_33OHM;
>> +	}
>> +
>> +	dev_warn(&pdev->dev,
>> +		"Invalid value %u for drive-impedance-ohm. "
>> +		"Falling back to 50 Ohm.\n",
>> +		dr_ohm);
>> +	return PHYCTRL_DR_50OHM;
>> +}
>> +
>> static int rockchip_emmc_phy_probe(struct platform_device *pdev)
>> {
>> 	struct device *dev = &pdev->dev;
>> @@ -322,6 +345,7 @@ static int rockchip_emmc_phy_probe(struct platform_device *pdev)
>> 	struct phy_provider *phy_provider;
>> 	struct regmap *grf;
>> 	unsigned int reg_offset;
>> +	u32 val;
>> 
>> 	if (!dev->parent || !dev->parent->of_node)
>> 		return -ENODEV;
>> @@ -345,6 +369,16 @@ static int rockchip_emmc_phy_probe(struct platform_device *pdev)
>> 	rk_phy->reg_offset = reg_offset;
>> 	rk_phy->reg_base = grf;
>> 
>> +	if (of_property_read_u32(dev->of_node, "drive-impedance-ohm", &val)) {
>> +		dev_info(dev,
>> +			"Missing drive-impedance-ohm property in node %s "
>> +			"Falling back to 50 Ohm.\n",
>> +			dev->of_node->name);
>> +		rk_phy->drive_impedance = PHYCTRL_DR_50OHM;
>> +	} else {
>> +		rk_phy->drive_impedance = convert_drive_impedance_ohm(pdev, val);
>> +	}
>> +
>> 	generic_phy = devm_phy_create(dev, dev->of_node, &ops);
>> 	if (IS_ERR(generic_phy)) {
>> 		dev_err(dev, "failed to create PHY\n");
>> 
> 
> 
> 
> 

