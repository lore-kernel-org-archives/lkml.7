Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A648BC072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F9B20851
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HajHFarC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfEVGXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 02:23:38 -0400
Received: from mail-eopbgr20056.outbound.protection.outlook.com ([40.107.2.56]:35331
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725850AbfEVGXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 02:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3/yQ8WQegMzQavf9PPoPb0aqwyXQdv/VrCiEgX98s8=;
 b=HajHFarCcZAzSehDhlfQ8eywOfs4CQn6+ehVf2lMvu9iC70VAgN1PPiryoNTd9ayO1arROG444c7yhHTHjA5sxJ3bYXaUEes19YzTURgDVrbbCRBlYPElCUmytyuPtMejTawPm4MpJ+sw/OBXGUJVZI0VBsvOdkY/wZKdwIpnGQ=
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com (52.133.37.151) by
 AM0PR0402MB3330.eurprd04.prod.outlook.com (52.133.47.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.20; Wed, 22 May 2019 06:23:32 +0000
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::b99f:920e:7f36:7af9]) by AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::b99f:920e:7f36:7af9%5]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 06:23:32 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 1/2] soc: imx: Add SCU SoC info driver support
Thread-Topic: [PATCH V5 1/2] soc: imx: Add SCU SoC info driver support
Thread-Index: AQHVEGbg2QLbsVO1oE+jxvonbRb8fg==
Date:   Wed, 22 May 2019 06:23:31 +0000
Message-ID: <1558505898-722-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0056.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::20) To AM0PR0402MB3905.eurprd04.prod.outlook.com
 (2603:10a6:208:b::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2adf1dce-202a-4842-0d20-08d6de7e02b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR0402MB3330;
x-ms-traffictypediagnostic: AM0PR0402MB3330:
x-microsoft-antispam-prvs: <AM0PR0402MB3330DB3028208D573F8798BEF5000@AM0PR0402MB3330.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(189003)(199004)(498600001)(3846002)(2906002)(53936002)(6116002)(7416002)(66066001)(5660300002)(14454004)(476003)(2616005)(6486002)(6436002)(486006)(99286004)(36756003)(305945005)(66946007)(73956011)(26005)(6512007)(8676002)(7736002)(66556008)(110136005)(71200400001)(2501003)(81166006)(64756008)(66446008)(386003)(71190400001)(6506007)(81156014)(25786009)(66476007)(52116002)(186003)(4326008)(68736007)(50226002)(8936002)(256004)(102836004)(2201001)(86362001)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3330;H:AM0PR0402MB3905.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DWzGLPSK0+lF3igsmZ2YgzACU4tmaxpXvzCODEtJ88RoA5Q/yRQnM+y3oJx7A+4dnKZqx8A6lfy+KjFlebfnAxCsAHFNV2REbGQPinNrgTF3C4bC4E/S3DskhIsLKpe+AIry4jBUjpi/JAkxQl2Loywwr4xDGJURwrBa6CyAVqzFEM2AeyQEVZTPJWMUicXCHzzT4G1cAbyd+OB+Xb51MTSNsbKYqzEWjHIGNDoKVNZBfF71otxgmBPxYGTZx6P6+oUpZQwGBErkh95SrG+S3VQ8a9MeZBc5ZnWzIHq0YSJGY80k+eFAqXmRwn6LehIB9b5tWNoqaGHJjDVwpJojAtHJkXCQ6Ftf4x49qQyxLm9x4EYn/cHLq6V54EK6NHJ5GhahgSUR//7iMG88QH0K5dqGkDt/clx6uTAZy0S2mqs=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E9E69FF8C523B347A5B1392E3D508A60@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adf1dce-202a-4842-0d20-08d6de7e02b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 06:23:32.1477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX SCU SoC info driver to support i.MX8QXP SoC, introduce
driver dependency into Kconfig as CONFIG_IMX_SCU must be
selected to support i.MX SCU SoC driver, also need to use
platform driver model to make sure IMX_SCU driver is probed
before i.MX SCU SoC driver.

With this patch, SoC info can be read from sysfs:

i.mx8qxp-mek# cat /sys/devices/soc0/family
Freescale i.MX

i.mx8qxp-mek# cat /sys/devices/soc0/soc_id
0x2

i.mx8qxp-mek# cat /sys/devices/soc0/machine
Freescale i.MX8QXP MEK

i.mx8qxp-mek# cat /sys/devices/soc0/revision
1.1

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V4:
	- using extern struct of_root instead of searching it again from DT;
	- add of_node_put() after "fsl,imx-scu" is found.
---
 drivers/soc/imx/Kconfig       |   9 +++
 drivers/soc/imx/Makefile      |   1 +
 drivers/soc/imx/soc-imx-scu.c | 155 ++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 165 insertions(+)
 create mode 100644 drivers/soc/imx/soc-imx-scu.c

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index d80f899..cbc1a41 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -7,4 +7,13 @@ config IMX_GPCV2_PM_DOMAINS
 	select PM_GENERIC_DOMAINS
 	default y if SOC_IMX7D
=20
+config IMX_SCU_SOC
+	bool "i.MX System Controller Unit SoC info support"
+	depends on IMX_SCU
+	select SOC_BUS
+	help
+	  If you say yes here you get support for the NXP i.MX System
+	  Controller Unit SoC info module, it will provide the SoC info
+	  like SoC family, ID and revision etc.
+
 endmenu
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index d6b529e0..ddf343d 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_HAVE_IMX_GPC) +=3D gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) +=3D gpcv2.o
 obj-$(CONFIG_ARCH_MXC) +=3D soc-imx8.o
