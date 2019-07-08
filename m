Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D4AC606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71742064A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Kk9AMk7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfGHMS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:18:58 -0400
Received: from mail-eopbgr680082.outbound.protection.outlook.com ([40.107.68.82]:9667
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727914AbfGHMS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RqTV19T+ba/HSxncKC7fuW0LWisj0ZPdvgu9p0rYP8=;
 b=Kk9AMk7USxOA6VYmhRpQsSw9N4dOa//zI6RwKwn4V+gYwd+Akfs/k0zeXmCKw3XZgyleITIV1mPWijhYGykUHpvCboMWBRRxcZMsbI4EFgn3MivKLOB8ZXeLKtlgTJxHN4Welfd9eg516rPbyoeidyhLtUOf/aoqoo7U5lLzN4o=
Received: from DM6PR02MB4779.namprd02.prod.outlook.com (20.176.109.16) by
 DM6PR02MB5884.namprd02.prod.outlook.com (20.179.68.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Mon, 8 Jul 2019 12:18:50 +0000
Received: from DM6PR02MB4779.namprd02.prod.outlook.com
 ([fe80::936:90c8:a385:1513]) by DM6PR02MB4779.namprd02.prod.outlook.com
 ([fe80::936:90c8:a385:1513%4]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 12:18:50 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
CC:     "vigneshr@ti.com" <vigneshr@ti.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "helmut.grohne@intenta.de" <helmut.grohne@intenta.de>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: RE: [LINUX PATCH v17 1/2] mtd: rawnand: nand_micron: Do not over
 write driver's read_page()/write_page()
Thread-Topic: [LINUX PATCH v17 1/2] mtd: rawnand: nand_micron: Do not over
 write driver's read_page()/write_page()
Thread-Index: AQHVKxEOKM99KajnN0G2IiFegkrxG6atgBaAgABKdoCAAAOHgIAABNvwgAAFfoCAAAE2wIAAA0eAgAABfeCAEtCbgA==
Date:   Mon, 8 Jul 2019 12:18:50 +0000
Message-ID: <DM6PR02MB4779F9AA8C6E4391CBF7906EAFF60@DM6PR02MB4779.namprd02.prod.outlook.com>
References: <20190625044630.31717-1-naga.sureshkumar.relli@xilinx.com>
 <20190626084807.3f06e718@collabora.com>
 <DM6PR02MB47796E3306C166A91E0BAE91AFE20@DM6PR02MB4779.namprd02.prod.outlook.com>
 <20190626132715.6128d8b1@collabora.com>
 <DM6PR02MB4779D347620E88BDB943DEB4AFE20@DM6PR02MB4779.namprd02.prod.outlook.com>
 <20190626140417.440cf762@collabora.com>
 <DM6PR02MB4779B5C815FB4DAF33EF4996AFE20@DM6PR02MB4779.namprd02.prod.outlook.com>
 <20190626142021.484c4fd8@collabora.com>
 <DM6PR02MB477919D28FDC063894C3CF50AFE20@DM6PR02MB4779.namprd02.prod.outlook.com>
In-Reply-To: <DM6PR02MB477919D28FDC063894C3CF50AFE20@DM6PR02MB4779.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58b37a04-19ea-4f6f-3d39-08d7039e6f97
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR02MB5884;
x-ms-traffictypediagnostic: DM6PR02MB5884:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR02MB5884D5A4917FBD28611EC8CFAFF60@DM6PR02MB5884.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(13464003)(199004)(189003)(76116006)(5660300002)(73956011)(52536014)(81166006)(66446008)(186003)(14454004)(64756008)(6246003)(86362001)(66946007)(476003)(81156014)(66476007)(478600001)(8676002)(966005)(66556008)(26005)(76176011)(2906002)(71200400001)(8936002)(4326008)(25786009)(7696005)(9686003)(55016002)(71190400001)(66066001)(6506007)(486006)(53546011)(3846002)(316002)(6306002)(7416002)(6116002)(33656002)(99286004)(229853002)(68736007)(54906003)(305945005)(446003)(53936002)(74316002)(102836004)(110136005)(7736002)(256004)(14444005)(11346002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5884;H:DM6PR02MB4779.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nsb6i9Tfj7EeJaxoyBTLGbhG6soLOTI4G+fEfeFXZDh9DFb93U+K4M3l7keE4Re8O+KR+1Rzfu9/o7OVUGgwDkI7RX/NxuWI7PNJouGX42UktZY+rLMl2VHVy/aRlIv/Kt6db14hlq/V+8JQmvXZQNS28cdDku18cw9WfrJjrdaZ9h8lyomg2wO5LLwyL3RsQUlhgtrjpOg4pDRA4ufQRUr8PLVEKI9docnqEjStga6x5+EjEBN1JQl6hXbqIns0YChabH8tBF2EiWelQl13AHQj6vxvBz9X9PiBNSXCexjfdU/JFdv1UjSCbmwi3fiS3d2Mkx9pOaFWnc3gnYmDHc0T9KVRs+qy2kLR/K77ekSX4QkQhk+xIk/4wupm2WGATdGtbNcfH/h973vgaUGSmAWbiw4ExtbrNGrOzuzVRX4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b37a04-19ea-4f6f-3d39-08d7039e6f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 12:18:50.2836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nagasure@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5884
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: linux-mtd <linux-mtd-bounces@lists.infradead.org> On Behalf Of Naga=
 Sureshkumar
> Relli
> Sent: Wednesday, June 26, 2019 6:04 PM
> To: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: vigneshr@ti.com; bbrezillon@kernel.org; helmut.grohne@intenta.de; ric=
hard@nod.at;
> linux-kernel@vger.kernel.org; marek.vasut@gmail.com; yamada.masahiro@soci=
onext.com;
> linux-mtd@lists.infradead.org; miquel.raynal@bootlin.com; computersforpea=
ce@gmail.com;
> dwmw2@infradead.org
> Subject: RE: [LINUX PATCH v17 1/2] mtd: rawnand: nand_micron: Do not over=
 write
> driver's read_page()/write_page()
>=20
> Hi Boris,
>=20
> > -----Original Message-----
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> > Sent: Wednesday, June 26, 2019 5:50 PM
> > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > Cc: miquel.raynal@bootlin.com; helmut.grohne@intenta.de;
> > richard@nod.at; dwmw2@infradead.org; computersforpeace@gmail.com;
> > marek.vasut@gmail.com; vigneshr@ti.com; bbrezillon@kernel.org;
> > yamada.masahiro@socionext.com; linux- mtd@lists.infradead.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [LINUX PATCH v17 1/2] mtd: rawnand: nand_micron: Do not
> > over write driver's read_page()/write_page()
> >
> > On Wed, 26 Jun 2019 12:12:47 +0000
> > Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:
> >
> > > Hi Boris,
> > >
> > > > -----Original Message-----
> > > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > > Sent: Wednesday, June 26, 2019 5:34 PM
> > > > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > > > Cc: miquel.raynal@bootlin.com; helmut.grohne@intenta.de;
> > > > richard@nod.at; dwmw2@infradead.org; computersforpeace@gmail.com;
> > > > marek.vasut@gmail.com; vigneshr@ti.com; bbrezillon@kernel.org;
> > > > yamada.masahiro@socionext.com; linux- mtd@lists.infradead.org;
> > > > linux-kernel@vger.kernel.org
> > > > Subject: Re: [LINUX PATCH v17 1/2] mtd: rawnand: nand_micron: Do
> > > > not over write driver's read_page()/write_page()
> > > >
> > > > On Wed, 26 Jun 2019 11:51:12 +0000 Naga Sureshkumar Relli
> > > > <nagasure@xilinx.com> wrote:
> > > >
> > > > > Hi Boris,
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > > > > Sent: Wednesday, June 26, 2019 4:57 PM
> > > > > > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > > > > > Cc: miquel.raynal@bootlin.com; helmut.grohne@intenta.de;
> > > > > > richard@nod.at; dwmw2@infradead.org;
> > > > > > computersforpeace@gmail.com; marek.vasut@gmail.com;
> > > > > > vigneshr@ti.com; bbrezillon@kernel.org;
> > > > > > yamada.masahiro@socionext.com; linux- mtd@lists.infradead.org;
> > > > > > linux-kernel@vger.kernel.org
> > > > > > Subject: Re: [LINUX PATCH v17 1/2] mtd: rawnand: nand_micron:
> > > > > > Do not over write driver's read_page()/write_page()
> > > > > >
> > > > > > On Wed, 26 Jun 2019 11:22:33 +0000 Naga Sureshkumar Relli
> > > > > > <nagasure@xilinx.com> wrote:
> > > > > >
> > > > > > > Hi Boris,
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > > > > > > Sent: Wednesday, June 26, 2019 12:18 PM
> > > > > > > > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > > > > > > > Cc: miquel.raynal@bootlin.com; helmut.grohne@intenta.de;
> > > > > > > > richard@nod.at; dwmw2@infradead.org;
> > > > > > > > computersforpeace@gmail.com; marek.vasut@gmail.com;
> > > > > > > > vigneshr@ti.com; bbrezillon@kernel.org;
> > > > > > > > yamada.masahiro@socionext.com; linux-
> > > > > > > > mtd@lists.infradead.org; linux-kernel@vger.kernel.org
> > > > > > > > Subject: Re: [LINUX PATCH v17 1/2] mtd: rawnand:
> > > > > > > > nand_micron: Do not over write driver's
> > > > > > > > read_page()/write_page()
> > > > > > > >
> > > > > > > > On Mon, 24 Jun 2019 22:46:29 -0600 Naga Sureshkumar Relli
> > > > > > > > <naga.sureshkumar.relli@xilinx.com> wrote:
> > > > > > > >
> > > > > > > > > Add check before assigning chip->ecc.read_page() and
> > > > > > > > > chip->ecc.write_page()
> > > > > > > > >
> > > > > > > > > Signed-off-by: Naga Sureshkumar Relli
> > > > > > > > > <naga.sureshkumar.relli@xilinx.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/mtd/nand/raw/nand_micron.c | 7 +++++--
> > > > > > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/mtd/nand/raw/nand_micron.c
> > > > > > > > > b/drivers/mtd/nand/raw/nand_micron.c
> > > > > > > > > index cbd4f09ac178..565f2696c747 100644
> > > > > > > > > --- a/drivers/mtd/nand/raw/nand_micron.c
> > > > > > > > > +++ b/drivers/mtd/nand/raw/nand_micron.c
> > > > > > > > > @@ -500,8 +500,11 @@ static int micron_nand_init(struct n=
and_chip
> *chip)
> > > > > > > > >  		chip->ecc.size =3D 512;
> > > > > > > > >  		chip->ecc.strength =3D chip->base.eccreq.strength;
> > > > > > > > >  		chip->ecc.algo =3D NAND_ECC_BCH;
> > > > > > > > > -		chip->ecc.read_page =3D micron_nand_read_page_on_die_e=
cc;
> > > > > > > > > -		chip->ecc.write_page =3D micron_nand_write_page_on_die=
_ecc;
> > > > > > > > > +		if (!chip->ecc.read_page)
> > > > > > > > > +			chip->ecc.read_page =3D
> > > > > > > > > +micron_nand_read_page_on_die_ecc;
> > > > > > > > > +
> > > > > > > > > +		if (!chip->ecc.write_page)
> > > > > > > > > +			chip->ecc.write_page =3D
> > > > > > > > > +micron_nand_write_page_on_die_ecc;
> > > > > > > >
> > > > > > > > That's wrong, if you don't want on-die ECC to be used,
> > > > > > > > simply don't set nand-ecc-mode to "on- die".
> > > > > > > Ok. But if we want to use on-die ECC then you mean to say it
> > > > > > > is mandatory to use
> > > > > > micron_nand_read/write_page_on_die_ecc()?
> > > > > >
> > > > > > Absolutely, and if it doesn't work that means you driver does
> > > > > > not implement raw accesses correctly, which means it's still bu=
ggy...
> > > > > I agree. But let's say, if there is a limitation with the
> > > > > controller. Then it is must to have this
> > > > check right?
> > > > > I mean, for pl353 controller, we must clear the CS during the
> > > > > data phase, hence we are splitting the Transfer in the pl353_read=
/write_page_raw().
> > > > > +	pl353_nand_read_data_op(chip, buf, mtd->writesize, false);
> > > > > +	p =3D chip->oob_poi;
> > > > > +	pl353_nand_read_data_op(chip, p,
> > > > > +				(mtd->oobsize -
> > > > > +				PL353_NAND_LAST_TRANSFER_LENGTH),
> > false);
> > > > > +	p +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> > > > > +	xnfc->dataphase_addrflags |=3D PL353_NAND_CLEAR_CS;
> > > > > +	pl353_nand_read_data_op(chip, p,
> > PL353_NAND_LAST_TRANSFER_LENGTH,
> > > > > +				false);
> > > > > As the above sequence is needed even for raw access, PL353 is
> > > > > unable to use the on_die_page
> > > > reads.
> > > >
> > > > This "de-assert CS on last access" logic should be done in the
> > > > exec_op() implementation. I also wonder how that works for
> > > > operations that don't have data cycles. Oh, BTW, most chips are
> > > > CE-don't-care, which means you can assert/de-assert CS on each
> > > > read_data_op() without
> > any issues.
> > > Yes, we can assert/de-assert CS on each read/write_data_op().
> > > But what about transfer length splitting?
> > > +	p =3D chip->oob_poi;
> > > +	pl353_nand_read_data_op(chip, p,
> > > +				(mtd->oobsize -
> > > +				PL353_NAND_LAST_TRANSFER_LENGTH), false);
> > > +	p +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> > > This should be done as a part of pl353_raw_read/write() right?
> >
> > Are you sure you need to do that, and if that's the case, do you have a=
n idea why this is
> needed?
> > Is this "read last 4 bytes separately"
> > thing is needed, I suspect it's needed for any kind of input-data cycle=
s, not just page reads.
> Yes. It is needed. This is Limitation in the HW, need to handle last 4 by=
tes separately for both
> page read/writes
Just wanted to know, is this fix OK?

Regards,
Naga Sureshkumar Relli
>=20
> Regards,
> Naga Sureshkumar Relli
>=20
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
