Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694F6CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3266820650
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kejZajiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfKDPOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:14:55 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40602 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfKDPOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:14:54 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA4FEWtW082531;
        Mon, 4 Nov 2019 09:14:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572880472;
        bh=h0Sfsp9psoHlAH0L5ZhvIbodfIi+1/unXj3Z6iImMNY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kejZajiSHQD5G0Eg97zB9t5UnX8SCrVoZvk1wQN+X5yYInIQEFa6yPNBY2rZ+H6Vt
         ausOZCdQKnRmJPRCTg7kZJxyXq9RnSARE9VBM/fKnkR0Pui6bz+wWNwrmyxskw7z0v
         6FjLNNohfuiv8DOSnvKyBUQ1Sny87axJ/iLIG8e8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA4FEWLk101598
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Nov 2019 09:14:32 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 4 Nov
 2019 09:14:17 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 4 Nov 2019 09:14:17 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA4FESFC069153;
        Mon, 4 Nov 2019 09:14:29 -0600
Subject: Re: [PATCH v4 2/2] usb: cdns3: Add TI specific wrapper driver
To:     Greg KH <gregkh@linuxfoundation.org>,
        <felipe.balbi@linux.intel.com>
CC:     <pawell@cadence.com>, <peter.chen@nxp.com>, <nsekhar@ti.com>,
        <kurahul@cadence.com>, <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20191028093249.22822-1-rogerq@ti.com>
 <20191028093249.22822-3-rogerq@ti.com> <20191104144752.GB2183570@kroah.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <2bd9cf7a-d48c-3975-ec46-b663d11359f6@ti.com>
