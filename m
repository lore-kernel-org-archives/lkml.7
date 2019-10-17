Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9D8C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 05:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702492067B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 05:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RmAnYt7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392674AbfJQFOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 01:14:21 -0400
Received: from mail-eopbgr40053.outbound.protection.outlook.com ([40.107.4.53]:39040
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728999AbfJQFOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 01:14:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjgymQVU0VbII2XiPWZYjiPDbUA/hy/E4DHZlBUW6/ROW8Pcso/gQcYEAInSwHbjoABHoKwkm3y5aqABuDvV1bJpFd1DGmMeD7uOqF/HytaaCnZh8eyso6d7idPk2Obcz6PtHwEqy5r4MMHaFxjqPurBmktIxcyYX46GQqBNoyRfv7kmGyWnVRQ42ngnysO5KXBlcvoiOyTugXi9c/CbIa+zAABRUc5xQG1/64A8D8TYqzjSi/x5CyJJjrUasDQSL1JvpKphHYcnimhWSDsshgXLaNjTxDhrV/BSVw0uEjS2orpguv1OYmMWC9jERJbC/2GWyc2PgJT/wzdkdhgVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNHZzNFteFCx8JNxTc0yQ5ay//l1xyLBsugc8EZdWW8=;
 b=b0CQVRKA6G6zOnB5T0QOKVhZG23YJE6SBBrJLacdnDuQMmP8uQwCKZPOpVzr7C9iWitA85TLpM8dNLtkkJALVlN1Fr/AlogYMFeKvj3F4f2TymvfS8dFHDf70KocYxmn1jN4FR6Zzkeb1XcbCj/BIitvG4rknocOvTny2wRaqC8TodGOK1FrC7cTMDdA51DP0J882UzV3gIbu5VkA/bLcrME2yMcEOWKOeHN92yvDhhQFHo6HPc7tw5C0kuSXUZYUxhr6sGRPM+Y/DGZ3QMm5jDYu5r0jfmNJiorYenLwQOTiDNDq07Hd+zdGjUjNd06sQOENJGtSOZhHIOeKxSbLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNHZzNFteFCx8JNxTc0yQ5ay//l1xyLBsugc8EZdWW8=;
 b=RmAnYt7BZgvydRsdwmNn8mhDDyZGVuS0HYPOfilOj+LEhBoFCXFAAIj0hXDwCrdmKhVipTVX8iuk0VRHRk3bhJqZCDSBTWJX7ST7XdL1KKCJsOy4XAgONdX5qWKkarGKs8RnphijwQ60u+n/J+6zt+vEhXeF6V5e2eF4x/5j1uE=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.3.146) by
 VI1PR0402MB2878.eurprd04.prod.outlook.com (10.175.23.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 05:14:15 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::5dd6:297c:51e5:2b52]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::5dd6:297c:51e5:2b52%7]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 05:14:15 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        dl-linux-imx <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: RE: [EXT] [PATCH v1 3/3] tty: serial: lpuart: Add RS485 support for
 32-bit uart flavour
Thread-Topic: [EXT] [PATCH v1 3/3] tty: serial: lpuart: Add RS485 support for
 32-bit uart flavour
Thread-Index: AQHVhDUKmWLMalCWlk6sMnHx6FvIsqdeSvHQ
Date:   Thu, 17 Oct 2019 05:14:15 +0000
Message-ID: <VI1PR0402MB36007F03DB38FDA44FED3332FF6D0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20191016151845.15859-1-philippe.schenker@toradex.com>
 <20191016151845.15859-3-philippe.schenker@toradex.com>
