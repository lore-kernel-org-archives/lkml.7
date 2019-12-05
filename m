Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B93C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F76B224F8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZiTgT0LD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfLEHYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 02:24:19 -0500
Received: from mail-eopbgr150070.outbound.protection.outlook.com ([40.107.15.70]:4058
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbfLEHYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 02:24:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCkl9gnzIXHeQJ6gdMXYVi8jhSN1Wot99AKvQx5zZnRzcnqcY32hLneCMZSWwGeFKGpqh2Ty1SUFfyCSS597aUopHgCLpG1hHeQh3w9lq1K5X0xXOtMoe+5eDMgx4gzXQgU1u36MfWr6C5+ZY0EsJ7SgDMcVFKyU5tjBwgRmieFYhmm/QTZb8e8pha2sCz6Q3XIXirUr9Uj0P1GDGUfUff36jVaNyHQqWbADdJjhtP8GDgmO1PqI7QptdD6Hq/RY53UAL9VpsCxz4Hz/xd9UCM/S7vLY1GDBXPbNIYdLUg08S2BzS60InR44YHqAN8ik5QwFq5QRnOPzX0tfpM/NLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYUT6IGpX3mke/XTyfhnBfeRsD9qbJ1sl1tJhl1h9As=;
 b=g6eDGDVHuQud+ibwuHHJNw53o64C/GQi2yIA+ccchTyDinONYzVyPkdFVCDq+cWq/pPbLhMwLh2OuG18g7XN4swNs0aJh4vYzGibkwO0iyNR9lyPobpxFXIkmdXMA/iiBdXv828f2HT62OexPh/Ykl1OUl3tuewzNyl/J8SsiHO4Pk0l7xrIgeN1mggysEyHu2e1yDp2P0AFIwXsduduPCI4e5CJPW75xQK/tF3gW0P5L/sQwuv9E36T8zhes2AMuYs412PAnNK7ZdYnxX16gvV3m4n8yeHwS4g0GwWlJffc6RV9tZrwyozJEmWxxpEHR7Q6mLF8NqQ7YiuJxHXW5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYUT6IGpX3mke/XTyfhnBfeRsD9qbJ1sl1tJhl1h9As=;
 b=ZiTgT0LDsmBy1yuFbLTDQuRck2980oGKDeHXAbqMnJMyrn2Y8UvJY3alVDAtL4hQWSjC7xCSAk8XzT4GGN/kKIhH3xc5RXdoSoIjq+msmQb/Hkleq5ePxrWyxBpYcvp5L+xIKruKrCmmKRmPwO6DtjTNbuxTOisxAqQjtlafrM4=
Received: from VI1PR04MB4015.eurprd04.prod.outlook.com (52.134.122.33) by
 VI1PR04MB4525.eurprd04.prod.outlook.com (20.177.54.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Thu, 5 Dec 2019 07:24:14 +0000
Received: from VI1PR04MB4015.eurprd04.prod.outlook.com
 ([fe80::d9d7:73f:8b70:78cf]) by VI1PR04MB4015.eurprd04.prod.outlook.com
 ([fe80::d9d7:73f:8b70:78cf%5]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 07:24:14 +0000
From:   Ashish Kumar <ashish.kumar@nxp.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: RE: [EXT] [PATCH 1/3] mtd: spi-nor: Split mt25qu512a (n25q512a) entry
 into two
Thread-Topic: [EXT] [PATCH 1/3] mtd: spi-nor: Split mt25qu512a (n25q512a)
 entry into two
Thread-Index: AQHVqzmQtMCjGpTNxEaXaxOx2snTEKerIPgw
Date:   Thu, 5 Dec 2019 07:24:14 +0000
Message-ID: <VI1PR04MB40154C771556031768A4D48D955C0@VI1PR04MB4015.eurprd04.prod.outlook.com>
References: <20191205065935.5727-1-vigneshr@ti.com>
 <20191205065935.5727-2-vigneshr@ti.com>
In-Reply-To: <20191205065935.5727-2-vigneshr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ashish.kumar@nxp.com; 
x-originating-ip: [92.120.1.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1200e1ac-f456-4c29-d49f-08d7795421b8
x-ms-traffictypediagnostic: VI1PR04MB4525:
x-microsoft-antispam-prvs: <VI1PR04MB4525737972B91B081ED2AA71955C0@VI1PR04MB4525.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(13464003)(199004)(189003)(229853002)(6436002)(6246003)(55016002)(6306002)(9686003)(3846002)(6116002)(305945005)(2906002)(86362001)(478600001)(14454004)(71200400001)(71190400001)(966005)(74316002)(25786009)(7736002)(102836004)(5660300002)(66946007)(44832011)(110136005)(64756008)(6506007)(53546011)(66446008)(76116006)(66476007)(66556008)(26005)(11346002)(186003)(54906003)(316002)(99286004)(4326008)(76176011)(8936002)(33656002)(52536014)(7696005)(81166006)(8676002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4525;H:VI1PR04MB4015.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XcnuZA4Wfu8QXbYDzOa8r5TcdNIVT5X/pGo2o1hk4wZakLq4qlBcqgPTGnJFZVKO5kIH2j/h799gLYdcVQ0RZs5l5hKy/jrvKnpzC7ymhlfgwDdWGLNE5vc9uvT2KnRidPIPXBQvKhuN21wofiPK8hV/+Ia1h+xnilZwTv9Z3PsW0n+YJtdkKGHVPNL4O58x3nd9YSmtd9hXudXseki9hxUPsiSxmcLbPihAEKr6ee3as1pigBJTqt6Zc8BVZyVdl2H84qTGnLFUmzh3e9PixegRDOB4akfNKgptVo0qu7LxEFwnhPV/ZTcdIrrgMLiN79bKLCmFb4nPGF7FZWCqFJU07+GHVlPsM9SgsQbVOPU3Zob85GnopYgyRmhH1ft9Adnm2zN+4lkewsjLtkCzbxf7KbRZp0HYU7kryYiQ7ZgMbklJeghlwPIkGVbQoscdcI5KmYkaOMMCqUx/PMiiKwilG585TW6ekL8yj0sFknaYT5s16HAR0EaJ/Afg2R0wG/+xagEu0ltXODB6hmlgqlUAP+SCyMspaeYQKDKfaPc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1200e1ac-f456-4c29-d49f-08d7795421b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 07:24:14.5559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qw0JD7zKsIjvQtAALRJW9DxD6fuwkP4t5vl7Ks9XoTdxyLC67yW1Lpk245fUdSqTTIziLC2Xrsa4Vol0xaRdxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4525
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

> -----Original Message-----
> From: Vignesh Raghavendra <vigneshr@ti.com>
> Sent: Thursday, December 5, 2019 12:30 PM
> To: Tudor Ambarus <tudor.ambarus@microchip.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>; Richard Weinberger
> <richard@nod.at>; Vignesh Raghavendra <vigneshr@ti.com>; Ashish Kumar
> <ashish.kumar@nxp.com>; linux-mtd@lists.infradead.org; linux-
> kernel@vger.kernel.org; John Garry <john.garry@huawei.com>
> Subject: [EXT] [PATCH 1/3] mtd: spi-nor: Split mt25qu512a (n25q512a) entr=
y
> into two
>=20
> Caution: EXT Email
>=20
> mt25q family is different from n25q family of devices, even though manf I=
D
> and device IDs are same. mt25q flash has bit 6 set in 5th byte of READ ID
> response which can be used to distinguish it from n25q variant.
> mt25q flashes support stateless 4 Byte addressing opcodes where as n25q
> flashes don't. Therefore, have two separate entries for mt25qu512a and
> n25q512a.
>=20
> Fixes: 9607af6f857f ("mtd: spi-nor: Rename "n25q512a" to "mt25qu512a
> (n25q512a)"")
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.=
c
> index f4afe123e9dc..01efea022990 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2459,15 +2459,16 @@ static const struct flash_info spi_nor_ids[] =3D =
{
>         { "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>         { "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512, SECT_4K |
> SPI_NOR_QUAD_READ) },
>         { "n25q512ax3",  INFO(0x20ba20, 0, 64 * 1024, 1024, SECT_4K | USE=
_FSR |
> SPI_NOR_QUAD_READ) },
> +       { "mt25qu512a",  INFO6(0x20bb20, 0x104400, 64 * 1024, 1024,
> +                              SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
> +                              SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
It seems you have moved back to my original patch [1], wrt mt25qu512a.

Regards
Ashish =20
> +       { "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K |
> +                             SPI_NOR_QUAD_READ) },
>         { "n25q00",      INFO(0x20ba21, 0, 64 * 1024, 2048, SECT_4K | USE=
_FSR |
> SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
>         { "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048, SECT_4K | USE=
_FSR |
> SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
>         { "mt25ql02g",   INFO(0x20ba22, 0, 64 * 1024, 4096,
>                               SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
>                               NO_CHIP_ERASE) },
> -       { "mt25qu512a (n25q512a)", INFO(0x20bb20, 0, 64 * 1024, 1024,
> -                                       SECT_4K | USE_FSR | SPI_NOR_DUAL_=
READ |
> -                                       SPI_NOR_QUAD_READ |
> -                                       SPI_NOR_4B_OPCODES) },
>         { "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096, SECT_4K | USE=
_FSR |
> SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
>=20
>         /* Micron */
> --
> 2.24.0
[1]: http://patchwork.ozlabs.org/patch/1146197/