Date:   Mon, 4 Nov 2019 17:14:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104144752.GB2183570@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/11/2019 16:47, Greg KH wrote:
> On Mon, Oct 28, 2019 at 11:32:49AM +0200, Roger Quadros wrote:
>> The J721e platform comes with 2 Cadence USB3 controller
>> instances. This driver supports the TI specific wrapper
>> on this platform.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> Reviewed-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>   drivers/usb/cdns3/Kconfig    |  10 ++
>>   drivers/usb/cdns3/Makefile   |   1 +
>>   drivers/usb/cdns3/cdns3-ti.c | 236 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 247 insertions(+)
>>   create mode 100644 drivers/usb/cdns3/cdns3-ti.c
>>
>> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
>> index d0331613a355..2a1e89d12ed9 100644
>> --- a/drivers/usb/cdns3/Kconfig
>> +++ b/drivers/usb/cdns3/Kconfig
>> @@ -43,4 +43,14 @@ config USB_CDNS3_PCI_WRAP
>>   	  If you choose to build this driver as module it will
>>   	  be dynamically linked and module will be called cdns3-pci.ko
>>   
>> +config USB_CDNS3_TI
>> +	tristate "Cadence USB3 support on TI platforms"
>> +	depends on ARCH_K3 || COMPILE_TEST
>> +	default USB_CDNS3
>> +	help
>> +	  Say 'Y' or 'M' here if you are building for Texas Instruments
>> +	  platforms that contain Cadence USB3 controller core.
>> +
>> +	  e.g. J721e.
>> +
>>   endif
>> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
>> index a703547350bb..948e6b88d1a9 100644
>> --- a/drivers/usb/cdns3/Makefile
>> +++ b/drivers/usb/cdns3/Makefile
>> @@ -14,3 +14,4 @@ endif
>>   cdns3-$(CONFIG_USB_CDNS3_HOST)		+= host.o
>>   
>>   obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+= cdns3-pci-wrap.o
>> +obj-$(CONFIG_USB_CDNS3_TI)		+= cdns3-ti.o
>> diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
>> new file mode 100644
>> index 000000000000..c6a79ca15858
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/cdns3-ti.c
>> @@ -0,0 +1,236 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/**
>> + * cdns3-ti.c - TI specific Glue layer for Cadence USB Controller
>> + *
>> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
>> + */
>> +
>> +#include <linux/bits.h>
>> +#include <linux/clk.h>
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/io.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/pm_runtime.h>
>> +
>> +/* USB Wrapper register offsets */
>> +#define USBSS_PID		0x0
>> +#define	USBSS_W1		0x4
>> +#define USBSS_STATIC_CONFIG	0x8
>> +#define USBSS_PHY_TEST		0xc
>> +#define	USBSS_DEBUG_CTRL	0x10
>> +#define	USBSS_DEBUG_INFO	0x14
>> +#define	USBSS_DEBUG_LINK_STATE	0x18
>> +#define	USBSS_DEVICE_CTRL	0x1c
>> +
>> +/* Wrapper 1 register bits */
>> +#define USBSS_W1_PWRUP_RST		BIT(0)
>> +#define USBSS_W1_OVERCURRENT_SEL	BIT(8)
>> +#define USBSS_W1_MODESTRAP_SEL		BIT(9)
>> +#define USBSS_W1_OVERCURRENT		BIT(16)
>> +#define USBSS_W1_MODESTRAP_MASK		GENMASK(18, 17)
>> +#define USBSS_W1_MODESTRAP_SHIFT	17
>> +#define USBSS_W1_USB2_ONLY		BIT(19)
>> +
>> +/* Static config register bits */
>> +#define USBSS1_STATIC_PLL_REF_SEL_MASK	GENMASK(8, 5)
>> +#define USBSS1_STATIC_PLL_REF_SEL_SHIFT	5
>> +#define USBSS1_STATIC_LOOPBACK_MODE_MASK	GENMASK(4, 3)
>> +#define USBSS1_STATIC_LOOPBACK_MODE_SHIFT	3
>> +#define USBSS1_STATIC_VBUS_SEL_MASK	GENMASK(2, 1)
>> +#define USBSS1_STATIC_VBUS_SEL_SHIFT	1
>> +#define USBSS1_STATIC_LANE_REVERSE	BIT(0)
>> +
>> +/* Modestrap modes */
>> +enum modestrap_mode { USBSS_MODESTRAP_MODE_NONE,
>> +		      USBSS_MODESTRAP_MODE_HOST,
>> +		      USBSS_MODESTRAP_MODE_PERIPHERAL};
>> +
>> +struct cdns_ti {
>> +	struct device *dev;
>> +	void __iomem *usbss;
>> +	int usb2_only:1;
>> +	int vbus_divider:1;
> 
> 'bool' instead of bitfields?  Makes it more obvious, right?
> 

right.

>> +	struct clk *usb2_refclk;
>> +	struct clk *lpm_clk;
>> +};
>> +
>> +static const int cdns_ti_rate_table[] = {	/* in KHZ */
>> +	9600,
>> +	10000,
>> +	12000,
>> +	19200,
>> +	20000,
>> +	24000,
>> +	25000,
>> +	26000,
>> +	38400,
>> +	40000,
>> +	58000,
>> +	50000,
>> +	52000,
>> +};
>> +
>> +static inline u32 cdns_ti_readl(struct cdns_ti *data, u32 offset)
>> +{
>> +	return readl(data->usbss + offset);
>> +}
> 
> Does sparse like this function?
> 

It doesn't complain.

