Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9934EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465EB20661
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicronCorp.onmicrosoft.com header.i=@MicronCorp.onmicrosoft.com header.b="JQIwF2K7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfCDNaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:30:01 -0500
Received: from mailout.micron.com ([137.201.242.129]:61090 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfCDNaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:30:01 -0500
Received: from mail.micron.com (boexchangeum.micron.com [137.201.21.209])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id x24DTO6v014457;
        Mon, 4 Mar 2019 06:29:24 -0700
Received: from BOWEX36H.micron.com (137.201.84.179) by bowex17a.micron.com
 (137.201.21.209) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Mon, 4 Mar
 2019 06:29:23 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (137.201.84.23)
 by BOWEX36H.micron.com (137.201.84.179) with Microsoft SMTP Server (TLS) id
 15.0.1365.1 via Frontend Transport; Mon, 4 Mar 2019 06:29:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicronCorp.onmicrosoft.com; s=selector1-micron-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTnL4hFPbEtljZ5a8lLxCG6sF7ct8HwOBUKjCuQafyo=;
 b=JQIwF2K76hgGYYdZeoqPzoNCSnR4ECREVnxOLJi6H9vSvTXUfteRQsi5hu0MNkfTRzCn6xlZxo6W0u5mMvZupdR/iuEJ6mIKawE+MnjRlSF8KhsUFBEnySySecEYQNl5ENy6HL9rtfgiiviGdTbJubRsmEXE+5H7HtQtniDg7Zw=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB5758.namprd08.prod.outlook.com (20.179.87.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 13:29:21 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::b8c2:d8f4:8770:4d95]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::b8c2:d8f4:8770:4d95%2]) with mapi id 15.20.1665.019; Mon, 4 Mar 2019
 13:29:21 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Boris Brezillon <bbrezillon@kernel.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        "Richard Weinberger" <richard@nod.at>,
        Schrempf Frieder <frieder.schrempf@kontron.De>,
        Marek Vasut <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>
Subject: RE: [EXT] Re: [PATCH 2/2] mtd: spinand: micron: Support for all
 Micron SPI NAND flashes
Thread-Topic: [EXT] Re: [PATCH 2/2] mtd: spinand: micron: Support for all
 Micron SPI NAND flashes
Thread-Index: AdS8exJYD8uSWbLRR5WRv3oHfltCMQAOKHqABXYK3+A=
Date:   Mon, 4 Mar 2019 13:29:21 +0000
Message-ID: <MN2PR08MB5951EE4ACB78BAD12EDA5F76B8710@MN2PR08MB5951.namprd08.prod.outlook.com>
References: <MN2PR08MB5951FD3B8244ABBA72FF7430B86D0@MN2PR08MB5951.namprd08.prod.outlook.com>
 <20190204190151.2c7987b7@bbrezillon>
