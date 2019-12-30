Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02D2C2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9666B2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LSyCUQFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfL3JNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 04:13:11 -0500
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:20292
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727267AbfL3JNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 04:13:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UC9bbGqxIq3XQdK7+NQzxboOzExW3nPk0VA6AWuhSpILHi0TVmEubKidQmIdGkA40fDy0NO25siT0ZuUNh1G6iH/Y/tKuWUZW4gywIPiDATR7xoRPzG2ePiXa1VDsSydllqoA2pllorVMmj6T+SCrg4151sQG3goyJwQCog3z7GqVZNrZvyXNPsZwOMkzrB2B6i1ZtSsmiJfP4uQIfaw45RYQxJ8OSL+yQrhZoBgdSZC/wQ3si50BTZVZMCoga5YyEqDFLQZ4S41vs8hz5B0BGUb4QCWD/L7IauuUKVyiAbMnqPy7+t9i1uk2s8jCdQIVlD90wlvKd19wn6SrZd7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVFkHVenmvTVlgAE9f+T+H3oa9SfKBL8JwiBDIAetK0=;
 b=FXvBmUEZ23L6EQ0qEYJAK1CH3wP9IW4qRLB9K+X/ZfpF8dqPTBbdFAuyHJm4UAirfcqhYVdFyITh7DWAn5RK47v7cHVf+vh9C8ksDAqhaWQdwYXZ6C/H1Vfuq1KtJSUqPuGkqJlPm4MB9QfJ9hRswt3mTg1ZNJVC4ocvI4OcYaw8bdzyo5sfa3Gz97mBE6fEB5ddv85DPprZeY8Bnog7VxMCqCBGdIXecVJHpMzbzO9pldh8fvFi9q4fCqIashpNfJIIJlTZSTGtDmnEzSD7cQ1X9F86f01XHmDJ3q0kUv3X9b1dTKMEv+nGn8ZYvP95fW+lwNwCqdochB3oTgqCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVFkHVenmvTVlgAE9f+T+H3oa9SfKBL8JwiBDIAetK0=;
 b=LSyCUQFox1QBH0AOAQsnpuWWnHfUiIvwpuu3YYSnLmrRW9Y8WrVu2DmQpxdT834UIfJp4l/3pf6909JRNKW9DrBeOny3uvvbq0IToS6BafT//w+Wi8/Dh4Tp8f1Rman1upoBVgLNlrjUX/xyYnniOHu85qovMPeLsG67bAnK8bg=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6401.eurprd04.prod.outlook.com (20.179.254.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Mon, 30 Dec 2019 09:13:06 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::c58c:e631:a110:ba58]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::c58c:e631:a110:ba58%6]) with mapi id 15.20.2581.007; Mon, 30 Dec 2019
 09:13:05 +0000
Received: from localhost.localdomain (119.31.174.67) by HK2PR03CA0057.apcprd03.prod.outlook.com (2603:1096:202:17::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2602.8 via Frontend Transport; Mon, 30 Dec 2019 09:13:01 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] clk: imx: pll14xx: introduce imx_clk_hw_pll14xx_flags
Thread-Topic: [PATCH 2/3] clk: imx: pll14xx: introduce
 imx_clk_hw_pll14xx_flags
Thread-Index: AQHVvvFYj/i+CACM7UiPThKGK48S/Q==
Date:   Mon, 30 Dec 2019 09:13:05 +0000
Message-ID: <1577696903-27870-3-git-send-email-peng.fan@nxp.com>
References: <1577696903-27870-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1577696903-27870-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0057.apcprd03.prod.outlook.com
 (2603:1096:202:17::27) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb58d679-f90a-43ae-6100-08d78d087a99
