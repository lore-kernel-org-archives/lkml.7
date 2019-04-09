Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76C0C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C3C2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="kFQ6SzDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfDIHgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:36:13 -0400
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:61702
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726383AbfDIHgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgNpA0yoesexA3mEetDw7sFtk418QMmYzYLgwB+NQPc=;
 b=kFQ6SzDUayGSuLO6FBLYau8xtcpUc4KAkR5mYFem9AU6H1nNvziOEM2E9AorQlf6w2FsijPBG60dhLG4hnIMwjUlCtCTUH3krIv89/UyHBy45S9Dy4bfoL7DMvKtfXeBP3ONERLqcRuSSK+f6TpIc14ZWFhe6r9Aj+QP9tqyjw8=
Received: from AM6PR05MB5224.eurprd05.prod.outlook.com (20.177.196.210) by
 AM6PR05MB5365.eurprd05.prod.outlook.com (20.177.197.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Tue, 9 Apr 2019 07:36:07 +0000
Received: from AM6PR05MB5224.eurprd05.prod.outlook.com
 ([fe80::a51e:351a:a52c:4d13]) by AM6PR05MB5224.eurprd05.prod.outlook.com
 ([fe80::a51e:351a:a52c:4d13%4]) with mapi id 15.20.1792.009; Tue, 9 Apr 2019
 07:36:07 +0000
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "jacek.anaszewski@gmail.com" <jacek.anaszewski@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        Ido Schimmel <idosch@mellanox.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: RE: [PATCH v1 bitops] bitops: Fix UBSAN undefined behavior warning
 for rotation right
Thread-Topic: [PATCH v1 bitops] bitops: Fix UBSAN undefined behavior warning
 for rotation right
Thread-Index: AQHU7UDq7atprWWBT0GZRfG/lIke+qYy4OyAgACQglA=
Date:   Tue, 9 Apr 2019 07:36:06 +0000
Message-ID: <AM6PR05MB52246C74B34F291F5D89A409A22D0@AM6PR05MB5224.eurprd05.prod.outlook.com>
References: <20190407125325.24440-1-vadimp@mellanox.com>
 <20190408155217.3f723554ae7fbcb34eeacb30@linux-foundation.org>
In-Reply-To: <20190408155217.3f723554ae7fbcb34eeacb30@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadimp@mellanox.com; 
x-originating-ip: [84.108.218.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24368098-ed6c-44ae-6311-08d6bcbe073a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR05MB5365;
x-ms-traffictypediagnostic: AM6PR05MB5365:
x-microsoft-antispam-prvs: <AM6PR05MB53650E687B08B2CAE4101962A22D0@AM6PR05MB5365.eurprd05.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(13464003)(199004)(189003)(486006)(71190400001)(71200400001)(7736002)(86362001)(26005)(6506007)(6436002)(53936002)(186003)(68736007)(102836004)(25786009)(446003)(4326008)(106356001)(105586002)(476003)(53546011)(305945005)(74316002)(8676002)(81166006)(81156014)(97736004)(76176011)(6916009)(2906002)(6246003)(3846002)(66066001)(8936002)(229853002)(52536014)(9686003)(99286004)(55016002)(6116002)(11346002)(478600001)(256004)(14444005)(5660300002)(7696005)(54906003)(316002)(14454004)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5365;H:AM6PR05MB5224.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PjxPfK0MzLBcX2Pyi+buGaw+80NTYEmmM6Whae8VPew+EToFDWH7pZ4p9TiQmy5YFrI1KCULFQJW06ytiwXN8YLntU/MJlXgjGdsoLmzz/q4HIh5oMcJbhxJeTTtUpfXFV2992fC1T6DJudTPUaGy+7uMdcgH0W3ZgDpyKSQgnUwhklFa81HHT/0G6SfhnvbJHu+4S9HQcZMbX+OdWB0SETcAJD/jSAEUxxiiSq4vsm2cUQcbYrPiK3C2ABdNbcAYcQh0jE4X0xTFzOqBcxFsI6z9x7oCW8E5CH6opQ5USfB3nloARZ/jdYser0iqbdNwit9MkkGbNcMxsZyjRkpcLvMAmP4iBvyG7Mott+3Ae2e7HbtQD3P6i4tVdEqnsG7iQ3FDMVhF1z+yp+Ctg5S2NhYj5Jf8uLhnH94sEkRAag=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24368098-ed6c-44ae-6311-08d6bcbe073a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 07:36:06.9097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5365
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andrew Morton <akpm@linux-foundation.org>
> Sent: Tuesday, April 09, 2019 1:52 AM
> To: Vadim Pasternak <vadimp@mellanox.com>
> Cc: jacek.anaszewski@gmail.com; pavel@ucw.cz; linux-kernel@vger.kernel.or=
g;
> linux-leds@vger.kernel.org; Ido Schimmel <idosch@mellanox.com>; Andrey
> Ryabinin <aryabinin@virtuozzo.com>
> Subject: Re: [PATCH v1 bitops] bitops: Fix UBSAN undefined behavior warni=
ng
> for rotation right
>=20
> (resend, cc Andrey)
>=20
> On Sun,  7 Apr 2019 12:53:25 +0000 Vadim Pasternak <vadimp@mellanox.com>
> wrote:
>=20
> > The warning is caused by call to rorXX(), if the second parameters of
> > this function "shift" is zero. In such case UBSAN reports the warning
> > for the next expression: (word << (XX - shift), where XX is 64, 32,
> > 16, 8 for respectively ror64, ror32, ror16, ror8.
> > Fix adds validation of this parameter - in case it's equal zero, no
> > need to rotate, just original "word" is to be returned to caller.
> >
> > The UBSAN undefined behavior warning has been reported for call to
> > ror32():
> > [   11.426543] UBSAN: Undefined behaviour in ./include/linux/bitops.h:9=
3:33
> > [   11.434045] shift exponent 32 is too large for 32-bit type 'unsigned=
 int'
>=20
> hm, do we care?

Hi Andrew,

Thank for reply.

We want to avoid UBSAN undefined behavior warning in case
"shift" parameter is not provided as a constant.

>=20
> > ...
> >
>=20
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -70,6 +70,9 @@ static inline __u64 rol64(__u64 word, unsigned int sh=
ift)
> >   */
> >  static inline __u64 ror64(__u64 word, unsigned int shift)  {
> > +	if (!shift)
> > +		return word;
> > +
> >  	return (word >> shift) | (word << (64 - shift));  }
>=20
> Is there any known architecture or compiler for which UL<<64 doesn't reli=
ably
> produce zero?  Is there any prospect that this will become a problem in t=
he
> future?

I don't know about such architecture.
Do you think it could be modified only for ro8, ror16, ror32?
