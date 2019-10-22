Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01777CA9EB0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41E4214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QsZdFqBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfJVCVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:21:18 -0400
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:18761
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729573AbfJVCVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:21:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JP1b+ojVZQMoWNxyiWgl7Odj1C1+utRKoA2AebHFgnpvxBsAzPTeT1Qo935qFCtzO3/V8E9pmwrn4aAKU/UB/KMEDlLp7SO5ADhMYOL+/phI9WVSYUrh4pgaDmKV3nOPQuBTh92WZmjocb7uA9YZiWRyqj0XUrUxnrDgkBN3m9i31nkVir9/vVjA/Ij9v+BVD5iU84OPpN+lRvjtaPVZoGujch1ww6QD7bmSOa8mTJO82CJZHlNqJ50LhZ/41awXJA7ArKubkJD0yBA2xrcgcyTDscHBDFcVUZpVhJCgGqnadjLWmXoljWMtWMVYKcGk6kLCHHc/t1zIO+aC8Un/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXKhPMz4BNOvM7SiwHzvqLKXme1k2d4cS8DWjnO2y2o=;
 b=j13gqk4Nd90sYqOXPz6GsEsTornNh5Ld3leoLUQ7dvarrCRQ6YKbvOkqLkTgyRfQF0aU4f8qqGpIrTdBf5xdHgG/+pNJpdA1Yz5pKqa+YOX5I+QSPBr2kvOFPBTzfNAhxU9NICgAjnybktI7R2mnjg+FKZVBhqGyfrPaTfo4nt96ApFGAHdD1hRItDzfKLVKYFeMsExPHOU8cOkLgALB2BN7XixckBKnji/U+FLUbkyyncBgHLqL5x5eHplksfRgWbyhEFNL/l2wKj1nXEXnmSJlfO6+H9ZoQ4gz6s0kcMVdsXPoQPf/uk8qSvGaiEIO5/0mLjCYV62jgBrXxQVNyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXKhPMz4BNOvM7SiwHzvqLKXme1k2d4cS8DWjnO2y2o=;
 b=QsZdFqBMnu87opKTH37nk2AuObKTPXXIfrEYSiSWncnP9XhozCqTck1AMJCH2PRrVq+sGLn+WZOlMbKuEtwnNhzMoLg8giVXm5+1ucWnRzPPZFsEULnETmAc1YuB4LuY0t+Kaw19T8PUgSDfw/K7y4brLLU4ng+lqCzZxlPp4sE=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB3023.eurprd04.prod.outlook.com (10.170.228.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.21; Tue, 22 Oct 2019 02:21:06 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133%3]) with mapi id 15.20.2347.029; Tue, 22 Oct 2019
 02:21:06 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] usb: cdns3: Add TI specific wrapper driver
Thread-Topic: [PATCH v2 2/2] usb: cdns3: Add TI specific wrapper driver
Thread-Index: AQHViBFy3Tm8TrXKnUqPYl+n++pWSKdl7ZoA
Date:   Tue, 22 Oct 2019 02:21:06 +0000
Message-ID: <20191022021736.GB26973@b29397-desktop>
References: <20191021131305.8689-1-rogerq@ti.com>
 <20191021131305.8689-3-rogerq@ti.com>
