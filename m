Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24035C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 05:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBED42070D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 05:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="DAV6s9VN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfHEFDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 01:03:42 -0400
Received: from mail-eopbgr130055.outbound.protection.outlook.com ([40.107.13.55]:48964
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbfHEFDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 01:03:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4qsN6rYO60MnBQL3Dpw+kfFX+KUkJu2bLo6UBB4gtf34xM2uARLqN9d+oQKWc5cV7lrvsIaEwS0kWhFubFnRtBUqqHk6EXtF7Pr/erVyMl5jWwOY8xskckwuZ2KVNfMpLN/DjfjNNavhzIdSVve9HFE6UR+pxD6iqZYdYV2kNVsH6iHnSuTZtUUJ1c3POBbKk6aVMQRQ6iBfvJ0Siib0NR6uoQqZWta8KkQQuViQ3zeVXv+GjmPvR4Ib8+4/Am+6G8oRDPbUoN25Xh9rBv+qovQi8PQTDpXdjlERNCAVG023MaJec2aH+NF9kBZL73iePhEawDJ5bp0FqU2P/dz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ323v0jULQbBpBMEOIhqQBmcV6tumJu7qh4p9HSrFE=;
 b=konnCtDyB7LvH9QjkYl4LCZi/nQP8iN7/8aIFJ8ld5nHCxkplfEnFlj3d6oQavDi7Iy5MdM42XlJbesTujVg4pW8hW7ZakAPoiZpcgAiyxnMh4qLcKLksnOnO1Gy2wC1cPRyQ0edUKfhey/sUqb2x3pJSE5QkkEiXljVTo+JgxxaAZ+j3EcfORvO2bUyeG8MDqni+Pj3CcqD3RoXh4iMg1eaBm7K4HnPd/QqDbKydZE9wcSDI2kwywmkU2wuZUEEfwMUWhQTewe19T/JOLeTBo/YdqQMiK3+93Nsb7bbxTC6PZtt9onG0pNvxAAqizdw+F590u2m8+OJleVHRgk4iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ323v0jULQbBpBMEOIhqQBmcV6tumJu7qh4p9HSrFE=;
 b=DAV6s9VNZO2iEvn6hJyXY0u5AbcYhgYWUi4v82D82B5dyUQSNbLaWfBch5BBD2wSbXuYEaXRKTNjmMNYKKIlinRgrOxrf1XgAu1tFXl2mFFl7Bd7vh5U7GJ0PHL2vE6drKwPWCuzQgHFf2OiYkkcedQidq2+oWxyTXQimrjYYx0=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3140.eurprd05.prod.outlook.com (10.171.186.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Mon, 5 Aug 2019 05:03:38 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::a1bc:70:4ca9:49f6]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::a1bc:70:4ca9:49f6%7]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 05:03:36 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     kbuild test robot <lkp@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>
Subject: Re: drivers/infiniband/core/.tmp_gl_uverbs_main.o:undefined reference
 to `__user_bad'
Thread-Topic: drivers/infiniband/core/.tmp_gl_uverbs_main.o:undefined
 reference to `__user_bad'
Thread-Index: AQHVS0le9ZStzbxzQU+1jMhieiDmg6br/7AA
Date:   Mon, 5 Aug 2019 05:03:36 +0000
Message-ID: <20190805050334.GL4832@mtr-leonro.mtl.com>
References: <201902281750.jbpT0s0R%fengguang.wu@intel.com>
 <646013c8-5fcd-e7ab-0a87-3e0620563dfb@infradead.org>
 <f19db95e-be92-302c-2aef-19c4f3f5c8b0@infradead.org>
