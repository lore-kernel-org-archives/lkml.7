Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF49EC4740C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 06:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9DF20882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 06:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QgnO3x5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393160AbfIWGhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 02:37:15 -0400
Received: from mail-eopbgr50082.outbound.protection.outlook.com ([40.107.5.82]:6115
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387519AbfIWGhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 02:37:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YX497xaUylI6hbDfHdbtPeXlw3coVUKfJUyqQ7g8nQZm51VksW8GjgvVz1p2X+OWSFAzfTI/OrbCPYG7ksvtWt4/8ivOQ2Sbins+J1aE86S6HkG3U00bFxf/VCDURyk5+1XsfBSY12etIZNJNXHL8nw6zzCYh5a1qrJO/BZglCYrPGKbnuHz26XLRdCSLPakmYzhqo0GwD4D9mUcxw5WI9IfAJmEboPi1ey7UguYitT5fQ3HuLJoBudg/Eco/x9tzu5XkSmprXaS4LiuDUbKl7/Wd87BZH5Uc1v2R6eyQpkSU1DGya1cLIceOkDVeiWUePRYuk0F2FisUDk/Q6H2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTMzL3RSKnGui4RaCFkQ3ifnzJ/sdAHOKuv7Q/txDdw=;
 b=jrqzv1xKMO0IzJU9PE7FZQqJWMYGm+YC4KZQbH32gkbcoG6wKU/Cr+K96vJBAl8UvEIc2eqKjtynAQAan0ta8tZF9S01U0D3Vg7shexyu/IALmg1+WEXijv79bNN091WX2KrYbLsZ8bNGw7oyjv9y0pcElD+TrFtNwb9twAf+YhPwZrzOGbeTunFbf/kY5lmPi6XSpojYkfL0KdgT66JeNZWAtxdQCQKHzZCasYQlHI3LvNTZ1lWZtf3zgPPiHFA4JmBGCq6j77xFk4YBr56bUUwNSuSqXzLYg+iXT1pSSN60oqI8M/WnHxp0L16Fe/cFbGQClIMOV2STnCQvJWZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTMzL3RSKnGui4RaCFkQ3ifnzJ/sdAHOKuv7Q/txDdw=;
 b=QgnO3x5TMq9PkC/PCW9yNQEue5tmFYmPejvHPk3KuNVqH6m/W5+alpQEldNv4zYegPvI+KO930SvoZdvymlBPtXM19qJaaGQgwwtonBcQMYyt9+gpCROWXRKR0X43g10Yb4+3a2Ob7z8aX/CVKKxPGcSSRUMpKjwlBnmwFhQZ2s=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4449.eurprd04.prod.outlook.com (52.135.148.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Mon, 23 Sep 2019 06:37:09 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 06:37:09 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Topic: [PATCH V7 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Index: AQHVcdlSnaopI9D/Y0WFH3ArfXrlxw==
Date:   Mon, 23 Sep 2019 06:37:08 +0000
Message-ID: <1569220514-27903-3-git-send-email-peng.fan@nxp.com>
References: <1569220514-27903-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1569220514-27903-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:203:2e::21) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d39051e-5531-4c19-73f8-08d73ff07532
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4449;
x-ms-traffictypediagnostic: AM0PR04MB4449:|AM0PR04MB4449:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4449844F19A0B68BDEA78D6088850@AM0PR04MB4449.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(189003)(199004)(2501003)(2201001)(305945005)(7736002)(54906003)(66066001)(64756008)(110136005)(66556008)(66476007)(316002)(66446008)(6306002)(71200400001)(6116002)(4326008)(71190400001)(86362001)(256004)(66946007)(6512007)(50226002)(8936002)(99286004)(52116002)(25786009)(76176011)(6436002)(26005)(3846002)(36756003)(8676002)(2906002)(11346002)(81166006)(81156014)(186003)(15650500001)(102836004)(446003)(44832011)(486006)(966005)(5660300002)(478600001)(6486002)(6506007)(386003)(476003)(2616005)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4449;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r5yYpxXjPyFgE3/YZ32E8m78usPJcZ5Mif2PnxYFBjqCO8GNKrCIIXmkEBtzR7tYP3Mb3dybDsQXCKXzn/3cjRnldJnPknwoyOkcMRT2iPpyPgTUVFSgL/erJ4f6/df0rY83IaciIOQjgYylMnzzZkCVcRu3L77fSR4fNXw7XvgXWXNlN5KIl7USKL34+KGbdu+oJ3ZCDR30sBSfKAnO6hHNAP5hij3qyh4hbJSWpRAcAQqzD2NFLJfqJdGXxHZVIdI9kZ8A6WXIO9Sg8EObCt5N/exCy3l51OSWIMhPxdac65OyXJA7MxOP9rbme9GiK8K62qlRmKP00NNqricdA//Gp8lUqKF5MnUh76CNui8FXLcyWTooDmdcwsTpr9NBACwNXO8+8RDzeR+Bg+WVR+wiKXiT0w9V7OgTg1ZgAcg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d39051e-5531-4c19-73f8-08d73ff07532
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 06:37:09.0414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jX1RuUTVINasTvMU0ccbZtnQH2WIHZqpCA080pAsXPDtIAhLOOgohyaNunY59yRm9XY4cBkYjNFsXBGIi+Btnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This mailbox driver implements a mailbox which signals transmitted data
via an ARM smc (secure monitor call) instruction. The mailbox receiver
is implemented in firmware and can synchronously return data when it
returns execution to the non-secure world again.
An asynchronous receive path is not implemented.
This allows the usage of a mailbox to trigger firmware actions on SoCs
which either don't have a separate management processor or on which such
a core is not available. A user of this mailbox could be the SCP
interface.

Modified from Andre Przywara's v2 patch
https://lore.kernel.org/patchwork/patch/812999/

Cc: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/Kconfig           |   7 ++
 drivers/mailbox/Makefile          |   2 +
 drivers/mailbox/arm-smc-mailbox.c | 168 ++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 177 insertions(+)
 create mode 100644 drivers/mailbox/arm-smc-mailbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index ab4eb750bbdd..7707ee26251a 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -16,6 +16,13 @@ config ARM_MHU
 	  The controller has 3 mailbox channels, the last of which can be
 	  used in Secure mode only.
=20
+config ARM_SMC_MBOX
+	tristate "Generic ARM smc mailbox"
+	depends on OF && HAVE_ARM_SMCCC
+	help
+	  Generic mailbox driver which uses ARM smc calls to call into
+	  firmware for triggering mailboxes.
+
 config IMX_MBOX
 	tristate "i.MX Mailbox"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index c22fad6f696b..93918a84c91b 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -7,6 +7,8 @@ obj-$(CONFIG_MAILBOX_TEST)	+=3D mailbox-test.o
=20
 obj-$(CONFIG_ARM_MHU)	+=3D arm_mhu.o
=20
+obj-$(CONFIG_ARM_SMC_MBOX)	+=3D arm-smc-mailbox.o
+
 obj-$(CONFIG_IMX_MBOX)	+=3D imx-mailbox.o
=20
 obj-$(CONFIG_ARMADA_37XX_RWTM_MBOX)	+=3D armada-37xx-rwtm-mailbox.o
diff --git a/drivers/mailbox/arm-smc-mailbox.c b/drivers/mailbox/arm-smc-ma=
ilbox.c
new file mode 100644
index 000000000000..664c8b4a0ed0
--- /dev/null
+++ b/drivers/mailbox/arm-smc-mailbox.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016,2017 ARM Ltd.
+ * Copyright 2019 NXP
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox/arm-smccc-mbox.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+struct arm_smc_chan_data {
+	unsigned int function_id;
+};
+
+typedef unsigned long (smc_mbox_fn)(unsigned int, unsigned long,
+				    unsigned long, unsigned long,
+				    unsigned long, unsigned long,
+				    unsigned long);
+static smc_mbox_fn *invoke_smc_mbox_fn;
+
+static int arm_smc_send_data(struct mbox_chan *link, void *data)
+{
+	struct arm_smc_chan_data *chan_data =3D link->con_priv;
+	struct arm_smccc_mbox_cmd *cmd =3D data;
+	unsigned long ret;
+	u32 function_id;
+
+	function_id =3D chan_data->function_id;
+	if (!function_id)
+		function_id =3D cmd->function_id;
+
+	if (ARM_SMCCC_IS_64(function_id)) {
+		ret =3D invoke_smc_mbox_fn(function_id, cmd->args_smccc64[0],
+					 cmd->args_smccc64[1],
+					 cmd->args_smccc64[2],
+					 cmd->args_smccc64[3],
+					 cmd->args_smccc64[4],
+					 cmd->args_smccc64[5]);
+	} else {
+		ret =3D invoke_smc_mbox_fn(function_id, cmd->args_smccc32[0],
+					 cmd->args_smccc32[1],
+					 cmd->args_smccc32[2],
+					 cmd->args_smccc32[3],
+					 cmd->args_smccc32[4],
+					 cmd->args_smccc32[5]);
+	}
+
+	mbox_chan_received_data(link, (void *)ret);
+
+	return 0;
+}
+
+static unsigned long __invoke_fn_hvc(unsigned int function_id,
+				     unsigned long arg0, unsigned long arg1,
+				     unsigned long arg2, unsigned long arg3,
+				     unsigned long arg4, unsigned long arg5)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_hvc(function_id, arg0, arg1, arg2, arg3, arg4,
+		      arg5, 0, &res);
+	return res.a0;
+}
+
+static unsigned long __invoke_fn_smc(unsigned int function_id,
+				     unsigned long arg0, unsigned long arg1,
+				     unsigned long arg2, unsigned long arg3,
+				     unsigned long arg4, unsigned long arg5)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(function_id, arg0, arg1, arg2, arg3, arg4,
+		      arg5, 0, &res);
+	return res.a0;
+}
+
+static const struct mbox_chan_ops arm_smc_mbox_chan_ops =3D {
+	.send_data	=3D arm_smc_send_data,
+};
+
+static struct mbox_chan *
+arm_smc_mbox_of_xlate(struct mbox_controller *mbox,
+		      const struct of_phandle_args *sp)
+{
+	return mbox->chans;
+}
+
+static int arm_smc_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct mbox_controller *mbox;
+	struct arm_smc_chan_data *chan_data;
+	int ret;
+	u32 function_id =3D 0;
+
+	if (of_device_is_compatible(dev->of_node, "arm,smc-mbox"))
+		invoke_smc_mbox_fn =3D __invoke_fn_smc;
+	else
+		invoke_smc_mbox_fn =3D __invoke_fn_hvc;
+
+	mbox =3D devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
+	if (!mbox)
+		return -ENOMEM;
+
+	mbox->of_xlate =3D arm_smc_mbox_of_xlate;
+	mbox->num_chans =3D 1;
+	mbox->chans =3D devm_kzalloc(dev, sizeof(*mbox->chans), GFP_KERNEL);
+	if (!mbox->chans)
+		return -ENOMEM;
+
+	chan_data =3D devm_kzalloc(dev, sizeof(*chan_data), GFP_KERNEL);
+	if (!chan_data)
+		return -ENOMEM;
+
+	of_property_read_u32(dev->of_node, "arm,func-id", &function_id);
+	chan_data->function_id =3D function_id;
+
+	mbox->chans->con_priv =3D chan_data;
+
+	mbox->txdone_poll =3D false;
+	mbox->txdone_irq =3D false;
+	mbox->ops =3D &arm_smc_mbox_chan_ops;
+	mbox->dev =3D dev;
+
+	platform_set_drvdata(pdev, mbox);
+
+	ret =3D devm_mbox_controller_register(dev, mbox);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "ARM SMC mailbox enabled.\n");
+
+	return ret;
+}
+
+static int arm_smc_mbox_remove(struct platform_device *pdev)
+{
+	struct mbox_controller *mbox =3D platform_get_drvdata(pdev);
+
+	mbox_controller_unregister(mbox);
+	return 0;
+}
+
+static const struct of_device_id arm_smc_mbox_of_match[] =3D {
+	{ .compatible =3D "arm,smc-mbox", },
+	{ .compatible =3D "arm,hvc-mbox", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, arm_smc_mbox_of_match);
+
+static struct platform_driver arm_smc_mbox_driver =3D {
+	.driver =3D {
+		.name =3D "arm-smc-mbox",
+		.of_match_table =3D arm_smc_mbox_of_match,
+	},
+	.probe		=3D arm_smc_mbox_probe,
+	.remove		=3D arm_smc_mbox_remove,
+};
+module_platform_driver(arm_smc_mbox_driver);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("Generic ARM smc mailbox driver");
+MODULE_LICENSE("GPL v2");
--=20
2.16.4

