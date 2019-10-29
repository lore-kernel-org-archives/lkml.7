Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78621CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CFF2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SgwHoNET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388978AbfJ2Nld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:41:33 -0400
Received: from mail-eopbgr130080.outbound.protection.outlook.com ([40.107.13.80]:24778
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388604AbfJ2Nlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:41:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwgQ4AMY5mEvl6VNUemquDmcdB4TyC1Z2geCMeDfOcqGaqErEATI/en10xhE9V/zyWOh2+X4B4KubW2HOe70dOEbtnreuVSGaijq4Ip464F2rF1N25PdIksTS0TF423CCFxqrXEITZKhWUGe3RLAur2vgHXfRUiBUSb2MnHwxu6Zx+Zbkb/QFwoE1f1pPqNl3ag3jq/cNG37YFk/kcthJU/tmQZ9wK0ox4HE4+90Yw8AatzSsJ79/VbXYN1/rZEsXRXxUPGOpX0VFMauvT0e7Rlw6Rq+MZrJT8qzIpKxEjgOuisOlTsh99cRqShQ72dwPCW3XhsX4zuWSMsHxicTGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oLf7GDtX2gdlTwAjeFUAFyGC64Ffk0E74Fzd1BjxZg=;
 b=i+VxXkThR7XCIg34nG518rgzPb7r5nA2PUGD5VGqk18embOJ6+55HsgPiAJPiMYQb/GMw8QEGJN2awHU/Q0ArNpMzhgBE8g9vBZKJ4tNVeTmXgiiCEkqY9RQKfCAPfL8XfTSS6CDhXRL4XGd76Qe17jFEuGPvjChe0pxDbCq+gYrYNP3yDG6Kz8JSeq2PI0daE79yRwsMnSCDa4FfkPKcgn8Fc6tlqIYm4OcLy6+ShFurGgT933RDGzSL2/k8QbMOJrb+SvlxIP3ZZ0izrFXIjBvqHSL/pYe0rDDuy642a2O+7OY4Ry3AVYzw37hBI+/U06D5IFeJA3vXXHnlwPwLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oLf7GDtX2gdlTwAjeFUAFyGC64Ffk0E74Fzd1BjxZg=;
 b=SgwHoNETNV4oPutxFVHDtir2Ibcx/JeQWDA2eDAhJHsXEM3Smfq8upfrbEc0GAk/rKTZxy2BABOMMeVkGfCZMd3aqwALMEgJfylGfKktlDqS5luyPdbf0gIo42jbFcehaJlbOBUdoFcojwZs0Rg+dFDLL1Iah/R3Gf96QG+GY3g=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5139.eurprd04.prod.outlook.com (20.176.215.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 13:41:27 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2387.023; Tue, 29 Oct 2019
 13:41:27 +0000
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
Subject: [PATCH 7/7] clk: imx: gate3: Switch to clk_hw based API
Thread-Topic: [PATCH 7/7] clk: imx: gate3: Switch to clk_hw based API
Thread-Index: AQHVjl6QP6B/hjNO9EqRDMbJjuGEWA==
Date:   Tue, 29 Oct 2019 13:41:27 +0000
Message-ID: <1572356175-24950-8-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: c1004cfa-acc3-4b9b-0061-08d75c75b264
x-ms-traffictypediagnostic: AM0PR04MB5139:|AM0PR04MB5139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5139519AD1C87C6D5BA13EF088610@AM0PR04MB5139.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(199004)(189003)(6436002)(102836004)(66946007)(52116002)(66556008)(66066001)(5660300002)(66476007)(2501003)(81166006)(8676002)(486006)(81156014)(14444005)(6506007)(386003)(66446008)(6486002)(64756008)(256004)(478600001)(26005)(2906002)(3846002)(76176011)(186003)(25786009)(99286004)(71190400001)(71200400001)(6116002)(6512007)(6636002)(54906003)(14454004)(7736002)(36756003)(446003)(11346002)(476003)(2616005)(305945005)(4326008)(44832011)(50226002)(316002)(110136005)(86362001)(2201001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5139;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2/NkHmoK2IPxtyHYhTnH8Os90HTqvzNjNK9aPGgqlwJyK7GlnmEbYNT97kpuY88Cwk5SCsV3u5Rlb5FHZgXGRZlJ47T3etPPGHr5hitAXuiR5unL3J91ESQOuXFqF3t9qAQ6zCUskUr7DvcRAwVSqN+TXKTjNhZL810ycPaxjz35gesEciIeUk65gK02lFzRBBGX7reTYtkSWN8u4FQTx3DNAlYnmi7AgYRfSEbScKHT5OqHuhgIAfqGvofJt3AkLf8mrL8EZTSmd9+hj6WEl0dEM/+2YMJRt/9PouhObzdFmpWcqWHGZbwNJxA4jH+3o6ge0e2PjwBlS6Ow7r3LknwGemZAtCtygY+jZ4w+CLY3qY4PiGO/WKn3au7vkkIb1qAN6LaRw4exmZ9e+iOG1XyVNICxIdfHRkNtJU3nCH5mWaVjBmyxeUjNFTZkWsht
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1004cfa-acc3-4b9b-0061-08d75c75b264
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 13:41:27.4339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qQoY+GtEYZAtTUDgio+ECKgX52cCue+4w4G0ak699eyK0wBqW3V5PT9FBG505ZAbitTT52iKkjgTV0hFu9lAOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Switch the imx_clk_hw_gate3_flags function to clk_hw based API, rename
accordingly and add a macro for clk based legacy. This allows us to
move closer to a clear split between consumer and provider clk APIs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 9de6bc590638..cd92d9fdccf4 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -366,15 +366,18 @@ static inline struct clk_hw *imx_clk_hw_gate3(const c=
har *name, const char *pare
 			reg, shift, 0, &imx_ccm_lock);
 }
=20
-static inline struct clk *imx_clk_gate3_flags(const char *name,
+static inline struct clk_hw *imx_clk_hw_gate3_flags(const char *name,
 		const char *parent, void __iomem *reg, u8 shift,
 		unsigned long flags)
 {
-	return clk_register_gate(NULL, name, parent,
+	return clk_hw_register_gate(NULL, name, parent,
 			flags | CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 			reg, shift, 0, &imx_ccm_lock);
 }
=20
+#define imx_clk_gate3_flags(name, parent, reg, shift, flags) \
+	imx_clk_hw_gate3_flags(name, parent, reg, shift, flags)->clk
+
 static inline struct clk_hw *imx_clk_hw_gate4(const char *name, const char=
 *parent,
 		void __iomem *reg, u8 shift)
 {
--=20
2.16.4

