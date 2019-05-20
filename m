Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611E6C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4BD2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbfETIMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:12:09 -0400
Received: from regular1.263xmail.com ([211.150.70.199]:60552 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbfETIMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:12:09 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 May 2019 04:12:07 EDT
Received: from wxt?rock-chips.com (unknown [192.168.167.161])
        by regular1.263xmail.com (Postfix) with ESMTP id 1F4D63EE;
        Mon, 20 May 2019 16:04:14 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.21.194] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32757T140039436609280S1558339450334725_;
        Mon, 20 May 2019 16:04:11 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c6a2d7109fd86b9f3d455bed21fbadbc>
X-RL-SENDER: wxt@rock-chips.com
X-SENDER: wxt@rock-chips.com
X-LOGIN-NAME: wxt@rock-chips.com
X-FST-TO: hjc@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH] phy: rockchip-dp: Avoid power leak by leaving the PHY
 power on
To:     Douglas Anderson <dianders@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     hl@rock-chips.com, linux-rockchip@lists.infradead.org,
        dbasehore@chromium.org, mka@chromium.org, ryandcase@chromium.org,
        groeck@chromium.org, Elaine Zhang <zhangqing@rock-chips.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "nickey.yang (nickey.yang@rock-chips.com)" 
        <nickey.yang@rock-chips.com>, wzz <wzz@rock-chips.com>,
        Huang Jiachai <hjc@rock-chips.com>
References: <20190507234857.81414-1-dianders@chromium.org>
From:   Caesar Wang <wxt@rock-chips.com>
Message-ID: <79ca5499-6b7d-fe55-2030-283f5cfb1d27@rock-chips.com>
Date:   Mon, 20 May 2019 16:04:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507234857.81414-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

For now,  nobody of rockchip is responsible for this driver.
Cc: Nickey, Zain, Hjc


On 5/8/19 7:48 AM, Douglas Anderson wrote:
> While testing a newer kernel on rk3288-based Chromebooks I found that
> the power draw in suspend was higher on newer kernels compared to the
> downstream Chrome OS 3.14 kernel.  Specifically the power of an
> rk3288-veyron-jerry board that I tested (as measured by the smart
> battery) was ~16 mA on Chrome OS 3.14 and ~21 mA on a newer kernel.
>
> I tracked the regression down to the fact that the "DP PHY" driver
> didn't exist in our downstream 3.14.  We relied on the eDP driver to
> turn on the clock and relied on the fact that the power for the PHY
> was default turned on.
>
> Specifically the thing that caused the power regression was turning
> the eDP PHY _off_.  Presumably there is some sort of power leak in the
> system and when we turn the PHY off something is leaching power from
> something else and causing excessive power draw.
>
> Doing a search through device trees shows that this PHY is only ever
> used on rk3288.  Presumably this power leak is present on all
> rk3288-SoCs running upstream Linux so let's just whack the driver to
> make sure we never turn off power.  We'll still leave the parts that
> turn _on_ the power and grab the clock, though.
>
> NOTES:
> A) If someone can identify what this power leak is and fix it in some
>     other way we can revert this patch.
> B) If someone can show that their particular board doesn't have this
>     power leak (maybe they have rails hooked up differently?) we can
>     perhaps add a device tree property indicating that for some boards
>     it's OK to turn this rail off.  I don't want to add this property
>     until I know of a board that needs it.
>
> Fixes: fd968973de95 ("phy: Add driver for rockchip Display Port PHY")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>


Reviewed-by: Caesar Wang <wxt@rock-chips.com>

> ---
> As far as I know Yakir (the original author) is no longer at Rockchip.
> I've added a few other Rockchip people and hopefully one of them can
> help direct even if they're not directly responsible.
>
>   drivers/phy/rockchip/phy-rockchip-dp.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-dp.c b/drivers/phy/rockchip/phy-rockchip-dp.c
> index 8b267a746576..10bbcd69d6f5 100644
> --- a/drivers/phy/rockchip/phy-rockchip-dp.c
> +++ b/drivers/phy/rockchip/phy-rockchip-dp.c
> @@ -35,7 +35,7 @@ struct rockchip_dp_phy {
>   static int rockchip_set_phy_state(struct phy *phy, bool enable)
>   {
>   	struct rockchip_dp_phy *dp = phy_get_drvdata(phy);
> -	int ret;
> +	int ret = 0;
>   
>   	if (enable) {
>   		ret = regmap_write(dp->grf, GRF_SOC_CON12,
> @@ -50,9 +50,12 @@ static int rockchip_set_phy_state(struct phy *phy, bool enable)
>   	} else {
>   		clk_disable_unprepare(dp->phy_24m);
>   
> -		ret = regmap_write(dp->grf, GRF_SOC_CON12,
> -				   GRF_EDP_PHY_SIDDQ_HIWORD_MASK |
> -				   GRF_EDP_PHY_SIDDQ_OFF);
> +		/*
> +		 * Intentionally don't turn SIDDQ off when disabling
> +		 * the PHY.  There is a power leak on rk3288 and
> +		 * suspend power _increases_ by 5 mA if you turn this
> +		 * off.
> +		 */


As described by TRM, The “GRF_EDP_PHY_SIDDQ_OFF” that all circuits are 
power down, all
IO are high-Z. That should make sure the PD_VIO[0] was disabled first, 
no active.
But the rk3288 can't turn pd_vio off at the moment.

[0]
PD_VIO Which clock are device clocks:
              *    clocks        devices
              *    *_IEP        IEP:Image Enhancement Processor
              *    *_ISP        ISP:Image Signal Processing
              *    *_VIP        VIP:Video Input Processor
              *    *_VOP*        VOP:Visual Output Processor
              *    *_RGA        RGA
              *    *_EDP*        EDP
              *    *_LVDS_*    LVDS
              *    *_HDMI        HDMI
              *    *_MIPI_*    MIPI


Thanks,
-Caesar


>   	}
>   
>   	return ret;


