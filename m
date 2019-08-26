Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541E1C3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC852070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ga8qEmMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbfHZJm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:42:58 -0400
Received: from mail-eopbgr60048.outbound.protection.outlook.com ([40.107.6.48]:9346
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbfHZJm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:42:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HodChanQkoFD8BPABuFE8PRg0k/77d7WGWkn5nroQog91QhGkDquVTLXTj+DTGD5+14wcdyEIKxDItHS1wXLWWdVIlAyy3bXS9EDVIzEkP5uzUDFwn1jZCeQXsKeJV/gty32A1m1/1sofNnx3qMaUO1U85h4Z28SHY0dEJzMuTQIaYiv3iS9GmRedRzaJnKlZbHXqulwNNCh1NVE0hF9ldVGCnFxCZOX39u7liMXRVjkaS3rc4h+BfSKpJpwUnPjQDNHtDv/Ki4Z5C0HRncDRuKMc6f5gIdTwH9/Y6akQf2XnTsPBRvASaxF/QQ2NY563INcyTsu7xHyPKfdfLuSPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A11c6YqLZ+w8YbRtLdr11LAUgnZRPRhPzG6+nMim9Hw=;
 b=Epc2Su5qfI8EIzP/DP8/S7eVkXiJrtiKweG0+NA5vAdkSmMJU17HsCqI9DDXxkQmRGwj/Sub7z/c45oFoaRFzeZ2zSNdKM0hcrzB9wIarfcdyVEQHeB9hnBUHL4be4NekbnKtLUBiRmeCdQ3+fI6lSo0AQDCZvVIromGaYXgHgn1zrrSTEkQa5jaJT7nJ3+jCC4rHK87tTtsaM52qqsoEJXjfq7ESUn/JW2aVVs1PlgLQviaHNKkHz/jp4XsMTTE90YvwOAFmPig4CT4ZUpHtZzkoRW85gl8tFtr4zIvimXd1+OrG8wRRgpRUy+s4P8naQ53Pz5USu3QRnuG7lNa0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A11c6YqLZ+w8YbRtLdr11LAUgnZRPRhPzG6+nMim9Hw=;
 b=Ga8qEmMRz80oX6LM7dZzMtrisnaSe2r1BWDGTBxN491ufUT2OFVyZtQKrXOZSnnkI358N5d6nvebanRo/fCqP2h/KV47L4E7kyuFQpJnPOF48prZPwrLTbmduwX+ohRYQkt6p1kAbp9X3yM0ugXjeVtI/+uknLPeB3p2gdckbMw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4194.eurprd04.prod.outlook.com (52.134.126.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 09:42:14 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.022; Mon, 26 Aug 2019
 09:42:14 +0000
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
Subject: [PATCH V2 1/4] clk: imx: pll14xx: avoid glitch when set rate
Thread-Topic: [PATCH V2 1/4] clk: imx: pll14xx: avoid glitch when set rate
Thread-Index: AQHVW/KK74JBQxFn0kSNJpxYwL3XVQ==
Date:   Mon, 26 Aug 2019 09:42:14 +0000
Message-ID: <1566855676-11510-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0047.apcprd04.prod.outlook.com
 (2603:1096:202:14::15) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50cafe09-948c-4e55-0c99-08d72a09acf0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4194;
x-ms-traffictypediagnostic: AM0PR04MB4194:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4194C75557579220DED810D088A10@AM0PR04MB4194.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(43544003)(189003)(199004)(478600001)(2501003)(25786009)(66066001)(81166006)(81156014)(66476007)(44832011)(7736002)(486006)(305945005)(2616005)(476003)(36756003)(8676002)(66946007)(66556008)(66446008)(64756008)(14454004)(316002)(110136005)(54906003)(6116002)(256004)(14444005)(8936002)(50226002)(2201001)(99286004)(4326008)(6512007)(2906002)(86362001)(53936002)(386003)(71200400001)(71190400001)(6506007)(102836004)(186003)(26005)(5660300002)(52116002)(3846002)(6436002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4194;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bAiVVXYMZcvfiSsmqHplSZmcwSALF01eVPT8IVFRFZ9r/UDIX0uHQrdHvNZ8+R6VxflTP08qGNACRbrrvHCnlRBrf4haL2sHKjyfwt6STGkn0MloFzRSN/QFrpwF+dPvMWxYwSAXjpvPDENkzbI8qR2uAMIam3dyFhYyrC+vJX35xwpNYIcQMTCV3MQz5f4eAsnaoDj5AFg+3XwMvQdCjfcUIM2nLcDcomUKxRNww31jzzOYspYZfMvOsQnndoKFTYaZvpEq/dwy4lAg9Ao3sgggWU6+cs9hPkvK6cidWRzsBCV/phOj2Ms1uMRB3TmIsMJioTHZRWACGZDRis4AmKF776a20/0v1Xppo2zGlErqQYKiWriBO9RRO0UWIZjHhBG+4W0M3cX3GiRRHXtyg57RYOrP5+9vT/8x5Orqbc0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cafe09-948c-4e55-0c99-08d72a09acf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 09:42:14.2608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AbfXkPej4cyNWw2QpctKGhPTEaqWX6SIzEPZytrzML+Pj1UYgVxBJLSB8VF9RKbwn68mtHNVkQR3PGo39YEL5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According to PLL1443XA and PLL1416X spec,
"When BYPASS is 0 and RESETB is changed from 0 to 1, FOUT starts to
output unstable clock until lock time passes. PLL1416X/PLL1443XA may
generate a glitch at FOUT."

So set BYPASS when RESETB is changed from 0 to 1 to avoid glitch.
In the end of set rate, BYPASS will be cleared.

When prepare clock, also need to take care to avoid glitch. So
we also follow Spec to set BYPASS before RESETB changed from 0 to 1.
And add a check if the RESETB is already 0, directly return 0;

Fixes: 8646d4dcc7fb ("clk: imx: Add PLLs driver for imx8mm soc")
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
  Avoid glitch when prepare
  update commit log

 drivers/clk/imx/clk-pll14xx.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index b7213023b238..656f48b002dd 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -191,6 +191,10 @@ static int clk_pll1416x_set_rate(struct clk_hw *hw, un=
signed long drate,
 	tmp &=3D ~RST_MASK;
 	writel_relaxed(tmp, pll->base);
=20
+	/* Enable BYPASS */
+	tmp |=3D BYPASS_MASK;
+	writel(tmp, pll->base);
+
 	div_val =3D (rate->mdiv << MDIV_SHIFT) | (rate->pdiv << PDIV_SHIFT) |
 		(rate->sdiv << SDIV_SHIFT);
 	writel_relaxed(div_val, pll->base + 0x4);
@@ -250,6 +254,10 @@ static int clk_pll1443x_set_rate(struct clk_hw *hw, un=
signed long drate,
 	tmp &=3D ~RST_MASK;
 	writel_relaxed(tmp, pll->base);
=20
+	/* Enable BYPASS */
+	tmp |=3D BYPASS_MASK;
+	writel_relaxed(tmp, pll->base);
+
 	div_val =3D (rate->mdiv << MDIV_SHIFT) | (rate->pdiv << PDIV_SHIFT) |
 		(rate->sdiv << SDIV_SHIFT);
 	writel_relaxed(div_val, pll->base + 0x4);
@@ -283,16 +291,28 @@ static int clk_pll14xx_prepare(struct clk_hw *hw)
 {
 	struct clk_pll14xx *pll =3D to_clk_pll14xx(hw);
 	u32 val;
+	int ret;
=20
 	/*
 	 * RESETB =3D 1 from 0, PLL starts its normal
 	 * operation after lock time
 	 */
 	val =3D readl_relaxed(pll->base + GNRL_CTL);
+	if (val & RST_MASK)
+		return 0;
+	val |=3D BYPASS_MASK;
+	writel_relaxed(val, pll->base + GNRL_CTL);
 	val |=3D RST_MASK;
 	writel_relaxed(val, pll->base + GNRL_CTL);
=20
-	return clk_pll14xx_wait_lock(pll);
+	ret =3D clk_pll14xx_wait_lock(pll);
+	if (ret)
+		return ret;
+
+	val &=3D ~BYPASS_MASK;
+	writel_relaxed(val, pll->base + GNRL_CTL);
+
+	return 0;
 }
=20
 static int clk_pll14xx_is_prepared(struct clk_hw *hw)
--=20
2.16.4

