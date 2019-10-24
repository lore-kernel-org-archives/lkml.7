Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C1ACA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FDA2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Exo5F42e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437027AbfJXCav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 22:30:51 -0400
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:33054
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437004AbfJXCau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:30:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7/CJ3MB+50TqH9FgiIRXjZl++j7RVhEH+iZEdLRqroEk1Mx5j3NSHnqSMh1nNMnCMZWu0hlXoaZaZlXq+cFoh/JJLSeFm9kVe1jK/IJIWWAu+qkf0Gcoh/SbsRoNf5LCZ3PXShspjS9rifKW0BW3IqatxxDVTrnzaCAXeR2QL8lR/WOuu3xVHM6TUlkraIgOLD+lC1s6FPQQXNnxV3gopFS6DSFbyw9Ukc0wlPiZVePr1o61Hf0ODCJuquzujCSX+4XfJTlPi3FgxgrM0nvnhS7EQIoG8QRtpcx9SQ0IrY+flB2FBXooTPzrE8Jrv1f8REJVCl1Wj0XEwr0SY5lOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WulYEXx1tckffS41JTOkNk+Lh3iYkyPwFfydyHwiX/Y=;
 b=Mzvizwq03Q/CEKLaY+AXIY9OLcX8u6bv3RFJS8yXaGisRqZgkD3Fjz56UpPuh+bX5pFLetYoj6yeOALo0dsI8QeGMPcd78hPA0VFO5cxVvHUYcDljpDl9r12yBhxHheseHBAf52qdRs+rxdUavHHI9dVNrvdqWTNHCsgr4QYIxRubVbWBA0RvZVWXgH2JRudBXA/3ZaALMgDeJzx6Ps0uumzeYGbO3Phz1Z+KOlKVV7pszLlz6gnXRtDOJP3m6b4cA8kUkkhwPKooEd2HCSnEPQ+7zLhtrNmOjjmgsXYWCv6mMnG+bx66weJoBQg+GhPEQTMLTO1TPw8Ty6szynOIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WulYEXx1tckffS41JTOkNk+Lh3iYkyPwFfydyHwiX/Y=;
 b=Exo5F42eHCVmV3O9bO4Sy5Gd1kKJBYDSMr9asloMxI8F5vrr8tcSUQoIbHRdCnzhWqXtMWiMFrAG5YhBKG85r7V+QyxF8WBpvVBNfrYXU91vioHsTRR/KIDL/DFtMYP3yJPJuwakiaDRz91a74egEnw/zCFvYKcgPd7yQjTZXNw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5315.eurprd04.prod.outlook.com (20.176.215.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Thu, 24 Oct 2019 02:30:46 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2347.030; Thu, 24 Oct 2019
 02:30:46 +0000
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
Subject: [PATCH 1/3] clk: imx: imx6sll: use imx_obtain_fixed_clk_hw to
 simplify code
Thread-Topic: [PATCH 1/3] clk: imx: imx6sll: use imx_obtain_fixed_clk_hw to
 simplify code
Thread-Index: AQHVihMKzo2n8fb25U+lPu3sBErwkA==
Date:   Thu, 24 Oct 2019 02:30:46 +0000
Message-ID: <1571884049-29263-2-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: a9072baa-0780-4e47-3105-08d7582a2d34
x-ms-traffictypediagnostic: AM0PR04MB5315:|AM0PR04MB5315:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB53157DB11B6CDDC31C2B91F4886A0@AM0PR04MB5315.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(199004)(189003)(256004)(99286004)(6512007)(52116002)(3846002)(4326008)(476003)(76176011)(446003)(8936002)(2906002)(5660300002)(6436002)(11346002)(50226002)(6116002)(6506007)(486006)(7736002)(71190400001)(71200400001)(386003)(305945005)(86362001)(81166006)(81156014)(2201001)(8676002)(66066001)(110136005)(26005)(6486002)(54906003)(2616005)(102836004)(478600001)(316002)(66446008)(2501003)(66556008)(66476007)(64756008)(44832011)(186003)(66946007)(25786009)(36756003)(14454004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5315;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rZUcBlaSOhsDiQnxTAmYu6TB9UipJwGzmrl1n00d1x2AjUqw1liTCXtgtF2ZdsOZwWrs4q62GQE7lyqN4aSpI4wrTlk4/U0d5vkdmXpkImWAzMebMW1UTiU0jFKMHBAz9ZLK0FBHm/PaXoJmlxdFl2HD1qG1vntlpwH5QggQCPSb4Izant0H0V2ZLn12oVxMhrCVA30NJ+se3yMk1sdtKH8+IY9aYFq8O4mvQj635p26Tcflgn89pJrrXeX8sEy69mEHttfEK8s+P7QlVb+QUhun/z+uu/p4RlH1MpG/Sr40CRGY99FnSoR/Xa7jfQq0xJ+X77td0n1yuTWb7kA7WndpY1sHUe2f9SHDOlbPKrXjUmWXrtzvbqk9Of2IPO4L9A+fvdrRLmhhlCDaYf7fSOiKjS+NLox+r7pwMxN72GfOV/q78Y7qmhgee6M8D75N
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9072baa-0780-4e47-3105-08d7582a2d34
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 02:30:46.8049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eex4RfclVtiQzZp114QTqOQiQwsz7JTCh19j15a1baRb3H7/yFl85UDUtVFqraZKQeminA8R7XAvpFPkSuIdAg==
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

