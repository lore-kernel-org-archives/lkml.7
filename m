Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFFEC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4C221479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="gObMzWAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfETUn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 16:43:59 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:32771
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfETUn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVISbyJa8q4V5HY/USxf6/ID0GC3+O3D8svDPVllIeM=;
 b=gObMzWAn3z8lJDx7EptRWwse9nmv3+lwNimfupbf2Tl/p9KrSXbgeUUyxB2TKlkmvOyF3C5kk6GJsP6YcusqFIn9iuFpvu7o0Os9VoNDEIM4gban/PvsaRJBxVPb3DuneSh8bdfR8hQHXj9VnwDyN7cyk0cRiOThd5370JkEsiI=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB4757.eurprd05.prod.outlook.com (10.168.20.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Mon, 20 May 2019 20:43:53 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::244a:2b0:6510:9864]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::244a:2b0:6510:9864%7]) with mapi id 15.20.1900.010; Mon, 20 May 2019
 20:43:53 +0000
From:   Liming Sun <lsun@mellanox.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/2] platform/mellanox: Add bootctl driver for Mellanox
 BlueField Soc
Thread-Topic: [PATCH v5 1/2] platform/mellanox: Add bootctl driver for
 Mellanox BlueField Soc
Thread-Index: AQHVDNjerktpZH/kD0q2FkOL+YtZAKZ0L50AgAAd9ECAABiUgIAAFpbg
Date:   Mon, 20 May 2019 20:43:53 +0000
Message-ID: <DB6PR05MB3223F25A2E2B78053FE96D5BA1060@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <0b74e9ad12360b56bc0a3c2ca972798c424f2610.1548790896.git.lsun@mellanox.com>
 <1558115345-32476-1-git-send-email-lsun@mellanox.com>
 <20190520155658.GA14165@kroah.com>
 <DB6PR05MB32232CA5DD05D1A923A28215A1060@DB6PR05MB3223.eurprd05.prod.outlook.com>
 <20190520191209.GA29776@kroah.com>
In-Reply-To: <20190520191209.GA29776@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3acfd52-0d1b-4a27-8911-08d6dd63df59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB6PR05MB4757;
x-ms-traffictypediagnostic: DB6PR05MB4757:
x-microsoft-antispam-prvs: <DB6PR05MB47578575899C9BF7CC753DCAA1060@DB6PR05MB4757.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(13464003)(189003)(199004)(52314003)(68736007)(71200400001)(71190400001)(33656002)(66066001)(256004)(476003)(86362001)(478600001)(186003)(81156014)(11346002)(6436002)(8936002)(6246003)(486006)(446003)(8676002)(229853002)(55016002)(26005)(4326008)(9686003)(316002)(81166006)(53936002)(2906002)(66446008)(66556008)(66476007)(305945005)(64756008)(76116006)(76176011)(7696005)(54906003)(7736002)(73956011)(66946007)(52536014)(99286004)(3846002)(6116002)(25786009)(6506007)(6916009)(53546011)(14454004)(5660300002)(74316002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB4757;H:DB6PR05MB3223.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7/oJVJQx+PndFSkYUr/TwztNL8W83LKDcB//cpJTqQG1MvMoXI4pPcGBNRp3K+RQkbVaRiWdk1Nh5TKFDwZE8QtjHiOeBeuQdxsJfPRnXr6s0+6bQBruxx6R9nK4yYX/sRttgQ1s66SBbHajsREhEDj/hIJ4rxEuRzbni/o6WJIndLXYnOOmDZ7X6kqLfV49kBkbQXD6gr10OIHqUtSitGe3yA3tRHZSmscYtV6bp5Vr9j2f5AxxOkOVVjiiw6FZ6DZ43GpCBGdvma964cUzltyFM1Kc09Kj8rvm+d1MB46hVWYye8nc6nnFbBnmo1i9VifG5YDHnlykrJQ0hJ0bL8eIW+LuGxerloq6ZyLopj5TbhcHTSsotxnZj6Xt37y0hO6l2bst8C1Pw1pAc28TDjQm7ablmnDOwIqzHh8czCE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3acfd52-0d1b-4a27-8911-08d6dd63df59
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 20:43:53.7022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB4757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Monday, May 20, 2019 3:12 PM
> To: Liming Sun <lsun@mellanox.com>
> Cc: Andy Shevchenko <andy@infradead.org>; Darren Hart <dvhart@infradead.o=
rg>; Vadim Pasternak <vadimp@mellanox.com>; David
> Woods <dwoods@mellanox.com>; platform-driver-x86@vger.kernel.org; linux-k=
ernel@vger.kernel.org
> Subject: Re: [PATCH v5 1/2] platform/mellanox: Add bootctl driver for Mel=
lanox BlueField Soc
>=20
> On Mon, May 20, 2019 at 06:07:44PM +0000, Liming Sun wrote:
> > > > +static struct platform_driver mlxbf_bootctl_driver =3D {
> > > > +	.probe =3D mlxbf_bootctl_probe,
> > > > +	.driver =3D {
> > > > +		.name =3D "mlxbf-bootctl",
> > > > +		.groups =3D mlxbf_bootctl_groups,
> > > > +		.acpi_match_table =3D mlxbf_bootctl_acpi_ids,
> > >
> > > Why is an acpi driver a platform driver?  Isn't there a "real" acpi
> > > driver interface you should be tieing into instead?
> > >
> > > Only use a platform driver as an absolute last resort.  I don't think
> > > that is the case here.
> >
> > The driver is trying to configure boot-swapping and display secure stat=
e,
> > and is defined/initiated in ACPI table in UEFI. It seems a little hard =
to
> > categorize this driver to any existing subsystem. Any suggestion
> > where it might be a better fit (like drivers/misc, drivers/firmware, et=
c)?
> > Please correct me if I misunderstand the comments. Thanks!.
>=20
> The comment was asking why an acpi driver is a platform driver, but then
> I went and looked now at a bunch of acpi drivers, and they all are
> platform drivers :(
>=20
> Anyway, drivers/acpi/ seems like the best place for this file, right?

My understanding is that the "drivers/acpi" is mainly for the acpi common c=
ode.
The vendor or platform specific drivers are spread in other various directo=
ries,
most of which are 'platform' drivers.=20

For this driver, we didn't find better sub-component for it, thus put it un=
der
'drivers/platform/mellanox' which is vendor specific driver by its name.

>=20
> thanks,
>=20
> greg k-h