x-ms-traffictypediagnostic: AM0PR04MB6401:|AM0PR04MB6401:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB64010D86614CBFF8E734406E88270@AM0PR04MB6401.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 0267E514F9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(199004)(81166006)(81156014)(6506007)(66946007)(69590400006)(71200400001)(66476007)(66556008)(8676002)(52116002)(4326008)(66446008)(64756008)(26005)(8936002)(2616005)(110136005)(6486002)(54906003)(956004)(86362001)(6636002)(316002)(16526019)(186003)(478600001)(36756003)(5660300002)(2906002)(6512007)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6401;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IBDc10K5UAezNyDurHAcyWIEEatVxQMvfsq+JDyEsuth1jE+1oQF5m5MkTDGmGCF9tUOxuinAoI3ack2J3eTObi7LZlLs1lEGxvUJjbz1Z151OiGdHJQ9ErWzsoGeWwA5J9gsy0ImhyjzqEGzm81XvCPXmIzVHRItwNGUkztcSj/V4BJhyge7Y6TL76b4YtH2YztDEET/4hQKt3kkXhPusMhg24GQWWVdRyRGWjL/396tZaRomsCig0oIqTIDchrWGL9LfeCY94qlMGv40jFFZtm94QGJ4GGAZP2GvOd72UXqF6U5lOptCQc0s/UkANlaqm1KEGMm9X32fV555+kRZCKC7VMjnhQ5IzTryqEOMQr1k0P3Ot34ItZXbWc/ocGpbwlA6Ef3Q2EZET+m1yxlY+10lAzeT9USdGHxZK5uxuCvPKTWPL2Wtzx3iC71EIukXg+e7lWVle86U42TsY2HlYeVKRHQK/iKPFICOa8roFFqs4osLefUnDlybJGpmOK
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb58d679-f90a-43ae-6100-08d78d087a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2019 09:13:05.8887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S5vaG+g4bNOmyShHWPS94tWnW/y+HNoTbqOeYi3hjM9f3LdulSKvCVg9Cn6YBG+1fLAKVL+SryQNvRAfKehBFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6401
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

imx_clk_hw_pll14xx_flags is intended to provide flexiblity when
add flags for clks, no need to add more imx_pll14xx_clk entries
in clk-pll14xx.c.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pll14xx.c | 10 ++++++----
 drivers/clk/imx/clk.h         | 15 ++++++++++++---
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 9288b21d4d59..030159dc4884 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -378,9 +378,11 @@ static const struct clk_ops clk_pll1443x_min_ops =3D {
 	.recalc_rate	=3D clk_pll1443x_recalc_rate,
 };
=20
-struct clk_hw *imx_clk_hw_pll14xx(const char *name, const char *parent_nam=
e,
-				  void __iomem *base,
-				  const struct imx_pll14xx_clk *pll_clk)
+struct clk_hw *imx_clk_hw_pll14xx_flags(const char *name,
+					const char *parent_name,
+					void __iomem *base,
+					const struct imx_pll14xx_clk *pll_clk,
+					unsigned long flags)
 {
 	struct clk_pll14xx *pll;
 	struct clk_hw *hw;
@@ -393,7 +395,7 @@ struct clk_hw *imx_clk_hw_pll14xx(const char *name, con=
st char *parent_name,
 		return ERR_PTR(-ENOMEM);
=20
 	init.name =3D name;
-	init.flags =3D pll_clk->flags;
+	init.flags =3D pll_clk->flags | flags;
 	init.parent_names =3D &parent_name;
 	init.num_parents =3D 1;
=20
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 65d80c675aa9..35a9d294b6df 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -131,9 +131,18 @@ struct clk *imx_clk_pll14xx(const char *name, const ch=
ar *parent_name,
 #define imx_clk_pll14xx(name, parent_name, base, pll_clk) \
 	to_clk(imx_clk_hw_pll14xx(name, parent_name, base, pll_clk))
=20
-struct clk_hw *imx_clk_hw_pll14xx(const char *name, const char *parent_nam=
e,
-				  void __iomem *base,
-				  const struct imx_pll14xx_clk *pll_clk);
+struct clk_hw *imx_clk_hw_pll14xx_flags(const char *name,
+					const char *parent_name,
+					void __iomem *base,
+					const struct imx_pll14xx_clk *pll_clk,
+					unsigned long flags);
+
+static inline struct clk_hw *imx_clk_hw_pll14xx(const char *name,
+		const char *parent_name, void __iomem *base,
+		const struct imx_pll14xx_clk *pll_clk)
+{
+	return imx_clk_hw_pll14xx_flags(name, parent_name, base, pll_clk, 0);
+}
=20
 struct clk_hw *imx_clk_hw_pllv1(enum imx_pllv1_type type, const char *name=
,
 		const char *parent, void __iomem *base);
--=20
2.16.4

