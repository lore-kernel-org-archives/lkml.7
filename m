Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37A0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC252086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RkWvcl/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfDAF2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 01:28:18 -0400
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:42519
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725771AbfDAF2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 01:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prxdrieTjztn3fVK8eoXmD3VqIKmnlN/sx+DVExpxE8=;
 b=RkWvcl/RpdLYOMAbqNdiik54xAGfUO3u5rX6voa1vCAyvOlR/G13DIqG5OyHI4aHQ9L53jxxdrvocS9x119Egqs0vYw/3hADPRoz5etA+rvMFtP6sENVKp0F99z1ChQqUJUqvDlHv+Thn87WidPz9b1ZxggVe4i/kK1EnCrir94=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3867.eurprd04.prod.outlook.com (52.134.65.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.19; Mon, 1 Apr 2019 05:28:12 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 05:28:12 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] input: keyboard: imx: use devm_platform_ioremap_resource() to
 simplify code
Thread-Topic: [PATCH] input: keyboard: imx: use
 devm_platform_ioremap_resource() to simplify code
Thread-Index: AQHU6EuzUpMy3ucHfEurgMtAlpFGjg==
Date:   Mon, 1 Apr 2019 05:28:12 +0000
Message-ID: <1554096209-17870-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0142.apcprd02.prod.outlook.com
 (2603:1096:202:16::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a868263-07a4-40d2-c902-08d6b662d571
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3867;
x-ms-traffictypediagnostic: DB3PR0402MB3867:
x-microsoft-antispam-prvs: <DB3PR0402MB3867A3399CB1D36817278019F5550@DB3PR0402MB3867.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(366004)(199004)(189003)(81156014)(8936002)(6116002)(7736002)(6506007)(386003)(25786009)(102836004)(316002)(3846002)(52116002)(5660300002)(81166006)(26005)(186003)(68736007)(110136005)(97736004)(2906002)(486006)(53936002)(106356001)(105586002)(8676002)(86362001)(2616005)(476003)(4326008)(50226002)(6436002)(305945005)(256004)(14454004)(99286004)(2501003)(71190400001)(71200400001)(6512007)(2201001)(66066001)(6486002)(36756003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3867;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OSwRe4e+krqcXS7S8xgFZG7L0gewHkJEHnFclR/bsPaVw+VoX9+TpEnkc4C/gEnwnxjPNp/W4DC1MD7rlC3JWyChPwE8uzUfhGh8DgLr5jAHtJ5s4gm875Mqaq1LzJLw68qT/42CzShWHzRJLemr9zAoQIRV+vxsNpvQRFwa0hYPGZ5yOZ0VMNOKcyEB6e0eH8dsMrPXiQrSK9C0U94n0X9C3ZX8AU8yGTf9wl9RNCvToAVxBVJ+nefvDByii93tOQbT+uB/jW/mS2Pq0pHXpKCXEolW7frxgMBmHFM8L2LBwUbb1jvqRk1oPjjeOu6R05aj8mq6J9xlu5QcH/jdKbyjU4s6BTNszQtqXsQ7FzkBA86J9mTewGUF7W3YBlxY49e4LE/Us5FQ1tS/GR0suBmCHHl/vFwdDrkBk0cUc30=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a868263-07a4-40d2-c902-08d6b662d571
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 05:28:12.8271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3867
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together, to
simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/input/keyboard/imx_keypad.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/i=
mx_keypad.c
index 539cb67..cf08f4a 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -422,7 +422,6 @@ static int imx_keypad_probe(struct platform_device *pde=
v)
 			dev_get_platdata(&pdev->dev);
 	struct imx_keypad *keypad;
 	struct input_dev *input_dev;
-	struct resource *res;
 	int irq, error, i, row, col;
=20
 	if (!keymap_data && !pdev->dev.of_node) {
@@ -455,8 +454,7 @@ static int imx_keypad_probe(struct platform_device *pde=
v)
 	timer_setup(&keypad->check_matrix_timer,
 		    imx_keypad_check_for_events, 0);
=20
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	keypad->mmio_base =3D devm_ioremap_resource(&pdev->dev, res);
+	keypad->mmio_base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(keypad->mmio_base))
 		return PTR_ERR(keypad->mmio_base);
=20
--=20
2.7.4

