Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BD1C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C67217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dWt12lFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfE2M0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:26:49 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:5830
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbfE2M0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=588tfaXco8sZLZoFxrasuXFZWMHw933ICXSDEa1zcPY=;
 b=dWt12lFysGbMdL2aRFSjgixYZzEv14nF4NpSPoLNOS8Pkw4rnlJ/1aFYZfgqe1YZT4PndEWFYBykpKto6CFoWHYvwRYguHQTEfHsUCKXvUQgxoD7SogLN4oqEwtXahCndXSw67FDD61wMcAwT+8jPr6JgvBpb4lVbHSn3J5YT/A=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6049.eurprd04.prod.outlook.com (20.179.32.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Wed, 29 May 2019 12:26:40 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 12:26:40 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND 02/18] clk: imx6sx: Do not reparent to unregistered
 IMX6SX_CLK_AXI
Thread-Topic: [RESEND 02/18] clk: imx6sx: Do not reparent to unregistered
 IMX6SX_CLK_AXI
Thread-Index: AQHVFhnEQ6+yBjxFSEqYRQDtiQoK/w==
Date:   Wed, 29 May 2019 12:26:39 +0000
Message-ID: <1559132773-12884-3-git-send-email-abel.vesa@nxp.com>
References: <1559132773-12884-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1559132773-12884-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1c9a068-f184-41fb-ea73-08d6e430e6c0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6049;
x-ms-traffictypediagnostic: AM0PR04MB6049:
x-microsoft-antispam-prvs: <AM0PR04MB6049CF68F153A315590F02FCF61F0@AM0PR04MB6049.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(346002)(376002)(199004)(189003)(6436002)(476003)(73956011)(53936002)(486006)(11346002)(446003)(76116006)(186003)(5660300002)(102836004)(66446008)(66476007)(66946007)(26005)(44832011)(64756008)(36756003)(91956017)(66556008)(8936002)(316002)(2616005)(66066001)(99286004)(256004)(6116002)(6512007)(3846002)(76176011)(68736007)(305945005)(81156014)(81166006)(6486002)(6506007)(54906003)(110136005)(478600001)(2906002)(7736002)(8676002)(4744005)(14454004)(86362001)(71190400001)(71200400001)(25786009)(4326008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6049;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DdVSkTf/7+qTYGI6QENAnmhabeEKMI2WgTYsNI6t1SuL6yb+ua3VVbZx7k00dmFxOLk2pYtogG8hmywfGKUE5PQYKAGp0ka8s6E/OgvF2T9ElQ4rmcF/J67YOfK9aTKRShoxcdLGQ87lbm1h6h1jeSsrU/U8ReEn9ZQntBMfWwjZtkUBxqEl46N5TPDfkl4Qeu0yzr7gx/75q+Mlc2KPcqLOTwCsmSMcFpOUoLvOxZ3qVtsXcePXi4IlrfQAxjaAw76EUxJomnR3EObzt9WQb2LsvFrAZjHbjrYRpE8UJbouAtrC3c+Elw+BCiGMayrJXwSkdBIFM3ymNTvzTkv80m0nel7O3mtnSyEGRusmo/tRwHI5dt8Hg3/E50JRHjnCghzshGewy+FKzoO3YGSJJvkYukAXPd4JjCf0Q0j15gs=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <752908D6060E1D4AA5BD5202CA028E25@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c9a068-f184-41fb-ea73-08d6e430e6c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 12:26:39.7731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock IMX6SX_CLK_AXI is not registered at all.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx6sx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index d8c96d5..a7aa0f2 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -509,8 +509,6 @@ static void __init imx6sx_clocks_init(struct device_nod=
e *ccm_node)
 	/* Set the parent clks of PCIe lvds1 and pcie_axi to be pcie ref, axi */
 	if (clk_set_parent(clks[IMX6SX_CLK_LVDS1_SEL], clks[IMX6SX_CLK_PCIE_REF_1=
25M]))
 		pr_err("Failed to set pcie bus parent clk.\n");
-	if (clk_set_parent(clks[IMX6SX_CLK_PCIE_AXI_SEL], clks[IMX6SX_CLK_AXI]))
-		pr_err("Failed to set pcie parent clk.\n");
=20
 	/*
 	 * Init enet system AHB clock, set to 200MHz
--=20
2.7.4
