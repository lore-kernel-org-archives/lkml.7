Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82651CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEA7222CD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cKlEHy2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfKDGTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 01:19:34 -0500
Received: from mail-eopbgr30081.outbound.protection.outlook.com ([40.107.3.81]:56807
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbfKDGTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 01:19:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGrkTwCyj3yH31BTMFcvODLjEAtOTUN2c/vQ0xYOnqGfon7xyRADAsT67IaiVmlOCLTtfSKQgS2h4KYnZPNK2svrQedXVrwHtjAhaOwaBDOhEVjcZHOieFBMDrvU/8jCR+ArrD7aC/rPmoqMaWTKtskMhJEbbFUNGomLzJyj8GMVWFZ6FaiYWnQjLZDD9uiqm0NDNJeRSmvzJYFb+uIEg8dh1fcc6O8H1w1dHq7tbNDJZ0ZDT3AnqrIVEZpoDqqw8N0rh0E9QKpmzAHmmyESFOenppalKEepSKjWk17om7GzmTp7LBEX9/ZxMhCNwRcLc+UnkU2ajfCx9B4rAIasCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjZpky3E6BDCN4IEzZ/CJX5O1KQ96TJj5pdRVr/NdUs=;
 b=dgKHlH+x6dbL19OK15gAosLoVnhi6egA4cw16gYWM76Zw2zkmrGyGT3d9+upVxRnLJnL19gVY5IkSmzNDbGksK+jyyOVIWywkieUJNuCENzxMgqZvW9klk4+HY8SETRzE9GGtaopkPHrvFgXJYz8jtxmkYw8BugTIJwerDEGbsUXkBTRSkXtpA2u7JXtHVVzVd8HZWGDaJA6McbgN+PtntNFA3pnbom9Otph6+jkVXkrYVyRnAaBm4kxbbLxSdtdNmpUmlIBvwQ25TgESNLscPaCJh8u9AKf3S4o4/5N2RKCDbWCG5P7QhD7JF8v5yu5xcjcd7/923SCySxU6w/oyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjZpky3E6BDCN4IEzZ/CJX5O1KQ96TJj5pdRVr/NdUs=;
 b=cKlEHy2gQzUNEPyOFwqdZm/dUVKWtFvOK1uRWQkkygEGCFrnbeBoLuoOOX0G/CyVOhZo+wvlM6OmOvbPpbi2DOH3QOIimeI8Dyi/vROXE9jE2++4Imp4H/TEu/6qYOaOAfNT8b++6OJxu3jB2h/qZ50mpoiOsoW+aImorwAjXUg=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4578.eurprd04.prod.outlook.com (52.135.149.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 06:19:30 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 06:19:30 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "olof@lixom.net" <olof@lixom.net>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: defconfig: Change CONFIG_AT803X_PHY from m to y
Thread-Topic: [PATCH] arm64: defconfig: Change CONFIG_AT803X_PHY from m to y
Thread-Index: AQHVktfR/Cqvx9J0xkqO2kYL/+zNUw==
Date:   Mon, 4 Nov 2019 06:19:30 +0000
Message-ID: <1572848275-30941-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0046.apcprd03.prod.outlook.com
 (2603:1096:203:2f::34) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 215918d0-a177-4d9e-3854-08d760eef397
x-ms-traffictypediagnostic: AM0PR04MB4578:|AM0PR04MB4578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4578554F493FD9F20523C7D5887F0@AM0PR04MB4578.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(199004)(189003)(81156014)(8676002)(14454004)(8936002)(305945005)(71190400001)(81166006)(71200400001)(86362001)(50226002)(66946007)(66476007)(66556008)(476003)(2616005)(64756008)(66446008)(486006)(36756003)(52116002)(26005)(6436002)(186003)(316002)(54906003)(102836004)(110136005)(6506007)(386003)(3846002)(6116002)(14444005)(7736002)(6486002)(25786009)(99286004)(2906002)(478600001)(66066001)(44832011)(4326008)(4744005)(5660300002)(2501003)(6512007)(256004)(129723003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4578;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lVOJ8QJbD08GG6RRbWVCekGRue/Ssl+ONVvEjv8KLqdCnUJvmnOrCX0spyRznEsZRUzz+9JjBCBqfH/hoParLVIgGxMobv/cMjLDS0P/zA7o+qvE0prIyRB19Q3cjJql8plNBx3ZrNTFM2YzREA10HceNVHqH6rsd0mUI6MuJJ4u0VGzM+hn08zTRDYb4NXgUFfKCUu6B3+M3zaeet0YVh+44X7jz/zMUbvx2bNuKE+tBfx2hhDTbC3h73DtmIGY2ok0GZpoopkhj/Qt372bB+Ad6YMIqAuk6ahNAz9eKqdLVR1Bvm7r4ZhKavuJPoB35PCFirYtPx+sGfe7oB2QR/1pxZkd9dy3hFiH3tvz9yTGemUSZDkJSk+2yEdJt9/mAgBBce7goo17P2ts89HzXBJle1lAxbik8bQmk3R+KLXC5DJhZaIPsiZMwmFHxyJD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215918d0-a177-4d9e-3854-08d760eef397
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 06:19:30.5608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 114IAHUJbLMejAqq65gdWV/GMxuxhM3i5Jf7EjsfV4j9zg+Yyr+o4P2F8xPJPHN0hAE2IM6nA9wzbjXzZVjBzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4578
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

With phy-reset-gpios are enabled for i.MX8MM-EVK board, phy
will be reset. Without CONFIG_AT803X_PHY as y, board will stop
booting in NFS DHCP, because phy is not ready. So mark
CONFIG_AT803X_PHY from m to y to make board boot when using nfs rootfs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9a867ac32d4..cd778c9ea8a4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -285,7 +285,7 @@ CONFIG_SNI_AVE=3Dy
 CONFIG_SNI_NETSEC=3Dy
 CONFIG_STMMAC_ETH=3Dm
 CONFIG_MDIO_BUS_MUX_MMIOREG=3Dy
-CONFIG_AT803X_PHY=3Dm
+CONFIG_AT803X_PHY=3Dy
 CONFIG_MARVELL_PHY=3Dm
 CONFIG_MARVELL_10G_PHY=3Dm
 CONFIG_MESON_GXL_PHY=3Dm
--=20
2.16.4

