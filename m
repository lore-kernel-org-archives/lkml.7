Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4433EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A7520850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o23isgtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfCVQtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:49:25 -0400
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:43590
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726023AbfCVQtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBhMaMMiQLfs0Af+kpXApAY7Cuzq7AOincseW0P03AM=;
 b=o23isgtShOXt9GV+uyrCdF0nAPnv6BTYpyelC6SMaJ7AXGLPdMD5B89EgALhNx+Ap54MH7YgFvVFNfPRvHwjwEq3/yKAwNCD0JnjlwMWKViPJ8AWsuvKjOOG4iggCCPQIaXm8F6rBQ8RSneerdRTS/iLXLA7eaFVcAGs0MgtSL0=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4883.eurprd04.prod.outlook.com (20.176.215.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 22 Mar 2019 16:49:20 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019
 16:49:20 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND v2] soc: imx: Add generic i.MX8 SoC driver
Thread-Topic: [RESEND v2] soc: imx: Add generic i.MX8 SoC driver
Thread-Index: AQHU4M8x51owZIDO7UOOFQ/teNRhvw==
Date:   Fri, 22 Mar 2019 16:49:20 +0000
Message-ID: <1553273350-28852-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0031.eurprd05.prod.outlook.com
 (2603:10a6:803:1::44) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [212.146.100.6]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 043b0ca2-d642-42f1-cbae-08d6aee65447
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4883;
x-ms-traffictypediagnostic: AM0PR04MB4883:
x-microsoft-antispam-prvs: <AM0PR04MB48833B2AEEF0BD45F269D914F6430@AM0PR04MB4883.eurprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(396003)(346002)(366004)(189003)(199004)(36756003)(6486002)(486006)(2906002)(476003)(54906003)(2616005)(3846002)(81156014)(8936002)(81166006)(102836004)(386003)(305945005)(6506007)(66066001)(68736007)(256004)(71200400001)(6436002)(71190400001)(25786009)(478600001)(316002)(106356001)(105586002)(186003)(7736002)(50226002)(97736004)(99286004)(14454004)(6116002)(26005)(44832011)(5660300002)(53936002)(52116002)(110136005)(8676002)(86362001)(6512007)(4326008)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4883;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 61XRgljERh8S+Q/jTPhgz9fHaY3XwjDzIgSA6t2LTPcyOOV2nWWTi7LDG7KpnctgV1Z1cy6pnxrn48wFrrJDXPtyMsmdgt6MlJJZU8q9JRKOY/Wg3DGtt5pIeLmai0UVjddigu1E4xXcNd0krjJz5oFzlffuCnHex5lqRKuOY9UasvWJryE9rcKbuOsq709XuCXsPwtbaX8bHRMWpg88/MQPAUx3AbbUgQ2gIkIK09W2cBm+rAlKlnJXSFcimdZcBK4b8gSmqn64bSGuLd6bfqPjkTIEcIMv1aSWbrfp7riW+Lt2XxIf+kLaUpLizHmjZw6bzmk7PK21gVis/Ex4qybYlXqsFqZz6owm85D29t91MusZuDeGrxLcQ8Li5sakhFPZFD0EfV612KvksvCraefBXYgXofyElyE/wDFkfzE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043b0ca2-d642-42f1-cbae-08d6aee65447
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 16:49:20.1447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4883
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic i.MX8 SoC driver along with the i.MX8MQ SoC specific code.
For now, only i.MX8MQ revision B1 is supported. For any other, i.MX8MQ
revision it will print 'unknown'.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/soc/imx/Makefile   |   1 +
 drivers/soc/imx/soc-imx8.c | 115 +++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 116 insertions(+)
 create mode 100644 drivers/soc/imx/soc-imx8.c

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 506a6f3..d6b529e0 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_HAVE_IMX_GPC) +=3D gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) +=3D gpcv2.o
+obj-$(CONFIG_ARCH_MXC) +=3D soc-imx8.o
diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
new file mode 100644
index 0000000..fc6429f
--- /dev/null
+++ b/drivers/soc/imx/soc-imx8.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 NXP.
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+
+#define REV_B1				0x21
+
+#define IMX8MQ_SW_INFO_B1		0x40
+#define IMX8MQ_SW_MAGIC_B1		0xff0055aa
+
+struct imx8_soc_data {
+	char *name;
+	u32 (*soc_revision)(void);
+};
+
+static u32 __init imx8mq_soc_revision(void)
+{
+	struct device_node *np;
+	void __iomem *ocotp_base;
+	u32 magic;
+	u32 rev =3D 0;
+
+	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
+	if (!np)
+		goto out;
+
+	ocotp_base =3D of_iomap(np, 0);
+	WARN_ON(!ocotp_base);
+
+	magic =3D readl_relaxed(ocotp_base + IMX8MQ_SW_INFO_B1);
+	if (magic =3D=3D IMX8MQ_SW_MAGIC_B1)
+		rev =3D REV_B1;
+
+	iounmap(ocotp_base);
+
+out:
+	of_node_put(np);
+	return rev;
+}
+
+static const struct imx8_soc_data imx8mq_soc_data =3D {
+	.name =3D "i.MX8MQ",
+	.soc_revision =3D imx8mq_soc_revision,
+};
+
+static const struct of_device_id imx8_soc_match[] =3D {
+	{ .compatible =3D "fsl,imx8mq", .data =3D &imx8mq_soc_data, },
+	{ }
+};
+
+#define imx8_revision(soc_rev) \
+	soc_rev ? \
+	kasprintf(GFP_KERNEL, "%d.%d", (soc_rev >> 4) & 0xf,  soc_rev & 0xf) : \
+	"unknown"
+
+static int __init imx8_soc_init(void)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+	struct device_node *root;
+	const struct of_device_id *id;
+	u32 soc_rev =3D 0;
+	const struct imx8_soc_data *data;
+	int ret;
+
+	soc_dev_attr =3D kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENODEV;
+
+	soc_dev_attr->family =3D "Freescale i.MX";
+
+	root =3D of_find_node_by_path("/");
+	ret =3D of_property_read_string(root, "model", &soc_dev_attr->machine);
+	if (ret)
+		goto free_soc;
+
+	id =3D of_match_node(imx8_soc_match, root);
+	if (!id)
+		goto free_soc;
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
+	soc_dev_attr->revision =3D imx8_revision(soc_rev);
+	if (!soc_dev_attr->revision)
+		goto free_soc;
+
+	soc_dev =3D soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev))
+		goto free_rev;
+
+	return 0;
+
+free_rev:
+	kfree(soc_dev_attr->revision);
+free_soc:
+	kfree(soc_dev_attr);
+	of_node_put(root);
+	return -ENODEV;
+}
+device_initcall(imx8_soc_init);
--=20
2.7.4

