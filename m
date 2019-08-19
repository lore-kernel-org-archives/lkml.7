Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1E9C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025642082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="YORRg0aj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfHSIgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 04:36:04 -0400
Received: from mail-eopbgr680056.outbound.protection.outlook.com ([40.107.68.56]:34177
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfHSIgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 04:36:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2NXbWkA8CmWmDwOhhNDdlMGU6sek1U9mBFDDAQxmaxAiPbqGBK8RIiww3+nBkl6w9ItAPVHgMbDBdYqcVT8220L3h3m5FyZ13v9JrYeFNPqzyYi8t4qMgiqp4viPnoj3eMm819l96LhS8OoCBKB6slu+Jx0ITam2LxhNIzO4YT7TEe3LZAOZ3e5B7acEb0ddxLgttg0L11hMIHWRPV3DDM7K9dqTnPHnRscsxUEcGGpbD+/4vXIZmiEevNaLqI/uvG5xLEt3tVfixVYVHGR/IpTbXzPNTOxN0JfYtH21mgIOgX763wDEMeYOXJaFaSQggmugBe9ZeOKrSTIGZus+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9rWeXYD33ixs/oOklLHg+HBUgb81ZPQgsunOceaw1s=;
 b=NukDflCukhsZvn77pAH1F78VQaLB/1pqkEKrRT9+ZOkGsp8CTWXFr1pHE0sqShCOdJ+MDrGV9FowIOvsNUZSTPYuOJPmtnUnirryWoQ5z0cSHCCd0/1ioAKP7gTMmoZDZfXpXsS7ccPY1DLnNtP8F21IkgAv+2B6fH9qPRW7a9jmSY9X9pkbGCBZH96KSp3d/hkgFa6har0gGAFOE0+kRGtbK9/90/wuvbinjBjXY+SIGndSiAI6LAkO7Zqc1/MiTuba3QQni7CED6e0135q14zYL158ET3vbzrqHCeDCan2LY3K6ur7SZN/sAGzqFcwXXIeNSTnO80PW/GXIJ1SJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9rWeXYD33ixs/oOklLHg+HBUgb81ZPQgsunOceaw1s=;
 b=YORRg0ajKAFbF2rDmsu8h85cHlREjN1ePQAqWKSZiWnjZK+L4IVzCIobfduXylmBxAh8emI117F1HxO71/nnf7xY3VdxxfQm2to61sbPYzjyFFRZDatjeID/0DqIoIoiZdH/VWXlPyQX/mY1OwirjDOGxnFJut0nK3/EJBA7TKc=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB6302.namprd08.prod.outlook.com (52.132.170.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 08:35:22 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::7548:c632:9c57:9252]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::7548:c632:9c57:9252%6]) with mapi id 15.20.2178.016; Mon, 19 Aug 2019
 08:35:22 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     'Miquel Raynal' <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Kletsky <git-commits@allycomm.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: RE: [EXT] Re: [PATCH 1/8] mtd: nand: move ONFI related functions to
 onfi.h
Thread-Topic: [EXT] Re: [PATCH 1/8] mtd: nand: move ONFI related functions to
 onfi.h
Thread-Index: AQHVTPr4D70gMtZhD06R9PhtnooDXab3bfxA
Date:   Mon, 19 Aug 2019 08:35:22 +0000
Message-ID: <MN2PR08MB5951AA8A1DE9D9A2AA4B2023B8A80@MN2PR08MB5951.namprd08.prod.outlook.com>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
        <20190722055621.23526-2-sshivamurthy@micron.com>
 <20190807103437.36abb59b@xps13>
