Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56814ECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 04:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD7E214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 04:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="bPK37mPF";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="MHXXSdRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407746AbfJQEMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 00:12:06 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:55098 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407691AbfJQEMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 00:12:05 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9H48Zam024968;
        Wed, 16 Oct 2019 21:11:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=YqpHBXY0PHXF8ELR0fNtMWSq/CQ+Sf0FeaOPmgHxngc=;
 b=bPK37mPFvcuw5dCM/QP483gNVbJsq6x5KtHtBmNy5vCLOP8NXm3nIVtGrRt2ZHsPbAhe
 W2b91vRWvpKCfadliDfiSmet8IfRrpPA8gcXAAgyK2/BN/KowS2WWU1iP+hvpdfXuh9a
 JSWehSpjXCpr7A/GDwXnapW616fNat0U4MjqvMmtfp5O5DkY8YYTtKG19kLZw60c560I
 Lh/hFCvkkz+sSGXr2YHObsObIbElgWkEFqPOE2GZ9jf01tdwARtR7taI6zZcQgHf5Brp
 3nxzyLqqr5ZtelGKS09yU7BQMCW9aD8VoI/meflYuibAsbJPOpt0Kxk39ANFUN3jIW07 MA== 
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2057.outbound.protection.outlook.com [104.47.49.57])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2vkadyj4am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 21:11:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVZs0sYIGUisAgjOxTjn5mkZ0OvMshymJfL82C8DFjGF2QDGptad4O07OfhgnkOdgvpfggK+4ZpnWaB35SjFdkGIQM5b/HZ3DMHZG2kUR9eb4Mx5hZGk5/Nmv79UgfUnMtTsOz0aqGnkpj5k7PernoZtSYHTLe82dWwy/O3q5Pmnvu+gSl7moeRIwn26G9qpgxVvK3wWYB2uNVrCZDgYVC/vww/vfnmzfoip/OMP+ZDE185hSldagNy4gqV8kwZw/1ioMADkUa8s/QzRmZjMZ1Ut/U/8JBRk67G6UlPvptNBQt+Pkt++lQLtZsbzy9Uy7sbl8JJfCDmHzM2tNM5j+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqpHBXY0PHXF8ELR0fNtMWSq/CQ+Sf0FeaOPmgHxngc=;
 b=bGuNCijPH86QjXyKJ0KyAQDf1K6q5pbhBj/31j/7erS9ofwKq9ASzhhUS1u193Q8IN0Qz+3i7wQFTE6kWcyqSQI3Z1puMkVNWV3kabLQWzwPSYJa3+aEnrqOqVRBSEHXyv0lIUcg3pbAOLQxUX6NiEqjuCvWryP7atqz3uublIb+DB3L0xzWxoKO09XxNLlUDpnL/+mhCLF7C7XNYWBnKazRmpfgJDBkgmccu1BSjpWwoTSLjlYbg/CgV1CrcN/RJ4+xxxjb65ubNZZ174ZxwWIRF9CHL1y7wsqtGJGezdLS1gyaFtJGTy3is85TFp5XuzI+fNZnabG/VbAcFO0QoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqpHBXY0PHXF8ELR0fNtMWSq/CQ+Sf0FeaOPmgHxngc=;
 b=MHXXSdRnIS0hDuij+QLI1hbJNSo+r9DUCeNqckWXZghCzUJ3I5rW7CEF1PCcSutVL2XzndJwFd7bVJecBnHcKjkK1Jy2g7inH36gmEu6RY+iH1zwSvNhZy4vS6R0DbvTE7BNcg83QeS9vTB55y/uZhTST+4Um3mWYrupuXvBUAQ=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5624.namprd07.prod.outlook.com (20.177.231.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Thu, 17 Oct 2019 04:11:56 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770%6]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 04:11:56 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 2/2] usb: cdns3: Add TI specific wrapper driver
Thread-Topic: [PATCH 2/2] usb: cdns3: Add TI specific wrapper driver
Thread-Index: AQHVfQQ5+muJa5awiUi+/NL8HJHfmKdeRxOA
Date:   Thu, 17 Oct 2019 04:11:55 +0000
Message-ID: <BYAPR07MB4709DF188FB4B95FB5520ADFDD6D0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <20191007114142.5182-1-rogerq@ti.com>
 <20191007114142.5182-3-rogerq@ti.com>
