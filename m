Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BB3C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C392087C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EUpY4vHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437621AbfIWIQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:16:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36267 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406068AbfIWIQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:16:40 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190923081637euoutp0261b06cd96e415bb01a98d95b6dc62b88~HA0bPdNS62410524105euoutp02M
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 08:16:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190923081637euoutp0261b06cd96e415bb01a98d95b6dc62b88~HA0bPdNS62410524105euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569226597;
        bh=rJetcVoZjhe5yu8zaqk9R4p8QFVoTZCo42vYfkzWAdU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=EUpY4vHwL4tvFKsDe84yomWDO4oc34G0rsqaxMieCgSFT/QXLb7WRDqQ14jutdo6d
         XVYFcFH+hhtPU07R6REeaVlHFt/iZ4pDV+rsvZEY0YU2yRUTsNZ6HU4tA3CV5BgT5J
         RXPp6ss6dBi/H02zwmJRTxgyN79mk6jhodF7n0hQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190923081637eucas1p250f7da714c920ad7048ba7d95b2803bf~HA0bCrZA40956409564eucas1p2Y;
        Mon, 23 Sep 2019 08:16:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5B.A1.04309.56F788D5; Mon, 23
        Sep 2019 09:16:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190923081637eucas1p1d166a7748daa77049b5253a3345766c9~HA0at_iaL3037830378eucas1p1H;
        Mon, 23 Sep 2019 08:16:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190923081637eusmtrp1f1c3bec4882cca4cbaad8ec2ae9b2a8d~HA0atA1wU2602926029eusmtrp17;
        Mon, 23 Sep 2019 08:16:37 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-3a-5d887f65f3fe
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8E.76.04117.56F788D5; Mon, 23
        Sep 2019 09:16:37 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190923081636eusmtip1e77cef5247ec7fb57f0c8582d7cbaade~HA0aOLyXa2739227392eusmtip1w;
        Mon, 23 Sep 2019 08:16:36 +0000 (GMT)
Subject: Re: [PATCH] drm/panel: samsung: s6e8aa0: Add backlight control
 support
To:     =?UTF-8?Q?Joonas_Kylm=c3=a4l=c3=a4?= <joonas.kylmala@iki.fi>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     paul.kocialkowski@bootlin.com, GNUtoo@cyberdimension.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <d8a8bf25-0c5e-8d94-9406-b1f74e3edfac@samsung.com>
Date:   Mon, 23 Sep 2019 10:16:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190921124843.6967-1-joonas.kylmala@iki.fi>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87qp9R2xBq2b5C16z51ksvi/bSKz
        xZWv79ksWq8/Zrf433KD3eLyrjlsFpe/9jFarPi5ldHi5655LA6cHvPWVHscPdDI7LH32wIW
        j52z7rJ7HP66kMVj+7cHrB73u48zeSyZdpXN4/MmuQDOKC6blNSczLLUIn27BK6MTRvnshTs
        0K5oX/SHsYHxkFIXIyeHhICJxIb/HaxdjFwcQgIrGCVONUyFcr4wShy5tp8NwvnMKDF/9QNm
        mJbGeY9YQWwhgeWMEqtmqUIUvWWU+PDjLRtIQlggUKJh7nF2kISIwGQmia43v9lBEswCNhJ9
        W3cygthsApoSfzffBGvgFbCT2DrlL9hUFgFVifNNz8DiogIREp8eHGaFqBGUODnzCQuIzSlg
        JbHm829GiJnyEs1bZzND2OISt57MZ4K49Ba7xMaH/BC2i8SUj/tYIWxhiVfHt7BD2DISpyf3
        sEDY9RL3V7QwgxwtIdDBKLF1w06ol60lDh+/CNTMAbRAU2L9Ln2IsKPE5TnNYGEJAT6JG28F
        IU7gk5i0bTozRJhXoqNNCKJaUeL+2a1QA8Ulll74yjaBUWkWksdmIXlmFpJnZiHsXcDIsopR
        PLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMweZ3+d/zLDsZdf5IOMQpwMCrx8H7Y2B4rxJpY
        VlyZe4hRgoNZSYR3k1ZbrBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeaoYH0UIC6YklqdmpqQWp
        RTBZJg5OqQbGZRUd8wx2nktkDy2QTZKOCzvpmDxb9wrHpKdWMTIibIxFJbw1Ph+T5GRkHvyu
        Z03a0jfTKSud/UJ6amzqjKLkmpsbDQXlDTS7t1cvWKfXwby11Fki2X9RQXfeklOvDotHm+zj
        aDtro7ikcDdbZ1r45EchLyvMPp+eoLIxQubEIc3405XH+5RYijMSDbWYi4oTAVAnXYlaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xu7qp9R2xBn0veCx6z51ksvi/bSKz
        xZWv79ksWq8/Zrf433KD3eLyrjlsFpe/9jFarPi5ldHi5655LA6cHvPWVHscPdDI7LH32wIW
        j52z7rJ7HP66kMVj+7cHrB73u48zeSyZdpXN4/MmuQDOKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MTRvnshTs0K5oX/SHsYHxkFIXIyeHhICJ
        ROO8R6xdjFwcQgJLGSWWtJxmhkiIS+ye/xbKFpb4c62LDaLoNaPE/JNvWUESwgKBEg1zj7OD
        2CICk5kktt0wArGZBWwk+rbuZIRo6GWUOPVpOyNIgk1AU+Lv5ptsIDavgJ3E1il/wQaxCKhK
        nG96BhYXFYiQOLxjFiNEjaDEyZlPWEBsTgEriTWffzNCLFCX+DPvEjOELS/RvHU2lC0ucevJ
        fKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRG7LZjP7fs
        YOx6F3yIUYCDUYmH98PG9lgh1sSy4srcQ4wSHMxKIrybtNpihXhTEiurUovy44tKc1KLDzGa
        Aj03kVlKNDkfmEzySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUw
        1tbO27Pf5GFNttkdvZ3xOey1ksGalocan9t2swndzbL+NfHk98SAb7Z52v3ujxh+Tgm2O5R3
        6YYr+9cJ54/YsuS9+jRh6vItpVXlfmecY613iHoe+/rjW0g6n/WxGN6EudnHuy2n6Rl0cL6J
        rnQ5xr6BleNUBpsd70um8MJTifMl7Z+xcBQpsRRnJBpqMRcVJwIA/M6+I+4CAAA=