In-Reply-To: <20191021131305.8689-3-rogerq@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 142f5d62-5163-477f-4eb4-08d756967e67
x-ms-traffictypediagnostic: VI1PR04MB3023:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB302319916AE05D0A65545F948B680@VI1PR04MB3023.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(39860400002)(396003)(366004)(346002)(136003)(189003)(199004)(25786009)(1076003)(76176011)(8936002)(7736002)(81166006)(71190400001)(305945005)(71200400001)(966005)(478600001)(81156014)(66066001)(5660300002)(6916009)(26005)(256004)(2906002)(99286004)(8676002)(44832011)(86362001)(33716001)(102836004)(486006)(6116002)(476003)(6436002)(6306002)(229853002)(33656002)(6512007)(9686003)(11346002)(6506007)(446003)(6246003)(45080400002)(6486002)(316002)(53546011)(66946007)(76116006)(91956017)(4326008)(66446008)(64756008)(66556008)(66476007)(14454004)(54906003)(3846002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3023;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +a44KePjS7Qd8KrGEiLAKcmuFx8apXBrZ79rlIsE53Bu8xJMX1OqkGstCNc2ImnPZjCPYEp7S+8nKwGN4N/hb+Fd1lGxKfoEX0XKOzoPw07IgG5Nb9Qsbdvh3aXvnX0tTzGBxSF8OupuOTbr+AyG2sU9x7U4J/FDsmpq4RNwhj0sDQX2KeUgBJmIXLcpxKpfxmqonL8OrHx/FT7ywou+mwMRBPJVPa97LSP2RoETTtIafo024u3bckqyOu+59LbLPysI8/F/Kbe4G+7ZB2xMRXaqoxYyAZPKzwLqyGt8q4J/x+RolqVrxfHvi0Xml9Mw/sBq54SDfhHj48cDoMgx3Z93yOtSBIRSnWzAUwxtqLPzMYW/snw4mIp5tG8s9bNnsBhPQQLAQKMBki/cGsg5GRmIGFf3m8doeISi5gZLw/OsijuUzoY6nY6T5dXzkRwfpFI2e9JfAFuNoAQsNNxwEnJ3Hkas/CcGMIfbXXici/s=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1F4C92C1526F94183A2DB6F5B711D27@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 142f5d62-5163-477f-4eb4-08d756967e67
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 02:21:06.1413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4SViO9ikp3bQOkzV/Jp8ElXsRgiC9GxX5PsA77Ju5sPpQmTUfz8ke8kdImqOV8BDIBpBcVdaVT25SXsqHxjEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-21 16:13:05, Roger Quadros wrote:
> The J721e platform comes with 2 Cadence USB3 controller
> instances. This driver supports the TI specific wrapper
> on this platform.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  drivers/usb/cdns3/Kconfig    |  10 ++
>  drivers/usb/cdns3/Makefile   |   1 +
>  drivers/usb/cdns3/cdns3-ti.c | 236 +++++++++++++++++++++++++++++++++++
>  3 files changed, 247 insertions(+)
>  create mode 100644 drivers/usb/cdns3/cdns3-ti.c
>=20
> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
> index d0331613a355..2a1e89d12ed9 100644
> --- a/drivers/usb/cdns3/Kconfig
> +++ b/drivers/usb/cdns3/Kconfig
> @@ -43,4 +43,14 @@ config USB_CDNS3_PCI_WRAP
>  	  If you choose to build this driver as module it will
>  	  be dynamically linked and module will be called cdns3-pci.ko
> =20
> +config USB_CDNS3_TI
> +	tristate "Cadence USB3 support on TI platforms"
> +	depends on ARCH_K3 || COMPILE_TEST
> +	default USB_CDNS3
> +	help
> +	  Say 'Y' or 'M' here if you are building for Texas Instruments
> +	  platforms that contain Cadence USB3 controller core.
> +
> +	  e.g. J721e.
> +
>  endif
> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> index a703547350bb..948e6b88d1a9 100644
> --- a/drivers/usb/cdns3/Makefile
> +++ b/drivers/usb/cdns3/Makefile
> @@ -14,3 +14,4 @@ endif
>  cdns3-$(CONFIG_USB_CDNS3_HOST)		+=3D host.o
> =20
>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+=3D cdns3-pci-wrap.o
> +obj-$(CONFIG_USB_CDNS3_TI)		+=3D cdns3-ti.o
> diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
> new file mode 100644
> index 000000000000..5541cba71965
> --- /dev/null
> +++ b/drivers/usb/cdns3/cdns3-ti.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * cdns_ti-ti.c - TI specific Glue layer for Cadence USB Controller

cdns3-ti.c

> + *
> + * Copyright (C) 2019 Texas Instruments Incorporated - https://eur01.saf=
elinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.ti.com&amp;data=3D02%=
7C01%7Cpeter.chen%40nxp.com%7C94aad23d5a294c5cdaf808d75628931c%7C686ea1d3bc=
2b4c6fa92cd99c5c301635%7C0%7C0%7C637072604595033025&amp;sdata=3DLye5SayAKcq=
AMaNGbZ%2Fq5OkUZ8IsWMVgGmeh8IhA69M%3D&amp;reserved=3D0
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/io.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
> +
> +/* USB Wrapper register offsets */
> +#define USBSS_PID		0x0
> +#define	USBSS_W1		0x4
> +#define USBSS_STATIC_CONFIG	0x8
> +#define USBSS_PHY_TEST		0xc
> +#define	USBSS_DEBUG_CTRL	0x10
> +#define	USBSS_DEBUG_INFO	0x14
> +#define	USBSS_DEBUG_LINK_STATE	0x18
> +#define	USBSS_DEVICE_CTRL	0x1c
> +
> +/* Wrapper 1 register bits */
> +#define USBSS_W1_PWRUP_RST		BIT(0)
> +#define USBSS_W1_OVERCURRENT_SEL	BIT(8)
> +#define USBSS_W1_MODESTRAP_SEL		BIT(9)
> +#define USBSS_W1_OVERCURRENT		BIT(16)
> +#define USBSS_W1_MODESTRAP_MASK		GENMASK(18, 17)
> +#define USBSS_W1_MODESTRAP_SHIFT	17
> +#define USBSS_W1_USB2_ONLY		BIT(19)
> +
> +/* Static config register bits */
> +#define USBSS1_STATIC_PLL_REF_SEL_MASK	GENMASK(8, 5)
> +#define USBSS1_STATIC_PLL_REF_SEL_SHIFT	5
> +#define USBSS1_STATIC_LOOPBACK_MODE_MASK	GENMASK(4, 3)
> +#define USBSS1_STATIC_LOOPBACK_MODE_SHIFT	3
> +#define USBSS1_STATIC_VBUS_SEL_MASK	GENMASK(2, 1)
> +#define USBSS1_STATIC_VBUS_SEL_SHIFT	1
> +#define USBSS1_STATIC_LANE_REVERSE	BIT(0)
> +
> +/* Modestrap modes */
> +enum modestrap_mode { USBSS_MODESTRAP_MODE_NONE,
> +		      USBSS_MODESTRAP_MODE_HOST,
> +		      USBSS_MODESTRAP_MODE_PERIPHERAL};
> +
> +struct cdns_ti {
> +	struct device *dev;
> +	void __iomem *usbss;
> +	int usb2_only:1;
> +	int vbus_divider:1;
> +	struct clk *usb2_refclk;
> +	struct clk *lpm_clk;
> +};
> +
> +static const int cdns_ti_rate_table[] =3D {	/* in KHZ */
> +	9600,
> +	10000,
> +	12000,
> +	19200,
> +	20000,
> +	24000,
> +	25000,
> +	26000,
> +	38400,
> +	40000,
> +	58000,
> +	50000,
> +	52000,
> +};
> +
> +static inline u32 cdns_ti_readl(struct cdns_ti *data, u32 offset)
> +{
> +	return readl(data->usbss + offset);
> +}
> +
> +static inline void cdns_ti_writel(struct cdns_ti *data, u32 offset, u32 =
value)
> +{
> +	writel(value, data->usbss + offset);
> +}
> +
> +static int cdns_ti_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *node =3D pdev->dev.of_node;
> +	struct cdns_ti *data;
> +	struct resource	*res;
> +	int error;
> +	u32 reg;
> +	int rate_code, i;
> +	unsigned long rate;
> +
> +	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	data->dev =3D dev;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->usbss =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(data->usbss))
> +		return PTR_ERR(data->usbss);
> +
> +	data->usb2_refclk =3D devm_clk_get(dev, "ref");
> +	if (IS_ERR(data->usb2_refclk)) {
> +		dev_err(dev, "can't get usb2_refclk\n");
> +		return PTR_ERR(data->usb2_refclk);
> +	}
> +
> +	data->lpm_clk =3D devm_clk_get(dev, "lpm");
> +	if (IS_ERR(data->lpm_clk)) {
> +		dev_err(dev, "can't get lpm_clk\n");
> +		return PTR_ERR(data->lpm_clk);
> +	}
> +
> +	rate =3D clk_get_rate(data->usb2_refclk);
> +	rate /=3D 1000;	/* To KHz */
> +	for (i =3D 0; i < ARRAY_SIZE(cdns_ti_rate_table); i++) {
> +		if (cdns_ti_rate_table[i] =3D=3D rate)
> +			break;
> +	}
> +
> +	if (i =3D=3D ARRAY_SIZE(cdns_ti_rate_table)) {
> +		dev_err(dev, "unsupported usb2_refclk rate: %lu KHz\n", rate);
> +		return -EINVAL;
> +	}
> +
> +	rate_code =3D i;
> +
> +	pm_runtime_enable(dev);
> +	error =3D pm_runtime_get_sync(dev);
> +	if (error < 0) {
> +		dev_err(dev, "pm_runtime_get_sync failed: %d\n", error);
> +		goto err_get;
> +	}

