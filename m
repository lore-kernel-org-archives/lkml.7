Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FF3C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73039217F4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.net header.i=@jaseg.net header.b="tFXYp5+D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mkYbFRki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfHJFRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 01:17:15 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:44133 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbfHJFRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 01:17:14 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 02CCD558;
        Sat, 10 Aug 2019 01:17:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 10 Aug 2019 01:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.net; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=T
        LKyPNFTsFZjFD5Cr/7Cre9egz8NoqCwoZLt4puyBJE=; b=tFXYp5+DPG8iNQeyE
        BBRQZZxMl+6qafobzbg/5E1c/C/jKA3xW0LBN1RKPIWbByAEwlfmXAs1k0vei4rV
        6t4mZ8Zd8sv5kG7S04c52vczT/aHj6xhrgC8cIsu2Smdrrd2qovtL4vQvOfuU2GB
        eG7/ZOde6VfKHp6YZYtAuY47m89JyyCk+wLmvDFhPubRK8OeP4xWE3pxQvD+5Fhp
        Id/8afpIEAjClRSO4ZOFE+8K8xM7qj6YrXGKMoGVdD6fg8qDxGhjTAVlyvL8K2XD
        z6TqfI1bJ+SOVfGoCYwhJNG6S1PqV39E8PEVuFcRhlfwnUyEuma2gJiFPKB2GM+C
        OSx7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=TLKyPNFTsFZjFD5Cr/7Cre9egz8NoqCwoZLt4puyB
        JE=; b=mkYbFRkiHlbE3Aedt/y7fbg5aAahol580ZkKuqQE5juraz24gPeTsnASU
        L9KjzfRCAb7UVbAuLEkMyl2yYhcTC/p3wGJt0q5/uw/TLinoOtcIYHOJ6bBcbLyR
        j608EB7pfRkK0t6UE95G5NLJ+qm3EsYati4hMxCmueAO1XTvMPBYBKtzbAp1/cT2
        bUw4b8rtdloWy1k+5DweyqpxlE+QNb/4gaZT2ijmnt1EgbPdKh56iughZF6e8hrh
        0h5OZtDxUQmckZVvSNVCi4GwrP9GshEnXmzzJZqWI06j3+294OW4extnDldSAaXK
        a6zcPHqvRixR6YUnkfyPHtpH5ZIGg==
X-ME-Sender: <xms:VVNOXW-1owb8VEeJc0OqzmekYfQBs9k3Zk741bxFDfzp4Yfsl5AoCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddukedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomheplfgrnhgp
    ufgvsggrshhtihgrnhgpifpnthhtvgcuoehlihhnuhigsehjrghsvghgrdhnvghtqeenuc
    ffohhmrghinhepfhhrvggvuggvshhkthhophdrohhrghenucfkphepiedtrdejuddrieef
    rdejheenucfrrghrrghmpehmrghilhhfrhhomheplhhinhhugiesjhgrshgvghdrnhgvth
    enucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:VVNOXW17m3d6V1OcPod5QW_J38jZ3uwZtwBJytwIrwGr0UgtoQOvsA>
    <xmx:VVNOXT-FZlpYqvi0eJeMDvMzkb95fV18xv71hn6A9wFnWHnfvQE8MA>
    <xmx:VVNOXWsWoHSvneIDHyjemrct3K2KIXQyue5hX5vcWgO_QbRRNSbVzw>
    <xmx:VlNOXUtNhyO_UZk2JMy0uKZDvmtB4CirJ_hB87q7LyUKZY9BNo0XSg>
Received: from [10.137.0.16] (softbank060071063075.bbtec.net [60.71.63.75])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3738880059;
        Sat, 10 Aug 2019 01:17:08 -0400 (EDT)
Subject: Re: [PATCH 6/6] drm: tiny: gdepaper: add driver for 2/3 color epaper
 displays
To:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org
References: <95b64347-fbc8-ba3d-79da-9de2557ff95e@jaseg.net>
 <604c82ee-af16-5f34-b229-5e919c4adfdc@tronnes.org>
From:   =?UTF-8?Q?Jan_Sebastian_G=c3=b6tte?= <linux@jaseg.net>
Message-ID: <7ebf06e2-fe24-a4fb-25ff-77ce1ee3ae16@jaseg.net>
Date:   Sat, 10 Aug 2019 14:17:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <604c82ee-af16-5f34-b229-5e919c4adfdc@tronnes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Noralf,

thank you for your comments. I've incorporated your suggestions into my draft.

On 8/7/19 1:06 AM, Noralf Trønnes wrote:
[...]

