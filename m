Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6968C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A3F2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="YTFazYQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387789AbfHFQHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:07:08 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:52709 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732239AbfHFQHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=dWMFeRy54Lui6Y/c/YyC3vFN5RldG/lCHvtJ/4e0SBQ=;
        b=YTFazYQjtk8Mqbgn2ikG7C9W4UsjQdkZOegBRK6dBW4UsRNZGMq3Ccz2becr4vgm9FqsnN2PI6VvnbpBe9KOURiFgqNfX3kzMmKuasKS/Lbef5QgyFoRfGqXK0wtm8vgaB+kjEqXJz4zPLC73CqUI4oDji0WRp6qGlbQKNM8ZOgx+shuQ2/DR2raONLpjhFJWVrEQCQeiE+1J+OGGfD5kUqwq0/VTikqdAeFpkx9m6cJfjVYT9T5UiLIR3P2TQn+UhRGybMgG0jjx3DZZw/OmRffM9+LizEGW2/PjPdqM5sC/upv9DZouFAel6YVHwPGBtM5jNH9KQCpAiDuwVkUjA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:56958 helo=[192.168.10.173])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hv1zK-0006ez-Pw; Tue, 06 Aug 2019 18:07:02 +0200
Subject: Re: [PATCH 6/6] drm: tiny: gdepaper: add driver for 2/3 color epaper
 displays
To:     =?UTF-8?Q?Jan_Sebastian_G=c3=b6tte?= <linux@jaseg.net>,
        dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org
References: <95b64347-fbc8-ba3d-79da-9de2557ff95e@jaseg.net>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <604c82ee-af16-5f34-b229-5e919c4adfdc@tronnes.org>
Date:   Tue, 6 Aug 2019 18:06:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <95b64347-fbc8-ba3d-79da-9de2557ff95e@jaseg.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

A couple of drive by comments:

Den 30.07.2019 15.48, skrev Jan Sebastian Götte:
> These ePaper displays are made in b/w, b/w/red and b/w/yellow variations
> by Good Display (www.e-paper-display.com) and sold on breakout boards by
> waveshare (waveshare.com).
> 
> This driver was tested against a 2.7" b/w/r display (IL91874 driver) as
> well as 4.2" b/w/r display (IL0389 driver) but can probably be
> configured for other displays using only a single COG driver die (i.e.
> any model except for their largest 12.5" model).
> 
> Through tinydrm this driver presents a standard XRGB8888 or RGB565
> framebuffer device to userspace and internally converts RGB colors to
> the epaper's colors. RGB565 support is provided for compatibility with
> anything expecting a small-size TFT LCD whose drivers often support
> RGB565.
> 
> For userspace, the most notable difference between these epaper displays
> and more traditional TFT LCDs besides their limited color space is their
> enormously long refresh times-about 5s for a b/w display and >15s for
> b/w/r and b/w/y.
> 
> This driver uses the display's "4-line SPI" interface (~CS, SCK, MOSI,
> BUSY) and does not support the bi-directional "3-line SPI" interface
> since target support for bidirectional SPI is going to be patchy. This
> means it can't read the display drivers factory-programmed ROM to
> automatically recognize the display's model, resolution or color
> configuration. This information must be provided from the device tree,
> either with a compatible="" section containing the display's model or
> through manual configuration of its various parameters. See the device
> tree doc file for details.
> 
> We name this driver "gdepaper" instead of naming it after the driver
> IC's part number since Good Display seems to be using a large number of
> mutually compatible distinct variations of the same driver IC, named
> using several different numbering schemes. Our plan is to add this
> generic driver, and to provide support for individual chips' quirks as
> they are discovered.
> 
> This driver uses four ioctls:
> * Force full display refresh, which may be needed since some epaper
>   displays need to be refreshed periodically (every few minutes to
>   hours) or the image degrades. This ioctl allows a user program to
>   trigger this hardware refresh from the epapers internal frame buffer
>   without need for a full redraw.
> * Get/set refresh params, which controls the display's waveform LUTs and
>   voltage levels.  This is necessary in case a user wants to tune paint/
>   refresh performance to their particular content and temperature.  In
>   particular for acceptable-quality partial refresh on BWR/BWY panels
>   this is essential.
> * Enable partial mode, which enables partial update and refresh on fb
>   updates. By default this is disabled since careful LUT tuning is
>   required for this to not look terrible. Also not all content is suited
>   to this mode of operation.
> 
> Tested-by: Jan Sebastian Götte <linux@jaseg.net>

