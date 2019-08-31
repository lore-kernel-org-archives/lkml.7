Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32B4C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 10:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652322190F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 10:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="PCiyfDiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfHaKDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 06:03:31 -0400
Received: from mail-eopbgr810137.outbound.protection.outlook.com ([40.107.81.137]:62688
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbfHaKDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 06:03:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWKALqPwwfA2tY/l035q5lThPCi0a53jvNw0WhBXh76dCk7+vvbPJZGVuJLmOyIqWNNw43PbGAlRVGZlglcKdveDPIP8K0bmmIcmRpG+U39KN52yvE3dCSkVD3AxwoQIzIVTGKwjaJmAqGUfPuYpWsyw4dWaTgaAzCO6hSt8b/uuAwPNLqpXXaT/JvAcEf8GKvGQ1B+zP7whNGfJXKV6IYIBUTB/Vz+AoVDXugBKUuebVVXbZAKV2oPjvhhvB8wI5JTlpUNqow5zgxX3lywyap2erdFFvNx8u8gQF/73NUvjyn4BpbE9EwzJJ20CXIpFJAjZp85cB+zQNiUG5T/ULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su6ZDz8R7cM8ot7yjuxtZ5uL1rw8XaqPz8o881SO2yY=;
 b=StnZj+MutX7E3nScsV61byLr+125PM6CbtPOm7VhbbHyKSSLWb0IZwllnXPNhtey0SUJWtAVLubd+CGz32kSpG+AnPlPwV2Pg7efFCQlzmf/jnyuFXhsLEjWaymGD+KHQtOYIjGFL6U37X9O1KUEvPeZ1yVNm66kw5jqgouDHBLUFtzVaaHB1jbfJzrRcdaNtpRmRxjZo9FBT1uHsbmZliauaha2C0S0BjSZw6tYr4IIcDLeWoizO0kfd83+GQ7itZqq4+aIbuIDgK5HCjtnDe+v0SSEd5HM6ywfEBycKwEwz5PMSr3PBmfaQJJL+docNBzQrW2p87BURkWL0M1R3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=mips.com;
 dkim=pass header.d=mips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su6ZDz8R7cM8ot7yjuxtZ5uL1rw8XaqPz8o881SO2yY=;
 b=PCiyfDiMM1fXyKeY44gqAlsgGMHx/3HsZMzVieAxOf67ZSPISX/mX+7BpHvEZewJ/CbXIobut9HUHTmq78UbBcXsVmGfKupKqP8ySGw3Y/K81UQBR+vu33+kERl3If5qgRi5kYalle0mJu91qVGOWLcoXaB2uqZMw+KGaHvNyWI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1312.namprd22.prod.outlook.com (10.172.63.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Sat, 31 Aug 2019 10:02:48 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::f9e8:5e8c:7194:fad3]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::f9e8:5e8c:7194:fad3%11]) with mapi id 15.20.2220.013; Sat, 31 Aug
 2019 10:02:48 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/4] atomic: Fixes to smp_mb__{before,after}_atomic()
 and mips.
Thread-Topic: [PATCH v2 0/4] atomic: Fixes to smp_mb__{before,after}_atomic()
 and mips.
Thread-Index: AQHVX+M9hlAL1dGeDUqOXDXZpSY6Xw==
Date:   Sat, 31 Aug 2019 10:02:47 +0000
Message-ID: <20190831100242.xhbgaodzbuqj5axy@pburton-laptop>
References: <20190613134317.734881240@infradead.org>
 <20190831090055.GH2369@hirez.programming.kicks-ass.net>
