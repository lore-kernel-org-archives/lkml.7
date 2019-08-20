Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F51C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B542B22CE8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hoU0FQVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfHTCRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:17:53 -0400
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:49302
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728770AbfHTCRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:17:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxlsiBHJQSEO/Lj5DeygXacGo2MnEhWqvX2MB6Rgt5S/faMFznruT1VSFCJwpJE6ZaIPr5pRFhuvifN4xNq962B0angBT1fqtWzuo6HOCvLiCEhxuFZ6UGIoJxIyl8lHA2PSlrP0JdUpvYe0yHEmTgjs2WAmFATxHAm6cqTL/AQ35XY3nGFc/X3XoTkVT2CuFr66w5olzLeUWRKpEkAo0FqkLZQ2zMxVX8fP1ITl04tjrd/JXCGiyOKV+LHoVIkIe27+hwf7IjFuqtVqaRsZ7JPTgE3miSJzVpIfcdS5NaaLkb2aClodc5fInOepAGz+vkds1uswvZKzTYTEr5p3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydOCh/K2z4zEONaG0ij2fsMOXs9+gCmBapYLNzCykV0=;
 b=bqNc0kCF0FcVuCYMW/YhgWvLg8jyVAMIBXDSt3A7k4p7hgpdjVoqR67QYXDxht/rpkWU72rLNbjPoHb1hfczhR3gFMJMduHyvNfTdUcixXJtd2IDdKWs9Rrc+fCeU/0WkhWQunwQRwKzKH9OJ5OqAA2iIfJ0qtFK/Pe3l/x5HYpk6AmxxBNOPSoc3mDLh6SO7OmynQnyYAe/BTN3/xydND1sc+pe5b4Z3q4Y3wAXhvLBujiFOIyusOMm4uZyrlTmsIshOPzRScRZ8f1XjrUnQluV7w8aegdEh1mtcINDR/p+8xSbgZLJf5g7j+87GvQdynAp+gG3uVkButzDdQHQmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydOCh/K2z4zEONaG0ij2fsMOXs9+gCmBapYLNzCykV0=;
 b=hoU0FQVkxu+pofMkPqL9HQ7lhzyghz7uV304KLH1s1KTjjEM1TX263/3s05i7lfcFReUcTPTui3UZC5519T7NNnwts++oZo9atDjwNc52SSyEmyeJgVkg4yPIXz2uO+xHkaE4LSCbFWGgd9/80sG4/aBCVOVxXVMRwawS2ZQNtM=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB3988.eurprd04.prod.outlook.com (52.134.90.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 02:17:46 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 02:17:46 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: pll14xx: avoid glitch when set rate
Thread-Topic: [PATCH] clk: imx: pll14xx: avoid glitch when set rate
Thread-Index: AQHVVv10E+OF2Euht0ilryFWSAJw8w==
Date:   Tue, 20 Aug 2019 02:17:46 +0000
Message-ID: <1566266337-21597-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0023.apcprd04.prod.outlook.com
 (2603:1096:202:2::33) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5bced0e-c6c1-44bb-5c18-08d725149702
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB3988;
x-ms-traffictypediagnostic: AM0PR04MB3988:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB39886ACF79389A92288D2BE288AB0@AM0PR04MB3988.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(199004)(189003)(478600001)(52116002)(4326008)(36756003)(86362001)(2201001)(5660300002)(6116002)(66066001)(14444005)(7736002)(256004)(305945005)(14454004)(53936002)(386003)(71200400001)(71190400001)(64756008)(6512007)(8936002)(81166006)(2906002)(81156014)(3846002)(316002)(6486002)(54906003)(6436002)(110136005)(102836004)(6506007)(186003)(99286004)(26005)(476003)(2616005)(44832011)(486006)(66476007)(25786009)(66446008)(50226002)(66556008)(66946007)(8676002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3988;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UOk8jyx8po7iWgMHcsEHV+YEH+daFBzm8iz0dgsQk6vT600TTqqdmZ2wF+NrBZi48Om9qstReb1Ks77Z5H02Kjxy73RJ8UJnfTp0FgMYnxfXHT4VMEgP1B/C+7Ix1pdHG3wK2EQDZDb7xel5wkfONUHyLhJl+fS4MLmwnKHryrYblqLUBNzu38cO4k7mSX+E3MgFQDKvTENZ2m2Wxupg1+n9oSmFCO+MLykvieZro0vcziuhxW15z5lJA9Y8MeKZor6cFMjDxQwk/uC8kqoO8lwtHPDyoVgMqPEH6d6WS89Bwte8Ss/wBjaukzHAuYZDboF5dDc61P5aRq6yW9oT46sZW8Xb0DUBN0Bc4CZgeTZO6bCNB7cm+UIOxDvVlDbp5CZFMABIPOxi7ivdSXuiC2G1TBD6/OUnGY+ltRUBNrs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bced0e-c6c1-44bb-5c18-08d725149702
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 02:17:46.1031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4ntTmLDc33kD77HRyloBOMV2gLexn1AxB/B9JDaN5ASW2dW9bP0nCfx5oXme3YPeiKtf/GLLHOElX2fCZSKrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3988
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According to PLL1443XA and PLL1416X spec,
"When BYPASS is 0 and RESETB is changed from 0 to 1, FOUT starts to
output unstable clock until lock time passes. PLL1416X/PLL1443XA may
generate a glitch at FOUT."

So set BYPASS when RESETB is changed from 0 to 1 to avoid glitch.
In the end of set rate, BYPASS will be cleared.

Fixes: 8646d4dcc7fb ("clk: imx: Add PLLs driver for imx8mm soc")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pll14xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index b7213023b238..bd072556bc44 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -191,6 +191,10 @@ static int clk_pll1416x_set_rate(struct clk_hw *hw, un=
signed long drate,
 	tmp &=3D ~RST_MASK;
 	writel_relaxed(tmp, pll->base);
=20
+	/* Enable BYPASS */
+	tmp |=3D BYPASS_MASK;
+	writel(tmp, pll->base);
+
 	div_val =3D (rate->mdiv << MDIV_SHIFT) | (rate->pdiv << PDIV_SHIFT) |
 		(rate->sdiv << SDIV_SHIFT);
 	writel_relaxed(div_val, pll->base + 0x4);
@@ -250,6 +254,10 @@ static int clk_pll1443x_set_rate(struct clk_hw *hw, un=
signed long drate,
 	tmp &=3D ~RST_MASK;
 	writel_relaxed(tmp, pll->base);
=20
+	/* Enable BYPASS */
+	tmp |=3D BYPASS_MASK;
+	writel_relaxed(tmp, pll->base);
+
 	div_val =3D (rate->mdiv << MDIV_SHIFT) | (rate->pdiv << PDIV_SHIFT) |
 		(rate->sdiv << SDIV_SHIFT);
 	writel_relaxed(div_val, pll->base + 0x4);
--=20
2.16.4

