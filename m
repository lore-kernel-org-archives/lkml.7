Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552D5FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B60220872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="I0pRxFT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440026AbfJQOOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:14:48 -0400
Received: from mail-eopbgr130137.outbound.protection.outlook.com ([40.107.13.137]:54430
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394848AbfJQOOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:14:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrVSf/uTiXdvpxIEsH7nG8PK19Bi0ashysYPGflFW4cmmSzGdmENYjwouEo+F652YNuOoMOgpeyrpOAR8yZhIq9lkk2hkRoN7WvWtGajXnwHE7ugFRiTMObvJHX6qPnZfEzgbFdGVDBfXjWksoTEuj6WV/OptDm6rNNl4b4VIh5gUL8SDrZNGKWpQy/B1Ru8uK021UceQSYwRVL8P2MpypD3MDg34/v+FfXRWFYULiFXDmS0RHVEWIlEjkoowDnxql1yYRySuU7A9uDEQRTUsyoe3HHTWA2NQjpoWcWxX3q60OxsVFG08YyZ4MKgAKyDieGoS8B7lw8HJsZA6WaiFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHeauLFJM0Su/71ZQxi0UVwRKvmbouF+IqU4IS2Y7gA=;
 b=XiD4mX+kGnRUvWXFfgKpDcd93AtjU0eiP3xYV0q9CnmHmh5QdoHtoYwUgbmtzywU222yZIrTiGr2mVQfQb4/iJ01r6OMvFbVGsmNpaI6S4yrztibfwgAGvazA1yDCy0MG2P0BAaBdrG9ZRBra7w9UnXd3MClEvQm0vE0kEEwsc/N3BIH2jtnEVHR+th9t5wEnH31k1s1q1wFpk0DS1GJkghHzPxLOqG+QTNzGRQSCQBz7TEHKrM523trFSiIVc9aseiY6u5RBlR2cg1dDFX/o1ix8aS2qQXq/Mx+3Cg9zq/ZfVKSYHK8jEWkQkTNlpAts0DgvGdr4F7xzg7tLD4RuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHeauLFJM0Su/71ZQxi0UVwRKvmbouF+IqU4IS2Y7gA=;
 b=I0pRxFT/TC+uaZt2vmcLM10PCfUpMt6n9JwfMAf8ZGC0Ae6aHEvXQ3JycyAR1gT90TjO0kG9qaJPu6suYWy5haxhAoNJLxVLH4xT64pngCBajb6QeXuIL7/QAi0raNh9IlfJrUE4VbK4n3BnW38NKdwhaKPEursRvQxZZwW7GrI=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.19.20) by
 VI1PR0502MB2990.eurprd05.prod.outlook.com (10.172.255.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Thu, 17 Oct 2019 14:14:41 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad%7]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 14:14:40 +0000
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
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>
Subject: [PATCH v2 2/3] tty: serial: lpuart: Use defines that correspond to
 correct register
Thread-Topic: [PATCH v2 2/3] tty: serial: lpuart: Use defines that correspond
 to correct register
Thread-Index: AQHVhPU3gu1Gs2IJKkapMCJaHmRF3g==
Date:   Thu, 17 Oct 2019 14:14:40 +0000
Message-ID: <20191017141428.10330-2-philippe.schenker@toradex.com>
References: <20191017141428.10330-1-philippe.schenker@toradex.com>
In-Reply-To: <20191017141428.10330-1-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: bd1fda99-d6ea-4f11-da03-08d7530c59a3
x-ms-traffictypediagnostic: VI1PR0502MB2990:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB2990B28D4BF34A043C38F927F46D0@VI1PR0502MB2990.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39850400004)(346002)(136003)(376002)(396003)(189003)(199004)(1076003)(81166006)(3846002)(102836004)(64756008)(186003)(386003)(52116002)(76176011)(26005)(66446008)(44832011)(8676002)(486006)(476003)(7736002)(4326008)(66476007)(6506007)(6116002)(478600001)(86362001)(25786009)(66946007)(66556008)(305945005)(5660300002)(36756003)(81156014)(14454004)(71200400001)(50226002)(110136005)(71190400001)(316002)(99286004)(2616005)(6486002)(2906002)(256004)(54906003)(107886003)(11346002)(8936002)(2501003)(6436002)(6512007)(446003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2990;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I60EnC0jDV6Thn5QzJTSgbCefjQLrlRtd02oyiz+nqrJlxHuSFaiPepvlszOmSdRD3Mqv+Tg8YieH8oGnQDAtPyxZOVLIXWrYdEFadT1I7D8gLYrW6AlOVhmr5mmPlIf0ym9TI/WZCBjWfLZExV3/4vDLYkJLP6/EfHTWDB+foSXlAjdgt6tpBl8gEjxTU2RKLmmK+DWen11mL56IfH7l+Han4DSAygbxgHL/OUucTWUn+saJB86XuKHigeT35L/H4sHcV8vA3ECJAPMU7sfZIhEGsOdklUapXelulyQxBAP65UN8J0ZbLKImA+DG0nrrHQshgNkvWEihJ6dmDe5qGqWYW//xoebe5nWz/tnQctdepHD679oU0dLLbGFf+mX5qAP0ZbOskLl70ICn3m7m0ED5tFI/h016wa8t+pxuVM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1fda99-d6ea-4f11-da03-08d7530c59a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 14:14:40.8475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zD2Th9XNqHH2oOX6G2IzI3nF4lle1wziX/M1snhFqK5UdjjYRDWxE3WApDlDTkZGWysAwA98AFIq0WTNjO6zIE5l5AGRlhD8GsB6wsUUq4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2990
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use define from the 32-bit register description UARTMODIR_* instead of
UARTMODEM_*. The value is the same, so there is no functional change.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Reviewed-by: Stefan Agner <stefan.agner@toradex.com>
Reviewed-by: Fugang Duan <fugang.duan@nxp.com>

---

Changes in v2:
- Changed commit message to Stefans suggestions
- Added Stefan's and Fugang's reviewed tag

 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuar=
t.c
index f3271857621c..346b4a070ce9 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1879,10 +1879,10 @@ lpuart32_set_termios(struct uart_port *port, struct=
 ktermios *termios,
 	}
=20
 	if (termios->c_cflag & CRTSCTS) {
-		modem |=3D UARTMODEM_RXRTSE | UARTMODEM_TXCTSE;
+		modem |=3D (UARTMODIR_RXRTSE | UARTMODIR_TXCTSE);
 	} else {
 		termios->c_cflag &=3D ~CRTSCTS;
-		modem &=3D ~(UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
+		modem &=3D ~(UARTMODIR_RXRTSE | UARTMODIR_TXCTSE);
 	}
=20
 	if (termios->c_cflag & CSTOPB)
--=20
2.23.0

