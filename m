Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE65BC17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F892084F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JBRYJf/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfKMHYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:24:53 -0500
Received: from mail-eopbgr00064.outbound.protection.outlook.com ([40.107.0.64]:56582
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbfKMHYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:24:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRnSEkwLKtDW05ZTHfLmic4pOUHwdf/xs0Fy+rsErSxfxEYBqafbHJvHUpkuAtBvzB7taYDO6XDRwiBtgTfOQNAtIjeqFIPpl9kS9JfOjlxwrskIldVlpQFzr0XY6KI6Ux4fWsZyO2PVD7/5FjgA9fw0Y99ZwW9jSn8e95pElilZwa3yRsA959evYXI5tEB/vwsD99/l3mnt4HUnmcPM00cEBgFBpLqYsQUmfFfS+76dafX0O14cC9/E994CPYfFrkbKKT0Cfx9ggQIxWZlKuylht1w9+RMD93tHyhJHZ4AeXmeUcDY8cYz7x5iG88aKVWJzeCCh6R9IjbXmVnulPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAsWPc4rNod5xFgv8fXO7pzo4SY9yZcYiaJLQgXpPHs=;
 b=j4MzUy4+hMVbtN/saFIA3Mrh5j/LM4Xtra65gkBg1tvVNjD9bA/6ScptrPS4eKd4M3HT4q61eaaKO3SyizppSwKoV05B/cPYxLLoEU0vu13NoIVWO/sDaBtXTBN9k0XKXYBz/aD8io8kF2odI57R9vQ4wGmBPnv6A88KT5CqBoGSnD3c44T1aBlQp4L+yT3ccuiM/Eve74+VDNQigZVPR6IyKMFlPuqGsfrgjPJ/kOCDi4HmyhE6sMjzjInnmYd/juSh5pt6GSAqlERUXI/xwaHWZhV5u7r6L6ROTtxY6e9E1lw1ZPjvO4cpJoRJQkHBP/KknPknEykkqUVoBDdU4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAsWPc4rNod5xFgv8fXO7pzo4SY9yZcYiaJLQgXpPHs=;
 b=JBRYJf/NOp7I+4n2iGjgd7WwVBJrIBEK93rk0CctvzlqKRl0P4ZW0TjZBCiBGFTbN8HEW7DIivGs5BnOvNAkF/N7d/8KN3gGq0DUmojXMz98NP0NxSUd9CSHViUWF4DqHPI04xJLSeToOpVKU2MZ+G0Hk1yiRS2ymqB2k3zcFK0=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB4651.eurprd04.prod.outlook.com (52.135.138.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Wed, 13 Nov 2019 07:24:48 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::115f:1e4f:9ceb:2a2c]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::115f:1e4f:9ceb:2a2c%7]) with mapi id 15.20.2430.028; Wed, 13 Nov 2019
 07:24:48 +0000
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
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 1/2] clk: imx: pll14xx: use writel_relaxed
Thread-Topic: [PATCH 1/2] clk: imx: pll14xx: use writel_relaxed
Thread-Index: AQHVmfNuHTJgCIWBG0W9BBzI6iT6Ug==
Date:   Wed, 13 Nov 2019 07:24:48 +0000
Message-ID: <1573629763-18389-2-git-send-email-peng.fan@nxp.com>
References: <1573629763-18389-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1573629763-18389-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0169.apcprd02.prod.outlook.com
 (2603:1096:201:1f::29) To DB7PR04MB4490.eurprd04.prod.outlook.com
 (2603:10a6:5:36::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 601fbdcd-7289-429c-0c58-08d7680a908a
x-ms-traffictypediagnostic: DB7PR04MB4651:|DB7PR04MB4651:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4651BF80C3B7DEB7260BE34488760@DB7PR04MB4651.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(199004)(189003)(54906003)(81156014)(81166006)(44832011)(8676002)(76176011)(50226002)(14444005)(256004)(186003)(52116002)(6636002)(6486002)(66066001)(486006)(110136005)(2906002)(8936002)(36756003)(6436002)(316002)(478600001)(6512007)(7736002)(305945005)(71200400001)(2616005)(386003)(11346002)(102836004)(71190400001)(446003)(2501003)(6506007)(26005)(14454004)(476003)(4744005)(5660300002)(66476007)(66556008)(64756008)(66446008)(86362001)(25786009)(6116002)(66946007)(3846002)(99286004)(2201001)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4651;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3q9ejDWl0W/Tsk0I1Od5DhHToCQkZDUWlGKZe1w6P9IBA8peUB41swIJHeGzKXnyT70t04upk3/ZC976rCoJjQMNjbbhLBBLujY9YzOfkdT7NVekUfN9Twj/VfrN7HItLxxYKiCmnTz6byg+T2smCSGvZFfGHlEgO0PagUw9rDLuQqAhnU7eyySHIulp8D5zO9Wd4Whimo4zUMiT9AAs5nQlDHRCyzKr9lkQ9D614L0v4U/w5UKDtY1dg70x2hVEp5LFycEDfs26IhRWEuygE4tuIKozUTR4ZlsPJD9VnMxn3a7u0zUtuFzSMKarexJYaaDpImXru9AJnEosSQqaYVB1TFzZOCNzj2BYgXzM2LxyZKwjSxowpIzXyiRo2mM2K035hSHHWCx04Gw24cnsylMK8ounfw9zkONA3/QMecQ+j9n6qBtGi0b0WIP2XJUI
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601fbdcd-7289-429c-0c58-08d7680a908a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 07:24:48.4419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xAJYZsstNA7o7obKgihI4pCKHqszfJDez2DTIs4m4Yzx4tn2taqc1b1/kxShzo43LIYYIjOTx9ANb8Swkw1fbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4651
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

It not make sense to use writel, use relaxed variant.

Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pll14xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 5682fce9f5e5..e34813904023 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -199,7 +199,7 @@ static int clk_pll1416x_set_rate(struct clk_hw *hw, uns=
igned long drate,
=20
 	/* Enable BYPASS */
 	tmp |=3D BYPASS_MASK;
-	writel(tmp, pll->base);
+	writel_relaxed(tmp, pll->base);
=20
 	div_val =3D (rate->mdiv << MDIV_SHIFT) | (rate->pdiv << PDIV_SHIFT) |
 		(rate->sdiv << SDIV_SHIFT);
--=20
2.16.4

