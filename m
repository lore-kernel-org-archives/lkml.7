Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28779C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58F8214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="sJfi0+/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKLGf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 01:35:57 -0500
Received: from mail-eopbgr720088.outbound.protection.outlook.com ([40.107.72.88]:22848
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbfKLGf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 01:35:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnNAm/MzfD6sCItduLTYWWUbnUlqu2Sc3C0TXHhJ+/erTKD/HvRYFFTHL9IH6vWlu1lNtryXsXBNQ0vH1kaOwbdnYF6maNlwWb8ejGe75emKJ5IH5n46zhxs94jEVQ60FtIInnb+IKHOKtFCMKLO2fvSN8q9s+RwoGjyw9X33x1EWW5Yw9Q5cmrN8tMfQu7v8juhfcsaCK9I8flpfeJ87z/ii9Pg8IPNe45MTkM/xyZsEJEpkAWWW+vEQMyfwLdcAdUNaDlBkEYhFUDInc1Gmz2QGpyAH0tQXmN9vRf8L/cZ0l0sR/rJSSIntGs+m0al2qZ3QzB9LkbQiKmtRl83oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4H7mWmhXcLmuKMhLft1V8nYFwf0F9QHRGgszosaV614=;
 b=BZsnSRtve2tmp8i2Jc+F8tpbkmnBVFCkbQgfhDP8RAVyN56ulyoEm9jzk3PieVp6KmHXIrlP4QMdThW2vVdx4k03uf1Sa0cH+/t1W9D6POY5eaqxrdaOqhtAoWCAJe9O09eRUqTu7MpChSr1YURGN6QQsfDo/4FmPBw3IegPwnUxtKBJQWX0KsFFa6tphlIVzL8KIy6oUKjy5UWMr4dpAo1kw+jccEJtsjiZ8n6LJSyC/ghD/cF6a0tf+8QO3qwrS3MS2Nkr2ob9KMD04ZX6PcN/47eiy8KmZQcjaTCvyDsdosBGemwrju5Fa2VxBzfCvooyBA8rFojtgowejWcQgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4H7mWmhXcLmuKMhLft1V8nYFwf0F9QHRGgszosaV614=;
 b=sJfi0+/EbSEAwS6n6aISSLx8KCLhGXGfnx1DWI9l6FBW/LEeu21qFqPXW7fZE+yq9OZjhgpom1hXFIJLHSvovo3mQXb6VAC5f7/GDN+dCHbudlM0LrTEyT4HhVEJubATvZ+cT/vr7DfKpWMA01FGiW1sd16DTA88R8PeTF3hYRw=
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3415.namprd13.prod.outlook.com (52.132.246.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.19; Tue, 12 Nov 2019 06:35:53 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::853e:1256:311e:d29]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::853e:1256:311e:d29%7]) with mapi id 15.20.2451.018; Tue, 12 Nov 2019
 06:35:53 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Subject: RE: [PATCH] RISC-V: Add address map dumper
Thread-Topic: [PATCH] RISC-V: Add address map dumper
Thread-Index: AQHVmFCzGZwFnAd1O0S/YrXUtDW+c6eGhTMAgACQvpA=
Date:   Tue, 12 Nov 2019 06:35:53 +0000
Message-ID: <CH2PR13MB33685CE31DF9AD8C32EB818D8C770@CH2PR13MB3368.namprd13.prod.outlook.com>
References: <1573450015-16475-1-git-send-email-yash.shah@sifive.com>
 <20191111215647.GB10647@linux.ibm.com>
