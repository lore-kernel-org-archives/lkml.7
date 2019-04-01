Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565EBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F5720856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J1/I7DM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfDAFNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 01:13:07 -0400
Received: from mail-eopbgr20050.outbound.protection.outlook.com ([40.107.2.50]:36578
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbfDAFNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 01:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+Rqv1e7rwqS3r+bWCcgb+uX2pZO59GkjocpA8unSx0=;
 b=J1/I7DM9GQAQHc44MvBs1UbUKmfyTqQX1PEneXDonD5oZgIwo5G6kmIs/2k2dwWdbO/jTOaNt3hLfxqIXfFvV3RX2SVVjNSzh5ZW7+sPrSXUoA94DWRFy6ovqYVqnVmaxOJEwvCda1r7iLBSeNbUVDspKCYFJG+JQm/OhktvWa4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Mon, 1 Apr 2019 05:13:02 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 05:13:02 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] clk: imx: use devm_platform_ioremap_resource() to simplify
 code
Thread-Topic: [PATCH] clk: imx: use devm_platform_ioremap_resource() to
 simplify code
Thread-Index: AQHU6EmUMVLbmtS1kE2536Ttj55H4g==
Date:   Mon, 1 Apr 2019 05:13:02 +0000
Message-ID: <1554095298-15111-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:202:2e::30) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86771402-8a3d-404f-0c3e-08d6b660b6d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3946;
x-ms-traffictypediagnostic: DB3PR0402MB3946:
x-microsoft-antispam-prvs: <DB3PR0402MB394625974CEBFFDE00136C6EF5550@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(366004)(39860400002)(189003)(199004)(316002)(14454004)(386003)(53936002)(50226002)(6486002)(6506007)(102836004)(26005)(5660300002)(7416002)(6512007)(2201001)(110136005)(99286004)(71190400001)(6436002)(52116002)(486006)(86362001)(2616005)(476003)(186003)(71200400001)(66066001)(478600001)(68736007)(106356001)(105586002)(7736002)(6116002)(36756003)(25786009)(2906002)(305945005)(3846002)(4326008)(8676002)(2501003)(97736004)(81156014)(256004)(8936002)(81166006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cYggXTEyLyfg85jrKhkP9YqEL1KNwOEs7qwDTCw6gXEsJnHgRgvYbBqtgvRndCUdVFhbACj7NkJPEzV15YpsdgIgpRoYF5qt5BKx9b7HjRQ7/nygGwPW7twKMkxg6aW5x6hQ1x54xFuLNI/iEW6ox2wTorIB44DXztK3l0YaDVcJehE8UjS9oa7RXdM3yiKHII6kkUbxJcoomwkvOkCnR6so0vvvd21HLvDsJ+5FBxtJVzY7JGTvqANXj5DXG4qlpGCri/974ma2wX0Vz5EZkUyjg/z4UfTHpPXEAXisp5HZWerZhyKfzlD8MmDZZayIQ1ZvWOtHFvPpWxstEwAAWGBLD8K11OBxV/Of2YCs5rLa/O88b03ZUVpNnSn1Z8gHzOKOcyJ7DnklGtF7xeIvpvV2M5FrT5au/P39vckuLR0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86771402-8a3d-404f-0c3e-08d6b660b6d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 05:13:02.4570
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
 drivers/clk/imx/clk-imx8qxp-lpcg.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8q=
xp-lpcg.c
index fb6edf1..c711654 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -159,7 +159,6 @@ static int imx8qxp_lpcg_clk_probe(struct platform_devic=
e *pdev)
 	struct clk_hw_onecell_data *clk_data;
 	const struct imx8qxp_ss_lpcg *ss_lpcg;
 	const struct imx8qxp_lpcg_data *lpcg;
-	struct resource *res;
 	struct clk_hw **clks;
 	void __iomem *base;
 	int i;
@@ -168,10 +167,7 @@ static int imx8qxp_lpcg_clk_probe(struct platform_devi=
ce *pdev)
 	if (!ss_lpcg)
 		return -ENODEV;
=20
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
-	base =3D devm_ioremap(dev, res->start, resource_size(res));
+	base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (!base)
 		return -ENOMEM;
=20
--=20
2.7.4

