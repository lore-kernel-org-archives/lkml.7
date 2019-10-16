Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F6DFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E6D2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="YxbnrAFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404802AbfJPPTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:19:07 -0400
Received: from mail-eopbgr00099.outbound.protection.outlook.com ([40.107.0.99]:40845
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731530AbfJPPTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:19:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQQ7jBb6T7ERy7cUJeedMUF6prKueudVqhRh3mGbv2YI2CEExm97zBFh1+MpLoZLTf4m+MExFDh9UOfV+BDWhkh15MM1mb4a4ZdTCVZGsU2eEEhIuxeh/9TvU9cvZJoZr2cvKmgPmsVm/45+SJfA7awGzPvGQBSCjGlHVtJ0VeDcJzoTbvnJPkSmKUbxeg6sP8jw5x2soV8T2hrSL4QWD1pCKxoZsrqnGwB5MEs/ENqhO9uyo5OrU9fidktXyWidBY7FBwHpbtp11blyneVlzVH63AphZ27YpurYAVny+wbzaZWPoireKrnlw7Li05LVqvphiGiLHdceDxsEW6du4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDm+/bdZ5hrRWzWjd4+UurSMQLTa+6xmywdZ+rIqjUw=;
 b=RlNvDou9Jmz5btpmfxd89TgAMNYYc+wRT8+ljXuyZawR+UQTzAuLwEM2KDxYbEktzKEYXfMEPgKDUfPXGI5BpnG526fyLGb3KW++oekRPaPKSvjlSb9YnutywtdGiSLj6ANt+T2ymy1KKPZpEu7WgTwgRYMarz+9D1UtMImWPMIjhbUIJNJX3T7RjVCcqxpDJ6YnpD5ySGm8568medsoyTSgVM5T1D+cnlfxpyqy09+ud2f+O/azIIi3uyw0D7kBi56XF2Gcwj3AmO69cV2mtYEUl4/1WvWBiA+FRZzNdDcrKDWxXG7YiFP1WFQm28LTC+h1CLc0tezeiQFv5SNpbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDm+/bdZ5hrRWzWjd4+UurSMQLTa+6xmywdZ+rIqjUw=;
 b=YxbnrAFjc0tcbeKObKvRugjE3Tt7QE7CthDZ99ixvV1c3AQlPra0bSLmxj6o/QqBdkHOGfCnPuEvczNQcUKYd9LolvN+oaUgcFG/c+vjUZRsvcrOpMYcxgj2aPqmdWwbeXvfaQAUGuGQddLaX4FafvEJgFS6Cv1ITlSyFG/bPZM=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.19.20) by
 VI1PR0502MB2989.eurprd05.prod.outlook.com (10.175.21.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Wed, 16 Oct 2019 15:18:59 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad%7]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 15:18:59 +0000
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
Subject: [PATCH v1 3/3] tty: serial: lpuart: Add RS485 support for 32-bit uart
 flavour
Thread-Topic: [PATCH v1 3/3] tty: serial: lpuart: Add RS485 support for 32-bit
 uart flavour
Thread-Index: AQHVhDUIydsEsSxrwEmSYx3VY636Fw==
Date:   Wed, 16 Oct 2019 15:18:59 +0000
Message-ID: <20191016151845.15859-3-philippe.schenker@toradex.com>
References: <20191016151845.15859-1-philippe.schenker@toradex.com>
In-Reply-To: <20191016151845.15859-1-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 576d8b2d-f401-4803-4bd6-08d7524c2b55
x-ms-traffictypediagnostic: VI1PR0502MB2989:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB2989ACE8A410EEC9D5F25077F4920@VI1PR0502MB2989.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(376002)(39850400004)(136003)(366004)(189003)(199004)(81156014)(2906002)(5660300002)(44832011)(476003)(486006)(8936002)(14454004)(110136005)(50226002)(2501003)(2616005)(8676002)(66066001)(11346002)(1076003)(446003)(54906003)(316002)(81166006)(86362001)(3846002)(478600001)(6116002)(25786009)(66556008)(6436002)(66946007)(66476007)(66446008)(26005)(6512007)(36756003)(107886003)(6486002)(305945005)(14444005)(52116002)(71200400001)(71190400001)(99286004)(64756008)(4326008)(186003)(7736002)(76176011)(386003)(102836004)(256004)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2989;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JWIb/To7xsWzgHo+EBqt1XdSF/0g/8+Lf2qKySKwc8VAydT3h4XX6WfpmSG1H12iKM65czSx+9PSlLLHvN6ZuJh77EhntXmFiGjn0CpzLkVCiV94Q6jcO35Z2N049JJV++t1KbIGlMqyHk6DWCOt/81t6Yq2ZmrxjI1TBIoIfs/L4gnzBjEgxnNQ/wN8yQ5I/+43jiNbfv2OR+KBtv+v/FijiFhz9X5R0lYPqCPeSe9Ntw3246UpfE7ICJuRmpxSgsTmvFF6Datq5lK12sBp42q5pLj6/1p2LDt9Uf9k6OTaHp4vOcY4Ru73aFy4miDeIJN92oe5hNTrdfYeKqU437axu/pjQ3U0ejNizb+E1xose+nmE/LlIZVD8oQCuJLxHOKyVoJukYBuBPiiNlIKiBc3u4V7rUBM+x+m7Wegb6w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576d8b2d-f401-4803-4bd6-08d7524c2b55
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 15:18:59.6725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IPrz2ElIsboFqW8vK6o5d8UpzQv4o6E4hlv4CSBJFcZx5kVVjveB7Vo1Gd+dqyXSRwTu7uSyp3+QKu43WGDIzW62Z9i6ZbajXGXAj71hUtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2989
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commits adds RS485 support for LPUART hardware that uses 32-bit
registers. These are typically found in i.MX8 processors.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 drivers/tty/serial/fsl_lpuart.c | 65 ++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuar=
t.c
index 346b4a070ce9..22df5f8f48b6 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1280,6 +1280,57 @@ static int lpuart_config_rs485(struct uart_port *por=
t,
 	return 0;
 }
