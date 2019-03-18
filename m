Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CED1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E084D205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfCRKLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:11:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:42472 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbfCRKLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:11:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 03:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,493,1544515200"; 
   d="scan'208";a="123579062"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 18 Mar 2019 03:11:10 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h5pEb-0000qW-UP; Mon, 18 Mar 2019 12:11:09 +0200
Date:   Mon, 18 Mar 2019 12:11:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 2/2] extcon: mrfld: Introduce extcon driver for Basin
 Cove PMIC
Message-ID: <20190318101109.GP9224@smile.fi.intel.com>
References: <20190318095225.69200-1-andriy.shevchenko@linux.intel.com>
 <20190318095225.69200-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318095225.69200-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 12:52:25PM +0300, Andy Shevchenko wrote:
> TBD

Oops.
I though I have written it already.

I will wait for other comments today and sent a new version with commit message
filled as follows:

On Intel Merrifield the Basin Cove PMIC provides a feature to detect
the USB connection type. This driver utilizes the feature in order to support
the USB dual role detection.

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/Kconfig              |   7 +
>  drivers/extcon/Makefile             |   1 +
>  drivers/extcon/extcon-intel-mrfld.c | 256 ++++++++++++++++++++++++++++
>  3 files changed, 264 insertions(+)
>  create mode 100644 drivers/extcon/extcon-intel-mrfld.c
> 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index 8e17149655f0..75349c6cc89e 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -60,6 +60,13 @@ config EXTCON_INTEL_CHT_WC
>  	  Say Y here to enable extcon support for charger detection / control
>  	  on the Intel Cherrytrail Whiskey Cove PMIC.
>  
> +config EXTCON_INTEL_MRFLD

> +	tristate "Intel MErrifield Basin Cove PMIC extcon driver"

ME -> Me (will be fixed)

> +	depends on INTEL_SOC_PMIC_MRFLD
> +	help
> +	  Say Y here to enable extcon support for charger detection / control
> +	  on the Intel Merrifiel Basin Cove PMIC.
> +
>  config EXTCON_MAX14577
>  	tristate "Maxim MAX14577/77836 EXTCON Support"
>  	depends on MFD_MAX14577
> diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
> index 261ce4cfe209..d3941a735df3 100644
> --- a/drivers/extcon/Makefile
> +++ b/drivers/extcon/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_EXTCON_AXP288)	+= extcon-axp288.o
>  obj-$(CONFIG_EXTCON_GPIO)	+= extcon-gpio.o
>  obj-$(CONFIG_EXTCON_INTEL_INT3496) += extcon-intel-int3496.o
>  obj-$(CONFIG_EXTCON_INTEL_CHT_WC) += extcon-intel-cht-wc.o
> +obj-$(CONFIG_EXTCON_INTEL_MRFLD) += extcon-intel-mrfld.o
>  obj-$(CONFIG_EXTCON_MAX14577)	+= extcon-max14577.o
>  obj-$(CONFIG_EXTCON_MAX3355)	+= extcon-max3355.o
>  obj-$(CONFIG_EXTCON_MAX77693)	+= extcon-max77693.o
> diff --git a/drivers/extcon/extcon-intel-mrfld.c b/drivers/extcon/extcon-intel-mrfld.c
> new file mode 100644
> index 000000000000..d45db4975b5f
> --- /dev/null
> +++ b/drivers/extcon/extcon-intel-mrfld.c
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Extcon driver for Basin Cove PMIC
> + *
> + * Copyright (c) 2018, Intel Corporation.

2019 I suppose :-)

> + * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> + */
> +
> +#include <linux/extcon-provider.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/intel_soc_pmic.h>
> +#include <linux/mfd/intel_soc_pmic_mrfld.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include "extcon-intel.h"
> +
> +#define BCOVE_USBIDCTRL			0x19
> +#define BCOVE_USBIDCTRL_ID		BIT(0)
> +#define BCOVE_USBIDCTRL_ACA		BIT(1)
> +#define BCOVE_USBIDCTRL_ALL	(BCOVE_USBIDCTRL_ID | BCOVE_USBIDCTRL_ACA)
> +
> +#define BCOVE_USBIDSTS			0x1a
> +#define BCOVE_USBIDSTS_GND		BIT(0)
> +#define BCOVE_USBIDSTS_RARBRC_MASK	GENMASK(2, 1)
> +#define BCOVE_USBIDSTS_RARBRC_SHIFT	1
> +#define BCOVE_USBIDSTS_NO_ACA		0
> +#define BCOVE_USBIDSTS_R_ID_A		1
> +#define BCOVE_USBIDSTS_R_ID_B		2
> +#define BCOVE_USBIDSTS_R_ID_C		3
> +#define BCOVE_USBIDSTS_FLOAT		BIT(3)
> +#define BCOVE_USBIDSTS_SHORT		BIT(4)
> +
> +#define BCOVE_CHGRIRQ_ALL	(BCOVE_CHGRIRQ_VBUSDET | BCOVE_CHGRIRQ_DCDET | \
> +				 BCOVE_CHGRIRQ_BATTDET | BCOVE_CHGRIRQ_USBIDDET)
> +
> +#define BCOVE_CHGRCTRL0			0x4b
> +#define BCOVE_CHGRCTRL0_CHGRRESET	BIT(0)
> +#define BCOVE_CHGRCTRL0_EMRGCHREN	BIT(1)
> +#define BCOVE_CHGRCTRL0_EXTCHRDIS	BIT(2)
> +#define BCOVE_CHGRCTRL0_SWCONTROL	BIT(3)
> +#define BCOVE_CHGRCTRL0_TTLCK		BIT(4)
> +#define BCOVE_CHGRCTRL0_BIT_5		BIT(5)
> +#define BCOVE_CHGRCTRL0_BIT_6		BIT(6)
> +#define BCOVE_CHGRCTRL0_CHR_WDT_NOKICK	BIT(7)
> +
> +struct mrfld_extcon_data {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct extcon_dev *edev;
> +	unsigned int status;
> +	unsigned int id;
> +};
> +
> +static const unsigned int mrfld_extcon_cable[] = {
> +	EXTCON_USB,
> +	EXTCON_USB_HOST,
> +	EXTCON_CHG_USB_SDP,
> +	EXTCON_CHG_USB_CDP,
> +	EXTCON_CHG_USB_DCP,
> +	EXTCON_CHG_USB_ACA,
> +	EXTCON_NONE,
> +};
> +
> +static int mrfld_extcon_clear(struct mrfld_extcon_data *data, unsigned int reg,
> +			      unsigned int mask)
> +{
> +	return regmap_update_bits(data->regmap, reg, mask, 0x00);
> +}
> +
> +static int mrfld_extcon_set(struct mrfld_extcon_data *data, unsigned int reg,
> +			    unsigned int mask)
> +{
> +	return regmap_update_bits(data->regmap, reg, mask, 0xff);
> +}
> +
> +static int mrfld_extcon_get_id(struct mrfld_extcon_data *data)
> +{
> +	struct regmap *regmap = data->regmap;
> +	unsigned int id;
> +	bool ground;
> +	int ret;
> +
> +	ret = regmap_read(regmap, BCOVE_USBIDSTS, &id);
> +	if (ret)
> +		return ret;
> +
> +	if (id & BCOVE_USBIDSTS_FLOAT)
> +		return INTEL_USB_ID_FLOAT;
> +
> +	switch ((id & BCOVE_USBIDSTS_RARBRC_MASK) >> BCOVE_USBIDSTS_RARBRC_SHIFT) {
> +	case BCOVE_USBIDSTS_R_ID_A:
> +		return INTEL_USB_RID_A;
> +	case BCOVE_USBIDSTS_R_ID_B:
> +		return INTEL_USB_RID_B;
> +	case BCOVE_USBIDSTS_R_ID_C:
> +		return INTEL_USB_RID_C;
> +	}
> +
> +	/*
> +	 * PMIC A0 reports USBIDSTS_GND = 1 for ID_GND,
> +	 * but PMIC B0 reports USBIDSTS_GND = 0 for ID_GND.
> +	 * Thus we must check this bit at last.
> +	 */
> +	ground = id & BCOVE_USBIDSTS_GND;
> +	switch ('A' + BCOVE_MAJOR(data->id)) {
> +	case 'A':
> +		return ground ? INTEL_USB_ID_GND : INTEL_USB_ID_FLOAT;
> +	case 'B':
> +		return ground ? INTEL_USB_ID_FLOAT : INTEL_USB_ID_GND;
> +	}
> +
> +	/* Unknown or unsupported type */
> +	return INTEL_USB_ID_FLOAT;
> +}
> +
> +static int mrfld_extcon_role_detect(struct mrfld_extcon_data *data)
> +{
> +	unsigned int id;
> +	bool usb_host;
> +	int ret;
> +
> +	ret = mrfld_extcon_get_id(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	id = ret;
> +
> +	usb_host = (id == INTEL_USB_ID_GND) || (id == INTEL_USB_RID_A);
> +	extcon_set_state_sync(data->edev, EXTCON_USB_HOST, usb_host);
> +
> +	return 0;
> +}
> +
> +static int mrfld_extcon_cable_detect(struct mrfld_extcon_data *data)
> +{
> +	struct regmap *regmap = data->regmap;
> +	unsigned int status;
> +	int ret;
> +
> +	/*
> +	 * It seems SCU firmware clears the content of BCOVE_CHGRIRQ1
> +	 * and makes it useless for OS. Instead we compare a previously
> +	 * stored status to the current one, provided by BCOVE_SCHGRIRQ1.
> +	 */
> +	ret = regmap_read(regmap, BCOVE_SCHGRIRQ1, &status);
> +	if (ret)
> +		return ret;
> +
> +	if (!(status ^ data->status))
> +		return -ENODATA;
> +
> +	if ((status ^ data->status) & BCOVE_CHGRIRQ_USBIDDET)
> +		ret = mrfld_extcon_role_detect(data);
> +
> +	data->status = status;
> +	return ret;
> +}
> +
> +static irqreturn_t mrfld_extcon_interrupt(int irq, void *dev_id)
> +{
> +	struct mrfld_extcon_data *data = dev_id;
> +	int ret;
> +
> +	ret = mrfld_extcon_cable_detect(data);
> +
> +	mrfld_extcon_clear(data, BCOVE_MIRQLVL1, BCOVE_LVL1_CHGR);
> +
> +	return ret ? IRQ_NONE: IRQ_HANDLED;
> +}
> +
> +static int mrfld_extcon_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct intel_soc_pmic *pmic = dev_get_drvdata(dev->parent);
> +	struct regmap *regmap = pmic->regmap;
> +	struct mrfld_extcon_data *data;
> +	unsigned int id;
> +	int irq, ret;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->dev = dev;
> +	data->regmap = regmap;
> +
> +	data->edev = devm_extcon_dev_allocate(dev, mrfld_extcon_cable);
> +	if (IS_ERR(data->edev))
> +		return -ENOMEM;
> +
> +	ret = devm_extcon_dev_register(dev, data->edev);
> +	if (ret < 0) {
> +		dev_err(dev, "can't register extcon device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL, mrfld_extcon_interrupt,
> +					IRQF_ONESHOT | IRQF_SHARED, pdev->name,
> +					data);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(regmap, BCOVE_ID, &id);
> +	if (ret)
> +		return ret;
> +
> +	data->id = id;
> +
> +	mrfld_extcon_set(data, BCOVE_CHGRCTRL0, BCOVE_CHGRCTRL0_SWCONTROL);
> +
> +	/* Get initial state */
> +	mrfld_extcon_role_detect(data);
> +
> +	mrfld_extcon_clear(data, BCOVE_MIRQLVL1, BCOVE_LVL1_CHGR);
> +	mrfld_extcon_clear(data, BCOVE_MCHGRIRQ1, BCOVE_CHGRIRQ_ALL);
> +
> +	mrfld_extcon_set(data, BCOVE_USBIDCTRL, BCOVE_USBIDCTRL_ALL);
> +
> +	platform_set_drvdata(pdev, data);
> +	return 0;
> +}
> +
> +static int mrfld_extcon_remove(struct platform_device *pdev)
> +{
> +	struct mrfld_extcon_data *data = platform_get_drvdata(pdev);
> +
> +	mrfld_extcon_clear(data, BCOVE_CHGRCTRL0, BCOVE_CHGRCTRL0_SWCONTROL);
> +	return 0;
> +}
> +
> +static const struct platform_device_id mrfld_extcon_id_table[] = {
> +	{ .name = "mrfld_bcove_extcon" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, mrfld_extcon_id_table);
> +
> +static struct platform_driver mrfld_extcon_driver = {
> +	.driver = {
> +		.name	= KBUILD_MODNAME,
> +	},
> +	.probe		= mrfld_extcon_probe,
> +	.remove		= mrfld_extcon_remove,
> +	.id_table	= mrfld_extcon_id_table,
> +};
> +module_platform_driver(mrfld_extcon_driver);
> +
> +MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
> +MODULE_DESCRIPTION("Extcon driver for Basin Cove PMIC");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


