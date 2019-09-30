Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5FAC388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 06:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5305621925
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 06:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LGTx8bTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfI3GUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 02:20:22 -0400
Received: from mail-eopbgr40056.outbound.protection.outlook.com ([40.107.4.56]:10790
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbfI3GUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 02:20:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4yThVsC4vc7MLxRQbRgwBksGbQy+yqEBtIxWCgj//VztCTORYED5ctddrUcpRLWX2QW7GaOkkO++U9qC3xgZiozHbpc+AVRboXIRnKCn0cbv2KNZWasGPaarIbecFk4Zwvb7RYKmhXwH9163BPGvbLRESuFWjHbZHmkBhY3vrXwyW1eR8gOXDUvwdMWuhkcKpZ9CoIHk6S4BzhP7c+iMzqmrI7HyoJhT8De1uXcOf8wby58TSMaq+EGbOLtocLvcQCvrcm/NA3Mgcxbn4DGnhoXbyr7/I+x4TUoOrrSc9SXpbzHHlbjkiXUp9TrjGcrc4nVzJtqxXtYhFzro9dzjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59jwsxccYOw9PNoxm/2gsbnDkCrez8hdXM9qvQXDtXw=;
 b=LSoOm3DodtJ8941dW9rLYD0/RPd/3R5FZ/YcWWw13FzTHuZUUT9tNSR7DH9FjbIThwDHr8LTsPHj6G/7dgSUs9x4DJqpWykPKcCf02ES4Q5URiGsl1v5Y/3vHN14SYV/quh0LxXGhu/rYdkqb1mvKYbgPCZolBX/8x44jfuY1CYul4XArffjirCoVsWGl0VzHmWYb/C/O3+coSRs7zSasmHZGIng2nBlNCKbkjSdaEjKoJMoUrDBLb/n7u5eWJjwdBGPo9unkcLHlnlKelONoO1f6zVtz0pfy0wf6bOvXl6REYOZoGSUlIyDlGX7oUNjmGvjuGWK6976KOxrIKVxmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59jwsxccYOw9PNoxm/2gsbnDkCrez8hdXM9qvQXDtXw=;
 b=LGTx8bTnT8bZgvQC05AUmnYog3uQrpN/Fhv8/Qd3f3ENIUc8L/9q568zKpeB1FWGw/0Ym3JVCWoLwLUkyd7O4I2JZ0DWkNAC6dUeN4GKITz7n+tK5JUISW9MXL7yz1xaFJvgC+o5Fbes5G4PngTnlI5SgAk7+cn5/EXf4sOFbb0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5348.eurprd04.prod.outlook.com (20.178.113.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 06:20:14 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 06:20:14 +0000
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
Subject: [PATCH V10 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Topic: [PATCH V10 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Index: AQHVd1cfT8QFyxAbm0eWywLWz3Kfzw==
Date:   Mon, 30 Sep 2019 06:20:14 +0000
Message-ID: <1569824287-4263-3-git-send-email-peng.fan@nxp.com>
References: <1569824287-4263-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1569824287-4263-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0034.apcprd03.prod.outlook.com
 (2603:1096:203:2f::22) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f356f2e-cee7-4009-01a2-08d7456e416b
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR04MB5348:|AM0PR04MB5348:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5348416558B888BBE660317188820@AM0PR04MB5348.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(189003)(199004)(54906003)(64756008)(4326008)(66446008)(186003)(110136005)(5660300002)(71190400001)(2201001)(71200400001)(8936002)(26005)(478600001)(316002)(8676002)(386003)(6506007)(36756003)(81166006)(81156014)(52116002)(102836004)(66946007)(66476007)(66556008)(2906002)(305945005)(7736002)(76176011)(14454004)(66066001)(15650500001)(25786009)(2501003)(50226002)(6116002)(966005)(476003)(11346002)(6436002)(256004)(2616005)(99286004)(3846002)(6512007)(6306002)(86362001)(486006)(44832011)(6486002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5348;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EW9HsL4i/drX6m8oLbJpMbEm+PbgK+bvY1J+rBAH9FPVhfdzHOc6KWyVfWFnbYmlFwBJcZUp34LAUZKu6kxDblB/1aVl98tD55kzREIbCA2W+qPr5ZBC0xj3H4JQj9ezbCczBBLDigM9kWy5rIXzIjz10vRF0w9Y9N6xcpMs62Td9XpBNz7la+fZa0Yz9MaIkyx1jJxldKttt2tM4g8vo5ybdQLr1UiIJ6PQnmsKII/caInCIGRuF3BT45jtSFPmW5aJ09N3caIzj8pBdC2GCPmGO44sGlBmAC4gFEwhyfiqJINsvctOkcsezXqudTQHOXgndue4cz2wLlsPpC0XXB8zzgFdahiCGNYPvRI6Y7kTYQ4Bn9+NJbFPOyHX42v63xVjALxLm0ZMnobH5iFo/OGntXZERW5HdO3u2tq8sG9+C3EDECtDn3RZQBRxIh0HgfYWDMuKUtAldsyQ3HUowQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f356f2e-cee7-4009-01a2-08d7456e416b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 06:20:14.5403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HD9DdvImHBV+PqA0E7FKhn1q9sS7aee7GtF+1y4/lEIMYi+JXgcoc6SYlLbPlzvdpoYYgrtumAWN8Vkmaa3ecQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5348
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

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/Kconfig                |   7 ++
 drivers/mailbox/Makefile               |   2 +
 drivers/mailbox/arm-smc-mailbox.c      | 166 +++++++++++++++++++++++++++++=
++++
 include/linux/mailbox/arm-smccc-mbox.h |  20 ++++
 4 files changed, 195 insertions(+)
 create mode 100644 drivers/mailbox/arm-smc-mailbox.c
 create mode 100644 include/linux/mailbox/arm-smccc-mbox.h

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
index 000000000000..a6ec56f41f7f
--- /dev/null
+++ b/drivers/mailbox/arm-smc-mailbox.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016,2017 ARM Ltd.
+ * Copyright 2019 NXP
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox/arm-smccc-mbox.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+typedef unsigned long (smc_mbox_fn)(unsigned int, unsigned long,
+				    unsigned long, unsigned long,
+				    unsigned long, unsigned long,
+				    unsigned long);
+
+struct arm_smc_chan_data {
+	unsigned int function_id;
+	smc_mbox_fn *invoke_smc_mbox_fn;
+};
+
+static int arm_smc_send_data(struct mbox_chan *link, void *data)
+{
+	struct arm_smc_chan_data *chan_data =3D link->con_priv;
+	struct arm_smccc_mbox_cmd *cmd =3D data;
+	unsigned long ret;
+
+	if (ARM_SMCCC_IS_64(chan_data->function_id)) {
+		ret =3D chan_data->invoke_smc_mbox_fn(chan_data->function_id,
+						    cmd->args_smccc64[0],
+						    cmd->args_smccc64[1],
+						    cmd->args_smccc64[2],
+						    cmd->args_smccc64[3],
+						    cmd->args_smccc64[4],
+						    cmd->args_smccc64[5]);
+	} else {
+		ret =3D chan_data->invoke_smc_mbox_fn(chan_data->function_id,
+						    cmd->args_smccc32[0],
+						    cmd->args_smccc32[1],
+						    cmd->args_smccc32[2],
+						    cmd->args_smccc32[3],
+						    cmd->args_smccc32[4],
+						    cmd->args_smccc32[5]);
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
+	ret =3D of_property_read_u32(dev->of_node, "arm,func-id",
+				   &chan_data->function_id);
+	if (ret)
+		return ret;
+
+	if (of_device_is_compatible(dev->of_node, "arm,smc-mbox"))
+		chan_data->invoke_smc_mbox_fn =3D __invoke_fn_smc;
+	else
+		chan_data->invoke_smc_mbox_fn =3D __invoke_fn_hvc;
+
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
diff --git a/include/linux/mailbox/arm-smccc-mbox.h b/include/linux/mailbox=
/arm-smccc-mbox.h
new file mode 100644
index 000000000000..d35fb89a77f5
--- /dev/null
+++ b/include/linux/mailbox/arm-smccc-mbox.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_ARM_SMCCC_MBOX_H_
+#define _LINUX_ARM_SMCCC_MBOX_H_
+
+#include <linux/types.h>
+
+/**
+ * struct arm_smccc_mbox_cmd - ARM SMCCC message structure
+ * @args_smccc32/64:	actual usage of registers is up to the protocol
+ *			(within the SMCCC limits)
+ */
+struct arm_smccc_mbox_cmd {
+	union {
+		u32 args_smccc32[6];
+		u64 args_smccc64[6];
+	};
+};
+
+#endif /* _LINUX_ARM_SMCCC_MBOX_H_ */
--=20
2.16.4

