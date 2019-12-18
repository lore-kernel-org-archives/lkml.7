Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A46C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16297206EE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bqshk1/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfLRC4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 21:56:52 -0500
Received: from mail-eopbgr10057.outbound.protection.outlook.com ([40.107.1.57]:18693
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726518AbfLRC4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 21:56:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VexqDKklTwlwlUjMt9M5Efuo59GRPm5PvXiAlbtAzX2oNuIz/CSHW/5etaaKdVK7bsNFcaun1ObSgoZ9zjCMl005DYVxcdMPhZ1mb0dYUrknM8U+xGcmA3n3ouav3jT9UIQXgoMwvmKEU7W7mxU/K1A7C3mfthR24R9F9BYEjmYtIi/ZpISDld3/LkEZ6odcu3IVryRywlDxCN/a3YoJYiyRH6igPNBJn30KeV9sZpXDpX4xmwkp3spa6zJJXT7wUCKJO1K+P9FKwDAPOgc8NdXXbRQQbVxvr0oM2VUuLCwUa02VtxP3il704NfyM16S4Yq1IYMfYNz6amqv6mE1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+W7TOGYnZvs4W4O6rI8JtBnt8hFdj1LQJw0Fsbmrt68=;
 b=fA23UzjAgRXIOHk1fY5ZDviF0DFQqrtmcJF6Q3r21bCuMBNVwWp7co49H+tq/JAaZAwtUECc+mLv3mg03dReGwB45Rz53T67xNFBOm/TThj/uUerQp5Qy0moANuPYmi3UobEoSGcZRWXA4muVNu4uppC4sPfVBTuErS2uYf7nsLvqxuc/4vofNc2XXbvtd6vwd5XMiMeep8SmH71aZo1+9XHN4gqxhv5oTbbPQkEvHpCAptcaU8/LMOJEj9Gxyc4bIEZ17gXkQueUrsdYCv1DVV1CkttKye9gOkDxWDW0jufX8HyID2HyGhB576v1mTvurjdRI/rLEABgriDylpZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+W7TOGYnZvs4W4O6rI8JtBnt8hFdj1LQJw0Fsbmrt68=;
 b=Bqshk1/apfvtLj5x4LTdLbnvaf9FoLzq6dLwdnzivTRple3Ef6hsFKHKtcDvMQjexLgLXoq9Ecfpe5lYCbesxYCuqrY95N3aiDmvyJPVkA5ZzdMqf7Xmrh48HjmxDJw3i5rDyB15eOG3d5GpkblCcF4o0yEL5O9Y44fcHT7DGpw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5715.eurprd04.prod.outlook.com (20.178.117.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 18 Dec 2019 02:56:46 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 02:56:46 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/3] tty: serial: fsl_lpuart: drop EARLYCON_DECLARE
Thread-Topic: [PATCH 1/3] tty: serial: fsl_lpuart: drop EARLYCON_DECLARE
Thread-Index: AQHVtU7Jwj5WRfqy902/PFYlgTitoA==
Date:   Wed, 18 Dec 2019 02:56:46 +0000
Message-ID: <1576637626-19317-2-git-send-email-peng.fan@nxp.com>
References: <1576637626-19317-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1576637626-19317-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: KL1PR01CA0100.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df429f33-2f43-4e47-2d9a-08d78365eb9a
x-ms-traffictypediagnostic: AM0PR04MB5715:|AM0PR04MB5715:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5715A66C69AF4DFDF1B587F288530@AM0PR04MB5715.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(110136005)(54906003)(316002)(71200400001)(5660300002)(26005)(186003)(66476007)(86362001)(66946007)(64756008)(66446008)(6506007)(52116002)(66556008)(8936002)(81156014)(81166006)(4326008)(2906002)(478600001)(36756003)(44832011)(2616005)(6512007)(6486002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5715;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L/ihhUBuo1iZEVcAIAfNCuDI9OSf/cY0jWyrYH9E6WyjQGq9QvfPAdJNRERlCzxRgQwBCg8g0mAeti0kiG3uOjm4/Ut+cbb6gADdL38/2zsssYooHxfQ2KP/4pUbaE9hvOSg/1DKBVRgUxrN/dfOtTUJB9KYCOhfDS4DBiY9G8Kvavio5ul/kmqUKz4IEMPRl+N+1Mtc0km0Vz1Cjc6dCcdghPi6LGi2/BtHlM87pTH1BuMvjLDHzAMPH8DscG7YWEo1YImqFoafagRBr6g3NtVKeKv0dAVn+zAp8r65UsSwMQbI1bx1QQBZa2ntiU4F0CtLdJphdvTs284+ZUaVTY//zzRaPYPK4g7wUoCodM/9dp7rkPK8AqUhhyMGxNRtRzmLL6WXjkb1jWM7FDA/1110q77tTB7xNHB0/e9WTn319uYdqp+NjH7AjxR9yvZF
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df429f33-2f43-4e47-2d9a-08d78365eb9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 02:56:46.7697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5cuNTeGRXleUnkl/eZIDZRa67J32Ei5lrh8dW2awLTrylcW3lLzJUGgTAJxkm6kBvyHdq//d4dUixJvb9K0h+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5715
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

EARLYCON_DECLARE is just a wrapper of OF_EARLYCON_DECLARE,
since we already have OF_EARLYCON_DECLARE for lpuart and lpuart32,
so no need EARLYCON_DECLARE.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuar=
t.c
index 4e128d19e0ad..54c7735406f8 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2397,8 +2397,6 @@ OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart", lpuar=
t_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1021a-lpuart", lpuart32_early_console=
_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart", lpuart32_imx_early_con=
sole_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx8qxp-lpuart", lpuart32_imx_early_con=
sole_setup);
-EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
-EARLYCON_DECLARE(lpuart32, lpuart32_early_console_setup);
=20
 #define LPUART_CONSOLE	(&lpuart_console)
 #define LPUART32_CONSOLE	(&lpuart32_console)
--=20
2.16.4

