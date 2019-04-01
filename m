Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74368C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF8520879
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZH4iFA9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfDAFVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 01:21:47 -0400
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]:42565
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725771AbfDAFVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 01:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJ75V1TmTUDRmJ7f0oJDMXUUEZ7jthcn7/zGV4W6PKs=;
 b=ZH4iFA9Pn0sJGdM/b6Wxy4MpVG1meoA58OfMS3nW7O6iCfmBxYOabdpftQ1INrz2mPyrvzOj331IYFCNOXjL/NshrwuANkrwCczHwNE+Mz8d+p1n7c+NMmjUGr/EGi9FemL8QDCisF81e8s4kr58A/UyL1Rdkhs7nvIEoM+1rIc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3673.eurprd04.prod.outlook.com (52.134.70.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Mon, 1 Apr 2019 05:21:44 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 05:21:43 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] rtc: mxc: use devm_platform_ioremap_resource() to simplify
 code
Thread-Topic: [PATCH] rtc: mxc: use devm_platform_ioremap_resource() to
 simplify code
Thread-Index: AQHU6ErLruWEMCY6B0i5i1N+oXQwww==
Date:   Mon, 1 Apr 2019 05:21:43 +0000
Message-ID: <1554095822-15532-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::35) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e77ad9aa-a89b-41d3-6ebf-08d6b661eda3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3673;
x-ms-traffictypediagnostic: DB3PR0402MB3673:
x-microsoft-antispam-prvs: <DB3PR0402MB3673DD2234C6C950A716552EF5550@DB3PR0402MB3673.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(136003)(396003)(199004)(189003)(71190400001)(305945005)(4744005)(14454004)(110136005)(52116002)(6506007)(26005)(6436002)(2201001)(102836004)(2906002)(105586002)(486006)(6116002)(5660300002)(106356001)(6512007)(36756003)(66066001)(53936002)(99286004)(478600001)(68736007)(7736002)(2501003)(8936002)(386003)(2616005)(3846002)(97736004)(186003)(86362001)(8676002)(25786009)(6486002)(476003)(4326008)(256004)(81156014)(81166006)(316002)(50226002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3673;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xDgYKSO/PD8+S+/aSl8Fqs6Bet5J1kmlcBnNud2FsJmjyFoO0oLizPk12NJtNMK7ZYzVT1YQqMKTXFqvsWSj8VondyOWP9+iSVldsoYnC/K241izfGWVaVx48dAmVtw+2Z8UEKcPlYlU3CBaeTY7gBz4bd1YmwZm4zdMmp5z/eUl+qeq/1VUqeUct6gA+OL6YCFlVP9Wz4FNupmq0MqqpYgXe4gPk0J/CY9igCR5PU3ULdsYzQycjo0lr8IIs0eI2ySrX6raPrOiXm+nGXBRD7XkkxAbVL05bn3CeVlWULS/W9LJ8jKGmTlPXQoArXq0xP2sfSJdBw20e/wdhbn/cenwmFVcS+kSjw3mMUHehFpGsaOILhkjO6thqEiSpBBy2T/wqVGZIAeUWM0eZpApjgcjTeE+HSSPUEBlyJR1KQU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77ad9aa-a89b-41d3-6ebf-08d6b661eda3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 05:21:43.9030
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
 drivers/rtc/rtc-mxc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index 878c6ee..28a15bd 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -318,7 +318,6 @@ static const struct rtc_class_ops mxc_rtc_ops =3D {
=20
 static int mxc_rtc_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct rtc_device *rtc;
 	struct rtc_plat_data *pdata =3D NULL;
 	u32 reg;
@@ -336,8 +335,7 @@ static int mxc_rtc_probe(struct platform_device *pdev)
 	else
 		pdata->devtype =3D pdev->id_entry->driver_data;
=20
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pdata->ioaddr =3D devm_ioremap_resource(&pdev->dev, res);
+	pdata->ioaddr =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pdata->ioaddr))
 		return PTR_ERR(pdata->ioaddr);
=20
--=20
2.7.4