In-Reply-To: <20190807103437.36abb59b@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b11437b-5a55-43ae-6c07-08d724802cfc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR08MB6302;
x-ms-traffictypediagnostic: MN2PR08MB6302:|MN2PR08MB6302:|MN2PR08MB6302:
x-microsoft-antispam-prvs: <MN2PR08MB6302A0935F89E64C4789FAF0B8A80@MN2PR08MB6302.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(189003)(199004)(446003)(5660300002)(229853002)(6246003)(8676002)(99286004)(54906003)(7416002)(6916009)(66066001)(81166006)(486006)(55016002)(316002)(11346002)(86362001)(8936002)(7736002)(74316002)(14454004)(7696005)(476003)(53936002)(76176011)(478600001)(305945005)(81156014)(9686003)(102836004)(186003)(6436002)(52536014)(26005)(6506007)(55236004)(256004)(14444005)(76116006)(4326008)(66446008)(64756008)(66556008)(66476007)(66946007)(2906002)(33656002)(25786009)(3846002)(6116002)(71190400001)(71200400001)(66574012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB6302;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X2/0MYCmBgRnYeUzRSpQGwR2mRTJrqG2PDzZ60vP8xLigdOnjUL8TJ3iy6HBvxHEGm8gbuw+VGSYG6e1laBXk5Q9eXcMhiwEkmcAHloHYW6EGcluoqDu3ftxue8L/dRc9f/TLUP3qwmiFeqdUQW3xja8yrJ77jVMBv9YaWv08fqLk1+saDVafdm06ljIXeK8JRQ5nePjVQ0cPi0prDlaQxhI0+bYjGiqfeK5hxMQ8M45SzwmrizU57VFPxsaLZXJiYYq2+rCz6LdAr4ppKoVLuNQPPFnmdQgkdFlHdujgr2UYcHPO5LqicmtbcmILCBUO32LCsytjwxHqxjE9lAThBR/Xt0NHcdx24Ed5n1LH0IMXH5EIwcBtQcJinDC6McWOu3OEl30YdMcaIPZ+KcH69Nw1/s0LHrl8AJK5RZeeFE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b11437b-5a55-43ae-6c07-08d724802cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 08:35:22.3149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g84rvaOCmCmfiOzcqFChuNaBIBH9S647DneMBClJaOzCwfyP+qld+1RpLI5nLFRP9cljuPc22KbF84BbuC6YPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB6302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

Thanks for reviewing.

>=20
> Hi Shiva,
>=20
> shiva.linuxworks@gmail.com wrote on Mon, 22 Jul 2019 07:56:14 +0200:
>=20
> > From: Shivamurthy Shastri <sshivamurthy@micron.com>
> >
> > These functions will be used by both raw NAND and SPI NAND, which
> > supports ONFI like standards.
>=20
> This is not exactly what you do. Why not:
>=20
> mtd: nand: export ONFI related functions to onfi.h
>=20
> These functions can be used by all flavors of NAND chips (raw, SPI)
> which may all follow ONFI standards. Export the related functions in
> the onfi.h generic file.
>=20

Looks good. I will use this.

> >
> > Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> > ---
> >  drivers/mtd/nand/raw/internals.h | 1 -
> >  include/linux/mtd/onfi.h         | 9 +++++++++
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/nand/raw/internals.h
> b/drivers/mtd/nand/raw/internals.h
> > index cba6fe7dd8c4..ed323087d884 100644
> > --- a/drivers/mtd/nand/raw/internals.h
> > +++ b/drivers/mtd/nand/raw/internals.h
> > @@ -140,7 +140,6 @@ void nand_legacy_adjust_cmdfunc(struct
> nand_chip *chip);
> >  int nand_legacy_check_hooks(struct nand_chip *chip);
> >
> >  /* ONFI functions */
> > -u16 onfi_crc16(u16 crc, u8 const *p, size_t len);
> >  int nand_onfi_detect(struct nand_chip *chip);
> >
> >  /* JEDEC functions */
> > diff --git a/include/linux/mtd/onfi.h b/include/linux/mtd/onfi.h
> > index 339ac798568e..2c8a05a02bb0 100644
> > --- a/include/linux/mtd/onfi.h
> > +++ b/include/linux/mtd/onfi.h
> > @@ -10,6 +10,7 @@
> >  #ifndef __LINUX_MTD_ONFI_H
> >  #define __LINUX_MTD_ONFI_H
> >
> > +#include <linux/mtd/nand.h>
>=20
> This should be removed, or at least not added at this moment.
>=20

okay.

> >  #include <linux/types.h>
> >
> >  /* ONFI version bits */
> > @@ -175,4 +176,12 @@ struct onfi_params {
> >  	u8 vendor[88];
> >  };
> >
> > +/* ONFI functions */
> > +u16 onfi_crc16(u16 crc, u8 const *p, size_t len);
> > +void nand_bit_wise_majority(const void **srcbufs,
> > +			    unsigned int nsrcbufs,
> > +			    void *dstbuf,
> > +			    unsigned int bufsize);
>=20
> Don't export this function while you don't use it from elsewhere.
>=20

The function will be moved to nand/onfi.c in next patch and will be
used by both raw and SPI NAND.

> > +void sanitize_string(u8 *s, size_t len);
>=20
> This one is used by jedec code and has no onfi-related logic, so you
> may want to export it (only when you will use it) in another header
> like linux/mtd/nand.h

okay, I will keep this as it is.

>=20
> > +
> >  #endif /* __LINUX_MTD_ONFI_H */
>=20
> Thanks,
> Miqu=E8l

Thanks,
Shiva