X-CMS-MailID: 20190923081637eucas1p1d166a7748daa77049b5253a3345766c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190921125017epcas3p2f5661cca04f0959f9707f6111102435d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190921125017epcas3p2f5661cca04f0959f9707f6111102435d
References: <CGME20190921125017epcas3p2f5661cca04f0959f9707f6111102435d@epcas3p2.samsung.com>
        <20190921124843.6967-1-joonas.kylmala@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joonas,


On 21.09.2019 14:48, Joonas Kylmälä wrote:
> This makes the backlight brightness controllable from the
> userspace.
>
> Signed-off-by: Joonas Kylmälä <joonas.kylmala@iki.fi>
> ---
>  drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c | 82 ++++++++++++++++++++-------
>  1 file changed, 60 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
> index dbced6501204..aa75934f5bed 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
> @@ -10,8 +10,12 @@
>   * Eunchul Kim <chulspro.kim@samsung.com>
>   * Tomasz Figa <t.figa@samsung.com>
>   * Andrzej Hajda <a.hajda@samsung.com>
> + *
> + * Derived from panel-samsung-s6e63m0.c:
> + *  Copyright (C) 2019 Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
>  */
>  
> +#include <linux/backlight.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/module.h>
> @@ -85,6 +89,8 @@
>  #define AID_2				(0x6)
>  #define AID_3				(0x7)
>  
> +#define MAX_BRIGHTNESS (GAMMA_LEVEL_NUM - 1)
> +
>  typedef u8 s6e8aa0_gamma_table[GAMMA_TABLE_LEN];
>  
>  struct s6e8aa0_variant {
> @@ -95,6 +101,7 @@ struct s6e8aa0_variant {
>  struct s6e8aa0 {
>  	struct device *dev;
>  	struct drm_panel panel;
> +	struct backlight_device *bl_dev;
>  
>  	struct regulator_bulk_data supplies[2];
>  	struct gpio_desc *reset_gpio;
> @@ -110,7 +117,6 @@ struct s6e8aa0 {
>  	u8 version;
>  	u8 id;
>  	const struct s6e8aa0_variant *variant;
> -	int brightness;
>  
>  	/* This field is tested by functions directly accessing DSI bus before
>  	 * transfer, transfer is skipped if it is set. In case of transfer
> @@ -321,9 +327,10 @@ static void s6e8aa0_etc_elvss_control(struct s6e8aa0 *ctx)
>  
>  static void s6e8aa0_elvss_nvm_set_v142(struct s6e8aa0 *ctx)
>  {
> +	struct backlight_device *bd = ctx->bl_dev;
>  	u8 br;
>  
> -	switch (ctx->brightness) {
> +	switch (bd->props.brightness) {
>  	case 0 ... 6: /* 30cd ~ 100cd */
>  		br = 0xdf;
>  		break;
> @@ -762,24 +769,6 @@ static const struct s6e8aa0_variant s6e8aa0_variants[] = {
>  	}
>  };
>  
> -static void s6e8aa0_brightness_set(struct s6e8aa0 *ctx)
> -{
> -	const u8 *gamma;
> -
> -	if (ctx->error)
> -		return;
> -
> -	gamma = ctx->variant->gamma_tables[ctx->brightness];
> -
> -	if (ctx->version >= 142)
> -		s6e8aa0_elvss_nvm_set(ctx);
> -
> -	s6e8aa0_dcs_write(ctx, gamma, GAMMA_TABLE_LEN);
> -
> -	/* update gamma table. */
> -	s6e8aa0_dcs_write_seq_static(ctx, 0xf7, 0x03);
> -}
> -
>  static void s6e8aa0_panel_init(struct s6e8aa0 *ctx)
>  {
>  	s6e8aa0_apply_level_1_key(ctx);
> @@ -791,7 +780,7 @@ static void s6e8aa0_panel_init(struct s6e8aa0 *ctx)
>  
>  	s6e8aa0_panel_cond_set(ctx);
>  	s6e8aa0_display_condition_set(ctx);
> -	s6e8aa0_brightness_set(ctx);
> +	backlight_enable(ctx->bl_dev);
>  	s6e8aa0_etc_source_control(ctx);
>  	s6e8aa0_etc_pentile_control(ctx);
>  	s6e8aa0_elvss_nvm_set(ctx);
> @@ -974,6 +963,53 @@ static int s6e8aa0_parse_dt(struct s6e8aa0 *ctx)
>  	return 0;
>  }
>  
> +static int s6e8aa0_set_brightness(struct backlight_device *bd)
> +{
> +	struct s6e8aa0 *ctx = bl_get_data(bd);
> +	const u8 *gamma;
> +
> +	if (ctx->error)
> +		return;
> +
> +	gamma = ctx->variant->gamma_tables[bd->props.brightness];
> +
> +	if (ctx->version >= 142)
> +		s6e8aa0_elvss_nvm_set(ctx);
> +
> +	s6e8aa0_dcs_write(ctx, gamma, GAMMA_TABLE_LEN);
> +
> +	/* update gamma table. */
> +	s6e8aa0_dcs_write_seq_static(ctx, 0xf7, 0x03);
> +
> +	return s6e8aa0_clear_error(ctx);
> +}
> +
> +static const struct backlight_ops s6e8aa0_backlight_ops = {
> +	.update_status	= s6e8aa0_set_brightness,


This is racy, update_status can be called in any time between probe and
remove, particularly:

a) before panel enable,

b) during panel enable,

c) when panel is enabled,

d) during panel disable,

