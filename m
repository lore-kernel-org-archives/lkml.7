Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76390C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6E62080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MEtubqVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407121AbfITDnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 23:43:42 -0400
Received: from mail-eopbgr20067.outbound.protection.outlook.com ([40.107.2.67]:48405
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404239AbfITDnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 23:43:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGiNSfxfU+wOUd4Rn473Qg+arjHI03bflNiD7gmHEp279Q2/XHX8EjY+Rs36nBN07YvumoBcL+gxVeleD66y00jYReM4Ks4rV15C5CZA5NY6Rka/D3l9fq7yDMMf8n8ft7+qr14mwsxYAFynkE19SYH9vs3ZWNEWlk2Yrb87L6C2OBzhsAR/QakT/fzQPGxBuK3Lr2QYBPXxaK6lByG+aEs/MxEw8qjPn4v1H+ExcS+rxRf+zDQj5wZnvyLa5mvi85OQPAnIQYpmzuttOzawq8SYu/+fEdarskRhAIBK3b/PfVMk94ESTykiT15MsaTmaPBdhTW7Ep5jvFVfjbOYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NTKtOxZwLGgRy2Vq2+o/CsJYcRu0n9V+GGGCgvXd74=;
 b=MyMZX6swhpA5GDpbscfoqBG0U11gTXMpb/zyxWarmWm7QgU9Gvp0abXJvfbLqYRkpIBtQZ5DyX/+SZfcU2FCF43mkojTaH9daJL95ty5lryEZiPey44kcfKrglfqYH33jovgLXTDClCiUup4gaZEanIQ87swvdOv3U34s0hHiD1KXnW1wlsf+YWdltB3cOrGtEsR8RrFWSWU1oycucs6UmYzZ/cIHNdcrwgS7ONVOtQ2QaxeC4Sm1SD+QRGan91HkJgWecS6YFR3W8zXkjlTz69KwgwNQTrzzeWIzeqkrjP9SK4G/RSLbVvk3xWZzzemJoD4Nqth9pqEnVd3i02+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NTKtOxZwLGgRy2Vq2+o/CsJYcRu0n9V+GGGCgvXd74=;
 b=MEtubqVgQ8uGTjGPVdIeeoOLskk/BpwN8KhisIJicNVlJTD6ghaR2uP+eVpLwtfFcqfvhwPjj7MF5M4H0/ew2cMzvMjZ2eZ0EDfhMiMer4KzreR9VvLGCiLPQA7MasyAkFBHDcnn7IcntzLf9dYwLgSd/nXewpYHcLD0C7ykxHU=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB3376.eurprd04.prod.outlook.com (52.134.1.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Fri, 20 Sep 2019 03:42:58 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::f919:a62a:998c:6e9a]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::f919:a62a:998c:6e9a%6]) with mapi id 15.20.2284.009; Fri, 20 Sep 2019
 03:42:58 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Robin Gong <yibin.gong@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] [PATCH v3] serial: imx: adapt rx buffer and dma periods
