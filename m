Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FD9C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D68206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="NxsORk+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfDZJWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:22:45 -0400
Received: from mail-eopbgr1410094.outbound.protection.outlook.com ([40.107.141.94]:31313
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbfDZJWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8aCcDiRI7+6UsUqc/TDpCc1zTHXxvQliIx3rzLDTbQ=;
 b=NxsORk+KlJbjUwqlVdezL3jyrv2lawCKl/II1wvZME4e/nk9dSJ5oNzOmgYuqgdj1asO1Zcpf0mhO5b0uk7za4ML1fOYljtIaZX59vcd39fNIxst15d7d6qqM3jYqN8JmEhYQGo/TjczxY5bEEXoSAgV5ON7Gg/sJVAdbKTDKhg=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.242.17) by
 OSBPR01MB1942.jpnprd01.prod.outlook.com (52.134.240.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Fri, 26 Apr 2019 09:22:39 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::6d2c:bd11:88b0:c53a]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::6d2c:bd11:88b0:c53a%3]) with mapi id 15.20.1813.017; Fri, 26 Apr 2019
 09:22:39 +0000
From:   Biju Das <biju.das@bp.renesas.com>
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
        Min Guo <min.guo@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: RE: [PATCH v4 5/6] usb: roles: add USB Type-B GPIO connector driver
Thread-Topic: [PATCH v4 5/6] usb: roles: add USB Type-B GPIO connector driver
Thread-Index: AQHU+/v4/Uu1yOd4cU+ciO8tKtQsgqZOKU8A
Date:   Fri, 26 Apr 2019 09:22:39 +0000
Message-ID: <OSBPR01MB210367FCF0BCDF4D9BB7B32CB83E0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1556261237-13823-1-git-send-email-chunfeng.yun@mediatek.com>
 <1556261237-13823-6-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1556261237-13823-6-git-send-email-chunfeng.yun@mediatek.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f738b081-cc45-4604-81db-08d6ca28ba93
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:OSBPR01MB1942;
x-ms-traffictypediagnostic: OSBPR01MB1942:
x-microsoft-antispam-prvs: <OSBPR01MB194267CBEEFA3AA20F4A4D4CB83E0@OSBPR01MB1942.jpnprd01.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(346002)(39860400002)(396003)(189003)(199004)(51914003)(76116006)(6436002)(5660300002)(26005)(14454004)(66066001)(81156014)(81166006)(64756008)(66446008)(66476007)(66946007)(8936002)(66556008)(7736002)(478600001)(71200400001)(73956011)(8676002)(86362001)(68736007)(97736004)(229853002)(6116002)(3846002)(305945005)(7416002)(4326008)(99286004)(52536014)(30864003)(316002)(6506007)(11346002)(33656002)(25786009)(446003)(102836004)(7696005)(53936002)(6246003)(71190400001)(74316002)(2906002)(44832011)(110136005)(55016002)(256004)(14444005)(54906003)(486006)(476003)(9686003)(76176011)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1942;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UmNnq8UhollGflXTBtdyQWR8M6OAbIaUw4Dj6I5038E03fTJ3DVYNioQSnmtkMuyTcacaAUgwLC7ejF09HEZEdbbvHJPbHGQYxb4U11s94IFWM+BB4NnSrGcYERjSOfCZECXsU00t+VPyZ1mhTGS7aa/t9AmbqxJziIQDGcH5Gkx72/o2ahU6Xs73Ovepma/iFet2Rev4yFJl/efr6G8gjL2IFnpxXsfEKtY0M21Rw6zhKsU6DuJqMMBeh2zJpIVKwZIPEEjLnjLJ1SHNtV9/TkQRtzSRanqz/Ghh8narwQ7yq8wjBqIDNmmX7kJuM4hrddmNhm0d5lyo13Sc/8jAfO5QOrwj7TWXOGXEKL+G9aUCdyJKr2nMSNc0Nbj7n0wdy6buPfDaoE/1q25fC05ibNj5fjmXbv4ColsxOTdpSY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f738b081-cc45-4604-81db-08d6ca28ba93
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 09:22:39.5554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunfeng Yun,

