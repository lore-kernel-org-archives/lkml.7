Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43AFECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8058020872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="cbKV/UEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440034AbfJQOOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:14:54 -0400
Received: from mail-eopbgr130137.outbound.protection.outlook.com ([40.107.13.137]:54430
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394836AbfJQOOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:14:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lp/EJO4coV4Icb4C5HvHmAaK8wYwpslwoy5fnOCSkt2mQHr+jWZKNq6+rOb79jv5RFnzvQE/KmQw8pPXhG5768vs6rgtBl7iy4pwQe7bzAEx80Q4NWIWKPX/vkNISMNtJx5hb3AWps1UA65gsJpFw2Fravizmsl8VWE3bxuiLo1ycDGcmAPVISqXGXuIJxyJZ8Vk3yc4DaL6TxFmAnkZpAWXRh8wrNMMmH+yq+W9G2kjxUSwR2vqMnJ2uWyifE76Z6gWvwwvmm4dDJEiGKk4da4sd0GOPTmPQf/vp4/95QXHQ3lTzJ4gUwcmOWVZghdH3LV4Z81JKxToqst2wSJAJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OdldipMRMrqhYBiFQdOe8qK14MI1q/VSOB8j2L94VY=;
 b=EelSmKVJ2JXlZ3rM3QoKf2my9Xt/aFG792ZWObpm9OHs1ccFSr4x3b+Pp6GGWNvMPq4KGxda9pJL/fGHkXkFOfda3j8lHM3S+FtRaE5zi2Bj8PBpRjWYOm67hH3mimy1i+y41Sfke5yBJbEnRUsE/DNdtIHzUeWrfhVGoa+jPA37vMHqX8E8Z3kNRakT6DxSu8svW2OaXgzJjO0qj0zV+AE9W3VENXTpBii9k3VgSDNXHCddcFm8EwaOqDfIrtIqOs7O/I4+WDqH1W8BnaXwS6RQuwtd7yEDaq8D5R3my6NlJvp3DD0iJ4bTXlvRgeENLerTuduFsT2RFdAS+pcFmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OdldipMRMrqhYBiFQdOe8qK14MI1q/VSOB8j2L94VY=;
 b=cbKV/UEVZC2Jg8/mtOFPTHz7fpR7/eZJt/nMR9IuXCHo8bDp9uUyJSRjktEHcIay0InLPTU56fLJueuVfsb8daHj/wSf1CNwXvq78FNPhWiDXagyDdJMfEUWnBLDQa/FJ9MNYf0rW6veOucVBPqy+5jkLbr4uL1/LqZtYaQkA2w=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.19.20) by
 VI1PR0502MB2990.eurprd05.prod.outlook.com (10.172.255.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Thu, 17 Oct 2019 14:14:42 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad%7]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 14:14:42 +0000
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
Subject: [PATCH v2 3/3] tty: serial: lpuart: Add RS485 support for 32-bit uart
 flavour
Thread-Topic: [PATCH v2 3/3] tty: serial: lpuart: Add RS485 support for 32-bit
 uart flavour
Thread-Index: AQHVhPU4TpV1krZ1f0SVVpur/+kqIA==
Date:   Thu, 17 Oct 2019 14:14:42 +0000
Message-ID: <20191017141428.10330-3-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: c0d1aaa6-9451-42d7-8d1c-08d7530c5a8e
x-ms-traffictypediagnostic: VI1PR0502MB2990:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB29907C2F4988D1A71B116FD0F46D0@VI1PR0502MB2990.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39850400004)(346002)(136003)(376002)(396003)(189003)(199004)(1076003)(81166006)(3846002)(102836004)(64756008)(186003)(386003)(52116002)(76176011)(26005)(66446008)(44832011)(8676002)(486006)(476003)(7736002)(4326008)(66476007)(6506007)(6116002)(478600001)(86362001)(25786009)(66946007)(66556008)(305945005)(5660300002)(36756003)(81156014)(14454004)(71200400001)(50226002)(14444005)(110136005)(71190400001)(316002)(99286004)(2616005)(6486002)(2906002)(256004)(54906003)(107886003)(11346002)(8936002)(2501003)(6436002)(6512007)(446003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2990;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +3vjLTKuEjrBQhz1VUvB5SSzEKY2fhFyjHZCXGNhid5SIDWZhTiz8wNGbx7Qd90Z0ue1AKTgqtqppRGcoJfjrz8hjvdCN5qmF/gdG5DrVkYHmK1IsAzwPq/kJN2NjhZq4Aw3pwREYPXco1ZwKFN5ucPHII5JbiatNTr64Vf9S/wiSmAkcKm0BOpiaQKkQtKVa6ujUMJxjbUs4S0eSO8pNJ9ZBSvwkNBkW9Ney8ZOTpOjuG71PjPa1TWxnULqV4P7owv33coACfrshKhKgLcFd5Ko8gj9kAJMeqhXEbzaIaYi2MZylwFKo1KPt+08Xwi+mIjYZdPk7XsS2CoDcxS83eFdto5QsYa6FRLFSCNxJmiuBjJnlwQ2H2ySwVrAP8T4UIh6aXiAg9seoxdG2D6+cplib6WWQk+Px/ft6pzKwh4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d1aaa6-9451-42d7-8d1c-08d7530c5a8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 14:14:42.2258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YBuGAXYHD+9ZUuv4kD6PToAsVG3HJ2Bxj6p5YnCV6efU07TG+vA72KtC/r6zpUD1sB/qB80sbAkOxHHkvsSZakeXz/mzKGvC+ODsJQQeHvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2990
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commits adds RS485 support for LPUART hardware that uses 32-bit
registers. These are typically found in i.MX8 processors.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Reviewed-by: Fugang Duan <fugang.duan@nxp.com>

---

Changes in v2:
- Added Fugang's reviewed tag

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

