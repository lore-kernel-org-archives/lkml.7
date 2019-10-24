Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8121CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9380920679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QB58JwM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437229AbfJXC7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 22:59:36 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:3621
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390589AbfJXC7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:59:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRafDHBqfZb4r3hc/hEOOWBgpLNiUdkoLAm59/EWeuVlEJvg3vjcfqKJeNYFX9WnPXR+cNCeIqnaauVcr0cEJ/jRCKfJEVKo/obgUbpGvt4y7i+UetFw8HH2423HhTB9duTX8ODLCpGLo/kGq5/bppRv9oh9sXuQtgmjGjksLx32s6fLYIf4+xFacQETiiP8qXj09Ox1ycQn3y1J+2CFXBY/Cuug7zawYlh0OzT8Yti1i8B0MA24A5Xt53Gd91NL79c/IH7tcTg5z2IKGc2yx1JR0k7uW0DqpNDk5kdDL8VK4JqnyseZ4VyXcnlgpQCvzveBjKgD1DEcF0hTp/0syA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WulYEXx1tckffS41JTOkNk+Lh3iYkyPwFfydyHwiX/Y=;
 b=LY/xdIv0DOyLqgb64HuPTduAh/qzVl+k+lhLuj0kz9jnWt4K0Ce2nshPyCzeER3vVp/NIzNRac333bgt+DQyvPa9oxuRQpQ3Tma9yhJG1gQOq1rjGd2+hkVYcUsF0hzj/Ink3p7l5sCaoHdzSlnubg9gXTVaCzFtXIpzVKQw8Zfq8KLXAtlZp2MFIHaW9vyd4/Zp5uxtvhJqUW12m+g4PAVn1EcuGDuQJF78wEWl0693NxYqswHQ4I4NdXBtpyMoU0PljNlz0LwTg5QOZ4LKGsi+OXv3UCuEd6n6m1WjLcFaSej+B4iqg8NYGGESeUOdgyrpTzlEplWbTZdraGKQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WulYEXx1tckffS41JTOkNk+Lh3iYkyPwFfydyHwiX/Y=;
 b=QB58JwM8kodciUtw7RASOMHLJGnepVHlQryMaTLJudQll/7D2Th9UOS/V/OJM88qPYl08inDRlwwVH8IAW/UF5NCG6NFMgo9icIVgV0l+JOSbfD0FZnQgcid6o0HkCV+T1ZNQzcek42b8GK5v509nGdOvR6kdsul+26pOrSBBSE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6609.eurprd04.prod.outlook.com (20.179.252.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Thu, 24 Oct 2019 02:59:32 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2347.030; Thu, 24 Oct 2019
 02:59:32 +0000
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
Subject: [PATCH V2 1/3] clk: imx: imx6sll: use imx_obtain_fixed_clk_hw to
 simplify code
Thread-Topic: [PATCH V2 1/3] clk: imx: imx6sll: use imx_obtain_fixed_clk_hw to
 simplify code
Thread-Index: AQHVihcPoLnaBDJtHk+gtL+lua5mZg==
Date:   Thu, 24 Oct 2019 02:59:32 +0000
Message-ID: <1571885777-21662-2-git-send-email-peng.fan@nxp.com>
References: <1571885777-21662-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1571885777-21662-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0081.apcprd04.prod.outlook.com
 (2603:1096:202:15::25) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1fca255-321b-4905-7435-08d7582e31aa
x-ms-traffictypediagnostic: AM0PR04MB6609:|AM0PR04MB6609:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6609F08ABFFF618869B0843D886A0@AM0PR04MB6609.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(199004)(189003)(305945005)(486006)(26005)(476003)(102836004)(2616005)(44832011)(52116002)(7736002)(446003)(6506007)(386003)(11346002)(71190400001)(64756008)(71200400001)(66556008)(66446008)(66476007)(66946007)(316002)(186003)(76176011)(54906003)(5660300002)(256004)(110136005)(86362001)(478600001)(99286004)(25786009)(14454004)(2501003)(50226002)(2201001)(6436002)(6486002)(2906002)(8676002)(81156014)(81166006)(66066001)(6512007)(36756003)(8936002)(4326008)(6116002)(3846002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6609;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sb69ogiuiRi3sl7uSeflZybLni5y5Z5wTSMpedvwqwwQ6A2Z/aF09edKyIfik/pd80+oIrpr7w6R4shx/3t7lbET01lkUgMaumCMIIJ9zBtERbdE4IIVvQiR5KIjMaMsP0TCiUlVcE9g48/+Wf1Mj7190RyKm1c4nwf2zhlmq/2mkUqeSvtzwm9HmMbWaFWDzOtNFD7aduHGqyfFOfB8I7YiLWn0EWs/d6KS3/5NmnTfN0yAt6W3aZBpLZbOwmBSD7autOo9qwhcQI6mGh2ltZapo/Rz6Bl3hPXyQ0xf0Od/lPM1km1+/CVpBeqsiNRpidMQIYICm6hQDvwrixGt9MVcNnlo/3HhNx6oEP+PCNmV/rlPS8w/6Qx9JzfruC4NAaANuV53xmHscp6ObchAe5ySwjg6o0LkfN5LEn99nq5k4WpInoiNrX/WASQorrfA
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fca255-321b-4905-7435-08d7582e31aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 02:59:32.2638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CYZ2PU8VFw23N+3S/ffvqFQzg8CyYwWraOUcVq93a6oE/7+6+l3cGhBO0ZgYmqTML4pR31MRDQjRKLZtAKDw4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6609
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

imx_obtain_fixed_clk_hw could be used to simplify code to replace
__clk_get_hw(of_clk_get_by_name(node, "name"))

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx6sll.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sll.c b/drivers/clk/imx/clk-imx6sll.c
index 5f3e92c09a5e..8e8288bda4d0 100644
--- a/drivers/clk/imx/clk-imx6sll.c
+++ b/drivers/clk/imx/clk-imx6sll.c
@@ -107,12 +107,12 @@ static void __init imx6sll_clocks_init(struct device_=
node *ccm_node)
=20
 	hws[IMX6SLL_CLK_DUMMY] =3D imx_clk_hw_fixed("dummy", 0);
=20
-	hws[IMX6SLL_CLK_CKIL] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "ckil=
"));
-	hws[IMX6SLL_CLK_OSC] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "osc")=
);
+	hws[IMX6SLL_CLK_CKIL] =3D imx_obtain_fixed_clk_hw(ccm_node, "ckil");
+	hws[IMX6SLL_CLK_OSC] =3D imx_obtain_fixed_clk_hw(ccm_node, "osc");
=20
 	/* ipp_di clock is external input */
-	hws[IMX6SLL_CLK_IPP_DI0] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "i=
pp_di0"));
-	hws[IMX6SLL_CLK_IPP_DI1] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "i=
pp_di1"));
+	hws[IMX6SLL_CLK_IPP_DI0] =3D imx_obtain_fixed_clk_hw(ccm_node, "ipp_di0")=
;
+	hws[IMX6SLL_CLK_IPP_DI1] =3D imx_obtain_fixed_clk_hw(ccm_node, "ipp_di1")=
;
=20
 	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx6sll-anatop");
 	base =3D of_iomap(np, 0);
--=20
2.16.4