In-Reply-To: <20190204190151.2c7987b7@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6beb2aa-a9a6-4693-11d2-08d6a0a56908
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MN2PR08MB5758;
x-ms-traffictypediagnostic: MN2PR08MB5758:|MN2PR08MB5758:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MN2PR08MB5758;23:ldww2lubyEtWeCY590IoCRFspssGtfVn73ljU4o1q?=
 =?us-ascii?Q?fXD2bexiXGgop27pK47qsUR5Pb0O3gss/jZ3kc9ucJQ2GliCPEZzn6yMBYYZ?=
 =?us-ascii?Q?m5K5+T51uEh1S5/+A0/yiAOQwHKtplDjwjXXk5K6A6ir+wcp01xY0R8tTcyt?=
 =?us-ascii?Q?LcjjapgM1uGcplmXiEGSSggFdSZ7+lmpae51CmgSY+rsh/E/LKTj4gWK6aRf?=
 =?us-ascii?Q?2xKindqQ3qhzaET3gu1efyzSQ0FTcDoQ1BIhPMgJ/pHIx64q7WPSXcBG2H38?=
 =?us-ascii?Q?1y7ZPxuoYuQNUMkokM+4xTQZpjgn3olM/avWpxz22DfA7cq3xOyHYR58df27?=
 =?us-ascii?Q?AT2YjXdRfP7BKXMxmvvDcRTuBxHfE66QNFgrZlv6x4oxDK3/A33kgL+Os4rA?=
 =?us-ascii?Q?QKmghKV0G7Zia7hTd28xlAeBIf+0nkfYGwYQLfotF9CDba3DAyChdDiYq+Wv?=
 =?us-ascii?Q?bqkgzHTl/WaKTI+qhCC+qFJSRXfAzO7L9SXhG2T86wfKz0ly3MuYeQS5JFLL?=
 =?us-ascii?Q?AyAEqNKk0L6t2oO+soF3IA2slnA1wQdp0/Zulq/8X++GkqS6ZfiRkkFcGKYH?=
 =?us-ascii?Q?PR1o6fb6AT1Zwda5Xf7E9hW+3e/j+oKHelmZpDzByKyZjBVGg1QK1DGBdWbI?=
 =?us-ascii?Q?YrdewIU/pXTy7mxDdR4EVIzd/KyTIyjOvryxjZN9fYEwh1tzCpYkr7bdACYi?=
 =?us-ascii?Q?zHTA0ajZ9c4Wp/mg30XP0fMthlpQEKaVdiqpLGDZ6DJHU1FyYC36BkHqiYiZ?=
 =?us-ascii?Q?4YRydUIdtK2UXSVXs6bl1bMHeqmPtNaXvAzdG5nsYKkymUT7nJ+9ejA8uuPU?=
 =?us-ascii?Q?eyoa7JUEsYILmesbTOp/le6Yk5zVr7qiotXWAj20aj9YB8oPVYSxHM4Hal4R?=
 =?us-ascii?Q?xIP9DaL9Fa+r9hknaf8VF0Bx08HfHwtqr4D8mtw24+VJtOfA4HTtmvZSX/EA?=
 =?us-ascii?Q?qsQl/8uJBGQ8EmJ8g9Zw2OUbiswBRGVbMlvOU+eSXj108t8uo2ZRr8gxlvM3?=
 =?us-ascii?Q?AlIyfWiUlihP4RnK4P04vgFz1Bj5synNLRIHP5GtKn3nAdP+SAUDHJbsZpE5?=
 =?us-ascii?Q?jQk+EKD7EI8PCq4em6O8OAt8bkjPfi9WTIpebo4Kr8ODxEi8wLwGal6L2Xb+?=
 =?us-ascii?Q?yd3CMaIGCE8X1QcxXOjXPVJWZAfYqPS4rrnFxjKghYbacVsGDVE0xq7bbk6c?=
 =?us-ascii?Q?KKnpukWPG3BN9TtFODupkMwVTtykhdg5NDh8eRm5sggJb6fntRg5ezdJxseQ?=
 =?us-ascii?Q?w+mtQ/KpG8HiEY83HW0GWEoX70kInyvlYQNUWQI4cxt6HcOHCZBBi1hDbVnz?=
 =?us-ascii?Q?nJEbw/MNwtL6ZgOorXaB7UuZRrSloPr0po25wGdD8Tlstc14u8Pe+asBFUh7?=
 =?us-ascii?Q?xaBwQ=3D=3D?=
