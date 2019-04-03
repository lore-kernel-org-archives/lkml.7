Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A672C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA46220830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vQGr/uzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDCKBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:01:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38803 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDCKBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:01:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id g37so7778721plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 03:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IkiQbk/kdRbQPbEHiNEScBeB2RnhPojQnKWPWkgAft4=;
        b=vQGr/uzDDu/XN0ib94P3PbFB6Lu89bJd+5neMsN98HFHrML3coC3rod0GW0yo4z9vT
         GCztFF+PKY8BJ39UZfm5bAg9NLiIcGoUDzfNzBi6ATQJkuQ0cT4gRNipJAWBN9jGpsG/
         4IBxJMEhRv6NVhConxWyGhRIuOZxSesKcAaBDu3kv7LtU64vOUhwmJihehrt8KjPfqte
         0aoJG8OMxywwTpCgVdDBdQLvKElHpIAGfAMkF3/l6oowdYViCfZnZw41+aYSTk7OuV5o
         T5n6befYqJ0bvIySouKnJftlnEkZWlp0Mcsbcwpm3MszznA5cY4hVxth4vbM56IVPA01
         pP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IkiQbk/kdRbQPbEHiNEScBeB2RnhPojQnKWPWkgAft4=;
        b=Gj+iasV0HUpwkfvAB00uzWtMZJ4211mGj08C12L2loyvE67sIyquxL1mrLc4LO0Xeb
         leu5ImngaFjZlVobikVsFxI5lJEXftNiFOkTTXXi5NG/EtYxA1EJNrmlFfNnoTpcy3pa
         RiTOzMy+KUKEMg8Hhne5qYQLZdaAu7OweACpjR8iTRbb6nS5H77pvo26/37E0cJ1Z9eZ
         qawnG0LkabdF61IS+5T5fYUYMezwlJw77MVe42f0OnQ8A0Q8MJ4JhVUYmENuZsTMo/ot
         nWXIe8w8u/4V/nx2En4b+uSEpyvA13Xm877rXQkWyWL/pw9m0gSPkWwv94iH1/ZdTTHI
         uQXw==
X-Gm-Message-State: APjAAAW44jKb9tcxY4tYh4kkxAG+Dc6H0Rzg/he7/QL8WvxAMeaW3eRl
        b9VJU4YnW7V4/IVnQsPsGVX1UQ==
X-Google-Smtp-Source: APXvYqw5Wk4WBONpaJUgvU5qVZ/4opGe4bbLCImLiA1ukZ3H1q9DnSYvCx8p7KDmOztUP5dG/h0yhA==
X-Received: by 2002:a17:902:e002:: with SMTP id ca2mr63819684plb.131.1554285667825;
        Wed, 03 Apr 2019 03:01:07 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id e4sm17887998pfh.146.2019.04.03.03.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 03:01:07 -0700 (PDT)
Date:   Wed, 3 Apr 2019 11:01:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v4 2/9] mfd: Add ST Multi-Function eXpander (STMFX) core
 driver
Message-ID: <20190403100101.GK11301@dell>
References: <1551260094-32570-1-git-send-email-amelie.delaunay@st.com>
 <1551260094-32570-3-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1551260094-32570-3-git-send-email-amelie.delaunay@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019, Amelie Delaunay wrote:

> STMicroelectronics Multi-Function eXpander (STMFX) is a slave controller
> using I2C for communication with the main MCU. Main features are:
> - 16 fast GPIOs individually configurable in input/output
> - 8 alternate GPIOs individually configurable in input/output when other
> STMFX functions are not used
> - Main MCU IDD measurement
> - Resistive touchscreen controller
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  drivers/mfd/Kconfig       |  13 ++
>  drivers/mfd/Makefile      |   2 +-
>  drivers/mfd/stmfx.c       | 568 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/stmfx.h | 123 ++++++++++
>  4 files changed, 705 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mfd/stmfx.c
>  create mode 100644 include/linux/mfd/stmfx.h

Very nice first attempt for what is a pretty complex driver.

Just a couple of nits below.

[...]

