Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FEACA9EDB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9081121929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jG161WRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387869AbfKEHVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 02:21:12 -0500
Received: from mail-eopbgr150040.outbound.protection.outlook.com ([40.107.15.40]:13100
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387484AbfKEHVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 02:21:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXiXCy7JD9DKbj41pBrfQ28alYxk80Xt4VKI9nG65Ea9Kp14PvjWGW4523GQ2LUxScfS7oZ0zDQQxkdmkcFgeZPc36h+jNbUH+7tsHbSjOTCi54O2HRCIxFMbBhP1n7JdnFPy8/C0JHUgILi+ilXc/uOcSy1C3WsV4GJt4JIbicC6+P1dgninlJSxXx5oDcpf+1fB8QJRGEBPTAOSgS6Fh2DW0NPL/XGs4x7y+cppSJU5K/19i8ErzJsKsv4rTFGOXINzx9sOEQUtUGka5/bGmsbwsK6ZzM226JyRHAZdA2HqgQHBoGVFh9E0vPmQpU7hDb1Di4+J3j1tt4906z4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg0VOfmyRVkQU2nDPkCCMCeqPGGYcOrVpqW1PWLizG8=;
 b=Rezp3SIcGRlq8t9Hkw4bb68345+lZ7xXZrKhlGgDTBNuh8h+s6usFt6SpPCRYlLfZG2BO+oDt+NM4a0K/5DhRpgQR7DCO6YODsHTdlafyC1VHurt58uYTHaLHmJFOfHAXUBSC5S9D0kzeoLngLO5bjOC+WnJDYXMcgosDhqklEueIVAbV6op8cZcdXd9N46FG7iX3MeDi6bOZYH/7unja39HjxL0Mdfd2pB0jM2vJWkLzR4nu5T+QeSOWBPWDYiZeBHNoig8BcBB5q+fU6dvcA4xu/UebKuTrob0/+lkkQAwivMM0Fae0WSPRh9KULzctB4PSi1CmnTtvUhTqvb4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg0VOfmyRVkQU2nDPkCCMCeqPGGYcOrVpqW1PWLizG8=;
 b=jG161WRXUYi4oBaImT+CZQ/LP+/kPXcaGLizY66g4REc88HIpcCm58SRbVXaJbQzUuhuoTjCswzst1+Bw9rfVZYnk4TIr8DlfUinvL+64RWn/2JhP9gW9MH2NmeOiISAIVpi77ykhtvMArq//PmDd1ACTJiH3DMmUM+E17XXuPo=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5668.eurprd04.prod.outlook.com (20.178.202.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 07:21:08 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 07:21:08 +0000
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
Subject: [PATCH] clk: imx: pll14xx: initialize flags to 0
Thread-Topic: [PATCH] clk: imx: pll14xx: initialize flags to 0
Thread-Index: AQHVk6mXpyRie0JbfEaM7Eg+PLW60Q==
Date:   Tue, 5 Nov 2019 07:21:08 +0000
Message-ID: <1572938372-7006-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::27) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b85e1df4-3c68-400b-4b2f-08d761c0ba2a
x-ms-traffictypediagnostic: AM0PR04MB5668:|AM0PR04MB5668:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5668043D5AA829C1C874BFDD887E0@AM0PR04MB5668.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:576;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(199004)(189003)(66556008)(6486002)(66476007)(5660300002)(25786009)(3846002)(6116002)(316002)(2616005)(186003)(476003)(26005)(2201001)(52116002)(2906002)(7736002)(305945005)(99286004)(8936002)(50226002)(110136005)(4744005)(44832011)(54906003)(86362001)(486006)(64756008)(66446008)(2501003)(66066001)(256004)(6636002)(81166006)(81156014)(102836004)(4326008)(8676002)(6436002)(478600001)(36756003)(14454004)(71200400001)(386003)(6506007)(71190400001)(66946007)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5668;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0WvJlG0hvf9BAwubKE9CNCLUt54s6IfV6u9tPlMKDeigHLGx5/5Th53R66Kx8JlF31VgM1I8V/blJAaWaauwr+va+psQTB9ug2rE1ZgLRD7hxh0CTbxs90WAPuRfBfmSAFGzX36TQAumIejw0hhd1AFVAt4TkAP0Or0gx/s8Hnai/llUfMNlw3LLyvK9YDfG+LdFNp79q2fOWUlD520yT5B/oMZ1rzLkpz6PKUr+hGPPhUkdhkJiLq/ZRhRHJEktxDKWmIYz3IyDmSFuetZl09QGDphGy9+vKHzyltS3oivupG0ZlqEm/VLqDSLMq0Y5LVTSCZ6d5oG2RRveTyQTSnfKEatth8aohdmFdn/3m+dXBdLY0YIafWqb1jm0NRdrKktv8gXphSVWB4mcqNc44HqcsYgQ7chL3aiRlqKSGH0EqTPLBcYPPncNoN7JqxuE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85e1df4-3c68-400b-4b2f-08d761c0ba2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 07:21:08.5461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wg5T5xGuYOoycXU1D7f7yOrI1e80SPN3Zl9Pq6IdbopNrlbYMmxjOEIEg/CTep0k2vCEBU28LMmYgFzFuS7SVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5668
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

init.flags is initialized with value from pll_clk->flags, however
imx_1443x_pll and imx_1416x_pll are not static structure, so flags
might be random value. So let's initialize flags as 0 now.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pll14xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index fa76e04251c4..a7f1c1abe664 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -65,12 +65,14 @@ struct imx_pll14xx_clk imx_1443x_pll =3D {
 	.type =3D PLL_1443X,
 	.rate_table =3D imx_pll1443x_tbl,
 	.rate_count =3D ARRAY_SIZE(imx_pll1443x_tbl),
+	.flags =3D 0,
 };
=20
 struct imx_pll14xx_clk imx_1416x_pll =3D {
 	.type =3D PLL_1416X,
 	.rate_table =3D imx_pll1416x_tbl,
 	.rate_count =3D ARRAY_SIZE(imx_pll1416x_tbl),
+	.flags =3D 0,
 };
=20
 static const struct imx_pll14xx_rate_table *imx_get_pll_settings(
--=20
2.16.4

