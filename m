Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C55C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D72F206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="O3lA2DKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389494AbfFJKc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:32:56 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12918 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389466AbfFJKc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:32:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfe31d40000>; Mon, 10 Jun 2019 03:32:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 10 Jun 2019 03:32:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 10 Jun 2019 03:32:52 -0700
Received: from [10.24.193.7] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Jun
 2019 10:32:46 +0000
Subject: Re: [PATCH v6 09/10] usb: roles: add USB Type-B GPIO connector driver
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yu Chen <chenyu56@huawei.com>
References: <1559115828-19146-1-git-send-email-chunfeng.yun@mediatek.com>
 <1559115828-19146-10-git-send-email-chunfeng.yun@mediatek.com>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <9640aa29-bc96-ded1-e757-e885bda354a8@nvidia.com>
Date:   Mon, 10 Jun 2019 16:03:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559115828-19146-10-git-send-email-chunfeng.yun@mediatek.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560162772; bh=bWmRlNrhWjmX5Y+q8rrrUpjUpcU1optSS1Aod6ADxgE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=O3lA2DKfT+zKHjU8VTzQuaUlMlRxmYPsz9GYZjlQsV9i3fNu2IPg2jdY9KYj02EfT
         96ERVopGCyLH+v3hUmB3wF1jG7711fbs6y8FKNJPUQGYf3H28Tq1gGyGYHRi11f7O+
         Rdv/TvcO1N9cSfYgM3BWyRsN1P/WbgQYN3+SEdpF4HvsOpG58VEg7JI6eMEZH5bUOg
         zscLrLD3V1LI/RZ2kBYlxR5PJ+O51fJECkzecZmuVIo/zG5NK5jUWsgWzx6uVgCtqI
         9zhFqD1ve0uR6UMq3tjwVCte97yR5rHFBOSlKQAXtyG7DOVsmqa6qRu3oKFgthsjYY
         tWvsd8Gg3J83g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Nagarjuna Kristam <nkristam@nvidia.com>

