Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A701DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C972082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kpIjcnxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKSJEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:04:55 -0500
Received: from mail-eopbgr00057.outbound.protection.outlook.com ([40.107.0.57]:31630
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbfKSJEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:04:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agv80Ej+H/+4r8bZSHODp+AuH8WrnRPLo2ZBA0X9GzBYYu8B8fqE/hU4lChYCR5XGba7HMSyz2CqCoQ4sal1IFR9v+AQ2rYEqeD6rBmc+xnZxbZw8FCz5uRSZ3t+SZ50P5yvmC1mvr9kGJ+9Mhrkvf6f4E35toEk+v1lV6Zx+7D/u4ACx26+si1YwYUssZi7EkxuZGj7pGcw85OBUt5r9e9xwpAFs3TvgyTIEV61saqrW2uLWSoqR2krKwp2QvVO+74fUruy3nQHNVHkL6H4JJnc6uMPiDz7fu0Wo2hHbwzxXaXQWZKNszZsebu1HSUqx39QBUwMwkbjQsCl90GTDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=127ZqZr3yibLEGADIDwdS92koh1Pj0RZ3R7B7s2PvMA=;
 b=mVeU+z1cSDIdM0GFBWZ5ELtOMwEI6YBk/KX/TdtVw+KbxyWK/27Xm3t3J+MnA7nmVFCv0fj0Rh+my6jvdYCh9lG9OLgRMnsyUMvQeKwXe7PtB1RS9ahlxS7KX3GymwLdNq4JBT1ffzygoMqM74ZCBX4YKx7ha2sFPZG/H06s+YkXd+P9a1XY9yzWoKg1mP5zcfjpWxPNcWK4xnllWk6HSxIqUS55yNmFNX3qXU/B/8xJAWGho5esHyVwawUFERjVhGcDEPQ/8Y01Plg5xt9wgngQ650UPuEncR5/uP1+8dwKlvRfivmLIoC2qqAdzeUDHjkCjvHNvxspoJ5ch0REQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=127ZqZr3yibLEGADIDwdS92koh1Pj0RZ3R7B7s2PvMA=;
 b=kpIjcnxjS0MEADFiteZ3l4wxQwQW9od8NSWliCn9SzQFgcyQKiWGiyWrXYwb8BnolKqqMLW/HdIQCx5MSZo7+/m/reSCJczn+sEZucM6RgRuOt4maH7ccSWzVUVnyGAZ73LzLmLwrQmg86ZVo5Vb6d/rNbNmvUR7WRNaJxDQfBA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4259.eurprd04.prod.outlook.com (52.134.126.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Tue, 19 Nov 2019 09:04:51 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 09:04:51 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/4] clk: imx: Remove __init for imx_obtain_fixed_clk_hw()
 API
Thread-Topic: [PATCH V3 1/4] clk: imx: Remove __init for
 imx_obtain_fixed_clk_hw() API
Thread-Index: AQHVnrhmTIfoGE/++UWTDwoewNvIZQ==
Date:   Tue, 19 Nov 2019 09:04:51 +0000
Message-ID: <1574154146-8818-2-git-send-email-peng.fan@nxp.com>
References: <1574154146-8818-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1574154146-8818-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0052.apcprd03.prod.outlook.com
 (2603:1096:203:52::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df7bc0d3-d02a-4a9c-4feb-08d76ccf890f
x-ms-traffictypediagnostic: AM0PR04MB4259:|AM0PR04MB4259:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4259F52A9D69F6FCCEC08AF6884C0@AM0PR04MB4259.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(189003)(199004)(486006)(76176011)(54906003)(36756003)(6512007)(6486002)(52116002)(6506007)(2201001)(64756008)(66556008)(66476007)(476003)(66446008)(386003)(25786009)(50226002)(2501003)(110136005)(4326008)(2906002)(316002)(6116002)(3846002)(44832011)(8936002)(6436002)(66066001)(71190400001)(71200400001)(11346002)(446003)(99286004)(256004)(186003)(14454004)(305945005)(86362001)(7736002)(2616005)(478600001)(5660300002)(8676002)(81166006)(81156014)(6636002)(4744005)(102836004)(66946007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4259;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6U7q/8+dRDkVBQZfH4sxTCk3km6GyrwgEv6tIoNeJeLHZbj3RHcV4phabtt4anNDu3o67kMvN/6O3jP0IF5ocRoome7oAADM+Q4trH4s5abSo0LrZGTr+Rj8i8YiXwUd0y60Pw/QU8Fww2+GujghPA3rNQjoy1VNPTM4/0zeiUkwnXUp3inESZ6qBOYcOABsnk8icKPW6F1YO7fBNFMrwxEHxsEL77NCkCDnyQgtjt0AvuaNTGlKTbpeL1e1Hm3izEnM3XR0V5zHJVWP1XK5vftaH0xuQ8daxtnrmFyhlJmq44Cv+If2Isr+Mc9ZsLDmiAMxcqOqSIOeN3ECcNPaoKRi6nHmqLeEE/D3Uu4bxhTg9CgP0y1zOr6U6jeIDjr5ADLFZUy9IanDDmkYSERdOP7B2IgJpsAQ2T7aLKfDLawc/btGS/3Jdxgslv49UMpI
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7bc0d3-d02a-4a9c-4feb-08d76ccf890f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 09:04:51.3224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+FojUHoQptSQ6vwBHin/QB9sEKmunbSpRAZtX4SemyO/4LELwr8awIx14MQzMNqkQIwflPhUzilyGaRgb2uug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Some of i.MX SoCs' clock driver will use platform driver model,
and they need to call imx_obtain_fixed_clk_hw() API, so
imx_obtain_fixed_clk_hw() API should NOT be in .init section.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index d0ce29f2c417..87ab8db3d282 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -102,8 +102,8 @@ struct clk_hw * __init imx_obtain_fixed_clock_hw(
 	return __clk_get_hw(clk);
 }
=20
-struct clk_hw * __init imx_obtain_fixed_clk_hw(struct device_node *np,
-					       const char *name)
+struct clk_hw * imx_obtain_fixed_clk_hw(struct device_node *np,
+					const char *name)
 {
 	struct clk *clk;
=20
--=20
2.16.4