Why you don't enable runtime pm at the end of probe?

Peter

> +
> +	/* assert RESET */
> +	reg =3D cdns_ti_readl(data, USBSS_W1);
> +	reg &=3D ~USBSS_W1_PWRUP_RST;
> +	cdns_ti_writel(data, USBSS_W1, reg);
> +
> +	/* set static config */
> +	reg =3D cdns_ti_readl(data, USBSS_STATIC_CONFIG);
> +	reg &=3D ~USBSS1_STATIC_PLL_REF_SEL_MASK;
> +	reg |=3D rate_code << USBSS1_STATIC_PLL_REF_SEL_SHIFT;
> +
> +	reg &=3D ~USBSS1_STATIC_VBUS_SEL_MASK;
> +	data->vbus_divider =3D device_property_read_bool(dev, "ti,vbus-divider"=
);
> +	if (data->vbus_divider)
> +		reg |=3D 1 << USBSS1_STATIC_VBUS_SEL_SHIFT;
> +
> +	cdns_ti_writel(data, USBSS_STATIC_CONFIG, reg);
> +	reg =3D cdns_ti_readl(data, USBSS_STATIC_CONFIG);
> +
> +	/* set USB2_ONLY mode if requested */
> +	reg =3D cdns_ti_readl(data, USBSS_W1);
> +	data->usb2_only =3D device_property_read_bool(dev, "ti,usb2-only");
> +	if (data->usb2_only)
> +		reg |=3D USBSS_W1_USB2_ONLY;
> +
> +	/* set default modestrap */
> +	reg |=3D USBSS_W1_MODESTRAP_SEL;
> +	reg &=3D ~USBSS_W1_MODESTRAP_MASK;
> +	reg |=3D USBSS_MODESTRAP_MODE_NONE << USBSS_W1_MODESTRAP_SHIFT;
> +	cdns_ti_writel(data, USBSS_W1, reg);
> +
> +	/* de-assert RESET */
> +	reg |=3D USBSS_W1_PWRUP_RST;
> +	cdns_ti_writel(data, USBSS_W1, reg);
> +
> +	error =3D of_platform_populate(node, NULL, NULL, dev);
> +	if (error) {
> +		dev_err(dev, "failed to create children: %d\n", error);
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	pm_runtime_put_sync(data->dev);
> +err_get:
> +	pm_runtime_disable(data->dev);
> +
> +	return error;
> +}
> +
> +static int cdns_ti_remove_core(struct device *dev, void *c)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +
> +	platform_device_unregister(pdev);
> +
> +	return 0;
> +}
> +
> +static int cdns_ti_remove(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +
> +	device_for_each_child(dev, NULL, cdns_ti_remove_core);
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id cdns_ti_of_match[] =3D {
> +	{ .compatible =3D "ti,j721e-usb", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, cdns_ti_of_match);
> +
> +static struct platform_driver cdns_ti_driver =3D {
> +	.probe		=3D cdns_ti_probe,
> +	.remove		=3D cdns_ti_remove,
> +	.driver		=3D {
> +		.name	=3D "cdns3-ti",
> +		.of_match_table	=3D cdns_ti_of_match,
> +	},
> +};
> +
> +module_platform_driver(cdns_ti_driver);
> +
> +MODULE_ALIAS("platform:cdns3-ti");
> +MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Cadence USB3 TI Glue Layer");
> --=20
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>=20

--=20

Thanks,
Peter Chen=
