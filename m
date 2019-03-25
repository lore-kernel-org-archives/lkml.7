Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6819C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5772087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JlDusdM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbfCYLhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:37:11 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34185 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730893AbfCYLhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:37:07 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190325113704euoutp01495ad82e6b7f64019a2e0cbc9ce0d996~PMJfH_-BL2601726017euoutp017
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:37:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190325113704euoutp01495ad82e6b7f64019a2e0cbc9ce0d996~PMJfH_-BL2601726017euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1553513824;
        bh=/sfpTrnXm1ev+2Q5CfQhERKPxPBrDD/nNA0BG9VaNzo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JlDusdM6ImeplLbWzhvA6U8Gx8M+H0i3fuec9uXaqQqnkK1XoI8tZP0Mbb0AEvqxr
         SOyxRBaGMzTmgC8xYjvbrArOCrjfLt7fDZH1k8wpNj16eKoeCZIUHpBEX+lKZO+EYK
         pUtd1btjSKPavo95PviWGXq/4G1NcqH5HlUONrMk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190325113704eucas1p2a40bb32ebf39bf93d1d50ad2ce2e8194~PMJekFgT81324213242eucas1p2e;
        Mon, 25 Mar 2019 11:37:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 68.2A.04325.F5DB89C5; Mon, 25
        Mar 2019 11:37:03 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190325113703eucas1p1e7cb22f691c3fdc428c643237cf2c7a3~PMJdtC3i40487604876eucas1p1N;
        Mon, 25 Mar 2019 11:37:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190325113703eusmtrp2d55a837999d38dff2750b7dc3026af90~PMJdfGX-O2685526855eusmtrp2N;
        Mon, 25 Mar 2019 11:37:03 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-d2-5c98bd5fd2d2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0A.A3.04146.F5DB89C5; Mon, 25
        Mar 2019 11:37:03 +0000 (GMT)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190325113702eusmtip24b60d3cc42230cafdb061ea09fc24b95~PMJdExWvu0624406244eusmtip2Y;
        Mon, 25 Mar 2019 11:37:02 +0000 (GMT)
Subject: Re: [PATCH] drm/bridge: dw-hdmi: disable SCDC configuration for
 invalid setups
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent.pinchart@ideasonboard.com, heiko@sntech.de, robh@kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@siol.net
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <6faa365e-2a4d-3666-b00f-79f36258106c@samsung.com>
Date:   Mon, 25 Mar 2019 12:37:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190315095414.28520-1-narmstrong@baylibre.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djP87rxe2fEGBw4Ym1x5et7Nov/j16z
        Wlz9/pLZonPiEnaLBbO5LS7vmsNm8enBf2aLQ33RFv/37GB34PR4f6OV3WN2x0xWj02rOtk8
        7ncfZ/LYvKTe40DvZBaP7dfmMXt83iQXwBHFZZOSmpNZllqkb5fAlfHl9BnGgq9yFbtfz2Rq
        YHwi0cXIySEhYCKxfO0F9i5GLg4hgRWMEj27zrBAOF8YJXaeuA2V+cwo8XvVeXaYlhWNh5kh
        EssZJT62H4By3jJKzJt7kBWkSlggUuLIlKMsILaIQLHE8T8vmECKmAWWMkq8f9wCVsQmoCnx
        d/NNNhCbV8BO4tzOvWA2i4CqROPvRWC2qECExPunu1kgagQlTs58AmZzCthKrHy7nhHEZhaQ
        l2jeOpsZwhaXuPVkPtgyCYFz7BLTTjYCLeMAclwklnzXg3hBWOLV8S1Q78hI/N8JUg9i10vc
        X9HCDNHbwSixdcNOZoiEtcTh4xfB5jADHb1+lz5E2FHi/OFlzBDj+SRuvBWEOIFPYtK26VBh
        XomONiGIakWJ+2e3Qg0Ul1h64SvbBEalWUgem4XkmVlInpmFsHcBI8sqRvHU0uLc9NRi47zU
        cr3ixNzi0rx0veT83E2MwIR1+t/xrzsY9/1JOsQowMGoxMP7Yuf0GCHWxLLiytxDjBIczEoi
        vE9EZ8QI8aYkVlalFuXHF5XmpBYfYpTmYFES561meBAtJJCeWJKanZpakFoEk2Xi4JRqYNxV
        e5nrowHPY06Tx7IJDzcUu/mWJnMsn3XK3vXp/laeC2u7NR4rJsfvVLx8Y2u62oImhfORZl87
        D/+OjHDMWi/G1XPsNeeqgMYjEttN/Qq8VKzkZs59W/BRwW1XwEYdld1hD7g6hRp8eM+YL2yP
        9lD2/b7u4VXOadfeRu2pkLO4ynom9J5ykRJLcUaioRZzUXEiALTUktJUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7rxe2fEGCy6yWZx5et7Nov/j16z
        Wlz9/pLZonPiEnaLBbO5LS7vmsNm8enBf2aLQ33RFv/37GB34PR4f6OV3WN2x0xWj02rOtk8
        7ncfZ/LYvKTe40DvZBaP7dfmMXt83iQXwBGlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqln
        aGwea2VkqqRvZ5OSmpNZllqkb5egl/Hl9BnGgq9yFbtfz2RqYHwi0cXIySEhYCKxovEwcxcj
        F4eQwFJGick/VrNBJMQlds9/ywxhC0v8udbFBlH0mlFi2pSdYAlhgUiJI1OOsoDYIgLFEgdW
        bGAFKWIGmTT/6D2ojgmMEqeONzOBVLEJaEr83XwTbAWvgJ3EuZ17wWwWAVWJxt+LwGxRgQiJ
        uxdfsEDUCEqcnPkEzOYUsJVY+XY9I4jNLKAu8WfeJWYIW16ieetsKFtc4taT+UwTGIVmIWmf
        haRlFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM0m3Hfm7ewXhpY/AhRgEO
        RiUeXoc902OEWBPLiitzDzFKcDArifA+EZ0RI8SbklhZlVqUH19UmpNafIjRFOi5icxSosn5
        wASSVxJvaGpobmFpaG5sbmxmoSTOe96gMkpIID2xJDU7NbUgtQimj4mDU6qBUYmpZqHB68f5
        4h9z5mRcXa7wseRyUt5e3ieXlZh/tl8Q9WG78sRu82d2ly1njrBeZ87IWBpqEvC4RNgr49NF
        25tXkpgqPlm9E5y5y2nm/DNRuWurZM6ucnBqDPxe+D5beI3x4etthaxLdJ/7p1nuPv3XI69X
        dmugjHiu36+mWt4HLXk9mi4tSizFGYmGWsxFxYkAnsoayegCAAA=
