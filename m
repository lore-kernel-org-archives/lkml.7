Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC24C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0778206DD
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfCCUXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:23:19 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:41514 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfCCUXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:23:19 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id A1EC520032;
        Sun,  3 Mar 2019 21:23:09 +0100 (CET)
Date:   Sun, 3 Mar 2019 21:23:08 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, mark.rutland@arm.com, devicetree@vger.kernel.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] drm: rockchip: introduce rk3066 hdmi
Message-ID: <20190303202308.GD13157@ravnborg.org>
References: <20190302104116.1535-1-jbx6244@gmail.com>
 <20190302104116.1535-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302104116.1535-2-jbx6244@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=s8YR1HE3AAAA:8 a=pGLkceISAAAA:8
        a=4y6Fq9xeSFUypJWi1pYA:9 a=CjuIK1q_8ugA:10 a=jGH_LyMDp9YhSvY-UuyI:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan.

Thanks for this nive driver.
A few review comments follows.

	Sam

On Sat, Mar 02, 2019 at 11:41:13AM +0100, Johan Jonker wrote:
> From: Zheng Yang <zhengyang@rock-chips.com>
> 
> Introduce rk3066 hdmi.
A little more info would be good here.
Do not assume all reader knows as much as you do.

> 
> Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> new file mode 100644
> index 000000000..3c5b702dc
> --- /dev/null
> +++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> @@ -0,0 +1,911 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
> + *    Zheng Yang <zhengyang@rock-chips.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +
> +#include <drm/drm_of.h>
> +#include <drm/drmP.h>
> +#include <drm/drm_probe_helper.h>
Please do not use drmP.h in new files. The usage of drmP.h is deprecated.
Also please sort the include files, but keep the nice grouping.