=20
+static int lpuart32_config_rs485(struct uart_port *port,
+			struct serial_rs485 *rs485)
+{
+	struct lpuart_port *sport =3D container_of(port,
+			struct lpuart_port, port);
+
+	unsigned long modem =3D lpuart32_read(&sport->port, UARTMODIR)
+				& ~(UARTMODEM_TXRTSPOL | UARTMODEM_TXRTSE);
+	lpuart32_write(&sport->port, modem, UARTMODIR);
+
+	/* clear unsupported configurations */
+	rs485->delay_rts_before_send =3D 0;
+	rs485->delay_rts_after_send =3D 0;
+	rs485->flags &=3D ~SER_RS485_RX_DURING_TX;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		/* Enable auto RS-485 RTS mode */
+		modem |=3D UARTMODEM_TXRTSE;
+
+		/*
+		 * RTS needs to be logic HIGH either during transer _or_ after
+		 * transfer, other variants are not supported by the hardware.
+		 */
+
+		if (!(rs485->flags & (SER_RS485_RTS_ON_SEND |
+				SER_RS485_RTS_AFTER_SEND)))
+			rs485->flags |=3D SER_RS485_RTS_ON_SEND;
+
+		if (rs485->flags & SER_RS485_RTS_ON_SEND &&
+				rs485->flags & SER_RS485_RTS_AFTER_SEND)
+			rs485->flags &=3D ~SER_RS485_RTS_AFTER_SEND;
+
+		/*
+		 * The hardware defaults to RTS logic HIGH while transfer.
+		 * Switch polarity in case RTS shall be logic HIGH
+		 * after transfer.
+		 * Note: UART is assumed to be active high.
+		 */
+		if (rs485->flags & SER_RS485_RTS_ON_SEND)
+			modem &=3D ~UARTMODEM_TXRTSPOL;
+		else if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
+			modem |=3D UARTMODEM_TXRTSPOL;
+	}
+
+	/* Store the new configuration */
+	sport->port.rs485 =3D *rs485;
+
+	lpuart32_write(&sport->port, modem, UARTMODIR);
+	return 0;
+}
+
 static unsigned int lpuart_get_mctrl(struct uart_port *port)
 {
 	unsigned int temp =3D 0;
@@ -1878,6 +1929,13 @@ lpuart32_set_termios(struct uart_port *port, struct =
ktermios *termios,
 		ctrl |=3D UARTCTRL_M;
 	}
=20
+	/*
+	 * When auto RS-485 RTS mode is enabled,
+	 * hardware flow control need to be disabled.
+	 */
+	if (sport->port.rs485.flags & SER_RS485_ENABLED)
+		termios->c_cflag &=3D ~CRTSCTS;
+
 	if (termios->c_cflag & CRTSCTS) {
 		modem |=3D (UARTMODIR_RXRTSE | UARTMODIR_TXCTSE);
 	} else {
@@ -2405,7 +2463,10 @@ static int lpuart_probe(struct platform_device *pdev=
)
 		sport->port.ops =3D &lpuart_pops;
 	sport->port.flags =3D UPF_BOOT_AUTOCONF;
=20
-	sport->port.rs485_config =3D lpuart_config_rs485;
+	if (lpuart_is_32(sport))
+		sport->port.rs485_config =3D lpuart32_config_rs485;
+	else
+		sport->port.rs485_config =3D lpuart_config_rs485;
=20
 	sport->ipg_clk =3D devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(sport->ipg_clk)) {
@@ -2459,7 +2520,7 @@ static int lpuart_probe(struct platform_device *pdev)
 	    sport->port.rs485.delay_rts_after_send)
 		dev_err(&pdev->dev, "driver doesn't support RTS delays\n");
=20
-	lpuart_config_rs485(&sport->port, &sport->port.rs485);
+	sport->port.rs485_config(&sport->port, &sport->port.rs485);
=20
 	sport->dma_tx_chan =3D dma_request_slave_channel(sport->port.dev, "tx");
 	if (!sport->dma_tx_chan)
--=20
2.23.0

