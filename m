Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51234CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183422084B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Oqo4lcdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408269AbfJXCi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 22:38:26 -0400
Received: from mail-eopbgr10040.outbound.protection.outlook.com ([40.107.1.40]:12801
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406545AbfJXCi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:38:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecaiCWJpCK7IbUxcbMTXWs/2jajixTf6JjulitG8BuScshCP6679ypu4/ixbj++m7N8DrjnIVWri0WkCRKX5NJ1/funsIM6qcxiy3pIRD2qAJONlqTO5Dxpy3y+f6YxL3J+00PMGQo5Dc+Tz+8JONhkrCxlfP5o+lRDByCyKAxUMYV12itAAkBhTR0n7AjhCAzLx0spIhxOPXqVmxF91cAc1NSFxgi1FuGFAulIBFdrHk5bjNm1mdMyKmM9sZGIiDQfPGgejOn2Nnftty4Ebe4eqgG5Ij9i63UQcOLvFKdOSj86tPdsNZgt98JH0DOCE6JysVyA2MolGo56W+tklkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DboEOpm25KIvAGHf58YaY0IM1XFgOv8fiCylXk8YWRE=;
 b=K2TYZE8434702yIDSLzO5hWIHkWM+9yJMQ4f/2ox8uuT399R2u7m5941z0OHsRdtZEK0yPj8Pq9ZJmdbhFKge3inARZxvAFfKt8SvbpyUoJo7SSpgh4dAncNKoZen9Z4m8+2PMj0bcfQs5dL3vgy2RzIIxffYbTeEal29q5LrVZ9g/Q+Q6vHJBNDl+Wi/d7sRv5NbDOBC3Q8uVAXFMoza+SzHYu+JZtNxfN8yUthn2rmB5p21F0xPKqCeByhlPUrWq8ITy/0XDsvf6eIMqsCPTroQRyYIgD3g2mO39fIxBcdujzGknWMGjtlq62rNI+ijzyjR+4PNJwbiSKUfexgMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DboEOpm25KIvAGHf58YaY0IM1XFgOv8fiCylXk8YWRE=;
 b=Oqo4lcdqUWiRfc0cM3SyPZxRi3zegzeeO5+dOMqtKIjEHDVM+fvFhzGQQZeOOwdAdY2QxZoEIGVBaSnIAqQFVNNpATLkAPY+Uls01LyWbjuxcGorRDUIDt8k88gbFsbA8wzVjWnxKS9jZIKrEXPsvLtBFH4W97vnQlRit6oaOGM=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5315.eurprd04.prod.outlook.com (20.176.215.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Thu, 24 Oct 2019 02:38:22 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2347.030; Thu, 24 Oct 2019
 02:38:22 +0000
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
Subject: [PATCH] clk: imx: imx7d: use imx_obtain_fixed_clk_hw to simplify code
Thread-Topic: [PATCH] clk: imx: imx7d: use imx_obtain_fixed_clk_hw to simplify
 code
Thread-Index: AQHVihQanyLud71oXkiy01GBJE3P/g==
Date:   Thu, 24 Oct 2019 02:38:22 +0000
Message-ID: <1571884513-19892-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0051.apcprd03.prod.outlook.com
 (2603:1096:203:52::15) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e3c5c47-50dd-44b2-a890-08d7582b3c76
x-ms-traffictypediagnostic: AM0PR04MB5315:|AM0PR04MB5315:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5315A8B8FB2FD92DB98D0E94886A0@AM0PR04MB5315.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(199004)(189003)(478600001)(2616005)(54906003)(6486002)(102836004)(66066001)(2201001)(8676002)(110136005)(26005)(36756003)(14454004)(66446008)(316002)(66946007)(186003)(25786009)(66476007)(66556008)(2501003)(44832011)(64756008)(3846002)(52116002)(4326008)(6512007)(99286004)(256004)(7736002)(486006)(71190400001)(305945005)(386003)(71200400001)(6506007)(86362001)(81156014)(81166006)(4744005)(6116002)(2906002)(476003)(8936002)(6436002)(50226002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5315;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +yE3Y7dTAmJ7jmPVMVSgdgmjFFOmGkBKxcYtY5MTGgmpZlwVlN1CnyNR2q2BI67MsqaFsb6zJ0YZG2o32G+/JHDqGMg+xk5xKC6qPxDrAylzy4nwtuv0P2/IKSGbCQmeWbDE5isnA/gyg1rypydO2mCGdnlDY2c+V2lSa/Six5b1geBtdYKMRvb5cm3780ojDhbucHu6jGAiuza0Pzib5eu0XLEXBkf5NfXAkJyTM1FcFXQh7w4v+OGFiZSqJvL0mOFpVV74vZ1far8SJI+E6wiqAci0r+TTwXsiHvBhCYr5WKesqEOiTo/PvC5MJiOJh90wI4sHL2Y14JzgUGJxeCa7of0X1/9NJXA8WBLq7wULgl7etJMF59Pu6TgOjR/1J30/yHSzvkjDGdcrUJ0NPGrBkiWyUY/k0AF+fdIU02k0I+b46Y01QB3AS5iDMVkr
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3c5c47-50dd-44b2-a890-08d7582b3c76
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 02:38:22.1179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ymiU5JAVjc1Ol3D54ZuiPk+Jtf3BBG0LqNVWYFbmQLq5VJ7pKky6C7NIl0wzmlU1d01KcbuAHl8SNBxYuHtAA==
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
 drivers/clk/imx/clk-imx7d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index fbea774ef687..0c9f7adb41ae 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -403,8 +403,8 @@ static void __init imx7d_clocks_init(struct device_node=
 *ccm_node)
 	hws =3D clk_hw_data->hws;
=20
 	hws[IMX7D_CLK_DUMMY] =3D imx_clk_hw_fixed("dummy", 0);
-	hws[IMX7D_OSC_24M_CLK] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "osc=
"));
-	hws[IMX7D_CKIL] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "ckil"));
+	hws[IMX7D_OSC_24M_CLK] =3D imx_obtain_fixed_clk_hw(ccm_node, "osc");
+	hws[IMX7D_CKIL] =3D imx_obtain_fixed_clk_hw(ccm_node, "ckil");
=20
 	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx7d-anatop");
 	base =3D of_iomap(np, 0);
--=20
2.16.4

