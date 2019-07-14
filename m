Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C7BC73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 16:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053D82089C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 16:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfGNQ0c convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 12:26:32 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:45462 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728065AbfGNQ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 12:26:31 -0400
X-Greylist: delayed 1511 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jul 2019 12:26:30 EDT
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.190) BY m9a0002g.houston.softwaregrp.com WITH ESMTP;
 Sun, 14 Jul 2019 16:26:29 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sun, 14 Jul 2019 15:52:55 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (15.124.72.14) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Sun, 14 Jul 2019 15:52:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGZqwYLRzzJZ1a6QGd8df7QDseWzHZEJFdumhByF4TjhcO3oXxN/GUHGC6FMq37gs8nBazyLVsjxKl0l7p2ZnN4sfUHahCFpUuwuDy3D8kw3A89/TUoxSUM8/J/mEfoHQbBO2kahEE0N46OVtBUaYQyyqUavRqLCxXBGU9pC6/MZB91Gt/wX0Ga+1XMWxr1nOLnhzJi+soi9GkAsUgVFUKurP0o9qyMJPL8QFE9TWYCo6eUrHNDZG89FzVFn61Nd2iDqIx6UKDuuv4nkvPtkhZWacbIg6082nZZTYUecZx4WVO/JNlGLulKjRE2GcFiDz/6ZrtdpjhDi8P+qSfdEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmNyBgEjsYtHU3O+MhVNioVLvnBdFJ+mRNvORPeqmFw=;
 b=aW9dV2yL8aBYs+ZjEyej1L+HapEnI0vnF8L7+4/ZaLfEH2RMVPL0/wvsAkOyUi7rkAxF5xpRs5Di5DySJcpr8DqTMU/OTd9n/NkeASKHeRzTs5bMP81VZuQbDLE2zbJD46LYR+7JYG4NgJ/KJcsZQ6QjvXKWQHP+EcsrzPZ0bluhcz5HGt41b0KnMrTgRmZGcn7rrgDxHxepEDm15qna9q8l8Tb/wbuA6ox/pu4nOZfrdUMtqHE0phmVkaVQAKPKI8YIygFPgitShB/reGBs/VC6spprKzz5lszYIPE+jWRRe2OIv9tuQDAYldPfeTO/rY3c6mBA0tX3ioGySMyCmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=suse.com;dmarc=pass action=none header.from=suse.com;dkim=pass
 header.d=suse.com;arc=none
Received: from MN2PR18MB2846.namprd18.prod.outlook.com (20.179.21.147) by
 MN2PR18MB3373.namprd18.prod.outlook.com (10.255.238.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Sun, 14 Jul 2019 15:52:52 +0000
Received: from MN2PR18MB2846.namprd18.prod.outlook.com
 ([fe80::307c:8422:7d8c:8ac6]) by MN2PR18MB2846.namprd18.prod.outlook.com
 ([fe80::307c:8422:7d8c:8ac6%3]) with mapi id 15.20.2073.012; Sun, 14 Jul 2019
 15:52:52 +0000
From:   Petr Tesarik <PTesarik@suse.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
CC:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Philipp Rudo" <prudo@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Raymund Will <rw@suse.com>
Subject: Re: [PATCH 2/2] s390: add Linux banner to the compressed image
Thread-Topic: [PATCH 2/2] s390: add Linux banner to the compressed image
Thread-Index: AQHVONZG6fQxJFf0Tk2aYjq5NUSgEKbKMUg4gAAVCgA=
Date:   Sun, 14 Jul 2019 15:52:52 +0000
Message-ID: <20190714175041.194c98be@ezekiel.suse.cz>
References: <cover.1562950641.git.ptesarik@suse.com>
        <aa477dd145aa2beb37fe813619b0723744a22a0a.1562950641.git.ptesarik@suse.com>
        <your-ad-here.call-01563114933-ext-9422@work.hours>
In-Reply-To: <your-ad-here.call-01563114933-ext-9422@work.hours>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0802CA0047.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::33) To MN2PR18MB2846.namprd18.prod.outlook.com
 (2603:10b6:208:3e::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=PTesarik@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
x-originating-ip: [2a00:1028:83b8:1e7a:5a6e:d5af:320a:e57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b04d1f83-d494-4478-9f94-08d7087353ec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3373;
x-ms-traffictypediagnostic: MN2PR18MB3373:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR18MB3373FE8D166CC299E1F16CDDA6CC0@MN2PR18MB3373.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0098BA6C6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(346002)(376002)(396003)(39850400004)(199004)(189003)(66946007)(66446008)(64756008)(66556008)(66476007)(8936002)(8676002)(76176011)(6306002)(6512007)(80792005)(52116002)(386003)(478600001)(186003)(6116002)(102836004)(50226002)(6506007)(14454004)(68736007)(6486002)(476003)(486006)(1076003)(9686003)(6436002)(81156014)(81166006)(53936002)(256004)(305945005)(7736002)(99286004)(71190400001)(2906002)(71200400001)(6246003)(107886003)(5660300002)(446003)(229853002)(11346002)(6916009)(966005)(4326008)(86362001)(316002)(54906003)(7416002)(46003)(25786009)(39210200001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR18MB3373;H:MN2PR18MB2846.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LJNV6ZL2VfwY5ohkstu3Pm3XJwYHJewEuCAKEPdO3p5H2XQ/Zkz+SrlQAGyqmPY27eFh08xzn3kNG5vU1ia8S4oH11NqLEatwt0z/n3IqE/M3U9gOvxoKx78CERGdunEDEUkR/GoBx6gyhUiQr9kpl811+LI4ukJIEeibclmYHPFW11tTZKvMFnKKh2QftRbsIMkDaZnTsAXLzp4d6a2NH2lgDhUIGtHQTYFSDMtwWd8v8CVCnjsm31CqFFl3xDWtdil7RpmB/pPLvt7Z5NrELfaXc1mEaLtdzPZGOJERi9uvxGMU63FECHyc20WwiZ/xPPcXyeYSbiBQYFIb53LPX7Xdc3nOEmL3BALtEXW6Df06VwohvpxT+PE3jw3XsD7109W8fO1KVcktIBMtRtZKfM1MePtyEn0+kYgquKgC+M=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2E90DAA65F4A33468644BAEFA921F303@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b04d1f83-d494-4478-9f94-08d7087353ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2019 15:52:52.1850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PTesarik@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3373
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jul 2019 16:35:33 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> On Fri, Jul 12, 2019 at 07:21:01PM +0200, Petr Tesarik wrote:
> > Various tools determine the kernel version from a given binary by
> > scanning for the Linux banner string. This does not work if the
> > banner string is compressed, but we can link it once more into the
> > uncompressed portion of bzImage.
> > 
> > Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> > ---
> >  arch/s390/boot/compressed/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
> > index fa529c5b4486..9bc4685477c5 100644
> > --- a/arch/s390/boot/compressed/Makefile
> > +++ b/arch/s390/boot/compressed/Makefile
> > @@ -11,6 +11,7 @@ UBSAN_SANITIZE := n
> >  KASAN_SANITIZE := n
> >  
> >  obj-y	:= $(if $(CONFIG_KERNEL_UNCOMPRESSED),,decompressor.o) piggy.o info.o
> > +obj-y   += ../../../../init/banner.o  
> 
> We don't reuse objects from another build stage, we rebuild them with
> distinct decompressor's build flags.
> $ git grep "ctype.[oc]" -- arch/s390/boot
> arch/s390/boot/Makefile:obj-y   += ctype.o text_dma.o
> arch/s390/boot/ctype.c:#include "../../../lib/ctype.c"

Those flags do not make a difference for a simple object file like the
Linux banner, but I get your point, and I cannot see an issues with
rebuilding the banner for the decompressor.

> Besides that, there is a special CONFIG_KERNEL_UNCOMPRESSED mode, with
> which "strings vmlinuz | grep 'Linux version'" I assume you are using
> would still yield result. Adding the second version of banner would
> produce duplicated result in this case.

Sure, and AFAICT that's not a problem. But the point here is that the
production kernel should be compressed for all those well-known
reasons, but such image is then not recognized.

> But even before discussing solutions I would like to understand the
> problem first. Which specific tools are you referring to? What are they
> good for? And how do they get the kernel version from other architectures
> compressed images?

The tool I'm aware of is called get_kernel_version. It's built as part
of openSUSE aaa_base and is used at install time. I'm not quite sure
how it is used, but I have added Raymund Will to Cc; he can provide
more information. There's also an open bug for it:

  https://bugzilla.opensuse.org/show_bug.cgi?id=1139939

As for other architectures, I only know about x86. The x86 compressed
binary contains a header with various pointers, among them a pointer to
the kernel version string, so it must be added to the decompressor (cf.
arch/x86/boot/version.c).

If you prefer to have a similar header for other architectures, then
that would be fine with me, but it's a bit more involved, because it
would set up a new ABI...

HTH,
Petr T
