Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4E2C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9734720843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vyvrz9rF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfEOIcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:32:18 -0400
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:19814
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbfEOIcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sD7VFq6/AJqUDrlDq38Fi76A4V+4v9NdTh4UKgIH430=;
 b=Vyvrz9rFFaqP2+o6YDexx8BTB+wxINzwDsHUTUK5UV0rNgMEKiWcjpsF4GBw9GhFlEGvzcIopTnTed71Hi1Zm7mOeLvz/7+yRmDhODL5J73/sqPuDD3FZYA5QkHB9Ba3zQ0nUoUxjfs0AeEG0Xur79496hVrX7r9Az88WIsM3V4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3897.eurprd04.prod.outlook.com (52.134.73.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 08:32:12 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 08:32:12 +0000
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
        Abel Vesa <abel.vesa@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 1/2] soc: imx: Add SCU SoC info driver support
Thread-Topic: [PATCH V2 1/2] soc: imx: Add SCU SoC info driver support
Thread-Index: AQHVCvixb1MFrIDHlECOalYM+lyDeQ==
Date:   Wed, 15 May 2019 08:32:12 +0000
Message-ID: <1557908823-11349-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::18) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14cbc943-d311-41b4-0459-08d6d90fd3bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3897;
x-ms-traffictypediagnostic: DB3PR0402MB3897:
x-microsoft-antispam-prvs: <DB3PR0402MB3897A6FCCBCD90EBDC523F6FF5090@DB3PR0402MB3897.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(396003)(376002)(189003)(199004)(256004)(486006)(6486002)(2616005)(476003)(2501003)(6512007)(3846002)(66446008)(316002)(66476007)(14454004)(73956011)(53936002)(66946007)(7416002)(25786009)(66556008)(64756008)(305945005)(7736002)(186003)(6116002)(6436002)(68736007)(66066001)(81156014)(71190400001)(8936002)(26005)(110136005)(478600001)(102836004)(52116002)(36756003)(8676002)(71200400001)(2201001)(4326008)(50226002)(2906002)(5660300002)(386003)(86362001)(6506007)(81166006)(99286004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3897;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QtEU5QgBjHXFeLtEvmQlyWjzC2fxSXGyVQ1GzlmpE1+hLvtPrIGjHEdrfPYhjIk4O+YiUrknMN4qong05aDCF8p4guspLlD5TYFJhO0oEW1wTTBEHy8WbRjMggtGoDOhhbzRi5l77a8LMJQt/7jrIuaZ8B8gCF7ql18sk17Yh8vHVBZeMttapyUYXj9l+xdLXhUPQtGGtODIbk7lrKyMx3rqBcGxFeXJFA3tgwUqxwPthn+M/JF4/NaYgTfmGBsLGHgRBGKiJi8e9eeEObyzMMjQ0VgTvAkzKSjjKk7RzrlLeKDXZ6QmWQhX9ngNp6GVsGFYYMhR/d3wKHA0Vq9ss9iY2xGEZc97mCNgAASGpgXIID74ZQjqz7Wdyw9j2R6VIFtvEL6Vix3ODhQqyYRSHfwutWJMWuZ41snhX6A7UNo=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <50EC2614903BAE4C84F45A6ECC0D94A4@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cbc943-d311-41b4-0459-08d6d90fd3bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 08:32:12.4854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3897
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
Changes since V1:
	- return correct value in probe function instead of hardcode;
	- add comment to explain why return 0 when get soc info from SCU firmware =
failed.
---
 drivers/soc/imx/Kconfig       |   9 +++
 drivers/soc/imx/Makefile      |   1 +
 drivers/soc/imx/soc-imx-scu.c | 183 ++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 193 insertions(+)
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
index 0000000..2331209
--- /dev/null
+++ b/drivers/soc/imx/soc-imx-scu.c
@@ -0,0 +1,183 @@
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
+		/* return 0 means getting revision failed */
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

