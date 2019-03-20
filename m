Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F91CC10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7F420850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FIS98PvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfCTRMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:12:55 -0400
Received: from mail-eopbgr50040.outbound.protection.outlook.com ([40.107.5.40]:64227
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726449AbfCTRMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwNLqDDZfTO49FoZHd7h+WkFgMmjZAZdVXfeCnBp/lk=;
 b=FIS98PvFC4SVb0STk/ak/cFVJJFlFQC8lxqP4BHThOGw36b6FG9FhpV61/uafex86CLwx+y2K262geGKibMmHYXUgKI2Vvdc5H37PV52nMm10LgszJKe/L+gRcmN34jNiWmyaM/4VNRoOaMUTz6V6aNEg6NhfiOT18773sTwWBg=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6465.eurprd04.prod.outlook.com (20.179.253.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 20 Mar 2019 17:12:49 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.015; Wed, 20 Mar 2019
 17:12:49 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Rob Herring <robh@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] clk: imx6q: Do not reparent unregistered IMX6QDL_CLK_PERIPH2
Thread-Topic: [PATCH] clk: imx6q: Do not reparent unregistered
 IMX6QDL_CLK_PERIPH2
Thread-Index: AQHU30AlQ7uX5WNrk0iZ5CsAK+rIhw==
Date:   Wed, 20 Mar 2019 17:12:49 +0000
Message-ID: <1553101958-13457-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0064.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::26) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [212.146.100.6]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 445192cc-3329-4b5e-e706-08d6ad57479e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6465;
x-ms-traffictypediagnostic: AM0PR04MB6465:
x-microsoft-antispam-prvs: <AM0PR04MB6465C74A3983A6D0E2A5021CF6410@AM0PR04MB6465.eurprd04.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(39860400002)(346002)(199004)(189003)(4326008)(486006)(478600001)(36756003)(26005)(68736007)(8936002)(2616005)(97736004)(5660300002)(81166006)(476003)(71190400001)(6512007)(44832011)(186003)(81156014)(6636002)(25786009)(53936002)(106356001)(105586002)(54906003)(6506007)(66066001)(386003)(50226002)(86362001)(71200400001)(14454004)(2906002)(6436002)(8676002)(52116002)(305945005)(102836004)(256004)(7736002)(6116002)(316002)(99286004)(110136005)(3846002)(6486002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6465;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zn1MnoEthL4ImsKFUXH/FlVG00RNcgN99LLeCZGPJqIBZF90pjYKR4zru2WPlgUIqbVqLVcfYiK26xaas1nmX4gj0HBJ5026n7rIb3X9anuNJ6jRq1GPX6LgahkWSHXICMQ+S918vKYYFk5yqxTaLqNCmlNLw54TLy6XRcvPwCnQoKqC0SFPPyV89v3HZstGf13aIqoT4NiFtdxn/MkPCmJrM9WBVhgOzsxyhA3Tm2DuMBC3lBQt6FiaWn+WDv4opwFVJVIsZvafRhroLg/HoQcbx3+aW5rIU3IepvtaMMxVMMVLk5UfuGJaqkllFNlv2bFha5/Ox2u9ErvY6QEmh5lJxuguN05AQPniNqH8VIEs2iVlQFmtJkaBCNL1InK9FOo2IT0J3Aphgr+fAeR8J3pQvMhvPPioKjHGO8F4YwU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445192cc-3329-4b5e-e706-08d6ad57479e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 17:12:49.8192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6465
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock is registered later then these two re-parentings

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