No need for this, it's assumed that you have tested your own driver ;-)

> Signed-off-by: Jan Sebastian Götte <linux@jaseg.net>
> ---
>  drivers/gpu/drm/tinydrm/gdepaper.c        | 1262 +++++++++++++++++++++
>  drivers/gpu/drm/tinydrm/gdepaper_models.h |  157 +++
>  2 files changed, 1419 insertions(+)
>  create mode 100644 drivers/gpu/drm/tinydrm/gdepaper.c
>  create mode 100644 drivers/gpu/drm/tinydrm/gdepaper_models.h
> 
> diff --git a/drivers/gpu/drm/tinydrm/gdepaper.c b/drivers/gpu/drm/tinydrm/gdepaper.c

<snip>

> +static int gdepaper_spi_transfer_cstoggle(struct gdepaper *epap, u8 *data,
> +					  size_t len)
> +{
> +	int i, ret = 0;
> +
> +	for (i = 0; i < len; i++) {
> +		ret = tinydrm_spi_transfer(epap->spi, epap->spi_speed_hz,
> +					   NULL, 8, &data[i], 1);

tinydrm_spi_transfer() is gone now, but you can use spi_write() here. It
will run the transfer at ->max_speed_hz. The reason for
tinydrm_spi_transfer() to have a speed argument, is that some display
controllers can run pixel transfers at a higher speed than the commands,
hence the need to override and run commands at a lower speed.

> +		if (ret)
> +			return ret;
> +		udelay(1); /* FIXME necessary? */
> +	}
> +
> +	return ret;
> +}

<snip>

