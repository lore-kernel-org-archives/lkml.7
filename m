Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23DDC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 07:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B0F22CF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 07:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A9R3BEJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfH2Hri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 03:47:38 -0400
Received: from mail-eopbgr30082.outbound.protection.outlook.com ([40.107.3.82]:31543
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfH2Hri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 03:47:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTTV3BcLNOnl7TfPYcXcUj91AGQSEIYaFegUIQ2W+Wh3xvA8lpQjutX6QzB670xhZL8H2j5Qt5vVR8rhu2prpB2AqYwSnqcfFBTz8rBg8lu8yPTcsTS+E/G3/5wy1CQ3N2KP5y6R67QA2ND2jPPSyv3xFbH08VRzIAL93YXVOBpN8IhBAb4JuPOe1Va/BWLjpfW4f4R8dm0/UbrVixplW1XelzcYa0tzYwpo3aX2tY14J+sm9cnSSfMP7U+L0tr7cz1BAX5jtOKqNCvIiZ1d+wh6b+lwTZdTft2wTLVO/pt80/6vys6A4mMRmUEDJ7ttneO+J7Q8S4U/FYON+1juaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlNL/kkl+9SxR0r0hlES7gJQFijtbQcH9+3deBsX1vo=;
 b=hkvzUr1h9U6qovyqYz7J+3vZnYicZsqeENUmQftdVGgeT7+WLwSktONT+0Fj79MjXwaG+uGcSzc3oCYaYaahhGuF0DDHErzSnVnGdzZrxSyFdA6CKAyVTpHj9rLIibOySHF1TA6ylwQ99Tm8iLXu2lqr+EIkDGeO4hFGJyGNMuTzsVWH0O+KLJohZV7dwnYrf1Td02ZfW9g0y79e3nT/rMHARtaYDU0L0xDfAh1aLUB9ApvtFmWGHIcO7WNtWKHyobvHcRnIOUQ4y4wqzuQVHitLxtC5jWjM5QMGUqTr/eysCEtATZR7kT3cujSHPZC1z83CyYEDoCL6as+5NIuNwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlNL/kkl+9SxR0r0hlES7gJQFijtbQcH9+3deBsX1vo=;
 b=A9R3BEJbsl6YUavSpJR0Kez2V/gEvatmCMa8piWfbefKI3HgPvogLVF6lEvbNBDoWAf1V79Csb9nc3eF3FtixTmyMC3AWjQKHBJfJx3QZ/3btJ2L7CuO/1ovmlsd2UMqj2YaiHA5cnPB22Pl1d3djgXyVaTUsPeA8RDuDWuaAbA=
Received: from VI1PR04MB4015.eurprd04.prod.outlook.com (10.171.182.24) by
 VI1PR04MB5023.eurprd04.prod.outlook.com (20.177.50.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 29 Aug 2019 07:47:32 +0000
Received: from VI1PR04MB4015.eurprd04.prod.outlook.com
 ([fe80::a57b:62dd:488e:b4a]) by VI1PR04MB4015.eurprd04.prod.outlook.com
 ([fe80::a57b:62dd:488e:b4a%4]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 07:47:32 +0000
From:   Ashish Kumar <ashish.kumar@nxp.com>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
CC:     Kuldeep Singh <kuldeep.singh@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [Patch v3] drivers: mtd: spi-nor: Add flash property
 for mt25qu512a and mt35xu02g
Thread-Topic: [EXT] Re: [Patch v3] drivers: mtd: spi-nor: Add flash property
 for mt25qu512a and mt35xu02g
Thread-Index: AQHVUcNFGTl4okY6Y0qzj8r47WNYKacO+6GAgALbLQA=
Date:   Thu, 29 Aug 2019 07:47:32 +0000
Message-ID: <VI1PR04MB4015E5BA7BE9763A105AD47D95A20@VI1PR04MB4015.eurprd04.prod.outlook.com>
References: <1565692705-27749-1-git-send-email-Ashish.Kumar@nxp.com>
 <e55cd1f9-7359-5484-d258-1f3ea51584b6@microchip.com>
In-Reply-To: <e55cd1f9-7359-5484-d258-1f3ea51584b6@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ashish.kumar@nxp.com; 
x-originating-ip: [92.120.0.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed1abf51-17d3-4551-172e-08d72c55269d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5023;
x-ms-traffictypediagnostic: VI1PR04MB5023:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5023FE3B43E73DA2BD17498395A20@VI1PR04MB5023.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(13464003)(199004)(189003)(6306002)(966005)(55016002)(6436002)(6116002)(8936002)(316002)(14454004)(476003)(44832011)(486006)(45080400002)(86362001)(25786009)(66946007)(8676002)(33656002)(3846002)(54906003)(7736002)(446003)(6246003)(64756008)(53936002)(66446008)(66476007)(76116006)(66556008)(2906002)(5660300002)(2201001)(76176011)(305945005)(9686003)(102836004)(478600001)(7696005)(186003)(71200400001)(71190400001)(6506007)(14444005)(53546011)(11346002)(4326008)(81156014)(81166006)(110136005)(66066001)(256004)(2501003)(99286004)(74316002)(26005)(52536014)(229853002)(138113003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5023;H:VI1PR04MB4015.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LvZmQ0CxSgSnwH7QlEiIsVdGgchCCaA/PlNInFp+msOtDiwJkNnaYijMRX1KWqlUemu/ikVtaj192M8Y1BSaU9pa0xgOhpzEpEn4iqhxHHJqRYpQkd2mRFInPjv5THNNMEE4u1ahefEVt6oGV5Zj0A50eJBBeAVXcrynMD9hg+EhtJmNfVXdqB/55V24ibRZvt5DKabPIedRGvoUfpZ+azqZCTMA3vqiRKEexgqfRCe4bFuaFpUY0JLTnWpb521+9ogkg+p3QUYL/HLgtqi0d5pqQ2ZWw2JCiqmvNZXy4Phbng5GxZB0tcaecvwWOENcM0jqcNYQSDkc8Sxg4y1jlWdGJz9tThRZYOVN70sk8+WFJ4/QpycgpNOVIzkGtDPfdMQFMk7PXeDuWIrP95XgJ8bVObKIRUi22iwYrxyRGao=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1abf51-17d3-4551-172e-08d72c55269d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 07:47:32.6307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjUm6oXktAfDUpXrfDMbpHnDE6xFRxM2SDU5hCMfUBDyv2LRoQLGfEaJBYbjepHTw3SZWngaJT7gL7Hbv7/wWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-mtd <linux-mtd-bounces@lists.infradead.org> On Behalf Of
> Tudor.Ambarus@microchip.com
> Sent: Tuesday, August 27, 2019 5:34 PM
> To: Ashish Kumar <ashish.kumar@nxp.com>; marek.vasut@gmail.com;
> dwmw2@infradead.org; computersforpeace@gmail.com;
> miquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com; linux-
> mtd@lists.infradead.org
> Cc: Kuldeep Singh <kuldeep.singh@nxp.com>; linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [Patch v3] drivers: mtd: spi-nor: Add flash property f=
or
> mt25qu512a and mt35xu02g
>=20
> Caution: EXT Email
>=20
> Hi, Ashish,
>=20
> On 08/13/2019 01:38 PM, Ashish Kumar wrote:
> > External E-Mail
> >
> >
> > mt25qu512a is rebranded after its spinoff from STM, so it is different
> > only in term of operating frequency, initial JEDEC id is same as that
> > of n25q512a. In order to avoid any confussion with respect to name new
> > entry is added.
> > This flash is tested for Single I/O and QUAD I/O mode on LS1046FRWY.
> >
> > mt35xu02g is Octal flash supporting Single I/O and QCTAL I/O and it
> > has been tested on LS1028ARDB
> >
> > Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> > Signed-off-by: Ashish Kumar <ashish.kumar@nxp.com>
> > ---
> > v3:
> > -Reword commits msg
> > -rebase to top of mtd-linux spi-nor/next
> > v2:
> > Incorporate review comments from Vignesh
> >
> >  drivers/mtd/spi-nor/spi-nor.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c
> > b/drivers/mtd/spi-nor/spi-nor.c index 03cc788..97d3de8 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -1988,6 +1988,12 @@ static const struct flash_info spi_nor_ids[] =3D=
 {
> >       { "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SECT_4K |
> SPI_NOR_QUAD_READ) },
> >       { "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >       { "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512, SECT_4K |
> > SPI_NOR_QUAD_READ) },
> > +
> > +     /* Micron */
> > +     { "mt25qu512a", INFO6(0x20bb20, 0x104400, 64 * 1024, 1024, SECT_4=
K |
> > +                             USE_FSR | SPI_NOR_DUAL_READ |
> > +                             SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES)
> > + },
>=20
> I'm looking at the following datasheets: mt25qu512a [1] and n25q512a [2].
> Both flashes have the same Extended Device ID data. What will happen, is
> that you'll always hit the first valid entry, so "mt25qu512a", and you'll=
 indicate
> a 'wrong' flash name for n25q512a. If there is nothing that differentiate
> between the two, maybe you can add a comment in the code that says that
> "n25q512a" was re-branded to "mt25qu512a" after the STM spin-off.
> Whatever solution will be, it will be better if you do it in a separate p=
atch.
Hi Tudor,
Considering both are same, should I rename to mt25qu51a, and add SPI_NOR_4B=
_OPCODES or
Keep n25q512a, and comment about mt25qu51a  and add SPI_NOR_4B_OPCODES.

For separate patch comment you mean split mt25qu512a and mt35xu02g into 2 p=
atch.

>=20
> [1]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fstati=
c
> 6.arrow.com%2Faropdfconversion%2F1a8b08cb08427821f166137d064c4837e
> ca70f15%2F12682797700728481268266842945946mt25q_qlkt_u_512_abb_0.p
> df.pdf&amp;data=3D02%7C01%7Cashish.kumar%40nxp.com%7C26e59cbcfac14
> 8e5218c08d72ae6c46b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7
> C637025042940681828&amp;sdata=3DgWBeML98ws80FAnwA7nvB4qvVbFWUa
> YTyr8PV6IUP3A%3D&amp;reserved=3D0
>=20
> [2]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww
> .google.com%2Furl%3Fsa%3Dt%26rct%3Dj%26q%3D%26esrc%3Ds%26source
> %3Dweb%26cd%3D1%26cad%3Drja%26uact%3D8%26ved%3D2ahUKEwjZlJ_
> M_KLkAhWB66QKHV6WAX4QFjAAegQIAhAC%26url%3Dhttps%253A%252F%
> 252Fwww.micron.com%252F-
> %252Fmedia%252Fdocuments%252Fproducts%252Fdata-sheet%252Fnor-
> flash%252Fserial-
> nor%252Fn25q%252Fn25q_512mb_1_8v_65nm.pdf%26usg%3DAOvVaw3BSi
> UIfTgikFZ0FZ7O_D61&amp;data=3D02%7C01%7Cashish.kumar%40nxp.com%7C
> 26e59cbcfac148e5218c08d72ae6c46b%7C686ea1d3bc2b4c6fa92cd99c5c30163
> 5%7C0%7C1%7C637025042940681828&amp;sdata=3D0bbEjEbOWQJfVYhDjBx55
> d6YkDzgR2fP2XBurJvDrMU%3D&amp;reserved=3D0
>=20
> > +
> >       { "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K | USE=
_FSR |
> SPI_NOR_QUAD_READ) },
> >       { "n25q512ax3",  INFO(0x20ba20, 0, 64 * 1024, 1024, SECT_4K | USE=
_FSR
> | SPI_NOR_QUAD_READ) },
> >       { "n25q00",      INFO(0x20ba21, 0, 64 * 1024, 2048, SECT_4K | USE=
_FSR |
> SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
> > @@ -2003,6 +2009,9 @@ static const struct flash_info spi_nor_ids[] =3D =
{
> >                       SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
> >                       SPI_NOR_4B_OPCODES)
> >       },
> > +     { "mt35xu02g",  INFO(0x2c5b1c, 0, 128 * 1024, 2048,
> > +                     SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
> > +                     SPI_NOR_4B_OPCODES) },
>=20
> Is there a public datasheet for this flash?
No,  data sheet in under NDA, I have asked micron FAE for public data sheet=
, will resend after the same is published.=20

Regards
Ashish=20
>=20
> Cheers,
> ta
> ______________________________________________________
> Linux MTD discussion mailing list
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists.=
in
> fradead.org%2Fmailman%2Flistinfo%2Flinux-
> mtd%2F&amp;data=3D02%7C01%7Cashish.kumar%40nxp.com%7C26e59cbcfac
> 148e5218c08d72ae6c46b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1
> %7C637025042940681828&amp;sdata=3DrNBZ%2B0F%2BW8Oxr55LGfABHLZSM
> M4neUMW8kinK1qh6eo%3D&amp;reserved=3D0
