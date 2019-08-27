Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F53C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D762186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m+VCO8fh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbfH0JwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:52:05 -0400
Received: from mail-eopbgr00082.outbound.protection.outlook.com ([40.107.0.82]:14222
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729024AbfH0JwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:52:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9lhDbXDjSeWHnUdw4zV7yIaXd6gthpafrq3jJqeeetEs9w3vbeuvUYp7uWblA7aoml9jR9PtfCKmJSiHsqw5igzP+RfTij8r6deTIwhrIxOfCCNCSn7JJGMuHzmZOf/RlkqtT8JQhucRj6zpixLSGvpG7RR82RIbQCIJMaW70rBJgkgPvyO91ClvRuL5Z+12kJ8DxIEPh73dnnYUFUpgI2fTSPhMyf/X6C6F6o08+sijwY3kVC5Ml2yQrlfOegdkJCXqdgJYJkAAsOpdHPLJJ5D7clryw2NPrwt1usHiK17/0CBg6CLQfMe4p30z9xvRC4Y0uCdi/ekJJw4g7GB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQLiX/5q6Ozn7jRCB+ApopDSM5CpvY/9PJqQMc2HFhg=;
 b=ag68nYaixO7UuudKXrNCZvZpzOl9gCyR1/KMf2EYfaD+Qii/fDSI3naVpfutO4GfCp+0MmNwVmaLMqHZHNhX12Muuin/tOF/SNNbCTPxVi2xj5S+0O0JHRCGZZUebSg/3lOyfqyIx2W+X2bogJMC7SRoKDfdTxmxhZknXpaSn0I26Mk0RTSE6IjOyIsmJb78I7xej3VY4YLhCF8zINQCaPYg2lIIqQbkQP4ldky1Oi+MBeGuOMbu8MjpTXphQNrHMjYb/6ox0Z7cYYyiePNEkwlmk8QLe9nGFny6E6rTDpl6c6TyHbzeTv/DU/hPmnuWyUXIfVuJMvcKT2AbN23CFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQLiX/5q6Ozn7jRCB+ApopDSM5CpvY/9PJqQMc2HFhg=;
 b=m+VCO8fhZJUCuReIb1Z/rHefWAeauswP00rZZN/x95j+VzpiLUY/cZ3qo8sTNV1RcIVMXWTgw3/hWlS8hoga8redOm+Irnn4NGWexrRNVQUcG7wWjNfCrQxIRoRlJSVwCS7NJ9mX8v6RWCtikQ6MjdOopOiO9j0hvDJH6lJtk/U=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4228.eurprd04.prod.outlook.com (52.134.126.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 09:51:59 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.022; Tue, 27 Aug 2019
 09:51:59 +0000
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
Subject: [PATCH v4 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Topic: [PATCH v4 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Index: AQHVXL0Rqmox0xa5yEKBC6oocJzJMg==
Date:   Tue, 27 Aug 2019 09:51:59 +0000
Message-ID: <1566942646-18015-3-git-send-email-peng.fan@nxp.com>
References: <1566942646-18015-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1566942646-18015-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:202:16::14) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbd1d436-689e-4627-01c9-08d72ad43420
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4228;
x-ms-traffictypediagnostic: AM0PR04MB4228:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4228B7A4D1D5C2873BF6350288A00@AM0PR04MB4228.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:425;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(189003)(199004)(110136005)(54906003)(36756003)(2616005)(305945005)(476003)(2501003)(15650500001)(486006)(6436002)(316002)(3846002)(26005)(7736002)(386003)(14454004)(66066001)(5660300002)(53936002)(50226002)(6486002)(446003)(186003)(52116002)(76176011)(11346002)(102836004)(6116002)(6306002)(86362001)(25786009)(2201001)(6512007)(478600001)(8936002)(256004)(71200400001)(8676002)(64756008)(66446008)(81156014)(66946007)(66476007)(71190400001)(81166006)(2906002)(66556008)(6506007)(4326008)(966005)(99286004)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4228;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u6Yh6yG0CYrbqYpMNVvLWSni+3I7iJB/9fvECgETEfK89Ivh+wDeKXIUnzwPVRJNdG4L5GJ6oNDfMS2+riM864AWrq0ynN/7eD0DHFQvW9EHXMd6JQkj01NTtShaxZyCxaqXVqFu5mXL0kqWeDLYj2mjD9ciKgQ51/AaN+xPYasUU+tfOqxPRjOvPac7Wq/YMSYQdnnFhuYn+ZUIxAkBIUN6PDFV/u+Jlbr3xDZ5OjM5Yb/izsQ+Qy/YMQc9UlR4n5Obw8iZbvo88ABVrk/2A22EQ0L00Vapw1C9ry58JPS81kTMcjA3rtYGASo08twpH1ei0q6g/t0CXPZ1fy7NecaSj+hY4rxa3RFaYZ9CQHmEjD+LRyjWbIMdmzo+/kndKfS4CohpxjxWqSdpiIWnG6Mzk7ObwyZg7zEluT3NhD0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd1d436-689e-4627-01c9-08d72ad43420
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 09:51:59.4029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: niLGNQUQj1wvFk9Q0/pAiK1wvj31Ks07tpBuwN+l4lIK7ufzqNkjCdG78I/B59+I3hfbukgHwCLDTmKWWtJkMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4228
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
 drivers/mailbox/arm-smc-mailbox.c | 215 ++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 224 insertions(+)
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
index 000000000000..76a2ae11ee4d
--- /dev/null
+++ b/drivers/mailbox/arm-smc-mailbox.c
@@ -0,0 +1,215 @@
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
+#define ARM_SMC_MBOX_MEM_TRANS	BIT(0)
+
+struct arm_smc_chan_data {
+	u32 function_id;
+	u32 chan_id;
+	u32 flags;
+};
+
+struct arm_smccc_mbox_cmd {
+	unsigned long a0, a1, a2, a3, a4, a5, a6, a7;
+};
+
+typedef unsigned long (smc_mbox_fn)(unsigned long, unsigned long,
+				    unsigned long, unsigned long,
+				    unsigned long, unsigned long,
+				    unsigned long, unsigned long);
+static smc_mbox_fn *invoke_smc_mbox_fn;
+
+static int arm_smc_send_data(struct mbox_chan *link, void *data)
+{
+	struct arm_smc_chan_data *chan_data =3D link->con_priv;
+	struct arm_smccc_mbox_cmd *cmd =3D data;
+	unsigned long ret;
+	u32 function_id;
+	u32 chan_id;
+
+	if (chan_data->flags & ARM_SMC_MBOX_MEM_TRANS) {
+		if (chan_data->function_id !=3D UINT_MAX)
+			function_id =3D chan_data->function_id;
+		else
+			function_id =3D cmd->a0;
+		chan_id =3D chan_data->chan_id;
+		ret =3D invoke_smc_mbox_fn(function_id, chan_id, 0, 0, 0, 0,
+					 0, 0);
+	} else {
+		ret =3D invoke_smc_mbox_fn(cmd->a0, cmd->a1, cmd->a2, cmd->a3,
+					 cmd->a4, cmd->a5, cmd->a6, cmd->a7);
+	}
+
+	mbox_chan_received_data(link, (void *)ret);
+
+	return 0;
+}
+
+static unsigned long __invoke_fn_hvc(unsigned long function_id,
+				     unsigned long arg0, unsigned long arg1,
+				     unsigned long arg2, unsigned long arg3,
+				     unsigned long arg4, unsigned long arg5,
+				     unsigned long arg6)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_hvc(function_id, arg0, arg1, arg2, arg3, arg4,
+		      arg5, arg6, &res);
+	return res.a0;
+}
+
+static unsigned long __invoke_fn_smc(unsigned long function_id,
+				     unsigned long arg0, unsigned long arg1,
+				     unsigned long arg2, unsigned long arg3,
+				     unsigned long arg4, unsigned long arg5,
+				     unsigned long arg6)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(function_id, arg0, arg1, arg2, arg3, arg4,
+		      arg5, arg6, &res);
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
+	const char *method;
+	bool mem_trans =3D false;
+	int ret, i;
+	u32 val;
+
+	if (!of_property_read_u32(dev->of_node, "arm,num-chans", &val)) {
+		if (!val) {
+			dev_err(dev, "invalid arm,num-chans value %u\n", val);
+			return -EINVAL;
+		}
+	} else {
+		return -EINVAL;
+	}
+
+	if (!of_property_read_string(dev->of_node, "transports", &method)) {
+		if (!strcmp("mem", method)) {
+			mem_trans =3D true;
+		} else if (!strcmp("reg", method)) {
+			mem_trans =3D false;
+		} else {
+			dev_warn(dev, "invalid \"transports\" property: %s\n",
+				 method);
+
+			return -EINVAL;
+		}
+	} else {
+		return -EINVAL;
+	}
+
+	if (!of_property_read_string(dev->of_node, "method", &method)) {
+		if (!strcmp("hvc", method)) {
+			invoke_smc_mbox_fn =3D __invoke_fn_hvc;
+		} else if (!strcmp("smc", method)) {
+			invoke_smc_mbox_fn =3D __invoke_fn_smc;
+		} else {
+			dev_warn(dev, "invalid \"method\" property: %s\n",
+				 method);
+
+			return -EINVAL;
+		}
+	} else {
+		return -EINVAL;
+	}
+
+	mbox =3D devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
+	if (!mbox)
+		return -ENOMEM;
+
+	mbox->num_chans =3D val;
+	mbox->chans =3D devm_kcalloc(dev, mbox->num_chans, sizeof(*mbox->chans),
+				   GFP_KERNEL);
+	if (!mbox->chans)
+		return -ENOMEM;
+
+	chan_data =3D devm_kcalloc(dev, mbox->num_chans, sizeof(*chan_data),
+				 GFP_KERNEL);
+	if (!chan_data)
+		return -ENOMEM;
+
+	for (i =3D 0; i < mbox->num_chans; i++) {
+		u32 function_id;
+
+		ret =3D of_property_read_u32_index(dev->of_node,
+						 "arm,func-ids", i,
+						 &function_id);
+		if (ret)
+			chan_data[i].function_id =3D UINT_MAX;
+
+		else
+			chan_data[i].function_id =3D function_id;
+
+		chan_data[i].chan_id =3D i;
+
+		if (mem_trans)
+			chan_data[i].flags |=3D ARM_SMC_MBOX_MEM_TRANS;
+		mbox->chans[i].con_priv =3D &chan_data[i];
+	}
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
+	dev_info(dev, "ARM SMC mailbox enabled with %d chan%s.\n",
+		 mbox->num_chans, mbox->num_chans =3D=3D 1 ? "" : "s");
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
+MODULE_AUTHOR("Andre Przywara <andre.przywara@arm.com>");
+MODULE_DESCRIPTION("Generic ARM smc mailbox driver");
+MODULE_LICENSE("GPL v2");
--=20
2.16.4

