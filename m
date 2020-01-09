Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B93C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D701B20673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YwbyEoxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgAIJv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:51:59 -0500
Received: from mail-eopbgr150077.outbound.protection.outlook.com ([40.107.15.77]:26668
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729170AbgAIJv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:51:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkMfifWn6iT/RU0PzTYyz258TlCyQwn0ji4MegNu2rd2nlR2NxXdVm7a4y+8FOJMuEFiyIb63GQHo6UyzDkefxTKQlv1djuJlHdGJ/OuyyaWtM1zy2btNEw4hXl/I249FsVghZ7DZwu/rDGbNpHDESDl0zixUC6W3gvQfFy/qGYNdg3Myw5gS8iyk8tyKq1aTxZMw6Yno2Ef+o0rap8vy2xTqE3X62IARTNhITzy/wKEoS141sW+2AYeLAxXqFAiBUF0AJ3EgDhPMhVkNR5zSIPJ0WYCDzylOWgxPsWWb5P6Qs991/GIomtaw4op2+h7IE58OzrA20+NC+rHrhabFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Cf1zCLId+N9/Ou4et2vAH1Xuiq6AnPLT30Ercj9LOE=;
 b=Oel0XLf+tNIBCaedtAwIMTV0wJgDzrf/phnHKnmrjCMIkWLz1u6PNsS0hRgKtwriqfPhXufYbpmR549GGfk82zM3cZwEtT0AreeINIe0Sv0IKDERdZJ0jA+lT5VleXecr+/cWzQr0aqAvVu634ckxPQD6ClNHGc0EXt15h2HxJ4e3mobw8xRnrubLMpAvToGZ7RtKZUvKQOmMepEnWB0hQmsB+Ld591HK9Tk85nIh0xJPoQJT0AKc6Df9bewL6xIkVyTPk9EIccqp0suLSpAJ9op+B+EV/JcGdAYNEzy60FBbOyugMZ3YOB5WauL15jQyC4NKKokd+v7lMrk/JWg1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Cf1zCLId+N9/Ou4et2vAH1Xuiq6AnPLT30Ercj9LOE=;
 b=YwbyEoxtMLGAolplTD53TF8XubRAiHpP2lW8Q/mLbv6pkbbPtAJbXk1SkZwS+TuG46dgQJrWF54DkPrd+zq5wPUFkDjpuowZ8VmDwizQwmcjn6KarlznShsrpg/aN94k6ltlLYNywqZZFYcnp2zD+UubWmsTGEcKtjA5fdip6ig=
Received: from VI1PR04MB4496.eurprd04.prod.outlook.com (20.177.54.92) by
 VI1PR04MB6878.eurprd04.prod.outlook.com (52.133.244.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 9 Jan 2020 09:51:55 +0000
Received: from VI1PR04MB4496.eurprd04.prod.outlook.com
 ([fe80::25c7:9207:684a:5e2b]) by VI1PR04MB4496.eurprd04.prod.outlook.com
 ([fe80::25c7:9207:684a:5e2b%6]) with mapi id 15.20.2623.010; Thu, 9 Jan 2020
 09:51:55 +0000
Received: from localhost.localdomain (119.31.174.67) by HK2PR02CA0172.apcprd02.prod.outlook.com (2603:1096:201:1f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2602.12 via Frontend Transport; Thu, 9 Jan 2020 09:51:49 +0000
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
Subject: [PATCH 1/4] clk: imx: composite-8m: add imx8m_clk_hw_core_composite
Thread-Topic: [PATCH 1/4] clk: imx: composite-8m: add
 imx8m_clk_hw_core_composite
Thread-Index: AQHVxtJtEmvfMffSOkGVxP8XepIuvA==
Date:   Thu, 9 Jan 2020 09:51:55 +0000
Message-ID: <1578563269-32710-2-git-send-email-peng.fan@nxp.com>
References: <1578563269-32710-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1578563269-32710-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To VI1PR04MB4496.eurprd04.prod.outlook.com
 (2603:10a6:803:69::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab077a2c-971d-4998-95a2-08d794e98f6c
x-ms-traffictypediagnostic: VI1PR04MB6878:|VI1PR04MB6878:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB687835693C075A874D174C9C88390@VI1PR04MB6878.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(189003)(199004)(6486002)(26005)(4326008)(54906003)(69590400006)(36756003)(6636002)(71200400001)(6506007)(110136005)(52116002)(478600001)(8936002)(6512007)(316002)(16526019)(186003)(86362001)(6666004)(2616005)(956004)(44832011)(66946007)(66556008)(5660300002)(66446008)(64756008)(2906002)(8676002)(81166006)(66476007)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6878;H:VI1PR04MB4496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eOSu1OnozzUUGIB+O9P4ojWAtUU1W/P9la0lDjzFvWhrzUjJzyWF0FmIZtMw1EFF3dDj2PbPYBZd8vBwXDaPf5m6X8nD70cDq4ZCSphyLLkkC1r5smUCQX08ToUc162Gbfv5ZfwfhbPs7ouKN1ipwbnmH2hvPRi/cBvECayKFxn76ZXn4axMo8IgpYbrHKEhVl6pF0iInvNDuNphmHjgK6BTrCgc6m4znYmsragljj13obq/tBjwnlgppzu5QFPPXwcjSbRiB9K7JH/hZrErY2h4kbnoCkwMvL4Wce4rxUST748xNJfbenDXpEGhKcaaeUy1wYnUyx+QpQVEwxqwwkW0Bkh3lsMg5SZmb0pulKL124rXOYl6pvZ+iXOaTasCXg0Rs7QjW6kZmte96phx7rmLmcm44kWYhczOAgZqGoATakDCGWvXA5D68/KQUZJe2nHavgzKURLPLHXVIt5FYgVHAN05NSOvjOPDiaSsZBmJxUAcuCmZbmTIQePJxGvi
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab077a2c-971d-4998-95a2-08d794e98f6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 09:51:55.3321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOFzTUgSMFeEISOhI6pjMhJq2f3TnlLf8kXBPL4qKWNHgRETDx+L3VZDaz4gABBO9L37lbIkkv7fovFemDTFUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6878
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There are several clock slices, current composite code
only support bus/ip clock slices, it could not support core
slice.

So introduce a new API imx8m_clk_hw_core_composite to support
core slice. To core slice, post divider with 3 bits width and
no pre divider. Other fields are same as bus/ip slices.

Add a flag IMX_COMPOSITE_CORE for the usecase.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-8m.c | 18 ++++++++++++++----
 drivers/clk/imx/clk.h              | 12 ++++++++++--
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-compo=
site-8m.c
index 20f7c91c03d2..4869c16376bf 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -15,6 +15,7 @@
 #define PCG_PREDIV_MAX		8
=20
 #define PCG_DIV_SHIFT		0
+#define PCG_CORE_DIV_WIDTH	3
 #define PCG_DIV_WIDTH		6
 #define PCG_DIV_MAX		64
=20
@@ -126,6 +127,7 @@ static const struct clk_ops imx8m_clk_composite_divider=
_ops =3D {
 struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 					const char * const *parent_names,
 					int num_parents, void __iomem *reg,
+					u32 composite_flags,
 					unsigned long flags)
 {
 	struct clk_hw *hw =3D ERR_PTR(-ENOMEM), *mux_hw;
@@ -133,6 +135,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char =
*name,
 	struct clk_divider *div =3D NULL;
 	struct clk_gate *gate =3D NULL;
 	struct clk_mux *mux =3D NULL;
+	const struct clk_ops *divider_ops;
=20
 	mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);
 	if (!mux)
@@ -150,8 +153,16 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char=
 *name,
=20
 	div_hw =3D &div->hw;
 	div->reg =3D reg;
-	div->shift =3D PCG_PREDIV_SHIFT;
-	div->width =3D PCG_PREDIV_WIDTH;
+	if (composite_flags & IMX_COMPOSITE_CORE) {
+		div->shift =3D PCG_DIV_SHIFT;
+		div->width =3D PCG_CORE_DIV_WIDTH;
+		divider_ops =3D &clk_divider_ops;
+	} else {
+		div->shift =3D PCG_PREDIV_SHIFT;
+		div->width =3D PCG_PREDIV_WIDTH;
+		divider_ops =3D &imx8m_clk_composite_divider_ops;
+	}
+
 	div->lock =3D &imx_ccm_lock;
 	div->flags =3D CLK_DIVIDER_ROUND_CLOSEST;
=20
@@ -166,8 +177,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char =
*name,
=20
 	hw =3D clk_hw_register_composite(NULL, name, parent_names, num_parents,
 			mux_hw, &clk_mux_ops, div_hw,
-			&imx8m_clk_composite_divider_ops,
-			gate_hw, &clk_gate_ops, flags);
+			divider_ops, gate_hw, &clk_gate_ops, flags);
 	if (IS_ERR(hw))
 		goto fail;
=20
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index ea84d2993b57..a74a409724e7 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -483,20 +483,28 @@ struct clk_hw *imx_clk_hw_cpu(const char *name, const=
 char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
=20
+#define IMX_COMPOSITE_CORE	BIT(0)
+
 struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 					    const char * const *parent_names,
 					    int num_parents,
 					    void __iomem *reg,
+					    u32 composite_flags,
 					    unsigned long flags);
=20
+#define imx8m_clk_hw_core_composite(name, parent_names, reg)	\
+	imx8m_clk_hw_composite_flags(name, parent_names, \
+			ARRAY_SIZE(parent_names), reg, \
+			IMX_COMPOSITE_CORE, 0)
+
 #define imx8m_clk_composite_flags(name, parent_names, num_parents, reg, \
 				  flags) \
 	to_clk(imx8m_clk_hw_composite_flags(name, parent_names, \
-				num_parents, reg, flags))
+				num_parents, reg, 0, flags))
=20
 #define __imx8m_clk_hw_composite(name, parent_names, reg, flags) \
 	imx8m_clk_hw_composite_flags(name, parent_names, \
-		ARRAY_SIZE(parent_names), reg, \
+		ARRAY_SIZE(parent_names), reg, 0, \
 		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
=20
 #define __imx8m_clk_composite(name, parent_names, reg, flags) \
--=20
2.16.4

