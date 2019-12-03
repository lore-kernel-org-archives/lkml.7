Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CA9C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 02:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBB920684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 02:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="acJMh89W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfLCCCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 21:02:44 -0500
Received: from mail-eopbgr20053.outbound.protection.outlook.com ([40.107.2.53]:60646
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbfLCCCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 21:02:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Az94Avch12g2jQ26pTo/XJLWhscL2TpAnfdhTmwDHOHBukHPRO5mVmPZYX5qQXzNIqLjKQu6du1/LwhripZvEDFYK7Z3G4mdTm52unALO8jjpKsYlFWRMciPySE/gpqyj22xHLxPmHP3SVWUrwQKTMuTeS3Ww1N7mbhWa9FpYylEONNixEVSN8IFN07RoV2kUs4GWskHKhpLAFst5qCUq190Aj3KQlDWVp350Pl1shXkC0+K6KXQlml4Wn9+OaadObKfPkpWe8Yqbz7j945WwE1FehkwMhpJIZX09nty7qCqa7pstD0QK07RokhPZZwmB9SZ+Tod4k5WAkUHx6CDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGbcCCHNhSmL7RPRjMe2FpX229Cd7Hzol2ich7aW29o=;
 b=n1ysxc7vYCvigt/wah48VfntYyg7xEGGh0R/2jLN1/areH05klVYyOSUCaZRs8qii2U7pJ3J9mSYmoAD4VRPTnGsP1KWO5nbybfs4owBl3iFoi6PXw5+RiA9k+i95cf0VJtxidw7KsPvRcRiGNNwloL2Gf0C2mtaHnIDDjETunRTkHCAeleGc9bdIU5Mt8+3r5dNdjWwaO2k0sXYOgconihtvIYQcner6BXoCZg19JzHXh9fDJWEqvl0tLcauVg+K/L8sAtLn8wHgccRRht6ZIbyKOdxCrSXEeWVxLc0Ov2QXOh7xv6copfNF6jwKvy1UDZ9wdPPGFma6NRknFJlrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGbcCCHNhSmL7RPRjMe2FpX229Cd7Hzol2ich7aW29o=;
 b=acJMh89WmARz+e6AbEC4W44aA7BxL4eqOStJDbpE4tH5pYBTFdCPTIsGLqYgKa0ZwX44oar3yGXD8OcTTh6RVX0ao/pofaEZMcR9SU4AWUNyNP3lXSfnf6VfYWjToNiU2MJU851B1MmSKjP5i14NNq+i2DMp1U9e/i8yl18u7i0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6865.eurprd04.prod.outlook.com (52.132.213.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 02:02:37 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 02:02:37 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] clk: imx: clk-composite-8m: add lock to gate/mux
Thread-Topic: [PATCH V2] clk: imx: clk-composite-8m: add lock to gate/mux
Thread-Index: AQHVqX28P68N2YUtS06IIycp0VIKnw==
Date:   Tue, 3 Dec 2019 02:02:37 +0000
Message-ID: <1575338427-22347-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0203.apcprd02.prod.outlook.com
 (2603:1096:201:20::15) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8e2c52f-6a08-47e1-791a-08d77794deca
x-ms-traffictypediagnostic: AM0PR04MB6865:|AM0PR04MB6865:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB68658BD622CD663DEE8FC76E88420@AM0PR04MB6865.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(199004)(189003)(25786009)(81166006)(6512007)(3846002)(81156014)(2906002)(305945005)(6116002)(6636002)(478600001)(71200400001)(71190400001)(26005)(66066001)(99286004)(66946007)(102836004)(36756003)(8676002)(52116002)(386003)(6506007)(66556008)(64756008)(66476007)(66446008)(54906003)(2201001)(44832011)(86362001)(8936002)(2501003)(2616005)(14444005)(5660300002)(256004)(186003)(4326008)(6486002)(14454004)(7736002)(6436002)(110136005)(50226002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6865;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iCLXU12D60at2/dhHoQsHEYQE4h3cv2XCeP4tek8LOqL3T9rnUZfuS0nnaKeo4HAld+p55dLrel6IRbTRO9i8yN4E2zHM8Z9knIllTZmZjA6IyJHl2K6N3IUnt3rSJ9I79R0F83DecoG4EraUQnL5dUV93T6nCpUs+2uyWjOGoPEU25swhL8s3LqDjfw6PyurdfaA3anYEcGXLGs0wHe+xZiGD799bWuKzxgXtH5ahh5M0fKwlRUauESdhCuRIKhvAVz5vBJxKSIEJWXdPxHOhYmxKpYfyjewlWxPjepnCGDcaYZL9vXuVZLTKDhGiBskjiwBPIP9px5qlq6UlGgDc0/x26gwck+GaPNhGanadFL+cULvEPInnurXrv/522ZRSXjxdZ1c+Srd1u7OKNjnpNPGm1fA+OlExmFZUJ7Do9To7PimTGXJvPQ/QHAZxdE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e2c52f-6a08-47e1-791a-08d77794deca
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 02:02:37.6978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XsPmB/9gKuGEw8Nh0VYfBdOxoFh1aFsJxQfq2C1a20dVLvkZ/HQgh7zIgpbsd4q2245COecVCYOMs8DmNotiYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6865
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is a lock to divider in the composite driver, but that's not
enough. lock to gate/mux are also needed to provide exclusive access
to the register.

Fixes: d3ff9728134e ("clk: imx: Add imx composite clock")
Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Add Shawn's tag and typo fix.

 drivers/clk/imx/clk-composite-8m.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-compo=
site-8m.c
index e0f25983e80f..20f7c91c03d2 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -142,6 +142,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char =
*name,
 	mux->reg =3D reg;
 	mux->shift =3D PCG_PCS_SHIFT;
 	mux->mask =3D PCG_PCS_MASK;
+	mux->lock =3D &imx_ccm_lock;
=20
 	div =3D kzalloc(sizeof(*div), GFP_KERNEL);
 	if (!div)
@@ -161,6 +162,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char =
*name,
 	gate_hw =3D &gate->hw;
 	gate->reg =3D reg;
 	gate->bit_idx =3D PCG_CGC_SHIFT;
+	gate->lock =3D &imx_ccm_lock;
=20
 	hw =3D clk_hw_register_composite(NULL, name, parent_names, num_parents,
 			mux_hw, &clk_mux_ops, div_hw,
--=20
2.16.4

