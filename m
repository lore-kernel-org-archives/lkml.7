Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CC8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC662070B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EPnHE53n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbfDAGV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 02:21:56 -0400
Received: from mail-eopbgr140049.outbound.protection.outlook.com ([40.107.14.49]:34686
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726206AbfDAGV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 02:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vFQKPKui/Wgq+8A60WR834lJaI++dn+3eNzsrRiltM=;
 b=EPnHE53nUp/cuSspaWxhVbbenqYiT3PUNW7fisBvwhEckAHmeHKhbUdwlFpDm1Q/iTD+0flC6eS2MqJBzRz4En6KuJzs6Cfw8Dxl8DUz4Hu5+yQH7qDYjqA5n8Qv/fC/Af1/147EVIY0SJQlqpuSqAlDk0CUpyS+MXMAlCHAvlE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3786.eurprd04.prod.outlook.com (52.134.71.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Mon, 1 Apr 2019 06:21:51 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 06:21:51 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] irqchip/imx-irqsteer: use devm_platform_ioremap_resource() to
 simplify code
Thread-Topic: [PATCH] irqchip/imx-irqsteer: use
 devm_platform_ioremap_resource() to simplify code
Thread-Index: AQHU6FMxMyoSmAudakaHd9hk5kAdZg==
Date:   Mon, 1 Apr 2019 06:21:51 +0000
Message-ID: <1554099427-5240-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:203:36::21) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01a15732-7f01-4ce1-c124-08d6b66a53a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3786;
x-ms-traffictypediagnostic: DB3PR0402MB3786:
x-microsoft-antispam-prvs: <DB3PR0402MB37863B595972D1AEA952D994F5550@DB3PR0402MB3786.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(366004)(376002)(189003)(199004)(110136005)(2501003)(2201001)(86362001)(2906002)(68736007)(71190400001)(3846002)(6116002)(7736002)(14454004)(6486002)(305945005)(71200400001)(6436002)(5660300002)(66066001)(26005)(6512007)(316002)(478600001)(486006)(2616005)(105586002)(6506007)(386003)(53936002)(106356001)(102836004)(8936002)(476003)(186003)(8676002)(50226002)(256004)(97736004)(52116002)(81156014)(81166006)(4326008)(99286004)(25786009)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3786;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sipoCIOFyDUy1Udkq10vfcuvgaWJhHqF0nOT0QJlUOUDmFoLy1O+WQmAscPwBSIz568BKE/aYwFnj6XvP39akH3CMlOf4fCoF7iEWhj5/5kxyWYKKzKiRODG3gdthO4VV4KqXmu6HwyKBCX0Xx6oaW3w/4CTQVHB2f4CKbCK8fm8z0F5XqlxNO44t4gZ+DONNWI8TLxKU1rINNGTJaqLx0jNiooMjWAKirTpj9KycFVTKxRKQR2O0rbA2ZhtNLw1DnMplf7xzJIPgzCdAvsDnYgDfbgZRH6sZzeYXKZhVilqS9p0kBtaWEuJo/jWewVnXBFQlEvDiFHivxHlLZvfhTIZxPtaVsmt3RNc9LFsBEz41Wbkb8wy6DvHC0gqXUE0vsnC0TwMhbAE71r5olND5bR2SfCpu4w1VvKR946IaGg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a15732-7f01-4ce1-c124-08d6b66a53a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 06:21:51.0765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3786
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together, to
simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/irqchip/irq-imx-irqsteer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-i=
rqsteer.c
index 88df3d00..290531e 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -144,7 +144,6 @@ static int imx_irqsteer_probe(struct platform_device *p=
dev)
 {
 	struct device_node *np =3D pdev->dev.of_node;
 	struct irqsteer_data *data;
-	struct resource *res;
 	u32 irqs_num;
 	int i, ret;
=20
@@ -152,8 +151,7 @@ static int imx_irqsteer_probe(struct platform_device *p=
dev)
 	if (!data)
 		return -ENOMEM;
=20
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->regs =3D devm_ioremap_resource(&pdev->dev, res);
+	data->regs =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->regs)) {
 		dev_err(&pdev->dev, "failed to initialize reg\n");
 		return PTR_ERR(data->regs);
--=20
2.7.4