> +static void gdepaper_fb_dirty(struct drm_framebuffer *fb, struct drm_rect *rect)
> +{
> +	struct gdepaper *epap = drm_to_gdepaper(fb->dev);
> +	struct device *dev = epap->drm.dev;
> +	unsigned int w, h;
> +	struct drm_rect rect_aligned;
> +	int idx, ret = 0;
> +
> +	dev_dbg(dev, "fbdirty\n");
> +
> +	if (!epap->partial_update_en) {
> +		*rect = (struct drm_rect) {
> +			.x1 = 0,
> +			.x2 = fb->width,
> +			.y1 = 0,
> +			.y2 = fb->height,
> +		};
> +	}
> +	w = rect->x2 - rect->x1;
> +	h = rect->y2 - rect->y1;
> +
> +	if (!epap->enabled) {
> +		dev_dbg(dev, "panel is disabled, returning\n");
> +		return;
> +	}
> +
> +	if (!drm_dev_enter(fb->dev, &idx)) {
> +		dev_dbg(dev, "can't acquire drm dev lock\n");
> +		return;
> +	}
> +
> +	dev_dbg(dev, "Flushing [FB:%d] " DRM_RECT_FMT "\n", fb->base.id,
> +		      DRM_RECT_ARG(rect));
> +
> +	ret = gdepaper_power_on(epap);
> +	if (ret)
> +		goto err_out;
> +
> +	if (w == fb->width && h == fb->height) { /* full refresh */
> +		/* black */
> +		ret = gdepaper_txbuf_pack((u8 *)epap->tx_buf, fb, rect,
> +					  GDEP_CH_BLACK);
> +
> +		dev_dbg(dev, "Sending %d byte full framebuf\n", ret);
> +		ret = gdepaper_command(epap, GDEP_CMD_DATA_START_TX_COL1,
> +			(u8 *)epap->tx_buf, ret);
> +		if (ret)
> +			goto err_out;
> +
> +		/* red/yellow */
> +		ret = gdepaper_txbuf_pack((u8 *)epap->tx_buf, fb, rect,
> +					  GDEP_CH_RED_YELLOW);
> +
> +		ret = gdepaper_command(epap, GDEP_CMD_DATA_START_TX_COL2,
> +			(u8 *)epap->tx_buf, ret);
> +		if (ret)
> +			goto err_out;
> +
> +		ret = gdepaper_command(epap, GDEP_CMD_DATA_STOP, NULL, 0);
> +		if (ret)
> +			goto err_out;
> +
> +		ret = gdepaper_command(epap, GDEP_CMD_DISP_RF, NULL, 0);
> +		if (ret)
> +			goto err_out;
> +
> +	} else {
> +		rect_aligned.x1 = rect->x1 & (~7U);

This can also be written as: round_down(rect->x1, 8);

> +		rect_aligned.y1 = rect->y1;
> +		rect_aligned.y2 = rect->y2;
> +		rect_aligned.x2 = rect_aligned.x1 +
> +			  ((rect->x2 - rect_aligned.x1 + 7) & (~7U));

Are you rounding up here?
If so: rect_aligned.x2 = round_up(rect->x2, 8);

> +
> +		/* black */
> +		ret = gdepaper_txbuf_pack((u8 *)epap->tx_buf, fb, &rect_aligned,
> +					  GDEP_CH_BLACK);
> +		dev_dbg(dev, "Sending %d byte partial framebuf\n", ret);
> +		if (ret < 0)
> +			goto err_out;
> +		ret = gdepaper_partial_cmd(epap, &rect_aligned,
> +			GDEP_CMD_PD_START_TX_COL1, (u8 *)epap->tx_buf, ret);
> +		if (ret)
> +			goto err_out;
> +
> +		/* red/yellow */
> +		ret = gdepaper_txbuf_pack((u8 *)epap->tx_buf, fb, &rect_aligned,
> +					  GDEP_CH_RED_YELLOW);
> +		if (ret < 0)
> +			goto err_out;
> +		ret = gdepaper_partial_cmd(epap, &rect_aligned,
> +			GDEP_CMD_PD_START_TX_COL2, (u8 *)epap->tx_buf,
> +			ret);
> +		if (ret)
> +			goto err_out;
> +		ret = gdepaper_command(epap, GDEP_CMD_DATA_STOP, NULL, 0);
> +		if (ret)
> +			goto err_out;
> +		ret = gdepaper_partial_cmd(epap, rect, GDEP_CMD_PART_DISP_RF,
> +			NULL, 0);
> +		if (ret)
> +			goto err_out;
> +	}
> +
> +	if (gdepaper_wait_busy(epap)) {
> +		dev_err(dev, "Timeout on partial refresh cmd\n");
> +		goto err_out;
> +	}
> +
> +	ret = gdepaper_power_off(epap);
> +	if (ret)
> +		goto err_out;
> +
> +	drm_dev_exit(idx);
> +	return;
> +
> +err_out:
> +	/* Try to power off anyway */
> +	gdepaper_power_off(epap);
> +
> +	dev_err(fb->dev->dev, "Failed to update display %d\n", ret);
> +	drm_dev_exit(idx);
> +}

<snip>

