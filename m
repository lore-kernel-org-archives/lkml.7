Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669B1C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3690920449
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="o6cYn6r4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfGIHSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:18:05 -0400
Received: from mail-eopbgr130058.outbound.protection.outlook.com ([40.107.13.58]:30885
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbfGIHSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hh7f2xuBCq6LCA7GPS9lDU5enW4MCikBRHX7iiw8Tmo=;
 b=o6cYn6r4yeH5+ZbrZRkNgGaMlQ7wMZxQglREemX7/gEJ7aOtTP1/PbZKaQZawiatJhitEPG07ZSNI4Kx6VNAbpVnTmbY0k5pJAbztiLzKC4Gx4CWOKrHY1dFyZb/dhxnlkfqixkh7ScRdG9KKDTI3dfJIrN8/elCzLbTDILBmqw=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3187.eurprd05.prod.outlook.com (10.171.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.20; Tue, 9 Jul 2019 07:18:01 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::ecbf:4002:63f2:43fb]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::ecbf:4002:63f2:43fb%6]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 07:18:01 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Mark Zhang <markz@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        asahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: linux-next: build failure after merge of the rdma tree
Thread-Topic: linux-next: build failure after merge of the rdma tree
Thread-Index: AQHVNgam1ySKRGHBz0+LGfGH8/fuJ6bB3PCAgAAD4QA=
Date:   Tue, 9 Jul 2019 07:18:00 +0000
Message-ID: <20190709071758.GI7034@mtr-leonro.mtl.com>
References: <20190709133019.25a8cd27@canb.auug.org.au>
 <ba1dd3e2-3091-816c-c308-2f9dd4385596@mellanox.com>
In-Reply-To: <ba1dd3e2-3091-816c-c308-2f9dd4385596@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P192CA0038.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::15) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 395f6e05-f550-442e-c531-08d7043d935e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3187;
x-ms-traffictypediagnostic: AM4PR05MB3187:
x-microsoft-antispam-prvs: <AM4PR05MB3187BDFDD56D863AF685654EB0F10@AM4PR05MB3187.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(53754006)(199004)(189003)(7736002)(446003)(11346002)(25786009)(476003)(486006)(66066001)(229853002)(33656002)(6512007)(6436002)(2906002)(478600001)(305945005)(14454004)(9686003)(6246003)(6116002)(256004)(3846002)(53936002)(8936002)(8676002)(81156014)(81166006)(6486002)(110136005)(316002)(86362001)(102836004)(186003)(5660300002)(26005)(52116002)(386003)(6506007)(53546011)(66476007)(73956011)(68736007)(6636002)(71190400001)(71200400001)(64756008)(66446008)(99286004)(66946007)(54906003)(1076003)(4326008)(66556008)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3187;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XtTIq1gO6+tGVjXNxuuKWIxrj4+/w4Sy46dFSy1GoyhHhne2oIryD5G3ksUUjQ13fjUS470m2IJo6M1iDdo3fXUvECx9fQ4ELzG+Kh1KiPzyew61B2q3WXOjdbWC5A44bwRk/1AXodQtO8g6fAAbpB+k9uPmn5t01fM2guC8lSdRkLUcDtzy2J9aAFPuGa7vs+tS3Fmn/lRydlW21kZjLX7UjMtYs40A2FRM3EMk9UGmDK5sb9I6dH05gcm/M6bwUjpHwziA8JWbXuTu9QOJccIxk64mxZJi9o/Ti+EFKvQ3AwJa9h/oXJr4Xx3dUaTAe0d1iov7e7pD6ZSortp0aeR62P5pO6PVEbknnWT1oAaROmx63K/Au0PevQf9j/J/MbH+ppXeCf66Jd+NTTYMWfMbR8LzFog7YOPEEtcA6Zs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C282D81B6A7AD645ACA31ABE72CEF461@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395f6e05-f550-442e-c531-08d7043d935e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 07:18:00.9521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonro@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 10:04:16AM +0300, Mark Zhang wrote:
> Hi Stephen,

Stephen,

For some reason, I wasn't in initial email report, can you please check why=
?

I need to be aware of any issues related to patches with my name on it
for tracking and improving internal submission flows/checks.

>
> Can you please try the patch below, thank you.

Jason, Doug,

Can you please take this patch?

Thanks

>
> net/mlx5: Remove include ib_verbs.h in rdma_counter.h
>
> rdma_counter.h include ib_verbs.h which in turn needs rdma_port_counter
> from rdma_counter.h, but it is not defined yet.
>
> Fixes: 413d3347503b ("RDMA/counter: Add set/clear per-port auto mode
> support")
> Signed-off-by: Mark Zhang <markz@mellanox.com>
>
> diff --git a/include/rdma/rdma_counter.h b/include/rdma/rdma_counter.h
> index 68827700ba95..eb99856e8b30 100644
> --- a/include/rdma/rdma_counter.h
> +++ b/include/rdma/rdma_counter.h
> @@ -9,10 +9,10 @@
>   #include <linux/mutex.h>
>   #include <linux/pid_namespace.h>
>
> -#include <rdma/ib_verbs.h>
>   #include <rdma/restrack.h>
>   #include <rdma/rdma_netlink.h>
>
> +struct ib_device;
>   struct ib_qp;
>
>   struct auto_mode_param {
>
> On 7/9/2019 11:30 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the rdma tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > In file included from /home/sfr/next/next/include/rdma/rdma_counter.h:1=
2,
> >                   from <command-line>:
> > /home/sfr/next/next/include/rdma/ib_verbs.h:2126:27: error: field 'port=
_counter' has incomplete type
> >    struct rdma_port_counter port_counter;
> >                             ^~~~~~~~~~~~
> >
> > Caused by commit
> >
> >    413d3347503b ("RDMA/counter: Add set/clear per-port auto mode suppor=
t")
> >
> > rdma_counter.h include ib_verbs.h which in turn needs rdma_port_counter
> > from rdma_counter.h, but it is not defined yet :-(
> >
> > I have applied the following patch for today.
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Tue, 9 Jul 2019 13:17:49 +1000
> > Subject: [PATCH] RDMA: don't try to build rdma_counter.h for now
> >
> > rdma_counter.h include ib_verbs.h which in turn needs rdma_port_counter
> > from rdma_counter.h, but it is not defined yet :-(
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >   include/Kbuild | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/include/Kbuild b/include/Kbuild
> > index 78434c59701f..8dab85cdf4f4 100644
> > --- a/include/Kbuild
> > +++ b/include/Kbuild
> > @@ -939,6 +939,7 @@ header-test-			+=3D rdma/ib.h
> >   header-test-			+=3D rdma/iw_portmap.h
> >   header-test-			+=3D rdma/opa_port_info.h
> >   header-test-			+=3D rdma/rdmavt_cq.h
> > +header-test-			+=3D rdma/rdma_counter.h
> >   header-test-			+=3D rdma/restrack.h
> >   header-test-			+=3D rdma/signature.h
> >   header-test-			+=3D rdma/tid_rdma_defs.h
> >
>