In-Reply-To: <20191007114142.5182-3-rogerq@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctM2U0NzFmODgtZjA5NC0xMWU5LTg3NGItYTQ0Y2M4YzMwYmQ0XGFtZS10ZXN0XDNlNDcxZjhhLWYwOTQtMTFlOS04NzRiLWE0NGNjOGMzMGJkNGJvZHkudHh0IiBzej0iOTg4MiIgdD0iMTMyMTU3NTkxMTEyNDUzMjI4IiBoPSJjZCt1djE5cXltRHJnRGhlc0cycDdtd2U3aGc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 157ac6b7-2f4d-4dc9-86e3-08d752b825f9
x-ms-traffictypediagnostic: BYAPR07MB5624:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR07MB5624E0C58E062D6A6649E688DD6D0@BYAPR07MB5624.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(189003)(199004)(36092001)(54906003)(74316002)(25786009)(478600001)(76176011)(7696005)(99286004)(305945005)(52536014)(2906002)(7736002)(76116006)(3846002)(6116002)(6246003)(229853002)(64756008)(66556008)(66446008)(66946007)(5660300002)(110136005)(4326008)(66476007)(316002)(33656002)(6306002)(14454004)(55016002)(2501003)(71190400001)(81156014)(66066001)(9686003)(8936002)(81166006)(486006)(6436002)(186003)(86362001)(71200400001)(446003)(6506007)(26005)(11346002)(966005)(102836004)(476003)(256004)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5624;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /KIWjeCkcZ00gAsU3qb0uJDTJyVwU4UblZZBiKM1exSTYLpnrAi+lDJyZQj4Tb0g/6vHJ2jWQLF2jbULfcl29okPB7lF7lOjcy1YeFnwRhtoBLq9dcqixlyXTU5IDhzO5O+CCpjN1nppuhy2QqcTnBHU63aEOmhxf4bpgtbsUpw9SX60SSP54/I5Je/7R5w15vCtuelvEebDBmhDgXhrghcxQJtk7yUtb7w+dWEoyGF1/YEFh9orKnaZ+hx0FFWNeVPiH6nhDsGBWEE4+ObNx7GiitXsGFFp95wD9XpZBVixWLBhPz3hpoBE4aD2HNlOC07nHx4cVLc0RhGfNsx04L4r9bBMj9S+oisXTcfX+nJ3BUoy1EIQN0YpbIsYw4suCxe59D/w5QnR+YwXNHYo0XZbx9cpa4eZDuBmh6Wma8BSZ+K/ysqsXYhjuF3DxoscQdFQkdE32EOwlOTLlXrKaQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157ac6b7-2f4d-4dc9-86e3-08d752b825f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 04:11:55.7586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s26e7pUiZ6L00iPw1UScgxXyE/F4JSHgYolyDpV/AXqaYPggMsscbq12uci0xk/L0Rd0X5sGtp2vpK0BjveM/NSM0SJBNvOyivhYv36fQ/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5624
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_01:2019-10-16,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910170028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

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
> drivers/usb/cdns3/cdns3-ti.c | 244 +++++++++++++++++++++++++++++++++++
>
> 3 files changed, 255 insertions(+)
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
>index 000000000000..7447f5fcbe64
>
>--- /dev/null
>
>+++ b/drivers/usb/cdns3/cdns3-ti.c
>
>@@ -0,0 +1,244 @@
>
>+// SPDX-License-Identifier: GPL-2.0
>
>+/**
>
>+ * cdns_ti-ti.c - TI specific Glue layer for Cadence USB Controller
>
>+ *
>
>+ * Copyright (C) 2019 Texas Instruments Incorporated - https://urldefense=
.proofpoint.com/v2/url?u=3Dhttp-
>3A__www.ti.com&d=3DDwIBAg&c=3DaUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&=
r=3De1OgxfvkL0qo9XO6fX1gscva-
>w03uSYC1nIyxl89-
>rI&m=3DcRVMFQ8EW2o1zPxOk40aNbOduH3ZSMTGs3Gjr6j7DIw&s=3DCX3YTCKJekxIRkpi36c=
Pmm8eEH1NK7Ipaag0MVAL4cc&e=3D
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
>+	int modestrap_mode;
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
>+	data->usb2_refclk =3D devm_clk_get(dev, "usb2_refclk");
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
>+	data->lpm_clk =3D devm_clk_get(dev, "lpm_clk");
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
>+	/* set modestrap  */
>
>+	if (device_property_read_bool(dev, "ti,modestrap-host"))
>
>+		modestrap_mode =3D USBSS_MODESTRAP_MODE_HOST;
>
>+	else if (device_property_read_bool(dev, "ti,modestrap-peripheral"))
>
>+		modestrap_mode =3D USBSS_MODESTRAP_MODE_PERIPHERAL;
>
>+	else
>
>+		modestrap_mode =3D USBSS_MODESTRAP_MODE_NONE;
>
>+
>
>+	reg |=3D USBSS_W1_MODESTRAP_SEL;
>
>+	reg &=3D ~USBSS_W1_MODESTRAP_MASK;
>
>+	reg |=3D modestrap_mode << USBSS_W1_MODESTRAP_SHIFT;
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


Reviewed-by: Pawel Laszczak <pawell@cadence.com>

Regards,
Pawel

>--
>
>Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>
>Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>
>