> +static int gdepaper_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct device_node *np = dev->of_node;
> +	const struct of_device_id *of_id;
> +	struct drm_device *drm;
> +	struct drm_display_mode *mode;
> +	struct gdepaper *epap;
> +	const struct gdepaper_type_descriptor *type_desc;
> +	int ret;
> +	size_t bufsize;
> +
> +	of_id = of_match_node(gdepaper_of_match, np);
> +	if (WARN_ON(of_id == NULL)) {
> +		dev_warn(dev, "dt node didn't match, aborting probe\n");
> +		return -EINVAL;
> +	}
> +	type_desc = of_id->data;
> +
> +	dev_dbg(dev, "Probing gdepaper module\n");
> +	epap = kzalloc(sizeof(*epap), GFP_KERNEL);
> +	if (!epap)
> +		return -ENOMEM;
> +
> +	epap->enabled = false;
> +	mutex_init(&epap->cmdlock);
> +	epap->tx_buf = NULL;
> +	epap->spi = spi;
> +
> +	drm = &epap->drm;
> +	ret = devm_drm_dev_init(dev, drm, &gdepaper_driver);
> +	if (ret) {
> +		dev_warn(dev, "failed to init drm dev\n");
> +		goto err_free;
> +	}
> +
> +	drm_mode_config_init(drm);
> +
> +	epap->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(epap->reset)) {
> +		dev_err(dev, "Failed to get reset GPIO\n");
> +		ret = PTR_ERR(epap->reset);
> +		goto err_free;
> +	}
> +
> +	epap->busy = devm_gpiod_get(dev, "busy", GPIOD_IN);
> +	if (IS_ERR(epap->busy)) {
> +		dev_err(dev, "Failed to get busy GPIO\n");
> +		ret = PTR_ERR(epap->busy);
> +		goto err_free;
> +	}
> +
> +	epap->dc = devm_gpiod_get(dev, "dc", GPIOD_OUT_LOW);
> +	if (IS_ERR(epap->dc)) {
> +		dev_err(dev, "Failed to get dc GPIO\n");
> +		ret = PTR_ERR(epap->dc);
> +		goto err_free;
> +	}
> +
> +	epap->spi_speed_hz = 2000000;
> +	epap->pll_div = 1;
> +	epap->framerate_mHz = 81850;
> +	epap->rfp.vg_lv = GDEP_PWR_VGHL_16V;
> +	epap->rfp.vcom_sel = 0;
> +	epap->rfp.vdh_bw_mv = 11000; /* drive high level, b/w pixel */
> +	epap->rfp.vdh_col_mv = 4200; /* drive high level, red/yellow pixel */
> +	epap->rfp.vdl_mv = -11000; /* drive low level */
> +	epap->rfp.border_data_sel = 2; /* "vbd" */
> +	epap->rfp.data_polarity = 0; /* "ddx" */
> +	epap->rfp.vcom_dc_mv = -1000;
> +	epap->rfp.vcom_data_ivl_hsync = 10; /* hsync periods */
> +	epap->rfp.use_otp_luts_flag = 1;
> +	epap->ss_param[0] = 0x07;
> +	epap->ss_param[1] = 0x07;
> +	epap->ss_param[2] = 0x17;
> +	epap->controller_res = GDEP_CTRL_RES_320X300;
> +
> +	ret = gdepaper_of_read_luts(epap, np, dev);
> +	if (ret) {
> +		dev_warn(dev, "can't read LUTs from dt\n");
> +		goto err_free;
> +	}
> +
> +	of_property_read_u32(np, "controller-resolution",
> +			&epap->controller_res);
> +	of_property_read_u32(np, "spi-speed-hz", &epap->spi_speed_hz);
> +	epap->partial_update_en = of_property_read_bool(np, "partial-update");
> +	ret = of_property_read_u32(np, "colors", &epap->display_colors);
> +	if (ret == -EINVAL) {
> +		if (type_desc) {
> +			epap->display_colors = type_desc->colors;
> +
> +		} else {
> +			dev_err(dev, "colors must be set in dt\n");
> +			ret = -EINVAL;
> +			goto err_free;
> +		}
> +	} else if (ret) {
> +		dev_err(dev, "Invalid dt colors property\n");
> +		goto err_free;
> +	}
> +	if (epap->display_colors < 0 ||
> +			epap->display_colors >= GDEPAPER_COL_END) {
> +		dev_err(dev, "invalid colors value\n");
> +		ret = -EINVAL;
> +		goto err_free;
> +	}
> +	epap->mirror_x = of_property_read_bool(np, "mirror-x");
> +	epap->mirror_y = of_property_read_bool(np, "mirror-y");
> +	of_property_read_u32(np, "pll-div", &epap->pll_div);
> +	of_property_read_u32(np, "fps-millihertz", &epap->framerate_mHz);
> +	of_property_read_u32(np, "vghl-level", &epap->rfp.vg_lv);
> +	epap->vds_en = !of_property_read_bool(np, "vds-external");
> +	epap->vdg_en = !of_property_read_bool(np, "vdg-external");
> +	of_property_read_u32(np, "vcom", &epap->rfp.vcom_sel);
> +	of_property_read_u32(np, "vdh-bw-millivolts", &epap->rfp.vdh_bw_mv);
> +	of_property_read_u32(np, "vdh-color-millivolts", &epap->rfp.vdh_col_mv);
> +	of_property_read_u32(np, "vdl-millivolts", &epap->rfp.vdl_mv);
> +	of_property_read_u32(np, "border-data", &epap->rfp.border_data_sel);
> +	of_property_read_u32(np, "data-polarity", &epap->rfp.data_polarity);
> +	ret = of_property_read_u8_array(np, "boost-soft-start",
> +			(u8 *)&epap->ss_param, sizeof(epap->ss_param));
> +	if (ret && ret != -EINVAL)
> +		dev_err(dev, "invalid boost-soft-start value, ignoring\n");
> +	of_property_read_u32(np, "vcom-data-interval-periods",
> +			&epap->rfp.vcom_data_ivl_hsync);