> +
> +#include "rockchip_drm_drv.h"
> +#include "rockchip_drm_vop.h"
> +
> +#include "rk3066_hdmi.h"
> +
> +#define DEFAULT_PLLA_RATE 30000000
> +
> +struct hdmi_data_info {
> +	int vic;
vic is used so much. It deserves an explanation.


> +	bool sink_is_hdmi;
> +	unsigned int enc_in_format;

enc_in_format is in this patch only assinged.
aybe drop it (if not used in later patches)

> +	unsigned int enc_out_format;
> +	unsigned int colorimetry;
> +};
> +
> +struct rk3066_hdmi_i2c {
> +	struct i2c_adapter adap;
> +
> +	u8 ddc_addr;
> +	u8 segment_addr;
The two members above are only used in rk3066_hdmi_i2c_write()
Maybe they can be made local variables?

> +	u8 stat;
> +
> +	struct mutex lock; /*for i2c operation*/
Name the lock after what is protects, to avoid mis-use.

> +	struct completion cmp;

cmp is shorthand for "compare" - as we have a command named so.
Find a better name.

> +};
> +
> +struct rk3066_hdmi {
> +	struct device *dev;
> +	struct drm_device *drm_dev;
The new way to do this is to embed the device.
See latest patches by Noralf in drm-misc-next, which include a nice example.

> +	struct regmap *regmap;
+1 for using regmap.
But then there is still several readl_relaxed() writel_relaxed() calls?
They are in hdmi_readb() and hdmi_writeb(). Should a regmap had been used here too?

> +	int irq;
> +	struct clk *hclk;
> +	void __iomem *regs;
> +
> +	struct drm_connector connector;
> +	struct drm_encoder encoder;
> +
> +	struct rk3066_hdmi_i2c *i2c;
> +	struct i2c_adapter *ddc;
> +
> +	unsigned int tmdsclk;
> +
> +	struct hdmi_data_info hdmi_data;
> +	struct drm_display_mode previous_mode;
> +};
> +
> +#define to_rk3066_hdmi(x) container_of(x, struct rk3066_hdmi, x)
> +
> +static inline u8 hdmi_readb(struct rk3066_hdmi *hdmi, u16 offset)
> +{
> +	return readl_relaxed(hdmi->regs + offset);
> +}
> +
> +static inline void hdmi_writeb(struct rk3066_hdmi *hdmi, u16 offset, u32 val)
> +{
> +	writel_relaxed(val, hdmi->regs + offset);
> +}
> +
> +static inline void hdmi_modb(struct rk3066_hdmi *hdmi, u16 offset,
> +			     u32 msk, u32 val)
> +{
> +	u8 temp = hdmi_readb(hdmi, offset) & ~msk;
> +
> +	temp |= val & msk;
> +	hdmi_writeb(hdmi, offset, temp);
> +}
> +
> +static void rk3066_hdmi_i2c_init(struct rk3066_hdmi *hdmi)
> +{
> +	int ddc_bus_freq;
> +
> +	ddc_bus_freq = (hdmi->tmdsclk >> 2) / HDMI_SCL_RATE;
> +
> +	hdmi_writeb(hdmi, HDMI_DDC_BUS_FREQ_L, ddc_bus_freq & 0xFF);
> +	hdmi_writeb(hdmi, HDMI_DDC_BUS_FREQ_H, (ddc_bus_freq >> 8) & 0xFF);
> +
> +	/* Clear the EDID interrupt flag and mute the interrupt */
> +	hdmi_modb(hdmi, HDMI_INTR_MASK1, HDMI_INTR_EDID_MASK, 0);
> +	hdmi_writeb(hdmi, HDMI_INTR_STATUS1, HDMI_INTR_EDID_MASK);
> +}
> +
> +static inline u8 rk3066_hdmi_get_power_mode(struct rk3066_hdmi *hdmi)
> +{
> +	return hdmi_readb(hdmi, HDMI_SYS_CTRL) & HDMI_SYS_POWER_MODE_MASK;
> +}
> +
> +static void rk3066_hdmi_set_power_mode(struct rk3066_hdmi *hdmi, int mode)
> +{
> +	u8 current_mode, next_mode;
> +	u8 i = 0;
> +
> +	current_mode = rk3066_hdmi_get_power_mode(hdmi);
> +
> +	dev_dbg(hdmi->dev, "mode         :%d\n", mode);
> +	dev_dbg(hdmi->dev, "current_mode :%d\n", current_mode);
> +
> +	if (current_mode == mode)
> +		return;
> +
> +	do {
> +		if (current_mode > mode)
> +			next_mode = current_mode / 2;
> +		else {
> +			if (current_mode < HDMI_SYS_POWER_MODE_A)
> +				next_mode = HDMI_SYS_POWER_MODE_A;
> +			else
> +				next_mode = current_mode * 2;
> +		}
> +
> +		dev_dbg(hdmi->dev, "%d: next_mode :%d\n", i, next_mode);
> +
> +		if (next_mode != HDMI_SYS_POWER_MODE_D) {
> +			hdmi_modb(hdmi, HDMI_SYS_CTRL,
> +				  HDMI_SYS_POWER_MODE_MASK, next_mode);
> +		} else {
> +			hdmi_writeb(hdmi, HDMI_SYS_CTRL,
> +				    HDMI_SYS_POWER_MODE_D |
> +				    HDMI_SYS_PLL_RESET_MASK);
> +			usleep_range(90, 100);
> +			hdmi_writeb(hdmi, HDMI_SYS_CTRL,
> +				    HDMI_SYS_POWER_MODE_D |
> +				    HDMI_SYS_PLLB_RESET);
> +			usleep_range(90, 100);
> +			hdmi_writeb(hdmi, HDMI_SYS_CTRL,
> +				    HDMI_SYS_POWER_MODE_D);
> +		}
> +		current_mode = next_mode;
> +		i = i + 1;
> +	} while ((next_mode != mode) && (i < 5));
> +
> +	/*
> +	 * When IP controller haven't configured to an accurate video
> +	 * timing, DDC_CLK is equal to PLLA freq which is 30MHz,so we
> +	 * need to init the TMDS rate to PCLK rate, and reconfigure
> +	 * the DDC clock.
> +	 */
> +	if (mode < HDMI_SYS_POWER_MODE_D)
> +		hdmi->tmdsclk = DEFAULT_PLLA_RATE;
> +}
> +
> +static int
> +rk3066_hdmi_upload_frame(struct rk3066_hdmi *hdmi, int setup_rc,
> +			 union hdmi_infoframe *frame, u32 frame_index,
> +			 u32 mask, u32 disable, u32 enable)
> +{
> +	if (mask)
> +		hdmi_modb(hdmi, HDMI_CP_AUTO_SEND_CTRL, mask, disable);
> +
> +	hdmi_writeb(hdmi, HDMI_CP_BUF_INDEX, frame_index);
> +
> +	if (setup_rc >= 0) {
> +		u8 packed_frame[HDMI_MAXIMUM_INFO_FRAME_SIZE];
> +		ssize_t rc, i;
> +
> +		rc = hdmi_infoframe_pack(frame, packed_frame,
> +					 sizeof(packed_frame));
> +		if (rc < 0)
> +			return rc;
> +
> +		for (i = 0; i < rc; i++)
> +			hdmi_writeb(hdmi, HDMI_CP_BUF_ACC_HB0 + i * 4,
> +				    packed_frame[i]);
> +
> +		if (mask)
> +			hdmi_modb(hdmi, HDMI_CP_AUTO_SEND_CTRL, mask, enable);
> +	}
> +
> +	return setup_rc;
> +}
> +
> +static int rk3066_hdmi_config_avi(struct rk3066_hdmi *hdmi,
> +				  struct drm_display_mode *mode)
> +{
> +	union hdmi_infoframe frame;
> +	int rc;
> +
> +	rc = drm_hdmi_avi_infoframe_from_display_mode(&frame.avi,
> +						      &hdmi->connector, mode);
> +
> +	if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_YUV444)
> +		frame.avi.colorspace = HDMI_COLORSPACE_YUV444;
> +	else if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_YUV422)
> +		frame.avi.colorspace = HDMI_COLORSPACE_YUV422;
> +	else
> +		frame.avi.colorspace = HDMI_COLORSPACE_RGB;
> +
> +	frame.avi.colorimetry = hdmi->hdmi_data.colorimetry;
> +	frame.avi.scan_mode = HDMI_SCAN_MODE_NONE;
> +
> +	return rk3066_hdmi_upload_frame(hdmi, rc, &frame,
> +					HDMI_INFOFRAME_AVI, 0, 0, 0);
> +}
> +
> +static int rk3066_hdmi_config_video_timing(struct rk3066_hdmi *hdmi,
> +					   struct drm_display_mode *mode)
> +{
> +	int value, vsync_offset;
> +
> +	/* Set detail external video timing polarity and interlace mode */
> +	value = HDMI_EXT_VIDEO_SET_EN;
> +	value |= mode->flags & DRM_MODE_FLAG_PHSYNC ?
> +		 HDMI_VIDEO_HSYNC_ACTIVE_HIGH : HDMI_VIDEO_HSYNC_ACTIVE_LOW;
> +	value |= mode->flags & DRM_MODE_FLAG_PVSYNC ?
> +		 HDMI_VIDEO_VSYNC_ACTIVE_HIGH : HDMI_VIDEO_VSYNC_ACTIVE_LOW;
> +	value |= mode->flags & DRM_MODE_FLAG_INTERLACE ?
> +		 HDMI_VIDEO_MODE_INTERLACE : HDMI_VIDEO_MODE_PROGRESSIVE;
> +	if (hdmi->hdmi_data.vic == 2 || hdmi->hdmi_data.vic == 3)
> +		vsync_offset = 6;
> +	else
> +		vsync_offset = 0;
> +	value |= vsync_offset << 4; 
Replace 4 with HDMI_VIDEO_VSYNC_OFFSET_SHIFT??

> +	hdmi_writeb(hdmi, HDMI_EXT_VIDEO_PARA, value);
> +

 +
> +static int rk3066_hdmi_bind(struct device *dev, struct device *master,
> +			    void *data)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct drm_device *drm = data;
> +	struct rk3066_hdmi *hdmi;
> +	struct resource *iores;
> +	int irq;
> +	int ret;
> +
> +	hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
> +	if (!hdmi)
> +		return -ENOMEM;
> +
> +	hdmi->dev = dev;
> +	hdmi->drm_dev = drm;
> +
> +	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!iores)
> +		return -ENXIO;
> +
> +	hdmi->regs = devm_ioremap_resource(dev, iores);
> +	if (IS_ERR(hdmi->regs))
> +		return PTR_ERR(hdmi->regs);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	hdmi->hclk = devm_clk_get(hdmi->dev, "hclk");
> +	if (IS_ERR(hdmi->hclk)) {
> +		dev_err(hdmi->dev, "unable to get HDMI hclk clock\n");
> +		return PTR_ERR(hdmi->hclk);
> +	}
> +
> +	ret = clk_prepare_enable(hdmi->hclk);
> +	if (ret) {
> +		dev_err(hdmi->dev, "cannot enable HDMI hclk clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	hdmi->regmap =
> +		syscon_regmap_lookup_by_phandle(hdmi->dev->of_node,
> +						"rockchip,grf");

dev->of_node would be fine here. No reason to go via hdmi->

> +	if (IS_ERR(hdmi->regmap)) {
> +		dev_err(hdmi->dev, "unable to get rockchip,grf\n");
> +		ret = PTR_ERR(hdmi->regmap);
> +		goto err_disable_hclk;
> +	}
> +
> +	/* internal hclk = hdmi_hclk / 25 */
> +	hdmi_writeb(hdmi, HDMI_INTERNAL_CLK_DIVIDER, 25);
> +
> +	hdmi->ddc = rk3066_hdmi_i2c_adapter(hdmi);
> +	if (IS_ERR(hdmi->ddc)) {
> +		ret = PTR_ERR(hdmi->ddc);
> +		hdmi->ddc = NULL;
> +		goto err_disable_hclk;
> +	}
> +
> +	rk3066_hdmi_set_power_mode(hdmi, HDMI_SYS_POWER_MODE_B);
> +	usleep_range(999, 1000);
> +	hdmi_writeb(hdmi, HDMI_INTR_MASK1, HDMI_INTR_HOTPLUG);
> +	hdmi_writeb(hdmi, HDMI_INTR_MASK2, 0);
> +	hdmi_writeb(hdmi, HDMI_INTR_MASK3, 0);
> +	hdmi_writeb(hdmi, HDMI_INTR_MASK4, 0);
> +	rk3066_hdmi_set_power_mode(hdmi, HDMI_SYS_POWER_MODE_A);
> +
> +	ret = rk3066_hdmi_register(drm, hdmi);
> +	if (ret)
> +		goto err_disable_hclk;
> +
> +	dev_set_drvdata(dev, hdmi);
> +
> +	ret = devm_request_threaded_irq(dev, irq, rk3066_hdmi_hardirq,
> +					rk3066_hdmi_irq, IRQF_SHARED,
> +					dev_name(dev), hdmi);
> +	if (ret) {
> +		dev_err(hdmi->dev,
> +			"failed to request hdmi irq: %d\n", ret);
> +		goto err_disable_hclk;
> +	}
> +
> +	return 0;
> +
> +err_disable_hclk:
> +	clk_disable_unprepare(hdmi->hclk);
> +
> +	return ret;
> +}
> +
> +static void rk3066_hdmi_unbind(struct device *dev, struct device *master,
> +			       void *data)
> +{
> +	struct rk3066_hdmi *hdmi = dev_get_drvdata(dev);
> +
> +	hdmi->connector.funcs->destroy(&hdmi->connector);
> +	hdmi->encoder.funcs->destroy(&hdmi->encoder);
I think the destroy() function should not be called directly.

> +
> +	clk_disable_unprepare(hdmi->hclk);
> +	i2c_put_adapter(hdmi->ddc);
> +}
> +
> +static const struct component_ops rk3066_hdmi_ops = {
> +	.bind	= rk3066_hdmi_bind,
> +	.unbind	= rk3066_hdmi_unbind,
> +};
> +
> +static int rk3066_hdmi_probe(struct platform_device *pdev)
> +{
> +	return component_add(&pdev->dev, &rk3066_hdmi_ops);
> +}
> +
> +static int rk3066_hdmi_remove(struct platform_device *pdev)
> +{
> +	component_del(&pdev->dev, &rk3066_hdmi_ops);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id rk3066_hdmi_dt_ids[] = {
> +	{ .compatible = "rockchip,rk3066-hdmi",
> +	},
MAke this a one-liner.

> +	{},
Us { /* sentinal */ }, like most other drivers.

> +	.driver = {
> +		.name = "rockchip-rk3066hdmi",
Different naming are used for the driver in this file.
Coniser using a macro to align the naming.


> +		.of_match_table = rk3066_hdmi_dt_ids,
> +	},
> +};

