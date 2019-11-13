Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17070C17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C0421D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RZpkSSVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfKMKCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:02:14 -0500
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:57831
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726338AbfKMKCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:02:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghLBCCT1l5ynKK6LusIHOM8YBh920vjMFYPminq7HU1fyci/q2DiPMrbI8f3ljsWFSyjmfMOknNvDGPsScofAVPDWYq0Xx0AzvYtrgkoR+p1/xNBC69ESMD+HGgZ399AXiPVZ0frgSoUcL5rhdNHuUAwe7FZYMqNijPh2k86gSp25/c6+aPGLq83ZqHy1gTGAv7I2rGRzz2PtSWp21EtMvcYn9fVvJtknJHrSOFvFKCElGM3KZp86ZtP+iObwz3wz9Vs2JItt3xWPcBn7OfsRAK4Piv/XipMEBRr6j+eYLdn9G2YJyuUdIIWXOdBUUXC5PB5jrdsJjKmqCqGfLhYEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwULUZZW2NsfXOwtKkSafTgMEJZbCA8DQu7hE4Bg/2k=;
 b=RJf0dRKi+AJdEM1ldK5uDfgL5Ew02z9U0z1j4rLu3/vWX1+xUKEhPBb+5Xg/qC+pDCqH1A8SlSzKN55L7UIeH8j6OR7ncWZU7sLQxmwEA7/xMAHl4FtwaO4sTM7jwY+/tGpXgguHkaX2nH/YlroMCKFFvLT/C5GWNg2s60sUEMSAtOD+Oi+RrdFwvvrd+ZeJZXXzVdyxwsvsbmxOBhHymqPFcG4IiFxc3HxUY5QYDLBOeMCnidX5KYg9mb+A3tSwKUPdhhi7jOfm0YqvyDcJUsdgFRVgXBLotgJ8yh9cjiSuJdhxL9IQ8ADK6PjZoruH3LOD37bz6TEvCF1ZKivn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwULUZZW2NsfXOwtKkSafTgMEJZbCA8DQu7hE4Bg/2k=;
 b=RZpkSSVujitAr/3Pqx31lBjLqhidwoX/bBQl4rovODxzZ80tpwpFPmJ3H3Fa6rcCAlSchITDNKyWvt2n/JH13Hjsm0uVgLnVDriNWfhEZNOfDyC52nVXooi8aEXpDoBNvdZw/8yoF/AgnrFhWCP19WaDHTVckhE+kiCu35RZqYU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7058.eurprd04.prod.outlook.com (10.186.129.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 10:02:09 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 10:02:09 +0000
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
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] clk: imx: composite-8m: use relaxed io api
Thread-Topic: [PATCH 2/2] clk: imx: composite-8m: use relaxed io api
Thread-Index: AQHVmglpFZP+G4Lm+0e0Ga/vcUI18Q==
Date:   Wed, 13 Nov 2019 10:02:09 +0000
Message-ID: <1573638817-4363-2-git-send-email-peng.fan@nxp.com>
References: <1573638817-4363-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1573638817-4363-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0044.apcprd03.prod.outlook.com
 (2603:1096:202:17::14) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44863b37-9d58-4c98-9a6b-08d768208b5f
x-ms-traffictypediagnostic: AM0PR04MB7058:|AM0PR04MB7058:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB7058C91771FE2DA05D3B51E988760@AM0PR04MB7058.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(189003)(199004)(66066001)(2501003)(76176011)(2616005)(71200400001)(486006)(44832011)(3846002)(11346002)(386003)(99286004)(7736002)(446003)(26005)(4326008)(102836004)(2201001)(25786009)(2906002)(71190400001)(6506007)(476003)(36756003)(305945005)(86362001)(6436002)(6116002)(66476007)(66556008)(64756008)(14454004)(478600001)(8936002)(316002)(8676002)(14444005)(81156014)(66446008)(81166006)(54906003)(5660300002)(66946007)(6486002)(110136005)(186003)(50226002)(6512007)(6636002)(52116002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7058;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S1XgwRkzRlouV8V69Gu3V6w7G+RBp3Xfb5xma6q9vXpXy7Ttdj3MQ2nH/psrNOThagn3Khq01MwiTJR1ezpu1139OndWWI9S5i1Q4aPWarugd9DxqbwMriW5EgBHf1urKfHBB+OI4nCEm6Qkw44XATt+RP4QpKkpHlFaox36UC06UYt/mFZOUNhWSqxlo3Xc9g/EhM4wAhHOr6rC9zzuHhPO3Sc7b1aUv/7avIyPDbOxvXkuCuKLCfSAnHf3XpdG77UoypBlf2i8VDCvNKiKfqXyoQu49ALQZjUDhfcJKrKSdVxSTHP6IkcvVTQJRQHA1mo5QIqbvoIjc5M6mpBQvBOg++PBmhdz0j3VD27UQxNVghzkc7aARHDgbeDu+08y0Qunem6k8A5QcLoyF1QnP7//lcKWkGnBlcx4fWjImT+FNhFCvNUduTc0EBbW876M
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44863b37-9d58-4c98-9a6b-08d768208b5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 10:02:09.3089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b2/9ycAprkbjI0u5Yc06x6em55H9BgX8hdKwV0PPx+ackqJA637nBwBTwcdQtjAwB6AkgRnSwTC69OlVJl9R8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

It is ok to use relaxed api here, no need to use stronger readl/writel

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

