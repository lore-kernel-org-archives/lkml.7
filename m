Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D077C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44402086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="iI9qcS6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfFZMfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:35:40 -0400
Received: from mail-eopbgr760082.outbound.protection.outlook.com ([40.107.76.82]:3910
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726131AbfFZMfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eH1Gjz/SwiOnqPv7o/dbajUXmfLWHUqFdqJQ2e6SEf0=;
 b=iI9qcS6NjUdkzQgWwnqiFOD+Vqi2zZHjg6+tsRF1bbCiwRD3QpVctOynYmjh286nk5yYNkk/nSs3lqkvELFYzma3ux7rVxca63ju766Jt9zKHM3Cdm/H6xjGpWKyU9FxlZx73f3lKjqG2t6jpvX8EFKyV6pK2qNjjZqTNxhvnRc=
Received: from DM6PR02MB4779.namprd02.prod.outlook.com (20.176.109.16) by
 DM6PR02MB4090.namprd02.prod.outlook.com (20.176.75.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.18; Wed, 26 Jun 2019 12:33:54 +0000
Received: from DM6PR02MB4779.namprd02.prod.outlook.com
 ([fe80::936:90c8:a385:1513]) by DM6PR02MB4779.namprd02.prod.outlook.com
 ([fe80::936:90c8:a385:1513%4]) with mapi id 15.20.2008.017; Wed, 26 Jun 2019
 12:33:54 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "helmut.grohne@intenta.de" <helmut.grohne@intenta.de>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [LINUX PATCH v17 1/2] mtd: rawnand: nand_micron: Do not over
 write driver's read_page()/write_page()
Thread-Topic: [LINUX PATCH v17 1/2] mtd: rawnand: nand_micron: Do not over
 write driver's read_page()/write_page()
Thread-Index: AQHVKxEOKM99KajnN0G2IiFegkrxG6atgBaAgABKdoCAAAOHgIAABNvwgAAFfoCAAAE2wIAAA0eAgAABfeA=
Date:   Wed, 26 Jun 2019 12:33:54 +0000
Message-ID: <DM6PR02MB477919D28FDC063894C3CF50AFE20@DM6PR02MB4779.namprd02.prod.outlook.com>
References: <20190625044630.31717-1-naga.sureshkumar.relli@xilinx.com>
        <20190626084807.3f06e718@collabora.com>
        <DM6PR02MB47796E3306C166A91E0BAE91AFE20@DM6PR02MB4779.namprd02.prod.outlook.com>
        <20190626132715.6128d8b1@collabora.com>
        <DM6PR02MB4779D347620E88BDB943DEB4AFE20@DM6PR02MB4779.namprd02.prod.outlook.com>
        <20190626140417.440cf762@collabora.com>
        <DM6PR02MB4779B5C815FB4DAF33EF4996AFE20@DM6PR02MB4779.namprd02.prod.outlook.com>
 <20190626142021.484c4fd8@collabora.com>
In-Reply-To: <20190626142021.484c4fd8@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3229a60-a164-475a-3395-08d6fa328d2d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR02MB4090;
x-ms-traffictypediagnostic: DM6PR02MB4090:
x-microsoft-antispam-prvs: <DM6PR02MB409062D03A1F0D686B1F5D4EAFE20@DM6PR02MB4090.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(346002)(376002)(136003)(13464003)(189003)(199004)(14444005)(9686003)(102836004)(256004)(25786009)(6436002)(7416002)(81166006)(4326008)(81156014)(229853002)(305945005)(55016002)(53936002)(74316002)(33656002)(8936002)(52536014)(7736002)(8676002)(2906002)(476003)(11346002)(76176011)(14454004)(5660300002)(71190400001)(6506007)(53546011)(99286004)(66066001)(446003)(68736007)(486006)(7696005)(54906003)(71200400001)(316002)(478600001)(6246003)(3846002)(6116002)(186003)(26005)(6916009)(76116006)(66446008)(73956011)(86362001)(66476007)(66556008)(66946007)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4090;H:DM6PR02MB4779.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HckuFpK08hU5rbLwAujp9Y8G8e2qKvDd/fZm3Vymryp47zvq6xlzVZzk2LJX4tmm8m9FWy1FjELEUutp2KtzKPEIvwsrFoe6QNjIoy5e4Zqd5q6kb3B8Cmad++sJ8G3RuJDxMxmIp8XzpsKPWNAY6Lo0qPGzAWj6wwTLeXRRGjwvQtboUqfiLxmRNc8Nayi2fR08SiFw/lLW5UIASw5dU6fdV7xFqUYks18Az7xfq8aKhD1b5BdHsch6pH6d9RuSWtZ6ONhyjxwb1OS10PPJxTaGZflwxOAzXoBKljPqPsSZQmvdKHcj1J9nQy/wWAuNqXWGPoMX927gTtKEIMSi1c4JE+pqK/dijnWRz+X9fzFW5sTcPLquaTjdrPxv7JHeCr9vRLa2fddQr9u+yBq/qgEQRFkP43mOXzbXgJUbvTw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3229a60-a164-475a-3395-08d6fa328d2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 12:33:54.2592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nagasure@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon <boris.brezillon@collabora.com>
> Sent: Wednesday, June 26, 2019 5:50 PM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: miquel.raynal@bootlin.com; helmut.grohne@intenta.de; richard@nod.at;
> dwmw2@infradead.org; computersforpeace@gmail.com; marek.vasut@gmail.com;
> vigneshr@ti.com; bbrezillon@kernel.org; yamada.masahiro@socionext.com; li=
nux-
> mtd@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [LINUX PATCH v17 1/2] mtd: rawnand: nand_micron: Do not over=
 write
> driver's read_page()/write_page()
>=20
> On Wed, 26 Jun 2019 12:12:47 +0000
> Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:
>=20
> > Hi Boris,
> >
> > > -----Original Message-----
> > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > Sent: Wednesday, June 26, 2019 5:34 PM
> > > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > > Cc: miquel.raynal@bootlin.com; helmut.grohne@intenta.de;
> > > richard@nod.at; dwmw2@infradead.org; computersforpeace@gmail.com;
> > > marek.vasut@gmail.com; vigneshr@ti.com; bbrezillon@kernel.org;
> > > yamada.masahiro@socionext.com; linux- mtd@lists.infradead.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [LINUX PATCH v17 1/2] mtd: rawnand: nand_micron: Do not
> > > over write driver's read_page()/write_page()
> > >
> > > On Wed, 26 Jun 2019 11:51:12 +0000
> > > Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:
> > >
> > > > Hi Boris,
> > > >
> > > > > -----Original Message-----
> > > > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > > > Sent: Wednesday, June 26, 2019 4:57 PM
> > > > > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > > > > Cc: miquel.raynal@bootlin.com; helmut.grohne@intenta.de;
> > > > > richard@nod.at; dwmw2@infradead.org;
> > > > > computersforpeace@gmail.com; marek.vasut@gmail.com;
> > > > > vigneshr@ti.com; bbrezillon@kernel.org;
> > > > > yamada.masahiro@socionext.com; linux- mtd@lists.infradead.org;
> > > > > linux-kernel@vger.kernel.org
> > > > > Subject: Re: [LINUX PATCH v17 1/2] mtd: rawnand: nand_micron: Do
> > > > > not over write driver's read_page()/write_page()
> > > > >
> > > > > On Wed, 26 Jun 2019 11:22:33 +0000 Naga Sureshkumar Relli
> > > > > <nagasure@xilinx.com> wrote:
> > > > >
> > > > > > Hi Boris,
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > > > > > Sent: Wednesday, June 26, 2019 12:18 PM
> > > > > > > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > > > > > > Cc: miquel.raynal@bootlin.com; helmut.grohne@intenta.de;
> > > > > > > richard@nod.at; dwmw2@infradead.org;
> > > > > > > computersforpeace@gmail.com; marek.vasut@gmail.com;
> > > > > > > vigneshr@ti.com; bbrezillon@kernel.org;
> > > > > > > yamada.masahiro@socionext.com; linux-
> > > > > > > mtd@lists.infradead.org; linux-kernel@vger.kernel.org
> > > > > > > Subject: Re: [LINUX PATCH v17 1/2] mtd: rawnand:
> > > > > > > nand_micron: Do not over write driver's
> > > > > > > read_page()/write_page()
> > > > > > >
> > > > > > > On Mon, 24 Jun 2019 22:46:29 -0600 Naga Sureshkumar Relli
> > > > > > > <naga.sureshkumar.relli@xilinx.com> wrote:
> > > > > > >
> > > > > > > > Add check before assigning chip->ecc.read_page() and
> > > > > > > > chip->ecc.write_page()
> > > > > > > >
> > > > > > > > Signed-off-by: Naga Sureshkumar Relli
> > > > > > > > <naga.sureshkumar.relli@xilinx.com>
> > > > > > > > ---
> > > > > > > >  drivers/mtd/nand/raw/nand_micron.c | 7 +++++--
> > > > > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/mtd/nand/raw/nand_micron.c
> > > > > > > > b/drivers/mtd/nand/raw/nand_micron.c
> > > > > > > > index cbd4f09ac178..565f2696c747 100644
> > > > > > > > --- a/drivers/mtd/nand/raw/nand_micron.c
> > > > > > > > +++ b/drivers/mtd/nand/raw/nand_micron.c
> > > > > > > > @@ -500,8 +500,11 @@ static int micron_nand_init(struct nan=
d_chip *chip)
> > > > > > > >  		chip->ecc.size =3D 512;
> > > > > > > >  		chip->ecc.strength =3D chip->base.eccreq.strength;
> > > > > > > >  		chip->ecc.algo =3D NAND_ECC_BCH;
> > > > > > > > -		chip->ecc.read_page =3D micron_nand_read_page_on_die_ecc=
;
> > > > > > > > -		chip->ecc.write_page =3D micron_nand_write_page_on_die_e=
cc;
> > > > > > > > +		if (!chip->ecc.read_page)
> > > > > > > > +			chip->ecc.read_page =3D
> > > > > > > > +micron_nand_read_page_on_die_ecc;
> > > > > > > > +
> > > > > > > > +		if (!chip->ecc.write_page)
> > > > > > > > +			chip->ecc.write_page =3D
> > > > > > > > +micron_nand_write_page_on_die_ecc;
> > > > > > >
> > > > > > > That's wrong, if you don't want on-die ECC to be used,
> > > > > > > simply don't set nand-ecc-mode to "on- die".
> > > > > > Ok. But if we want to use on-die ECC then you mean to say it
> > > > > > is mandatory to use
> > > > > micron_nand_read/write_page_on_die_ecc()?
> > > > >
> > > > > Absolutely, and if it doesn't work that means you driver does
> > > > > not implement raw accesses correctly, which means it's still bugg=
y...
> > > > I agree. But let's say, if there is a limitation with the
> > > > controller. Then it is must to have this
> > > check right?
> > > > I mean, for pl353 controller, we must clear the CS during the data
> > > > phase, hence we are splitting the Transfer in the pl353_read/write_=
page_raw().
> > > > +	pl353_nand_read_data_op(chip, buf, mtd->writesize, false);
> > > > +	p =3D chip->oob_poi;
> > > > +	pl353_nand_read_data_op(chip, p,
> > > > +				(mtd->oobsize -
> > > > +				PL353_NAND_LAST_TRANSFER_LENGTH),
> false);
> > > > +	p +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> > > > +	xnfc->dataphase_addrflags |=3D PL353_NAND_CLEAR_CS;
> > > > +	pl353_nand_read_data_op(chip, p,
> PL353_NAND_LAST_TRANSFER_LENGTH,
> > > > +				false);
> > > > As the above sequence is needed even for raw access, PL353 is
> > > > unable to use the on_die_page
> > > reads.
> > >
> > > This "de-assert CS on last access" logic should be done in the
> > > exec_op() implementation. I also wonder how that works for
> > > operations that don't have data cycles. Oh, BTW, most chips are
> > > CE-don't-care, which means you can assert/de-assert CS on each read_d=
ata_op() without
> any issues.
> > Yes, we can assert/de-assert CS on each read/write_data_op().
> > But what about transfer length splitting?
> > +	p =3D chip->oob_poi;
> > +	pl353_nand_read_data_op(chip, p,
> > +				(mtd->oobsize -
> > +				PL353_NAND_LAST_TRANSFER_LENGTH), false);
> > +	p +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> > This should be done as a part of pl353_raw_read/write() right?
>=20
> Are you sure you need to do that, and if that's the case, do you have an =
idea why this is needed?
> Is this "read last 4 bytes separately"
> thing is needed, I suspect it's needed for any kind of input-data cycles,=
 not just page reads.
Yes. It is needed. This is Limitation in the HW, need to handle last 4 byte=
s separately for both page read/writes

Regards,
Naga Sureshkumar Relli
