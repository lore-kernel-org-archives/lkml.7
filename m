Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584FCC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FF7206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uLLq6Tq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfFFIQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:16:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51154 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFIQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:16:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190606081636euoutp02abf8536999f59527132a42988269e3f7~ljgSVxUyn1035010350euoutp02R
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2019 08:16:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190606081636euoutp02abf8536999f59527132a42988269e3f7~ljgSVxUyn1035010350euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559808996;
        bh=ema7D7hL/gimsUt+MjqT3jyUKG1qu0SX0tNtF6u23RQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=uLLq6Tq92mQsANJY+fgtgtaVuwq78aWITwJT6RRQmY1CE2D58fkfNbgO8BHYRTMJi
         0h0uglVQzAmjezAIb2Ra2KXHa0xUfkdvJpUSjRT1jhkuRmCjTw04irt/0qPn+JHTXn
         sFARHNihfkg0FB6WaXDNyoFoejpirw2q00ZH8/K4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190606081635eucas1p2fc26b0056a8b87d2d5915de8f6ab5bba~ljgRqC6Pt2782827828eucas1p2j;
        Thu,  6 Jun 2019 08:16:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C3.11.04325.3EBC8FC5; Thu,  6
        Jun 2019 09:16:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190606081634eucas1p216cc8c49612d299a305d488871dd56e6~ljgQ3Id7H0445004450eucas1p2e;
        Thu,  6 Jun 2019 08:16:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190606081634eusmtrp2ee724d3e740dc6f9d564cbe17527c92f~ljgQnaqxY1010210102eusmtrp2J;
        Thu,  6 Jun 2019 08:16:34 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-30-5cf8cbe3d905
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B3.F8.04146.2EBC8FC5; Thu,  6
        Jun 2019 09:16:34 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190606081633eusmtip1ac5b49157c844d13111287b92c233c3f~ljgPktkJI3153031530eusmtip1P;
        Thu,  6 Jun 2019 08:16:33 +0000 (GMT)
Subject: Re: [PATCH v3 04/15] drm/bridge: tc358767: Simplify
 tc_set_video_mode()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <f34eee66-6fe0-2bae-4a07-f114bbcacf33@samsung.com>
Date:   Thu, 6 Jun 2019 10:16:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605070507.11417-5-andrew.smirnov@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djPc7qPT/+IMfi4VsCiucPWoulQA6tF
        U8dbVosfVw6zWBzcc5zJ4srX92wWD+beZLLonLiE3eLyrjlsFnfvnWCxWD//FpsDt8flvl4m
        jwdT/zN57Jx1l91jdsdMVo/73ceZPPr/Gngcv7GdyePzJjmPc1PPMgVwRnHZpKTmZJalFunb
        JXBlrN95mamg37ai+fVM9gbGfQZdjJwcEgImEi2fbrJ0MXJxCAmsYJR4+mIfI4TzhVHiyvOn
        bBDOZ0aJqe83McG0vLnYBVW1nFHi89vfUFVvGSUOXVjKBlIlLBAk0bTiIiuILSIQIPGpaSdY
        EbPAVyaJA5cmgo1iE9CU+Lv5JlgDr4CdxOa+F4wgNouAisTvNYvBakQFIiTuH9vAClEjKHFy
        5hMWEJsTqP7cwytg9cwC8hLNW2czQ9jiEreezGcCWSYh8JZd4syRLlaIu10kpt2fAWULS7w6
        voUdwpaR+L9zPtRv9RL3V7QwQzR3MEps3bCTGSJhLXH4OMg7HEAbNCXW79KHCDtKfN7RxQIS
        lhDgk7jxVhDiBj6JSdumM0OEeSU62oQgqhUl7p/dCjVQXGLpha9sExiVZiH5bBaSb2Yh+WYW
        wt4FjCyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxAlPa6X/Hv+5g3Pcn6RCjAAejEg+v
        xMbvMUKsiWXFlbmHGCU4mJVEeBNvf4kR4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN8CBaSCA9
        sSQ1OzW1ILUIJsvEwSnVwMgRfct67irtBQq9kksidt1tEEqPrEkIPvP/0janZEX9SM2sIz+d
        +N/e9Q85ZdkXc9/6ZN+Z/pzOdPfu1xLu7psuWF5JCRZeL1crq7qsZn2bxD6nSZfb/UU8G1dM
        9NY79FdBOuSM6UImy+z2moPBExUqA4S2H2y/e1Iid2r2Ro8NNnWergEhSizFGYmGWsxFxYkA
        DAxqQWUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xu7qPTv+IMbh2V9yiucPWoulQA6tF
        U8dbVosfVw6zWBzcc5zJ4srX92wWD+beZLLonLiE3eLyrjlsFnfvnWCxWD//FpsDt8flvl4m
        jwdT/zN57Jx1l91jdsdMVo/73ceZPPr/Gngcv7GdyePzJjmPc1PPMgVwRunZFOWXlqQqZOQX
        l9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlrN95mamg37ai+fVM9gbG
        fQZdjJwcEgImEm8udjF2MXJxCAksZZT4OecRE0RCXGL3/LfMELawxJ9rXWwQRa8ZJWZ/3cAG
        khAWCJJoWnGRFcQWEfCT6Jp3gAmkiFngO5PExOV7WSA6jjJKzOm8xAJSxSagKfF3802wbl4B
        O4nNfS8YQWwWARWJ32sWg60WFYiQOPN+BQtEjaDEyZlPwGxOoPpzD6+A1TMLqEv8mXeJGcKW
        l2jeOhvKFpe49WQ+0wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLz
        czcxAqN427Gfm3cwXtoYfIhRgINRiYdXYuP3GCHWxLLiytxDjBIczEoivIm3v8QI8aYkVlal
        FuXHF5XmpBYfYjQFem4is5Rocj4wweSVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5N
        LUgtgulj4uCUamDkmFYh47hZLeXUAymXjyZWBfMPV1mtagtueiL2S2Fyls+f5briZyyFZos8
        eDupqf129CYB7pm/f1dOMz1k1u1UIfHVlFvdyOy6ncPt1wtjWl89l+CNl1juW3bmmWp8nS5X
        yPGADL+1PR/UzM57ut31Tt2Q8mrrb7HoCTc+rXVk9/mi9rBwabASS3FGoqEWc1FxIgAxXXlR
        +AIAAA==
