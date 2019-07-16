Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F92C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B9E2173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbfGPPTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 11:19:55 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:39044 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728137AbfGPPTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 11:19:55 -0400
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.190) BY m9a0002g.houston.softwaregrp.com WITH ESMTP;
 Tue, 16 Jul 2019 15:19:54 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 16 Jul 2019 15:10:33 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 16 Jul 2019 15:10:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlCKAabnBGzE37jxY7Kh4+R8bR+KydM7/Oi18g1SuIID02yZcmubK+CneRr0oIfT4MJ0ptce2UQaL6WY+8B6cXnC3/DjfDpUzRQdiM3ozPxolBQgnqFip1FbO9eKc3R4lGAub3y/MNbo0xXJEwHCZKK5vz07R0N9eKsVUtpLhpDQeEfXvnZJiwNhFDXG9NqmUp6tItjYGJ2z9KIX6q9GrRqX7ulCX3KBTNR7L56G31mLLC7MoUr+6lMeIVYfz+jhUMsqy9MZ/RZhhvKONwiRD6VL15Z3hwPf/Lrxn7B2phUo6bNG58rLUC9GPkMJUTtthxpk36lTdiu1Kc70Bwricg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uR767Ckf0sa37w/K7oA48XRywI6r2u0bAfU4MHovKZo=;
 b=P3YoDgTr+pPkMUAQiQ7Y2wueO+BfYtI34hJhGmNf3BcEJmI+EeNQ8iDAHTzzcUYO8MdZBdll7Tsi7AdFhiQZNqvmc7PiugxZQnl6vP9EklKlc0KDOw+VpIo6er8OT6pjKPKc52pTXSHXsfghzp3gXfRogBVclhOUY9w52ZGhJxzlWI6lEDuyHcZQLh78rMTNFFKMpVvP2Spgd/g8rbXZIl3zHYXFa77/jpYkrqrh/Edim1SkJyWvf4WXqm71abm3rjb3Jv8K7yaBJbiO0N/n5tLvrj2/6W2Z3yGkSv5Eq+zwGdoXULbZbzTfZwiJ7q1ZEcZ5tYXLo9/q+gnlDEiJpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=suse.com;dmarc=pass action=none header.from=suse.com;dkim=pass
 header.d=suse.com;arc=none
