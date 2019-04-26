Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86517C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B82E206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="EqVnBwHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDZPCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:02:50 -0400
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:52350
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbfDZPCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/Z0TJgtVFaQG+wvgt3CmQHkED0zIpaVo41H0D7M88I=;
 b=EqVnBwHU6BuomxPN+NuPGMtTr36a1GFCZLqGsmv4vCA/NLAOVfVN9+VKrauPs7FnigeMsrza9cORBW5LK3UwZrf2eEjxLIXgI6ps6hLg10olIqAu+vEythQAJdf24kDLocFkAKwHtdzpohCtWfkaa1VmLq9xZjQvsHh4rhnuGyo=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5069.eurprd05.prod.outlook.com (20.177.52.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Fri, 26 Apr 2019 15:02:44 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 15:02:43 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Will Deacon <will.deacon@arm.com>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v2] binfmt_elf: Update READ_IMPLIES_EXEC logic for modern
 CPUs
Thread-Topic: [PATCH v2] binfmt_elf: Update READ_IMPLIES_EXEC logic for modern
 CPUs
Thread-Index: AQHU+t0VMl+rzkpGzUmQ8mmhU8ex6KZMXawAgAC6+QCAADaggIABPSyA
Date:   Fri, 26 Apr 2019 15:02:43 +0000
Message-ID: <20190426150237.GD2303@mellanox.com>
References: <20190424203408.GA11386@beast> <20190425054242.GA7816@gmail.com>
 <CAGXu5jKWQtmt+tN9rwdCWP=7pL6GYU4DmDW4R7ViQV8r1m1J=g@mail.gmail.com>
 <20190425200725.GC58719@gmail.com>
In-Reply-To: <20190425200725.GC58719@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::20) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30ddc246-d44d-48f0-435d-08d6ca583b98
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5069;
x-ms-traffictypediagnostic: VI1PR05MB5069:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB5069DE8D1496A1001507EAEBCF3E0@VI1PR05MB5069.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(256004)(3846002)(76176011)(81156014)(6116002)(26005)(81166006)(68736007)(6916009)(99286004)(8676002)(305945005)(7736002)(966005)(52116002)(97736004)(33656002)(229853002)(66066001)(2906002)(6306002)(8936002)(71200400001)(71190400001)(6512007)(25786009)(36756003)(54906003)(386003)(7416002)(446003)(6436002)(2616005)(11346002)(5660300002)(478600001)(6506007)(1076003)(4326008)(66446008)(64756008)(73956011)(66476007)(66556008)(102836004)(53936002)(86362001)(316002)(6246003)(486006)(93886005)(476003)(186003)(6486002)(66946007)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5069;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mIoUEvJ83V5TVELtwVtWiVvJxc3l3gG77drZMQTmeB/EaZX3tdP3MbRGlSObW5YlPacdQlrYcrwjBhNSocm/VrAF/gEOTZi2wYR64pf8e5Et4XlWPhE6tY4xxcKSfypgwGeVnW3Tp4ZYmosJI0i68J3v2hRl/hSmrdDyS51HWpQEz7wlI+OutY4X0laNhjt0QgAl4hN8eCdzu8VFzyR6soDFdRnALlPdgMdHsVpokqxB6T+qmn+rtBA0fxfue17XapeOtfzSX4rQFluGdgWvKF1GaozbLK47wTmWLAk+vitSg4mE1duQQwBIQCR0VcalFk6odLlZrpi82ujF4WMD+OzL+nIm8OtgTvXvJk5/8XVsDtNnJx8RFzPjYgMNh5ZsVBtF22XsFrB8LD3UvOo84ULY8hE0QZfu/LsZQGX7aNI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B789B7DDBE5CBF4D84311195D93448DB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ddc246-d44d-48f0-435d-08d6ca583b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 15:02:43.7419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:07:25PM +0200, Ingo Molnar wrote:

> > But yes, your above diff for "has NX" is roughly correct. I'll walk
> > through each piece I'm thinking about. Here is the current state:
> >=20
> >                CPU: | lacks NX*  | has NX, ia32     | has NX, x86_64 |
> >   ELF:              |            |                  |                |
> >   missing GNU_STACK | exec-all   | exec-all         | exec-all       |
> >   GNU_STACK =3D=3D RWX  | exec-all   | exec-all         | exec-all     =
  |
> >   GNU_STACK =3D=3D RW   | exec-none  | exec-none        | exec-none    =
  |
> >=20
> > *this column has no architecture effect: NX markings are ignored by
> > hardware, but may have behavioral effects when "wants X" collides with
> > "cannot be X" constraints in memory permission flags, as in [1].
>=20
> So [1] appears to be device driver mapping a BAR that isn't intended to=20
> be excutable:
>=20
>    https://lore.kernel.org/netdev/20190418055759.GA3155@mellanox.com/
>=20
> and the question is, do we reject this at the device driver mmap() level=
=20
> already, right?

No, we wanted to reject it at the driver mmap() level, but if an
executable is marked with GNU_STACK=3DRWX then the core mm code always
calls the driver with VM_EXEC (even though the mmap isn't a stack) and
the driver becomes incompatible with userspace using GNU_STACK=3DRWX (ie
some Fortran programs, apparently)

> I suspect the best behavior is to reject as early as possible, so I agree=
=20
> with your change here - even though !NX systems tend to become less and=20
> less relevant these days.

I suggested the idea of adding a flag in either the struct file or the
file_operations flag that says mmap is never to be executable for this
file with the idea that most/all cdev users would set it.

Does that seem reasonable?

Jason
