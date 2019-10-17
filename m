Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EDAFA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 05:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205512067B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 05:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T8Zsq55X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392025AbfJQFNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 01:13:21 -0400
Received: from mail-eopbgr50052.outbound.protection.outlook.com ([40.107.5.52]:65183
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732174AbfJQFNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 01:13:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6XEb+6NyAqwCT0KK4lZNYpfvs72sPhX4mXpv8hGgvNcHuj8B+epA18d95GNkUecBUewsJMWoXeGhxx2jMyGGypm5OdCj+EGtV35x5eU+DOQHDxRxmymmANmdYBjcVWvFVSvKnwedCVI3I0mp+RzABnmlEKEqw4ce3oZmEHOX9cKpkocEZDJzauKNl1DsUsCJXadwD3GMX7FaVOicOSCOd1eF8/heRujyP4qq72NG/NZeKsI3AOYhNfPHtKaydvZ9VQkXvetwbThssOzhC4fkPXKt82v6o8XEWogyaRwXE1e4YDdfdhmybhy2x8MCbMr2oFD3YAc2wOae/SftHy3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QM4fyMGzePuOBYYN4Gd/4seAvNKg+b1WOQmZMsRxkXs=;
 b=HNdOK8ShP13mWBj8Nrho9ad7rvVai02Gr7y/fukZ2YObdv9dE/AdLEQfu4Ij8eT9kRjDzNHuFezCiFqd6NyagLH3e5uXEKtEN+SUtyFc+Dv4r85iyTLKD6wI1clhRCKjrWu3UpYrIplJRy5MlFqryBGYZzzHG5nmPC0dAfNdtmXwMNKqOxIUpJYnHQPLHmrBvEPD+FzAc3IB+iEqkc683ctUNNfOVJn9zANFV94MLVNx/LrV/M8b41htblu0Ek7iux1oUcOCiKeal5F1rGdnN3wNV7I9e50am/A+eHcLh49qx512W5MvQ8kqSOKUpUYomWy2kAH8f0ES4i3T94kcEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QM4fyMGzePuOBYYN4Gd/4seAvNKg+b1WOQmZMsRxkXs=;
 b=T8Zsq55XS6Afk70KhGFYvOeGjEV78siEkc8mtWMKxb0xuHk9j/AuifjjmW40NOsR+Br80YhLhFmrjXpMq41Ab+bykadJWAGXBU2IfS7lDW+UL43mnwbnl8KOgAQCgCgYyCHthEMQxQQzxyBvWDLngEAa3cwTSeiPuCiWOu6MDfw=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.3.146) by
 VI1PR0402MB2878.eurprd04.prod.outlook.com (10.175.23.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 05:13:14 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::5dd6:297c:51e5:2b52]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::5dd6:297c:51e5:2b52%7]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 05:13:14 +0000
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
Subject: RE: [EXT] [PATCH v1 1/3] tty: serial: lpuart: Remove unnecessary code
 from set_mctrl
Thread-Topic: [EXT] [PATCH v1 1/3] tty: serial: lpuart: Remove unnecessary
 code from set_mctrl
Thread-Index: AQHVhDUGhND3HaeiCUSQsk6nHPAtXKdeSnjQ
Date:   Thu, 17 Oct 2019 05:13:14 +0000
Message-ID: <VI1PR0402MB3600A060EE349ED54559610BFF6D0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20191016151845.15859-1-philippe.schenker@toradex.com>
In-Reply-To: <20191016151845.15859-1-philippe.schenker@toradex.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1461f97-8669-4eb6-7a17-08d752c0b690
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR0402MB2878:|VI1PR0402MB2878:|VI1PR0402MB2878:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB287841724EEFE51E07403A0CFF6D0@VI1PR0402MB2878.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(189003)(199004)(66066001)(71200400001)(71190400001)(4326008)(476003)(102836004)(6506007)(26005)(186003)(86362001)(11346002)(256004)(52536014)(14454004)(446003)(478600001)(25786009)(6246003)(486006)(33656002)(2501003)(74316002)(81156014)(305945005)(229853002)(66446008)(66476007)(66556008)(7736002)(3846002)(76176011)(8936002)(9686003)(6116002)(2906002)(66946007)(6436002)(7696005)(54906003)(55016002)(110136005)(81166006)(8676002)(76116006)(99286004)(5660300002)(64756008)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2878;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y7QGfr3RT5ZprK/wawb98IJL9cadkRSdwW1si+SvBR7xNA/O5H+NPDHs9uzkNdJlt4+7FKoWmirlT6AAJZ7AizTbKq+MuyMhC5Tlq5a/IGEdo28cOEKQWUD7dC7qXVdFaFqUOEbmhqQk2TTTwA4bQbyOnxYYPKQsQNMGv14Uz2rnpc2ia0lw5mMuuUquklR6MeNG4DjAMp7nhGwOI3h2ik0M+jMeqJAITixs1EtyaBn+kaq9VfpmAa3PcIDYo55RzAZiuRbGS53nei6igqnYIntg9sq2KJH5ypfN54ji3bNkyYpRcehdeIfgCay7S8HwQHgzYz6Uoa14dvmixlj6IcUVzC7XrNtj4b54qFQ2Ux0nXmskm3CFkjFIu/K67s9Nnsdpn/8xaxDefiYH3/q+c6TDbJMjsIe7q8dQcUH2WUg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1461f97-8669-4eb6-7a17-08d752c0b690
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 05:13:14.4635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HIj0qT5+blW7lJZ9TtZTmWR7yQoGz1zH3foyoNX6xfNn95YT1hbHAA4CNZaaK6B1/wFqavlvGbhao4nZafQcIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2878
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com> Sent: Wednesday, Oc=
tober 16, 2019 11:19 PM
> Currently flow control is not working due to lpuart32_set_mctrl that is
> clearing TXCTSE bit in all cases. This bit gets earlier setup by
> lpuart32_set_termios.
>=20
> As I read in Documentation set_mctrl is also not meant for hardware flow
> control rather than gpio setting and clearing a RTS signal.
> Therefore I guess it is safe to remove the whole code in lpuart32_set_mct=
rl.
>=20
> This was tested with console on a i.MX8QXP SoC.
>=20
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Reviewed-by: Fugang Duan <fugang.duan@nxp.com>
> ---
>=20
>  drivers/tty/serial/fsl_lpuart.c | 11 -----------
>  1 file changed, 11 deletions(-)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c index
> 537896c4d887..f3271857621c 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1333,18 +1333,7 @@ static void lpuart_set_mctrl(struct uart_port
> *port, unsigned int mctrl)
>=20
>  static void lpuart32_set_mctrl(struct uart_port *port, unsigned int mctr=
l)  {
> -       unsigned long temp;
> -
> -       temp =3D lpuart32_read(port, UARTMODIR) &
> -                       ~(UARTMODIR_RXRTSE |
> UARTMODIR_TXCTSE);
> -
> -       if (mctrl & TIOCM_RTS)
> -               temp |=3D UARTMODIR_RXRTSE;
> -
> -       if (mctrl & TIOCM_CTS)
> -               temp |=3D UARTMODIR_TXCTSE;
>=20
> -       lpuart32_write(port, temp, UARTMODIR);
>  }
>=20
>  static void lpuart_break_ctl(struct uart_port *port, int break_state)
> --
> 2.23.0