Thanks for the patch.

> Subject: [PATCH v4 5/6] usb: roles: add USB Type-B GPIO connector driver
>=20
> Due to the requirement of usb-connector.txt binding, the old way using
> extcon to support USB Dual-Role switch is now deprecated when use Type-B
> connector.
> This patch introduces a driver of Type-B connector which typically uses a=
n
> input GPIO to detect USB ID pin, and try to replace the function provided=
 by
> extcon-usb-gpio driver
>=20
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v4 changes:
>   1. remove linux/gpio.h suggested by Linus
>   2. put node when error happens
>=20
> v3 changes:
>   1. treat bype-B connector as a virtual device;
>   2. change file name again
>=20
> v2 changes:
>   1. file name is changed
>   2. use new compatible
> ---
>  drivers/usb/roles/Kconfig           |  11 +
>  drivers/usb/roles/Makefile          |   1 +
>  drivers/usb/roles/typeb-conn-gpio.c | 305
> ++++++++++++++++++++++++++++
>  3 files changed, 317 insertions(+)
>  create mode 100644 drivers/usb/roles/typeb-conn-gpio.c
>=20
> diff --git a/drivers/usb/roles/Kconfig b/drivers/usb/roles/Kconfig index
> f8b31aa67526..d1156e18a81a 100644
> --- a/drivers/usb/roles/Kconfig
> +++ b/drivers/usb/roles/Kconfig
> @@ -26,4 +26,15 @@ config USB_ROLES_INTEL_XHCI
>  	  To compile the driver as a module, choose M here: the module will
>  	  be called intel-xhci-usb-role-switch.
>=20
> +config TYPEB_CONN_GPIO
> +	tristate "USB Type-B GPIO Connector"
> +	depends on GPIOLIB
> +	help
> +	  The driver supports USB role switch between host and device via
> GPIO
> +	  based USB cable detection, used typically if an input GPIO is used
> +	  to detect USB ID pin.
> +
> +	  To compile the driver as a module, choose M here: the module will
> +	  be called typeb-conn-gpio.ko
> +
>  endif # USB_ROLE_SWITCH
> diff --git a/drivers/usb/roles/Makefile b/drivers/usb/roles/Makefile inde=
x
> 757a7d2797eb..5d5620d9d113 100644
> --- a/drivers/usb/roles/Makefile
> +++ b/drivers/usb/roles/Makefile
> @@ -3,3 +3,4 @@
>  obj-$(CONFIG_USB_ROLE_SWITCH)		+=3D roles.o
>  roles-y					:=3D class.o
>  obj-$(CONFIG_USB_ROLES_INTEL_XHCI)	+=3D intel-xhci-usb-role-
> switch.o
> +obj-$(CONFIG_TYPEB_CONN_GPIO)		+=3D typeb-conn-gpio.o
> diff --git a/drivers/usb/roles/typeb-conn-gpio.c b/drivers/usb/roles/type=
b-
> conn-gpio.c
> new file mode 100644
> index 000000000000..097d2ca12a12
> --- /dev/null
> +++ b/drivers/usb/roles/typeb-conn-gpio.c
> @@ -0,0 +1,305 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * USB Type-B GPIO Connector Driver
> + *
> + * Copyright (C) 2019 MediaTek Inc.
> + *
> + * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
> + *
> + * Some code borrowed from drivers/extcon/extcon-usb-gpio.c  */
> +
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_graph.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/usb/role.h>
> +
> +#define USB_GPIO_DEB_MS		20	/* ms */
> +#define USB_GPIO_DEB_US		((USB_GPIO_DEB_MS) * 1000)	/* us
> */
> +
> +#define USB_CONN_IRQF	\
> +	(IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
> IRQF_ONESHOT)
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
> + * "DEVICE" =3D VBUS and "HOST" =3D !ID, so we have:
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
> + * - VBUS only - we want to distinguish between [1] and [2], so ID is
> +always 1
> + * - ID only - we want to distinguish between [1] and [4], so VBUS =3D I=
D
> +*/ static void usb_conn_detect_cable(struct work_struct *work) {
> +	struct usb_conn_info *info;
> +	enum usb_role role;
> +	int id, vbus, ret;
> +
> +	info =3D container_of(to_delayed_work(work),
> +			    struct usb_conn_info, dw_det);
> +
> +	/* check ID and VBUS */
> +	id =3D info->id_gpiod ?
> +		gpiod_get_value_cansleep(info->id_gpiod) : 1;
> +	vbus =3D info->vbus_gpiod ?
> +		gpiod_get_value_cansleep(info->vbus_gpiod) : id;
> +
> +	if (!id)
> +		role =3D USB_ROLE_HOST;
> +	else if (vbus)
> +		role =3D USB_ROLE_DEVICE;
> +	else
> +		role =3D USB_ROLE_NONE;
> +
> +	dev_dbg(info->dev, "role %d/%d, gpios: id %d, vbus %d\n",
> +		info->last_role, role, id, vbus);
> +
> +	if (info->last_role =3D=3D role) {
> +		dev_warn(info->dev, "repeated role: %d\n", role);
> +		return;
> +	}
> +
> +	if (info->last_role =3D=3D USB_ROLE_HOST)
> +		regulator_disable(info->vbus);
> +
> +	ret =3D usb_role_switch_set_role(info->role_sw, role);
> +	if (ret)
> +		dev_err(info->dev, "failed to set role: %d\n", ret);
> +
> +	if (role =3D=3D USB_ROLE_HOST) {
> +		ret =3D regulator_enable(info->vbus);
> +		if (ret)
> +			dev_err(info->dev, "enable vbus regulator failed\n");
> +	}
> +
> +	info->last_role =3D role;
> +
> +	dev_dbg(info->dev, "vbus regulator is %s\n",
> +		regulator_is_enabled(info->vbus) ? "enabled" : "disabled"); }
> +
> +static void usb_conn_queue_dwork(struct usb_conn_info *info,
> +				 unsigned long delay)
> +{
> +	queue_delayed_work(system_power_efficient_wq, &info-
> >dw_det, delay); }
> +
> +static irqreturn_t usb_conn_isr(int irq, void *dev_id) {
> +	struct usb_conn_info *info =3D dev_id;
> +
> +	usb_conn_queue_dwork(info, info->debounce_jiffies);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int usb_conn_probe(struct platform_device *pdev) {
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	struct device_node *parent;
> +	struct device_node *child;
> +	struct usb_conn_info *info;
> +	int ret =3D 0;
> +
> +	if (!np)
> +		return -EINVAL;
> +
> +	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->dev =3D dev;
> +
> +	child =3D of_get_child_by_name(np, "connector");
> +	if (!child) {
> +		dev_err(dev, "failed to find connector node\n");
> +		return -ENODEV;
> +	}
> +
> +	info->id_gpiod =3D devm_gpiod_get_from_of_node(
> +				dev, child, "id-gpios", 0, GPIOD_IN, "idpin");
> +	if (IS_ERR(info->id_gpiod)) {
> +		of_node_put(child);
> +		return PTR_ERR(info->id_gpiod);
> +	}
> +
> +	info->vbus_gpiod =3D devm_gpiod_get_from_of_node(
> +				dev, child, "vbus-gpios", 0, GPIOD_IN,
> +				"vbuspin");
> +	if (IS_ERR(info->vbus_gpiod)) {
> +		of_node_put(child);
> +		return PTR_ERR(info->vbus_gpiod);
> +	}
> +
> +	if (!info->id_gpiod && !info->vbus_gpiod) {
> +		dev_err(dev, "failed to get gpios\n");
> +		return -ENODEV;
> +	}
> +
> +	of_node_put(child);
> +
> +	if (info->id_gpiod)
> +		ret =3D gpiod_set_debounce(info->id_gpiod,
> USB_GPIO_DEB_US);
> +	if (!ret && info->vbus_gpiod)
> +		ret =3D gpiod_set_debounce(info->vbus_gpiod,
> USB_GPIO_DEB_US);
> +	if (ret < 0)
> +		info->debounce_jiffies =3D
> msecs_to_jiffies(USB_GPIO_DEB_MS);
> +
> +	INIT_DELAYED_WORK(&info->dw_det, usb_conn_detect_cable);
> +
> +	info->vbus =3D devm_regulator_get(dev, "vbus");
> +	if (IS_ERR(info->vbus)) {
> +		dev_err(dev, "failed to get vbus\n");
> +		return PTR_ERR(info->vbus);
> +	}
> +
> +	child =3D of_graph_get_endpoint_by_regs(np, -1, 0);
> +	parent =3D of_graph_get_remote_port_parent(child);
> +	info->role_sw =3D
> fwnode_usb_role_switch_get(of_fwnode_handle(parent));
> +	of_node_put(child);
> +	of_node_put(parent);
> +	if (IS_ERR(info->role_sw)) {
> +		dev_err(dev, "failed to get role switch\n");
> +		return PTR_ERR(info->role_sw);
> +	}
> +
> +	if (info->id_gpiod) {
> +		info->id_irq =3D gpiod_to_irq(info->id_gpiod);
> +		if (info->id_irq < 0) {
> +			dev_err(dev, "failed to get ID IRQ\n");
May be usb_role_switch_put(info->role_sw); ??
> +			return info->id_irq;
> +		}
> +
> +		ret =3D devm_request_threaded_irq(dev, info->id_irq, NULL,
> +						usb_conn_isr,
> USB_CONN_IRQF,
> +						pdev->name, info);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to request ID IRQ\n");
May be usb_role_switch_put(info->role_sw); ??
> +			return ret;
> +		}
> +	}
> +
> +	if (info->vbus_gpiod) {
> +		info->vbus_irq =3D gpiod_to_irq(info->vbus_gpiod);
> +		if (info->vbus_irq < 0) {
> +			dev_err(dev, "failed to get VBUS IRQ\n");
May be usb_role_switch_put(info->role_sw);
> +			return info->vbus_irq;
> +		}
> +
> +		ret =3D devm_request_threaded_irq(dev, info->vbus_irq,
> NULL,
> +						usb_conn_isr,
> USB_CONN_IRQF,
> +						pdev->name, info);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to request VBUS IRQ\n");
May be usb_role_switch_put(info->role_sw); ??
> +			return ret;
> +		}
> +	}
> +
> +	platform_set_drvdata(pdev, info);
> +
> +	/* Perform initial detection */
> +	usb_conn_queue_dwork(info, 0);
> +
> +	return 0;
> +}
> +
> +static int usb_conn_remove(struct platform_device *pdev) {
> +	struct usb_conn_info *info =3D platform_get_drvdata(pdev);
> +
> +	cancel_delayed_work_sync(&info->dw_det);
> +
> +	if (info->last_role =3D=3D USB_ROLE_HOST)
> +		regulator_disable(info->vbus);
> +
> +	usb_role_switch_put(info->role_sw);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused usb_conn_suspend(struct device *dev) {
> +	struct usb_conn_info *info =3D dev_get_drvdata(dev);
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
> +static int __maybe_unused usb_conn_resume(struct device *dev) {
> +	struct usb_conn_info *info =3D dev_get_drvdata(dev);
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
> +#define DEV_PMS_OPS (IS_ENABLED(CONFIG_PM_SLEEP) ?
> &usb_conn_pm_ops :
> +NULL)
> +
> +static const struct of_device_id usb_conn_dt_match[] =3D {
> +	{ .compatible =3D "linux,typeb-conn-gpio", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, usb_conn_dt_match);
> +
> +static struct platform_driver usb_conn_driver =3D {
> +	.probe		=3D usb_conn_probe,
> +	.remove		=3D usb_conn_remove,
> +	.driver		=3D {
> +		.name	=3D "typeb-conn-gpio",
> +		.pm	=3D DEV_PMS_OPS,
> +		.of_match_table =3D usb_conn_dt_match,
> +	},
> +};
> +
> +module_platform_driver(usb_conn_driver);
> +
> +MODULE_AUTHOR("Chunfeng Yun <chunfeng.yun@mediatek.com>");
> +MODULE_DESCRIPTION("USB Type-B GPIO connector driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.21.0

