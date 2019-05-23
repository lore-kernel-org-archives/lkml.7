Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791E8C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2829E20879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BQAIxqLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbfEWJKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:10:23 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39022 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfEWJKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gvMc8e1blxSFjrQAJfdsPT3oO6xm8lpzhMKEL0P1bLs=; b=BQAIxqLQooHeCeK5WVsEqQJZK
        kU0lC15VHB4iOLCjEo0UuhKfX4y3viK6OP2dG0YQ9oOblQk2b4q3HSwNPIMmny14TRWG4UCozKlA5
        LSeXNBB/Cx6oiH5VNEEfnZAY/pKVf0akXlbK3NNsibQl2F/PxFqGh/k4so0wtQH01qhLM1Fbq75Ne
        YKz05O5L1cM3FGJVNtTd0z8KF/MEl/sHFwI0BNvvLltd0H58QCZ9AjfNFLqy7MuRGwJdTx2ONuCFP
        WONoC+lPgkCDImHd509WqDqdqe4Yw1v/jnV0G0nl6/IYVwSU4Mq57bogLMImeNpQCiBDUfMUt+oha
        dwaTv+zrQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:38254)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hTjjQ-0004gL-Ex; Thu, 23 May 2019 10:09:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hTjjK-0007V5-1i; Thu, 23 May 2019 10:09:42 +0100
Date:   Thu, 23 May 2019 10:09:41 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "agross@kernel.org" <agross@kernel.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V6 1/2] soc: imx: Add SCU SoC info driver support
Message-ID: <20190523090941.zd4rbvcimgit5lq5@shell.armlinux.org.uk>
References: <1558586911-29309-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558586911-29309-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 04:53:46AM +0000, Anson Huang wrote:
> Add i.MX SCU SoC info driver to support i.MX8QXP SoC, introduce
> driver dependency into Kconfig as CONFIG_IMX_SCU must be
> selected to support i.MX SCU SoC driver, also need to use
> platform driver model to make sure IMX_SCU driver is probed
> before i.MX SCU SoC driver.

This seems buggy...

> +static int imx_scu_soc_probe(struct platform_device *pdev)
> +{
> +	struct soc_device_attribute *soc_dev_attr;
> +	struct soc_device *soc_dev;
> +	u32 id, val;
> +	int ret;
> +
> +	ret = imx_scu_get_handle(&soc_ipc_handle);
> +	if (ret)
> +		return ret;
> +
> +	soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr),
> +				    GFP_KERNEL);
> +	if (!soc_dev_attr)
> +		return -ENOMEM;
> +
> +	soc_dev_attr->family = "Freescale i.MX";
> +
> +	ret = of_property_read_string(of_root,
> +				      "model",
> +				      &soc_dev_attr->machine);
> +	if (ret)
> +		return ret;
> +
> +	id = imx_scu_soc_id();
> +
> +	/* format soc_id value passed from SCU firmware */
> +	val = id & 0x1f;
> +	soc_dev_attr->soc_id = val ? kasprintf(GFP_KERNEL, "0x%x", val)
> +			       : "unknown";

soc_id can either be an allocated string, or it can be a static string
of "unknown".

> +	if (!soc_dev_attr->soc_id)
> +		return -ENOMEM;
> +
> +	/* format revision value passed from SCU firmware */
> +	val = (id >> 5) & 0xf;
> +	val = (((val >> 2) + 1) << 4) | (val & 0x3);
> +	soc_dev_attr->revision = val ? kasprintf(GFP_KERNEL,
> +						 "%d.%d",
> +						 (val >> 4) & 0xf,
> +						 val & 0xf) : "unknown";

revision here is the same.

> +	if (!soc_dev_attr->revision) {
> +		ret = -ENOMEM;
> +		goto free_soc_id;
> +	}
> +
> +	soc_dev = soc_device_register(soc_dev_attr);
> +	if (IS_ERR(soc_dev)) {
> +		ret = PTR_ERR(soc_dev);
> +		goto free_revision;
> +	}
> +
> +	return 0;
> +
> +free_revision:
> +	kfree(soc_dev_attr->revision);
> +free_soc_id:
> +	kfree(soc_dev_attr->soc_id);

Yet here you blindly kfree(), which means you could be doing in effect
kfree("unknown") - which will likely result in a kernel oops.

Either always make revision/soc_id an allocated string, or use some
static storage for the strings (they're only small, static storage is
likely to be much more efficient in this case, and there can only be
one of these in any case.)

> +	return ret;
> +}
> +
> +static struct platform_driver imx_scu_soc_driver = {
> +	.driver = {
> +		.name = IMX_SCU_SOC_DRIVER_NAME,
> +	},
> +	.probe = imx_scu_soc_probe,
> +};
> +
> +static int __init imx_scu_soc_init(void)
> +{
> +	struct platform_device *imx_scu_soc_pdev;
> +	struct device_node *np;
> +	int ret;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx-scu");
> +	if (!np)
> +		return -ENODEV;
> +
> +	of_node_put(np);
> +
> +	ret = platform_driver_register(&imx_scu_soc_driver);
> +	if (ret)
> +		return ret;
> +
> +	imx_scu_soc_pdev =
> +		platform_device_register_simple(IMX_SCU_SOC_DRIVER_NAME,
> +						-1,
> +						NULL,
> +						0);
> +	if (IS_ERR(imx_scu_soc_pdev))
> +		platform_driver_unregister(&imx_scu_soc_driver);
> +
> +	return PTR_ERR_OR_ZERO(imx_scu_soc_pdev);
> +}
> +device_initcall(imx_scu_soc_init);
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
