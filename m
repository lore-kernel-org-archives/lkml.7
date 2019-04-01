Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B053BC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB3120879
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xl9Iyv9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfDAF3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 01:29:18 -0400
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:49320
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725771AbfDAF3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 01:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoboX1Dj7qzCQVNU9UcOdTLOWtM+dUjYOHGjVBr3r8Q=;
 b=Xl9Iyv9waKIoIlCx+km7bzp/+VkMuhMnLT0xG++yMxYQWojuaUjEXL7D1Ifg4AoBvPgUztYMXRJ7Gnzx/vNf/Y8H4vUWH6CHEtAno0M/aTWlrApX52JxhqYJAuBA4fc7zdrPfr4fyDTQMiQ8/iQkXIt+8LlfEmiBb6Wq7+VR7y4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3867.eurprd04.prod.outlook.com (52.134.65.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.19; Mon, 1 Apr 2019 05:29:13 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 05:29:13 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] rtc: snvs: use devm_platform_ioremap_resource() to simplify
 code
Thread-Topic: [PATCH] rtc: snvs: use devm_platform_ioremap_resource() to
 simplify code
Thread-Index: AQHU6EvXUmyLyX8+gkyzEz/7Ulxs5g==
Date:   Mon, 1 Apr 2019 05:29:13 +0000
Message-ID: <1554096271-17921-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0140.apcprd02.prod.outlook.com
 (2603:1096:202:16::24) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5f5852f-f7b1-440f-6418-08d6b662f955
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3867;
x-ms-traffictypediagnostic: DB3PR0402MB3867:
x-microsoft-antispam-prvs: <DB3PR0402MB386715770E266CE726A8D340F5550@DB3PR0402MB3867.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(366004)(199004)(189003)(81156014)(8936002)(6116002)(7736002)(6506007)(386003)(25786009)(102836004)(316002)(3846002)(52116002)(5660300002)(81166006)(26005)(186003)(68736007)(110136005)(97736004)(14444005)(2906002)(486006)(53936002)(106356001)(105586002)(8676002)(86362001)(2616005)(476003)(4326008)(50226002)(6436002)(305945005)(256004)(14454004)(99286004)(2501003)(71190400001)(71200400001)(6512007)(2201001)(66066001)(6486002)(36756003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3867;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fJfRv/98iWsUGGryLDKFUhVHehJ9XhzZflvrrKlUfx/jllwAjAbPkYqzks3k8cYMrSNz4Y+wWX+VIMFQOHr5bi+oVkz/drJZ65olCGV15Fr/mHUZ0a3h/LdYtjew15mhdy55HfGSgF5vCjRuWoYzyP9fTRDvPL1Mcn1yuOnKEjHijdxeSIXdfoqolH+Gdrgeuv064jamiOEbx3XLxtwncv+cnK1NcMJ0csawsMmCJNAb2A6o2s9cu658nX7UebDb2qg5EBMFuCV6CXiAz+m0vpxFzZUwZebV5d+U14c2KtreHNbutMTOJS+w0kJbO5pq6a3nfo5eoBIzH9tDuHIZcgfg+sEe0m4ujYOwAx4M7BU/deNCawyBR/g5pPuUTGiOt1bL60dFEfSIByc15AHlGTgcvUPA7Sm50qv9kfQnRJY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f5852f-f7b1-440f-6418-08d6b662f955
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 05:29:13.0230
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
 drivers/rtc/rtc-snvs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index ce73eab..e0edd594 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -272,7 +272,6 @@ static const struct regmap_config snvs_rtc_config =3D {
 static int snvs_rtc_probe(struct platform_device *pdev)
 {
 	struct snvs_rtc_data *data;
-	struct resource *res;
 	int ret;
 	void __iomem *mmio;
=20
@@ -284,9 +283,8 @@ static int snvs_rtc_probe(struct platform_device *pdev)
=20
 	if (IS_ERR(data->regmap)) {
 		dev_warn(&pdev->dev, "snvs rtc: you use old dts file, please update it\n=
");
-		res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
=20
-		mmio =3D devm_ioremap_resource(&pdev->dev, res);
+		mmio =3D devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(mmio))
 			return PTR_ERR(mmio);
=20
--=20
2.7.4

