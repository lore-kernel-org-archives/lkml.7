Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE76C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767E920856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GhXih6vp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfDAFUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 01:20:00 -0400
Received: from mail-eopbgr30048.outbound.protection.outlook.com ([40.107.3.48]:15015
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725817AbfDAFT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 01:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjQ29Bb99KvaZDOBdO3VWLYAcE53MgZC/WyoEBCX+II=;
 b=GhXih6vpWSFZAhnaWzU1StA3jOAEgDcyUlko1C2RnfEFsbfrhEEnTqYQJ7hFxxvHEtS8Hhfz/Zz0xWlGL9ZMpLI6s4dRnEHe2UVjIVzvOYM0mvuj06yWj+FLdeyJNTk14R2R+IRAMF4Jc76+BfIsYTMX88wj8rYPdoYxuD6AAWk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3673.eurprd04.prod.outlook.com (52.134.70.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Mon, 1 Apr 2019 05:19:55 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 05:19:55 +0000
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
Subject: [PATCH] input: imx6ul_tsc: use devm_platform_ioremap_resource() to
 simplify code
Thread-Topic: [PATCH] input: imx6ul_tsc: use devm_platform_ioremap_resource()
 to simplify code
Thread-Index: AQHU6EqK7YCFSFAUiEmCAJSqda9wGQ==
Date:   Mon, 1 Apr 2019 05:19:55 +0000
Message-ID: <1554095712-15413-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:202:2e::18) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64ae32ec-6b8a-4a9d-e3ca-08d6b661ad18
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3673;
x-ms-traffictypediagnostic: DB3PR0402MB3673:
x-microsoft-antispam-prvs: <DB3PR0402MB3673CAE66AA890CF5A4DE0A3F5550@DB3PR0402MB3673.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(136003)(396003)(199004)(189003)(71190400001)(305945005)(14454004)(110136005)(52116002)(6506007)(26005)(6436002)(2201001)(102836004)(2906002)(105586002)(486006)(6116002)(5660300002)(106356001)(6512007)(36756003)(66066001)(53936002)(99286004)(478600001)(68736007)(7736002)(2501003)(8936002)(386003)(2616005)(3846002)(97736004)(186003)(86362001)(8676002)(25786009)(6486002)(476003)(4326008)(256004)(81156014)(81166006)(316002)(50226002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3673;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oxCBVGRklem4sc5YMAkG41wQpL9h8VmrFR4Lf1dG+cy4DFDnxNyFaJS96qd1mu4au1hf3MdMccdGJiOf9N6IqF72wNgIVElpWuJDRdSeNezQaUdOrs95SQV5ZAZ2K8YcdRuImXA9xvbKrYtnYsHtkUY9nkAxh/xe26JBcyVAu15ZoWrh+Uhx5Kv9z4OvNImBhQ17/69QNVXvmXLht7inNMv1js9I9VJ8gEJXR46OOLRZwsgRmYNEffyv34nXjxitkuAVAHNt0PtIvabW0kCoJtAH/1YFQ0wEX9mMz6MlxnTTrnbfnl45vhUmxQM6kiCpQgL0Wd1aPaSaB57q2O3WZgxopdr6c6vHslEYyQZrZ409W9ADtdPY4FsnQe2ciNuNrhgzOHwUqltCiJp6erTnMsFxWgjYz1AXxPVJfrEIEo0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ae32ec-6b8a-4a9d-e3ca-08d6b661ad18
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 05:19:55.4008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together, to
simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/input/touchscreen/imx6ul_tsc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchsc=
reen/imx6ul_tsc.c
index c10fc59..e04eecd 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -364,8 +364,6 @@ static int imx6ul_tsc_probe(struct platform_device *pde=
v)
 	struct device_node *np =3D pdev->dev.of_node;
 	struct imx6ul_tsc *tsc;
 	struct input_dev *input_dev;
-	struct resource *tsc_mem;
-	struct resource *adc_mem;
 	int err;
 	int tsc_irq;
 	int adc_irq;
@@ -403,16 +401,14 @@ static int imx6ul_tsc_probe(struct platform_device *p=
dev)
 		return err;
 	}
=20
-	tsc_mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tsc->tsc_regs =3D devm_ioremap_resource(&pdev->dev, tsc_mem);
+	tsc->tsc_regs =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tsc->tsc_regs)) {
 		err =3D PTR_ERR(tsc->tsc_regs);
 		dev_err(&pdev->dev, "failed to remap tsc memory: %d\n", err);
 		return err;
 	}
=20
-	adc_mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	tsc->adc_regs =3D devm_ioremap_resource(&pdev->dev, adc_mem);
+	tsc->adc_regs =3D devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(tsc->adc_regs)) {
 		err =3D PTR_ERR(tsc->adc_regs);
 		dev_err(&pdev->dev, "failed to remap adc memory: %d\n", err);
--=20
2.7.4

