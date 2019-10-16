Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F07FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6852067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="GVeTVCLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392807AbfJPPTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:19:01 -0400
Received: from mail-eopbgr00099.outbound.protection.outlook.com ([40.107.0.99]:40845
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731530AbfJPPTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:19:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYsE/ok0KioF7v3ireCmnIPqBJz5Djx7fPu9yhG22ztd89/2Dl47w6ZYsAVWqV6qsKcg0fsq3T9s7xG5ZNTqeBRYMmnlAjahVVvbBMXRvdg9A8/5XftDpc4uIiQvd/DAn24gcOqKPPlKP33cMToOZ5lWb5bsZdPPeeGhwCqyqyKkhGatURS6AbT3NBxN8pGPBTDdSsOedx9ehztdTETPS/IT1blCfRLY5FdrSNj37TF7xXcTI6VadNtXz1wE8wgxSsGZgPyqcghQ3pBs9nzq8lj6O1nd1o3sdqQQ9Bw7WhJeKaW/9vMFjMsgwaVDEo2iTeKJ7dvl0qTmhpBs7J5q2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyvfE9aZcj1WEjogcTar2E/Ibkcd5rlpyHpxPjHoEpI=;
 b=eXngvdeSMVc27ROyeQA3AWiXJp30v7S6zzwhKde4TVivd2vX+uLUiKH1JlpQdq1UeH+zCOaoUOQRRa/gbWsBf3RUfD7urdLOCXYP5VJA7YLcOUWl51ZLv3RD/f9rfURQEClcf+qlSz0Ba2DBF2raKu/r8ydA7a7cAchXWJkDrBZRfcyNqPD64JEeZgBwoW+TeWNUbHyJ/YVF2GKd+KXfVkVb55AE6wEPqOHDu//UOVl3L1g63O+ZCjdQ9h5K6UMS4ZATi3trveiimqi5d8Jvx1/sR2ZlVemCgLGIeebtXhVB9LaRem2vaXEqegT0dfCHg9oOar+xMWqAgeRCoJg8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyvfE9aZcj1WEjogcTar2E/Ibkcd5rlpyHpxPjHoEpI=;
 b=GVeTVCLkjPyIENsrQyHbk+675Fai+pGmvUAnNc4bGrNffE4RSTaAkmKy4P6uYmasAKosCloC9YMB0qlGJZ38Fh3bjj0TdT6SrgwCdC4wzcBAeKUyNQXtRtBUZrJsyPk2cftf4QRRxr3vyHoFRRL5HTVmfpCgumo7m1jjopTny1s=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.19.20) by
 VI1PR0502MB2989.eurprd05.prod.outlook.com (10.175.21.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Wed, 16 Oct 2019 15:18:56 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad%7]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 15:18:56 +0000
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
Subject: [PATCH v1 1/3] tty: serial: lpuart: Remove unnecessary code from
 set_mctrl
Thread-Topic: [PATCH v1 1/3] tty: serial: lpuart: Remove unnecessary code from
 set_mctrl
Thread-Index: AQHVhDUGhND3HaeiCUSQsk6nHPAtXA==
Date:   Wed, 16 Oct 2019 15:18:56 +0000
Message-ID: <20191016151845.15859-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR10CA0029.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::39) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:26::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f57edf93-9b66-4535-b6a1-08d7524c2958
x-ms-traffictypediagnostic: VI1PR0502MB2989:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB2989AB9B69AEF8BCF6D10B22F4920@VI1PR0502MB2989.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(376002)(39850400004)(136003)(366004)(189003)(199004)(81156014)(2906002)(5660300002)(44832011)(476003)(486006)(8936002)(14454004)(110136005)(50226002)(2501003)(2616005)(8676002)(66066001)(1076003)(54906003)(316002)(81166006)(86362001)(3846002)(478600001)(6116002)(25786009)(66556008)(6436002)(66946007)(66476007)(66446008)(26005)(6512007)(36756003)(107886003)(6486002)(305945005)(52116002)(71200400001)(71190400001)(99286004)(64756008)(4326008)(186003)(7736002)(386003)(102836004)(256004)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2989;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cDNXwlJilr6RA4BmprV8JrfzQ7LQGGfq09RjmzYjP+sya4eHEfU1fbKz3Yf6swSx+RogGT4zYysd5iZYP9a7V9912H4aCkhaRHXKmi/ZjsjJc+OiQqiBlem6Y/tAyHS0Kn1ixFhx3EmMgELdwsUp/d8tIsxtc9MH2WcwTBZqtHvRPLzDPUvtr4WxADd4xZktcKWA8tG1ixY0lglG6WTcHfouwXYQjNB9iPdkP45VZIu2b14lLn2EwUC8FegHJW8xAwJLamvFfZtrZuHn/CST98sC3SQcTHjgcCWiz8rN3S3BKLmqZWEsRzjkvLG47J6LWoNrLLnniE+wn4WYv7SgfJyjfhbd2F9u632Syaw7pWWVnesZdQ8r2L1RCFhUGSUDGDma0rVVHMveA7S/vvcIKiUx/5uHRtifAEqsPSzUH8g=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57edf93-9b66-4535-b6a1-08d7524c2958
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 15:18:56.5623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fsMB7pDkkufbjPAPnFaUizVa+AQfxV542lEdW3sihwbKj2EzvqNeN0SVC1BF7yZUYXCcz6cBHpX5te+zLu+3I8f/I3C2LAeOZc6alofgOMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2989
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
---

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

