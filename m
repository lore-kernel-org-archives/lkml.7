Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3CFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 05:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D620D2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 05:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Cys+zMai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfCRFeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 01:34:44 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:57066 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfCRFen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 01:34:43 -0400
X-IronPort-AV: E=Sophos;i="5.58,492,1544511600"; 
   d="scan'208";a="28007183"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Mar 2019 22:34:42 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Sun, 17 Mar 2019 22:34:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVN5NhOE0bTofil7UlCJL9UEqxWTNmxjWc2NvUcFKwQ=;
 b=Cys+zMaiEjPuhqXSRMKDpy3HJM9HnOo4VA8s1V2PH1nlvhFi4ZL8lxRJ7kiBzwFqrwEpBvu/xs4dLTrsHAXZAfctPMKfVo17Dlb9diqWQvzpVJd2CV4nL+Q3C4rm4KuhCKwv9TP7iezzRIklSGpsDiyj8MIS2v4ny+bGx0WEqJo=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1298.namprd11.prod.outlook.com (10.173.32.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 05:34:38 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::85a9:6cf6:d651:128e]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::85a9:6cf6:d651:128e%10]) with mapi id 15.20.1709.015; Mon, 18 Mar
 2019 05:34:38 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <nagasure@xilinx.com>, <bbrezillon@kernel.org>,
        <broonie@kernel.org>
CC:     <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>, <nagasuresh12@gmail.com>,
        <dwmw2@infradead.org>, <michals@xilinx.com>,
        <liu.xiang6@zte.com.cn>
