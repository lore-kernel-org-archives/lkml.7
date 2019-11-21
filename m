Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF67C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50F220872
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y76hToc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKUKao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:30:44 -0500
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:14210
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726132AbfKUKao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:30:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cr515NtOlfrcRSe6QLECcfdV6/SsZquV2mBciB1XqdCu/r9JeG1ncR2i+XW+68QcgzYQ7KaqCdTMVXg2olX/VUVtFuKn5Rj3f2ZA+ogrRAA6t5w9yUdpZscvDYg+WkPS22pKJXo1ZL1iRkQqGtlXZdseqtsy2higpJtIZKr/waChOQG1luooYcEZBSfK1rtFC4wZZlv400wO3loNZHBD0d2NgQvHmG1r3/m4g0q3Y4InrsXsgIXCko4bE4pEa22BJTs0Unc9Cura/EwWKRUlrPqCxOBs3MIkuewfuEmwzw0qzCxSZVUjtkqBdZfzuLgJ6U8oUfwj1QkAvi/1kLBGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drhEai2cOWH9fRNUcjHvoKfxwqUxM2ucCjD2yABaBTw=;
 b=O35BiRDQG9zA6uuF2zZBe2OD6xVBeeTq+EedwjUe81ayVyTB9OhL0cYFhqXVdcHr9nlHa81/IUHrvksGcihPvduM1oHhG9yl1nluDZwo5CxApRTmjMSRhpYfsvBIKTdPgrkO4fYW+GNWQZZREeaPzP0dRiIW0Bfx9BfAQVFRhOJNf36ZtI/o8YGNQ2PrL3pd/7Hw3fEFq/RuHhVXfXxYbhk931igzr8ovsjrhRcHYp48QGYzcJFgfg9sYCHRelfYa9v2c4ETO4ywK5t0oSggHiYoDYQ2Rf050hbi0/ychsnwb/IyPhL6cNZLLs2+y/EsbO/nzB7xce3yVssprXmfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drhEai2cOWH9fRNUcjHvoKfxwqUxM2ucCjD2yABaBTw=;
 b=Y76hToc3SBVjxF3vul81FYoeQbpUM80jyatF11lLxCHLZni60KcA6F2Yk4AvCdb4HD3E93s5TK1pCqYrSiQzp+yIV3uodFovPA8Wjpxfyg+SVQdhjP4P2Sdb2m+cmj7GA28qb2YDnJwB8UoVonrljWJkj/c37xKgaXA6qjaX0Gs=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5554.eurprd04.prod.outlook.com (20.178.112.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Thu, 21 Nov 2019 10:30:40 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2451.031; Thu, 21 Nov 2019
 10:30:40 +0000
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
Subject: [PATCH] clk: imx: clk-composite-7ulp: add lock
Thread-Topic: [PATCH] clk: imx: clk-composite-7ulp: add lock
Thread-Index: AQHVoFa4qHyFBgWUVEOTxio+xNlL5Q==
Date:   Thu, 21 Nov 2019 10:30:39 +0000
Message-ID: <1574332142-7130-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:203:b0::26) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e5898b92-f064-4113-3809-08d76e6ddac0
x-ms-traffictypediagnostic: AM0PR04MB5554:|AM0PR04MB5554:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB55542E978F711FD250FB79A4884E0@AM0PR04MB5554.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(199004)(189003)(25786009)(36756003)(66066001)(5660300002)(14454004)(478600001)(86362001)(2906002)(14444005)(256004)(71200400001)(71190400001)(2201001)(8676002)(81156014)(81166006)(8936002)(50226002)(305945005)(7736002)(2501003)(6636002)(44832011)(6436002)(99286004)(6512007)(6486002)(4326008)(2616005)(386003)(110136005)(186003)(6506007)(3846002)(26005)(102836004)(6116002)(66476007)(66556008)(64756008)(66446008)(66946007)(52116002)(54906003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5554;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mUS2HWutZVkg1GvCogYgG9mJKqW377rU34d0dj1/31kqiTHHUJ6cL29dnWB8MiHumUR/cyI2Fpp2cMhcPPJrEgWsoCGli2MsxIcil6uOLdpN3BBcU4X02Whu6+28OSWBz5JzHe0rArFeet58tXFO5w83o0Bzv6j5AGZekmnZzstgnOhKY3Yy9R5oO/5iC46IqZFgnYMcu+rWawq+pfEBJR95E29AB5OatgIcdrNYEO9SQFplCYRxfcbSVylp1MaGV0UNQFb9URHVzkdvE+HfwFLtLxhwFID7h6LrSlSnN7uU8ZluTNZYmbDdVSea0pcyeN4hA8aD0NAudbN5vbdhp7UK2wFee5RVVRUyIR+U8A+9f1oAeAsh1MCxIoS5G7MOwPERLXNYDL0jXdkXkvo3HbFvXS4pyO7ZKgXrCcKy75ImcEW7ywD0wDY6hekNwMLA
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5898b92-f064-4113-3809-08d76e6ddac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 10:30:40.0393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cRvtYKQ3HTIn80iAPuyWmkGcaAcTMxC+pTxtkHrPzHAIaKnqqGA/7uCcuNxB4P5cw47jM+vaJQZqY4wuE+tCcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5554
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add lock to mux/gate/divider to protect the access to the register

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-7ulp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/imx/clk-composite-7ulp.c b/drivers/clk/imx/clk-com=
posite-7ulp.c
index 060f8600ea0d..d8c6e48207c5 100644
--- a/drivers/clk/imx/clk-composite-7ulp.c
+++ b/drivers/clk/imx/clk-composite-7ulp.c
@@ -41,6 +41,7 @@ struct clk_hw *imx7ulp_clk_composite(const char *name,
 		mux->reg =3D reg;
 		mux->shift =3D PCG_PCS_SHIFT;
 		mux->mask =3D PCG_PCS_MASK;
+		mux->lock =3D &imx_ccm_lock;
 	}
=20
 	if (rate_present) {
@@ -58,6 +59,7 @@ struct clk_hw *imx7ulp_clk_composite(const char *name,
 		fd->nwidth =3D PCG_PCD_WIDTH;
 		fd->nmask =3D PCG_PCD_MASK;
 		fd->flags =3D CLK_FRAC_DIVIDER_ZERO_BASED;
+		fd->lock =3D &imx_ccm_lock;
 	}
=20
 	if (gate_present) {
@@ -70,6 +72,7 @@ struct clk_hw *imx7ulp_clk_composite(const char *name,
 		gate_hw =3D &gate->hw;
 		gate->reg =3D reg;
 		gate->bit_idx =3D PCG_CGC_SHIFT;
+		gate->lock =3D &imx_ccm_lock;
 	}
=20
 	hw =3D clk_hw_register_composite(NULL, name, parent_names, num_parents,
--=20
2.16.4

