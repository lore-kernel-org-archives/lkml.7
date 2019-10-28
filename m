Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A9FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9611321783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="f1Rq3O1r";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="RZaISiq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387759AbfJ1JHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:07:17 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:29222 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728337AbfJ1JHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:07:16 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9S93UYV003531;
        Mon, 28 Oct 2019 02:05:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=bnW1NNf3ojwvJO7kpyzFHDBNAg1OZWugsE5g8QSTRhM=;
 b=f1Rq3O1r/oNz3Yqx6r3iuorNWCvHSVu9SMJUdggdK9ls9yrKQbK9PLQqp4bdH0mTFeG8
 Ky5C+jwIHxuzPq44SakOc/vuG+2QrEE6PRlSVAg+1GRI1hlIYBiP5hhueQV94j49Bewu
 DQERfjoP/9Nw+Y3J2UYCTduVp9WzGV4xS9ypBT5L260nUJdcPifks/fIWQ/hpNJqhimR
 3K0N7i23ZgSBtgIF7Twuvc/wZUGoNmuDVYKTNxtpk4zjLuz8MEqNd/7TgIdcM8dc3KVw
 QHSrQud8qMMoI6p7kcEz29fPLfnRgwwb/Xfx+PEPihQ+ZXNblvoZBVPfpn3BNZrk20my Yg== 
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2050.outbound.protection.outlook.com [104.47.42.50])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2vvhqx585d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 28 Oct 2019 02:05:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVQnLbs5gIYLVMn1AEZ4qzukz/EcT681dCMzvPzIshfGt378J1cN2Pm9XBHyNuGqNrtPNCJ5CkFg30gSpIbz72wpUoFWyf17V3hXM8Tup9C8XnK4aVngmdvOZg1KlNWaQX4Wxhkl7tuNLpW2Rti3pv4UegMSZ7E1iAOK6yz4xDykFPSujLocNQFPdpePAfT5XVhNR2voPP6y9Gu2fKDYNAtKvxnSb1K5y5/PPFPDffz3fOUJjJ63c/tq+pwanSMiRyHxYW47Em9SwazyEh2d5G8lqvNHNCgjJbAzADfeIzLQ5EBHIzih2ghQkHpSuTbBLNnDdFxenLRoVQg23FEJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnW1NNf3ojwvJO7kpyzFHDBNAg1OZWugsE5g8QSTRhM=;
 b=HXKC8N68VnQERkyDutbWTiTNpPd5VWfmtvWbgVI2x/rUg1HaInbYt7jdZcbeGLbxzQDaDuSJdlASKvEhbbpRIENVU9Xcn1kNwL4mbfqXmPwjz4BUsXVWf2z2cYmu/d2BR1C6CjzZHcZGiq1DCBtgxc6NYnW1rTssex6AgvgzfL2LP60cqWrAzfgqzeneBv5Fq9c+BR9LAUh7T9FoZY0+VkeUHozmszdnezjvbtMSnGE34hU2fNGdsEIPhvQotbQ/uyOWm5gdm1Xxtp0tPvJURbW9UTYDQxdpF7Hmc2tt8FG+9tSLv3ICko1eyZqHeFp/Vuo1BZRn66/R11nkQnptNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnW1NNf3ojwvJO7kpyzFHDBNAg1OZWugsE5g8QSTRhM=;
 b=RZaISiq9wQWSWJM6EbAleiVtfPO4keJepCcBdyOCweOYTESc9zafJYFhDO/ubdysGSQOMcqeLRFkGsktkqUULswZ233fgY25vIjwBuObHNKLWnG1cNHJEuSB4PxA5BsNCM7XU+8D+LEr0IDl3f61a0O9MGMSOJZFN8qhIHE5ix0=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5528.namprd07.prod.outlook.com (20.177.229.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Mon, 28 Oct 2019 09:05:04 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770%6]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 09:05:04 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        Rahul Kumar <kurahul@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] usb: cdns3: Add TI specific wrapper driver