>> +
>> +static inline void cdns_ti_writel(struct cdns_ti *data, u32 offset, u32 value)
>> +{
>> +	writel(value, data->usbss + offset);
> 
> Same here, have you run sparse on this code?

I hadn't but now that I run i only see these errors.

   CHECK   drivers/usb/cdns3/cdns3-ti.c
drivers/usb/cdns3/cdns3-ti.c:55:24: error: dubious one-bit signed bitfield
drivers/usb/cdns3/cdns3-ti.c:56:27: error: dubious one-bit signed bitfield

> 
>> +}
>> +
>> +static int cdns_ti_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *node = pdev->dev.of_node;
>> +	struct cdns_ti *data;
>> +	int error;
>> +	u32 reg;
>> +	int rate_code, i;
>> +	unsigned long rate;
>> +
>> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, data);
>> +
>> +	data->dev = dev;
>> +
>> +	data->usbss = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(data->usbss)) {
>> +		dev_err(dev, "can't map IOMEM resource\n");
> 
> Doesn't the function print an error?

It does.
> 
>> +		return PTR_ERR(data->usbss);
>> +	}
>> +
>> +	data->usb2_refclk = devm_clk_get(dev, "ref");
>> +	if (IS_ERR(data->usb2_refclk)) {
>> +		dev_err(dev, "can't get usb2_refclk\n");
> 
> Again, doesn't the function print an error?

No.

> 
>> +		return PTR_ERR(data->usb2_refclk);
>> +	}
>> +
>> +	data->lpm_clk = devm_clk_get(dev, "lpm");
>> +	if (IS_ERR(data->lpm_clk)) {
>> +		dev_err(dev, "can't get lpm_clk\n");
> 
> Same?
> 
>> +		return PTR_ERR(data->lpm_clk);
>> +	}
>> +
>> +	rate = clk_get_rate(data->usb2_refclk);
>> +	rate /= 1000;	/* To KHz */
>> +	for (i = 0; i < ARRAY_SIZE(cdns_ti_rate_table); i++) {
>> +		if (cdns_ti_rate_table[i] == rate)
>> +			break;
>> +	}
>> +
>> +	if (i == ARRAY_SIZE(cdns_ti_rate_table)) {
>> +		dev_err(dev, "unsupported usb2_refclk rate: %lu KHz\n", rate);
> 
> What can userspace do about this?

Nothing, but it would help us identify the issue on customer boards.

> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	rate_code = i;
>> +
>> +	pm_runtime_enable(dev);
>> +	error = pm_runtime_get_sync(dev);
>> +	if (error < 0) {
>> +		dev_err(dev, "pm_runtime_get_sync failed: %d\n", error);
> 
> Again, the call should print the error, right?

It doesn't.
> 
>> +		goto err_get;
>> +	}
>> +
>> +	/* assert RESET */
>> +	reg = cdns_ti_readl(data, USBSS_W1);
>> +	reg &= ~USBSS_W1_PWRUP_RST;
>> +	cdns_ti_writel(data, USBSS_W1, reg);
>> +
>> +	/* set static config */
>> +	reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
>> +	reg &= ~USBSS1_STATIC_PLL_REF_SEL_MASK;
>> +	reg |= rate_code << USBSS1_STATIC_PLL_REF_SEL_SHIFT;
>> +
>> +	reg &= ~USBSS1_STATIC_VBUS_SEL_MASK;
>> +	data->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
>> +	if (data->vbus_divider)
>> +		reg |= 1 << USBSS1_STATIC_VBUS_SEL_SHIFT;
>> +
>> +	cdns_ti_writel(data, USBSS_STATIC_CONFIG, reg);
>> +	reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
>> +
>> +	/* set USB2_ONLY mode if requested */
>> +	reg = cdns_ti_readl(data, USBSS_W1);
>> +	data->usb2_only = device_property_read_bool(dev, "ti,usb2-only");
>> +	if (data->usb2_only)
>> +		reg |= USBSS_W1_USB2_ONLY;
>> +
>> +	/* set default modestrap */
>> +	reg |= USBSS_W1_MODESTRAP_SEL;
>> +	reg &= ~USBSS_W1_MODESTRAP_MASK;
>> +	reg |= USBSS_MODESTRAP_MODE_NONE << USBSS_W1_MODESTRAP_SHIFT;
>> +	cdns_ti_writel(data, USBSS_W1, reg);
>> +
>> +	/* de-assert RESET */
>> +	reg |= USBSS_W1_PWRUP_RST;
>> +	cdns_ti_writel(data, USBSS_W1, reg);
>> +
>> +	error = of_platform_populate(node, NULL, NULL, dev);
>> +	if (error) {
>> +		dev_err(dev, "failed to create children: %d\n", error);
> 
> Again, error in the caller?

doesn't seem like so.


Felipe,

Do you want me to send a diff with the changes or a revised patch?

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
