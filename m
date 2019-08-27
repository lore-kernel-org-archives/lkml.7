Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9A1C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCB020828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xHm5ro9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfH0Fqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 01:46:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47236 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfH0Fqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 01:46:31 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7R5kG9A107128;
        Tue, 27 Aug 2019 00:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566884776;
        bh=ZAF6lxduyg1DAVm1+t6edccVUM1EdHkaqdYbZYXZhs8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xHm5ro9L+Re37Rl4h/bOVIzb7tdWP8WOnvEyMvvKaQVvupJfwiLnA0m5RctCJPXYO
         8q+NX5TZuoNBT0PHL00CN/OhjceROuazI7sFVliSikACr2SEMskLIVMATg/ZhMovPb
         t0q0aMZWd5YuGIf4h2SOKney9ujCAtMMU1o8ngMs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7R5kG9Q124670
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Aug 2019 00:46:16 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 27
 Aug 2019 00:46:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 27 Aug 2019 00:46:15 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7R5kDPw088826;
        Tue, 27 Aug 2019 00:46:13 -0500
Subject: Re: [PATCH] drm/bridge: tc358767: Expose test mode functionality via
 debugfs
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        <dri-devel@lists.freedesktop.org>
CC:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        <linux-kernel@vger.kernel.org>
References: <20190826182524.5064-1-andrew.smirnov@gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <3cc666bd-36f7-c1ca-e369-ee88cd06332c@ti.com>
Date:   Tue, 27 Aug 2019 08:46:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826182524.5064-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/08/2019 21:25, Andrey Smirnov wrote:
> Presently, the driver code artificially limits test pattern mode to a
> single pattern with fixed color selection. It being a kernel module
> parameter makes switching "test patter" <-> "proper output" modes
> on-the-fly clunky and outright impossible if the driver is built into
> the kernel.
> 
> To improve the situation a bit, convert current test pattern code to
> use debugfs instead by exposing "TestCtl" register. This way old
> "tc_test_pattern=1" functionality can be emulated via:
> 
>      echo -n 0x78146312 > tstctl
> 
> and switch back to regular mode can be done with:
> 
>      echo -n 0x78146310 > tstctl

It might be worth explaining the format in the commit msg or in a 
comment in the driver.