Thread-Topic: [EXT] [PATCH v3] serial: imx: adapt rx buffer and dma periods
Thread-Index: AQHVbvmzoURW9oife0iGKep4oJxlpacz42bg
Date:   Fri, 20 Sep 2019 03:42:57 +0000
Message-ID: <VI1PR0402MB3600CA068AEBAC63D3CE6A4CFF880@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20190919145114.13006-1-philipp.puschmann@emlix.com>
In-Reply-To: <20190919145114.13006-1-philipp.puschmann@emlix.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e25efc45-fd56-452d-c054-08d73d7ca0dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3376;
x-ms-traffictypediagnostic: VI1PR0402MB3376:|VI1PR0402MB3376:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB33764E00A8A96B8462167FCAFF880@VI1PR0402MB3376.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(199004)(189003)(54534003)(7696005)(66476007)(66556008)(5660300002)(66946007)(6246003)(66446008)(64756008)(99286004)(2906002)(76176011)(102836004)(6506007)(4326008)(52536014)(25786009)(229853002)(55016002)(9686003)(7736002)(7416002)(305945005)(6436002)(74316002)(316002)(76116006)(54906003)(3846002)(110136005)(81156014)(8936002)(81166006)(6116002)(8676002)(71190400001)(14444005)(71200400001)(256004)(14454004)(476003)(446003)(11346002)(66066001)(86362001)(486006)(26005)(2501003)(478600001)(186003)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3376;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NyqFIHVPRJq0WkJj1eMKBBLqkAqSE5gKzVToOIpfvFXyZGq12FiZ+F+PEOfntiHcc0LFG/1HODQmcqhOgb0ElWpVYFG/cElUe8sKD1lFMN6vf1vlG8OOoGQyLgY0oLAffhDB3Udo3VplBySzQcUoFux16xCTn7Je3AsIf8qbyCAK30SIs+sCxjNeEazPuBKj+GpjytOSpF/+A3nBUff4+x2GT2x0tfDUOWmToBePYxrhOgdZDXTdkv6bns6b+H3JQ7afgovyV0Y2Kd1c8CwdrOL/fuyW13JoLzxqiC+21XOuGJ3OzeLHxQM1r4WVaKdz1EAI6hLnEF5OeiunctbiTMHCWzvTCvWym6ft7ulXMlgR7s1wIe0PvyC8qOPSa6ecBwoLunEIGXUr0lwYpBiPbXB4QvfNVIQNDahYUbYLCVo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25efc45-fd56-452d-c054-08d73d7ca0dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 03:42:57.9501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BmY5dXgVuWXDsl4yRLB/dazZDvTpuERCF+TZAwMfz8Yo7urt24WYFgIp3bLNz9K2IPyd48u45oKk3PJWGlrglQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3376
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Puschmann <philipp.puschmann@emlix.com> Sent: Thursday, Septe=
mber 19, 2019 10:51 PM
> Using only 4 DMA periods for UART RX is very few if we have a high freque=
ncy
> of small transfers - like in our case using Bluetooth with many small pac=
kets
> via UART - causing many dma transfers but in each only filling a fraction=
 of a
> single buffer. Such a case may lead to the situation that DMA RX transfer=
 is
> triggered but no free buffer is available. When this happens dma channel =
ist
> stopped - with the patch
> "dmaengine: imx-sdma: fix dma freezes" temporarily only - with the possib=
le
> consequences that:
> with disabled hw flow control:
>   If enough data is incoming on UART port the RX FIFO runs over and
>   characters will be lost. What then happens depends on upper layer.
>=20
> with enabled hw flow control:
>   If enough data is incoming on UART port the RX FIFO reaches a level
>   where CTS is deasserted and remote device sending the data stops.
>   If it fails to stop timely the i.MX' RX FIFO may run over and data
>   get lost. Otherwise it's internal TX buffer may getting filled to
>   a point where it runs over and data is again lost. It depends on
>   the remote device how this case is handled and if it is recoverable.
>=20
> Obviously we want to avoid having no free buffers available. So we decrea=
se
> the size of the buffers and increase their number and the total buffer si=
ze.
>=20
> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>=20
> Changelog v3:
>  - enhance description
>=20
> Changelog v2:
>  - split this patch from series "Fix UART DMA freezes for iMX6"
>  - add Reviewed-by tag
>=20
>  drivers/tty/serial/imx.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
> 87c58f9f6390..51dc19833eab 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1034,8 +1034,6 @@ static void imx_uart_timeout(struct timer_list *t)
>         }
>  }
>=20
> -#define RX_BUF_SIZE    (PAGE_SIZE)
> -
>  /*
>   * There are two kinds of RX DMA interrupts(such as in the MX6Q):
>   *   [1] the RX DMA buffer is full.
> @@ -1118,7 +1116,8 @@ static void imx_uart_dma_rx_callback(void
> *data)  }
>=20
>  /* RX DMA buffer periods */
> -#define RX_DMA_PERIODS 4
> +#define RX_DMA_PERIODS 16
> +#define RX_BUF_SIZE    (PAGE_SIZE / 4)
>=20
Why to decrease the DMA RX buffer size here ?

The current DMA implementation support DMA cyclic mode, one SDMA BD receive=
 one Bluetooth frame can
bring better performance.
As you know, for L2CAP, a maximum transmission unit (MTU) associated with t=
he largest Baseband payload
is 341 bytes for DH5 packets.

So I suggest to increase RX_BUF_SIZE along with RX_DMA_PERIODS to feasible =
value.

Andy

>  static int imx_uart_start_rx_dma(struct imx_port *sport)  {
> --
> 2.23.0