Received: from MN2PR18MB2846.namprd18.prod.outlook.com (20.179.21.147) by
 MN2PR18MB2686.namprd18.prod.outlook.com (20.179.81.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.11; Tue, 16 Jul 2019 15:10:32 +0000
Received: from MN2PR18MB2846.namprd18.prod.outlook.com
 ([fe80::307c:8422:7d8c:8ac6]) by MN2PR18MB2846.namprd18.prod.outlook.com
 ([fe80::307c:8422:7d8c:8ac6%3]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019
 15:10:32 +0000
From:   Petr Tesarik <PTesarik@suse.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
CC:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Laura Abbott" <labbott@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Raymund Will <rw@suse.com>
Subject: Re: [PATCH] s390: enable detection of kernel version from bzImage
Thread-Topic: [PATCH] s390: enable detection of kernel version from bzImage
Thread-Index: AQHVO1p2NdiEYNQpfUiSTDvrwXSeS6bNLbAAgAALz9SAACD1gA==
Date:   Tue, 16 Jul 2019 15:10:32 +0000
Message-ID: <20190716171019.0313d3d9@ezekiel.suse.cz>
References: <your-ad-here.call-01563228330-ext-8076@work.hours>
        <patch.git-94e9726bbfe5.your-ad-here.call-01563228538-ext-5706@work.hours>
        <20190716123006.2d426ec8@ezekiel.suse.cz>
        <your-ad-here.call-01563282698-ext-9575@work.hours>
In-Reply-To: <your-ad-here.call-01563282698-ext-9575@work.hours>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0244.eurprd07.prod.outlook.com
 (2603:10a6:802:58::47) To MN2PR18MB2846.namprd18.prod.outlook.com
 (2603:10b6:208:3e::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=PTesarik@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
x-originating-ip: [195.146.112.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fdd58d3-a749-4240-710b-08d709ffbeec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(49563074)(7193020);SRVR:MN2PR18MB2686;
x-ms-traffictypediagnostic: MN2PR18MB2686:
x-microsoft-antispam-prvs: <MN2PR18MB26862D1F55065039EAF0A25DA6CE0@MN2PR18MB2686.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(199004)(189003)(4326008)(68736007)(316002)(25786009)(3846002)(6116002)(5660300002)(80792005)(478600001)(256004)(54906003)(99286004)(52116002)(76176011)(66066001)(102836004)(71190400001)(66446008)(64756008)(305945005)(66556008)(2906002)(1076003)(66476007)(66616009)(71200400001)(8676002)(26005)(99936001)(50226002)(6506007)(6916009)(229853002)(186003)(386003)(486006)(476003)(6512007)(9686003)(66946007)(86362001)(14454004)(6436002)(53936002)(107886003)(7736002)(6486002)(81166006)(81156014)(8936002)(446003)(7416002)(11346002)(6246003)(39210200001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR18MB2686;H:MN2PR18MB2846.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C9kKtHNqRxEVfErqrpQQTZZC7DlH9g641e3Fw4QGY1IBTAdvCHTOY++jlDKOEwrWwwtzETEWvn+n3JdldyGAg0oI/V31+UH1L26tInlEWDymTp9fqgWtCWo/qy28w+UBm9UIRAckA0AuD0o7gklzX1KqqSHJVsUJd9A2XDdWN5Si0dHhSk77eWOivARQl66J+J5sIKmCLjure5LqJVkuyAWlnGVcOQbCiTkY6NndKqUBu1+72lxaAxnmV5W38CcHwIhXo4CFH9iefcABd2g5AF23ObbMLDmfgwGMMJAv6OOo/NNpPYBEYdWYrkq3stLXx4ZxTtFSXl8Xk4eBLlN0cP0iIZj06KoQxedFHiMYLFjw9gXM6vt1n3IJYxkAJ4V8EXO+mH8+u2ncqgdgZhiHKKeb5Kgr32Jj7NUIggjJIRQ=
Content-Type: multipart/signed; micalg=pgp-sha256;
        boundary="Sig_/QOVQTxMmYG2vTcfhSUNHucV";
        protocol="application/pgp-signature"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdd58d3-a749-4240-710b-08d709ffbeec
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 15:10:32.3779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PTesarik@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2686
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QOVQTxMmYG2vTcfhSUNHucV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jul 2019 15:11:38 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> On Tue, Jul 16, 2019 at 10:30:14AM +0000, Petr Tesarik wrote:
> > On Tue, 16 Jul 2019 00:12:19 +0200
> > Vasily Gorbik <gor@linux.ibm.com> wrote:
> >  =20
> > > Extend "parmarea" to include an offset of the version string, which is
> > > stored as 8-byte big endian value.
> > >=20
> > > To retrieve version string from bzImage reliably, one should check the
> > > presence of "S390EP" ascii string at 0x10008 (available since v3.2),
> > > then read the version string offset from 0x10428 (which has been 0
> > > since v3.2 up to now). The string is null terminated.
> > >=20
> > > Could be retrieved with the following "file" command magic (requires
> > > file v5.34):
> > > 8 string \x02\x00\x00\x18\x60\x00\x00\x50\x02\x00\x00\x68\x60\x00\x00=
\x50\x40\x40\x40\x40\x40\x40\x40\x40 Linux S390 =20
> > > >0x10008       string          S390EP   =20
> > > >>0x10428      bequad          >0   =20
> > > >>>(0x10428.Q) string          >\0             \b, version %s   =20
> > >=20
> > > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com> =20
> >=20
> > This looks great! Much cleaner than the original approach.
> >=20
> > Thank you,
> > Petr T =20
>=20
> Then I'll add
> Reported-by: Petr Tesarik <ptesarik@suse.com>
> Suggested-by: Petr Tesarik <ptesarik@suse.com>
> if you don't mind and try to queue that for 5.3.

Oh, sure, please add these lines and go ahead.

Thank you again,
Petr T

--Sig_/QOVQTxMmYG2vTcfhSUNHucV
Content-Type: application/pgp-signature
Content-Description: Digitální podpis OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHl2YIZkIo5VO2MxYqlA7ya4PR6cFAl0t6NsACgkQqlA7ya4P
R6d7Xwf+JNE4QIkYg1+FqAdL+wSIawGHgDsRlLflNNiFUtSyXFP6YQ2QiNVZkW6u
IAI8Q9hexXcHBcPttgIxoc7spvMxWnsUnfdy75BlyeUIpmArKUeoWyOoA4CycAuo
MIBwcXWkLv59+7VrZYCSHuquMjtRisnYLj7iwGshjLjlrT4BCfwboJozfGvjRDDB
1fbPen/3fnYtACRZWZ6lXrWHo+q0qdnGzi3Q3MtDRRgcn2NvMGk43V2Qf/KGJ7kf
WDpkJqqcLUS2yq9By7X6m3Exx/AimjomPgSJv43qJnHRKeRkCePX8g/0l0JcZxi3
FKC3BMjzl1UEuf1YZ2UwubO+6YvuNg==
=YyiZ
-----END PGP SIGNATURE-----

--Sig_/QOVQTxMmYG2vTcfhSUNHucV--
