Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0187BCA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14382084B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oM13Smy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437039AbfJXCa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 22:30:56 -0400
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]:28551
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437004AbfJXCay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:30:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqhEk/HgIT+W5hVrVEtyEh1cbkLYO3a0lIhmgZSrksBT2hF8q8o1RgaUKakwxkbB7ESH0XTsz3hAcYcpikPiFU1sOKNDJsfeLav1/24EDMG+cae2IE6iXtien09Fi5ZRp5w5mwFhXNqFb7hMLUzcTqHjYGecXdUo0w6iw55aOpr08VAx0r+JYcpPsk5jkNEfSdhwUTOfcel5g1ygm6A6OIhEuhxn5aZuKGZ6gcA3QNO3sEHm7phR4l3PpHdOjc9ddjNcXcHYM1BMmVVVrs7jKDEoi0S1rOrtPj31OyYpsSRCmN20PdsS2D3M6vpKAlE02F/A5YxRNgPjjbGEBFRRhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeUl/ugzJjf++UL5sfIw455b06HC68ZQ9OlcHWchWHQ=;
 b=X00I/AW7OcGjw9pJi+fRm1qjC/9/Gh0tiILsGmpN0ApT1OfoVAvcP+c0/zYzRFClt/pGlASZHfh7sls3kvsJzyFoKjjEi2BJEim2bqgDecVUT4btxk+3cPDGj3dhQ4lOHreGiitbEamziZDmt0aXtLmqVgTfSy4HG516mvCk/iARy5haRhtttKf5n2AJzDpYoLem9+KyFTs2Xo3LqM67Rer0hou9OsOumRyjZUX22nHZqDZ6od9IcJvx7WgPD5J93D/whvZYFgaKo6E6frIN3IJ5GO3iTYyW9gYgu+YaZwS3rsKH2bjRdo8/w8+7kkoDzVMR4KlBL4ZZwziljDE4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeUl/ugzJjf++UL5sfIw455b06HC68ZQ9OlcHWchWHQ=;
 b=oM13Smy4LeyqZNLTwhEySZ5E/Pp8QndJCsHxa7dPJjgvu1zwMwLP+vopoRq1J5BzBdROLY+3t7pq/tHeRsOAtyNi13xaWpRBFoBG5m/YkF47rgo8wI4RyUphGdXCJW1ol9WxlII7wVGcDOblfe99a2y5J1MghpQ2PBtDFJmhvuU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5315.eurprd04.prod.outlook.com (20.176.215.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Thu, 24 Oct 2019 02:30:51 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2347.030; Thu, 24 Oct 2019
 02:30:51 +0000
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
Subject: [PATCH 2/3] clk: imx: imx6sx: use imx_obtain_fixed_clk_hw to simplify
 code
Thread-Topic: [PATCH 2/3] clk: imx: imx6sx: use imx_obtain_fixed_clk_hw to
 simplify code
Thread-Index: AQHVihMNtHdpWr4KtECpUSBdvfHoXw==
Date:   Thu, 24 Oct 2019 02:30:51 +0000
Message-ID: <1571884049-29263-3-git-send-email-peng.fan@nxp.com>
References: <1571884049-29263-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1571884049-29263-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b9ac28c5-b92f-4be2-d066-08d7582a3037
x-ms-traffictypediagnostic: AM0PR04MB5315:|AM0PR04MB5315:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5315F0DDE05E2FC79B5D0E35886A0@AM0PR04MB5315.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:862;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(199004)(189003)(256004)(99286004)(6512007)(52116002)(3846002)(4326008)(476003)(76176011)(446003)(8936002)(2906002)(5660300002)(6436002)(11346002)(50226002)(6116002)(6506007)(486006)(7736002)(71190400001)(71200400001)(386003)(305945005)(86362001)(81166006)(81156014)(2201001)(8676002)(66066001)(110136005)(26005)(6486002)(54906003)(2616005)(102836004)(478600001)(316002)(66446008)(2501003)(66556008)(66476007)(64756008)(44832011)(186003)(66946007)(25786009)(36756003)(14454004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5315;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ES0H+CwZFM1TZDGmuTJh/vV2DkY2RB9BY/UHtI2ua3FNllXb0LyPu2CRCLeorSf0lGdJnOc0hRX3uH43d3HVDTVmjoVVan3PK/Az/d82A7YRlscjaZx8zlcWznRWfTgnIzKbymiwiObkimNnIkDuwgIBSv4f36/kxuz6Oy4egbPUFE4sgqDSN1on5S2m5WlwVNLf+OMQmU3w5wb3iMkicLwMjuLODuGGIdu7QreAWnVxHIk8zN1x8j+nlHG4Fg5SVmbnKlE6jzH0kglwYJRSDGnu97g/Df2LPjM/A7mocFYw3wJxNZVrtM19uzWSCzmZzJ2BRlkgjmvHi28KN210BR364TgyKR3JTc05aNVEUsfWbM1UUSQAzQNFw8/Eo2zLYMdLZlE7AzpgQ9m9L0ybrWzvC45PFpfz5uG/WOBAu0t5AS6K7KBu9JsIY920a6dq
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ac28c5-b92f-4be2-d066-08d7582a3037
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 02:30:51.8478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zn1zMRC2TJup5bEIx0GfmLsbOil25ou79oUAMLx9PTJLYZNmvOLyQlTxyHKO+iIpXLsweP7M0PVcX16omgOaOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5315
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

imx_obtain_fixed_clk_hw could be used to simplify code to replace
__clk_get_hw(of_clk_get_by_name(node, "name"))

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx6sx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index c4685c01929a..89ba71271e5c 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -139,16 +139,16 @@ static void __init imx6sx_clocks_init(struct device_n=
ode *ccm_node)
=20
 	hws[IMX6SX_CLK_DUMMY] =3D imx_clk_hw_fixed("dummy", 0);
=20
-	hws[IMX6SX_CLK_CKIL] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "ckil"=
));
-	hws[IMX6SX_CLK_OSC] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "osc"))=
;
+	hws[IMX6SX_CLK_CKIL] =3D imx_obtain_fixed_clk_hw(ccm_node, "ckil");
+	hws[IMX6SX_CLK_OSC] =3D imx_obtain_fixed_clk_hw(ccm_node, "osc");
=20
 	/* ipp_di clock is external input */
-	hws[IMX6SX_CLK_IPP_DI0] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "ip=
p_di0"));
-	hws[IMX6SX_CLK_IPP_DI1] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "ip=
p_di1"));
+	hws[IMX6SX_CLK_IPP_DI0] =3D imx_obtain_fixed_clk_hw(ccm_node, "ipp_di0");
+	hws[IMX6SX_CLK_IPP_DI1] =3D imx_obtain_fixed_clk_hw(ccm_node, "ipp_di1");
=20
 	/* Clock source from external clock via CLK1/2 PAD */
-	hws[IMX6SX_CLK_ANACLK1] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "an=
aclk1"));
-	hws[IMX6SX_CLK_ANACLK2] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "an=
aclk2"));
+	hws[IMX6SX_CLK_ANACLK1] =3D imx_obtain_fixed_clk_hw(ccm_node, "anaclk1");
+	hws[IMX6SX_CLK_ANACLK2] =3D imx_obtain_fixed_clk_hw(ccm_node, "anaclk2");
=20
 	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx6sx-anatop");
 	base =3D of_iomap(np, 0);
--=20
2.16.4

