Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC55CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF91C2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hZpKghbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfCVPhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:37:16 -0400
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:41091
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727570AbfCVPhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxAAyk0lMWt1jcLiCs3ToQmuiQPdTfFNbqFY3XTsUEU=;
 b=hZpKghbIjM+jN8Hvuekcrk6C0d5HdNuuIuD2ukNftU81F8bUrG6B0trc7726BO13A8lZUxbFCz8sZz2967BBce991FBcq4C0s0zgfjZ59me7bKHT8U9d1Tn/jYnUBGDXid+dg9pCV9raHU7v71T1tlK6RmcXybYCMj5tIN5Kzlg=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5636.eurprd04.prod.outlook.com (20.178.202.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Fri, 22 Mar 2019 15:37:04 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019
 15:37:04 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 04/19] clk: imx6q: Do not reparent uninitialized
 IMX6QDL_CLK_PERIPH2 clock
Thread-Topic: [RFC 04/19] clk: imx6q: Do not reparent uninitialized
 IMX6QDL_CLK_PERIPH2 clock
Thread-Index: AQHU4MUZE6Xa9A23l0WrI1B1HzslYQ==
Date:   Fri, 22 Mar 2019 15:37:03 +0000
Message-ID: <1553269010-15591-5-git-send-email-abel.vesa@nxp.com>
References: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0170.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::24) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [212.146.100.6]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5341363c-f235-4bac-cc14-08d6aedc3bb5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5636;
x-ms-traffictypediagnostic: AM0PR04MB5636:
x-microsoft-antispam-prvs: <AM0PR04MB5636B23B1A1255FC46B72625F6430@AM0PR04MB5636.eurprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(106356001)(105586002)(54906003)(110136005)(316002)(52116002)(6512007)(81156014)(97736004)(53936002)(86362001)(81166006)(478600001)(8676002)(2906002)(14454004)(486006)(99286004)(36756003)(7736002)(71200400001)(44832011)(71190400001)(3846002)(5660300002)(386003)(4326008)(6116002)(6486002)(50226002)(6506007)(66066001)(256004)(76176011)(446003)(186003)(25786009)(11346002)(68736007)(26005)(476003)(6436002)(2616005)(8936002)(102836004)(305945005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5636;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mQc+E7zNv9P6f3Lc0ASe72VebA/DKdSq1Va27AlZenoBT11PTsle4eCtLQNaLInPfknnC2mx6MQC/X2Xcx0oUA2dlGW7VXusjPH2htyKzba6euMJlZpD52Gd64mNYwGQDBrymGFOgzJKc6sqeWIE0U1/8FzS9PYQjguEDiVKiSNzCqOP4Tr7PaliDQxv9+/0jWHdbOBYq7r3R8vogV5x+dTBO1hKE7wiuS6gSZuvmykPCiEYaCCVB9Kybuk/I7qTi4s2vMY+Lef9hVy5UnvLFf14e5bZ5iqqpgkmPNRv5UhdNIfucI+hYJObAoS3LPuaxU4EOD7l20oknr0oR8xoRLE+eWBZy7HhqIePX0rHnSyhQ9DFIK0fJ1O7LyCV6J5/IJTjjUU5e/qU7OK23FxR8GHn6l1nOaANBM/z/2ozWac=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5341363c-f235-4bac-cc14-08d6aedc3bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 15:37:03.9673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock is registered later than these two re-parentings.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx6q.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 708e7c5..c7b671e 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -291,12 +291,6 @@ static void mmdc_ch1_disable(void __iomem *ccm_base)
 	clk_set_parent(clk[IMX6QDL_CLK_PERIPH2_CLK2_SEL],
 		       clk[IMX6QDL_CLK_PLL3_USB_OTG]);
=20
-	/*
-	 * Handshake with mmdc_ch1 module must be masked when changing
-	 * periph2_clk_sel.
-	 */
-	clk_set_parent(clk[IMX6QDL_CLK_PERIPH2], clk[IMX6QDL_CLK_PERIPH2_CLK2]);
-
 	/* Disable pll3_sw_clk by selecting the bypass clock source */
 	reg =3D readl_relaxed(ccm_base + CCM_CCSR);
 	reg |=3D CCSR_PLL3_SW_CLK_SEL;
@@ -311,8 +305,6 @@ static void mmdc_ch1_reenable(void __iomem *ccm_base)
 	reg =3D readl_relaxed(ccm_base + CCM_CCSR);
 	reg &=3D ~CCSR_PLL3_SW_CLK_SEL;
 	writel_relaxed(reg, ccm_base + CCM_CCSR);
-
-	clk_set_parent(clk[IMX6QDL_CLK_PERIPH2], clk[IMX6QDL_CLK_PERIPH2_PRE]);
 }
=20
 /*
--=20
2.7.4