> Note that switching to any of the test patterns, will NOT trigger link
> re-establishment whereas switching to normal operation WILL. This is
> done so:
> 
> a) we can isolate and verify (e)DP link functionality by switching to
>     one of the test patters
> 
> b) trigger a link re-establishment by switching back to normal mode
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/gpu/drm/bridge/tc358767.c | 137 ++++++++++++++++++++++--------
>   1 file changed, 101 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 6308d93ad91d..7a795b613ed0 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -17,6 +17,7 @@
>   
>   #include <linux/bitfield.h>
>   #include <linux/clk.h>
> +#include <linux/debugfs.h>
>   #include <linux/device.h>
>   #include <linux/gpio/consumer.h>
>   #include <linux/i2c.h>
> @@ -222,11 +223,10 @@
>   #define COLOR_B			GENMASK(15, 8)
>   #define ENI2CFILTER		BIT(4)
>   #define COLOR_BAR_MODE		GENMASK(1, 0)
> +#define COLOR_BAR_MODE_NORMAL	0
>   #define COLOR_BAR_MODE_BARS	2
> -#define PLL_DBG			0x0a04
>   
> -static bool tc_test_pattern;
> -module_param_named(test, tc_test_pattern, bool, 0644);
> +#define PLL_DBG			0x0a04
>   
>   struct tc_edp_link {
>   	struct drm_dp_link	base;
> @@ -789,16 +789,6 @@ static int tc_set_video_mode(struct tc_data *tc,
>   	if (ret)
>   		return ret;
>   
> -	/* Test pattern settings */
> -	ret = regmap_write(tc->regmap, TSTCTL,
> -			   FIELD_PREP(COLOR_R, 120) |
> -			   FIELD_PREP(COLOR_G, 20) |
> -			   FIELD_PREP(COLOR_B, 99) |
> -			   ENI2CFILTER |
> -			   FIELD_PREP(COLOR_BAR_MODE, COLOR_BAR_MODE_BARS));
> -	if (ret)
> -		return ret;
> -
>   	/* DP Main Stream Attributes */
>   	vid_sync_dly = hsync_len + left_margin + mode->hdisplay;
>   	ret = regmap_write(tc->regmap, DP0_VIDSYNCDELAY,
> @@ -1150,14 +1140,6 @@ static int tc_stream_enable(struct tc_data *tc)
>   
>   	dev_dbg(tc->dev, "enable video stream\n");
>   
> -	/* PXL PLL setup */
> -	if (tc_test_pattern) {
> -		ret = tc_pxl_pll_en(tc, clk_get_rate(tc->refclk),
> -				    1000 * tc->mode.clock);
> -		if (ret)
> -			return ret;
> -	}
> -
>   	ret = tc_set_video_mode(tc, &tc->mode);
>   	if (ret)
>   		return ret;
> @@ -1186,12 +1168,8 @@ static int tc_stream_enable(struct tc_data *tc)
>   	if (ret)
>   		return ret;
>   	/* Set input interface */
> -	value = DP0_AUDSRC_NO_INPUT;
> -	if (tc_test_pattern)
> -		value |= DP0_VIDSRC_COLOR_BAR;
> -	else
> -		value |= DP0_VIDSRC_DPI_RX;
> -	ret = regmap_write(tc->regmap, SYSCTRL, value);
> +	ret = regmap_write(tc->regmap, SYSCTRL,
> +			   DP0_AUDSRC_NO_INPUT | DP0_VIDSRC_DPI_RX);
>   	if (ret)
>   		return ret;
>   
> @@ -1220,39 +1198,44 @@ static void tc_bridge_pre_enable(struct drm_bridge *bridge)
>   	drm_panel_prepare(tc->panel);
>   }
>   
> -static void tc_bridge_enable(struct drm_bridge *bridge)
> +static int __tc_bridge_enable(struct tc_data *tc)
>   {
> -	struct tc_data *tc = bridge_to_tc(bridge);
>   	int ret;
>   
>   	ret = tc_get_display_props(tc);
>   	if (ret < 0) {
>   		dev_err(tc->dev, "failed to read display props: %d\n", ret);
> -		return;
> +		return ret;
>   	}
>   
>   	ret = tc_main_link_enable(tc);
>   	if (ret < 0) {
>   		dev_err(tc->dev, "main link enable error: %d\n", ret);
> -		return;
> +		return ret;
>   	}
>   
>   	ret = tc_stream_enable(tc);
>   	if (ret < 0) {
>   		dev_err(tc->dev, "main link stream start error: %d\n", ret);
>   		tc_main_link_disable(tc);
> -		return;
>   	}
>   
> -	drm_panel_enable(tc->panel);
> +	return ret;
>   }

Maybe it's just me, but I rather have the last if() block do a "return 
ret"; and have "return 0;" at the end of the function to keep all the if 
blocks consistent.

>   
> -static void tc_bridge_disable(struct drm_bridge *bridge)
> +static void tc_bridge_enable(struct drm_bridge *bridge)
>   {
>   	struct tc_data *tc = bridge_to_tc(bridge);
> -	int ret;
>   
> -	drm_panel_disable(tc->panel);
> +	if (__tc_bridge_enable(tc) < 0)
> +		return;
> +
> +	drm_panel_enable(tc->panel);
> +}
> +
> +static int __tc_bridge_disable(struct tc_data *tc)
> +{
> +	int ret;
>   
>   	ret = tc_stream_disable(tc);
>   	if (ret < 0)
> @@ -1261,6 +1244,16 @@ static void tc_bridge_disable(struct drm_bridge *bridge)
>   	ret = tc_main_link_disable(tc);
>   	if (ret < 0)
>   		dev_err(tc->dev, "main link disable error: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void tc_bridge_disable(struct drm_bridge *bridge)
> +{
> +	struct tc_data *tc = bridge_to_tc(bridge);
> +
> +	drm_panel_disable(tc->panel);
> +	__tc_bridge_disable(tc);
>   }

Maybe have this enable/disable change as a separate patch?

>   
>   static void tc_bridge_post_disable(struct drm_bridge *bridge)
> @@ -1372,6 +1365,77 @@ static enum drm_connector_status tc_connector_detect(struct drm_connector *conne
>   		return connector_status_disconnected;
>   }
>   
> +static int tc_tstctl_set(void *data, u64 val)
> +{
> +	struct tc_data *tc = data;
> +	int ret;
> +
> +	if (FIELD_GET(COLOR_BAR_MODE, val) == COLOR_BAR_MODE_NORMAL) {
> +		ret = regmap_write(tc->regmap, SYSCTRL, DP0_VIDSRC_DPI_RX);
> +		if (ret) {
> +			dev_err(tc->dev,
> +				"failed to select dpi video stream\n");
> +			return ret;
> +		}
> +
> +		ret = regmap_write(tc->regmap, TSTCTL, val | ENI2CFILTER);
> +		if (ret) {
> +			dev_err(tc->dev, "failed to set TSTCTL\n");
> +			return ret;
> +		}
> +
> +		ret = tc_pxl_pll_dis(tc);
> +		if (ret) {
> +			dev_err(tc->dev, "failed to disable PLL\n");
> +			return ret;
> +		}
> +
> +		/*
> +		 * Re-establish DP link
> +		 */
> +		ret = __tc_bridge_disable(tc);
> +		if (ret)
> +			return ret;
> +
> +		ret = __tc_bridge_enable(tc);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = tc_pxl_pll_en(tc, clk_get_rate(tc->refclk),
> +				    1000 * tc->mode.clock);
> +		if (ret) {
> +			dev_err(tc->dev, "failed to enable PLL\n");
> +			return ret;
> +		}
> +
> +		ret = regmap_write(tc->regmap, TSTCTL, val | ENI2CFILTER);
> +		if (ret) {
> +			dev_err(tc->dev, "failed to set TSTCTL\n");
> +			return ret;
> +		}
> +
> +		ret = regmap_write(tc->regmap, SYSCTRL, DP0_VIDSRC_COLOR_BAR);
> +		if (ret) {
> +			dev_err(tc->dev, "failed to color bar video stream\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(tc_tstctl_fops, NULL, tc_tstctl_set, "%llu\n");
> +
> +static int tc_late_register(struct drm_connector *connector)
> +{
> +	if (connector->debugfs_entry)
> +		debugfs_create_file_unsafe("tstctl", 0644,
> +					   connector->debugfs_entry,
> +					   connector_to_tc(connector),
> +					   &tc_tstctl_fops);
> +	return 0;
> +}

I very recently wanted to add quick debugfs functionality to a bridge 
too, but as there didn't seem an easy way to do it, I just lazily added 
the debugfs files to the debugfs root...

I'm not sure if adding bridge's debugfs files to connector's directory 
is a good idea. What if we have two bridges, both have the same debugfs 
file? Or even if there's no conflict, there's also no way to know which 
bridge a particular debugfs file belongs to.

Maybe we need some DRM infrastructure for bridge debugfs?

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
