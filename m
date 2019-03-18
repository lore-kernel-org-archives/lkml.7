Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E77C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2DC2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mzaLaNLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfCRDKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 23:10:01 -0400
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:12289
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727159AbfCRDKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 23:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3bMcDjMplin1nFB8z1inS7ernOo99d8UeTgiETFOUI=;
 b=mzaLaNLHaueMb3PsFb8d3tkcJmF6uQ+diUR7KpB21sco6YQF2+Za7DyxsdeS4jcsLAo5q9ixznjYrKhmxO1QSpPnyEvpx/TpCBuKkAwlxC403OHVViAyAEyepjyTVXwdOhVQGL2Q0Uxnb7OtYD9JIu6/LKdoDrjDN50Q/B/WCkY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3883.eurprd04.prod.outlook.com (52.134.71.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Mon, 18 Mar 2019 03:09:55 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 03:09:55 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 2/4] firmware: imx: enable imx scu general irq function
Thread-Topic: [PATCH V5 2/4] firmware: imx: enable imx scu general irq
 function
Thread-Index: AQHU3TgP/onlTWH0OEWf1xUmhiNMMw==
Date:   Mon, 18 Mar 2019 03:09:55 +0000
Message-ID: <1552878291-22866-2-git-send-email-Anson.Huang@nxp.com>
References: <1552878291-22866-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552878291-22866-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::35) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19521733-101a-408b-2de2-08d6ab4f3227
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3883;
x-ms-traffictypediagnostic: DB3PR0402MB3883:
x-microsoft-antispam-prvs: <DB3PR0402MB3883D6B9D8DAB1F699E9DA60F5470@DB3PR0402MB3883.eurprd04.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(366004)(346002)(199004)(189003)(6512007)(256004)(386003)(6486002)(6436002)(97736004)(106356001)(6116002)(3846002)(14444005)(52116002)(446003)(486006)(6506007)(186003)(26005)(53936002)(4326008)(476003)(316002)(11346002)(76176011)(2616005)(2501003)(2201001)(86362001)(25786009)(7416002)(305945005)(478600001)(110136005)(99286004)(7736002)(5660300002)(36756003)(50226002)(68736007)(66066001)(2906002)(105586002)(14454004)(81166006)(8676002)(81156014)(71200400001)(102836004)(71190400001)(8936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3883;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NLjCN8cMB1A/qXbBz7pY2b4KU7EYd1N39J0x6RlHRQ4+7Bdu5bNMCXL30BeXvG4MrRvNlRj/mdHNzVhKywpS+B+iTK9nU7hF7BiwuctO3pGGhGo1aYwoMAXk1ym8WAsSsPvo+Qu1PfXG37UJ47lIkfWHvybcOsaA/LPGewLvqWAoojSaOMdVB7d/y1eULlzC3yrhmNwNwSyGUMkiYCimM3zl9oK0Pa429QmKZUqmpK+p3XeEL/m20OY2TXZykjwyI/j1OgJrDpbQRUVI04oYm0ALww6lzE7vxkM0e7IwzdWSRpqCYyYqvY5uyuaBBOQvy7pxhlwgpWbQQQTwz39bNnKXVwSDiPM8fEqZfIYQJWxuctowQSyoR2fkxCqaAg57ZDTXsvTye3QqDTKmuL9z/k9t8oCXIDJqtNvE61VU368=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19521733-101a-408b-2de2-08d6ab4f3227
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 03:09:55.6812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3883
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The System Controller Firmware (SCFW) controls RTC, thermal
and WDOG etc., these resources' interrupt function are managed
by SCU. When any IRQ pending, SCU will notify Linux via MU general
interrupt channel #3, and Linux kernel needs to call SCU APIs
to get IRQ status and notify each module to handle the interrupt.

Since there is no data transmission for SCU IRQ notification, so
doorbell mode is used for this MU channel, and SCU driver will
use notifier mechanism to broadcast to every module which registers
the SCU block notifier.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V4:
	- move scu irq support to a new file imx-scu-irq.c;
	- improve the function name with "imx_scu_irq_" as prefix for irq related =
functions;
	- move MU IRQ sources id out of sc ipc struct;
	- add IRQ group info message print when get irq status fail;
	- move MU ID parse into imx_scu_enable_general_irq_channel() function and =
ONLY do it
	  when irq channel enable successfully.
	- change max IRQ group supported to 4, ONLY support for those kernel featu=
res.
---
 drivers/firmware/imx/Makefile      |   2 +-
 drivers/firmware/imx/imx-scu-irq.c | 133 +++++++++++++++++++++++++++++++++=
++++
 drivers/firmware/imx/imx-scu.c     |   6 ++
 include/linux/firmware/imx/sci.h   |   4 ++
 4 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/imx/imx-scu-irq.c

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 1b2e15b..802c4ad 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_IMX_SCU)		+=3D imx-scu.o misc.o
+obj-$(CONFIG_IMX_SCU)		+=3D imx-scu.o misc.o imx-scu-irq.o
 obj-$(CONFIG_IMX_SCU_PD)	+=3D scu-pd.o
diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-=
scu-irq.c
new file mode 100644
index 0000000..0e20aa7
--- /dev/null
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019 NXP
+ *
+ * Implementation of the SCU IRQ functions using MU.
+ *
+ */
+
+#include <dt-bindings/firmware/imx/rsrc.h>
+#include <linux/firmware/imx/ipc.h>
+#include <linux/mailbox_client.h>
+
+#define IMX_SC_IRQ_FUNC_STATUS	2
+#define IMX_SC_IRQ_NUM_GROUP	4
+
+static u32 mu_resource_id;
+
+struct imx_sc_msg_irq_get_status {
+	struct imx_sc_rpc_msg hdr;
+	union {
+		struct {
+			u16 resource;
+			u8 group;
+			u8 reserved;
+		} __packed req;
+		struct {
+			u32 status;
+		} resp;
+	} data;
+};
+
+static struct imx_sc_ipc *imx_sc_irq_ipc_handle;
+static struct work_struct imx_sc_irq_work;
+static BLOCKING_NOTIFIER_HEAD(imx_scu_irq_notifier_chain);
+
+int imx_scu_irq_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(
+		&imx_scu_irq_notifier_chain, nb);
+}
+EXPORT_SYMBOL(imx_scu_irq_register_notifier);
+
+int imx_scu_irq_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(
+		&imx_scu_irq_notifier_chain, nb);
+}
+EXPORT_SYMBOL(imx_scu_irq_unregister_notifier);
+
+static int imx_scu_irq_notifier_call_chain(unsigned long status, u8 *group=
)
+{
+	return blocking_notifier_call_chain(&imx_scu_irq_notifier_chain,
+		status, (void *)group);
+}
+
+static void imx_scu_irq_work_handler(struct work_struct *work)
+{
+	struct imx_sc_msg_irq_get_status msg;
+	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
+	u32 irq_status;
+	int ret;
+	u8 i;
+
+	for (i =3D 0; i < IMX_SC_IRQ_NUM_GROUP; i++) {
+		hdr->ver =3D IMX_SC_RPC_VERSION;
+		hdr->svc =3D IMX_SC_RPC_SVC_IRQ;
+		hdr->func =3D IMX_SC_IRQ_FUNC_STATUS;
+		hdr->size =3D 2;
+
+		msg.data.req.resource =3D mu_resource_id;
+		msg.data.req.group =3D i;
+
+		ret =3D imx_scu_call_rpc(imx_sc_irq_ipc_handle, &msg, true);
+		if (ret) {
+			pr_err("get irq group %d status failed, ret %d\n",
+			       i, ret);
+			return;
+		}
+
+		irq_status =3D msg.data.resp.status;
+		if (!irq_status)
+			continue;
+
+		imx_scu_irq_notifier_call_chain(irq_status, &i);
+	}
+}
+
+static void imx_scu_irq_callback(struct mbox_client *c, void *msg)
+{
+	schedule_work(&imx_sc_irq_work);
+}
+
+int imx_scu_enable_general_irq_channel(struct device *dev)
+{
+	struct of_phandle_args spec;
+	struct mbox_client *cl;
+	struct mbox_chan *ch;
+	int ret =3D 0, i =3D 0;
+
+	cl =3D devm_kzalloc(dev, sizeof(*cl), GFP_KERNEL);
+	if (!cl)
+		return -ENOMEM;
+
+	cl->dev =3D dev;
+	cl->rx_callback =3D imx_scu_irq_callback;
+
+	/* SCU general IRQ uses general interrupt channel 3 */
+	ch =3D mbox_request_channel_byname(cl, "gip3");
+	if (IS_ERR(ch)) {
+		ret =3D PTR_ERR(ch);
+		dev_err(dev, "failed to request mbox chan gip3, ret %d\n", ret);
+		return ret;
+	}
+
+	ret =3D imx_scu_get_handle(&imx_sc_irq_ipc_handle);
+	if (ret)
+		return ret;
+
+	INIT_WORK(&imx_sc_irq_work, imx_scu_irq_work_handler);
+
+	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
+				       "#mbox-cells", 0, &spec))
+		i =3D of_alias_get_id(spec.np, "mu");
+
+	/* use mu1 as general mu irq channel if failed */
+	if (i < 0)
+		i =3D 1;
+
+	mu_resource_id =3D IMX_SC_R_MU_0A + i;
+
+	return ret;
+}
+EXPORT_SYMBOL(imx_scu_enable_general_irq_channel);
diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.=
c
index 2bb1a19..04a24a8 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -10,6 +10,7 @@
 #include <linux/err.h>
 #include <linux/firmware/imx/types.h>
 #include <linux/firmware/imx/ipc.h>
+#include <linux/firmware/imx/sci.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
@@ -246,6 +247,11 @@ static int imx_scu_probe(struct platform_device *pdev)
=20
 	imx_sc_ipc_handle =3D sc_ipc;
=20
+	ret =3D imx_scu_enable_general_irq_channel(dev);
+	if (ret)
+		dev_warn(dev,
+			"failed to enable general irq channel: %d\n", ret);
+
 	dev_info(dev, "NXP i.MX SCU Initialized\n");
=20
 	return devm_of_platform_populate(dev);
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/=
sci.h
index ebc5509..918fa16 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -15,4 +15,8 @@
=20
 #include <linux/firmware/imx/svc/misc.h>
 #include <linux/firmware/imx/svc/pm.h>
+
+int imx_scu_enable_general_irq_channel(struct device *dev);
+int imx_scu_irq_register_notifier(struct notifier_block *nb);
+int imx_scu_irq_unregister_notifier(struct notifier_block *nb);
 #endif /* _SC_SCI_H */
--=20
2.7.4

