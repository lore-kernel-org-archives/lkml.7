Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C129ECA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840E4217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B0eLz3pe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfKDKLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:11:38 -0500
Received: from mail-eopbgr00086.outbound.protection.outlook.com ([40.107.0.86]:3559
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728064AbfKDKLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:11:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlYGHsxjlZNuaTJrUaL/6LU5EwJflHPKG/56OwlLHqFWL0Gw8liSTJyMPEx3HvDrVrr/MWVAGDlT070rQSqxPn0Pm95YCb+7zC3bfkhspSBl/j+nkeZa2S94iUs4fht1sgPYmaPXffDtXD6BFHkrszmstCYWHAIk+M0J58iqNWjTBURdVhaeHX6APbywXeTOlWnPQLW+vSj02DAB6/frbGOgkRdyId8ivGUajQTMR9l3RnoApgHqQab1aLvCn0AG1tBDVkGzT2T3owqg7pe8AddgiR5qf7LxqSE+vnMvaGpOuKHSQygP5Rgv/KEIqu3hutnTolfEX21AlEX6juO66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXNZ4gtJEZXkyLS5eARYxheAL8v3cyxs7r5hvQT8Sko=;
 b=E9ouPnI41nesQ0p4iD/f8ySJovwQxRt4cvMWvNRGlcJ8Sz4mylElXhz4W1VB2ODI6pfUt4W9TIgJ88fultmpP9aIbW+ioqYcuk+5i88p/AkZcE0WEBYmfm77Uannd8Q+eqzz0Q5DvUuecUCfM45PO44W2GfFSLVSwgqmOvIUpnihD8O1wNQEBbJbPLiNLHHwuRU5ogiTM+cL7N2vBxAQIt9VCZFrxmqw4NebaJMlTWWK/KKDX9mUBp9O1k1XndLC/x0invD/WLrQG5lUhZn983BbtBNoq50fLTSIYWqhmdNePZr3P1eQy4NGAsS1pSrHGImpXZ6DQXkzaJzEqpty9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXNZ4gtJEZXkyLS5eARYxheAL8v3cyxs7r5hvQT8Sko=;
 b=B0eLz3peHIeD3qc9qp0NSBqcr4KAuSML26LR8YkkmsLomtbdLi6iXbv1ngyL4Zl7EVFL8plrWrXXc3WLNC5q88DbniczpRsqhO3HM5Xf0/DdnJ51XmjDpfs/AiSW47vj8knDEo6DGwkOLXkVpZtvL/zty0fZIbIC7PneQHa7b8A=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6100.eurprd04.prod.outlook.com (20.179.33.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 10:11:33 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 10:11:33 +0000
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
Subject: [PATCH 1/2] clk: imx: clk-divider-gate: typo fix
Thread-Topic: [PATCH 1/2] clk: imx: clk-divider-gate: typo fix
Thread-Index: AQHVkvg7LUdk4W5CkUy0CpJNIA6DVQ==
Date:   Mon, 4 Nov 2019 10:11:33 +0000
Message-ID: <1572862200-29923-1-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: 5bbe008d-fd76-487e-4fc5-08d7610f5e0b
x-ms-traffictypediagnostic: AM0PR04MB6100:|AM0PR04MB6100:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB61005CABEB0F77B4C716AE96887F0@AM0PR04MB6100.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(199004)(189003)(256004)(86362001)(4326008)(110136005)(54906003)(486006)(14444005)(2201001)(6436002)(6486002)(2906002)(316002)(8676002)(26005)(186003)(6116002)(3846002)(64756008)(66476007)(66556008)(66446008)(66066001)(66946007)(8936002)(50226002)(25786009)(71190400001)(476003)(5660300002)(478600001)(81166006)(52116002)(81156014)(2616005)(44832011)(14454004)(102836004)(6512007)(99286004)(6506007)(386003)(36756003)(305945005)(7736002)(71200400001)(2501003)(6636002)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6100;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gdydCnzWDXWWmSfIzlZiXfYhyrjpienySeAkiqkd8ka/4WaxLqT2ZuzuKeJeuCBpewoWtHQn9PQzgkjxVCgI0Mt8uAoVnctrZ8cqBV2qoGpki83WI2tfXH+fe/lTSIJFlUwvpgAzjIFJdpk7BGcLE+AgyBKIq+XFoGSPDcuwpKztui/+HuE36NuA8sakzHTNVgLPgSAUekSK8dtJDy1k34sFyl7R3lN+0qgdfWtwPBvMd+4iCWztsbNHLbiHEH3czeNGQCVs3X/skAzt4tDe1QSOhRsQd2w1wN8qOPGaWGw8nBSeZ/xAE3GKntLy2ZDdcPu+pUsTa3baVzK7gjpWgXW+4D/laW1iBcqRAjnbjL9jLOX7MaW8q2W3EcBzKFAN1ZRLLPDk7g0YyZjAB0zixcZqCfl64UBcYkN+nuS/pRY2i2Ydhjo3DH/hItlWZQn+
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbe008d-fd76-487e-4fc5-08d7610f5e0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 10:11:33.0555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZvEJLW3bn/SIE+R40QjHPEJ4f/b5m/dfeSh1YSv/U86Uh7MiSHNSjogz4eWgJCIIPEjWtbTT/30IdSllnkhUGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

resue->reuse

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-divider-gate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-divider-gate.c b/drivers/clk/imx/clk-divid=
er-gate.c
index 2a8352a316c7..214e18eb2b22 100644
--- a/drivers/clk/imx/clk-divider-gate.c
+++ b/drivers/clk/imx/clk-divider-gate.c
@@ -167,7 +167,7 @@ static const struct clk_ops clk_divider_gate_ops =3D {
 };
=20
 /*
- * NOTE: In order to resue the most code from the common divider,
+ * NOTE: In order to reuse the most code from the common divider,
  * we also design our divider following the way that provids an extra
  * clk_divider_flags, however it's fixed to CLK_DIVIDER_ONE_BASED by
  * default as our HW is. Besides that it supports only CLK_DIVIDER_READ_ON=
LY
--=20
2.16.4