Subject: Re: 4-Byte addressing issue with IS25WP256D nor flash
Thread-Topic: 4-Byte addressing issue with IS25WP256D nor flash
Thread-Index: AdTZgzps1dokp2Q3SSmhxyFZkToq1ADyQRIA
Date:   Mon, 18 Mar 2019 05:34:38 +0000
Message-ID: <e1e2f867-8a28-c74b-7f01-5f798e37c81d@microchip.com>
References: <MWHPR02MB2623388725B13BB7B133B98BAF4A0@MWHPR02MB2623.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR02MB2623388725B13BB7B133B98BAF4A0@MWHPR02MB2623.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0260.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::33) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38b37266-66c4-4e6a-8309-08d6ab636959
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1298;
x-ms-traffictypediagnostic: BN6PR11MB1298:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR11MB1298C6A1DE473882E5E51AA8F0470@BN6PR11MB1298.namprd11.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(366004)(376002)(189003)(199004)(6346003)(6512007)(53936002)(99286004)(6306002)(386003)(305945005)(7416002)(52116002)(71190400001)(8936002)(81166006)(53546011)(8676002)(6506007)(105586002)(81156014)(7736002)(6436002)(4326008)(229853002)(478600001)(26005)(6246003)(186003)(36756003)(31696002)(66066001)(6486002)(86362001)(2616005)(3846002)(446003)(11346002)(14454004)(486006)(6116002)(476003)(5660300002)(72206003)(14444005)(2906002)(256004)(25786009)(102836004)(106356001)(54906003)(316002)(2501003)(68736007)(71200400001)(110136005)(31686004)(966005)(97736004)(76176011)(505234006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1298;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a7GvPV7LyXcPSpx+VtUC5B9yw/BXYF0PmnfnytjJb/BNTdBPUVFCuMpRuvlqOYIaxH27eu/14LDRhRGr1c/RHOVzcTMZVMnNfhQ0OVbvKw/FPBMhHotRclKqHvIrYAW9VAJS2ib8WceFSv9ZI4doOODtxcETVmp1qCZvE47dWX7pIlEz8R5vuS9hPOqghjUwu1y2ymreDIsCllthCNA8UKjLdbzsHviR8gsCpBJTCudOKs+JQL8RB3IH9rYaylvbej0Qt6LtKIFz5HPokDrt3UECJ/73r4PMh0blwxOPbmDI/8zWZXqgBdBrcKoYb5GeTt20AAdNocPEYrAZWSxLd/Qd/eTYgBMBh22l9ILZdP/feKpUmkzi4WQENz4F1kO5s0bRVU1CxKKyshE/LAUliRHgbAh6Vcw/WAQDfb3KILE=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <1E5CEF06750F3A46B3B3EBB9B732392A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b37266-66c4-4e6a-8309-08d6ab636959
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 05:34:38.1193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1298
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Naga,

On 03/13/2019 12:30 PM, Naga Sureshkumar Relli wrote:
> Hi,
>=20
> =A0
>=20
> Currently I am facing an issue with is25wp256d part.
>=20
>  1. With u-boot the data integrity is working(erase, write, read and veri=
fy)
>     with out any issues
>  2. Don=92t probe the qspi at u-boot, and boot Linux and do data integrit=
y
>     (erase, write, read and verify) =A0and verification done successfully=
.
>  3. At u-boot, do sf probe and after booting Linux, check for data integr=
ity
>=20
> =A0=A0=A0=A0=A0 (erase, write, read and verify) and verify is failing.
>=20
> And here are my observations.
>=20
> When we do sf probe at u-boot, as per the device size, u-boot is changing
>=20
> The flash device addressing mode from 3 byte to 4 byte
>=20
> =A0
>=20
> But Linux spi-nor frame work is using 3 byte commands with 3 Byte address=
ing(because
>=20
> Of wrong sfdp information from the is25wp256d part). Hence data verificat=
ion is failing.
>=20
> i.e. sfdp information is saying that it supports only 3-Byte addressing.
>=20
> that means, sfdp table for is25wp256d is wrong.
>=20

I couldn't find the sfdp table described in the datasheet. I would like to =
check
if bfpt is not entirely wrong. Can you please hexdump the entire sfdp table=
?

> =A0
>=20
> Here are the steps that I am running.
>=20
> Write data using u-boot =A0like below
>=20
> 1. sf probe 0 0 0
>=20
> 2. mw.b 0x100000 11 0x100
>=20
> 3. sf write 0x100000 0x0 0x100
>=20
> 4. sf read 0x200000 0x0 0x100
>=20
> 5. md.b 0x200000 0x100
>=20
> 00200000: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 00200010: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 00200020: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 00200030: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 00200040: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 00200050: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 00200060: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 00200070: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 00200080: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 00200090: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 002000a0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 002000b0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 002000c0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 002000d0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 002000e0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> 002000f0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ......=
..........
>=20
> And in Linux just try reading the data,
>=20
> root# mtd_debug read /dev/mtd0 0x0 0x100 test.bin
>=20
> root#hexdump -C -n 50 test.bin
>=20
> 0000000 ffff ffff =A01111 1111 1111 1111 1111 1111
>=20
> 0000010 1111 1111 1111 1111 1111 1111 1111
>=20
> *
>=20
> 0000100
>=20
> =A0
>=20
> I did the below change in spi-nor.c
>=20
> iff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>=20
> index 4216ce0..f8603ff 100644
>=20
> --- a/drivers/mtd/spi-nor/spi-nor.c
>=20
> +++ b/drivers/mtd/spi-nor/spi-nor.c
>=20
> @@ -2890,6 +2890,11 @@ static int spi_nor_init_params(struct spi_nor *nor=
,
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nor=
->addr_width =3D 0;
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nor=
->mtd.erasesize =3D 0;
>=20
> =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((=
JEDEC_MFR(info) =3D=3D SNOR_MFR_ISSI) &&
Does all issi flashes have this problem?

>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 params->size >=A0 OFFSET_16_MB) {
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 nor->addr_width =3D 4;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 set_4byte(nor, info, 1);
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mem=
cpy(params, &sfdp_params, sizeof(*params));
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
> =A0=A0=A0=A0=A0=A0=A0 }
>=20
> Any further suggestions?

We should implement this as a post_bfpt fixup hook.

>=20
> I have gone through https://lkml.org/lkml/2018/11/14/599.
>=20
> But I didn=92t see any further mails after that.

Sorry, I forgot about it :(

Cheers,
ta
