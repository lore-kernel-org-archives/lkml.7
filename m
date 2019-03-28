Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E69BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAF120823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnl52pVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfC1Ruo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:50:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35198 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfC1Rum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:50:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id s39so12498163edb.2;
        Thu, 28 Mar 2019 10:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uHElz/AtLG9+rpBu/qnPFZensihjHWt8GZ1QqUPYG2U=;
        b=mnl52pVwpCgjQMjH1YsV2H3Vs+Ra7F55nYIawP6A76IS71tV5Qczt6dDOalx52fbsJ
         8nK7VXAoLAwYnSQZxTAWrNi/mxcjxIka7yPa/AMTkrP9875CC2+SXTPOcoj5xs94jddj
         p/ZM3sjwxk552auUlGE9DMNykP4rTrMSiyxUyne2GUba6EqJzcI/I0mHvEtuQ6LW7yy4
         nMVsTmUZ5Rr1esd3SBalR/Owo/VSU1+qc3gOaGevJlPRgJyQu9DHUygIVBaWdA+nO3QR
         0nommB4VUHeoJwPO663yMH1cn1VQ3YE6yjQSnChx0ldtGIyTX4CUpn3jwDxKaOm0z4Hm
         RISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uHElz/AtLG9+rpBu/qnPFZensihjHWt8GZ1QqUPYG2U=;
        b=Q6HqhLHf89gZJltOM1JH1cp1Ma2NXUvezXn5h2EZlrO2ucIKtvncYoHbanxNWWlW9o
         S32bze5iDs5f2Ws5bk4QGw9rRgiWG44jdjKu0IEjnGg1Z6zBXiuqlSwTya2f3kgmtUqR
         tyM/sn9CVrZoqsPECqpC25DMg+jMlhGRlobECOSWWNXvLY2diq1tCljstJKvIOFeQLvj
         AtZVCwK1GGr/BCPMimzc+W2BYi1KdIY1sBX4w5l+eKSOj6H5Bg9UwIXDt5/TuSGIfwKV
         N4Yoj60f7uTGHaNuiLVt2yLmjpZ6LY0KoR0e/IcSLhb5QtWGu0XbeHxXjT1AdzlHATWt
         nO0g==
X-Gm-Message-State: APjAAAXXG7X8H+ScoFh49acmbAtK7tjjF4xn8TEmdFHB7j+59VXNGD9o
        X8dWXq2HIAj4n+c59AmGrwkYS0id
X-Google-Smtp-Source: APXvYqwIGm5Zz03HYQHIVB0g2CuG2FbslQB7WU/e3N5HyW1LQY9VqHsDhUFjmjEPbxx6Rq1nMc2mhw==
X-Received: by 2002:a17:906:3c5:: with SMTP id c5mr24731270eja.24.1553795438992;
        Thu, 28 Mar 2019 10:50:38 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r13sm4712459edl.12.2019.03.28.10.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 10:50:37 -0700 (PDT)
Subject: Re: [PATCH v4 1/4] drm: rockchip: introduce rk3066 hdmi
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190306224113.24853-1-jbx6244@gmail.com>
 <20190306224113.24853-2-jbx6244@gmail.com> <4125149.ebfS1HlHkS@diego>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <3f6267ba-82a6-0c58-8a2b-ebce2cb5c650@gmail.com>
Date:   Thu, 28 Mar 2019 18:50:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4125149.ebfS1HlHkS@diego>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Question for Heiko cs. See below.
Let me know if there's a need for V6?

On 3/19/19 12:44 PM, Heiko Stübner wrote:

> Am Mittwoch, 6. März 2019, 23:41:10 CET schrieb Johan Jonker:

>> +static int rk3066_hdmi_connector_get_modes(struct drm_connector *connector)
>> +{
>> +	struct rk3066_hdmi *hdmi = to_rk3066_hdmi(connector);
>> +	struct edid *edid;
>> +	int ret = 0;
>> +

Is this OK or drop it?
	hdmi->hdmi_data.sink_is_hdmi = false;

>> +	if (!hdmi->ddc)
>> +		return 0;
>> +
>> +	edid = drm_get_edid(connector, hdmi->ddc);
>> +	if (edid) {
>> +		hdmi->hdmi_data.sink_is_hdmi = drm_detect_hdmi_monitor(edid);
>> +		drm_connector_update_edid_property(connector, edid);
>> +		ret = drm_add_edid_modes(connector, edid);
>> +		kfree(edid);
>> +	}
>> +

>> +
>> +	return ret;
>> +}



