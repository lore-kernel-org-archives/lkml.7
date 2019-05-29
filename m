Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6587C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFBA21873
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dl0GiIbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfE2M2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:28:04 -0400
Received: from mail-eopbgr30051.outbound.protection.outlook.com ([40.107.3.51]:23783
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727085AbfE2M0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSf4gKjs3zpyNPrKSJADkzRIyXHw5+kQmaxEOT+J0WU=;
 b=Dl0GiIbihkbBOcsAOvw2UiHoeukri5yljLb2w2/alciYPGvOzHQp67cLUzRuE557AO7TKrcb2dkLSpJQKcvF+7sZcXwqdxk8cEeMzGsx0SGchZWveQ7QB3ZIOR3a+p/hzB6wZiOjOmy29DkSDBaTGhg5FG10KcMksmgd7je+QVg=
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
Subject: [RESEND 03/18] clk: imx6q: Do not reparent uninitialized
 IMX6QDL_CLK_PERIPH2 clock
Thread-Topic: [RESEND 03/18] clk: imx6q: Do not reparent uninitialized
 IMX6QDL_CLK_PERIPH2 clock
Thread-Index: AQHVFhnE02Ous6iKsUun2H1sK1dYlQ==
Date:   Wed, 29 May 2019 12:26:40 +0000
Message-ID: <1559132773-12884-4-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 26c69390-9ab3-46d2-2d9f-08d6e430e71d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6049;
x-ms-traffictypediagnostic: AM0PR04MB6049:
x-microsoft-antispam-prvs: <AM0PR04MB60496CE982D3283175359894F61F0@AM0PR04MB6049.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(346002)(376002)(199004)(189003)(6436002)(476003)(73956011)(53936002)(486006)(11346002)(446003)(76116006)(186003)(5660300002)(102836004)(66446008)(66476007)(66946007)(26005)(44832011)(64756008)(36756003)(91956017)(66556008)(8936002)(316002)(2616005)(66066001)(99286004)(256004)(6116002)(6512007)(3846002)(76176011)(68736007)(305945005)(81156014)(81166006)(6486002)(6506007)(54906003)(110136005)(478600001)(2906002)(7736002)(8676002)(14454004)(86362001)(71190400001)(71200400001)(25786009)(4326008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6049;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5ERzVMJ8FwqLvnKZuSKCFP7a2unQEGjbva37jEQ5VXl26WPe0hJzUpVCZJptViNwmSy/gSxbvQ7bA4Okwzsj2xNrQCI12rF9d3SlquuRy7SkxlvOCUP72sspyOMoODdme6/9cbm4MNkxqW/jEJ/HPG4lv+b6vFebKW6NOsfgkTm9d9kz+YzzZGQph+v46u119O/NEQoFTureomE8jdgVMHnCxrr5wFwlsrR4KawvaZmNvCMP/YVwy92AKOd/NLFUGdS12KYwkEeYNjdAN6e/Gjzvv/OVfXnjhMM7kU8DDSKNseJ5ALCV5HHqiq0yX6jlMVATwhlzM1RxOQkqWCbeX4SHMdWIjCAzrAZdzrCBxzIzxhblF/CaO0KPLeP+9XAHEQ4wLzmFLU9yIrk8W6c4AwgE82U3303cC8MOdxEJ40g=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D08CF27B4170454DAAFE7DF2A0AA74F3@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c69390-9ab3-46d2-2d9f-08d6e430e71d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 12:26:40.0899
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

The clock is registered later than these two re-parentings.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx6q.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 077276b..d90d54b 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -280,12 +280,6 @@ static void mmdc_ch1_disable(void __iomem *ccm_base)
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
@@ -300,8 +294,6 @@ static void mmdc_ch1_reenable(void __iomem *ccm_base)
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
