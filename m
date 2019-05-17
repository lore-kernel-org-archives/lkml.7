Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E77DC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 05:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E78120833
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 05:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PXHUKQ8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfEQFtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 01:49:19 -0400
Received: from mail-eopbgr50050.outbound.protection.outlook.com ([40.107.5.50]:31363
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726772AbfEQFtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 01:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T85cY8VaZs5ybl5pYMF4MWXllFJWHzTIU2aBA5WmFko=;
 b=PXHUKQ8NKVG34T5p79GxdlpA7ivMq3gFdg1WkfLsXPLyCGjo0lfXFZBls8EfAyhMxwjNmGraEy712U/EWfbBHThSeunnFIPhJSEXo3KBKqXjI/cEpMlL6I99CNNP8CxV0evfLSeDci+Cg431KpfpBMaJW7ju3KFBxXkvyGBxE7Q=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3801.eurprd04.prod.outlook.com (52.134.65.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Fri, 17 May 2019 05:49:11 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 05:49:11 +0000
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
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4 1/2] soc: imx: Add SCU SoC info driver support
Thread-Topic: [PATCH V4 1/2] soc: imx: Add SCU SoC info driver support
Thread-Index: AQHVDHRAx0Mm9bAN6USp/nK7XaFMrA==
Date:   Fri, 17 May 2019 05:49:11 +0000
Message-ID: <1558071840-841-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::30) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e43d6df7-cc18-4a3f-a141-08d6da8b6236
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3801;
x-ms-traffictypediagnostic: DB3PR0402MB3801:
x-microsoft-antispam-prvs: <DB3PR0402MB3801B97C133E2EEFF21D859FF50B0@DB3PR0402MB3801.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39860400002)(376002)(346002)(199004)(189003)(53936002)(7416002)(36756003)(68736007)(3846002)(6116002)(2501003)(4326008)(8936002)(71200400001)(71190400001)(256004)(7736002)(8676002)(81156014)(81166006)(316002)(66066001)(2906002)(50226002)(6512007)(305945005)(478600001)(52116002)(6436002)(6486002)(386003)(73956011)(25786009)(99286004)(66446008)(64756008)(6506007)(14454004)(66556008)(2616005)(66946007)(476003)(66476007)(486006)(102836004)(86362001)(110136005)(26005)(186003)(5660300002)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3801;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IQnZ7wBPtBuyWWvKMUik/qg5vIZ3W0eepiTuuGkWqJRmuqDeMBQM6ZmNcRRwEYsk88xYCq21ugtM65/VQj4rlTBGCYUAUjoerR2LvAQoMKWbxWy6thynWCAQBvjrJ+aWkbeXqs26LG1+SXhi8NWwUyd+Cq1Xou8sYHor7U8A1bSQJbw3quIPPRD12W0GDsomwKTlNCALm4h4zDr6r4ZjJjztC6oZBuLRscx8v4qzKwgWPHa4mCHFAiyXFo0Y690OaYiqdMC9gBUqaL1/qPTbqgBhZ42ugQsvf8OMk53HvIadUFVB2iMRoEuKP1G9vQvEk5n0WQAtttKkmpWnObMTPSLUOl7ByXmADtDFuVXXj6KpBIYkrc0mLcPZ/sF4Q+4J/UgOR3HEqEU5J+V5Xcf5aTH4kRSqL5kwwXdZbNo0JNg=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <8E6A216F5B704C49BE49F1C317F3F49D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43d6df7-cc18-4a3f-a141-08d6da8b6236
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 05:49:11.2717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3801
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
Changes since V3:
	- remove of_device_id table to make it generic for all i.MX8 SoC with SCU =
inside, and check
	  "fsl,imx-scu" node to devide whether to register soc platform driver;
	- for soc_id, just return the value reading from SCU firmware instead of c=
reating string, for
	  detail name of soc_id, the machine name already contains it;
	- fix some error handling of kasprintf.
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
index 0000000..60458ac
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
+	struct device_node *root;
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
+	root =3D of_find_node_by_path("/");
+	ret =3D of_property_read_string(root,
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

