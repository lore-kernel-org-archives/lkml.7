Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842D6FA3735
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE3320854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Cn0TC56b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440014AbfJQOOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:14:45 -0400
Received: from mail-eopbgr130137.outbound.protection.outlook.com ([40.107.13.137]:54430
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394836AbfJQOOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:14:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNgbEJQrNtaAm0Tzt9Yb0fyku1/L5A2C0rH0QoaqGS0MYgclNGxBXMpAVoofoW+2bxTDZzvHMSlI6+Ju56Q0qEUgFVao1kQqK166YA3+giNfhemi4xQfc8FLVdj7AN4TD/xytL91LT09FjgKrRj+kcQemT0ZCvUCEDO0QgZruK/Kvn0kk1Fm0JKWM4dqCNrJjHH5sR3je0RKaE025JwxLoN5+zb3aRCZLOCiiwT3Fnp3nw7QMoz/j7YgJvr7qttkUoHPQhcuIQbNm2fhKrtU8YkwNXDlQV+1IwTkUlP3JOFN2XD0CNiCKt2/2wCLP57ElCPZYQt0Eq3Nph7UWh8mJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6LIcr+kArlEvgSDuljDT1IwaMtvn/GHjTreLE0nANw=;
 b=YheABDG3pXYJms96tAniAdIxHacNuRRSI1Dwc8YgIluZHHiM8EZ7DzVYdzTKWp2Ih+CEA7lQkdMsEyG4MSBMn8sbMpPZoNyRteDE8HPaUj6Da6vzT5aN9IZHZTuOeSLJ7793rAmOQwMqLGCQ4q0D4z1TVoZ8rGww+zkYwUQhwblj3ZZDRJ4sOSsoWaTuJuRWRuClZKNWEHnHSSktI0W0TN75rP7HuBE07S0rifrmHRasdCCuUBIMfk0NAa/HpRbdZb40D1SXW2lXSI/9XKX6YZeVZOu3QvTogv5jubcv9ZpopVAJgC+e+spXmBcorTKHgsOP29yGEy1YQ4a08xN9bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6LIcr+kArlEvgSDuljDT1IwaMtvn/GHjTreLE0nANw=;
 b=Cn0TC56b2LOPNGUIQtVq+gxyfB5LgpsPW0srr/3zuFaR+OmKX+EvwaUnWpHIANul1GumVXgu/tTRutE9rsB+K8ktlO6uR9kHj+QI+pZX9nErVopHql6UA1jjnE0YFr15suSAR6v8dDmarTE0ntdK9RDqoeYOvx2LVkS2Bm5EO+0=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.19.20) by
 VI1PR0502MB2990.eurprd05.prod.outlook.com (10.172.255.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Thu, 17 Oct 2019 14:14:39 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad%7]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 14:14:39 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fugang Duan <fugang.duan@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: [PATCH v2 1/3] tty: serial: lpuart: Remove unnecessary code from
 set_mctrl
Thread-Topic: [PATCH v2 1/3] tty: serial: lpuart: Remove unnecessary code from
 set_mctrl
Thread-Index: AQHVhPU2EBX8M1xP2UCKLhG8jBwn/A==
Date:   Thu, 17 Oct 2019 14:14:38 +0000
Message-ID: <20191017141428.10330-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0202CA0036.eurprd02.prod.outlook.com
 (2603:10a6:208:1::49) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:26::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 915fa753-d661-4c1f-3113-08d7530c58a3
x-ms-traffictypediagnostic: VI1PR0502MB2990:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB2990A13585566E72F5923BC2F46D0@VI1PR0502MB2990.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39850400004)(346002)(136003)(376002)(396003)(189003)(199004)(1076003)(81166006)(3846002)(102836004)(64756008)(186003)(386003)(52116002)(26005)(66446008)(44832011)(8676002)(486006)(476003)(7736002)(4326008)(66476007)(6506007)(6116002)(478600001)(86362001)(25786009)(66946007)(66556008)(305945005)(5660300002)(36756003)(81156014)(14454004)(71200400001)(50226002)(110136005)(71190400001)(316002)(99286004)(2616005)(6486002)(2906002)(256004)(54906003)(107886003)(8936002)(2501003)(6436002)(6512007)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2990;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UxF3aMVyxHsZ9HoESrTN3dxa3yeQqC52nTxqCqHlKCFmvYblTA6HIcHvy3o08rgywQ0WDSuyRkZfETrIZOp9TL1IGe9Gm1xp/v7hyUb/rhNPuBBiqbLdP0CUM01jcGJm1k3Fc0Fp5h7uq+d+7Cuwz/rhBW5iyUct6LtbB2vflkgAayLCsVpmm7wnwPmDOOZP1pwQXQv/iZ1TIiC/2ClUOuebQEWV4x+jYgPU4g0zbCamgoKwKOEmSt2Fnk7Rlq+JcbvRhuPB7LLKyZ1gUicFywUomel4aG8tov6lrR+0fWuI2j8jPFsAh9zzFVJU/lkPJ+BzlKUOZLDeGJP61gDmZq3SP4IN/sMDoM58C7DaHSXQ5j5/zb2OduxFPVXgrph4M0pofR7bhNaNHE71vOqJ6WHQnAkz0t8OR4EOY3sebhc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915fa753-d661-4c1f-3113-08d7530c58a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 14:14:39.0765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2X0j/U1FGNhZHsp7JuQ+54H/Bvfv4T0OffgviCeqfuQrXY8EnA6IzJJzsVg/LeStBhON4bOaqOPJzFOiREeeYZedlPq3ej05K40R4E5zE4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2990
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently flow control is not working due to lpuart32_set_mctrl that is
clearing TXCTSE bit in all cases. This bit gets earlier setup by
lpuart32_set_termios.

As I read in Documentation set_mctrl is also not meant for hardware
flow control rather than gpio setting and clearing a RTS signal.
Therefore I guess it is safe to remove the whole code in
lpuart32_set_mctrl.

This was tested with console on a i.MX8QXP SoC.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Reviewed-by: Fugang Duan <fugang.duan@nxp.com>

---

Changes in v2:
- Added Fugang Duan's review

 drivers/tty/serial/fsl_lpuart.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuar=
t.c
index 537896c4d887..f3271857621c 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1333,18 +1333,7 @@ static void lpuart_set_mctrl(struct uart_port *port,=
 unsigned int mctrl)
=20
 static void lpuart32_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	unsigned long temp;
-
-	temp =3D lpuart32_read(port, UARTMODIR) &
-			~(UARTMODIR_RXRTSE | UARTMODIR_TXCTSE);
-
-	if (mctrl & TIOCM_RTS)
-		temp |=3D UARTMODIR_RXRTSE;
-
-	if (mctrl & TIOCM_CTS)
-		temp |=3D UARTMODIR_TXCTSE;
=20
-	lpuart32_write(port, temp, UARTMODIR);
 }
=20
 static void lpuart_break_ctl(struct uart_port *port, int break_state)
--=20
2.23.0