In-Reply-To: <20190831090055.GH2369@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0289.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::13) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [78.144.179.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e3ef5e4-f975-4647-38bf-08d72dfa6028
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1312;
x-ms-traffictypediagnostic: MWHPR2201MB1312:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR2201MB1312D0230E243DEE83D15D88C1BC0@MWHPR2201MB1312.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 014617085B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(39850400004)(366004)(396003)(136003)(346002)(189003)(199004)(102836004)(71190400001)(316002)(9686003)(58126008)(7416002)(53936002)(52116002)(1076003)(33716001)(71200400001)(229853002)(8936002)(25786009)(54906003)(6512007)(26005)(186003)(66556008)(6306002)(5660300002)(256004)(64756008)(66446008)(66946007)(66476007)(76176011)(6916009)(14444005)(486006)(476003)(966005)(66066001)(386003)(6506007)(8676002)(81156014)(81166006)(6486002)(446003)(2906002)(11346002)(6116002)(42882007)(3846002)(99286004)(7736002)(4326008)(14454004)(305945005)(6246003)(6436002)(478600001)(44832011)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1312;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A++e+Qt+eVo9M7acDou/UeGX8LUh9CBpNoz+7A7Xous42DreTlY9a1wEEslAlxF4dis38e8buAetpw9JEOHl0p9Hm6fcmBqj1n1zr59MIwOEKSTeWs+A9xIQh3a4uWIt7GvGV98d7mv8kVqIKC5LW0zJOaWDlO8Xp1wtHFlAUjSFrtYl9H8Df+v3DUR57SxlyNHd8+lrXcfKat7+KMuEYBc/oi7lIMwfHJuRIV7wv/QsqClshGhZ2T9ivRbif+KKw27V2PXYQA3Et/J54Vt3S3dzDUsLsWuQW+bp2p4UJWQ382bBLgzbKreMnvFD/w8EJBvSAaBbL3jVmeL9Ad6S1OOnb0Njl5JtWjP6QRVvGqoW5d9+tSRiZ26+qNhxRRAL3uqwSODXozn89jlRH2Obxj6hi2FT/AWqw9nz4VTZCJI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4FC9B0A9B556AF4AACCAD20AED627196@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3ef5e4-f975-4647-38bf-08d72dfa6028
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2019 10:02:47.7685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lN+KdEmzoLPoQGJoujDNsD+GXd2TSuj4i6iSExtVbbXkQF5oXHvygbm6yvh6UP2YfKqt2D21DEP772y/s9+AeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1312
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Sat, Aug 31, 2019 at 11:00:55AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 13, 2019 at 03:43:17PM +0200, Peter Zijlstra wrote:
> > Hi,
> >=20
> > This all started when Andrea Parri found a 'surprising' behaviour for x=
86:
> >=20
> >   http://lkml.kernel.org/r/20190418125412.GA10817@andrea
> >=20
> > Basically we fail for:
> >=20
> > 	*x =3D 1;
> > 	atomic_inc(u);
> > 	smp_mb__after_atomic();
> > 	r0 =3D *y;
> >=20
> > Because, while the atomic_inc() implies memory order, it
> > (surprisingly) does not provide a compiler barrier. This then allows
> > the compiler to re-order like so:
> >=20
> > 	atomic_inc(u);
> > 	*x =3D 1;
> > 	smp_mb__after_atomic();
> > 	r0 =3D *y;
> >=20
> > Which the CPU is then allowed to re-order (under TSO rules) like:
> >=20
> > 	atomic_inc(u);
> > 	r0 =3D *y;
> > 	*x =3D 1;
> >=20
> > And this very much was not intended.
> >=20
> > This had me audit all the (strong) architectures that had weak
> > smp_mb__{before,after}_atomic: ia64, mips, sparc, s390, x86, xtensa.
> >=20
> > Of those, only x86 and mips were affected. Looking at MIPS to solve thi=
s, led
> > to the other MIPS patches.
> >=20
> > All these patches have been through 0day for quite a while.
> >=20
> > Paul, how do you want to route the MIPS bits?
>=20
> Paul; afaict the MIPS patches still apply (ie. they've not made their
> way into Linus' tree yet).
>=20
> I thought you were going to take them?

My apologies, between the linux-mips mailing list not being copied (so
this didn't end up in patchwork) and my being away for my father's
funeral this fell through the cracks.

I'll go apply them to mips-next for v5.4.

Thanks for following up again,

    Paul
