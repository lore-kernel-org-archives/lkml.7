Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5BEC04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 03:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA5220862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 03:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m6d80gIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfEPDYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 23:24:55 -0400
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:47490
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726464AbfEPDYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 23:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uA5dlFs1tJDaVpee3R6ZJwMuZkUdoZEiUhmRFxg/QAA=;
 b=m6d80gIwdsh7v4tHhIAoIPlwzZjFIG29VRg9ueMfj6BsfJnBKBJEf7Cb7LKvxiG263r/uyx0oAAv/AGYnfOcisZGhcgtoYXrQaiktkNBDyIe2TO3U2gXLlnJglM9x7N7oq2Fgh0JhBrjgiWVgoXqcde30bAhx9V/U/9crv3SiJw=
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com (52.133.37.151) by
 AM0PR0402MB3700.eurprd04.prod.outlook.com (52.133.36.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Thu, 16 May 2019 03:24:49 +0000
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::b99f:920e:7f36:7af9]) by AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::b99f:920e:7f36:7af9%5]) with mapi id 15.20.1878.024; Thu, 16 May 2019
 03:24:49 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V3 1/2] soc: imx: Add SCU SoC info driver support
Thread-Topic: [PATCH V3 1/2] soc: imx: Add SCU SoC info driver support
Thread-Index: AQHVC5bqk1P5MqRzRU2gqcSUyb18Bw==
Date:   Thu, 16 May 2019 03:24:48 +0000
Message-ID: <1557976777-8304-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0085.apcprd04.prod.outlook.com
 (2603:1096:202:15::29) To AM0PR0402MB3905.eurprd04.prod.outlook.com
 (2603:10a6:208:b::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2d1cac9-120b-4900-0143-08d6d9ae0cc9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR0402MB3700;
x-ms-traffictypediagnostic: AM0PR0402MB3700:
x-microsoft-antispam-prvs: <AM0PR0402MB370041C3E0B739ECA5556932F50A0@AM0PR0402MB3700.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(36756003)(2201001)(8936002)(50226002)(2501003)(86362001)(81156014)(316002)(8676002)(66066001)(3846002)(81166006)(14454004)(6116002)(2906002)(478600001)(68736007)(25786009)(305945005)(99286004)(2616005)(476003)(7736002)(4326008)(6486002)(26005)(7416002)(66556008)(256004)(102836004)(52116002)(486006)(386003)(6506007)(186003)(6436002)(66446008)(64756008)(66946007)(73956011)(71190400001)(71200400001)(5660300002)(110136005)(66476007)(53936002)(6512007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3700;H:AM0PR0402MB3905.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IZjNd74z44S9Z4/Hm8dk0Yt2WFTwLlBwr5sxScULJFQiEH/ArKaIlq7n5DOsldx7bYPsfXeq4lR4R8xz+Y5zeqO6IjCNXPdrNeJmWjaTSApweWQczzjjTUEuHRGoN5Ozl3Ou4e1fvwEw7HEFQjxMTAth9AvbwLpVvT+lnDmjC0KA9rDiE1sO8yVXMa1EpUVnAeVJh/HdsaBCNLip8pDX7UGUTyX+vAMS06oSdzh1XHQVRPepcWBDgp27o1LbbbF2Sa0S+RP9b7a0EVG3GlJVr7tvIWssobwXTafPmjoQvMG+CTafGS9lzJgml1VOQmVTwy77z4xt7nRAOMVxZTHwKEKTWqYZf50UM7ugrXJNsUlYwWJK+/OWIPMpr0+ygEPqf4U65aM5WCzXYNXFm3c13LGSHajMbc16boDhdrE5Mz0=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <2086D889AE1A614AA55E52F9D6128433@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d1cac9-120b-4900-0143-08d6d9ae0cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 03:24:48.8156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3700
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
i.MX8QXP

i.mx8qxp-mek# cat /sys/devices/soc0/machine
Freescale i.MX8QXP MEK

i.mx8qxp-mek# cat /sys/devices/soc0/revision
1.1

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- using device_initcall instead of module_init;
	- check of_match_node in init function and ONLY register platform driver w=
hen matched, this
	  is to avoid unnecessary probe for non SCU based i.MX8 SoCs.
---
 drivers/soc/imx/Kconfig       |   9 +++
 drivers/soc/imx/Makefile      |   1 +
 drivers/soc/imx/soc-imx-scu.c | 173 ++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 183 insertions(+)
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
index 0000000..243c418
--- /dev/null
+++ b/drivers/soc/imx/soc-imx-scu.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 NXP.
+ */
+
+#include <dt-bindings/firmware/imx/rsrc.h>
+#include <linux/firmware/imx/sci.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+
+#define IMX_SCU_SOC_DRIVER_NAME		"imx-scu-soc"
+
+static struct imx_sc_ipc *soc_ipc_handle;
+static struct platform_device *imx_scu_soc_pdev;
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
+struct imx_scu_soc_data {
+	char *name;
+	u32 (*soc_revision)(void);
+};
+
+static u32 imx8qxp_soc_revision(void)
+{
+	struct imx_sc_msg_misc_get_soc_id msg;
+	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
+	u32 rev;
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
+		dev_err(&imx_scu_soc_pdev->dev,
+			"get soc info failed, ret %d\n", ret);
+		/* return 0 means getting revision failed */
+		return 0;
+	}
+
+	/* format revision value passed from SCU firmware */
+	rev =3D (msg.data.resp.id >> 5) & 0xf;
+	rev =3D (((rev >> 2) + 1) << 4) | (rev & 0x3);
+
+	return rev;
+}
+
+static const struct imx_scu_soc_data imx8qxp_soc_data =3D {
+	.name =3D "i.MX8QXP",
+	.soc_revision =3D imx8qxp_soc_revision,
+};
+
+static const struct of_device_id imx_scu_soc_match[] =3D {
+	{ .compatible =3D "fsl,imx8qxp", .data =3D &imx8qxp_soc_data, },
+	{ }
+};
+
+#define imx_scu_revision(soc_rev) \
+	soc_rev ? \
+	kasprintf(GFP_KERNEL, "%d.%d", (soc_rev >> 4) & 0xf,  soc_rev & 0xf) : \
+	"unknown"
+
+static int imx_scu_soc_probe(struct platform_device *pdev)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	const struct imx_scu_soc_data *data;
+	const struct of_device_id *id;
+	struct soc_device *soc_dev;
+	u32 soc_rev =3D 0;
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
+	ret =3D of_property_read_string(pdev->dev.of_node,
+				      "model",
+				      &soc_dev_attr->machine);
+	if (ret)
+		return ret;
+
+	id =3D of_match_node(imx_scu_soc_match, pdev->dev.of_node);
+	data =3D id->data;
+	if (data) {
+		soc_dev_attr->soc_id =3D data->name;
+		if (data->soc_revision)
+			soc_rev =3D data->soc_revision();
+	}
+
+	soc_dev_attr->revision =3D imx_scu_revision(soc_rev);
+	if (!soc_dev_attr->revision)
+		return -ENODEV;
+
+	soc_dev =3D soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->revision);
+		return PTR_ERR(soc_dev);
+	}
+
+	return 0;
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
+	const struct of_device_id *id;
+	struct device_node *root;
+	int ret;
+
+	root =3D of_find_node_by_path("/");
+	id =3D of_match_node(imx_scu_soc_match, root);
+	if (!id) {
+		of_node_put(root);
+		return -ENODEV;
+	}
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
+	imx_scu_soc_pdev->dev.of_node =3D root;
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