In-Reply-To: <20191016151845.15859-3-philippe.schenker@toradex.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 043add86-214d-4425-897d-08d752c0daeb
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR0402MB2878:|VI1PR0402MB2878:|VI1PR0402MB2878:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB2878A9376671BB447D694F47FF6D0@VI1PR0402MB2878.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(189003)(199004)(66066001)(71200400001)(71190400001)(4326008)(476003)(102836004)(6506007)(26005)(186003)(86362001)(11346002)(256004)(14444005)(52536014)(14454004)(446003)(478600001)(25786009)(6246003)(486006)(33656002)(2501003)(74316002)(81156014)(305945005)(229853002)(66446008)(66476007)(66556008)(7736002)(3846002)(76176011)(8936002)(9686003)(6116002)(2906002)(66946007)(6436002)(7696005)(54906003)(55016002)(110136005)(81166006)(8676002)(76116006)(99286004)(5660300002)(64756008)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2878;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mc25iaFBFZNpFKZzrtg/pO51diq5DQeDGeyGLrMDmcafnxea0wkK0EMhtlFHX8BNgLtZsNenOhHFvT+lAI1XQzQwWfg3r2HoVVkG/vsBYE06W6n5YKxkYWSUFOKIRvVMz0bnmbzDi7QtsF0ki37KhTGgFfen5C/IDrz70+sAj1PYSGgP4BkqoRbhBO33vAkHoRZVQGceBLcH4zpMy6JOi+rzISOtmcguPH7k7FY3J+BP4BueTdHQLejxJV5BaXe4MIdZW5rlCGWmaLlYLq43S8WE+uwFlVIC8RFdKpXTCANC/2XFaXn2PNO/+VWujnp41ckQS2SDmNm4x3ChRjp9DyQkhbL16/jQh96Urzutx3vwWW47wbCh2DQ6IV43E0gVHf67l3OpcqLF1Glw+oI1sHGpP8mrYlQggk4JB37/v4w=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043add86-214d-4425-897d-08d752c0daeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 05:14:15.4953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EuzjXQgaZP4CfNBOXxnfaKTWl8r1IyM2Z8c+ZaIEhg5jGkWtpBu3Qhc62Gr+JyXcvFr/cy92I5SpUCuAs5Ad/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2878
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com> Sent: Wednesday, Oc=
tober 16, 2019 11:19 PM
> This commits adds RS485 support for LPUART hardware that uses 32-bit
> registers. These are typically found in i.MX8 processors.
>=20
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Reviewed-by: Fugang Duan <fugang.duan@nxp.com>
>=20
> ---
>=20
>  drivers/tty/serial/fsl_lpuart.c | 65 ++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c index
> 346b4a070ce9..22df5f8f48b6 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1280,6 +1280,57 @@ static int lpuart_config_rs485(struct uart_port
> *port,
>         return 0;
>  }
>=20
> +static int lpuart32_config_rs485(struct uart_port *port,
> +                       struct serial_rs485 *rs485) {
> +       struct lpuart_port *sport =3D container_of(port,
> +                       struct lpuart_port, port);
> +
> +       unsigned long modem =3D lpuart32_read(&sport->port, UARTMODIR)
> +                               & ~(UARTMODEM_TXRTSPOL |
> UARTMODEM_TXRTSE);
> +       lpuart32_write(&sport->port, modem, UARTMODIR);
> +
> +       /* clear unsupported configurations */
> +       rs485->delay_rts_before_send =3D 0;
> +       rs485->delay_rts_after_send =3D 0;
> +       rs485->flags &=3D ~SER_RS485_RX_DURING_TX;
> +
> +       if (rs485->flags & SER_RS485_ENABLED) {
> +               /* Enable auto RS-485 RTS mode */
> +               modem |=3D UARTMODEM_TXRTSE;
> +
> +               /*
> +                * RTS needs to be logic HIGH either during transer _or_
> after
> +                * transfer, other variants are not supported by the
> hardware.
> +                */
> +
> +               if (!(rs485->flags & (SER_RS485_RTS_ON_SEND |
> +                               SER_RS485_RTS_AFTER_SEND)))
> +                       rs485->flags |=3D SER_RS485_RTS_ON_SEND;
> +
> +               if (rs485->flags & SER_RS485_RTS_ON_SEND &&
> +                               rs485->flags &
> SER_RS485_RTS_AFTER_SEND)
> +                       rs485->flags &=3D
> ~SER_RS485_RTS_AFTER_SEND;
> +
> +               /*
> +                * The hardware defaults to RTS logic HIGH while
> transfer.
> +                * Switch polarity in case RTS shall be logic HIGH
> +                * after transfer.
> +                * Note: UART is assumed to be active high.
> +                */
> +               if (rs485->flags & SER_RS485_RTS_ON_SEND)
> +                       modem &=3D ~UARTMODEM_TXRTSPOL;
> +               else if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
> +                       modem |=3D UARTMODEM_TXRTSPOL;
> +       }
> +
> +       /* Store the new configuration */
> +       sport->port.rs485 =3D *rs485;
> +
> +       lpuart32_write(&sport->port, modem, UARTMODIR);
> +       return 0;
> +}
> +
>  static unsigned int lpuart_get_mctrl(struct uart_port *port)  {
>         unsigned int temp =3D 0;
> @@ -1878,6 +1929,13 @@ lpuart32_set_termios(struct uart_port *port,
> struct ktermios *termios,
>                 ctrl |=3D UARTCTRL_M;
>         }
>=20
> +       /*
> +        * When auto RS-485 RTS mode is enabled,
> +        * hardware flow control need to be disabled.
> +        */
> +       if (sport->port.rs485.flags & SER_RS485_ENABLED)
> +               termios->c_cflag &=3D ~CRTSCTS;
> +
>         if (termios->c_cflag & CRTSCTS) {
>                 modem |=3D (UARTMODIR_RXRTSE |
> UARTMODIR_TXCTSE);
>         } else {
> @@ -2405,7 +2463,10 @@ static int lpuart_probe(struct platform_device
> *pdev)
>                 sport->port.ops =3D &lpuart_pops;
>         sport->port.flags =3D UPF_BOOT_AUTOCONF;
>=20
> -       sport->port.rs485_config =3D lpuart_config_rs485;
> +       if (lpuart_is_32(sport))
> +               sport->port.rs485_config =3D lpuart32_config_rs485;
> +       else
> +               sport->port.rs485_config =3D lpuart_config_rs485;
>=20
>         sport->ipg_clk =3D devm_clk_get(&pdev->dev, "ipg");
>         if (IS_ERR(sport->ipg_clk)) {
> @@ -2459,7 +2520,7 @@ static int lpuart_probe(struct platform_device
> *pdev)
>             sport->port.rs485.delay_rts_after_send)
>                 dev_err(&pdev->dev, "driver doesn't support RTS
> delays\n");
>=20
> -       lpuart_config_rs485(&sport->port, &sport->port.rs485);
> +       sport->port.rs485_config(&sport->port, &sport->port.rs485);
>=20
>         sport->dma_tx_chan =3D
> dma_request_slave_channel(sport->port.dev, "tx");
>         if (!sport->dma_tx_chan)
> --
> 2.23.0

