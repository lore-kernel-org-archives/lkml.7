Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ABAC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863EC20890
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XKlvryg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbfIPJot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 05:44:49 -0400
Received: from mail-eopbgr130054.outbound.protection.outlook.com ([40.107.13.54]:50033
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729400AbfIPJop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 05:44:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Be3MTed1PRJzwcCt1hGDgWf0rBFEdn01ovY5tzHsyDtY8q1NoG192wWOCZTKEjiB6jwMXyyhHMHRD+PXScyxG+yZF0OTWDkEMCnjSfMIrG8wrH/Phg9bJGrs5X0OxK2HINWLhc1HdcC11zdX9golGyUz8oceXF4AN6OLsiPRYkEGC9xIbQII28a0+t25XvNC933c2XgDCOvxUTbrvwPECFsBtFowc9ICr/1WqPSW+fhASICdv6KQBQAQaRFOqq8vcIYEMY8b/vCjExYAZD7qvyNUCQXwawW4FKznTBrQvOWB3dbGloKq65UgsbpDIiH6eDmmslZqGKirjBdfOfiwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FJTyOwjd9hE2TfgR7a2Fk5cGji2TGsc+fCxqaCZJ4Q=;
 b=nk48If9273e3brwLwWDKDPTNroYTscPyYeeKn6oUkfk7zCf/Vc9oDN5CRPW98MSSpRm83ipqYIRCLXDlIY9Bokh6OBgitVqhEJ4jRdxeZ6gFW+0mFngOIqCMfq/I8OxEvyecL/FlZbCXD2ppkb7gwHCb/LbBDbvn7YFfoeb1TQI5zfFpAuWuHups3X3Od/wplWhTxpx//48xeTbhwJQPTxq0hP0PwDt8IZdlerxjaImpDZleoeTCPBWHryxbvs6vTHgbj7743HaGwl/bD+3UjJEGHm+s6Gpq9USxNKSgUZzjetlPj2dJhHu+XhXQgzp+K3HSXGTVEuZ8VTlCUVolEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FJTyOwjd9hE2TfgR7a2Fk5cGji2TGsc+fCxqaCZJ4Q=;
 b=XKlvryg6LSth4xlEoY+40KrkS+HuqPrr+qx4ZbndmbNcg+RgtDXqWnQxGy8tjDBV3ttpmkdvlGLQOBaYrm9t40i4Rf4u+Wz18n6qPigo97DBtxXTC33UDON8eKWm1EN6Hwo6Yln4XX6GGedds+GoXpJG04gacvj36Mj7so9FcAE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4674.eurprd04.prod.outlook.com (52.135.149.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.13; Mon, 16 Sep 2019 09:44:41 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 09:44:41 +0000
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
Subject: [PATCH V6 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Topic: [PATCH V6 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Index: AQHVbHNdulW1qSzh8kulKbzCOfhGfw==
Date:   Mon, 16 Sep 2019 09:44:41 +0000
Message-ID: <1568626884-5189-3-git-send-email-peng.fan@nxp.com>
References: <1568626884-5189-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1568626884-5189-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6808022f-1368-447c-2c37-08d73a8a7f6e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB4674;
x-ms-traffictypediagnostic: AM0PR04MB4674:|AM0PR04MB4674:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4674A1B1A9374F3552D6CDC9888C0@AM0PR04MB4674.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(189003)(199004)(50226002)(81156014)(44832011)(8676002)(8936002)(81166006)(66946007)(14454004)(52116002)(99286004)(15650500001)(6436002)(316002)(2616005)(53936002)(486006)(305945005)(7736002)(86362001)(476003)(76176011)(66066001)(36756003)(2201001)(54906003)(6486002)(446003)(11346002)(2906002)(66556008)(5660300002)(6512007)(110136005)(386003)(6506007)(4326008)(71200400001)(26005)(71190400001)(102836004)(966005)(6116002)(66476007)(3846002)(186003)(64756008)(256004)(66446008)(6306002)(2501003)(478600001)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4674;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jMkY6u3N+UlUN4IafInkDz0ka+LVmlMaV5uFqntfo+ZEO/bQ9SB3d1vt3mL0epia2/87XEyPI6QQLmLZwpL91YFY1tkuaguP/ArB1FilfAVmlZzgBkDtTusFBWf8utME6+HZfjN1uU7waP1uYq0CPtJLm5ZUlbEYBMWCJfF2Lxr6Zwlk+Mo0BKDHvDCO0Ed98l21/dhpPheAQv5xVMkXDUgmIW2tmlXurUEyvB9AQfmRwWflUqn+wUzar4bfOJ+pOTfs8SGNA/WQ6CVT/EF5Z+45Jc4JwAt0FxOwAkIl7Fye5z6LCc1o+PSljKvNX0IsrYGBNWHNpe+oZmyZ+LFe+K/NfQ6RUdv4wwICDCAIkQrfqctCea8JzCgzHLMP9/cOTdWDs0wskvG2+xcj7jVp8fZ3fQgzttiqVcctjwhl0RU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6808022f-1368-447c-2c37-08d73a8a7f6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 09:44:41.6247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BnqeDvxBx+XmDtDSAwPTnfT0JV44MgCYLrr/aaAAAh8S6SDh4iVlQp3mw/ENFwssB9x6gXYuOfegzMLbMue9vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4674
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
 drivers/mailbox/arm-smc-mailbox.c | 167 ++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 176 insertions(+)
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
index 000000000000..c84aef39c8d9
--- /dev/null
+++ b/drivers/mailbox/arm-smc-mailbox.c
@@ -0,0 +1,167 @@
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
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+struct arm_smc_chan_data {
+	unsigned int function_id;
+};
+
+struct arm_smccc_mbox_cmd {
+	unsigned int function_id;
+	union {
+		unsigned int args_smccc32[6];
+		unsigned long args_smccc64[6];
+	};
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
+	if (function_id & BIT(30)) {
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