In-Reply-To: <f19db95e-be92-302c-2aef-19c4f3f5c8b0@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0236.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::32) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.137.115.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9a0a98f-ac7e-4f35-e870-08d7196245f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM4PR05MB3140;
x-ms-traffictypediagnostic: AM4PR05MB3140:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <AM4PR05MB31405DBE24DF7EB3DDDC7619B0DA0@AM4PR05MB3140.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(174874002)(189003)(199004)(71200400001)(71190400001)(5660300002)(1076003)(7736002)(6306002)(6116002)(8676002)(3846002)(305945005)(25786009)(6916009)(68736007)(81156014)(81166006)(478600001)(99286004)(54906003)(6246003)(76176011)(8936002)(66476007)(102836004)(66446008)(66946007)(64756008)(66556008)(386003)(6506007)(53546011)(26005)(4326008)(966005)(52116002)(186003)(476003)(11346002)(53936002)(5024004)(66066001)(6486002)(486006)(86362001)(9686003)(316002)(446003)(14454004)(6512007)(2906002)(33656002)(229853002)(14444005)(6436002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3140;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nDejgVqkiGLfdIfDxFy31j7I9D+F8xuVwMIwDSN6IFRwdBC4ZMQyakcEm73OJ5QS9YCNOZ+JWUu3KTLErtm9PbpPdp6UVSGYnfD0Jv8PP07FHgYNjTUjcd0ZXiXWbtyp8NY8tJIdD/UuBYivqKR5fjxFAh47xWb7u4pJT1S0m89vaCIqmSvfsgZFrQ8tA9c8CZzdF3urI4rvacliif4Vu4bkULAEq2abMSPD4FA4kEpeqUv1nN0jxQm7IViPYCoTOuLTssd0DdigJ45K1qUKGXI6VHECnDqqyDaYzSmB1DD7mzPbyJmBBUvdho83QIwGoqhoymSc4TwM6ckAcu4b2KboPoNWIhPijahbnUgYwxCr+d2pkquGc3JQqBtMPig1QS8TnBACFlSUjQH9dubK3ylLszSdBrXwvt8+0a8HDds=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3070116C95EF6542B26EB3ACB26D6B6A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a0a98f-ac7e-4f35-e870-08d7196245f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 05:03:36.8614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonro@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2019 at 09:50:50PM -0700, Randy Dunlap wrote:
> On 4/2/19 7:38 PM, Randy Dunlap wrote:
> > On 2/28/19 1:03 AM, kbuild test robot wrote:
> >> Hi Jason,
> >>
> >> FYI, the error/warning still remains.
> >>
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git master
> >> head:   7d762d69145a54d169f58e56d6dac57a5508debc
> >> commit: 3a6532c9af1a7836da2d597f1aaca73cb16c3b97 RDMA/uverbs: Use uver=
bs_attr_bundle to pass udata for write
> >> date:   3 months ago
> >> config: microblaze-allyesconfig (attached as .config)
> >> compiler: microblaze-linux-gcc (GCC) 8.2.0
> >> reproduce:
> >>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/=
sbin/make.cross -O ~/bin/make.cross
> >>         chmod +x ~/bin/make.cross
> >>         git checkout 3a6532c9af1a7836da2d597f1aaca73cb16c3b97
> >>         # save the attached .config to linux build tree
> >>         GCC_VERSION=3D8.2.0 make.cross ARCH=3Dmicroblaze
> >>
> >> All errors (new ones prefixed by >>):
> >>
> >>    `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hd=
lc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> >>    `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hd=
lc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> >>    drivers/infiniband/core/uverbs_main.o: In function `ib_uverbs_write=
':
> >>>> drivers/infiniband/core/.tmp_gl_uverbs_main.o:(.text+0x13a4): undefi=
ned reference to `__user_bad'
> >>    drivers/android/binder.o: In function `binder_thread_write':
> >>    drivers/android/.tmp_gl_binder.o:(.text+0xda6c): undefined referenc=
e to `__user_bad'
> >>    drivers/android/.tmp_gl_binder.o:(.text+0xda98): undefined referenc=
e to `__user_bad'
> >>    drivers/android/.tmp_gl_binder.o:(.text+0xdf10): undefined referenc=
e to `__user_bad'
> >>    drivers/android/.tmp_gl_binder.o:(.text+0xe498): undefined referenc=
e to `__user_bad'
> >>    drivers/android/binder.o:drivers/android/.tmp_gl_binder.o:(.text+0x=
ea78): more undefined references to `__user_bad' follow
> >>
> >> ---
> >> 0-DAY kernel test infrastructure                Open Source Technology=
 Center
> >> https://lists.01.org/pipermail/kbuild-all                   Intel Corp=
oration
> >
> > Hi Michal,
> >
> > Would you comment on this, please?
>
> [crickets]
>
> > Jason has said more than once that these build errors are because
> > arch/microblaze does not support get_user() of size 8 (bytes),
> > although it does support a put_user() of size 8.
> >
> >
> > See a previous report & comment at
> > https://lore.kernel.org/lkml/20190101200742.GA5757@mellanox.com/
> >
> >
> > thanks.
>
> I currently don't have a cross-build environment set up, so I haven't
> built this yet, but a patch like this might fix this nagging issue.
>
> (It's clearly not high priority since arch/microblaze/ mostly seems to be
> not well-maintained.)

It seems reasonable, drivers/infiniband/* never worked and will work on
that architecture.

Thanks
