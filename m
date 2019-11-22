Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB6FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097D520637
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HjBq0jeZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfKVKsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:48:31 -0500
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:28323
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729923AbfKVKs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:48:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNjoN2JRhtOIhAQsCzxKg6H0PE+Ob9vAv98Rby1RK6DmUqaEsUSNAuW66VNFAnZlCo7EwzYdYBIdmtjlePIv/HwCLOwNrkSsy3IUal1rPZLuREG25lEV3XxexUfUOFu1zmPB9IkvdbJHUCw7BFRyr8rpzOQhwrbb+iDn56VbXapqRinGx4yx3WXUWYCrldjRkAZhCgmdM9Z9ZR7isbdw+tEBzBguxQE2EAJi4VIpamdRDJxsOXxDmpRcHeFUs2NpIVEj9W9+kcfsKEXujgkKEH0XHpbxCc6/1Qf5HmNFNBkMbRmGiP08Amd+sDICGj1nfln3QXn0QCZRTEwTCDXTww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VR84e7KeizBu3qE+oCsthNWfYlpyMuz9oFUWH4kVzZA=;
 b=Y+ohO4H9N94nVTWI+t5On/iC0J9GkIlZCu89Zvo9E1rAl/jdVbd5O+Mq5XPJ+UoMAfwFxmAAkL+xpbMrmm93umTlGVEH1d3+idyLQkTsKyhLobdbsQpGUNRMLH0gNW+Ul3qFi57tbbYd7bovwnZTe8SFltPjdkWI22R0klSMt2U03slJebXxPDamXlx12IzuDxCYHZl1voXAaJXGtlegOKKDCWk3DJMNFKmfoStKb2io9tG/fDM7mdL52c43Iism6r01EaLSX1xoCJ3LOHM6sfr5SPMv8Pn4pyEZPy1jMXbTuVCjROe/Ncw8wUmcHFt0+ijKNbK/6XBAqcL7cmL1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VR84e7KeizBu3qE+oCsthNWfYlpyMuz9oFUWH4kVzZA=;
 b=HjBq0jeZ6owFjZRUBBwnWirk9qPgVd/CyO9RuIGEZfG1rTyYmuepKQfUDNgytalfM91HJK+Vlb1aFFB0t/RWWGF1tG2RWDP6OoRFvF6MK2X56jZ6GDL6hGBfNDTcK7DK8ItfCyYhlPUThKu3c8Dznibvj1YFv6qrwQeJexFEJgs=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5074.eurprd04.prod.outlook.com (20.177.42.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 22 Nov 2019 10:48:15 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 10:48:15 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>
CC:     Peng Fan <peng.fan@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 05/11] clk: imx: pllv2: Switch to clk_hw based API
Thread-Topic: [PATCH v2 05/11] clk: imx: pllv2: Switch to clk_hw based API
Thread-Index: AQHVoSJXaTujkjS7KUGyJEkLCMUF0g==
Date:   Fri, 22 Nov 2019 10:48:14 +0000
Message-ID: <1574419679-3813-6-git-send-email-abel.vesa@nxp.com>
References: <1574419679-3813-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1574419679-3813-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0020.eurprd04.prod.outlook.com
 (2603:10a6:208:15::33) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.7.4
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15b2f7ec-1bdd-4624-65d2-08d76f397a09
x-ms-traffictypediagnostic: AM0PR04MB5074:|AM0PR04MB5074:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5074A7461C76CCAD79CB6F73F6490@AM0PR04MB5074.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(478600001)(256004)(6506007)(54906003)(7736002)(305945005)(316002)(71200400001)(5660300002)(110136005)(102836004)(186003)(86362001)(66066001)(71190400001)(2906002)(4326008)(76176011)(99286004)(36756003)(26005)(52116002)(386003)(8936002)(3846002)(2616005)(446003)(44832011)(11346002)(66556008)(66476007)(66446008)(64756008)(6486002)(66946007)(6436002)(81166006)(8676002)(81156014)(6636002)(6512007)(25786009)(14454004)(50226002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5074;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pPREQRbxzcPs5v4QI9kbAgLLYbOWyU4qBCFFNtkpNyHs2AQP0iv7gAhwAyY5B+hzIpPWyWtnw7W8kaey6Zs+b1kLZ7X7iUgdltDek9oHDFsKPtvexnL+YGiOAteqmYUT1tE7VwUnhMpOLJvfu0RVGv86WJGPpUXpl7lkUxNKf52R+k7tt0jO0Y0uAntxnaVOAKfTpURG0GQtDsrSOdHg5Vm9kLy89QaCNbiQtIiaDAXfYnF8HYT66KPh+9FV8tPwtelr0PIqahcFmcCt7e2wMCT3gUSSUlUsiSgYwqesw1oEBZwbBJjCGF+1C/iixesJFkeRDLoxDDBCgoUsw+gRE1T6y6uLBS/Z2GHYHBtMk5uKiMqkrnzmiTOVtxdFs7qeWkqy9rjwBQ48Q1SFeL4uu9qBv2GlnnTxZIhURRzj0KPWUTaP9JY1sfbnxSvlezlY
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b2f7ec-1bdd-4624-65d2-08d76f397a09
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 10:48:14.8799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4IBBOmMecMZyckNZXJS0tHN2hL6uoBh9e3m1MfGMHFDVuaTQ1Hq+AjQ03jGVe+JV1yUNgkMo9Bhvl8aC7A2oCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the imx_clk_pllv2 register function to clk_hw based API, rename
accordingly and add a macro for clk based legacy. This allows us to
move closer to a clear split between consumer and provider clk APIs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pllv2.c | 14 +++++++++-----
 drivers/clk/imx/clk.h       |  5 ++++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-pllv2.c b/drivers/clk/imx/clk-pllv2.c
index eeba3cb..ff17f06 100644
--- a/drivers/clk/imx/clk-pllv2.c
+++ b/drivers/clk/imx/clk-pllv2.c
@@ -239,12 +239,13 @@ static const struct clk_ops clk_pllv2_ops =3D {
 	.set_rate =3D clk_pllv2_set_rate,
 };
=20
-struct clk *imx_clk_pllv2(const char *name, const char *parent,
+struct clk_hw *imx_clk_hw_pllv2(const char *name, const char *parent,
 		void __iomem *base)
 {
 	struct clk_pllv2 *pll;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
=20
 	pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
 	if (!pll)
@@ -259,10 +260,13 @@ struct clk *imx_clk_pllv2(const char *name, const cha=
r *parent,
 	init.num_parents =3D 1;
=20
 	pll->hw.init =3D &init;
+	hw =3D &pll->hw;
=20
-	clk =3D clk_register(NULL, &pll->hw);
-	if (IS_ERR(clk))
+	ret =3D clk_hw_register(NULL, hw);
+	if (ret) {
 		kfree(pll);
+		return ERR_PTR(ret);
+	}
=20
-	return clk;
+	return hw;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index bd6a592..331f5ab 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -112,13 +112,16 @@ extern struct imx_pll14xx_clk imx_1443x_pll;
 #define imx_clk_pllv1(type, name, parent, base) \
 	to_clk(imx_clk_hw_pllv1(type, name, parent, base))
=20
+#define imx_clk_pllv2(name, parent, base) \
+	to_clk(imx_clk_hw_pllv2(name, parent, base))
+
 struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
=20
 struct clk_hw *imx_clk_hw_pllv1(enum imx_pllv1_type type, const char *name=
,
 		const char *parent, void __iomem *base);
=20
-struct clk *imx_clk_pllv2(const char *name, const char *parent,
+struct clk_hw *imx_clk_hw_pllv2(const char *name, const char *parent,
 		void __iomem *base);
=20
 struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
--=20
2.7.4

