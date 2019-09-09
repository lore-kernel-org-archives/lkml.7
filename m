Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40DBC00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDF02196E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Krupxkba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387833AbfIIDkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 23:40:17 -0400
Received: from mail-eopbgr20065.outbound.protection.outlook.com ([40.107.2.65]:12275
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728204AbfIIDkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 23:40:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZ0dAqnSvSp3ZkVzmmmMC/gi3lFum1wx8ui9GugtrWejamgNVpwLgpDsK2R8cgjuIGzuRZfmJ7YdSazc6Iyb2dLSA2iqYsA5qkhgs2L61pxY4loX7HtP4e8uw2koo5z/1SVoVa76aA7qGc1n/mMjzSGwAA7crCENobvPTHlVWQrVb3QBTmbxwao1BSvtiL94nF6J5Iio9t/XbmLBIkPvNaOUJC9ih28idraA3CifJJqGLTlgnkIv5T4pdyIEpVUJ/XArFBbD/9ffI6o6c9Jgh0cjO9KmANVHyP2vxOTzsPsZTLuIE6d1yRzOshF6K1MJ9flKg8ajAwnop8WJf2ZjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoVIxvENZzR234Jzf2NQ1yFRnNq8/y+bqpbHiEFxKOg=;
 b=oJXWwteGx6INe8dadWAgso4LqfZg8psqRVtRjKmbf8o89DzE9nk5vM5oEAyxLt+MvkzWIbh8Kj0xQcFMJ9CAyr5bN/lxjZIPv2H4ZuVhcSfRYTsqd2FSt2PNQXdkAJc9yznIrd3kIGgrtWn7gvm4SSbEq90e2SvElL7xQaOB88+exdfX5GBNjK2u8fHjLNiq+nMs4JEcWkXgN5MCMU29fIW4ycOphiZoRKgxRE54uFQRs8z5JZZ4fj0mhDw0HBAtZVB4KGnL+AHHJ7LDzdScDRTvainxbub8YSMsRq6kRw3JuO6NA1sLGO9uHPNsgbtlCbolL4Z20J1nxb/yHPy1xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoVIxvENZzR234Jzf2NQ1yFRnNq8/y+bqpbHiEFxKOg=;
 b=KrupxkbaSV7d1OpPLsN0kWVFzyqbQTgLCTN7munrX0GbEAjMHzZBBSmwqHmdE+WsuHW/XXjU8i7/xFKhSpuRNuFbepCKAHOAkd4uWL9MkOZq5OxL/GFxjEk5bCGjGZA2Zb4E1ZvHVFTTAmFMP+peBSVS7oSJoH6uPfSNj7iksvA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6020.eurprd04.prod.outlook.com (20.179.32.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.19; Mon, 9 Sep 2019 03:39:39 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 03:39:39 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/4] clk: imx: clk-pll14xx: unbypass PLL by default
Thread-Topic: [PATCH V3 2/4] clk: imx: clk-pll14xx: unbypass PLL by default
Thread-Index: AQHVZsA1EtD+h9V9IEql7N7H+rcN+w==
Date:   Mon, 9 Sep 2019 03:39:39 +0000
Message-ID: <1568043491-20680-3-git-send-email-peng.fan@nxp.com>
References: <1568043491-20680-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1568043491-20680-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:203:2e::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 209c0b62-6559-4024-ed2f-08d734d7580a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6020;
x-ms-traffictypediagnostic: AM0PR04MB6020:|AM0PR04MB6020:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB602025C019E9961612901AE088B70@AM0PR04MB6020.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(199004)(189003)(7736002)(186003)(26005)(54906003)(316002)(66446008)(64756008)(76176011)(50226002)(446003)(2616005)(4326008)(6512007)(11346002)(44832011)(3846002)(6116002)(66946007)(102836004)(110136005)(2201001)(25786009)(8676002)(52116002)(2501003)(386003)(478600001)(36756003)(14454004)(99286004)(66556008)(5660300002)(66476007)(86362001)(71190400001)(6506007)(2906002)(256004)(476003)(486006)(53936002)(8936002)(6486002)(66066001)(81166006)(6436002)(71200400001)(81156014)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6020;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5StAbYTixbqzKGnWotXOTeRgYgMV8OsJJTwMDtk7K6iMsYkNbrDfGp+SjlaKRsr3s+RovqNgoETZO0e/Ctp+7kjvMaLEX++cXARdXwKfdgADcz83i/QnKSWPaas7QYkab3f0g9PP8MbzzkUchF3IDvaySHSIQR5TQ8bZiKxPfZvk2rijmgBZN92PWGgohvcusOZo23auW2y574zgSxOwBIzaIj1sSwlOF/Hp0eSNg0utr6uRd5ebZcWUCo8Sx63Xt0BcR1OGwYxbIcC5uMLsPSBOYHcrv6QCrPnjJDZWgeNAXcPHg6LrxuBdreTsi3SvxBu0AFt/quaHXiSF6fYXZKQPc6LMJ+Eae7VeIAd/nRVJxSGU802BxFLGmDwtnoj0NFRDaEdm4PB+chWo0+DeoTuU38YJa34NjbpJKH4AzKI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209c0b62-6559-4024-ed2f-08d734d7580a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 03:39:39.7387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gyKWI4h8GQ8idRcS0CbXD9jVf45v1/YXrV0kLXpjPj993nfaijn3tW96+W2b12ldZ/Bxdco3VoI1RFfrydQAyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When registering the PLL, unbypass the PLL.
The PLL has two bypass control bit, BYPASS and EXT_BYPASS.
we will expose EXT_BYPASS to clk driver for mux usage, and keep
BYPASS inside pll14xx usage. The PLL has a restriction that
when M/P change, need to RESET/BYPASS pll to avoid glitch, so
we could not expose BYPASS.

To make it easy for clk driver usage, unbypass PLL which does
not hurt current function.

Fixes: 8646d4dcc7fb ("clk: imx: Add PLLs driver for imx8mm soc")
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 None
V2:
 New patch


 drivers/clk/imx/clk-pll14xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 656f48b002dd..7a815ec76aa5 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -368,6 +368,7 @@ struct clk *imx_clk_pll14xx(const char *name, const cha=
r *parent_name,
 	struct clk_pll14xx *pll;
 	struct clk *clk;
 	struct clk_init_data init;
+	u32 val;
=20
 	pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
 	if (!pll)
@@ -399,6 +400,10 @@ struct clk *imx_clk_pll14xx(const char *name, const ch=
ar *parent_name,
 	pll->rate_table =3D pll_clk->rate_table;
 	pll->rate_count =3D pll_clk->rate_count;
=20
+	val =3D readl_relaxed(pll->base + GNRL_CTL);
+	val &=3D ~BYPASS_MASK;
+	writel_relaxed(val, pll->base + GNRL_CTL);
+
 	clk =3D clk_register(NULL, &pll->hw);
 	if (IS_ERR(clk)) {
 		pr_err("%s: failed to register pll %s %lu\n",
--=20
2.16.4

