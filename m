Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE414C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6D220842
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbfCASJ3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:09:29 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:47474 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726835AbfCASJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 13:09:28 -0500
Received: from ip092042140082.rev.nessus.at ([92.42.140.82]:56577 helo=[10.2.146.249])
        by mail.theobroma-systems.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <christoph.muellner@theobroma-systems.com>)
        id 1gzmam-00075h-Oq; Fri, 01 Mar 2019 19:09:04 +0100
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 1/3] phy: rockchip-emmc: Allow to set drive impedance via
 DTS.
From:   =?utf-8?Q?Christoph_M=C3=BCllner?= 
        <christoph.muellner@theobroma-systems.com>
In-Reply-To: <CAD=FV=UUuQYwh2DMgB5FLuiE1BwbTMTuc9rAte1J5L_JP5qk1Q@mail.gmail.com>
Date:   Fri, 1 Mar 2019 19:09:03 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
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
Content-Transfer-Encoding: 8BIT
Message-Id: <CB9331AE-2FEC-4646-BD8E-BDF9F4E48F74@theobroma-systems.com>
References: <20190301153348.29870-1-christoph.muellner@theobroma-systems.com>
 <CAD=FV=UUuQYwh2DMgB5FLuiE1BwbTMTuc9rAte1J5L_JP5qk1Q@mail.gmail.com>
To:     Doug Anderson <dianders@chromium.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

> On 01.03.2019, at 17:48, Doug Anderson <dianders@chromium.org> wrote:
> 
> Hi,
> 
> On Fri, Mar 1, 2019 at 7:37 AM Christoph Muellner
> <christoph.muellner@theobroma-systems.com> wrote:
>> 
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
>> 1 file changed, 36 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
>> index 19bf84f0bc67..5413fa73dd45 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-emmc.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
>> @@ -87,6 +87,7 @@ struct rockchip_emmc_phy {
>>        unsigned int    reg_offset;
>>        struct regmap   *reg_base;
>>        struct clk      *emmcclk;
>> +       unsigned int drive_impedance;
>> };
>> 
>> static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
>> @@ -281,10 +282,10 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
>> {
>>        struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
>> 
>> -       /* Drive impedance: 50 Ohm */
>> +       /* Drive impedance: from DTS */
>>        regmap_write(rk_phy->reg_base,
>>                     rk_phy->reg_offset + GRF_EMMCPHY_CON6,
>> -                    HIWORD_UPDATE(PHYCTRL_DR_50OHM,
>> +                    HIWORD_UPDATE(rk_phy->drive_impedance,
>>                                   PHYCTRL_DR_MASK,
>>                                   PHYCTRL_DR_SHIFT));
>> 
>> @@ -314,6 +315,28 @@ static const struct phy_ops ops = {
>>        .owner          = THIS_MODULE,
>> };
>> 
>> +static u32 convert_drive_impedance_ohm(struct platform_device *pdev, u32 dr_ohm)
>> +{
>> +       switch (dr_ohm) {
>> +       case 100:
>> +               return PHYCTRL_DR_100OHM;
>> +       case 66:
>> +               return PHYCTRL_DR_66OHM;
>> +       case 50:
>> +               return PHYCTRL_DR_50OHM;
>> +       case 40:
>> +               return PHYCTRL_DR_40OHM;
>> +       case 33:
>> +               return PHYCTRL_DR_33OHM;
>> +       }
>> +
>> +       dev_warn(&pdev->dev,
>> +               "Invalid value %u for drive-impedance-ohm. "
>> +               "Falling back to 50 Ohm.\n",
>> +               dr_ohm);
>> +       return PHYCTRL_DR_50OHM;
>> +}
>> +
>> static int rockchip_emmc_phy_probe(struct platform_device *pdev)
>> {
>>        struct device *dev = &pdev->dev;
>> @@ -322,6 +345,7 @@ static int rockchip_emmc_phy_probe(struct platform_device *pdev)
>>        struct phy_provider *phy_provider;
>>        struct regmap *grf;
>>        unsigned int reg_offset;
>> +       u32 val;
>> 
>>        if (!dev->parent || !dev->parent->of_node)
>>                return -ENODEV;
>> @@ -345,6 +369,16 @@ static int rockchip_emmc_phy_probe(struct platform_device *pdev)
>>        rk_phy->reg_offset = reg_offset;
>>        rk_phy->reg_base = grf;
>> 
>> +       if (of_property_read_u32(dev->of_node, "drive-impedance-ohm", &val)) {
>> +               dev_info(dev,
>> +                       "Missing drive-impedance-ohm property in node %s "
>> +                       "Falling back to 50 Ohm.\n",
>> +                       dev->of_node->name);
> 
> This is awfully noisy for something that pretty much all existing
> boards will run.  debug level instead of info level?  Also:

Removed for v2 as suggested by Robin.

> 
> * Don't split strings
> across lines
> 
> * There's a magic % thing to get the name of an OF node.  Use that.
> 
> 
>> +               rk_phy->drive_impedance = PHYCTRL_DR_50OHM;
>> +       } else {
>> +               rk_phy->drive_impedance = convert_drive_impedance_ohm(pdev, val);
>> +       }
> 
> It's been a long time since I looked at this, but I could have sworn
> that it was more complicated than that.  Specifically I though you
> were supposed to query the eMMC card for what it supported and then
> resolve that with what the host could support.
> 
> Assuming that this is supposed to be queried from the card (which is
> how I remember it) then you definitely don't want it in the device
> tree since you want to be able to stuff various different eMMC parts
> and we should be able to figure out the impedance at runtime.
> 
> 
> NOTE: IIRC the old value of 50 ohms is required to be supported by all
> hosts and cards and is specified to be the default.
> 

When using 50 ohms on our board in HS-400 mode (200 MHz), then
we see communication errors. These are cause by additional components
on the clock line, which damp the 200 Mhz signal too much.

We could do the following:

* sdhci.c provides a default implementation to set the drive impedance (in HOST_CONTROL2,
  like it is done already now as part of sdhci_set_ios())
* sdhci-of-arasan.c installs an alternative implementation in case of Rockchip's eMMC controller
* the alternative implementation uses a callback to the Rockchip's eMMC phy driver
* the Rockchip eMMC phy driver sets the drive impedance accordingly

But still we would need a mechanism to override this for our board.
And exactly this override mechanism is provided by the patch series.

Thanks,
Christoph

> 
> I do see at least the summary of what I thought of this before at
> <https://patchwork.kernel.org/patch/9086541/>
> 
> 
> (Sorry if the above is wrong and feel free to correct me--I don't have
> time at the moment to do all the full research but hopefully you can
> dig more based on my pointers.  Feel free to call me on my BS)
> 
> 
> -Doug