+obj-$(CONFIG_IMX_SCU_SOC) +=3D soc-imx-scu.o
diff --git a/drivers/soc/imx/soc-imx-scu.c b/drivers/soc/imx/soc-imx-scu.c
new file mode 100644
index 0000000..17deb4e
--- /dev/null
+++ b/drivers/soc/imx/soc-imx-scu.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 NXP.
+ */
+
+#include <dt-bindings/firmware/imx/rsrc.h>
+#include <linux/firmware/imx/sci.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+
+#define IMX_SCU_SOC_DRIVER_NAME		"imx-scu-soc"
+
+static struct imx_sc_ipc *soc_ipc_handle;
+
+struct imx_sc_msg_misc_get_soc_id {
+	struct imx_sc_rpc_msg hdr;
+	union {
+		struct {
+			u32 control;
+			u16 resource;
+		} send;
+		struct {
+			u32 id;
+			u16 reserved;
+		} resp;
+	} data;
+} __packed;
+
+static u32 imx_scu_soc_id(void)
+{
+	struct imx_sc_msg_misc_get_soc_id msg;
+	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
+	int ret;
+
+	hdr->ver =3D IMX_SC_RPC_VERSION;
+	hdr->svc =3D IMX_SC_RPC_SVC_MISC;
+	hdr->func =3D IMX_SC_MISC_FUNC_GET_CONTROL;
+	hdr->size =3D 3;
+
+	msg.data.send.control =3D IMX_SC_C_ID;
+	msg.data.send.resource =3D IMX_SC_R_SYSTEM;
+
+	ret =3D imx_scu_call_rpc(soc_ipc_handle, &msg, true);
+	if (ret) {
+		pr_err("%s: get soc info failed, ret %d\n", __func__, ret);
+		/* return 0 means getting revision failed */
+		return 0;
+	}
+
+	return msg.data.resp.id;
+}
+
+static int imx_scu_soc_probe(struct platform_device *pdev)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+	u32 id, val;
+	int ret;
+
+	/* wait i.MX SCU driver ready */
+	ret =3D imx_scu_get_handle(&soc_ipc_handle);
+	if (ret)
+		return ret;
+
+	soc_dev_attr =3D devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr),
+				    GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->family =3D "Freescale i.MX";
+
+	ret =3D of_property_read_string(of_root,
+				      "model",
+				      &soc_dev_attr->machine);
+	if (ret)
+		return ret;
+
+	id =3D imx_scu_soc_id();
+
+	/* format soc_id value passed from SCU firmware */
+	val =3D id & 0x1f;
+	soc_dev_attr->soc_id =3D val ? kasprintf(GFP_KERNEL, "0x%x", val)
+			       : "unknown";
+	if (!soc_dev_attr->soc_id)
+		return -ENOMEM;
+
+	/* format revision value passed from SCU firmware */
+	val =3D (id >> 5) & 0xf;
+	val =3D (((val >> 2) + 1) << 4) | (val & 0x3);
+	soc_dev_attr->revision =3D val ? kasprintf(GFP_KERNEL,
+						 "%d.%d",
+						 (val >> 4) & 0xf,
+						 val & 0xf) : "unknown";
+	if (!soc_dev_attr->revision) {
+		ret =3D -ENOMEM;
+		goto free_soc_id;
+	}
+
+	soc_dev =3D soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		ret =3D PTR_ERR(soc_dev);
+		goto free_revision;
+	}
+
+	return 0;
+
+free_revision:
+	kfree(soc_dev_attr->revision);
+free_soc_id:
+	kfree(soc_dev_attr->soc_id);
+	return ret;
+}
+
+static struct platform_driver imx_scu_soc_driver =3D {
+	.driver =3D {
+		.name =3D IMX_SCU_SOC_DRIVER_NAME,
+	},
+	.probe =3D imx_scu_soc_probe,
+};
+
+static int __init imx_scu_soc_init(void)
+{
+	struct platform_device *imx_scu_soc_pdev;
+	struct device_node *np;
+	int ret;
+
+	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx-scu");
+	if (!np)
+		return -ENODEV;
+
+	of_node_put(np);
+
+	ret =3D platform_driver_register(&imx_scu_soc_driver);
+	if (ret)
+		return ret;
+
+	imx_scu_soc_pdev =3D
+		platform_device_register_simple(IMX_SCU_SOC_DRIVER_NAME,
+						-1,
+						NULL,
+						0);
+	if (IS_ERR(imx_scu_soc_pdev)) {
+		ret =3D PTR_ERR(imx_scu_soc_pdev);
+		goto unreg_platform_driver;
+	}
+
+	return 0;
+
+unreg_platform_driver:
+	platform_driver_unregister(&imx_scu_soc_driver);
+	return ret;
+}
+device_initcall(imx_scu_soc_init);
--=20
2.7.4

