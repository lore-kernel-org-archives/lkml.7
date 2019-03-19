Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90519C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559D520857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfCSLoS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:44:18 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58294 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfCSLoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:44:17 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h6DA4-0006B0-Ec; Tue, 19 Mar 2019 12:44:04 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] drm: rockchip: introduce rk3066 hdmi
Date:   Tue, 19 Mar 2019 12:44:03 +0100
Message-ID: <4125149.ebfS1HlHkS@diego>
In-Reply-To: <20190306224113.24853-2-jbx6244@gmail.com>
References: <20190306224113.24853-1-jbx6244@gmail.com> <20190306224113.24853-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Mittwoch, 6. März 2019, 23:41:10 CET schrieb Johan Jonker:
> From: Zheng Yang <zhengyang@rock-chips.com>
> 
> The RK3066 HDMI TX serves as interface between a LCD Controller and
> a HDMI bus. A HDMI TX consists of one HDMI transmitter controller and
> one HDMI transmitter PHY. The interface has three (3) 8-bit data channels
> which can be configured for a number of bus widths (8/10/12/16/20/24-bit)
> and different video formats (RGB, YCbCr).
> 
> Features:
> HDMI version 1.4a, HDCP revision 1.4 and
> DVI version 1.0 compliant transmitter.
> Supports DTV resolutions from 480i to 1080i/p HD.
> Master I2C interface for a DDC connection.
> HDMI TX supports multiple power save modes.
> The HDMI TX input can switch between LCDC0 and LCDC1.
> (Sound support is not included in this patch)
> 
> Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Looks good in general, but there are some minor things to improve yet,
please see below for specifics.

[...]

> +static void rk3066_hdmi_config_phy(struct rk3066_hdmi *hdmi)
> +{
> +	/* TMDS uses the same frequency as dclk. */
> +	hdmi_writeb(hdmi, HDMI_DEEP_COLOR_MODE, 0x22);

These magic values below are no fault of yours, but in any case this
could use a comment that the semi-public documentation does not
describe hdmi-registers at all, so we're stuck with these magic-values
for now.

> +	if (hdmi->tmdsclk > 100000000) {
> +		rk3066_hdmi_phy_write(hdmi, 0x158, 0x0E);
> +		rk3066_hdmi_phy_write(hdmi, 0x15c, 0x00);
> +		rk3066_hdmi_phy_write(hdmi, 0x160, 0x60);
> +		rk3066_hdmi_phy_write(hdmi, 0x164, 0x00);
> +		rk3066_hdmi_phy_write(hdmi, 0x168, 0xDA);
> +		rk3066_hdmi_phy_write(hdmi, 0x16c, 0xA1);
> +		rk3066_hdmi_phy_write(hdmi, 0x170, 0x0e);
> +		rk3066_hdmi_phy_write(hdmi, 0x174, 0x22);
> +		rk3066_hdmi_phy_write(hdmi, 0x178, 0x00);
> +	} else if (hdmi->tmdsclk > 50000000) {
> +		rk3066_hdmi_phy_write(hdmi, 0x158, 0x06);
> +		rk3066_hdmi_phy_write(hdmi, 0x15c, 0x00);
> +		rk3066_hdmi_phy_write(hdmi, 0x160, 0x60);
> +		rk3066_hdmi_phy_write(hdmi, 0x164, 0x00);
> +		rk3066_hdmi_phy_write(hdmi, 0x168, 0xCA);
> +		rk3066_hdmi_phy_write(hdmi, 0x16c, 0xA3);
> +		rk3066_hdmi_phy_write(hdmi, 0x170, 0x0e);
> +		rk3066_hdmi_phy_write(hdmi, 0x174, 0x20);
> +		rk3066_hdmi_phy_write(hdmi, 0x178, 0x00);
> +	} else {
> +		rk3066_hdmi_phy_write(hdmi, 0x158, 0x02);
> +		rk3066_hdmi_phy_write(hdmi, 0x15c, 0x00);
> +		rk3066_hdmi_phy_write(hdmi, 0x160, 0x60);
> +		rk3066_hdmi_phy_write(hdmi, 0x164, 0x00);
> +		rk3066_hdmi_phy_write(hdmi, 0x168, 0xC2);
> +		rk3066_hdmi_phy_write(hdmi, 0x16c, 0xA2);
> +		rk3066_hdmi_phy_write(hdmi, 0x170, 0x0e);
> +		rk3066_hdmi_phy_write(hdmi, 0x174, 0x20);
> +		rk3066_hdmi_phy_write(hdmi, 0x178, 0x00);
> +	}
> +}