X-CMS-MailID: 20190325113703eucas1p1e7cb22f691c3fdc428c643237cf2c7a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190315095421epcas4p3321555f6918dc4e420acdbf23121338f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190315095421epcas4p3321555f6918dc4e420acdbf23121338f
References: <CGME20190315095421epcas4p3321555f6918dc4e420acdbf23121338f@epcas4p3.samsung.com>
        <20190315095414.28520-1-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2019 10:54, Neil Armstrong wrote:
> This patch is an attempt to limit HDMI 2.0 SCDC setup when :
> - the SoC embeds an HDMI 1.4 only controller
> - the EDID supports SCDC but not scrambling
> - the EDID supports SCDC scrambling but not for low TMDS bit rates,
>   while only supporting low TMDS bit rates
>
> This to avoid communicating with the SCDC DDC slave uncessary, and
> setting the DW-HDMI TMDS Scrambler setup when not supported by the
> underlying hardware.
>
> Reported-by: Rob Herring <robh@kernel.org>
> Fixes: 264fce6cc2c1 ("drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>
> Rob,
>
> this patch should also solve your issue with your 11' display, could you
> test it ?
> If this works, I will focus on the underlying issue where the RK3399 SoC
> freezes in your setup.
>
> Thanks,
> Neil
>
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 34 ++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index a63e5f0dae56..db761329a1e3 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1037,6 +1037,31 @@ void dw_hdmi_phy_i2c_write(struct dw_hdmi *hdmi, unsigned short data,
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_phy_i2c_write);
>  
> +/* Filter out invalid setups to avoid configuring SCDC and scrambling */
> +static bool dw_hdmi_support_scdc(struct dw_hdmi *hdmi)
> +{
> +	struct drm_display_info *display = &hdmi->connector.display_info;
> +
> +	/* Completely disable SCDC support for older controllers */
> +	if (hdmi->version < 0x200a)
> +		return false;
> +
> +	/* Disable if SCDC is not supported, or if an HF-VSDB block is absent */
> +	if (!display->hdmi.scdc.supported ||
> +	    !display->hdmi.scdc.scrambling.supported)
> +		return false;
> +
> +	/*
> +	 * Disable if display only support low TMDS rates and scrambling
> +	 * for low rates is not supported either
> +	 */
> +	if (!display->hdmi.scdc.scrambling.low_rates &&
> +	    display->max_tmds_clock <= 340000)
> +		return false;
> +
> +	return true;
> +}
> +
>  /*
>   * HDMI2.0 Specifies the following procedure for High TMDS Bit Rates:
>   * - The Source shall suspend transmission of the TMDS clock and data
> @@ -1055,7 +1080,7 @@ void dw_hdmi_set_high_tmds_clock_ratio(struct dw_hdmi *hdmi)
>  	unsigned long mtmdsclock = hdmi->hdmi_data.video_mode.mtmdsclock;
>  
>  	/* Control for TMDS Bit Period/TMDS Clock-Period Ratio */
> -	if (hdmi->connector.display_info.hdmi.scdc.supported) {
> +	if (dw_hdmi_support_scdc(hdmi)) {
>  		if (mtmdsclock > HDMI14_MAX_TMDSCLK)
>  			drm_scdc_set_high_tmds_clock_ratio(hdmi->ddc, 1);
>  		else
> @@ -1579,8 +1604,9 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>  
>  	/* Set up HDMI_FC_INVIDCONF */
>  	inv_val = (hdmi->hdmi_data.hdcp_enable ||
> -		   vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
> -		   hdmi_info->scdc.scrambling.low_rates ?
> +		   (dw_hdmi_support_scdc(hdmi) &&
> +		    (vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
> +		     hdmi_info->scdc.scrambling.low_rates)) ?
>  		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_ACTIVE :
>  		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_INACTIVE);


The condition is hard to read, but I have no idea atm how make it
compact and pretty :)

Anyway:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>


As I remember you can queue it to drm-misc, if not I can do it, just let
me know.


 --
Regards
Andrzej



>  
> @@ -1646,7 +1672,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>  	}
>  
>  	/* Scrambling Control */
> -	if (hdmi_info->scdc.supported) {
> +	if (dw_hdmi_support_scdc(hdmi)) {
>  		if (vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
>  		    hdmi_info->scdc.scrambling.low_rates) {
>  			/*


