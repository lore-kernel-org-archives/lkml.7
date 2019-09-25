Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDABC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 02:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A41421783
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 02:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GkJCwQl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633803AbfIYCJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 22:09:16 -0400
Received: from mail-eopbgr140044.outbound.protection.outlook.com ([40.107.14.44]:9125
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2633788AbfIYCJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 22:09:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgPFqyUJlgdwoqv9rLPvHPlil/ZKH9Hkr+xGRnwBJ86/UImRnl2O/uCmIYIla17XYBeRRZUbVbHlv3Yfndriv9VC+18oLmq1UmsPvqL5IlcE5TCda/V+QRwsq4+0sm2cpZug07O9nAww/rzefT5Rybzc1+RmOr/fmkH2BDRG1Fb3UsRKtPSS0tBRYOvbEyJkwbjaZGFJaSLcqlr1Vi0RFDK/2zNCgXS+5aww7euh+cOFIWN52Jqx43RyOXQhN2hDTh0jTMUwsRvw2DzzMKPheqGGo6WipwS1AKjDJrdPxL2qKLaAd5/jmbHun0WgpckZajVkCF0+0GaSV90kgId9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRZDNMKXjQ0UPKE7WIBqw9OLRKXAwRYqivA6GpCvmLc=;
 b=ge8Z6RQDMf1G/fpcQQCrl7h1MKLUZPAujqdG05Sbb1nZlpWkYkhGnCj6wCt7cFbhJe7R2bn4Nac5Rz6rP/Or+Dc3l2ivDg0VpMak3c9dj7m0lcvT/3Nm3pbQWf73xP1AyS0QH9hgBkijmidZcTW9dHAKhSY0J/HLroFCxKZXheF0JsCZX5RArBkXwDs4+3rWQGERcefAomFURBcroCd9b/ISfBwJWQmiwN4cRKgWl6qKF78s5vFjhg7ebKFfeyrLR1HZT6zOkSV46FcUTf6BqULdIJMp63W/G76CF8IWAJ81IeUHQODcZLOAOuCzSWqBaugMPRopBC5gEICF8WKCIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRZDNMKXjQ0UPKE7WIBqw9OLRKXAwRYqivA6GpCvmLc=;
 b=GkJCwQl6G1Jb6YJa/oRSNWWv80Yvy8lJXnadh9S12PaiHbhFyt0vlOBUzXyQtbTfB3SF5nqkZGo8VxMkPgZ7yOZYxBZhScyQ4wfpWUObbhTX/OrTkuc0Pt9c+I6LAUehpxFka+U13X2ceI4yHw1zfPbYtTAQwI8nRFZqLAUUnVQ=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4451.eurprd04.prod.outlook.com (52.135.149.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Wed, 25 Sep 2019 02:09:11 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 02:09:11 +0000
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
Subject: [PATCH V9 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Topic: [PATCH V9 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Index: AQHVc0Y4wdHLx7HssEii123ZZ3l8/w==
Date:   Wed, 25 Sep 2019 02:09:11 +0000
Message-ID: <1569377224-5755-3-git-send-email-peng.fan@nxp.com>
References: <1569377224-5755-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1569377224-5755-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0041.apcprd03.prod.outlook.com
 (2603:1096:203:2f::29) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b634eece-d37c-41fe-c925-08d7415d5b38
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB4451;
x-ms-traffictypediagnostic: AM0PR04MB4451:|AM0PR04MB4451:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB44517C02C8A9052DD485ECBF88870@AM0PR04MB4451.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(189003)(199004)(8676002)(2501003)(66446008)(6116002)(66946007)(6512007)(6306002)(102836004)(6436002)(66476007)(64756008)(26005)(186003)(86362001)(44832011)(386003)(6506007)(54906003)(76176011)(66556008)(486006)(316002)(8936002)(2616005)(446003)(11346002)(476003)(25786009)(7736002)(256004)(15650500001)(305945005)(99286004)(66066001)(14454004)(71200400001)(50226002)(81166006)(81156014)(110136005)(3846002)(478600001)(2906002)(52116002)(966005)(2201001)(36756003)(5660300002)(71190400001)(4326008)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4451;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z5YTnrCM8zPtFmEcDdY0/bQitb3gDp+2IvqM6GLRdopREITQnIR8BxcEPvRLgp8VgVQkf6ytg5/H83ofYgE2rwS5flaNznL38jN3pnW1u5Nj3CtcAMqjTxE8Va+STQDJR705BE3UMOafcIAe9UbPvHyNqNvCigXEpxKmx5oki7aBglk+Rbc79Vyk4Ga/z62mSIv8Uggp9AmCIr9GCDUhYfbhHEcNJ/SfPwyyfYum+J/TWiIsFxOUzMQJ5VzL7ewITvqJmIAvaDKmhzboXno+pThDHkFbxBPiqDuNX18cOZb31+U2lbKuEh59ykK2/RT61vGJoiC4Zn4/PsSl1WCHQA3b5vR0PkfY2R5WvVZ56C3JRFjstvw1vbHxg6FzDm1yCnS0o9m5w3/ybcWMesNljsVsO8+GvlDOJjnt8RR/Y+Qfab5ObjJ5m0WKgyIZiXlPeQqAzyO7xFocAxlGFktiVA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b634eece-d37c-41fe-c925-08d7415d5b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 02:09:11.6275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/3nVOZbafyhB8RP7BvH8SQOk9+Cu4UvTnkDBXl4y9k4KYsRGAHHnBX8qrU4jl/Whqge88q5iyWZCfpjO85f6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4451
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
 drivers/mailbox/Kconfig                |   7 ++
 drivers/mailbox/Makefile               |   2 +
 drivers/mailbox/arm-smc-mailbox.c      | 167 +++++++++++++++++++++++++++++=
++++
 include/linux/mailbox/arm-smccc-mbox.h |  20 ++++
 4 files changed, 196 insertions(+)
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
index 000000000000..6f0b5fd6ad1b
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