> +static void rk3066_hdmi_encoder_enable(struct drm_encoder *encoder)
> +{
> +	struct rk3066_hdmi *hdmi = to_rk3066_hdmi(encoder);
> +	int mux, val;
> +
> +	mux = drm_of_encoder_active_endpoint_id(hdmi->dev->of_node, encoder);
> +	if (mux)
> +		val = BIT(30) | BIT(14);
> +	else
> +		val = BIT(30);
> +
> +	regmap_write(hdmi->grf, 0x150, val);


Please define constants for both BIT(14) and the 0x150 GRF register,
which is GRF_SOC_CON0, so in the header

#define GRF_SOC_CON0	0x150
#define HDMI_VIDEO_SEL	BIT(14)

and then do
	if (mux)
		val = (HDMI_VIDEO_SEL << 16) | HDMI_VIDEO_SEL;
	else
		val = HDMI_VIDEO_SEL << 16;

	regmap_write(hdmi->grf, GRF_SOC_CON0, val);

> +
> +	dev_dbg(hdmi->dev, "hdmi encoder enable select: vop%s\n",
> +		(mux) ? "1" : "0");
> +
> +	rk3066_hdmi_setup(hdmi, &hdmi->previous_mode);
> +}
> +


> +static const struct drm_display_mode edid_cea_modes[] = {
> +	/* 4 - 1280x720@60Hz 16:9 */
> +	{ DRM_MODE("1280x720", DRM_MODE_TYPE_DRIVER, 74250, 1280, 1390,
> +		   1430, 1650, 0, 720, 725, 730, 750, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> +};

please drop that, see below

> +static int rk3066_hdmi_connector_get_modes(struct drm_connector *connector)
> +{
> +	struct rk3066_hdmi *hdmi = to_rk3066_hdmi(connector);
> +	struct drm_display_mode *mode = NULL;
> +	struct edid *edid;
> +	int ret = 0;
> +
> +	if (!hdmi->ddc)
> +		return 0;
> +
> +	hdmi->hdmi_data.sink_is_hdmi = false;
> +
> +	edid = drm_get_edid(connector, hdmi->ddc);
> +	if (edid) {
> +		hdmi->hdmi_data.sink_is_hdmi = drm_detect_hdmi_monitor(edid);
> +
> +		dev_info(hdmi->dev, "monitor type : %s : %dx%d cm\n",
> +			(hdmi->hdmi_data.sink_is_hdmi ? "HDMI" : "DVI"),
> +			edid->width_cm, edid->height_cm);
> +
> +		drm_connector_update_edid_property(connector, edid);
> +		ret = drm_add_edid_modes(connector, edid);
> +		kfree(edid);
> +	}
> +
> +	if ((ret == 0) || (hdmi->hdmi_data.sink_is_hdmi == false)) {
> +		hdmi->hdmi_data.sink_is_hdmi = false;
> +
> +		mode = drm_mode_duplicate(hdmi->drm_dev, &edid_cea_modes[0]);
> +		if (!mode)
> +			return ret;
> +		mode->type |= DRM_MODE_TYPE_PREFERRED;
> +		drm_mode_probed_add(connector, mode);
> +		ret++;
> +
> +		dev_info(hdmi->dev, "no CEA mode found, use default\n");

This is a hack from the vendor-kernel.

If EDID reading fails, it is some sort of issue with the driver, so we
shouldn't assume any specific mode at all. See the somewhat similar
inno_hdmi driver for comparison.


> +	}
> +
> +	return ret;
> +}
> +



> +static int
> +rk3066_hdmi_register(struct drm_device *drm, struct rk3066_hdmi *hdmi)
> +{
> +	struct drm_encoder *encoder = &hdmi->encoder;
> +	struct device *dev = hdmi->dev;
> +
> +	encoder->possible_crtcs =
> +		drm_of_find_possible_crtcs(drm, dev->of_node);
> +
> +	/*
> +	 * If we failed to find the VOP(s) which this encoder is
> +	 * supposed to be connected to, it's because the VOP has
> +	 * not been registered yet.  Defer probing, and hope that
> +	 * the required VOP is added later.
> +	 */
> +	if (encoder->possible_crtcs == 0)
> +		return -EPROBE_DEFER;
> +
> +	dev_info(hdmi->dev, "VOP found\n");

unnecessary output which will clutter up the kernel log, please drop.

> +
> +	drm_encoder_helper_add(encoder, &rk3066_hdmi_encoder_helper_funcs);
> +	drm_encoder_init(drm, encoder, &rk3066_hdmi_encoder_funcs,
> +			 DRM_MODE_ENCODER_TMDS, NULL);
> +
> +	hdmi->connector.polled = DRM_CONNECTOR_POLL_HPD;
> +
> +	drm_connector_helper_add(&hdmi->connector,
> +				 &rk3066_hdmi_connector_helper_funcs);
> +	drm_connector_init(drm, &hdmi->connector,
> +			   &rk3066_hdmi_connector_funcs,
> +			   DRM_MODE_CONNECTOR_HDMIA);
> +
> +	drm_connector_attach_encoder(&hdmi->connector, encoder);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t rk3066_hdmi_i2c_irq(struct rk3066_hdmi *hdmi, u8 stat)
> +{
> +	struct rk3066_hdmi_i2c *i2c = hdmi->i2c;
> +
> +	if (!(stat & HDMI_INTR_EDID_MASK))
> +		return IRQ_NONE;
> +
> +	i2c->stat = stat;
> +
> +	complete(&i2c->compl);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t rk3066_hdmi_hardirq(int irq, void *dev_id)
> +{
> +	struct rk3066_hdmi *hdmi = dev_id;
> +	irqreturn_t ret = IRQ_NONE;
> +	u8 interrupt;
> +
> +	if (rk3066_hdmi_get_power_mode(hdmi) == HDMI_SYS_POWER_MODE_A)
> +		hdmi_writeb(hdmi, HDMI_SYS_CTRL, HDMI_SYS_POWER_MODE_B);
> +
> +	interrupt = hdmi_readb(hdmi, HDMI_INTR_STATUS1);
> +	if (interrupt)
> +		hdmi_writeb(hdmi, HDMI_INTR_STATUS1, interrupt);
> +
> +	if (hdmi->i2c)
> +		ret = rk3066_hdmi_i2c_irq(hdmi, interrupt);

I think you don't really need that rk3066_hdmi_i2c_irq function above,
this can just become

	if (interrupt & HDMI_INTR_EDID_MASK) {
		hdmi->i2c->stat = stat;
		complete(&hdmi->i2c->compl);
	}

hdmi->i2c is set through rk3066_hdmi_i2c_adapter() which is always called
and needs to be sucessful before registering the interrupt, so there is
no need to check for hdmi->i2c here at all.


> +
> +	if (interrupt & (HDMI_INTR_HOTPLUG | HDMI_INTR_MSENS))
> +		ret = IRQ_WAKE_THREAD;
> +
> +	return ret;
> +}
> +





> +static struct i2c_adapter *rk3066_hdmi_i2c_adapter(struct rk3066_hdmi *hdmi)
> +{
> +	struct i2c_adapter *adap;
> +	struct rk3066_hdmi_i2c *i2c;
> +	int ret;
> +
> +	i2c = devm_kzalloc(hdmi->dev, sizeof(*i2c), GFP_KERNEL);
> +	if (!i2c)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_init(&i2c->i2c_lock);
> +	init_completion(&i2c->compl);
> +
> +	adap = &i2c->adap;
> +	adap->class = I2C_CLASS_DDC;
> +	adap->owner = THIS_MODULE;
> +	adap->dev.parent = hdmi->dev;
> +	adap->dev.of_node = hdmi->dev->of_node;
> +	adap->algo = &rk3066_hdmi_algorithm;
> +	strlcpy(adap->name, "RK3066 HDMI", sizeof(adap->name));
> +	i2c_set_adapdata(adap, hdmi);
> +
> +	ret = i2c_add_adapter(adap);
> +	if (ret) {
> +		dev_warn(hdmi->dev, "cannot add %s I2C adapter\n", adap->name);
> +		devm_kfree(hdmi->dev, i2c);
> +		return ERR_PTR(ret);
> +	}
> +
> +	hdmi->i2c = i2c;
> +
> +	dev_info(hdmi->dev, "registered %s I2C bus driver\n", adap->name);

Please drop or make it a DRM_DEV_DEBUG. Also, please convert all the
general dev_foobar calls to their DRM_* equivalents, so
dev_warn becomes DRM_DEV_ERROR, dev_info DRM_DEV_INFO and so on.


> +	return adap;
> +}
> +
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
> +	hdmi->hclk = devm_clk_get(dev, "hclk");
> +	if (IS_ERR(hdmi->hclk)) {
> +		dev_err(dev, "unable to get HDMI hclk clock\n");
> +		return PTR_ERR(hdmi->hclk);
> +	}
> +
> +	ret = clk_prepare_enable(hdmi->hclk);
> +	if (ret) {
> +		dev_err(dev, "cannot enable HDMI hclk clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	hdmi->grf = syscon_regmap_lookup_by_phandle(dev->of_node,
> +						    "rockchip,grf");
> +	if (IS_ERR(hdmi->grf)) {
> +		dev_err(dev, "unable to get rockchip,grf\n");
> +		ret = PTR_ERR(hdmi->grf);
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

goto err_disable_i2c;

So that the i2c-adapter also gets disabled on error.

> +	dev_set_drvdata(dev, hdmi);
> +
> +	ret = devm_request_threaded_irq(dev, irq, rk3066_hdmi_hardirq,
> +					rk3066_hdmi_irq, IRQF_SHARED,
> +					dev_name(dev), hdmi);
> +	if (ret) {
> +		dev_err(dev, "failed to request hdmi irq: %d\n", ret);
> +		goto err_disable_hclk;

goto err_disable_i2c;

> +	}
> +
> +	return 0;
> +

err_disable_i2c:
	i2c_put_adapter(hdmi->ddc);

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
> +
> +	clk_disable_unprepare(hdmi->hclk);
> +	i2c_put_adapter(hdmi->ddc);

you should probably invert the calling order here, first remove the
i2c adapter and only then disable the clock.


Thanks
Heiko