e) after panel disable,


b and d are racy for sure - backlight and drm callbacks are async.

IMO the best solution would be to register backlight after attaching
panel to drm, but for this drm_panel_funcs should have attach/detach
callbacks (like drm_bridge_funcs),

then update_status callback should take some drm_connector lock to
synchronize with drm, and write to hw only when pipe is enabled.


Regards

Andrzej



> +};
> +
> +static int s6e8aa0_backlight_register(struct s6e8aa0 *ctx)
> +{
> +	struct backlight_properties props = {
> +		.type		= BACKLIGHT_RAW,
> +		.brightness	= MAX_BRIGHTNESS,
> +		.max_brightness = MAX_BRIGHTNESS
> +	};
> +	struct device *dev = ctx->dev;
> +	int ret = 0;
> +
> +	ctx->bl_dev = devm_backlight_device_register(dev, "panel", dev, ctx,
> +						     &s6e8aa0_backlight_ops,
> +						     &props);
> +	if (IS_ERR(ctx->bl_dev)) {
> +		ret = PTR_ERR(ctx->bl_dev);
> +		DRM_DEV_ERROR(dev, "error registering backlight device (%d)\n",
> +			      ret);
> +	}
> +
> +	return ret;
> +}
> +
>  static int s6e8aa0_probe(struct mipi_dsi_device *dsi)
>  {
>  	struct device *dev = &dsi->dev;
> @@ -1015,7 +1051,9 @@ static int s6e8aa0_probe(struct mipi_dsi_device *dsi)
>  		return PTR_ERR(ctx->reset_gpio);
>  	}
>  
> -	ctx->brightness = GAMMA_LEVEL_NUM - 1;
> +	ret = s6e8aa0_backlight_register(ctx);
> +	if (ret < 0)
> +		return ret;
>  
>  	drm_panel_init(&ctx->panel, dev, &s6e8aa0_drm_funcs,
>  		       DRM_MODE_CONNECTOR_DSI);


