Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ECFC3A5A1
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 01:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9920E20644
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 01:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rej2dU+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfHTBzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 21:55:11 -0400
Received: from mail-eopbgr150048.outbound.protection.outlook.com ([40.107.15.48]:10574
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728773AbfHTBzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 21:55:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvNp0dsV0rtp1SFp79Ntx2JF3eGTDY/kCfhinI46b/13bC1pNF29RtrzYJVyVLdVJhyyeXJGQhHLZCiNg4uZkF7+ekx3FurtxiV+NGvs+6I9H4vFbPUS3EPA2qyeNwXBYc4O4dnh41PW6DmM2wfiSqAeEUJYTThMug1FYgdfyv0jcrHm4l1/e45PM7CtQ7AhOOYZByEuFa3xlZu10/EC4rkmrV5qjATFfQgVQReFWOVCEfShTvTgOTPf8SH9332UpPB40cobrW/9BE8tE/TdbdvFIgXRtR2uumlkdLHNkK8Nty6OGhc9YX9+gVm2Mq/IUGuXolb5r7je0Y8OjdU33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Rsp3bvn1VYswwty9Qp0NHusnBbdFVLvw46pvTZBIpM=;
 b=TLJ1Yz3p73VyIoeEZthnPu2JIGf5K42Qf30lp3of1wwjWdoGtipc/XRcMj74PuYKSCtGWDym+1dr3kh36xUFjKLJS/3JQXWRusHajywVVNxDh0sTiBYG0GVZcPdv3aUkPdSs25jceys0ktgIfqaR9D7ZzjXt8qreb8vlCCcQ2h2W6rHip3zxpodVk+mX6midohJ7XwjGUTXI8UHeTuXPveGsBXz9YJaONVc7hHMbQIFsFYfJKTWaUJk4RfLyxEsh8QEi36l9hnnRrtECss+03RYWDSX+gJA9lx89ZgSghFtQF4AythLB9xV20jFaqjmHlEL+N4IxEo3fllp+FTTXFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Rsp3bvn1VYswwty9Qp0NHusnBbdFVLvw46pvTZBIpM=;
 b=Rej2dU+VFfZaUkkDmzm/qT3nMTLhwc9Ilf5K0DQ2O1mn0GPr1rt5dwkQdvJzeF4MQpuNTVUvyeK0WbrU3tH7+AiZ5CqQvanjjO6SlnQkDxFx5nMCrcySPKFJNDsGOaO02pPmfSqVjsoLSYErK4qG8tRQi9fIp0leZm71gkuN9Vg=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5874.eurprd04.prod.outlook.com (20.178.202.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 01:55:07 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 01:55:07 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: imx8mn: fix audio pll setting
Thread-Topic: [PATCH] clk: imx: imx8mn: fix audio pll setting
Thread-Index: AQHVVvpKZsJi+GA1m0yPuh1H25F+Bw==
Date:   Tue, 20 Aug 2019 01:55:07 +0000
Message-ID: <1566264894-31788-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::36) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4efa2d5-a1e5-4f33-e9d9-08d725116d10
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB5874;
x-ms-traffictypediagnostic: AM0PR04MB5874:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB587459DAA9B5DD9C49FFBB1D88AB0@AM0PR04MB5874.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(199004)(189003)(2501003)(2906002)(478600001)(66066001)(6486002)(305945005)(4326008)(52116002)(7736002)(53936002)(5660300002)(3846002)(6116002)(102836004)(256004)(14444005)(14454004)(36756003)(6512007)(316002)(54906003)(71190400001)(186003)(81166006)(71200400001)(8936002)(81156014)(66556008)(64756008)(66446008)(66476007)(44832011)(110136005)(6506007)(25786009)(386003)(486006)(2616005)(476003)(8676002)(6436002)(86362001)(50226002)(26005)(2201001)(99286004)(66946007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5874;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UpSHm4oe0QLKY+aLMV1wS4jgz+62+sGz7t7slAeEJjKOCiIdsXYzZu3qNARltsOVrRRUCZykmZqjKZgj9Jo/XKw9rYcJUS/DXzR2ZjhwqBaLuk85Hlg5Aqo2jhZEWwrOfOURGhpgikefI2vPdhNThOGTjoXUERvRCwlhAkBMP8ybvnUqsmVoSrXg2H2JUsXx4Hw+Te/GGwmdNr4umlx+cvI80OBBPkRM/UKe/u1QYmWVBJqYKmcjQtnDlkmTWXBG9rXmjGqNBxe4H4I8fHhmXiBjO336V82+HonhAQMrvavst9zerpmtap3RD/oIrD3V4L8Rhkuub5R7comZOw87W07U8UsJtWpBJkfxaeDmhtsDRwnHU0Mi950zkdEPwSSnlaHSHXzOEdFrWU2sZRobKzKvWCEB8uEqUv0/uNb6Ikk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4efa2d5-a1e5-4f33-e9d9-08d725116d10
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 01:55:07.4838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPAX6hEMadN4tvxpDvPjW2/rqCgliLyOcXxKzYu4VOSA34DvWGztoOmRNFdxP6xsav4uRcDIf/lx9wjii/W+kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5874
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The AUDIO PLL max support 650M, so the original clk settings violate
spec. This patch makes the output 786432000 -> 393216000,
and 722534400 -> 361267200 to aligned with NXP vendor kernel without any
impact on audio functionality and go within 650MHz PLL limit.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/clk/imx/clk-imx8mn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index c5838710e1d8..0e7fb39bcb44 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -51,8 +51,8 @@ static const struct imx_pll14xx_rate_table imx8mn_pll1416=
x_tbl[] =3D {
 };
=20
 static const struct imx_pll14xx_rate_table imx8mn_audiopll_tbl[] =3D {
-	PLL_1443X_RATE(786432000U, 655, 5, 2, 23593),
-	PLL_1443X_RATE(722534400U, 301, 5, 1, 3670),
+	PLL_1443X_RATE(393216000U, 262, 2, 3, 9437),
+	PLL_1443X_RATE(361267200U, 361, 3, 3, 17511),
 };
=20
 static const struct imx_pll14xx_rate_table imx8mn_videopll_tbl[] =3D {
--=20
2.16.4

