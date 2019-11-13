Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8145C17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D55207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QDP3T4pN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKMH06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:26:58 -0500
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:39303
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbfKMH06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:26:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJSPqjR7qvd/FEQZ3CLK7yGxtbOUgN4YGhfoDV2GyY1noAnYTl6x/gnYe6Z2S9KfKL0Rf0B4H4EhveiR4oAimfSEB5H/UpZuWpa+IfNyG7b8eC0MX46swjWvM4eK34w7a/ztXTGax4SkqbBDsDnAQDwi05FyksRKIbubUEDbc6ClNq7x2v4ih+6LcVFf4cdddFgnYnvE2r14sdHESJ1xaBUBeEUmcRnf6MktJzRTu/6BUV9kleJlS94L+ysP8l8fycSPFocnr02lFAimImC7FBspb/94NpH6TUSGKlqvR0u7ibuMvByrgpVwOiHWYWaQh9SpxsR+EmMzSuQ6ytaHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Hxjrz5C9/VV+J9suiKHSnIvaqybT4wMv8GmdNIbsS0=;
 b=MgQyK4nm6e+/7ghZJgL7XN/Www4IGllea3ZDSK0HtfHvnCdnNWM1uPUrCfOOy/rNBi6Oez2/30dtpbJprW1OJsqt640uE8JopuOtYLkDXIp7c81r39JdVNDRWm2UGyitkxYuGZUTT02faMG52JzzIGkJWjL6ZSs8jgtaybzx5OYolUaJD63QAQ+5G74pmYynrr0tuMNLbYlxkkvVLe4auOAiPknFPQWfkVJz07V7S+iimsCwSYbj/Ltbxq1jOvZZZnBhkv1m6U2RSx+JQ/yz2gPVaR9867/xkpuYorFQqWfhbXmKrotxBjr8sid8X00kY+v2mVBdiNgIb6epfMrTvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Hxjrz5C9/VV+J9suiKHSnIvaqybT4wMv8GmdNIbsS0=;
 b=QDP3T4pNdciEM/c73+5035wjPGZO2tCElLX5jsJ5+MF5kgCzxIx+2s7wFfr6b46oWS3cI3mNcEs9N0n2tfOg65kENhmz+emIppVQXfmMHOH+QhY1Qk+nW7pZ+zTDsCoXeBKZES7skmUq8/fSJF0HclNRz7MIvp6JdORv92dY8aI=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB5260.eurprd04.prod.outlook.com (20.176.237.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Wed, 13 Nov 2019 07:26:52 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::115f:1e4f:9ceb:2a2c]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::115f:1e4f:9ceb:2a2c%7]) with mapi id 15.20.2430.028; Wed, 13 Nov 2019
 07:26:52 +0000
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
Subject: [PATCH] clk: imx: pll14xx: introduce imx_clk_hw_pll14xx_flags
Thread-Topic: [PATCH] clk: imx: pll14xx: introduce imx_clk_hw_pll14xx_flags
Thread-Index: AQHVmfO4UT5wBnIiNkiEwV6EPli0Lg==
Date:   Wed, 13 Nov 2019 07:26:52 +0000
Message-ID: <1573629896-23954-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0022.apcprd04.prod.outlook.com
 (2603:1096:203:36::34) To DB7PR04MB4490.eurprd04.prod.outlook.com
 (2603:10a6:5:36::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d96d5909-cb79-44b4-4ec1-08d7680adac5
x-ms-traffictypediagnostic: DB7PR04MB5260:|DB7PR04MB5260:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5260C3C5542559CC1416CD1688760@DB7PR04MB5260.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(199004)(189003)(102836004)(86362001)(6116002)(50226002)(7736002)(305945005)(2201001)(3846002)(486006)(2501003)(81156014)(81166006)(476003)(66476007)(8676002)(66946007)(66446008)(52116002)(386003)(66556008)(6506007)(44832011)(5660300002)(2616005)(64756008)(6636002)(2906002)(6306002)(26005)(99286004)(6436002)(478600001)(66066001)(4326008)(8936002)(966005)(14454004)(71190400001)(36756003)(256004)(6486002)(316002)(6512007)(25786009)(54906003)(110136005)(186003)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5260;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YUtVGvK5diM/qNM4YJa8JrNJF+GPnF4vWJbb88qBnVLrpaRbjVSvMpxGU/+cB44y2aNZvtQX1C8dFsy87Hf96jLbV/uIdYnbAA96cvPe2wtREGz+tfKR8aSNHXK23fEX63PZ8ELgogz/gYf3rRABtnyztcEYOzvik8Px0e3kxzKfNp+hzN26BW0QHHYQFPkwPV+snzTMDxoyAnRbt23T2XD2RI4st8CY7LsF9mnOUHFHQ1rqKqValkTU39vWGYo6HNWPs7YTZpsB3s74de33Pvxf8oomQjENMkd0TZDjn52RiOMJ8U9GXTnpNvxtfsacd17L84Z/0nQ5ZKsVbMSElPAWkkDDC3tl/xqhdQc5CaQufbTzYsPiZ4dY0LXVonLo2ci8u7Mw6Nn92A8+rCNseEOr5U0BkFz2ro+yTk3TB9LXh6jodB4gSYWZcsPZo4c+
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d96d5909-cb79-44b4-4ec1-08d7680adac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 07:26:52.7728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sJe+xM/8PWGSI6e0/66k9aPepf0rFMjfnerC7s9bqTM5OFotxYwOQJczMpftscOdV3evpcq6coRCHhiRqV1abQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5260
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Introduce imx_clk_hw_pll14xx_flags, then no need to add new
imx_pll14xx_clk variable for new flags.

Since the original imx_pll14xx_clk flags is not used, so drop it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 Based on https://patchwork.kernel.org/patch/11217889/

 drivers/clk/imx/clk-pll14xx.c | 12 +++++++++++-
 drivers/clk/imx/clk.h         |  7 ++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 2bbcfbf8081a..a8af949f0848 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -379,6 +379,16 @@ struct clk_hw *imx_clk_hw_pll14xx(const char *name, co=
nst char *parent_name,
 				  void __iomem *base,
 				  const struct imx_pll14xx_clk *pll_clk)
 {
+
+	return imx_clk_hw_pll14xx_flags(name, parent_name, base, pll_clk, 0);
+}
+
+struct clk_hw *imx_clk_hw_pll14xx_flags(const char *name,
+					const char *parent_name,
+					void __iomem *base,
+					const struct imx_pll14xx_clk *pll_clk,
+					unsigned long flags)
+{
 	struct clk_pll14xx *pll;
 	struct clk_hw *hw;
 	struct clk_init_data init;
@@ -390,7 +400,7 @@ struct clk_hw *imx_clk_hw_pll14xx(const char *name, con=
st char *parent_name,
 		return ERR_PTR(-ENOMEM);
=20
 	init.name =3D name;
-	init.flags =3D pll_clk->flags;
+	init.flags =3D flags;
 	init.parent_names =3D &parent_name;
 	init.num_parents =3D 1;
=20
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index cd92d9fdccf4..c2851a82b4fd 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -48,7 +48,6 @@ struct imx_pll14xx_clk {
 	enum imx_pll14xx_type type;
 	const struct imx_pll14xx_rate_table *rate_table;
 	int rate_count;
-	int flags;
 };
=20
 extern struct imx_pll14xx_clk imx_1416x_pll;
@@ -105,6 +104,12 @@ struct clk_hw *imx_clk_hw_pll14xx(const char *name, co=
nst char *parent_name,
 				  void __iomem *base,
 				  const struct imx_pll14xx_clk *pll_clk);
=20
+struct clk_hw *imx_clk_hw_pll14xx_flags(const char *name,
+					const char *parent_name,
+					void __iomem *base,
+					const struct imx_pll14xx_clk *pll_clk,
+					unsigned long flags);
+
 struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,
 		const char *parent, void __iomem *base);
=20
--=20
2.16.4

