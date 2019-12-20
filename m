Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C576C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8A42467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qcudVcou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfLTGNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 01:13:53 -0500
Received: from mail-eopbgr130072.outbound.protection.outlook.com ([40.107.13.72]:29146
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfLTGNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:13:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7kG08V2jHkX/a0Y9RwQskn1uK9B/ZZWw2RMY5GTbPNuwQqBn5Z6vkraOoFmQ9zTHJXdovXZksAKLbG09wuRr0tc15l/UwUXCiJfD3HZb+92/jRRbHPfuQTAZaGzU7XgqGCJQyp41ST6XZidd/i73p5TjugWNgsSOasN0nF8THJTOWEfbSWUCb+9daw1W9jPGGIKNv8nwMQLTD/wHDzC0x3K1WGM9Vbh07cDd8vlM2nW+YyZR7Wt+uz59NqxrhNTNAQoum9YPtUbke24bzrkEpRn957Ix8ihf6rSTXBJv8thBZwEBtOMP90YEGFG42vJn84lPHmy/JnEObYh6grtSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5p2VusnXK40CMyc4GtZRup+0926cc6bW/dyjLs9kp0=;
 b=FTh7qCo5oSw0hfPEHjBeffG+/mXnpv2dw+g4HXHnYkWew0IVw094lqvaob5vjLdjwyF9VNu4bgF1S0Vj5O5n8+Q3O2DQv9YlOjkfhKr8oT1xFWwkfscXco/4no4+qW9kU2YlHSMxjLeZYbpwjIaVdNMLkIfNhiDN/Qr9YBy8e0+y+SaF+SeBxgSH1huFdCbcZI3WDBcnuJfi4bAVn5212YDvzDnqd1tpMEZrEOTarSa+qQAH7Gn1pIxRI8SaV2HLkUq8hi+l+1oDLPf+x2FPClzz3NNQs8hGy4222TqRhKSXkcT1kk8+WM5SKfqXRjU69Ef4H8NNyn4L0Q4mccvT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5p2VusnXK40CMyc4GtZRup+0926cc6bW/dyjLs9kp0=;
 b=qcudVcouO2J3Cy2kCOJAEt9DYgCCgX8d20v/5b78RJhr5rqLpM+sr3gHxKkhsLflgOsjEW4zyTlB5q3v+6oNWFe2R/ry47L6OyOWmKDimkVBs0CuAC7Ry9P4K1IB4vWd8gP6m82VcHiDwOBp68nuD832fjKJf2MzABzWiUv8vlc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4801.eurprd04.prod.outlook.com (20.177.41.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Fri, 20 Dec 2019 06:13:41 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2559.015; Fri, 20 Dec 2019
 06:13:41 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/3] tty: serial: fsl_lpuart: drop earlycon entry for
 i.MX8QXP
Thread-Topic: [PATCH V2 3/3] tty: serial: fsl_lpuart: drop earlycon entry for
 i.MX8QXP
Thread-Index: AQHVtvye564AYsYVGUyQSgBRz3Y7Qw==
Date:   Fri, 20 Dec 2019 06:13:39 +0000
Message-ID: <1576822230-23125-4-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: 077db54a-823d-49f0-eaed-08d78513c120
x-ms-traffictypediagnostic: AM0PR04MB4801:|AM0PR04MB4801:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4801B83704CCE957B54BD035882D0@AM0PR04MB4801.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:372;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(316002)(110136005)(66476007)(66556008)(5660300002)(64756008)(66446008)(26005)(81166006)(81156014)(71200400001)(36756003)(6486002)(4326008)(6512007)(186003)(2906002)(86362001)(54906003)(478600001)(66946007)(8676002)(2616005)(8936002)(52116002)(4744005)(6506007)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4801;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qOeAqXHrSe1ux1rTaa3nx1kTWyoniT8fEPeVwDn0Eli0t/84GAJejyUMxMLW7VV8A02vuvY4JM9Y8hrRLxl71jhjzNs/emxWZGS1XRXu8LoVD6a8JXmWdsQa/bQV8igW3l148OIlVucoyIrnbjTBpABr74lx+iRylX+Y/PAW4HUjm6VBtDCxT01N9iIHqPBIrSmuA3G1xan/s1zC07mS1jgkyB/SH4o0lGMeAtZxlrpu0FV+A0c+qlW3yUoLF2xo6cJyHiFz5WpD+sFA9uhStIsGxwk+Gf2YZyTKspTSux9G/Cv7pCJN09m5q7/Fbp1r5/esScvzD+UBL9UI+GyoOLoZtQ27N4hl9l3CFGuemVcL1/RPWjYy40tf8eSG9TZqpgf/MN5LAl7BZaPudmOqnAoEUkvhUv9OvHw5FHrRlgHCX2F5elMO0nwpp1Lvct/t
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077db54a-823d-49f0-eaed-08d78513c120
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 06:13:39.1504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQ72NAk2o0fCcOOUBhrhnEPm9ihGSNdole75/VT7HBXakzpgGPSGwC87EsAha2XMqTO1ioC546Q8Go7Vo9ay3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4801
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8QXP lpuart is compatible with i.MX7ULP, so no need
an extra  entry for i.MX8QXP.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuar=
t.c
index 6ad0af073e62..00cf72e9e9e8 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2398,7 +2398,6 @@ static int __init lpuart32_imx_early_console_setup(st=
ruct earlycon_device *devic
 OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart", lpuart_early_console_setup=
);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1021a-lpuart", lpuart32_early_console=
_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart", lpuart32_imx_early_con=
sole_setup);
-OF_EARLYCON_DECLARE(lpuart32, "fsl,imx8qxp-lpuart", lpuart32_imx_early_con=
sole_setup);
=20
 #define LPUART_CONSOLE	(&lpuart_console)
 #define LPUART32_CONSOLE	(&lpuart32_console)
--=20
2.16.4