x-microsoft-antispam-prvs: <MN2PR08MB57588B21CB85F30507BC2D7BB8710@MN2PR08MB5758.namprd08.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(39860400002)(376002)(189003)(199004)(13464003)(71190400001)(81156014)(52536013)(256004)(14444005)(55016002)(9686003)(486006)(11346002)(446003)(7416002)(2906002)(74316002)(7736002)(476003)(229853002)(5660300002)(53936002)(6916009)(8936002)(81166006)(71200400001)(8676002)(6436002)(30864003)(97736004)(305945005)(478600001)(105586002)(33656002)(76176011)(6506007)(26005)(99286004)(68736007)(14454004)(316002)(3846002)(6116002)(86362001)(102836004)(106356001)(53546011)(55236004)(54906003)(186003)(66066001)(25786009)(7696005)(107886003)(6246003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5758;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p/FZbvwvtsqaulGkBdOs7W9am0EOs/sKvoJQXVV4A1/j4Rapgm4j+cp+7D9LhBX+wk/C7HyIiz0mg0r+WObaPIYOM7cBZtHqWFcqVVe28kdFkmJMP81SbDN92CorGrvMuM7N98PM2XhaEihvjJ/otJMqa+arwS07eIWykwoCjRL9s2dGmqML6MD4UlGhap8yxA9u3EWJDlsdSt1eQIbDXmsRA2/AsN8AerEHyJGZCarNpFT/BwswpxtxNcdGQfrd6pi2IXLmV0QQcgbrtJslo2Md4uvU+WzV5OQI+c2AeyfVIMLjkwQUBEoHezqsQXrZIbd3gBabeXKbKbi8z3eF0mixpb4SDiLBJ0ybJJb9AkUVj800pbZYkoHLEqswaEMpDw0qZSeKIO3OEc+PycWjLbmFdSjc/hADfDmLaGlY/LA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e6beb2aa-a9a6-4693-11d2-08d6a0a56908
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 13:29:21.0667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5758
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24468.005
X-TM-AS-Result: No--24.451200-0.000000-31
X-TM-AS-MatchedID: 150567-139010-139006-703523-704746-700648-851106-187165-7
        00022-700075-110462-708060-703712-121536-701702-706561-700038-708733-702198
        -701604-105640-706823-702865-702358-106230-704049-700287-701475-700016-7035
        29-188019-706290-847298-700324-702143-701384-700057-105630-702033-708712-70
        4473-700398-700264-851458-188199-700059-700492-706771-703399-703283-780052-
        700200-709403-701698-704156-700042-708797-700300-702898-702609-709584-70569
        4-704713-700251-704425-121336-702796-704407-121169-702037-711109-121119-113
        238-702091-707663-708558-148004-148007-148020-148050-20043-29997-42000-4200
        3-63-190014
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.82.98
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon <bbrezillon@kernel.org>
> Sent: Monday, February 4, 2019 7:02 PM
> To: Shivamurthy Shastri (sshivamurthy) <sshivamurthy@micron.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>; linux-
> mtd@lists.infradead.org; linux-kernel@vger.kernel.org; Chuanhong Guo
> <gch981213@gmail.com>; Richard Weinberger <richard@nod.at>; Schrempf
> Frieder <frieder.schrempf@kontron.De>; Marek Vasut
> <marek.vasut@gmail.com>; Frieder Schrempf
> <frieder.schrempf@exceet.de>; Brian Norris
> <computersforpeace@gmail.com>; David Woodhouse
> <dwmw2@infradead.org>; Bean Huo (beanhuo) <beanhuo@micron.com>
> Subject: [EXT] Re: [PATCH 2/2] mtd: spinand: micron: Support for all Micr=
on
> SPI NAND flashes
>=20
> Hi Shivamurthy,
>=20
> On Mon, 4 Feb 2019 11:17:51 +0000
> "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote:
>=20
> > Driver is redesigned using parameter page to support all the Micron
> > SPI NAND flashes.
>=20
> Do all Micron SPI NANDs really expose a valid ONFI param page? If
> that's not the case, then relying on ONFi parsing only sounds like a
> bad idea.

Micron SPI NAND datasheet does not confirm to be as ONFI standard.
However, they all expose parameter page, which I used for development.

>=20
> >
> > Parameter page of Micron flashes is similar to ONFI parameter table and
> > functionality is same, so copied some of the common functions like crc1=
6
> > and bit_wise_majority from nand_onfi.c.
>=20
> Most of the code is generic and does not depend on the spinand layer,
> plus, we already have ONFI param page parsing code in
> drivers/mtd/nand/raw/ which you're intentionally duplicating in a
> version that will not be re-usable by the raw NAND layer even after
> converting it to use the generic NAND layer.
>=20
> Please move ONFi parsing code to drivers/mtd/nand/onfi.c and make it
> generic.

As I said before, it is not compliant to ONFI standard, I think it is bette=
r not=20
to make it generic.

>=20
> >
> > This driver is tested using MT29F2G01ABXGD, MT29F4G01ABXFD,
> MT29F8G01ADXFD,
> > MT29F1G01ABXFD.
> >
> > Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> > Reviewed-by: Bean Huo <beanhuo@micron.com>
>=20
> I wish this code review had happened publicly.
>=20
> > ---
> >  drivers/mtd/nand/spi/micron.c | 172 +++++++++++++++++++++++++++--
> -----
> >  drivers/mtd/nand/spi/micron.h |  83 ++++++++++++++++
> >  2 files changed, 221 insertions(+), 34 deletions(-)
> >  create mode 100644 drivers/mtd/nand/spi/micron.h
> >
> > diff --git a/drivers/mtd/nand/spi/micron.c
> b/drivers/mtd/nand/spi/micron.c
> > index 9c4381d6847b..c9c53fd0aa01 100644
> > --- a/drivers/mtd/nand/spi/micron.c
> > +++ b/drivers/mtd/nand/spi/micron.c
> > @@ -10,13 +10,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/mtd/spinand.h>
> >
> > -#define SPINAND_MFR_MICRON		0x2c
> > -
> > -#define MICRON_STATUS_ECC_MASK		GENMASK(7, 4)
> > -#define MICRON_STATUS_ECC_NO_BITFLIPS	(0 << 4)
> > -#define MICRON_STATUS_ECC_1TO3_BITFLIPS	(1 << 4)
> > -#define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
> > -#define MICRON_STATUS_ECC_7TO8_BITFLIPS	(5 << 4)
> > +#include "micron.h"
> >
> >  static SPINAND_OP_VARIANTS(read_cache_variants,
> >  		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2,
> NULL, 0),
> > @@ -34,38 +28,38 @@ static
> SPINAND_OP_VARIANTS(update_cache_variants,
> >  		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> >  		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> >
> > -static int mt29f2g01abagd_ooblayout_ecc(struct mtd_info *mtd, int
> section,
> > -					struct mtd_oob_region *region)
> > +static int ooblayout_ecc(struct mtd_info *mtd, int section,
> > +			 struct mtd_oob_region *region)
> >  {
> >  	if (section)
> >  		return -ERANGE;
> >
> > -	region->offset =3D 64;
> > -	region->length =3D 64;
> > +	region->offset =3D mtd->oobsize / 2;
> > +	region->length =3D mtd->oobsize / 2;
> >
> >  	return 0;
> >  }
> >
> > -static int mt29f2g01abagd_ooblayout_free(struct mtd_info *mtd, int
> section,
> > -					 struct mtd_oob_region *region)
> > +static int ooblayout_free(struct mtd_info *mtd, int section,
> > +			  struct mtd_oob_region *region)
> >  {
> >  	if (section)
> >  		return -ERANGE;
> >
> >  	/* Reserve 2 bytes for the BBM. */
> >  	region->offset =3D 2;
> > -	region->length =3D 62;
> > +	region->length =3D (mtd->oobsize / 2) - 2;
> >
> >  	return 0;
> >  }
> >
> > -static const struct mtd_ooblayout_ops mt29f2g01abagd_ooblayout =3D {
> > -	.ecc =3D mt29f2g01abagd_ooblayout_ecc,
> > -	.free =3D mt29f2g01abagd_ooblayout_free,
> > +static const struct mtd_ooblayout_ops ooblayout =3D {
> > +	.ecc =3D ooblayout_ecc,
> > +	.free =3D ooblayout_free,
> >  };
> >
> > -static int mt29f2g01abagd_ecc_get_status(struct spinand_device
> *spinand,
> > -					 u8 status)
> > +static int ecc_get_status(struct spinand_device *spinand,
> > +			  u8 status)
> >  {
> >  	switch (status & MICRON_STATUS_ECC_MASK) {
> >  	case STATUS_ECC_NO_BITFLIPS:
> > @@ -90,22 +84,53 @@ static int mt29f2g01abagd_ecc_get_status(struct
> spinand_device *spinand,
> >  	return -EINVAL;
> >  }
> >
> > -static const struct spinand_info micron_spinand_table[] =3D {
> > -	SPINAND_INFO("MT29F2G01ABAGD", 0x24,
> > -		     NAND_MEMORG(1, 2048, 128, 64, 2048, 2, 1, 1),
> > -		     NAND_ECCREQ(8, 512),
> > -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> > -					      &write_cache_variants,
> > -					      &update_cache_variants),
> > -		     0,
> > -		     SPINAND_ECCINFO(&mt29f2g01abagd_ooblayout,
> > -				     mt29f2g01abagd_ecc_get_status)),
> > -};
> > +static u16 spinand_crc16(u16 crc, u8 const *p, size_t len)
> > +{
> > +	int i;
> > +
> > +	while (len--) {
> > +		crc ^=3D *p++ << 8;
> > +		for (i =3D 0; i < 8; i++)
> > +			crc =3D (crc << 1) ^ ((crc & 0x8000) ? 0x8005 : 0);
> > +	}
> > +
> > +	return crc;
> > +}
> > +
> > +static void bit_wise_majority(const void **srcbufs,
> > +			      unsigned int nsrcbufs,
> > +				   void *dstbuf,
> > +				   unsigned int bufsize)
> > +{
> > +	int i, j, k;
> > +
> > +	for (i =3D 0; i < bufsize; i++) {
> > +		u8 val =3D 0;
> > +
> > +		for (j =3D 0; j < 8; j++) {
> > +			unsigned int cnt =3D 0;
> > +
> > +			for (k =3D 0; k < nsrcbufs; k++) {
> > +				const u8 *srcbuf =3D srcbufs[k];
> > +
> > +				if (srcbuf[i] & BIT(j))
> > +					cnt++;
> > +			}
> > +
> > +			if (cnt > nsrcbufs / 2)
> > +				val |=3D BIT(j);
> > +		}
> > +
> > +		((u8 *)dstbuf)[i] =3D val;
> > +	}
> > +}
> >
> >  static int micron_spinand_detect(struct spinand_device *spinand)
> >  {
> > +	struct spinand_info deviceinfo;
> > +	struct micron_spinand_params *params;
> >  	u8 *id =3D spinand->id.data;
> > -	int ret;
> > +	int ret, i;
> >
> >  	/*
> >  	 * Micron SPI NAND read ID need a dummy byte,
> > @@ -114,16 +139,95 @@ static int micron_spinand_detect(struct
> spinand_device *spinand)
> >  	if (id[1] !=3D SPINAND_MFR_MICRON)
> >  		return 0;
> >
> > -	ret =3D spinand_match_and_init(spinand, micron_spinand_table,
> > -				     ARRAY_SIZE(micron_spinand_table),
> id[2]);
> > +	params =3D kzalloc(sizeof(*params) * 3, GFP_KERNEL);
> > +	if (!params)
> > +		return -ENOMEM;
> > +
> > +	ret =3D spinand_parameter_page_read(spinand, PARAMETER_PAGE,
> params,
> > +					  sizeof(*params) * 3);
> >  	if (ret)
> > -		return ret;
> > +		goto free_params;
> > +
> > +	for (i =3D 0; i < 3; i++) {
> > +		if (spinand_crc16(0x4F4E, (u8 *)&params[i], 254) =3D=3D
> > +				le16_to_cpu(params->crc)) {
> > +			if (i)
> > +				memcpy(params, &params[i],
> sizeof(*params));
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (i =3D=3D 3) {
> > +		const void *srcbufs[3] =3D {params, params + 1, params + 2};
> > +
> > +		pr_warn("No valid parameter page, trying bit-wise majority
> to recover it\n");
> > +		bit_wise_majority(srcbufs, ARRAY_SIZE(srcbufs), params,
> > +				  sizeof(*params));
> > +
> > +		if (spinand_crc16(0x4F4E, (u8 *)params, 254) !=3D
> > +				le16_to_cpu(params->crc)) {
> > +			pr_err("Parameter page recovery failed,
> aborting\n");
> > +			goto free_params;
> > +		}
> > +	}
> > +
> > +	params->model[sizeof(params->model) - 1] =3D 0;
> > +	strim(params->model);
> > +
> > +	deviceinfo.model =3D kstrdup(params->model, GFP_KERNEL);
> > +	if (!deviceinfo.model) {
> > +		ret =3D -ENOMEM;
> > +		goto free_params;
> > +	}
> > +
> > +	deviceinfo.devid =3D id[2];
> > +	deviceinfo.flags =3D 0;
> > +	deviceinfo.memorg.bits_per_cell =3D params->bits_per_cell;
> > +	deviceinfo.memorg.pagesize =3D params->byte_per_page;
> > +	deviceinfo.memorg.oobsize =3D params->spare_bytes_per_page;
> > +	deviceinfo.memorg.pages_per_eraseblock =3D params-
> >pages_per_block;
> > +	deviceinfo.memorg.eraseblocks_per_lun =3D
> > +		params->blocks_per_lun * params->lun_count;
> > +	deviceinfo.memorg.planes_per_lun =3D params->lun_count;
>=20
> As pointed by Emil, this is wrong, params->lun_count should be used to
> fill luns_per_target. ->planes_per_lun should be extracted from
> ->interleaved_bits.

It is my bad, I will correct it.
However, Micron SPI NAND's use vendor specific area ->vendor_specific[0] .

>=20
> > +	deviceinfo.memorg.luns_per_target =3D 1;
> > +	deviceinfo.memorg.ntargets =3D 1;
> > +	deviceinfo.eccreq.strength =3D params->ecc_max_correct_ability;
> > +	deviceinfo.eccreq.step_size =3D 512;
> > +	deviceinfo.eccinfo.get_status =3D ecc_get_status;
> > +	deviceinfo.eccinfo.ooblayout =3D &ooblayout;
>=20
> Are all devices really using the same get_status method and the same
> layout. Sounds risky to me to assume this is the case.
>=20
> > +	deviceinfo.op_variants.read_cache =3D &read_cache_variants;
> > +	deviceinfo.op_variants.write_cache =3D &write_cache_variants;
> > +	deviceinfo.op_variants.update_cache =3D &update_cache_variants;
> > +
> > +	ret =3D spinand_match_and_init(spinand, &deviceinfo,
> > +				     1, id[2]);
>=20
> Please don't abuse the spinand_match_and_init() function. Fill the
> nand_device object directly instead of creating a temporary spinand_info
> instance with the expected id.
>=20
> > +	if (ret)
> > +		goto free_model;
> > +
> > +	kfree(params);
> >
> >  	return 1;
> > +
> > +free_model:
> > +	kfree(deviceinfo.model);
> > +free_params:
> > +	kfree(params);
> > +
> > +	return ret;
> > +}
> > +
> > +static int micron_spinand_init(struct spinand_device *spinand)
> > +{
> > +	/*
> > +	 * Some of the Micron flashes enable this BIT by default,
> > +	 * and there is a chance of read failure due to this.
> > +	 */
> > +	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE, 0);
> >  }
> >
> >  static const struct spinand_manufacturer_ops
> micron_spinand_manuf_ops =3D {
> >  	.detect =3D micron_spinand_detect,
> > +	.init =3D micron_spinand_init,
> >  };
> >
> >  const struct spinand_manufacturer micron_spinand_manufacturer =3D {
> > diff --git a/drivers/mtd/nand/spi/micron.h
> b/drivers/mtd/nand/spi/micron.h
> > new file mode 100644
> > index 000000000000..c2cf3bee6f7e
> > --- /dev/null
> > +++ b/drivers/mtd/nand/spi/micron.h
> > @@ -0,0 +1,83 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2019 Micron Technology, Inc.
> > + *
> > + * Authors:
> > + *	Shivamurthy Shastri <sshivamurthy@micron.com>
> > + */
> > +
> > +#ifndef __MICRON_H
> > +#define __MICRON_H
> > +
> > +#define SPINAND_MFR_MICRON		0x2c
> > +
> > +#define MICRON_STATUS_ECC_MASK		GENMASK(7, 4)
> > +#define MICRON_STATUS_ECC_NO_BITFLIPS	(0 << 4)
> > +#define MICRON_STATUS_ECC_1TO3_BITFLIPS	BIT(4)
> > +#define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
> > +#define MICRON_STATUS_ECC_7TO8_BITFLIPS	(5 << 4)
> > +
> > +#define UNIQUE_ID_PAGE	0x00
> > +#define PARAMETER_PAGE	0x01
> > +
> > +/*
> > + * Micron SPI NAND has parameter table similar to ONFI
> > + */
> > +struct micron_spinand_params {
> > +	/* rev info and features block */
> > +	u8 sig[4];
> > +	__le16 revision;
> > +	__le16 features;
> > +	__le16 opt_cmd;
> > +	u8 reserved0[22];
> > +
> > +	/* manufacturer information block */
> > +	char manufacturer[12];
> > +	char model[20];
> > +	u8 manufact_id;
> > +	__le16 date_code;
> > +	u8 reserved1[13];
> > +
> > +	/* memory organization block */
> > +	__le32 byte_per_page;
> > +	__le16 spare_bytes_per_page;
> > +	__le32 data_bytes_per_ppage;
> > +	__le16 spare_bytes_per_ppage;
> > +	__le32 pages_per_block;
> > +	__le32 blocks_per_lun;
> > +	u8 lun_count;
> > +	u8 addr_cycles;
> > +	u8 bits_per_cell;
> > +	__le16 bb_per_lun;
> > +	__le16 block_endurance;
> > +	u8 guaranteed_good_blocks;
> > +	__le16 guaranteed_block_endurance;
> > +	u8 programs_per_page;
> > +	u8 ppage_attr;
> > +	u8 ecc_bits;
> > +	u8 interleaved_bits;
> > +	u8 interleaved_ops;
> > +	u8 reserved2[13];
> > +
> > +	/* electrical parameter block */
> > +	u8 io_pin_capacitance_max;
> > +	__le16 async_timing_mode;
> > +	__le16 program_cache_timing_mode;
> > +	__le16 t_prog;
> > +	__le16 t_bers;
> > +	__le16 t_r;
> > +	__le16 t_ccs;
> > +	u8 reserved3[23];
> > +
> > +	/* vendor */
> > +	__le16 vendor_revision;
> > +	u8 vendor_specific[14];
> > +	u8 reserved4[68];
> > +	u8 ecc_max_correct_ability;
> > +	u8 die_select_feature;
> > +	u8 reserved5[4];
> > +
> > +	__le16 crc;
> > +} __packed;
> > +
>=20
> Please use the nand_onfi_params definition (include/linux/mtd/onfi.h).
>=20
> > +#endif /* __MICRON_H */
>=20
>=20
> Regards,
>=20
> Boris
