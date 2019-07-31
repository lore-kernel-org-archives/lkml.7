Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75A6C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BDF20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="h2Q0wozM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfGaMb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:31:27 -0400
Received: from mail-eopbgr690042.outbound.protection.outlook.com ([40.107.69.42]:54709
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726259AbfGaMb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:31:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDEa3NP8kAgWdePgFMTOl2m5qXRxkAH/Wuw+3jkaFRhrMeLp1LTT+ks/WLWRHowRGcjupXucGmk5M3sCV4j4QWrCbFshcbLhgMeVfdwm54nQ4AI0fkwy4S7RYP+bvoqIcjIaX1RKJxXpCdlXR5u9VJUZZyfXgraBHQIdmrtffGUG3My0EGZKeDob25MukVs41wbQz58jnypseb/tiRgenyXKWrO7yTVz6TG9q1YNBhkA0uZbS3e5u2w93PRB0fGlkCZDKy5lKOSMhvlekYQOvmoDv1MHTXwfaDn8F8LRXVPzhI6YljeI4AuSReT7c9u3+U/+8Xf9MLGUndSqIymD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpThwdtoO4lL/Pp45dPQwKCmPu1MGNMzacFVdcYhZZs=;
 b=jdZi2VB7xSGA9PYbugVbdSEdt0h6hDVghtiRjGUrORGEfeKDdKnQbNL5wffxG3cUesKA8lp9i72luHdqVhHXfct+S/Q2ZSTFsiMPV80OLsYZmS5gILM8Dv4t3B6almGQaBJ/ChhlFI3Mr0x0Pay6TwCmtEKzPrZDQgkf9JCMBbjGccla9A7PUrzw3QU6ddOGEw/0VF/xqKJzXoGJ8NfucjoFO4MbNR1MjHcX1B9Ebbc2e0Y44Vkg+UrbWzvN8Spoin371pFdKOIX4O2S+LwCkUHZl5MTbptMODJJdFxXwxmsP7jHvlMoEHfq456aWKx6WanQPe7OuocuKBtlX2jxYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=xilinx.com;dmarc=pass action=none
 header.from=xilinx.com;dkim=pass header.d=xilinx.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpThwdtoO4lL/Pp45dPQwKCmPu1MGNMzacFVdcYhZZs=;
 b=h2Q0wozMj8hTvtrrKKDYTytm/lWXuI1HVmZNVxkEAU0XR5fh+N1YdaxwCwci8qgYosu7+ir6WxcvgFmVW0iHmJTy+30lKBSAWtT/UNofkUUIxfV0vUvUDlFIA7uwNXQLNqgrkWQyWTfq01zDgga+wSSlQel+HDsFlG3TgX+yT/U=
Received: from MN2PR02MB5727.namprd02.prod.outlook.com (20.179.85.153) by
 MN2PR02MB6448.namprd02.prod.outlook.com (20.179.99.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 12:31:19 +0000
Received: from MN2PR02MB5727.namprd02.prod.outlook.com
 ([fe80::3873:a3ea:1f66:fc89]) by MN2PR02MB5727.namprd02.prod.outlook.com
 ([fe80::3873:a3ea:1f66:fc89%7]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:31:19 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>
CC:     "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: RE: [PATCH 5/6] mtd: spi-nor: Add s3an_post_sfdp_fixups()
Thread-Topic: [PATCH 5/6] mtd: spi-nor: Add s3an_post_sfdp_fixups()
Thread-Index: AQHVR4AuPtwOhxyzBUKoXu06OueqLabkpU9A
Date:   Wed, 31 Jul 2019 12:31:19 +0000
Message-ID: <MN2PR02MB5727FF8617B1A2FC89739601AFDF0@MN2PR02MB5727.namprd02.prod.outlook.com>
References: <20190731091145.27374-1-tudor.ambarus@microchip.com>
 <20190731091145.27374-6-tudor.ambarus@microchip.com>
In-Reply-To: <20190731091145.27374-6-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a42b926d-e364-4fad-75c4-08d715b2fd57
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR02MB6448;
x-ms-traffictypediagnostic: MN2PR02MB6448:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MN2PR02MB64480C3C5943F3F8FC81ACC4AFDF0@MN2PR02MB6448.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(189003)(199004)(13464003)(51914003)(86362001)(7736002)(76116006)(53936002)(6306002)(14444005)(6436002)(71190400001)(478600001)(9686003)(102836004)(55016002)(71200400001)(8936002)(11346002)(99286004)(14454004)(476003)(7696005)(966005)(26005)(256004)(7416002)(6116002)(66476007)(74316002)(3846002)(81166006)(305945005)(25786009)(52536014)(486006)(53546011)(446003)(316002)(4326008)(2201001)(66446008)(2501003)(64756008)(66946007)(76176011)(54906003)(81156014)(6246003)(33656002)(6506007)(66556008)(110136005)(8676002)(5660300002)(229853002)(2906002)(66066001)(68736007)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6448;H:MN2PR02MB5727.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 56Ux3SN7EelnJHl/pQzDHG8VAYO654I36hgC5kUkA9OTNkg16d3lNkfKqs+2DNogNvufEhJ71hswd3r9bdOSfPmCBuysIMi2QOj+G00gjQIS6paKnSuYfXUlfIJVD+P5wsBCDLKYJVuv+MU2wXF9cRyTuUOkCm1XpTxgLwh/YvMr6CqRxfdPswABLPUnsEqrUkgG1KZUaA3b9QrWN7jcsotMkw5ge0gDK7tC/2Ia5EPmxDPYMLRF1qLBSEICJWbX+pvSQHYli3izjnmnv/mk+tN243I63IgBNqKABzvT0w5n7A3LVvYkJ1sGGYVDzR8toBMaw9WWnH3u0JawYi1vazij6dDG8ALLgubIh22VnZ4P8OQUlco8juXRALUQgAkn+JemZzBoExP0ZzO4bs6+wMo0NQ52qQKB84Fftpo93d4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42b926d-e364-4fad-75c4-08d715b2fd57
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:31:19.2925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nagasure@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6448
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

Thanks for the updates. With these kind of updates, we can add Vendor speci=
fic
Code easily, like Xilinx Dual parallel and stacked modes.
In these configurations we need to tweak the nor parameters like page_size,=
 sectors etc.
So with the help of these patches. we can easily update these parameters.

> -----Original Message-----
> From: linux-mtd <linux-mtd-bounces@lists.infradead.org> On Behalf Of
> Tudor.Ambarus@microchip.com
> Sent: Wednesday, July 31, 2019 2:42 PM
> To: boris.brezillon@collabora.com; marek.vasut@gmail.com; vigneshr@ti.com
> Cc: Tudor.Ambarus@microchip.com; richard@nod.at; linux-kernel@vger.kernel=
.org; linux-
> mtd@lists.infradead.org; miquel.raynal@bootlin.com; computersforpeace@gma=
il.com;
> dwmw2@infradead.org
> Subject: [PATCH 5/6] mtd: spi-nor: Add s3an_post_sfdp_fixups()
>=20
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>=20
> s3an_nor_scan() was overriding the opcode selection done in spi_nor_defau=
lt_setup(). Set nor-
> >setup() method in order to avoid unnecessary call to spi_nor_default_set=
up().
>=20
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.=
c index
> 0ff474e5e4f5..5fea5d7ce2cb 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2795,7 +2795,9 @@ static int spi_nor_check(struct spi_nor *nor)
>  	return 0;
>  }
>=20
> -static int s3an_nor_scan(struct spi_nor *nor)
> +static int s3an_nor_setup(struct spi_nor *nor,
> +			  const struct spi_nor_flash_parameter *params,
> +			  const struct spi_nor_hwcaps *hwcaps)
>  {
>  	int ret;
>  	u8 val;
> @@ -4393,6 +4395,11 @@ static void spansion_post_sfdp_fixups(struct spi_n=
or *nor)
>  	nor->mtd.erasesize =3D nor->info->sector_size;  }
>=20
> +static void s3an_post_sfdp_fixups(struct spi_nor *nor) {
> +	nor->setup =3D s3an_nor_setup;
> +}
> +
>  static void
>  spi_nor_manufacturer_post_sfdp_fixups(struct spi_nor *nor,
>  				      struct spi_nor_flash_parameter *params) @@ -4405,6
> +4412,9 @@ spi_nor_manufacturer_post_sfdp_fixups(struct spi_nor *nor,
>  	default:
>  		break;
>  	}
> +
> +	if (nor->info->flags & SPI_S3AN)
> +		s3an_post_sfdp_fixups(nor);
>  }
>
Instead of checking the flags, why can't we call directly the nor_fixups?
like Boris implementation nor->info->fixups->post_sfdp()
https://patchwork.ozlabs.org/patch/1009291/

Thanks,
Naga Sureshkumar Relli

>  static void spi_nor_post_sfdp_fixups(struct spi_nor *nor, @@ -4582,9 +45=
92,9 @@ static
> int spi_nor_select_erase(struct spi_nor *nor, u32 wanted_size)
>  	return 0;
>  }
>=20
> -static int spi_nor_setup(struct spi_nor *nor,
> -			 const struct spi_nor_flash_parameter *params,
> -			 const struct spi_nor_hwcaps *hwcaps)
> +static int spi_nor_default_setup(struct spi_nor *nor,
> +				 const struct spi_nor_flash_parameter *params,
> +				 const struct spi_nor_hwcaps *hwcaps)
>  {
>  	u32 ignored_mask, shared_mask;
>  	int err;
> @@ -4641,6 +4651,16 @@ static int spi_nor_setup(struct spi_nor *nor,
>  	return err;
>  }
>=20
> +static int spi_nor_setup(struct spi_nor *nor,
> +			 const struct spi_nor_flash_parameter *params,
> +			 const struct spi_nor_hwcaps *hwcaps) {
> +	if (!nor->setup)
> +		return 0;
> +
> +	return nor->setup(nor, params, hwcaps); }
> +
>  static int spi_nor_disable_write_protection(struct spi_nor *nor)  {
>  	if (!nor->disable_write_protection)
> @@ -4804,6 +4824,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *n=
ame,
>  	/* Kept only for backward compatibility purpose. */
>  	nor->quad_enable =3D spansion_quad_enable;
>  	nor->set_4byte =3D spansion_set_4byte;
> +	nor->setup =3D spi_nor_default_setup;
>=20
>  	/* Default locking operations. */
>  	if (info->flags & SPI_NOR_HAS_LOCK) {
> @@ -4905,12 +4926,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *=
name,
>  		return -EINVAL;
>  	}
>=20
> -	if (info->flags & SPI_S3AN) {
> -		ret =3D s3an_nor_scan(nor);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	/* Send all the required SPI flash commands to initialize device */
>  	ret =3D spi_nor_init(nor);
>  	if (ret)
> --
> 2.9.5
>=20
>=20
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
