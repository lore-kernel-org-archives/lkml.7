Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2BFC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC992064A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="xZTAW0en"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfFZLWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 07:22:37 -0400
Received: from mail-eopbgr690060.outbound.protection.outlook.com ([40.107.69.60]:65531
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726104AbfFZLWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HELjfFyhQIb0MvNALOGGkLXTIak9XAxQdggCW07O0Co=;
 b=xZTAW0enIxFNIF5JKxtH178isqpKkI6jRR8Xcy01Nh9esSwTCB4MamhzG4IfjbBbfQDToCpUBKzMPA10peJlekFbOYgBs+ygNbsuGj4kY3EzO29AGagv02mZ+w7hR3tyk/LTYXvdxi58VD02nY6BzwvfIeKQBRG/bGEHmbcPOMA=
Received: from DM6PR02MB4779.namprd02.prod.outlook.com (20.176.109.16) by
 DM6PR02MB4665.namprd02.prod.outlook.com (20.176.108.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 11:22:33 +0000
Received: from DM6PR02MB4779.namprd02.prod.outlook.com
 ([fe80::936:90c8:a385:1513]) by DM6PR02MB4779.namprd02.prod.outlook.com
 ([fe80::936:90c8:a385:1513%4]) with mapi id 15.20.2008.017; Wed, 26 Jun 2019
 11:22:33 +0000
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
Thread-Index: AQHVKxEOKM99KajnN0G2IiFegkrxG6atgBaAgABKdoA=
Date:   Wed, 26 Jun 2019 11:22:33 +0000
Message-ID: <DM6PR02MB47796E3306C166A91E0BAE91AFE20@DM6PR02MB4779.namprd02.prod.outlook.com>
References: <20190625044630.31717-1-naga.sureshkumar.relli@xilinx.com>
 <20190626084807.3f06e718@collabora.com>
In-Reply-To: <20190626084807.3f06e718@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95cbaa52-84e9-44aa-d657-08d6fa2895ba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR02MB4665;
x-ms-traffictypediagnostic: DM6PR02MB4665:
x-microsoft-antispam-prvs: <DM6PR02MB46657F33B1F5DECD90BB2C5DAFE20@DM6PR02MB4665.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(366004)(39850400004)(346002)(13464003)(189003)(199004)(6916009)(102836004)(26005)(6506007)(86362001)(33656002)(53546011)(478600001)(6436002)(99286004)(305945005)(486006)(446003)(7736002)(76176011)(186003)(4326008)(11346002)(3846002)(6116002)(7696005)(66446008)(476003)(25786009)(52536014)(64756008)(66556008)(66476007)(73956011)(66946007)(76116006)(74316002)(14454004)(81166006)(81156014)(5660300002)(8676002)(6246003)(8936002)(66066001)(53936002)(229853002)(2906002)(54906003)(9686003)(55016002)(316002)(68736007)(7416002)(71200400001)(71190400001)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4665;H:DM6PR02MB4779.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: imTRrbx7JsSftHeYBqITjQ0teiDCoP+CsC5nPkmjqHIiVQbyg07sHELe3aBmSF8+xuZMeaHeYxrpz9xs0DAx2vFvJMDDwJdPLd5pdk3aHt9E8FinBT0uLQpsOYGiWDfZ/TVRpfRfdiY5QqBemtbn1ZakxNqKKAH1zTIQvlCZyK7Hi4iU6y/3a7lFFNVmy5Tm+ercf8gDntWsx4Manw1W+K6OO8FLdrzkIo3L2yQBM2RMwc7Te67CCIOaZmQb6ldcSZnyp12ACP/06ToYl6S5djuf8Fw5+4p4vwHhBHHNpcOD7mlhQbRGMXElSL2dA2ZoZuiy4Po8KjtlUGYn3ruJonjfP2HbUhxYZqJUBsJSaRdZ7QsZik0rgolBavlew3t4OEGmB3EaH+l2yPyW6ChHnXI+Nq/zwctECcdgj3lt/9M=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cbaa52-84e9-44aa-d657-08d6fa2895ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 11:22:33.5860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nagasure@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4665
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon <boris.brezillon@collabora.com>
> Sent: Wednesday, June 26, 2019 12:18 PM
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
> On Mon, 24 Jun 2019 22:46:29 -0600
> Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
>=20
> > Add check before assigning chip->ecc.read_page() and
> > chip->ecc.write_page()
> >
> > Signed-off-by: Naga Sureshkumar Relli
> > <naga.sureshkumar.relli@xilinx.com>
> > ---
> >  drivers/mtd/nand/raw/nand_micron.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/nand_micron.c
> > b/drivers/mtd/nand/raw/nand_micron.c
> > index cbd4f09ac178..565f2696c747 100644
> > --- a/drivers/mtd/nand/raw/nand_micron.c
> > +++ b/drivers/mtd/nand/raw/nand_micron.c
> > @@ -500,8 +500,11 @@ static int micron_nand_init(struct nand_chip *chip=
)
> >  		chip->ecc.size =3D 512;
> >  		chip->ecc.strength =3D chip->base.eccreq.strength;
> >  		chip->ecc.algo =3D NAND_ECC_BCH;
> > -		chip->ecc.read_page =3D micron_nand_read_page_on_die_ecc;
> > -		chip->ecc.write_page =3D micron_nand_write_page_on_die_ecc;
> > +		if (!chip->ecc.read_page)
> > +			chip->ecc.read_page =3D micron_nand_read_page_on_die_ecc;
> > +
> > +		if (!chip->ecc.write_page)
> > +			chip->ecc.write_page =3D micron_nand_write_page_on_die_ecc;
>=20
> That's wrong, if you don't want on-die ECC to be used, simply don't set n=
and-ecc-mode to "on-
> die".
Ok. But if we want to use on-die ECC then you mean to say it is mandatory t=
o use micron_nand_read/write_page_on_die_ecc()?

Regards,
Naga Sureshkumar Relli
>=20
> >
> >  		if (ondie =3D=3D MICRON_ON_DIE_MANDATORY) {
> >  			chip->ecc.read_page_raw =3D nand_read_page_raw_notsupp;

