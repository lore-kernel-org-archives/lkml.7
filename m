Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6A5C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 02:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9B920882
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 02:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZDNIU5UJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfEMC7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 22:59:25 -0400
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:62016
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727132AbfEMC7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 22:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aazZoe2JxVf6tbNvd2la8SBw9qmOvqn0Pz2yVRvDA1Q=;
 b=ZDNIU5UJ/z366KAVCfQ0Bj4ekhbJ3sjk10h8K5hCqaJyNkw6BHIImzFVLl1SYfNlHMQEhIzz5kDCOfAc/nlW359BtnUv0Q3UYO9U+lS2ryFIUmeZTIIqTcRu76gtfp0sOQ8LkiCVf+RiwMa5AZT6TjWE7feIHmkjJkVf3hUPtzk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Mon, 13 May 2019 02:59:17 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 02:59:17 +0000
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
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH RESEND 1/2] soc: imx: Add SCU SoC info driver support
Thread-Topic: [PATCH RESEND 1/2] soc: imx: Add SCU SoC info driver support
Thread-Index: AQHVCTfaYqtO/eSQ1UCSJJ4U0eiBlA==
Date:   Mon, 13 May 2019 02:59:17 +0000
Message-ID: <1557716049-22744-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d7be45c-0a62-4def-9a2c-08d6d74efcb8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB3707F1A8837F7AE8C32B1310F50F0@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(136003)(199004)(189003)(26005)(66066001)(6512007)(6306002)(71200400001)(71190400001)(966005)(386003)(6506007)(316002)(305945005)(110136005)(68736007)(478600001)(52116002)(2501003)(7736002)(99286004)(14454004)(102836004)(81156014)(6436002)(81166006)(73956011)(6486002)(8676002)(4326008)(8936002)(486006)(25786009)(6116002)(3846002)(50226002)(5660300002)(256004)(36756003)(186003)(86362001)(2616005)(2906002)(53936002)(66446008)(64756008)(66946007)(7416002)(2201001)(66556008)(66476007)(476003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zN7+DwiHQoi4LXPHj3a+YX7Bp5jgw0fxntmcFgXpcoKrZaNYnbxpE0e6K2fUOxr8yRLZ1mUD2mhxMAL0rtU+lWoOL3NpV8kaQT4rTxtPLCdh3rCfCfoBXxcEbgkpZ3CmgVEo83cFWGmxV8BvTkZII0YdRjh3W9G3XO9fER0yhAL8erRFJoIG7XAwxZ7RIne22iJtSK0rJMY8+wxsYQXQQZv0MTDRB6gWA149bNeREhIbg20InFWCcFbGhm/IG/Kc3DOosrbV3V8GyVOjnTV2gVhPMvM4QIRGQ58o6qtgIPq2vtPLjEEYep49wJ/6a58HBqvAZz9O6eZqRr5XrZLnfrutITEH2GyfVTE5c5mqSX4hZ/5gw61GlCaCxohk4w1+f9g6jOjPiTboZtwjDfrM36JOczoyZwgFf7xzefY3PDI=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <100285B8E8F37144AD2A125D34FB0D13@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7be45c-0a62-4def-9a2c-08d6d74efcb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 02:59:17.0463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
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
This patch is the resend version of patch series https://patchwork.kernel.o=
rg/patch/10895147/, changes as
below:
	- use correct encoding;
	- use same method of creating soc info as current existing i.MX8MQ soc dri=
ver, the ONLY differences
	  are: scu soc driver needs to use defer probe to wait i.MX SCU driver rea=
dy; need to get soc info
	  from SCU using SCU FW API.
---
 drivers/soc/imx/Kconfig       |   9 +++
 drivers/soc/imx/Makefile      |   1 +
 drivers/soc/imx/soc-imx-scu.c | 182 ++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 192 insertions(+)
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
index 0000000..e81055d
--- /dev/null
+++ b/drivers/soc/imx/soc-imx-scu.c
@@ -0,0 +1,182 @@
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
+	u32 rev =3D 0;
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
+		return rev;
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
+	struct device_node *root;
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
+	root =3D of_find_node_by_path("/");
+	ret =3D of_property_read_string(root, "model", &soc_dev_attr->machine);
+	if (ret) {
+		of_node_put(root);
+		return ret;
+	}
+
+	id =3D of_match_node(imx_scu_soc_match, root);
+	if (!id) {
+		of_node_put(root);
+		return -ENODEV;
+	}
+
+	of_node_put(root);
+
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
+		return -ENODEV;
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
+	int ret;
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
+
+static void __exit imx_scu_soc_exit(void)
+{
+	platform_device_unregister(imx_scu_soc_pdev);
+	platform_driver_unregister(&imx_scu_soc_driver);
+}
+
+module_init(imx_scu_soc_init);
+module_exit(imx_scu_soc_exit);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("i.MX system controller unit SoC driver");
+MODULE_LICENSE("GPL v2");
--=20
2.7.4