Why do you need these DT properties when you define compatibles for all
the panels, can't you include these settings in the type descriptor?

> +
> +	/* Accept both positive and negative notation */
> +	if (epap->rfp.vdl_mv < 0)
> +		epap->rfp.vdl_mv = -epap->rfp.vdl_mv;
> +	if (epap->rfp.vcom_dc_mv < 0)
> +		epap->rfp.vcom_dc_mv = -epap->rfp.vcom_dc_mv;
> +
> +	/* (from mipi-dbi.c:)
> +	 * Even though it's not the SPI device that does DMA (the master does),
> +	 * the dma mask is necessary for the dma_alloc_wc() in
> +	 * drm_gem_cma_create(). The dma_addr returned will be a physical
> +	 * address which might be different from the bus address, but this is
> +	 * not a problem since the address will not be used.
> +	 * The virtual address is used in the transfer and the SPI core
> +	 * re-maps it on the SPI master device using the DMA streaming API
> +	 * (spi_map_buf()).
> +	 */
> +	if (!dev->coherent_dma_mask) {
> +		ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +		if (ret) {
> +			dev_warn(dev, "Failed to set dma mask %d\n", ret);
> +			goto err_free;
> +		}
> +	}
> +
> +	mode = gdepaper_of_read_mode(type_desc, np, dev);
> +	if (IS_ERR(mode)) {
> +		dev_warn(dev, "Failed to read mode: %ld\n", PTR_ERR(mode));
> +		ret = PTR_ERR(mode);
> +		goto err_free;
> +	}
> +
> +	/* 8 pixels per byte, bit-packed */
> +	bufsize = (mode->vdisplay * mode->hdisplay + 7)/8;

DIV_ROUND_UP(mode->vdisplay * mode->hdisplay, 8)

> +	epap->tx_buf = devm_kmalloc(drm->dev, bufsize, GFP_KERNEL);
> +	if (!epap->tx_buf) {
> +		ret = -ENOMEM;
> +		goto err_free;
> +	}
> +
> +	/* TODO rotation support? */
> +	ret = tinydrm_display_pipe_init(drm, &epap->pipe, &gdepaper_pipe_funcs,
> +					DRM_MODE_CONNECTOR_VIRTUAL,
> +					gdepaper_formats,
> +					ARRAY_SIZE(gdepaper_formats), mode, 0);

tinydrm_display_pipe_init() is gone now, here's how I replaced it in the
other e-ink driver:

drm/tinydrm/repaper: Don't use tinydrm_display_pipe_init()
https://cgit.freedesktop.org/drm/drm-misc/commit?id=1321db837549a0ff9dc2c95ff76c46770f7f02a1

Noralf.

> +	if (ret) {
> +		dev_warn(dev, "Failed to initialize display pipe: %d\n", ret);
> +		goto err_free;
> +	}
> +
> +	drm->mode_config.funcs = &gdepaper_dbi_mode_config_funcs;
> +	drm->mode_config.preferred_depth = 32;
> +	drm_plane_enable_fb_damage_clips(&epap->pipe.plane);
> +	drm_mode_config_reset(drm);
> +
> +	ret = drm_dev_register(drm, 0);
> +	if (ret) {
> +		dev_warn(dev, "Failed to register drm device: %d\n", ret);
> +		goto err_free;
> +	}
> +
> +	spi_set_drvdata(spi, drm);
> +	drm_fbdev_generic_setup(drm, 0);
> +
> +	dev_dbg(dev, "Probed gdepaper module\n");
> +	return 0;
> +err_free:
> +	kfree(epap);
> +	return ret;
> +}
