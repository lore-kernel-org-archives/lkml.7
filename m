Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23023C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAEE2467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KN4ZHD7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfLTGNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 01:13:45 -0500
Received: from mail-eopbgr130072.outbound.protection.outlook.com ([40.107.13.72]:29146
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfLTGNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:13:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cs/bp471gfM0NSLGN9FxtjY4905Tr4TUvsTJzcM2b0GBX0dJthcQ/IvHNPF57n/E6tn6IplrHcADMprq8ygbpgPM8HFT69bTNYa12MytlyMFJANvseyaPgT98x5urHjdxuTa1xj28lQkAcU+Hyp1AyiJYJCHe2mmpkT3600jm674JKus5emjbaZA5n4keU93yxGvsQtJN9zua8RLPnNOOpqV+n7LPizCgfXlfmtFdOhSGa//Ed9uqq6UDOPlLNA4+6hQQw+pPEnRLM3uSkRzsyBRGC72B5QjpOtWYkWggjLFL0dZaSgzcRnD5UTJM6I3dKl5PGVxT/WCLKvyegcj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+W7TOGYnZvs4W4O6rI8JtBnt8hFdj1LQJw0Fsbmrt68=;
 b=ldB7miMZbULB0KQsGebhHxUS5t+PGNofRrzCgkZdULPIuny0EV+OyxEq9DdmLsqkNyRkMgg8XufiDA0jAPnTTfmwnY6eusGll8gaqDtg+9brgAkzJkfqfudM8jLgT8LXYJuE3qA/BhdyRWpdoRP7vTDPp3mBQwThf0rtVwe9ZK03bgnXSV/tm37Rh0xDRCiPIMdL9XKazNykXegbn5Heb0F3HhAHlHFIbAjOyq/DGzGv2/Y7lGePTenTJWuGcc4/iWBOocTCtdI1wJfgFR8fAfwBVfdWszkEfzpN81sqHd3mvKGKP0I8UeOAYvFUC7QIdceAARNZGPpST4WBA/txLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+W7TOGYnZvs4W4O6rI8JtBnt8hFdj1LQJw0Fsbmrt68=;
 b=KN4ZHD7Ai6vuyI/8iAf4GImMmOF5hA/QMGHj95MzNWoln1mb0fN2TyHmXaw8Ct+BdAUbn9OoWJAQJj18p5ZKoj6I+HgLVLfyFGWAIZAKBQeFZXulMLtxxkyr0kxDgiA7LIvTB9K1ULWl/r15h3+k1bshrpnbp9zJn1t6xm/FWaU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4801.eurprd04.prod.outlook.com (20.177.41.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Fri, 20 Dec 2019 06:13:33 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2559.015; Fri, 20 Dec 2019
 06:13:33 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/3] tty: serial: fsl_lpuart: drop EARLYCON_DECLARE
Thread-Topic: [PATCH V2 1/3] tty: serial: fsl_lpuart: drop EARLYCON_DECLARE
Thread-Index: AQHVtvybcW9f1LWooUuxoK1plutw+A==
Date:   Fri, 20 Dec 2019 06:13:33 +0000
Message-ID: <1576822230-23125-2-git-send-email-peng.fan@nxp.com>
References: <1576822230-23125-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1576822230-23125-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d49d3a6d-aaab-4275-2b86-08d78513bdd1
x-ms-traffictypediagnostic: AM0PR04MB4801:|AM0PR04MB4801:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB480105D9FBF6DAED07A5D899882D0@AM0PR04MB4801.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(316002)(110136005)(66476007)(66556008)(5660300002)(64756008)(66446008)(26005)(81166006)(81156014)(71200400001)(36756003)(6486002)(4326008)(6512007)(186003)(2906002)(86362001)(54906003)(478600001)(66946007)(8676002)(2616005)(8936002)(52116002)(6506007)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4801;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q53d3L07yc4qUOqTwjrMuGcJeyVhGP6vBEB0Z6MU6/3V6tR6gfw7jYeZ1nflVmlh1iFsIkooIwBREWIbe032w1FrKcQEF54o47TpnSMCL+pnPqqCq85JGhSVetFQWA+DDw1dtFOQ25rR/CmRWNSzCS7zbZapDWPelZytRs5iI6QTdAD1Y4482EjzSirCTRSU67kPm6uy/PGiuxONFC4TnjfSoS58jz8ZTWFPHYT5n0PR/rYxK230Ji98avV0oOcwM0dmhLWBLucoEMqUUq0mwQ3Fsc8CqNwPM33Qp6MKAgtzW7iRm3OTgbZCZwY7WbrP6CmbuzpKbaiAZp6XSNbNamt+JdJVTSRtvy9PHKieq/wpRIXicAfUwDInJ4kAmMmGKx4e1jMnIZANcgF/5r+lfvb1sD+Q5lOO+SitsVW1EzI4V7CafmMD9G4ijGO3Bimo
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d49d3a6d-aaab-4275-2b86-08d78513bdd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 06:13:33.5487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssqEI2wUWfxDZGf/zClpAovR9HVLXgrK1FZOF9UTHtkUOQaLBvoffya6esTX+QCO81ND6e7uF7yAQ25oxQbqlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4801
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