Thread-Topic: [PATCH v3 2/2] usb: cdns3: Add TI specific wrapper driver
Thread-Index: AQHVimDSbDt6LAUtGES7eJ2Ryuja0qdvyFuQ
Date:   Mon, 28 Oct 2019 09:05:04 +0000
Message-ID: <BYAPR07MB470954A89E14FCDBAFCAB0D4DD660@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <20191024114717.30984-1-rogerq@ti.com>
 <20191024114717.30984-3-rogerq@ti.com>
In-Reply-To: <20191024114717.30984-3-rogerq@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3894992e-7528-40a4-055c-08d75b85ec26
x-ms-traffictypediagnostic: BYAPR07MB5528:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB552880E76109331E60A1142ADD660@BYAPR07MB5528.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(36092001)(199004)(189003)(66446008)(6246003)(76176011)(102836004)(99286004)(966005)(11346002)(76116006)(478600001)(26005)(66946007)(7696005)(476003)(486006)(66556008)(25786009)(186003)(6116002)(64756008)(446003)(316002)(2906002)(52536014)(6506007)(110136005)(54906003)(229853002)(2501003)(66066001)(3846002)(5660300002)(66476007)(33656002)(6436002)(14454004)(4326008)(9686003)(6306002)(2201001)(81156014)(8676002)(81166006)(7736002)(86362001)(55016002)(305945005)(256004)(74316002)(71190400001)(71200400001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5528;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +td+1DQ1H/1JrRQpTzSrsiNpZOEQc4stvj/2V5H1O85qJ6GmQGPqPiFp8zZZNkDVk4Gs4NmmW8coV3QkEE+FrPbKshZ5k+lGZl+pJGyG4w57pFe3RoNsbCvJdwkEv9hturkUX9+4HtmhNtfSut4JZaW8GnfinhU9shKsPDuXP4Hhi9s4ILvrZ3u3mcuhDsi5aLrBEqKx5djgZe100wiJ7zj6gz0XgeLSTUO7sYbWVHku7U5eU9jRZVZNJWh4p3D/MkADp4j4d4KpR0efig7pXMwaa4XtlK2RWO8rN6x4TGQzin3A0l8wq4y3ajGmb7Q1B/ytYo9WX6IMOARpaeEAoYwNhtGsNiibBq/c4F6tCCxX1Tuvc+pIOTTgPx+3Tcqjl9AiCFnBUdAbs1GRVs5k9UUxYR2Tpd6CZ9X0GhrOcK6IPX5pnKoffQWGGw3e+sSv5x6cw0BtHv1LUix+Z1khnS0H3Pd12a6XCcuIqoX1K+Q=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3894992e-7528-40a4-055c-08d75b85ec26
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 09:05:04.5947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bgUJ6Eu+AJlFdscEBWbPmvesnogGvw7kdppXwth6rwCpZNxAZd3QsLwpSwwzAAEx3noek/WCkjpnjy1elBriz1W/kF+CWTYSLQIlDiQliHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5528
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-28_04:2019-10-25,2019-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910280090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=20


Reviewed-by: Pawel Laszczak <pawell@cadence.com>

Regards,
Pawel,

>
>
>The J721e platform comes with 2 Cadence USB3 controller
>
>instances. This driver supports the TI specific wrapper
>
>on this platform.
>
>
>
>Signed-off-by: Roger Quadros <rogerq@ti.com>
>
>Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>
>---
>
> drivers/usb/cdns3/Kconfig    |  10 ++
>
> drivers/usb/cdns3/Makefile   |   1 +
>
> drivers/usb/cdns3/cdns3-ti.c | 236 +++++++++++++++++++++++++++++++++++
>
> 3 files changed, 247 insertions(+)
>
> create mode 100644 drivers/usb/cdns3/cdns3-ti.c
>
>
>
>diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
>
>index d0331613a355..2a1e89d12ed9 100644
>
>--- a/drivers/usb/cdns3/Kconfig
>
>+++ b/drivers/usb/cdns3/Kconfig
>
>@@ -43,4 +43,14 @@ config USB_CDNS3_PCI_WRAP
>
> 	  If you choose to build this driver as module it will
>
> 	  be dynamically linked and module will be called cdns3-pci.ko
>
>
>
>+config USB_CDNS3_TI
>
>+	tristate "Cadence USB3 support on TI platforms"
>
>+	depends on ARCH_K3 || COMPILE_TEST
>
>+	default USB_CDNS3
>
>+	help
>
>+	  Say 'Y' or 'M' here if you are building for Texas Instruments
>
>+	  platforms that contain Cadence USB3 controller core.
>
>+
>
>+	  e.g. J721e.
>
>+
>
> endif
>
>diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
>
>index a703547350bb..948e6b88d1a9 100644
>
>--- a/drivers/usb/cdns3/Makefile
>
>+++ b/drivers/usb/cdns3/Makefile
>
>@@ -14,3 +14,4 @@ endif
>
> cdns3-$(CONFIG_USB_CDNS3_HOST)		+=3D host.o
>
>
>
> obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+=3D cdns3-pci-wrap.o
>
>+obj-$(CONFIG_USB_CDNS3_TI)		+=3D cdns3-ti.o
>
>diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
>
>new file mode 100644
>
>index 000000000000..89620e40023f
>
>--- /dev/null
>
>+++ b/drivers/usb/cdns3/cdns3-ti.c
>
>@@ -0,0 +1,236 @@
>
>+// SPDX-License-Identifier: GPL-2.0
>
>+/**
>
>+ * cdns3-ti.c - TI specific Glue layer for Cadence USB Controller
>
>+ *
>
>+ * Copyright (C) 2019 Texas Instruments Incorporated - https://urldefense=
.proofpoint.com/v2/url?u=3Dhttp-
>3A__www.ti.com&d=3DDwIBAg&c=3DaUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&=
r=3De1OgxfvkL0qo9XO6fX1gscva-w03uSYC1nIyxl89-
>rI&m=3DH6841QR1j9qs7DWnJfSzVFshZ-g7qZy7fYvO-sqqggo&s=3Deew1XA1kWdUhRDB8F-f=
yN96g8nJmTH3GVOk8PGoc1Iw&e=3D
>
>+ */
>
>+
>
>+#include <linux/bits.h>
>
>+#include <linux/clk.h>
>
>+#include <linux/module.h>
>
>+#include <linux/kernel.h>
>
>+#include <linux/interrupt.h>
>
>+#include <linux/platform_device.h>
>
>+#include <linux/dma-mapping.h>
>
>+#include <linux/io.h>
>
>+#include <linux/of_platform.h>
>
>+#include <linux/pm_runtime.h>
>
>+
>
>+/* USB Wrapper register offsets */
>
>+#define USBSS_PID		0x0
>
>+#define	USBSS_W1		0x4
>
>+#define USBSS_STATIC_CONFIG	0x8
>
>+#define USBSS_PHY_TEST		0xc
>
>+#define	USBSS_DEBUG_CTRL	0x10
>
>+#define	USBSS_DEBUG_INFO	0x14
>
>+#define	USBSS_DEBUG_LINK_STATE	0x18
>
>+#define	USBSS_DEVICE_CTRL	0x1c
>
>+
>
>+/* Wrapper 1 register bits */
>
>+#define USBSS_W1_PWRUP_RST		BIT(0)
>
>+#define USBSS_W1_OVERCURRENT_SEL	BIT(8)
>
>+#define USBSS_W1_MODESTRAP_SEL		BIT(9)
>
>+#define USBSS_W1_OVERCURRENT		BIT(16)
>
>+#define USBSS_W1_MODESTRAP_MASK		GENMASK(18, 17)
>
>+#define USBSS_W1_MODESTRAP_SHIFT	17
>
>+#define USBSS_W1_USB2_ONLY		BIT(19)
>
>+
>
>+/* Static config register bits */
>
>+#define USBSS1_STATIC_PLL_REF_SEL_MASK	GENMASK(8, 5)
>
>+#define USBSS1_STATIC_PLL_REF_SEL_SHIFT	5
>
>+#define USBSS1_STATIC_LOOPBACK_MODE_MASK	GENMASK(4, 3)
>
>+#define USBSS1_STATIC_LOOPBACK_MODE_SHIFT	3
>
>+#define USBSS1_STATIC_VBUS_SEL_MASK	GENMASK(2, 1)
>
>+#define USBSS1_STATIC_VBUS_SEL_SHIFT	1
>
>+#define USBSS1_STATIC_LANE_REVERSE	BIT(0)
>
>+
>
>+/* Modestrap modes */
>
>+enum modestrap_mode { USBSS_MODESTRAP_MODE_NONE,
>
>+		      USBSS_MODESTRAP_MODE_HOST,
>
>+		      USBSS_MODESTRAP_MODE_PERIPHERAL};
>
>+
>
>+struct cdns_ti {
>
>+	struct device *dev;
>
>+	void __iomem *usbss;
>
>+	int usb2_only:1;
>
>+	int vbus_divider:1;
>
>+	struct clk *usb2_refclk;
>
>+	struct clk *lpm_clk;
>
>+};
>
>+
>
>+static const int cdns_ti_rate_table[] =3D {	/* in KHZ */
>
>+	9600,
>
>+	10000,
>
>+	12000,
>
>+	19200,
>
>+	20000,
>
>+	24000,
>
>+	25000,
>
>+	26000,
>
>+	38400,
>
>+	40000,
>
>+	58000,
>
>+	50000,
>
>+	52000,
>
>+};
>
>+
>
>+static inline u32 cdns_ti_readl(struct cdns_ti *data, u32 offset)
>
>+{
>
>+	return readl(data->usbss + offset);
>
>+}
>
>+
>
>+static inline void cdns_ti_writel(struct cdns_ti *data, u32 offset, u32 v=
alue)
>
>+{
>
>+	writel(value, data->usbss + offset);
>
>+}
>
>+
>
>+static int cdns_ti_probe(struct platform_device *pdev)
>
>+{
>
>+	struct device *dev =3D &pdev->dev;
>
>+	struct device_node *node =3D pdev->dev.of_node;
>
>+	struct cdns_ti *data;
>
>+	struct resource	*res;
>
>+	int error;
>
>+	u32 reg;
>
>+	int rate_code, i;
>
>+	unsigned long rate;
>
>+
>
>+	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>
>+	if (!data)
>
>+		return -ENOMEM;
>
>+
>
>+	platform_set_drvdata(pdev, data);
>
>+
>
>+	data->dev =3D dev;
>
>+
>
>+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
>+	data->usbss =3D devm_ioremap_resource(dev, res);
>
>+	if (IS_ERR(data->usbss))
>
>+		return PTR_ERR(data->usbss);
>
>+
>
>+	data->usb2_refclk =3D devm_clk_get(dev, "ref");
>
>+	if (IS_ERR(data->usb2_refclk)) {
>
>+		dev_err(dev, "can't get usb2_refclk\n");
>
>+		return PTR_ERR(data->usb2_refclk);
>
>+	}
>
>+
>
>+	data->lpm_clk =3D devm_clk_get(dev, "lpm");
>
>+	if (IS_ERR(data->lpm_clk)) {
>
>+		dev_err(dev, "can't get lpm_clk\n");
>
>+		return PTR_ERR(data->lpm_clk);
>
>+	}
>
>+
>
>+	rate =3D clk_get_rate(data->usb2_refclk);
>
>+	rate /=3D 1000;	/* To KHz */
>
>+	for (i =3D 0; i < ARRAY_SIZE(cdns_ti_rate_table); i++) {
>
>+		if (cdns_ti_rate_table[i] =3D=3D rate)
>
>+			break;
>
>+	}
>
>+
>
>+	if (i =3D=3D ARRAY_SIZE(cdns_ti_rate_table)) {
>
>+		dev_err(dev, "unsupported usb2_refclk rate: %lu KHz\n", rate);
>
>+		return -EINVAL;
>
>+	}
>
>+
>
>+	rate_code =3D i;
>
>+
>
>+	pm_runtime_enable(dev);
>
>+	error =3D pm_runtime_get_sync(dev);
>
>+	if (error < 0) {
>
>+		dev_err(dev, "pm_runtime_get_sync failed: %d\n", error);
>
>+		goto err_get;
>
>+	}
>
>+
>
>+	/* assert RESET */
>
>+	reg =3D cdns_ti_readl(data, USBSS_W1);
>
>+	reg &=3D ~USBSS_W1_PWRUP_RST;
>
>+	cdns_ti_writel(data, USBSS_W1, reg);
>
>+
>
>+	/* set static config */
>
>+	reg =3D cdns_ti_readl(data, USBSS_STATIC_CONFIG);
>
>+	reg &=3D ~USBSS1_STATIC_PLL_REF_SEL_MASK;
>
>+	reg |=3D rate_code << USBSS1_STATIC_PLL_REF_SEL_SHIFT;
>
>+
>
>+	reg &=3D ~USBSS1_STATIC_VBUS_SEL_MASK;
>
>+	data->vbus_divider =3D device_property_read_bool(dev, "ti,vbus-divider")=
;
>
>+	if (data->vbus_divider)
>
>+		reg |=3D 1 << USBSS1_STATIC_VBUS_SEL_SHIFT;
>
>+
>
>+	cdns_ti_writel(data, USBSS_STATIC_CONFIG, reg);
>
>+	reg =3D cdns_ti_readl(data, USBSS_STATIC_CONFIG);
>
>+
>
>+	/* set USB2_ONLY mode if requested */
>
>+	reg =3D cdns_ti_readl(data, USBSS_W1);
>
>+	data->usb2_only =3D device_property_read_bool(dev, "ti,usb2-only");
>
>+	if (data->usb2_only)
>
>+		reg |=3D USBSS_W1_USB2_ONLY;
>
>+
>
>+	/* set default modestrap */
>
>+	reg |=3D USBSS_W1_MODESTRAP_SEL;
>
>+	reg &=3D ~USBSS_W1_MODESTRAP_MASK;
>
>+	reg |=3D USBSS_MODESTRAP_MODE_NONE << USBSS_W1_MODESTRAP_SHIFT;
>
>+	cdns_ti_writel(data, USBSS_W1, reg);
>
>+
>
>+	/* de-assert RESET */
>
>+	reg |=3D USBSS_W1_PWRUP_RST;
>
>+	cdns_ti_writel(data, USBSS_W1, reg);
>
>+
>
>+	error =3D of_platform_populate(node, NULL, NULL, dev);
>
>+	if (error) {
>
>+		dev_err(dev, "failed to create children: %d\n", error);
>
>+		goto err;
>
>+	}
>
>+
>
>+	return 0;
>
>+
>
>+err:
>
>+	pm_runtime_put_sync(data->dev);
>
>+err_get:
>
>+	pm_runtime_disable(data->dev);
>
>+
>
>+	return error;
>
>+}
>
>+
>
>+static int cdns_ti_remove_core(struct device *dev, void *c)
>
>+{
>
>+	struct platform_device *pdev =3D to_platform_device(dev);
>
>+
>
>+	platform_device_unregister(pdev);
>
>+
>
>+	return 0;
>
>+}
>
>+
>
>+static int cdns_ti_remove(struct platform_device *pdev)
>
>+{
>
>+	struct device *dev =3D &pdev->dev;
>
>+
>
>+	device_for_each_child(dev, NULL, cdns_ti_remove_core);
>
>+	pm_runtime_put_sync(dev);
>
>+	pm_runtime_disable(dev);
>
>+
>
>+	platform_set_drvdata(pdev, NULL);
>
>+
>
>+	return 0;
>
>+}
>
>+
>
>+static const struct of_device_id cdns_ti_of_match[] =3D {
>
>+	{ .compatible =3D "ti,j721e-usb", },
>
>+	{},
>
>+};
>
>+MODULE_DEVICE_TABLE(of, cdns_ti_of_match);
>
>+
>
>+static struct platform_driver cdns_ti_driver =3D {
>
>+	.probe		=3D cdns_ti_probe,
>
>+	.remove		=3D cdns_ti_remove,
>
>+	.driver		=3D {
>
>+		.name	=3D "cdns3-ti",
>
>+		.of_match_table	=3D cdns_ti_of_match,
>
>+	},
>
>+};
>
>+
>
>+module_platform_driver(cdns_ti_driver);
>
>+
>
>+MODULE_ALIAS("platform:cdns3-ti");
>
>+MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
>
>+MODULE_LICENSE("GPL v2");
>
>+MODULE_DESCRIPTION("Cadence USB3 TI Glue Layer");
>
>--
>
>Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>
>Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>
>

