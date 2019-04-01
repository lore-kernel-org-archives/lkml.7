Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30A7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C0A20828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KImIXjOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfDAFHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 01:07:54 -0400
Received: from mail-eopbgr130083.outbound.protection.outlook.com ([40.107.13.83]:9454
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726424AbfDAFHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 01:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcFyNDqLG3r4x4CfWKKcfyeasMKFRGMorQGU+S9Jhyg=;
 b=KImIXjOeIRdfBfPMZIFSwe8yhTGWjlEes11aZ5OpMYOgBSdXH4X9/06EdEEdE6neAsWOYjBF18Cky5g+OINdXAowWBC4Tjr2ENSiQnf9RMd/4p4PJyteUVKTugWmOCs1aYCMIzl/h/ES5Dgn3qD5TCsa/KACHIbiaygnzkhQHsA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Mon, 1 Apr 2019 05:07:49 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 05:07:49 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] pinctrl: freescale: use devm_platform_ioremap_resource() to
 simplify code
Thread-Topic: [PATCH] pinctrl: freescale: use devm_platform_ioremap_resource()
 to simplify code
Thread-Index: AQHU6EjaALQm1oR+wkWuBa/l4GPnkA==
Date:   Mon, 1 Apr 2019 05:07:49 +0000
Message-ID: <1554094986-14897-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0090.apcprd04.prod.outlook.com
 (2603:1096:202:15::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c70870c-2768-48ea-f420-08d6b65ffc4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3946;
x-ms-traffictypediagnostic: DB3PR0402MB3946:
x-microsoft-antispam-prvs: <DB3PR0402MB3946F822690E1CB7AD34FCA4F5550@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(136003)(376002)(396003)(199004)(189003)(105586002)(36756003)(6116002)(7736002)(478600001)(106356001)(68736007)(97736004)(2501003)(81166006)(8936002)(256004)(81156014)(2906002)(305945005)(25786009)(4326008)(8676002)(3846002)(5660300002)(26005)(6512007)(50226002)(6486002)(6506007)(53936002)(102836004)(316002)(386003)(14454004)(476003)(2616005)(86362001)(71200400001)(66066001)(186003)(110136005)(99286004)(2201001)(486006)(52116002)(6436002)(71190400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /wa2RoUpXC1oYcMTTv1YOCHVnExU9EHxSf2qIbOnwIik3USPUow+jQ0xGMLBIVceNMd5nVMPD3BmITW0lS2Adr84Y5FGGuh/ca5eVhOVZU7UPCr8TdsbpFLl4wbv627mrerqgW0Od2Ij53i/k1Z0x6R+1cLj0n45vT1nx/HEINka2pXR6yBxPIiGR3My4GXLXz0EIkqKSlolwzw1Df++imQnmUEmBkk/T94cdzm4XWasq8z8I389AEXAApsTCWZl1/jRmR4GlKTl8p8Iza86a/Wz4r3eWYvdzFd4ZVOPb4028rYBxHfIQcytGcUjXZ76qgOIZc3osZsQ69K5daCPFbQVt3dl49XF9MWPAuAUmwCIoP8pk1ltL7p+086O77vZ3NAhy+XUeZDF3/2WkPTeHlihznIYiJVmCM79pLtT7m4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c70870c-2768-48ea-f420-08d6b65ffc4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 05:07:49.5038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together, to
simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pinctrl/freescale/pinctrl-imx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/free=
scale/pinctrl-imx.c
index 188001b..cc6f5cc 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -785,7 +785,6 @@ int imx_pinctrl_probe(struct platform_device *pdev,
 	struct pinctrl_desc *imx_pinctrl_desc;
 	struct device_node *np;
 	struct imx_pinctrl *ipctl;
-	struct resource *res;
 	struct regmap *gpr;
 	int ret, i;
=20
@@ -817,8 +816,7 @@ int imx_pinctrl_probe(struct platform_device *pdev,
 			ipctl->pin_regs[i].conf_reg =3D -1;
 		}
=20
-		res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		ipctl->base =3D devm_ioremap_resource(&pdev->dev, res);
+		ipctl->base =3D devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(ipctl->base))
 			return PTR_ERR(ipctl->base);
=20
--=20
2.7.4