X-CMS-MailID: 20190606081634eucas1p216cc8c49612d299a305d488871dd56e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605070530epcas2p12c8dcf1906e71653a624d0f53b6cdf58
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605070530epcas2p12c8dcf1906e71653a624d0f53b6cdf58
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
        <CGME20190605070530epcas2p12c8dcf1906e71653a624d0f53b6cdf58@epcas2p1.samsung.com>
        <20190605070507.11417-5-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.2019 09:04, Andrey Smirnov wrote:
> Simplify tc_set_video_mode() by replacing explicit shifting using
> macros from <linux/bitfield.h>. No functional change intended.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org


Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


> ---
>  drivers/gpu/drm/bridge/tc358767.c | 106 ++++++++++++++++++++++--------
>  1 file changed, 78 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 115cffc55a96..c0fc686ce5ec 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -24,6 +24,7 @@
>   * GNU General Public License for more details.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/gpio/consumer.h>
> @@ -56,6 +57,7 @@
>  
>  /* Video Path */
>  #define VPCTRL0			0x0450
> +#define VSDELAY			GENMASK(31, 20)
>  #define OPXLFMT_RGB666			(0 << 8)
>  #define OPXLFMT_RGB888			(1 << 8)
>  #define FRMSYNC_DISABLED		(0 << 4) /* Video Timing Gen Disabled */
> @@ -63,9 +65,17 @@
>  #define MSF_DISABLED			(0 << 0) /* Magic Square FRC disabled */
>  #define MSF_ENABLED			(1 << 0) /* Magic Square FRC enabled */
>  #define HTIM01			0x0454
> +#define HPW			GENMASK(8, 0)
> +#define HBPR			GENMASK(24, 16)
>  #define HTIM02			0x0458
> +#define HDISPR			GENMASK(10, 0)
> +#define HFPR			GENMASK(24, 16)
>  #define VTIM01			0x045c
> +#define VSPR			GENMASK(7, 0)
> +#define VBPR			GENMASK(23, 16)
>  #define VTIM02			0x0460
> +#define VFPR			GENMASK(23, 16)
> +#define VDISPR			GENMASK(10, 0)
>  #define VFUEN0			0x0464
>  #define VFUEN				BIT(0)   /* Video Frame Timing Upload */
>  
> @@ -108,14 +118,28 @@
>  /* Main Channel */
>  #define DP0_SECSAMPLE		0x0640
>  #define DP0_VIDSYNCDELAY	0x0644
> +#define VID_SYNC_DLY		GENMASK(15, 0)
> +#define THRESH_DLY		GENMASK(31, 16)
> +
>  #define DP0_TOTALVAL		0x0648
> +#define H_TOTAL			GENMASK(15, 0)
> +#define V_TOTAL			GENMASK(31, 16)
>  #define DP0_STARTVAL		0x064c
> +#define H_START			GENMASK(15, 0)
> +#define V_START			GENMASK(31, 16)
>  #define DP0_ACTIVEVAL		0x0650
> +#define H_ACT			GENMASK(15, 0)
> +#define V_ACT			GENMASK(31, 16)
> +
>  #define DP0_SYNCVAL		0x0654
> +#define VS_WIDTH		GENMASK(30, 16)
> +#define HS_WIDTH		GENMASK(14, 0)
>  #define SYNCVAL_HS_POL_ACTIVE_LOW	(1 << 15)
>  #define SYNCVAL_VS_POL_ACTIVE_LOW	(1 << 31)
>  #define DP0_MISC		0x0658
>  #define TU_SIZE_RECOMMENDED		(63) /* LSCLK cycles per TU */
> +#define MAX_TU_SYMBOL		GENMASK(28, 23)
> +#define TU_SIZE			GENMASK(21, 16)
>  #define BPC_6				(0 << 5)
>  #define BPC_8				(1 << 5)
>  
> @@ -192,6 +216,12 @@
>  
>  /* Test & Debug */
>  #define TSTCTL			0x0a00
> +#define COLOR_R			GENMASK(31, 24)
> +#define COLOR_G			GENMASK(23, 16)
> +#define COLOR_B			GENMASK(15, 8)
> +#define ENI2CFILTER		BIT(4)
> +#define COLOR_BAR_MODE		GENMASK(1, 0)
> +#define COLOR_BAR_MODE_BARS	2
>  #define PLL_DBG			0x0a04
>  
>  static bool tc_test_pattern;
> @@ -672,6 +702,7 @@ static int tc_set_video_mode(struct tc_data *tc,
>  	int upper_margin = mode->vtotal - mode->vsync_end;
>  	int lower_margin = mode->vsync_start - mode->vdisplay;
>  	int vsync_len = mode->vsync_end - mode->vsync_start;
> +	u32 dp0_syncval;
>  
>  	/*
>  	 * Recommended maximum number of symbols transferred in a transfer unit:
> @@ -696,50 +727,69 @@ static int tc_set_video_mode(struct tc_data *tc,
>  	 * assume we do not need any delay when DPI is a source of
>  	 * sync signals
>  	 */
> -	tc_write(VPCTRL0, (0 << 20) /* VSDELAY */ |
> +	tc_write(VPCTRL0,
> +		 FIELD_PREP(VSDELAY, 0) |
>  		 OPXLFMT_RGB888 | FRMSYNC_DISABLED | MSF_DISABLED);
> -	tc_write(HTIM01, (ALIGN(left_margin, 2) << 16) | /* H back porch */
> -			 (ALIGN(hsync_len, 2) << 0));	 /* Hsync */
> -	tc_write(HTIM02, (ALIGN(right_margin, 2) << 16) |  /* H front porch */
> -			 (ALIGN(mode->hdisplay, 2) << 0)); /* width */
> -	tc_write(VTIM01, (upper_margin << 16) |		/* V back porch */
> -			 (vsync_len << 0));		/* Vsync */
> -	tc_write(VTIM02, (lower_margin << 16) |		/* V front porch */
> -			 (mode->vdisplay << 0));	/* height */
> +	tc_write(HTIM01,
> +		 FIELD_PREP(HBPR, ALIGN(left_margin, 2)) |
> +		 FIELD_PREP(HPW, ALIGN(hsync_len, 2)));
> +	tc_write(HTIM02,
> +		 FIELD_PREP(HDISPR, ALIGN(mode->hdisplay, 2)) |
> +		 FIELD_PREP(HFPR, ALIGN(right_margin, 2)));
> +	tc_write(VTIM01,
> +		 FIELD_PREP(VBPR, upper_margin) |
> +		 FIELD_PREP(VSPR, vsync_len));
> +	tc_write(VTIM02,
> +		 FIELD_PREP(VFPR, lower_margin) |
> +		 FIELD_PREP(VDISPR, mode->vdisplay));
>  	tc_write(VFUEN0, VFUEN);		/* update settings */
>  
>  	/* Test pattern settings */
>  	tc_write(TSTCTL,
> -		 (120 << 24) |	/* Red Color component value */
> -		 (20 << 16) |	/* Green Color component value */
> -		 (99 << 8) |	/* Blue Color component value */
> -		 (1 << 4) |	/* Enable I2C Filter */
> -		 (2 << 0) |	/* Color bar Mode */
> -		 0);
> +		 FIELD_PREP(COLOR_R, 120) |
> +		 FIELD_PREP(COLOR_G, 20) |
> +		 FIELD_PREP(COLOR_B, 99) |
> +		 ENI2CFILTER |
> +		 FIELD_PREP(COLOR_BAR_MODE, COLOR_BAR_MODE_BARS));
>  
>  	/* DP Main Stream Attributes */
>  	vid_sync_dly = hsync_len + left_margin + mode->hdisplay;
>  	tc_write(DP0_VIDSYNCDELAY,
> -		 (max_tu_symbol << 16) |	/* thresh_dly */
> -		 (vid_sync_dly << 0));
> +		 FIELD_PREP(THRESH_DLY, max_tu_symbol) |
> +		 FIELD_PREP(VID_SYNC_DLY, vid_sync_dly));
>  
> -	tc_write(DP0_TOTALVAL, (mode->vtotal << 16) | (mode->htotal));
> +	tc_write(DP0_TOTALVAL,
> +		 FIELD_PREP(H_TOTAL, mode->htotal) |
> +		 FIELD_PREP(V_TOTAL, mode->vtotal));
>  
>  	tc_write(DP0_STARTVAL,
> -		 ((upper_margin + vsync_len) << 16) |
> -		 ((left_margin + hsync_len) << 0));
> +		 FIELD_PREP(H_START, left_margin + hsync_len) |
> +		 FIELD_PREP(V_START, upper_margin + vsync_len));
> +
> +	tc_write(DP0_ACTIVEVAL,
> +		 FIELD_PREP(V_ACT, mode->vdisplay) |
> +		 FIELD_PREP(H_ACT, mode->hdisplay));
> +
> +	dp0_syncval = FIELD_PREP(VS_WIDTH, vsync_len) |
> +		      FIELD_PREP(HS_WIDTH, hsync_len);
> +
> +	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
> +		dp0_syncval |= SYNCVAL_VS_POL_ACTIVE_LOW;
>  
> -	tc_write(DP0_ACTIVEVAL, (mode->vdisplay << 16) | (mode->hdisplay));
> +	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> +		dp0_syncval |= SYNCVAL_HS_POL_ACTIVE_LOW;
>  
> -	tc_write(DP0_SYNCVAL, (vsync_len << 16) | (hsync_len << 0) |
> -		 ((mode->flags & DRM_MODE_FLAG_NHSYNC) ? SYNCVAL_HS_POL_ACTIVE_LOW : 0) |
> -		 ((mode->flags & DRM_MODE_FLAG_NVSYNC) ? SYNCVAL_VS_POL_ACTIVE_LOW : 0));
> +	tc_write(DP0_SYNCVAL, dp0_syncval);
>  
> -	tc_write(DPIPXLFMT, VS_POL_ACTIVE_LOW | HS_POL_ACTIVE_LOW |
> -		 DE_POL_ACTIVE_HIGH | SUB_CFG_TYPE_CONFIG1 | DPI_BPP_RGB888);
> +	tc_write(DPIPXLFMT,
> +		 VS_POL_ACTIVE_LOW | HS_POL_ACTIVE_LOW |
> +		 DE_POL_ACTIVE_HIGH | SUB_CFG_TYPE_CONFIG1 |
> +		 DPI_BPP_RGB888);
>  
> -	tc_write(DP0_MISC, (max_tu_symbol << 23) | (TU_SIZE_RECOMMENDED << 16) |
> -			   BPC_8);
> +	tc_write(DP0_MISC,
> +		 FIELD_PREP(MAX_TU_SYMBOL, max_tu_symbol) |
> +		 FIELD_PREP(TU_SIZE, TU_SIZE_RECOMMENDED) |
> +		 BPC_8);
>  
>  	return 0;
>  err:


