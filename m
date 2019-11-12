Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C39C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032E62084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="hZNz1j4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfKLGUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 01:20:03 -0500
Received: from mail-eopbgr750083.outbound.protection.outlook.com ([40.107.75.83]:55111
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbfKLGUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 01:20:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SB4QeQtLbW5h5ozYdcJ0WJqiz1OmZvvxMDspDkVCzQGyGMNcUFq4Clj8ZqI0KH/XIHX27aNCcdmH2/nN5xQps/sAn2x0COWJHSMNtEw3SbUogX1ZuI7Fw9bmO6QMKUQo8WDch2WZZj7fGoAk/cskpNla8rpmAKfii39Gyqwcqd9HhcM5POT40fIyowFsQ71agU5UVdOAsGYgWqtcLnWWx6fIRxFfwrbbPICZC7cGw3cmkVdFBvn1TdfPsXclQYGSmByn1CpxAxxnJs9u/P+d0kCHXt2MODS8KDy0A+hfEYft75fIfxfoAXzOf9sDaUd0OAA5hQ6fzzR7UYf5OGVObg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrAFuwqFVOHnaxWlUg4RbzUisjfCzQwR/6oIRjuVxJc=;
 b=Xtoa+TwFcG3BCz7ljuoB1LlVCR2d5b8xzM9DMm2JnSqV7cCUBn6FCxUYMDeMZLR8uGEC+Ux9gfDw04xdC642jKMt9ebDyUOWw9l9G4y3hAIB2LuDkoR+87uDAD/O3Ce1gEu3hsXCRO1+UsK7vFbdxocOWtGz7VoUr8mfEiW1AkI/aHXAZ+KDoejwKNPIFfCM/moPtPQbH7dHRlSe1QYXU+mcBy6EXbJNY+AOUFB2hiTJMOtg9EODSC71jMNb9EDZhbUWT7h8NwWrJSlwBIlDwT+l2qv37pKG+G1aX4ag7eoQXqRlFuMCGdVZBwiXMdFpp2iAps4RZFMUO2bAI+1Qtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrAFuwqFVOHnaxWlUg4RbzUisjfCzQwR/6oIRjuVxJc=;
 b=hZNz1j4oOtfKMfZJaYxMj6dYQdmkXfoegpBmnEaBX+Gz5c9VyLn1ZJm30WYqfUSbh16ARXCFpsrByChhDG2LoEQFYuhKjL9avpkfJONI/j80/OgvBuasOVLZQjvgIi0XWTwgYOUaxXc95w1YSid/kD0rpEEe6jWM5BEmyNVys2Y=
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3736.namprd13.prod.outlook.com (20.180.13.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.15; Tue, 12 Nov 2019 06:19:59 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::853e:1256:311e:d29]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::853e:1256:311e:d29%7]) with mapi id 15.20.2451.018; Tue, 12 Nov 2019
 06:19:59 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
Subject: RE: [PATCH] RISC-V: Add address map dumper
Thread-Topic: [PATCH] RISC-V: Add address map dumper
Thread-Index: AQHVmFCzGZwFnAd1O0S/YrXUtDW+c6eGRxcAgADJF9A=
Date:   Tue, 12 Nov 2019 06:19:58 +0000
Message-ID: <CH2PR13MB336810E7C6FE6754558E717D8C770@CH2PR13MB3368.namprd13.prod.outlook.com>
References: <1573450015-16475-1-git-send-email-yash.shah@sifive.com>
 <91f35033-ffc8-cd2e-36f7-c6f4f25be36b@deltatee.com>
In-Reply-To: <91f35033-ffc8-cd2e-36f7-c6f4f25be36b@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
x-originating-ip: [114.143.65.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ca85c5b-7e5f-4ec0-39b8-08d767385822
x-ms-traffictypediagnostic: CH2PR13MB3736:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR13MB37368BA029B2CC751988E9D38C770@CH2PR13MB3736.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(366004)(346002)(136003)(376002)(199004)(189003)(2201001)(71190400001)(9686003)(5660300002)(71200400001)(2501003)(256004)(478600001)(11346002)(486006)(446003)(6306002)(966005)(6246003)(476003)(81166006)(4326008)(7416002)(81156014)(76176011)(8936002)(305945005)(7736002)(229853002)(14454004)(74316002)(8676002)(52536014)(66556008)(6116002)(3846002)(66446008)(33656002)(66476007)(64756008)(110136005)(26005)(76116006)(4001150100001)(2906002)(44832011)(7696005)(86362001)(6436002)(54906003)(99286004)(66066001)(66946007)(53546011)(316002)(55016002)(6506007)(186003)(102836004)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3736;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xI63z3uG9PovloLo+Mj6HWuCfWrnGjSxpQW1LCAm/vjm8+WNVKC1rn5/6XOoqzdQyuXieLnpO55dgfPdNWHiU5R0Cyn1Nx6EclUQDRNdx5HCTS6muXG0UGNPpaG/XVQVfadq5pI+dmXtbwh9hwiyyyzmbStgKVWoevfe7hQfzIHlIsgvNiWs8r6BpbCqVhustaj9h1mrtR8sDU2DZArptqyJEIxtRiCO4F7ecLRJmqGnL2GFE59mhZKNjAQIuOAPO0DWKfRU582D3GP9qoFnhOQgGGGRp9C1zHPP05ZYqHZo2nUpsDTkLkJ3a/cnX5wyHrMCc9FVsjuWQeIIpg7jbOgjntdWUH0vapFIGOf8tJ7El/AYkedqUc1AtjfwH7Ssv27oDXp7FWEgtqRHoRUu7zPR7cCVu5jl0u659cgL0E9/5bQAYvHMy+gwAvGwAr8r
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca85c5b-7e5f-4ec0-39b8-08d767385822
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 06:19:58.8833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjl9/z0HDHZHwOGuvUmkJvOLEWGJbFlq79pDmO0v3aVK8CeXqEVEMFbgKRlpUVIT2kEMh4YcS4sZu51eGbkUVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3736
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2019-11-10 10:27 p.m., Yash Shah wrote:
> > Add support for dumping the kernel address space layout to the console.
> > User can enable CONFIG_DEBUG_VM_LAYOUT to dump the virtual
> memory
> > region into dmesg buffer during boot-up.
>=20
> Cool, I'd find this useful. Though, is there any reason we don't do this =
more
> generally for all architectures?
>=20
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> > This patch is based on Linux 5.4-rc6 and tested on SiFive HiFive
> > Unleashed board.
> > ---
> >  arch/riscv/Kconfig.debug |  9 +++++++++
> >  arch/riscv/mm/init.c     | 30 ++++++++++++++++++++++++++++++
> >  2 files changed, 39 insertions(+)
> >
...
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c index
> > 79cfb35..fcb8144 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -55,6 +55,36 @@ void __init mem_init(void)
> >  	memblock_free_all();
> >
> >  	mem_init_print_info(NULL);
> > +#ifdef CONFIG_DEBUG_VM_LAYOUT
>=20
> Generally, it's best to avoid #ifdefs inside functions, it's even counter=
-
> indicated in the style guide[1].

Yes, I will move out the print logic as a separate function and guard it wi=
th #ifdefs

>=20
> > +#define MLK(b, t) b, t, (((t) - (b)) >> 10) #define MLM(b, t) b, t,
> > +(((t) - (b)) >> 20) #define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t)
> > +- (b)), SZ_1K)
>=20
> I personally find these inline defines rather ugly. Maybe it would be bet=
ter to
> have a helper function that prints a single line. Also seems like MLK and
> MLK_ROUNDUP could be the same assuming the entries in MLK are
> aligned...
>=20

Sure, will convert this macros into helper inline functions and will also d=
rop MLK_ROUNDUP.

>=20
> Thanks,
>=20
> Logan
>=20

Thanks for your comments!

- Yash

> [1]
> https://www.kernel.org/doc/html/latest/process/coding-
> style.html#conditional-compilation
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