> +static int stmfx_chip_init(struct i2c_client *client)
> +{
> +	struct stmfx *stmfx = i2c_get_clientdata(client);
> +	u32 id;
> +	u8 version[2];
> +	int ret;
> +
> +	stmfx->vdd = devm_regulator_get_optional(&client->dev, "vdd");
> +	if (IS_ERR(stmfx->vdd)) {
> +		ret = PTR_ERR(stmfx->vdd);
> +		if (ret != -ENODEV) {
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(&client->dev,
> +					"No VDD regulator found:%d\n", ret);

Actually -ENODEV means this, which is okay.

In this case we failed to obtain a provided regulator.

> +			return ret;
> +		}
> +	} else {

	if (IS_ERR(stmfx->vdd) && PTR_ERR(stmfx->vdd) == -EPROBE_DEFER) {
		return PTR_ERR(stmfx->vdd);
	} else (IS_ERR(stmfx->vdd) && PTR_ERR(stmfx->vdd) == -ENODEV) {
		stmfx->vdd = NULL;
	} else (IS_ERR(stmfx->vdd))) {
		dev_err(&client->dev, "Failed to get VDD regulator:%d\n", ret);
		return PTR_ERR(stmfx->vdd);
	}

	if (stmfx->vdd) {

> +		ret = regulator_enable(stmfx->vdd);
> +		if (ret) {
> +			dev_err(&client->dev, "VDD enable failed: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +

[...]

> +static const struct resource stmfx_ts_resources[] = {
> +	DEFINE_RES_IRQ(STMFX_REG_IRQ_SRC_EN_TS_DET),
> +	DEFINE_RES_IRQ(STMFX_REG_IRQ_SRC_EN_TS_NE),
> +	DEFINE_RES_IRQ(STMFX_REG_IRQ_SRC_EN_TS_TH),
> +	DEFINE_RES_IRQ(STMFX_REG_IRQ_SRC_EN_TS_FULL),
> +	DEFINE_RES_IRQ(STMFX_REG_IRQ_SRC_EN_TS_OVF),
> +};

Please move everything from here --------------->

> +static struct mfd_cell stmfx_cells[] = {
> +	{
> +		.of_compatible = "st,stmfx-0300-pinctrl",
> +		.name = "stmfx-pinctrl",
> +		.resources = stmfx_pinctrl_resources,
> +		.num_resources = ARRAY_SIZE(stmfx_pinctrl_resources),
> +	},
> +	{
> +		.of_compatible = "st,stmfx-0300-idd",
> +		.name = "stmfx-idd",
> +		.resources = stmfx_idd_resources,
> +		.num_resources = ARRAY_SIZE(stmfx_idd_resources),
> +	},
> +	{
> +		.of_compatible = "st,stmfx-0300-ts",
> +		.name = "stmfx-ts",
> +		.resources = stmfx_ts_resources,
> +		.num_resources = ARRAY_SIZE(stmfx_ts_resources),
> +	},
> +};
> +
> +static bool stmfx_reg_volatile(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case STMFX_REG_SYS_CTRL:
> +	case STMFX_REG_IRQ_SRC_EN:
> +	case STMFX_REG_IRQ_PENDING:
> +	case STMFX_REG_IRQ_GPI_PENDING1:
> +	case STMFX_REG_IRQ_GPI_PENDING2:
> +	case STMFX_REG_IRQ_GPI_PENDING3:
> +	case STMFX_REG_GPIO_STATE1:
> +	case STMFX_REG_GPIO_STATE2:
> +	case STMFX_REG_GPIO_STATE3:
> +	case STMFX_REG_IRQ_GPI_SRC1:
> +	case STMFX_REG_IRQ_GPI_SRC2:
> +	case STMFX_REG_IRQ_GPI_SRC3:
> +	case STMFX_REG_GPO_SET1:
> +	case STMFX_REG_GPO_SET2:
> +	case STMFX_REG_GPO_SET3:
> +	case STMFX_REG_GPO_CLR1:
> +	case STMFX_REG_GPO_CLR2:
> +	case STMFX_REG_GPO_CLR3:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool stmfx_reg_writeable(struct device *dev, unsigned int reg)
> +{
> +	return (reg >= STMFX_REG_SYS_CTRL);
> +}
> +
> +static const struct regmap_config stmfx_regmap_config = {
> +	.reg_bits	= 8,
> +	.reg_stride	= 1,
> +	.val_bits	= 8,
> +	.max_register	= STMFX_REG_MAX,
> +	.volatile_reg	= stmfx_reg_volatile,
> +	.writeable_reg	= stmfx_reg_writeable,
> +	.cache_type	= REGCACHE_RBTREE,
> +};

----------------------->

... to here, up to the top, just below the includes.

> +static int stmfx_probe(struct i2c_client *client,
> +		       const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct stmfx *stmfx;
> +	int i, ret;
> +
> +	stmfx = devm_kzalloc(dev, sizeof(*stmfx), GFP_KERNEL);
> +	if (!stmfx)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, stmfx);
> +
> +	stmfx->dev = dev;
> +
> +	stmfx->map = devm_regmap_init_i2c(client, &stmfx_regmap_config);
> +	if (IS_ERR(stmfx->map)) {
> +		ret = PTR_ERR(stmfx->map);
> +		dev_err(dev, "Failed to allocate register map: %d\n", ret);
> +		return ret;
> +	}
> +
> +	mutex_init(&stmfx->lock);
> +
> +	ret = stmfx_chip_init(client);
> +	if (ret) {
> +		if (ret == -ETIMEDOUT)
> +			return -EPROBE_DEFER;
> +		return ret;
> +	}
> +
> +	if (client->irq < 0) {
> +		dev_err(dev, "Failed to get IRQ: %d\n", client->irq);
> +		ret = client->irq;
> +		goto err_chip_exit;
> +	}
> +
> +	ret = stmfx_irq_init(client);
> +	if (ret)
> +		goto err_chip_exit;
> +
> +	for (i = 0; i < ARRAY_SIZE(stmfx_cells); i++) {
> +		stmfx_cells[i].platform_data = stmfx;
> +		stmfx_cells[i].pdata_size = sizeof(struct stmfx);
> +	}

Pass this though dev_get_drvdata() instead.

...

Actually, didn't you already set this with i2c_set_clientdata()?  That
does exactly the same thing.  So you can get this back from the client
via i2c_get_clientdata().  No need to send it though platform data.

> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> +				   stmfx_cells, ARRAY_SIZE(stmfx_cells), NULL,
> +				   0, stmfx->irq_domain);
> +	if (ret)
> +		goto err_irq_exit;
> +
> +	return 0;
> +
> +err_irq_exit:
> +	stmfx_irq_exit(client);
> +err_chip_exit:
> +	stmfx_chip_exit(client);
> +
> +	return ret;
> +}
> +
> +static int stmfx_remove(struct i2c_client *client)
> +{
> +	stmfx_irq_exit(client);
> +
> +	return stmfx_chip_exit(client);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int stmfx_backup_regs(struct stmfx *stmfx)
> +{
> +	int ret;
> +
> +	ret = regmap_raw_read(stmfx->map, STMFX_REG_SYS_CTRL,
> +			      &stmfx->bkp_sysctrl, sizeof(stmfx->bkp_sysctrl));
> +	if (ret)
> +		return ret;

'\n' here.

> +	ret = regmap_raw_read(stmfx->map, STMFX_REG_IRQ_OUT_PIN,
> +			      &stmfx->bkp_irqoutpin,
> +			      sizeof(stmfx->bkp_irqoutpin));
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int stmfx_restore_regs(struct stmfx *stmfx)
> +{
> +	int ret;
> +
> +	ret = regmap_raw_write(stmfx->map, STMFX_REG_SYS_CTRL,
> +			       &stmfx->bkp_sysctrl, sizeof(stmfx->bkp_sysctrl));
> +	if (ret)
> +		return ret;

'\n' here.

> +	ret = regmap_raw_write(stmfx->map, STMFX_REG_IRQ_OUT_PIN,
> +			       &stmfx->bkp_irqoutpin,
> +			       sizeof(stmfx->bkp_irqoutpin));
> +	if (ret)
> +		return ret;

'\n' here.

> +	ret = regmap_raw_write(stmfx->map, STMFX_REG_IRQ_SRC_EN,
> +			       &stmfx->irq_src, sizeof(stmfx->irq_src));
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int stmfx_suspend(struct device *dev)
> +{
> +	struct stmfx *stmfx = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = stmfx_backup_regs(stmfx);

Don't think you need a separate function for this.  Just move the
regmap_raw_write() commands here.

> +	if (ret) {
> +		dev_err(stmfx->dev, "Registers backup failure\n");
> +		return ret;
> +	}
> +
> +	if (!IS_ERR(stmfx->vdd)) {
> +		ret = regulator_disable(stmfx->vdd);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int stmfx_resume(struct device *dev)
> +{
> +	struct stmfx *stmfx = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!IS_ERR(stmfx->vdd)) {
> +		ret = regulator_enable(stmfx->vdd);
> +		if (ret) {
> +			dev_err(stmfx->dev,
> +				"VDD enable failed: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = stmfx_restore_regs(stmfx);

As above.

> +	if (ret) {
> +		dev_err(stmfx->dev, "Registers restoration failure\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(stmfx_dev_pm_ops, stmfx_suspend, stmfx_resume);
> +
> +static const struct of_device_id stmfx_of_match[] = {
> +	{ .compatible = "st,stmfx-0300", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, stmfx_of_match);
> +
> +static struct i2c_driver stmfx_driver = {
> +	.driver = {
> +		.name = "stmfx-core",
> +		.of_match_table = of_match_ptr(stmfx_of_match),
> +		.pm = &stmfx_dev_pm_ops,
> +	},
> +	.probe = stmfx_probe,
> +	.remove = stmfx_remove,
> +};
> +module_i2c_driver(stmfx_driver);
> +
> +MODULE_DESCRIPTION("STMFX core driver");
> +MODULE_AUTHOR("Amelie Delaunay <amelie.delaunay@st.com>");
> +MODULE_LICENSE("GPL v2");

[...]

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
