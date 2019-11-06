Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C8CC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9CA21872
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OPeesbwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfKFFbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 00:31:19 -0500
Received: from mail-eopbgr30067.outbound.protection.outlook.com ([40.107.3.67]:7806
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbfKFFbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 00:31:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QG02v5zmFF6aHwB6YuDJlFVyym3QH5DNIls0KRZjBeDR7rnyMRbG9tZzh7DrEJo2EUR2eEf9vFkUO6FbHVaQYDUGsABa8gd8Nt8YSxADBflVwCeSQzVOOpRzvHlXv+TVgLLzBfRmNz9VRUxUQtR4ho9t2cRyB9lMSkTN7epHiXQb0J1TP/EI/RhftvGtzbM9vvZv2LaxWr3V5Ksw8lvBVDGro7QCry2XCxJtw5QAhoQZJSWMC19ozqhrGFvLP4BFCuAy3slqpke2lgc9tH4EP5LOVW7jmO4LVn4jOzqpAkgRko4Q+KuI9u6POwE10r0/rjD0SO9l3UVPOsfU4wGwmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZILj+/RNXyvglyWPuYnjTqv8mXOrESz3yqO60rK9YU=;
 b=jb3VAizod0Yjrge6yjYgPlxYEkCzI3Wed6oA4d0dOhOI4Wa7/Kytx3jrY2QbdZaxACa34VjQ8hrqR3kRCjptunhE/a5OJCnE2W5m+yPfJk4qYOioa6qzfJDcDxP7M/5M9/YrXR/daSqkysZKCyjUpDy/EFP7quDg1hz7KrXEflPORDHwFVNvJytMRUbY0JhqBytBF7lAOGk3BTSLMnXZKsSK5v3e0XSfcyFUPrta5WjlJ1ula81lPcA4ojoAYOU7Uk1AFYotirEgenoq40ZNFSUY92uo7R7+CC81BEuUFJr6+3bOyQLQo/NdIUuPuRnG9A27tafZLLrUs380xC9flw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZILj+/RNXyvglyWPuYnjTqv8mXOrESz3yqO60rK9YU=;
 b=OPeesbwvxlE5xhrpV0qVPvJuz+HjzFsnGAOKx6gtN8Y9eqtt2p2ha7/2ULPJvh/I11jl05MzcR8iBoqdF2Udpiw9Zl2BgGx39piYLKAdy0mgEKxbga5DGNQYEcEcvpp8tng5XmTMVzgnvlu8AkH/JPW29B8/gucvwj3C1qYsswA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5009.eurprd04.prod.outlook.com (20.176.215.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 05:31:15 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 05:31:15 +0000
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
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: pll14xx: fix clk_pll14xx_wait_lock
Thread-Topic: [PATCH] clk: imx: pll14xx: fix clk_pll14xx_wait_lock
Thread-Index: AQHVlGNoepC2TDBj7kaCYRyt+h3yDw==
Date:   Wed, 6 Nov 2019 05:31:15 +0000
Message-ID: <1573018178-14939-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:36::15) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0dd6f3c3-ebe6-4980-6f4c-08d7627a8a99
x-ms-traffictypediagnostic: AM0PR04MB5009:|AM0PR04MB5009:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB50099577F705688A5CDF72D288790@AM0PR04MB5009.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(199004)(189003)(81156014)(81166006)(99286004)(486006)(476003)(14454004)(6486002)(25786009)(186003)(44832011)(316002)(52116002)(102836004)(6506007)(386003)(8676002)(6116002)(26005)(8936002)(50226002)(7736002)(4744005)(5660300002)(54906003)(71200400001)(4326008)(71190400001)(86362001)(66946007)(305945005)(2616005)(66446008)(3846002)(110136005)(14444005)(256004)(2906002)(478600001)(6436002)(2501003)(66066001)(36756003)(2201001)(6636002)(64756008)(6512007)(66556008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5009;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Utzgprxqyh2MO6z6fhlqWnzg8SI3nRTHcw8b24BXaEnr3Y9/xi6V0Dq5iYFcfNpkwpae7nk7mAF2r7jM87xEfn2ok4ETxLSH7k+U52jb5Bgo6WujYxSL5F7ib4xEDs+a4Vn+aIYNcBLREF0/LqScEVbXMoDEGUnM/XkSfjs4HPkEF0k3+iwKsX+lVdIiFgLYliF0yDiTES8rvQ2086DyEtRigzj0PyYOjCtIJ5ElGPyKXcoXoU7Eztkc5pB5k0a68jN9sL4ZSlqpgb+dFN7YWwE97226S1iQN5+Pzjkaoxd4kUxioEQpBmp5Hccdhkoyp8U35zFueA7Zg7gMwcBIVO1wj2AcuwTUzcXJJff9Ip/qdgGWJ/wPvZtvpaKs8Y4JEgXUV4t0QghFwEtEnl9otnj4GfuLmR4PHemxxEg557s2qJPMvZTLgkzMDyXCs6YH
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd6f3c3-ebe6-4980-6f4c-08d7627a8a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 05:31:15.0905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9uRsrAfBUQ5n2bsdJ2N81KoqLe1Rj4Cddumn6zHnp9kR/B+a1MHvCOZkUIrztTR/ke53MUT2RXPXNV5r7VRG3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The usage of readl_poll_timeout is wrong, the cond should be
"val & LOCK_STATUS" not "val & LOCK_TIMEOUT_US".

Fixes: 8646d4dcc7fb ("clk: imx: Add PLLs driver for imx8mm soc")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 Hi Shawn,
   This patch is made based on 5.4-rc6, not your for-next branch,
   not sure whether this patch could catch 5.4 release.

 drivers/clk/imx/clk-pll14xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 7a815ec76aa5..d43b4a3c0de8 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -153,7 +153,7 @@ static int clk_pll14xx_wait_lock(struct clk_pll14xx *pl=
l)
 {
 	u32 val;
=20
-	return readl_poll_timeout(pll->base, val, val & LOCK_TIMEOUT_US, 0,
+	return readl_poll_timeout(pll->base, val, val & LOCK_STATUS, 0,
 			LOCK_TIMEOUT_US);
 }
=20
--=20
2.16.4