On 29-05-2019 13:13, Chunfeng Yun wrote:
> Due to the requirement of usb-connector.txt binding, the old way
> using extcon to support USB Dual-Role switch is now deprecated
> when use Type-B connector.
> This patch introduces a driver of Type-B connector which typically
> uses an input GPIO to detect USB ID pin, and try to replace the
> function provided by extcon-usb-gpio driver
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v6 changes:
>   1. get usb-role-swtich by usb_role_switch_get()
> 
> v5 changes:
>   1. put usb_role_switch when error happens suggested by Biju
>   2. don't treat bype-B connector as a virtual device suggested by Rob
> 
> v4 changes:
>   1. remove linux/gpio.h suggested by Linus
>   2. put node when error happens
> 
> v3 changes:
>   1. treat bype-B connector as a virtual device;
>   2. change file name again
> 
> v2 changes:
>   1. file name is changed
>   2. use new compatible
> ---
>  drivers/usb/roles/Kconfig           |  11 ++
>  drivers/usb/roles/Makefile          |   1 +
>  drivers/usb/roles/typeb-conn-gpio.c | 286 ++++++++++++++++++++++++++++
>  3 files changed, 298 insertions(+)
>  create mode 100644 drivers/usb/roles/typeb-conn-gpio.c
> 
> diff --git a/drivers/usb/roles/Kconfig b/drivers/usb/roles/Kconfig
> index f8b31aa67526..d1156e18a81a 100644
> --- a/drivers/usb/roles/Kconfig
> +++ b/drivers/usb/roles/Kconfig
> @@ -26,4 +26,15 @@ config USB_ROLES_INTEL_XHCI
>  	  To compile the driver as a module, choose M here: the module will
>  	  be called intel-xhci-usb-role-switch.
>  
> +config TYPEB_CONN_GPIO
> +	tristate "USB Type-B GPIO Connector"
> +	depends on GPIOLIB
> +	help
> +	  The driver supports USB role switch between host and device via GPIO
> +	  based USB cable detection, used typically if an input GPIO is used
> +	  to detect USB ID pin.
> +
> +	  To compile the driver as a module, choose M here: the module will
> +	  be called typeb-conn-gpio.ko
> +
>  endif # USB_ROLE_SWITCH
> diff --git a/drivers/usb/roles/Makefile b/drivers/usb/roles/Makefile
> index 757a7d2797eb..5d5620d9d113 100644
> --- a/drivers/usb/roles/Makefile
> +++ b/drivers/usb/roles/Makefile
> @@ -3,3 +3,4 @@
>  obj-$(CONFIG_USB_ROLE_SWITCH)		+= roles.o
>  roles-y					:= class.o
>  obj-$(CONFIG_USB_ROLES_INTEL_XHCI)	+= intel-xhci-usb-role-switch.o
> +obj-$(CONFIG_TYPEB_CONN_GPIO)		+= typeb-conn-gpio.o
> diff --git a/drivers/usb/roles/typeb-conn-gpio.c b/drivers/usb/roles/typeb-conn-gpio.c
> new file mode 100644
> index 000000000000..c66f852365ef
> --- /dev/null
> +++ b/drivers/usb/roles/typeb-conn-gpio.c
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * USB Type-B GPIO Connector Driver
> + *
> + * Copyright (C) 2019 MediaTek Inc.
> + *
> + * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
> + *
> + * Some code borrowed from drivers/extcon/extcon-usb-gpio.c
> + */
> +
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/usb/role.h>
> +
> +#define USB_GPIO_DEB_MS		20	/* ms */
> +#define USB_GPIO_DEB_US		((USB_GPIO_DEB_MS) * 1000)	/* us */
> +
> +#define USB_CONN_IRQF	\
> +	(IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT)
> +
> +struct usb_conn_info {
> +	struct device *dev;
> +	struct usb_role_switch *role_sw;
> +	enum usb_role last_role;
> +	struct regulator *vbus;
> +	struct delayed_work dw_det;
> +	unsigned long debounce_jiffies;
> +
> +	struct gpio_desc *id_gpiod;
> +	struct gpio_desc *vbus_gpiod;
> +	int id_irq;
> +	int vbus_irq;
> +};
> +
> +/**
> + * "DEVICE" = VBUS and "HOST" = !ID, so we have:
> + * Both "DEVICE" and "HOST" can't be set as active at the same time
> + * so if "HOST" is active (i.e. ID is 0)  we keep "DEVICE" inactive
> + * even if VBUS is on.
> + *
> + *  Role          |   ID  |  VBUS
> + * ------------------------------------
> + *  [1] DEVICE    |   H   |   H
> + *  [2] NONE      |   H   |   L
> + *  [3] HOST      |   L   |   H
> + *  [4] HOST      |   L   |   L
> + *
> + * In case we have only one of these signals:
> + * - VBUS only - we want to distinguish between [1] and [2], so ID is always 1
> + * - ID only - we want to distinguish between [1] and [4], so VBUS = ID
> + */
> +static void usb_conn_detect_cable(struct work_struct *work)
> +{
> +	struct usb_conn_info *info;
> +	enum usb_role role;
> +	int id, vbus, ret;
> +
> +	info = container_of(to_delayed_work(work),
> +			    struct usb_conn_info, dw_det);
> +
> +	/* check ID and VBUS */
> +	id = info->id_gpiod ?
> +		gpiod_get_value_cansleep(info->id_gpiod) : 1;
> +	vbus = info->vbus_gpiod ?
> +		gpiod_get_value_cansleep(info->vbus_gpiod) : id;
> +
> +	if (!id)
> +		role = USB_ROLE_HOST;
> +	else if (vbus)
> +		role = USB_ROLE_DEVICE;
> +	else
> +		role = USB_ROLE_NONE;
> +
> +	dev_dbg(info->dev, "role %d/%d, gpios: id %d, vbus %d\n",
> +		info->last_role, role, id, vbus);
> +
> +	if (info->last_role == role) {
> +		dev_warn(info->dev, "repeated role: %d\n", role);
> +		return;
> +	}
> +
> +	if (info->last_role == USB_ROLE_HOST)
> +		regulator_disable(info->vbus);
> +
> +	ret = usb_role_switch_set_role(info->role_sw, role);
> +	if (ret)
> +		dev_err(info->dev, "failed to set role: %d\n", ret);
> +
> +	if (role == USB_ROLE_HOST) {
> +		ret = regulator_enable(info->vbus);
> +		if (ret)
> +			dev_err(info->dev, "enable vbus regulator failed\n");
> +	}
> +
> +	info->last_role = role;
> +
> +	dev_dbg(info->dev, "vbus regulator is %s\n",
> +		regulator_is_enabled(info->vbus) ? "enabled" : "disabled");
> +}
> +
> +static void usb_conn_queue_dwork(struct usb_conn_info *info,
> +				 unsigned long delay)
> +{
> +	queue_delayed_work(system_power_efficient_wq, &info->dw_det, delay);
> +}
> +
> +static irqreturn_t usb_conn_isr(int irq, void *dev_id)
> +{
> +	struct usb_conn_info *info = dev_id;
> +
> +	usb_conn_queue_dwork(info, info->debounce_jiffies);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int usb_conn_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct usb_conn_info *info;
> +	int ret = 0;
> +
> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->dev = dev;
> +	info->id_gpiod = devm_gpiod_get_optional(dev, "id", GPIOD_IN);
> +	if (IS_ERR(info->id_gpiod))
> +		return PTR_ERR(info->id_gpiod);
> +
> +	info->vbus_gpiod = devm_gpiod_get_optional(dev, "vbus", GPIOD_IN);
> +	if (IS_ERR(info->vbus_gpiod))
> +		return PTR_ERR(info->vbus_gpiod);
> +
> +	if (!info->id_gpiod && !info->vbus_gpiod) {
> +		dev_err(dev, "failed to get gpios\n");
> +		return -ENODEV;
> +	}
> +
> +	if (info->id_gpiod)
> +		ret = gpiod_set_debounce(info->id_gpiod, USB_GPIO_DEB_US);
> +	if (!ret && info->vbus_gpiod)
> +		ret = gpiod_set_debounce(info->vbus_gpiod, USB_GPIO_DEB_US);
> +	if (ret < 0)
> +		info->debounce_jiffies = msecs_to_jiffies(USB_GPIO_DEB_MS);
> +
> +	INIT_DELAYED_WORK(&info->dw_det, usb_conn_detect_cable);
> +
> +	info->vbus = devm_regulator_get(dev, "vbus");
> +	if (IS_ERR(info->vbus)) {
> +		dev_err(dev, "failed to get vbus\n");
> +		return PTR_ERR(info->vbus);
> +	}
> +
> +	info->role_sw = usb_role_switch_get(dev);
> +	if (IS_ERR(info->role_sw)) {
> +		if (PTR_ERR(info->role_sw) != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get role switch\n");
> +
> +		return PTR_ERR(info->role_sw);
> +	}
> +
> +	if (info->id_gpiod) {
> +		info->id_irq = gpiod_to_irq(info->id_gpiod);
> +		if (info->id_irq < 0) {
> +			dev_err(dev, "failed to get ID IRQ\n");
> +			ret = info->id_irq;
> +			goto put_role_sw;
> +		}
> +
> +		ret = devm_request_threaded_irq(dev, info->id_irq, NULL,
> +						usb_conn_isr, USB_CONN_IRQF,
> +						pdev->name, info);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to request ID IRQ\n");
> +			goto put_role_sw;
> +		}
> +	}
> +
> +	if (info->vbus_gpiod) {
> +		info->vbus_irq = gpiod_to_irq(info->vbus_gpiod);
> +		if (info->vbus_irq < 0) {
> +			dev_err(dev, "failed to get VBUS IRQ\n");
> +			ret = info->vbus_irq;
> +			goto put_role_sw;
> +		}
> +
> +		ret = devm_request_threaded_irq(dev, info->vbus_irq, NULL,
> +						usb_conn_isr, USB_CONN_IRQF,
> +						pdev->name, info);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to request VBUS IRQ\n");
> +			goto put_role_sw;
> +		}
> +	}
> +
> +	platform_set_drvdata(pdev, info);
> +
> +	/* Perform initial detection */
> +	usb_conn_queue_dwork(info, 0);
> +
> +	return 0;
> +
> +put_role_sw:
> +	usb_role_switch_put(info->role_sw);
> +	return ret;
> +}
> +
> +static int usb_conn_remove(struct platform_device *pdev)
> +{
> +	struct usb_conn_info *info = platform_get_drvdata(pdev);
> +
> +	cancel_delayed_work_sync(&info->dw_det);
> +
> +	if (info->last_role == USB_ROLE_HOST)
> +		regulator_disable(info->vbus);
> +
> +	usb_role_switch_put(info->role_sw);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused usb_conn_suspend(struct device *dev)
> +{
> +	struct usb_conn_info *info = dev_get_drvdata(dev);
> +
> +	if (info->id_gpiod)
> +		disable_irq(info->id_irq);
> +	if (info->vbus_gpiod)
> +		disable_irq(info->vbus_irq);
> +
> +	pinctrl_pm_select_sleep_state(dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused usb_conn_resume(struct device *dev)
> +{
> +	struct usb_conn_info *info = dev_get_drvdata(dev);
> +
> +	pinctrl_pm_select_default_state(dev);
> +
> +	if (info->id_gpiod)
> +		enable_irq(info->id_irq);
> +	if (info->vbus_gpiod)
> +		enable_irq(info->vbus_irq);
> +
> +	usb_conn_queue_dwork(info, 0);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(usb_conn_pm_ops,
> +			 usb_conn_suspend, usb_conn_resume);
> +
> +#define DEV_PMS_OPS (IS_ENABLED(CONFIG_PM_SLEEP) ? &usb_conn_pm_ops : NULL)
> +
> +static const struct of_device_id usb_conn_dt_match[] = {
> +	{ .compatible = "linux,typeb-conn-gpio", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, usb_conn_dt_match);
> +
> +static struct platform_driver usb_conn_driver = {
> +	.probe		= usb_conn_probe,
> +	.remove		= usb_conn_remove,
> +	.driver		= {
> +		.name	= "typeb-conn-gpio",
> +		.pm	= DEV_PMS_OPS,
> +		.of_match_table = usb_conn_dt_match,
> +	},
> +};
> +
> +module_platform_driver(usb_conn_driver);
> +
> +MODULE_AUTHOR("Chunfeng Yun <chunfeng.yun@mediatek.com>");
> +MODULE_DESCRIPTION("USB Type-B GPIO connector driver");
> +MODULE_LICENSE("GPL v2");
> 
