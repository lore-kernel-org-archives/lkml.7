Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5511CCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA1521721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i1Cw/kHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388956AbfJ2Nl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:41:29 -0400
Received: from mail-eopbgr130083.outbound.protection.outlook.com ([40.107.13.83]:20179
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388604AbfJ2Nl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:41:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpdwvRIpATfusPJcTDCnH9NFlvuemj4jUAJI0ZdJiVSH/IFrdG4J3epyxakFJSNEsmPvGXBPgPKgk6qF1c4DU4Ztgvfqjqe7tONMFY4rBBOjDklaU7n0sNcBRgUpxlIMtFy7behkLBdbTrzt6y+tDcia+MlxhRF2/T+85AKQPLHfJlzI6wUBJaV0Vy9a9BQzPIwQJc4uMCbSHSk85cBpmW04enBFj3pB0L9lGrlPVVNQXhN6Da/ENrDp3eVlYSExZ/WZ1wA8kLUdZhrAWDrYh46zuOM4mRHuoxb6keMXGysoqcxph+MlyQfnhRAD/YUs3sug3UGjb7qn8Nrh1O3dSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhvqOkMu2GXckDZf1/zbCsjg5AHZh23AH8C6jad/Dks=;
 b=BZG4Uth29xZmBB7KVyZAkEsfMTmg7wquiYwtN44I4RK1x/hStUxBopVpsCSbp9y0vbjmXTw/QcGblQREt6dSIQgUm2DlHq5x2lDuJRmsYBZ8O/YKzVFV9Z4zC66ZSXBc96JEol0b4qRL8NENjY17vdbPuC/hLB3IvDhOEStj6Qhl0uIORbQl0lFPYY5KCDg9N6fngWzZfbTpUCIOMHYOjucMD9dwqEf9AAVwuzOTbxpzKJFnWZ5q/2YSgXh7EjV64DCqCD05+egZRTozX3zWZI8wSrNAQSqWvHR/O4OZaWP+UT1HWv31VNhl9JP5fKiCvE63HToUvFJXAgf0Qp7EVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhvqOkMu2GXckDZf1/zbCsjg5AHZh23AH8C6jad/Dks=;
 b=i1Cw/kHA3jVzk2HTV+pmevZIJZ6961jvmW82Jmu+NavvwteChpfXSlaEWZSruhI9E8Ve3hDPAtmh0rmTyVvRtsuspAOKv7/LDjENK3cbn7DvZPOOnFg8lQSJ1uOlBDUf6zrtRb8yKSs07AnJF1lH6YVNRCrsh0ovTP1XqdqeriI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5139.eurprd04.prod.outlook.com (20.176.215.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 13:41:22 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2387.023; Tue, 29 Oct 2019
 13:41:22 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6/7] clk: imx: sccg-pll: Switch to clk_hw based API
Thread-Topic: [PATCH 6/7] clk: imx: sccg-pll: Switch to clk_hw based API
Thread-Index: AQHVjl6Mj3bsIZq53UurLtNlu0w/Lg==
Date:   Tue, 29 Oct 2019 13:41:21 +0000
Message-ID: <1572356175-24950-7-git-send-email-peng.fan@nxp.com>
References: <1572356175-24950-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1572356175-24950-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26698e48-19a0-4694-018f-08d75c75af39
x-ms-traffictypediagnostic: AM0PR04MB5139:|AM0PR04MB5139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5139476F0C6D6B025F67F85188610@AM0PR04MB5139.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(199004)(189003)(6436002)(102836004)(66946007)(52116002)(66556008)(66066001)(5660300002)(66476007)(2501003)(81166006)(8676002)(486006)(81156014)(6506007)(386003)(66446008)(6486002)(64756008)(256004)(478600001)(26005)(2906002)(3846002)(76176011)(186003)(25786009)(99286004)(71190400001)(71200400001)(6116002)(6512007)(6636002)(54906003)(14454004)(7736002)(36756003)(446003)(11346002)(476003)(2616005)(305945005)(4326008)(44832011)(50226002)(316002)(110136005)(86362001)(2201001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5139;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X2+M6k8+okpt81fLqdKhJTUAI0bInbTK8q2YBZ9QZJRGBfiYcB/2hG40F1ErmYGbBrVlb8HEqP0qMGPXP2iHXooiCUTbGQAbN4kl9HH/ubbuMAnek2PCIHFnwiCVw/vEOTplbaGCsL9aA+7W6IL4iWkO2X0p1nGFUnbvSjcB9+rFqpzi4jIxAkXWkGi83HYJM1Zi8q7+OgQcOZMWcENkVoIdDRZYvnu6jsQCE+i9deVKKd0SLz8+/+tVZQn6fCyNOmcrC91WQ6tmF9g6LkHKYZbgnnTMcUd+RYDEZzmSoFdzlP2yDy2363bOgVLT2EWZQEsyj6KJF2rY1NNLvdYWOFxHz3SYWQY9Opr+ZNAXeXmQUPv6meSyMPhFC9ONeeA7iEGhZBgow7+UgeIpfx6D7rmm/PQ3x628P86hzTtQk/wDwawmakvLyQgPccSMoeS0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26698e48-19a0-4694-018f-08d75c75af39
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 13:41:21.8981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x4qAm5WMGD4ujBuQjM3MoSlT/mN/JI/QJfAtRoPsh/AKv6vlcglnwo4qnD4bvrU2y9rdbiEiwEGsO8MRl5MrIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Switch the imx_clk_sccg_pll function to clk_hw based API, rename
accordingly and add a macro for clk based legacy. This allows us to
move closer to a clear split between consumer and provider clk APIs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-sccg-pll.c | 4 ++--
 drivers/clk/imx/clk.h          | 8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-pll.=
c
index 5d65f65c512e..2cf874813458 100644
--- a/drivers/clk/imx/clk-sccg-pll.c
+++ b/drivers/clk/imx/clk-sccg-pll.c
@@ -506,7 +506,7 @@ static const struct clk_ops clk_sccg_pll_ops =3D {
 	.determine_rate	=3D clk_sccg_pll_determine_rate,
 };
=20
-struct clk *imx_clk_sccg_pll(const char *name,
+struct clk_hw *imx_clk_hw_sccg_pll(const char *name,
 				const char * const *parent_names,
 				u8 num_parents,
 				u8 parent, u8 bypass1, u8 bypass2,
@@ -545,5 +545,5 @@ struct clk *imx_clk_sccg_pll(const char *name,
 		return ERR_PTR(ret);
 	}
=20
-	return hw->clk;
+	return hw;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index a260b8dd3256..9de6bc590638 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -116,13 +116,17 @@ struct clk_hw *imx_clk_hw_frac_pll(const char *name, =
const char *parent_name,
 #define imx_clk_frac_pll(name, parent_name, base) \
 	imx_clk_hw_frac_pll(name, parent_name, base)->clk
=20
-struct clk *imx_clk_sccg_pll(const char *name,
+struct clk_hw *imx_clk_hw_sccg_pll(const char *name,
 				const char * const *parent_names,
 				u8 num_parents,
 				u8 parent, u8 bypass1, u8 bypass2,
 				void __iomem *base,
 				unsigned long flags);
-
+#define imx_clk_sccg_pll(name, parent_names, num_parents, parent, \
+			 bypass1, bypass2, base, flags) \
+	imx_clk_hw_sccg_pll(name, parent_names, num_parents, parent, \
+			    bypass1, bypass2, base, flags)->clk
+
 enum imx_pllv3_type {
 	IMX_PLLV3_GENERIC,
 	IMX_PLLV3_SYS,
--=20
2.16.4