>> +static int rk3066_hdmi_bind(struct device *dev, struct device *master,
>> +			    void *data)
>> +{
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +	struct drm_device *drm = data;
>> +	struct rk3066_hdmi *hdmi;
>> +	struct resource *iores;
>> +	int irq;
>> +	int ret;
>> +
>> +	hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
>> +	if (!hdmi)
>> +		return -ENOMEM;
>> +
>> +	hdmi->dev = dev;
>> +	hdmi->drm_dev = drm;
>> +
>> +	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!iores)
>> +		return -ENXIO;
>> +
>> +	hdmi->regs = devm_ioremap_resource(dev, iores);
>> +	if (IS_ERR(hdmi->regs))
>> +		return PTR_ERR(hdmi->regs);
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0)
>> +		return irq;
>> +
>> +	hdmi->hclk = devm_clk_get(dev, "hclk");
>> +	if (IS_ERR(hdmi->hclk)) {
>> +		dev_err(dev, "unable to get HDMI hclk clock\n");
>> +		return PTR_ERR(hdmi->hclk);
>> +	}
>> +
>> +	ret = clk_prepare_enable(hdmi->hclk);
>> +	if (ret) {
>> +		dev_err(dev, "cannot enable HDMI hclk clock: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	hdmi->grf = syscon_regmap_lookup_by_phandle(dev->of_node,
>> +						    "rockchip,grf");
>> +	if (IS_ERR(hdmi->grf)) {
>> +		dev_err(dev, "unable to get rockchip,grf\n");
>> +		ret = PTR_ERR(hdmi->grf);
>> +		goto err_disable_hclk;
>> +	}
>> +
>> +	/* internal hclk = hdmi_hclk / 25 */
>> +	hdmi_writeb(hdmi, HDMI_INTERNAL_CLK_DIVIDER, 25);
>> +
>> +	hdmi->ddc = rk3066_hdmi_i2c_adapter(hdmi);
>> +	if (IS_ERR(hdmi->ddc)) {
>> +		ret = PTR_ERR(hdmi->ddc);
>> +		hdmi->ddc = NULL;
>> +		goto err_disable_hclk;
>> +	}
>> +
>> +	rk3066_hdmi_set_power_mode(hdmi, HDMI_SYS_POWER_MODE_B);
>> +	usleep_range(999, 1000);
>> +	hdmi_writeb(hdmi, HDMI_INTR_MASK1, HDMI_INTR_HOTPLUG);
>> +	hdmi_writeb(hdmi, HDMI_INTR_MASK2, 0);
>> +	hdmi_writeb(hdmi, HDMI_INTR_MASK3, 0);
>> +	hdmi_writeb(hdmi, HDMI_INTR_MASK4, 0);
>> +	rk3066_hdmi_set_power_mode(hdmi, HDMI_SYS_POWER_MODE_A);
>> +

The function rk3066_hdmi_register() inits an encoder and connector.

>> +	ret = rk3066_hdmi_register(drm, hdmi);
>> +	if (ret)
>> +		goto err_disable_hclk;
> 
> goto err_disable_i2c;
> 
> So that the i2c-adapter also gets disabled on error.
> 
>> +	dev_set_drvdata(dev, hdmi);
>> +
>> +	ret = devm_request_threaded_irq(dev, irq, rk3066_hdmi_hardirq,
>> +					rk3066_hdmi_irq, IRQF_SHARED,
>> +					dev_name(dev), hdmi);
>> +	if (ret) {
>> +		dev_err(dev, "failed to request hdmi irq: %d\n", ret);
>> +		goto err_disable_hclk;
> 

If an error happens here the encoder and connector also have to be
removed like in the inno driver. Is that correct?
Change this to:

goto err_cleanup_hdmi;

> goto err_disable_i2c;
> 
>> +	}
>> +
>> +	return 0;
>> +
> 

What goto name would you like to have here?

err_cleanup_hdmi:
	hdmi->connector.funcs->destroy(&hdmi->connector);
	hdmi->encoder.funcs->destroy(&hdmi->encoder);

> err_disable_i2c:
> 	i2c_put_adapter(hdmi->ddc);
> 
>> +err_disable_hclk:
>> +	clk_disable_unprepare(hdmi->hclk);
>> +
>> +	return ret;
>> +}
>> +