In-Reply-To: <20191111215647.GB10647@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
x-originating-ip: [114.143.65.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86b56a69-d0b7-491f-eb9b-08d7673a9139
x-ms-traffictypediagnostic: CH2PR13MB3415:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR13MB3415E82B786285FEC4D9E4DA8C770@CH2PR13MB3415.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39850400004)(136003)(366004)(396003)(13464003)(189003)(199004)(66946007)(186003)(76116006)(66556008)(64756008)(4326008)(66066001)(478600001)(6436002)(66476007)(486006)(25786009)(7416002)(256004)(8936002)(305945005)(26005)(2906002)(7736002)(66446008)(9686003)(81166006)(81156014)(8676002)(74316002)(446003)(102836004)(5660300002)(14454004)(11346002)(6916009)(86362001)(52536014)(76176011)(316002)(44832011)(229853002)(55016002)(7696005)(71190400001)(71200400001)(99286004)(476003)(6506007)(6246003)(54906003)(53546011)(3846002)(6116002)(107886003)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3415;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l5zL+13uN9NSgU3WEsBJ5tGHq3GtP4BEePE1qwM2uRfbel4J0HySfZoy5MkMMj+9t9IsKQl4oYc02Tmqh8ZSfvZOFYxssAGlMu92DyeeqxWI5UK6bo0kJS4ETHwjHbboj3XZ5ToKh34WHKvFyCWKgXLE98omYqpbFbyYiz3v1m1zySoHlrn616gQ9pQCbsDgQzS4vb9NuwEHaMHZL6ruLSv5aRa+HVop9Tnyk58fXpBwg5WxUmmrRFco9S0SmvrxxHvJDjr0Q4F2QCUw9TqKXiH01q6g3g/+N1oazG/5wvIcBMNffN840r3bid2eHBYBV+EJGzGFx1i+XUAINaZqavPw9b5EOE+7jM5mJmIQcUCKgOpF4M9CXEkIkOFcEPfg/h3Sc7tWphMDICIbzNmdo59xa+K8ikpd/m6dqFXyDCTJ63D5np8fmFjQKmRuY1Bt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b56a69-d0b7-491f-eb9b-08d7673a9139
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 06:35:53.5562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ka1j7rOxZwZvBKpwS/sddh3l1wc9IPDfgKh99p0/c2EL/iL3KvqK68rHyLAh1cFIIX/5InHetaiZZN7KEiNI2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3415
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mike Rapoport <rppt@linux.ibm.com>
> Sent: 12 November 2019 03:27
> To: Yash Shah <yash.shah@sifive.com>
> Cc: Paul Walmsley ( Sifive) <paul.walmsley@sifive.com>; linux-
> riscv@lists.infradead.org; linux-kernel@vger.kernel.org;
> palmer@dabbelt.com; aou@eecs.berkeley.edu; Anup.Patel@wdc.com;
> logang@deltatee.com; ren_guo@c-sky.com; bmeng.cn@gmail.com;
> tglx@linutronix.de; Sachin Ghadi <sachin.ghadi@sifive.com>
> Subject: Re: [PATCH] RISC-V: Add address map dumper
>=20
> Hi,
>=20
> On Mon, Nov 11, 2019 at 05:27:25AM +0000, Yash Shah wrote:
> > Add support for dumping the kernel address space layout to the console.
> > User can enable CONFIG_DEBUG_VM_LAYOUT to dump the virtual
> memory
> > region into dmesg buffer during boot-up.
> >
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> > This patch is based on Linux 5.4-rc6 and tested on SiFive HiFive
> > Unleashed board.
> > ---
> >  arch/riscv/Kconfig.debug |  9 +++++++++
> >  arch/riscv/mm/init.c     | 30 ++++++++++++++++++++++++++++++
> >  2 files changed, 39 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig.debug b/arch/riscv/Kconfig.debug index
> > e69de29..cdedfd3 100644
> > --- a/arch/riscv/Kconfig.debug
> > +++ b/arch/riscv/Kconfig.debug
> > @@ -0,0 +1,9 @@
> > +config DEBUG_VM_LAYOUT
>=20
> I believe this could be enabled when CONFIG_DEBUG_VM=3Dy without adding
> yet another architecture specific Kconfig option.

Oh yes, I will drop the newly added kconfig option in v2.

> --
> Sincerely yours,
> Mike.

Thanks for your comment!

- Yash

