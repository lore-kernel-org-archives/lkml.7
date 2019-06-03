Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BF3C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B35D248FE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u5Ozm140"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfFCLWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 07:22:11 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55892 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfFCLWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 07:22:10 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x53BLvO4103825;
        Mon, 3 Jun 2019 06:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559560917;
        bh=2YhNwIo/l7wzWRuENxexmzy1sBuFHUF6M4OhGWZhKHk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=u5Ozm140iDprwkX1UzkHx925k7VJNDiqRJNRhNvieaj5M96uC5sI++R47WHGxmQZI
         HmZYqqLR29A71GOw4j75zdPLA8lOFWZBEjswNo4ekHoNUjeaA/WdZOJs32KFOQrwxZ
         XIDZKGypdW3mhKGS4cq8vsh0kEd9FS40dmckYH/4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x53BLvq2041821
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Jun 2019 06:21:57 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 3 Jun
 2019 06:21:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 3 Jun 2019 06:21:57 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x53BLqLo075595;
        Mon, 3 Jun 2019 06:21:53 -0500
Subject: Re: [PATCH] phy: rockchip-dp: Avoid power leak by leaving the PHY
 power on
To:     Caesar Wang <wxt@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>
CC:     <hl@rock-chips.com>, <linux-rockchip@lists.infradead.org>,
        <dbasehore@chromium.org>, <mka@chromium.org>,
        <ryandcase@chromium.org>, <groeck@chromium.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "nickey.yang (nickey.yang@rock-chips.com)" 
        <nickey.yang@rock-chips.com>, wzz <wzz@rock-chips.com>,
        Huang Jiachai <hjc@rock-chips.com>
References: <20190507234857.81414-1-dianders@chromium.org>
 <79ca5499-6b7d-fe55-2030-283f5cfb1d27@rock-chips.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <82480aa5-ab2e-11c5-8dd5-c395f72fc6e7@ti.com>
Date:   Mon, 3 Jun 2019 16:50:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <79ca5499-6b7d-fe55-2030-283f5cfb1d27@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/05/19 1:34 PM, Caesar Wang wrote:
> Hi Doug,
> 
> For now,  nobody of rockchip is responsible for this driver.
> Cc: Nickey, Zain, Hjc
> 
> 
> On 5/8/19 7:48 AM, Douglas Anderson wrote:
>> While testing a newer kernel on rk3288-based Chromebooks I found that
>> the power draw in suspend was higher on newer kernels compared to the
>> downstream Chrome OS 3.14 kernel.  Specifically the power of an
>> rk3288-veyron-jerry board that I tested (as measured by the smart
>> battery) was ~16 mA on Chrome OS 3.14 and ~21 mA on a newer kernel.
>>
>> I tracked the regression down to the fact that the "DP PHY" driver
>> didn't exist in our downstream 3.14.  We relied on the eDP driver to
>> turn on the clock and relied on the fact that the power for the PHY
>> was default turned on.
>>
>> Specifically the thing that caused the power regression was turning
>> the eDP PHY _off_.  Presumably there is some sort of power leak in the
>> system and when we turn the PHY off something is leaching power from
>> something else and causing excessive power draw.
>>
>> Doing a search through device trees shows that this PHY is only ever
>> used on rk3288.  Presumably this power leak is present on all
>> rk3288-SoCs running upstream Linux so let's just whack the driver to
>> make sure we never turn off power.  We'll still leave the parts that
>> turn _on_ the power and grab the clock, though.
>>
>> NOTES:
>> A) If someone can identify what this power leak is and fix it in some
>>     other way we can revert this patch.
>> B) If someone can show that their particular board doesn't have this
>>     power leak (maybe they have rails hooked up differently?) we can
>>     perhaps add a device tree property indicating that for some boards
>>     it's OK to turn this rail off.  I don't want to add this property
>>     until I know of a board that needs it.
>>
>> Fixes: fd968973de95 ("phy: Add driver for rockchip Display Port PHY")
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> 
> 
> Reviewed-by: Caesar Wang <wxt@rock-chips.com>
> 
>> ---
>> As far as I know Yakir (the original author) is no longer at Rockchip.
>> I've added a few other Rockchip people and hopefully one of them can
>> help direct even if they're not directly responsible.
>>
>>   drivers/phy/rockchip/phy-rockchip-dp.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-dp.c
>> b/drivers/phy/rockchip/phy-rockchip-dp.c
>> index 8b267a746576..10bbcd69d6f5 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-dp.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-dp.c
>> @@ -35,7 +35,7 @@ struct rockchip_dp_phy {
>>   static int rockchip_set_phy_state(struct phy *phy, bool enable)
>>   {
>>       struct rockchip_dp_phy *dp = phy_get_drvdata(phy);
>> -    int ret;
>> +    int ret = 0;
>>         if (enable) {
>>           ret = regmap_write(dp->grf, GRF_SOC_CON12,
>> @@ -50,9 +50,12 @@ static int rockchip_set_phy_state(struct phy *phy, bool
>> enable)
>>       } else {
>>           clk_disable_unprepare(dp->phy_24m);
>>   -        ret = regmap_write(dp->grf, GRF_SOC_CON12,
>> -                   GRF_EDP_PHY_SIDDQ_HIWORD_MASK |
>> -                   GRF_EDP_PHY_SIDDQ_OFF);
>> +        /*
>> +         * Intentionally don't turn SIDDQ off when disabling
>> +         * the PHY.  There is a power leak on rk3288 and
>> +         * suspend power _increases_ by 5 mA if you turn this
>> +         * off.
>> +         */

Can someone in Rockchip try to find the root-cause of the issue? Keeping the
PHY off shouldn't increase power draw.

Thanks
Kishon
