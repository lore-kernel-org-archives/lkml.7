Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB511CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4E7217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bkb6VJnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfKDKLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:11:42 -0500
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:29057
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728351AbfKDKLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:11:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cW/8DKuZEZSnQuWB40Q5VjX7k5CznfnBb+A8yCdkDhNy8QX3L+ncYdPtCkCq9SYN5qSTmmU+GGPJqyMEI8WhKYkwZeoOTtkAMf6WWSmaoovmZHBVe8FEgI+4QgOkcXvCy+6dO6ofydrDnzJsr/bwXv3BkcIg1wCUne3WDC9FaBeP5vMvI5sX8alFUHYV6m3hzy0m5MYWu1aGkDlda3L87dCilLjK4SX+6CkiVo2vaPTCQKmg0VxfJ15zMz5gdLS8PIE3gNOzPtksyj+2JCOYk+OddtFQ1xmELJBOjbiJwvL/Y4jcIBfo6HpkH0mnUOOoB8PE43CN6jIXwEtfPeqEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4Q6OCFdfXglH+O9H0xCZY4exLfJrhjJhNG5RxsjsJ8=;
 b=VdrGRwcWtmgQDz4i3gj0miwVQu9ROosshEiyS9howBXVCm8RC10onWtJOpC/Z4BbqWhzfrXpYwssE1izENG5SHG6sxR5kX0v+dn97uU8ovgg5mhqyMokuJ9sGDMVs8CdUr00FYgOZ4Ao5Mp/JYof42fM/RcPTMb8EjegQ8WeeMhajbzj9drxGc7Jh+ANp9MLm1KPKON9N72SrH54ELvWvEieL5RgNC3DaNGPkL7MGLNDb4HBTiiHHxNyMsam5e7JZspD57J23Ex5JD5XiyN2X3bKUTx9h+WQCR1qxuSkiAqO0aQq8tlyXYIrO5vFIpyFAQacngYiV+ZQ0ePT1gp5Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4Q6OCFdfXglH+O9H0xCZY4exLfJrhjJhNG5RxsjsJ8=;
 b=bkb6VJnj9JS+BcfAIn3B7guaPqj+Kzje3Gm9BNRiqAFbLv1Z8RPMuwxrP/W313fJW4Ao2grm/tQjUkr7Z5pEARKE2OwxITQt4Y4k+QR1xNB5S51O+4PQBleqMXPUMCF2z67aahHtmEG7DY9TR1RHnIr951yA1jdi1i1zXN6Otq8=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB3987.eurprd04.prod.outlook.com (52.134.94.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 10:11:37 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 10:11:37 +0000
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
Subject: [PATCH 2/2] clk: imx: clk-divider-gate: drop redundant initialization
Thread-Topic: [PATCH 2/2] clk: imx: clk-divider-gate: drop redundant
 initialization
Thread-Index: AQHVkvg+c+4CR86moUSn7OJwmBC6Vw==
Date:   Mon, 4 Nov 2019 10:11:37 +0000
Message-ID: <1572862200-29923-2-git-send-email-peng.fan@nxp.com>
References: <1572862200-29923-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1572862200-29923-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0047.apcprd03.prod.outlook.com
 (2603:1096:202:17::17) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 870ac988-59f5-48d0-04f6-08d7610f60f7
x-ms-traffictypediagnostic: AM0PR04MB3987:|AM0PR04MB3987:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB39876C00A0C2A0E93C3441A8887F0@AM0PR04MB3987.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(189003)(199004)(2906002)(110136005)(186003)(54906003)(81166006)(14444005)(316002)(386003)(6506007)(6636002)(52116002)(66556008)(7736002)(6436002)(102836004)(25786009)(305945005)(71190400001)(71200400001)(66446008)(8936002)(66476007)(64756008)(76176011)(66946007)(66066001)(6116002)(3846002)(81156014)(8676002)(4326008)(86362001)(446003)(11346002)(256004)(14454004)(50226002)(26005)(478600001)(476003)(486006)(5660300002)(44832011)(99286004)(6512007)(36756003)(2501003)(2201001)(2616005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3987;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wMsw9gUwnSRSolxjTYfQzBV6u6u6z34kY6oG8xzQJs/s6BJgPLQ7Dm42DQ1OSUmaIxl/hHIYuOpI/sJWfGJp904WARI/XVHIbUZiiE04mJGO/m+sjznbWUzny1xJ3isjZp7IWCqLDHHTNYMfbPZk9QV7C7cdicKPQ2CWnIiwyaIQaycDloei4O6DX2WzbmSPP/uVXZmng7YPi2nooX8HTR88xPzX9/JWNcf8pE/gP8w5MsVGf0W3OMMMOlSTRjov/FBsCFL+vxAg5Ux7sGim7kYJQ9MSCnyi0L/k7h1ysdtr2oXt8GXl9m2VKlL9BY4bxEj+NmcsUhIgk55K6z7csyaxTTDMr/+k0my4jANztMEx1pFBkOb4+i1Yszmph7KkCISV7V7Jhjb5f9L6ZRLwVn5Vlq/gxsdwHPhsBNcnaMd0mdGb/FxUrbKNHEpYiw9D
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870ac988-59f5-48d0-04f6-08d7610f60f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 10:11:37.7318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ncKNwRArnpFrHkpLWQ9pjp3FaGcPjfWjsXINk+gZZBG0CznxRo1gHkKbL3Dz0EiKyQhKW4hpYhTIHTX0tm9UVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3987
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is no need to initialize flags as 0.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-divider-gate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-divider-gate.c b/drivers/clk/imx/clk-divid=
er-gate.c
index 214e18eb2b22..4145594af53b 100644
--- a/drivers/clk/imx/clk-divider-gate.c
+++ b/drivers/clk/imx/clk-divider-gate.c
@@ -43,7 +43,7 @@ static unsigned long clk_divider_gate_recalc_rate(struct =
clk_hw *hw,
 {
 	struct clk_divider_gate *div_gate =3D to_clk_divider_gate(hw);
 	struct clk_divider *div =3D to_clk_divider(hw);
-	unsigned long flags =3D 0;
+	unsigned long flags;
 	unsigned int val;
=20
 	spin_lock_irqsave(div->lock, flags);
@@ -75,7 +75,7 @@ static int clk_divider_gate_set_rate(struct clk_hw *hw, u=
nsigned long rate,
 {
 	struct clk_divider_gate *div_gate =3D to_clk_divider_gate(hw);
 	struct clk_divider *div =3D to_clk_divider(hw);
-	unsigned long flags =3D 0;
+	unsigned long flags;
 	int value;
 	u32 val;
=20
@@ -104,7 +104,7 @@ static int clk_divider_enable(struct clk_hw *hw)
 {
 	struct clk_divider_gate *div_gate =3D to_clk_divider_gate(hw);
 	struct clk_divider *div =3D to_clk_divider(hw);
-	unsigned long flags =3D 0;
+	unsigned long flags;
 	u32 val;
=20
 	if (!div_gate->cached_val) {
@@ -127,7 +127,7 @@ static void clk_divider_disable(struct clk_hw *hw)
 {
 	struct clk_divider_gate *div_gate =3D to_clk_divider_gate(hw);
 	struct clk_divider *div =3D to_clk_divider(hw);
-	unsigned long flags =3D 0;
+	unsigned long flags;
 	u32 val;
=20
 	spin_lock_irqsave(div->lock, flags);
--=20
2.16.4