>> +static int gdepaper_probe(struct spi_device *spi)
>> +{
>> +	struct device *dev = &spi->dev;
>> +	struct device_node *np = dev->of_node;
>> +	const struct of_device_id *of_id;
>> +	struct drm_device *drm;
>> +	struct drm_display_mode *mode;
>> +	struct gdepaper *epap;
>> +	const struct gdepaper_type_descriptor *type_desc;
>> +	int ret;
>> +	size_t bufsize;
>> +
>> +	of_id = of_match_node(gdepaper_of_match, np);
>> +	if (WARN_ON(of_id == NULL)) {
>> +		dev_warn(dev, "dt node didn't match, aborting probe\n");
>> +		return -EINVAL;
>> +	}
>> +	type_desc = of_id->data;
>> +
>> +	dev_dbg(dev, "Probing gdepaper module\n");
>> +	epap = kzalloc(sizeof(*epap), GFP_KERNEL);
>> +	if (!epap)
>> +		return -ENOMEM;
>> +
>> +	epap->enabled = false;
>> +	mutex_init(&epap->cmdlock);
>> +	epap->tx_buf = NULL;
>> +	epap->spi = spi;
>> +
>> +	drm = &epap->drm;
>> +	ret = devm_drm_dev_init(dev, drm, &gdepaper_driver);
>> +	if (ret) {
>> +		dev_warn(dev, "failed to init drm dev\n");
>> +		goto err_free;
>> +	}
>> +
>> +	drm_mode_config_init(drm);
>> +
>> +	epap->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>> +	if (IS_ERR(epap->reset)) {
>> +		dev_err(dev, "Failed to get reset GPIO\n");
>> +		ret = PTR_ERR(epap->reset);
>> +		goto err_free;
>> +	}
>> +
>> +	epap->busy = devm_gpiod_get(dev, "busy", GPIOD_IN);
>> +	if (IS_ERR(epap->busy)) {
>> +		dev_err(dev, "Failed to get busy GPIO\n");
>> +		ret = PTR_ERR(epap->busy);
>> +		goto err_free;
>> +	}
>> +
>> +	epap->dc = devm_gpiod_get(dev, "dc", GPIOD_OUT_LOW);
>> +	if (IS_ERR(epap->dc)) {
>> +		dev_err(dev, "Failed to get dc GPIO\n");
>> +		ret = PTR_ERR(epap->dc);
>> +		goto err_free;
>> +	}
>> +
>> +	epap->spi_speed_hz = 2000000;
>> +	epap->pll_div = 1;
>> +	epap->framerate_mHz = 81850;
>> +	epap->rfp.vg_lv = GDEP_PWR_VGHL_16V;
>> +	epap->rfp.vcom_sel = 0;
>> +	epap->rfp.vdh_bw_mv = 11000; /* drive high level, b/w pixel */
>> +	epap->rfp.vdh_col_mv = 4200; /* drive high level, red/yellow pixel */
>> +	epap->rfp.vdl_mv = -11000; /* drive low level */
>> +	epap->rfp.border_data_sel = 2; /* "vbd" */
>> +	epap->rfp.data_polarity = 0; /* "ddx" */
>> +	epap->rfp.vcom_dc_mv = -1000;
>> +	epap->rfp.vcom_data_ivl_hsync = 10; /* hsync periods */
>> +	epap->rfp.use_otp_luts_flag = 1;
>> +	epap->ss_param[0] = 0x07;
>> +	epap->ss_param[1] = 0x07;
>> +	epap->ss_param[2] = 0x17;
>> +	epap->controller_res = GDEP_CTRL_RES_320X300;
>> +
>> +	ret = gdepaper_of_read_luts(epap, np, dev);
>> +	if (ret) {
>> +		dev_warn(dev, "can't read LUTs from dt\n");
>> +		goto err_free;
>> +	}
>> +
>> +	of_property_read_u32(np, "controller-resolution",
>> +			&epap->controller_res);
>> +	of_property_read_u32(np, "spi-speed-hz", &epap->spi_speed_hz);
>> +	epap->partial_update_en = of_property_read_bool(np, "partial-update");
>> +	ret = of_property_read_u32(np, "colors", &epap->display_colors);
>> +	if (ret == -EINVAL) {
>> +		if (type_desc) {
>> +			epap->display_colors = type_desc->colors;
>> +
>> +		} else {
>> +			dev_err(dev, "colors must be set in dt\n");
>> +			ret = -EINVAL;
>> +			goto err_free;
>> +		}
>> +	} else if (ret) {
>> +		dev_err(dev, "Invalid dt colors property\n");
>> +		goto err_free;
>> +	}
>> +	if (epap->display_colors < 0 ||
>> +			epap->display_colors >= GDEPAPER_COL_END) {
>> +		dev_err(dev, "invalid colors value\n");
>> +		ret = -EINVAL;
>> +		goto err_free;
>> +	}
>> +	epap->mirror_x = of_property_read_bool(np, "mirror-x");
>> +	epap->mirror_y = of_property_read_bool(np, "mirror-y");
>> +	of_property_read_u32(np, "pll-div", &epap->pll_div);
>> +	of_property_read_u32(np, "fps-millihertz", &epap->framerate_mHz);
>> +	of_property_read_u32(np, "vghl-level", &epap->rfp.vg_lv);
>> +	epap->vds_en = !of_property_read_bool(np, "vds-external");
>> +	epap->vdg_en = !of_property_read_bool(np, "vdg-external");
>> +	of_property_read_u32(np, "vcom", &epap->rfp.vcom_sel);
>> +	of_property_read_u32(np, "vdh-bw-millivolts", &epap->rfp.vdh_bw_mv);
>> +	of_property_read_u32(np, "vdh-color-millivolts", &epap->rfp.vdh_col_mv);
>> +	of_property_read_u32(np, "vdl-millivolts", &epap->rfp.vdl_mv);
>> +	of_property_read_u32(np, "border-data", &epap->rfp.border_data_sel);
>> +	of_property_read_u32(np, "data-polarity", &epap->rfp.data_polarity);
>> +	ret = of_property_read_u8_array(np, "boost-soft-start",
>> +			(u8 *)&epap->ss_param, sizeof(epap->ss_param));
>> +	if (ret && ret != -EINVAL)
>> +		dev_err(dev, "invalid boost-soft-start value, ignoring\n");
>> +	of_property_read_u32(np, "vcom-data-interval-periods",
>> +			&epap->rfp.vcom_data_ivl_hsync);
> 
> Why do you need these DT properties when you define compatibles for all
> the panels, can't you include these settings in the type descriptor?
	I allowed for these to be overridden in case there is some panel that's not listed on the mfg's (quite chaotic) website. Looking at this some more I think I'll remove some of these though.

I'll leave vds-external/vgs-external since they depend on circuitry around the panel and thus should be in DT. boost-soft-start is largely undocumented and I don't know what they might be useful for, but I feel it could depend on the booster inductors and voltage regulator connected to the panel, so it should be in DT.

Those ending up in the refresh params struct are refresh-related and thus application-specific. Most of these come with probably sane defaults, so to initialize a display at a minimum you only need either the type (compatible=gdew...) or the dimensions (px, mm) and color scheme.

>> +
>> +	/* Accept both positive and negative notation */
>> +	if (epap->rfp.vdl_mv < 0)
>> +		epap->rfp.vdl_mv = -epap->rfp.vdl_mv;
>> +	if (epap->rfp.vcom_dc_mv < 0)
>> +		epap->rfp.vcom_dc_mv = -epap->rfp.vcom_dc_mv;
>> +
>> +	/* (from mipi-dbi.c:)
>> +	 * Even though it's not the SPI device that does DMA (the master does),
>> +	 * the dma mask is necessary for the dma_alloc_wc() in
>> +	 * drm_gem_cma_create(). The dma_addr returned will be a physical
>> +	 * address which might be different from the bus address, but this is
>> +	 * not a problem since the address will not be used.
>> +	 * The virtual address is used in the transfer and the SPI core
>> +	 * re-maps it on the SPI master device using the DMA streaming API
>> +	 * (spi_map_buf()).
>> +	 */
>> +	if (!dev->coherent_dma_mask) {
>> +		ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
>> +		if (ret) {
>> +			dev_warn(dev, "Failed to set dma mask %d\n", ret);
>> +			goto err_free;
>> +		}
>> +	}
>> +
>> +	mode = gdepaper_of_read_mode(type_desc, np, dev);
>> +	if (IS_ERR(mode)) {
>> +		dev_warn(dev, "Failed to read mode: %ld\n", PTR_ERR(mode));
>> +		ret = PTR_ERR(mode);
>> +		goto err_free;
>> +	}
>> +
>> +	/* 8 pixels per byte, bit-packed */
>> +	bufsize = (mode->vdisplay * mode->hdisplay + 7)/8;
> 
> DIV_ROUND_UP(mode->vdisplay * mode->hdisplay, 8)
> 
>> +	epap->tx_buf = devm_kmalloc(drm->dev, bufsize, GFP_KERNEL);
>> +	if (!epap->tx_buf) {
>> +		ret = -ENOMEM;
>> +		goto err_free;
>> +	}
>> +
>> +	/* TODO rotation support? */
>> +	ret = tinydrm_display_pipe_init(drm, &epap->pipe, &gdepaper_pipe_funcs,
>> +					DRM_MODE_CONNECTOR_VIRTUAL,
>> +					gdepaper_formats,
>> +					ARRAY_SIZE(gdepaper_formats), mode, 0);
> 
> tinydrm_display_pipe_init() is gone now, here's how I replaced it in the
> other e-ink driver:
> 
> drm/tinydrm/repaper: Don't use tinydrm_display_pipe_init()
> https://cgit.freedesktop.org/drm/drm-misc/commit?id=1321db837549a0ff9dc2c95ff76c46770f7f02a1
Thank you. I found an almost identical solution.

- Jan
