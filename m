Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B66BC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 05:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4772E21743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 05:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="1CxmTbq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfGQFdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 01:33:41 -0400
Received: from mail-eopbgr730056.outbound.protection.outlook.com ([40.107.73.56]:20209
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbfGQFdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 01:33:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqEdCvRA1BShk1eXi/JqRYQQiJaNnYzp7Q4ILf7tgtYbLEcjR1fjPird3CcbonACWG6Wtp0PH2Tysngp0Kzak7SDwxRNLs7WeT4HdhW72MiGPC9q8A4P430V+esQsHHRMFz3F7vFONicYK1fTFOsq6G6Ops2AYkXeI5wMXjBiRlhPP1ssEQmkDpjYrcrXEiEOQRo/qxRG8ROYRSOOZ0HpSyx+3yctXydL7fcmSmHVb+B0Uv5iQrvlgpW6h0GSJ/4RGpeNDM5aULbUosy99OVO5MPqOgSq3eI5/qcVcfGv15RN+XPk3ilTj90IRVXfieamsjNCkqn/GKpKzMF4LSB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5Zg18hYb+n1/w3c0DL9dslwZp1Nqtuuq+3rHuwirGo=;
 b=SPO+kkQcC5WCG4zZB+lG1tFULjB1cAG+HNSL1Lyi6ZI3tKOl7umcIBQtj/fKn3C90OpRhroTLJySLQ4vXOJO5gGbCeF215m45rRnLCPinoCsix7fQmFYGZSbx4xzViqXcJnORQoSRKDDVgyHj2NAZas8Nx4Lr6EMu3NUAZ3sPm29nbHZpyuJFlxzPlqLzvRKT35JwFA4N7LXk87X8netWBaHm27b24gnIa3bU9vDtMgCmXSczZWentYlHCkAOAgRexQVomo2yth6f9ZOiq2x5f5kTLjZWOQ2F3sJZkSxMA+oydt4S5lAqWlwgwYyurm+OmfxX7gAJeciPGvKS6ZWiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=xilinx.com;dmarc=pass action=none
 header.from=xilinx.com;dkim=pass header.d=xilinx.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5Zg18hYb+n1/w3c0DL9dslwZp1Nqtuuq+3rHuwirGo=;
 b=1CxmTbq93exhABnuOPKkoKHVTVMl9nzDm62SNsyGI8iK+Bt3TAow0Laogcfg2wOMBh1RbVpWHlt4kVHVCzALllX/Z2A8VlvPbqilihgTdh09PkPXTSF1b7CGHcdn0fxLULwu8rAmj/1cJGRQRIs79hbFrLhMyoHmM42Hentjj08=
Received: from DM6PR02MB4779.namprd02.prod.outlook.com (20.176.109.16) by
 DM6PR02MB4492.namprd02.prod.outlook.com (20.176.104.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Wed, 17 Jul 2019 05:33:35 +0000
Received: from DM6PR02MB4779.namprd02.prod.outlook.com
 ([fe80::936:90c8:a385:1513]) by DM6PR02MB4779.namprd02.prod.outlook.com
 ([fe80::936:90c8:a385:1513%4]) with mapi id 15.20.2073.012; Wed, 17 Jul 2019
 05:33:35 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Srikanth Vemula <svemula@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
Subject: RE: [LINUX PATCH v18 1/2] mtd: rawnand: nand_micron: Do not over
 write driver's read_page()/write_page()
Thread-Topic: [LINUX PATCH v18 1/2] mtd: rawnand: nand_micron: Do not over
 write driver's read_page()/write_page()
Thread-Index: AQHVO5eo4+vjEMfVj0u12vHDQxXMaabM2dGAgAADsQCAAWJjoA==
Date:   Wed, 17 Jul 2019 05:33:35 +0000
Message-ID: <DM6PR02MB4779307E32670683AE9F60D6AFC90@DM6PR02MB4779.namprd02.prod.outlook.com>
References: <20190716053051.11282-1-naga.sureshkumar.relli@xilinx.com>
        <20190716093137.3d8e8c1f@pc-375.home> <20190716094450.122ba6e7@pc-375.home>
In-Reply-To: <20190716094450.122ba6e7@pc-375.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1a0aaeb-2f7a-4579-1c03-08d70a78504d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR02MB4492;
x-ms-traffictypediagnostic: DM6PR02MB4492:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR02MB4492C91FB4F5972A8D91C7B8AFC90@DM6PR02MB4492.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(13464003)(199004)(189003)(316002)(7736002)(54906003)(33656002)(8936002)(6436002)(478600001)(14454004)(99286004)(81156014)(81166006)(6116002)(53936002)(4326008)(7696005)(6506007)(25786009)(2906002)(446003)(256004)(66446008)(66476007)(71190400001)(229853002)(6916009)(7416002)(66946007)(76116006)(11346002)(66556008)(186003)(5660300002)(14444005)(76176011)(86362001)(26005)(52536014)(74316002)(66066001)(64756008)(55016002)(486006)(6306002)(3846002)(8676002)(966005)(9686003)(6246003)(476003)(53546011)(68736007)(305945005)(102836004)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4492;H:DM6PR02MB4779.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3O0lWqUhHpRlsIA9dFMOKBcWBcUlazHRxFP7r1EkYb9HMkXbHqxS0NuHv+eQ0E8CslecUG2NoSgYzmGXQsyq7rjLMJlGgUOQwScyNr/qSXXE9OvPU7gQSdcuoRQz7oLmIUojPx9vlZLJ00dxuqVeP5CX4anA6i0ZIBMfOan58PTyQ27jzyldE8gK1eeps039HzOoH0Hmw43W9Wu/mnIVJN41pH29hJxGtlIwLcW/ztKob44rZuGbpH9/oQMOpHr43lf7OUAmDO7E2dsAxYadrQPAQ5fkmf5TFTQ7pMcpreVyILQLPBsLoIMHVwQNaxokosi+e03tOrELTrUQYegM5rOfyrElb6RWEGyukm4/XDXqwtI38TUbkvqdQgDk/af8lROP1Y7HSheir86OqzpCBRzbUhx04LxLvfhNYFUoTH0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a0aaeb-2f7a-4579-1c03-08d70a78504d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 05:33:35.4419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nagasure@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4492
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon <boris.brezillon@collabora.com>
> Sent: Tuesday, July 16, 2019 1:15 PM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: miquel.raynal@bootlin.com; bbrezillon@kernel.org; richard@nod.at;
> dwmw2@infradead.org; computersforpeace@gmail.com; marek.vasut@gmail.com;
> vigneshr@ti.com; yamada.masahiro@socionext.com; linux-mtd@lists.infradead=
.org; linux-
> kernel@vger.kernel.org; Michal Simek <michals@xilinx.com>; Srikanth Vemul=
a
> <svemula@xilinx.com>; nagasuresh12@gmail.com
> Subject: Re: [LINUX PATCH v18 1/2] mtd: rawnand: nand_micron: Do not over=
 write
> driver's read_page()/write_page()
>=20
> On Tue, 16 Jul 2019 09:31:37 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
>=20
> > On Mon, 15 Jul 2019 23:30:51 -0600
> > Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
> >
> > > Add check before assigning chip->ecc.read_page() and
> > > chip->ecc.write_page()
> > >
> > > Signed-off-by: Naga Sureshkumar Relli
> > > <naga.sureshkumar.relli@xilinx.com>
> > > ---
> > > Changes in v18
> > >  - None
> > > ---
> > >  drivers/mtd/nand/raw/nand_micron.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mtd/nand/raw/nand_micron.c
> > > b/drivers/mtd/nand/raw/nand_micron.c
> > > index cbd4f09ac178..565f2696c747 100644
> > > --- a/drivers/mtd/nand/raw/nand_micron.c
> > > +++ b/drivers/mtd/nand/raw/nand_micron.c
> > > @@ -500,8 +500,11 @@ static int micron_nand_init(struct nand_chip *ch=
ip)
> > >  		chip->ecc.size =3D 512;
> > >  		chip->ecc.strength =3D chip->base.eccreq.strength;
> > >  		chip->ecc.algo =3D NAND_ECC_BCH;
> > > -		chip->ecc.read_page =3D micron_nand_read_page_on_die_ecc;
> > > -		chip->ecc.write_page =3D micron_nand_write_page_on_die_ecc;
> > > +		if (!chip->ecc.read_page)
> > > +			chip->ecc.read_page =3D micron_nand_read_page_on_die_ecc;
> > > +
> > > +		if (!chip->ecc.write_page)
> > > +			chip->ecc.write_page =3D micron_nand_write_page_on_die_ecc;
> > >
> >
> > Seriously?! I told you this was inappropriate and you keep sending
> > this patch. So let's make it clear:
> >
> > Nacked-by: Boris Brezillon <boris.brezillon@collabora.com>
> >
> > Fix your controller driver instead of adding hacks to the Micron logic!
>=20
> Not even going to review the other patch: if you have to do that, that me=
ans the driver is
> broken. On a side note, this patch series is still not threaded as it sho=
uld be and it's a v18 for a
> damn NAND controller driver! Sorry but you reached the limit of my patien=
ce. Please find
> someone to help you with that task.
My intention is not to resend this 1/2 again. Sorry for that.
We already had some discussion on [v17 1/2], https://lkml.org/lkml/2019/6/2=
6/430
And there we didn't conclude that raw_read()/writes().=20
So I thought that, will send updated driver along with this patch, then wil=
l get more information about
The issue on the latest driver review.
There is nothing like keep on sending this patch, As you people are experts=
 in the driver review,=20
if this patch is a hack, then we will definitely fix that in controller dri=
ver. I will find a way to do that.

But in this flow of patch sending, if the work I did hurts you, then I am r=
eally sorry for that.
Will fix this issue in the controller driver and will send the updated one.
Could you please let me know if this is OK.

I will send the series as threaded one from next time onwards.

Thanks,
pcieNaga Sureshkumar Relli
