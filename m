Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8DDC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 03:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83BF206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 03:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cfPILI8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfKNDic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 22:38:32 -0500
Received: from mail-eopbgr20088.outbound.protection.outlook.com ([40.107.2.88]:35749
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbfKNDib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 22:38:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzyV/bBUlt3nHHqFJH2evpQZpTBORRLvSf275keXtMvEP8uA0MGG5dXXJ2SyI/lt27PGhaGwFd7XcxC4AouGl8Sfblpqah2eNi+oPfHKz/WicU2FZ7miSECszqihqF5DcEmB1h1JYpGJ2qfTCVSUx1+Rs2nmKnN33OLxBGXWlNunygTDMdJ7aZbU7C2lXoCO+NSbKBBV9C1cmGBiNCd2+skr2xRQIWW70AMCrQxWG/4MmmVF42366BGhjA9x/DRchJONfCJtez6LFJ/z+XAHt0Pzlacy7aTSJr4sNotvgWqFMEXoOWL2/aPpeV3zVQJ1v6Dl14mPsA5vFRQ5h6Vn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byRtdbqMPgct8GxQZExa0Mdbbx5IfxCCr8i2HW0+U0Q=;
 b=n4Wor90lciGUKogp4zkxwA7UUpQ0psHNjxmMVKaD2mWaHsjwSL+XSi54UGWXX/5/yKKaH9fanNTXL1irIpVEi2Xd7k8jJyyyEsINeOcrz7NqoUAZY4BGJS1aplobZPb2VRA9q065bMV7NE4NLzzWjd7bURKKnjN4NLNgCAKX08RXbOJb8qgegxQjc+fCZ3yoqCIjrD2k9DlKCCpc9tfToBXOEegyXyo6lPeJZgbI/S4M6ewZN9TdiNdM5vYqj4M3R6D3mzaDFdv6812pfozesiwAXFeOmt+nSTSl20hABF9Zwo1jnHvOBumbf6h9sFekO61JxVE15N6HCRD3y2VErA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byRtdbqMPgct8GxQZExa0Mdbbx5IfxCCr8i2HW0+U0Q=;
 b=cfPILI8w7MC8qM1vX0b3fbDG7kXiW/+urQI1TdIetx5IbAHt2l48aYFn7wnbvnUYbAd3Wfy3KHVgZEiv9AHnGdiQs5ZIgzTnrcWb1vlZgAtfQAYmkB/KrLtdDTEyrYcmol4IO8OkHjDU8pqMRpj3DqkAU7PBgFwUugaddaHCcvY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4994.eurprd04.prod.outlook.com (20.176.215.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Thu, 14 Nov 2019 03:38:28 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2451.024; Thu, 14 Nov 2019
 03:38:28 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Alice Guo <alice.guo@nxp.com>,
        "will@kernel.org" <will@kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/4] clk: imx: composite-8m: use relaxed io api
Thread-Topic: [PATCH V2 4/4] clk: imx: composite-8m: use relaxed io api
Thread-Index: AQHVmpz6hEyooanfW0qGgPGksZc+HA==
Date:   Thu, 14 Nov 2019 03:38:28 +0000
Message-ID: <1573702559-2744-5-git-send-email-peng.fan@nxp.com>
References: <1573702559-2744-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1573702559-2744-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::21) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da549bda-804d-468b-620c-08d768b41cc1
x-ms-traffictypediagnostic: AM0PR04MB4994:|AM0PR04MB4994:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4994577BA82E7FDAB36E523788710@AM0PR04MB4994.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(66066001)(305945005)(14454004)(36756003)(71200400001)(71190400001)(7736002)(2501003)(99286004)(4326008)(486006)(81156014)(81166006)(25786009)(86362001)(44832011)(2616005)(476003)(50226002)(446003)(11346002)(8676002)(8936002)(52116002)(76176011)(186003)(478600001)(6506007)(386003)(6486002)(6512007)(6436002)(2201001)(102836004)(26005)(316002)(5660300002)(54906003)(110136005)(256004)(14444005)(3846002)(6116002)(66556008)(6636002)(66446008)(66946007)(64756008)(66476007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4994;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2lPMtvP9KTUnySnwLQ76TxhyIiYsrpxK4r//pmQB6Mx1G11Mx/QJQue9ZJIsS0UMCSzEvZZbsM2IwBWeAOsaFHcCjJMwWFOdeBbNy9HC3ifaYghiHlHK0DytnGft/X7fNjRFBUi+FeQ6d2xpfqd0tO24NnDDJGMRGT7hUpSYnyHKoxRQSQQih/FDTkgj3/urn2kvYRkg/Xl7nY15KwCYrYTii6R3WTx9JgiedqKhiYjznFZ163WwPVKSDfl5s12hOjWBwAumGYFMWrCRsyxpeepD7jfYr3YEg2pGBqUXJXYBLt2AqbKMakG76qCqC08R3acmKVSzEpQWj1L7Km8nk5o+KRMRErYC22dRUVdqT7Y82QeS+XBvfZOJLTBD9SBbFY1dpCYRe74lazAiH33iYi4XAkzpOCVzc1STqYGFfPzDucCwT5W9340PwMF1mx+x
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da549bda-804d-468b-620c-08d768b41cc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 03:38:28.3601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UmiA5ztVMKze12N/dUmnQA4a7HHfUsNqbDuYfrBqZPvuJUOPBBkfgsOvtzQVe6zb5WA7pkh3i3l/8+LhXSym9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4994
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

writel/readl has a barrier, however that barrier is not needed,
because device memory mapping is nGnRE mapping and access is
in order and clk driver has spin lock or other lock to make
sure write finished. It is ok to use relaxed api here, no need
to use stronger readl/writel

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-8m.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-compo=
site-8m.c
index 20f7c91c03d2..513dc57483d0 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -31,14 +31,14 @@ static unsigned long imx8m_clk_composite_divider_recalc=
_rate(struct clk_hw *hw,
 	unsigned int prediv_value;
 	unsigned int div_value;
=20
-	prediv_value =3D readl(divider->reg) >> divider->shift;
+	prediv_value =3D readl_relaxed(divider->reg) >> divider->shift;
 	prediv_value &=3D clk_div_mask(divider->width);
=20
 	prediv_rate =3D divider_recalc_rate(hw, parent_rate, prediv_value,
 						NULL, divider->flags,
 						divider->width);
=20
-	div_value =3D readl(divider->reg) >> PCG_DIV_SHIFT;
+	div_value =3D readl_relaxed(divider->reg) >> PCG_DIV_SHIFT;
 	div_value &=3D clk_div_mask(PCG_DIV_WIDTH);
=20
 	return divider_recalc_rate(hw, prediv_rate, div_value, NULL,
@@ -104,13 +104,13 @@ static int imx8m_clk_composite_divider_set_rate(struc=
t clk_hw *hw,
=20
 	spin_lock_irqsave(divider->lock, flags);
=20
-	val =3D readl(divider->reg);
+	val =3D readl_relaxed(divider->reg);
 	val &=3D ~((clk_div_mask(divider->width) << divider->shift) |
 			(clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
=20
 	val |=3D (u32)(prediv_value  - 1) << divider->shift;
 	val |=3D (u32)(div_value - 1) << PCG_DIV_SHIFT;
-	writel(val, divider->reg);
+	writel_relaxed(val, divider->reg);
=20
 	spin_unlock_irqrestore(divider->lock, flags);
=20
--=20
2.16.4

