Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C489C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E5B20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="PWEH60ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfCGHYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 02:24:42 -0500
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]:42371
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725554AbfCGHYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 02:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaLlFCw1aXW6OueH6CNdpyuVCI4fOo7ncGdlPUaJ/6k=;
 b=PWEH60eekufHfemMlomQk+w/0rmBm5CVbfX10Rm7c0udTY04jvSejSmBd7biRTmle5shLJjICIE5fvD1jJ0UqyINWamcw1LXKFpd4izYz8MbDNTTebZUN4DrP3AcwsB/k4S5WN0ZuXqofzkLQXyu+n2pIUGn9uYyrKNqrd4zRn4=
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com (10.172.226.9) by
 DB6PR0501MB2197.eurprd05.prod.outlook.com (10.168.58.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Thu, 7 Mar 2019 07:24:32 +0000
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2]) by DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2%9]) with mapi id 15.20.1686.016; Thu, 7 Mar 2019
 07:24:32 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
Thread-Topic: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
Thread-Index: AQHU1IFjo1AIqyRPikaxzNyP0OOhK6X/X/kAgAAN6YCAAFa0AA==
Date:   Thu, 7 Mar 2019 07:24:32 +0000
Message-ID: <20190307072428.GJ1789@mtr-leonro.mtl.com>
References: <20190307010153.81157-1-bvanassche@acm.org>
 <20190307012417.GU1758@mellanox.com>
 <8a5bd9ae-ebfe-687c-2868-d0f2a610d1e0@acm.org>
In-Reply-To: <8a5bd9ae-ebfe-687c-2868-d0f2a610d1e0@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR08CA0037.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::25) To DB6PR0501MB2694.eurprd05.prod.outlook.com
 (2603:10a6:4:82::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ad14c58-e1c0-4b0c-a165-08d6a2cdf0e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(49563074)(7193020);SRVR:DB6PR0501MB2197;
x-ms-traffictypediagnostic: DB6PR0501MB2197:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DB6PR0501MB2197;23:ovM4hYmexmIgi5TlVkHesC6UTr0I7KW+epVzzuz?=
 =?us-ascii?Q?nl1zQBt7wNdT5CsIF9X0gjfpPxw7VizJHvf8LQeCTz+fz+rz00xnfpsijlJF?=
 =?us-ascii?Q?KtScbxU6zZGd5ihw6z6Ma99PdFKxY2FQ0J+xKmDCWY+v4qmhBznAPkxqxcNP?=
 =?us-ascii?Q?LmehuiUvLjnpR88nsUu46l1i7orQc3YxdE4tPhVbh6FAVknOKfdoIY0UOrue?=
 =?us-ascii?Q?lE5ULA83XSWSfFi1DyKESQpnAK9iIvc8en7IfblV7IY6M0UNEXzd5tzRIqvT?=
 =?us-ascii?Q?eqb9Pxvq0fS5vW48aQ1qrUGXtrCg9wo+FA5WsvK7t3hvnAsVSq0P3WMLK+1q?=
 =?us-ascii?Q?6N0spbN94Ke7QKI46lVy4kV7o94beA8PZHg0cGDL4j76YDbwK7yMgG1OYrUq?=
 =?us-ascii?Q?ggg1m/zA7Z2PBHPKF9AWbZa2XZ0CndWpQUbTTip/rDg0kD20bnrISL4Te5X8?=
 =?us-ascii?Q?BNNR4qp3ZBKdbJ7jT7XsBLjnDrCaCmFpvNvQI758KHpm+9YpFvvOxD81Ryk4?=
 =?us-ascii?Q?3L5sUXU276X/0OPXhrm3U9w46A+BoM7L1fo8f8lv0AiQzqpHrEpeCpIXqdZu?=
 =?us-ascii?Q?ALTi7ktwszBIqhGiSXEflUYzLb9AQopcmB+s38OnTda9VLzmqgcQBVfeQ4Pd?=
 =?us-ascii?Q?1JbAWWqtDWR9Vdz9ZyRuiv7I0QBug9ZJsyHvLOp8AxN7Kd1dhSumlerlH/Qm?=
 =?us-ascii?Q?Ke37oDoKDSpJ4rcP4ZR9CqnJj4B46KkENqDoA53T629tKOJHtKlOt+sFbdbI?=
 =?us-ascii?Q?HYAyM6ymSX2grt8n8rwM0nF0OXDV7WDt4LmDDoognifMWxNVtVoWt+C9PA2C?=
 =?us-ascii?Q?fiIqgwDou+kY087LyLBhIDuSiXiRmXM39zyaNKxZyzO8oSfI3BTzgNQeN9VS?=
 =?us-ascii?Q?8W3ksN9C1kUPGaM4O/3DSAhtkpTYUFArKfxpVkk7WxGn2tYnU8G49WaL0THW?=
 =?us-ascii?Q?fGwdYlSceQlSB12QgjpffyRByml5k7D2rggw3hNu5F5nOBCI91TXDEo5mX4V?=
 =?us-ascii?Q?KDjE2JbsWbM0VQMWaamIvFobd7EP75y4NJIpotXuvJsABN2U8k2vX2wi+cVf?=
 =?us-ascii?Q?CJYhB6dvm0IBhx+orMyIQ9lGHTX2zcEc3zwb0b6FMOInd0pgVGnCHAZrv30A?=
 =?us-ascii?Q?4AwFePyuPASTE6lZjQFoa1fiXZoc0V2OtXXstItD8iLjzUfd5nzw9lL769fK?=
 =?us-ascii?Q?xaJSKB4HN6R5wAup9wNOqrXl4TYbrB4u/WjiL5SWODovL8tSGYwvHyQdDIhX?=
 =?us-ascii?Q?iQ258xu/5RqFssaHooyviCnU2XGoKHGYAFEtpc+1UadOXGPhc5cNhYDfNerN?=
 =?us-ascii?Q?x0A=3D=3D?=
x-microsoft-antispam-prvs: <DB6PR0501MB2197E94EBD231D510196D876B04C0@DB6PR0501MB2197.eurprd05.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(478600001)(66066001)(14454004)(14444005)(305945005)(256004)(7736002)(8676002)(11346002)(97736004)(476003)(486006)(229853002)(106356001)(105586002)(81166006)(81156014)(446003)(99936001)(1076003)(3846002)(2906002)(54906003)(6116002)(53936002)(6436002)(6512007)(6246003)(99286004)(6486002)(316002)(68736007)(102836004)(86362001)(4326008)(6916009)(25786009)(71200400001)(71190400001)(53546011)(6506007)(5660300002)(33656002)(76176011)(8936002)(26005)(386003)(186003)(9686003)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2197;H:DB6PR0501MB2694.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a7v8X8CUcE9JnMLJYlwJwG+vQnG3OHDMY5GNwxOE42ednLR04uov2BjOA/RBNFoPpXQElnLFFJLLdn02cUjcEh+hvXv9NuRj2rwliJCN0LqZr5uFgm/TaQ38VefP2eY0jHA0H70TGcivL4W/oI3GlVeGjEtB7rxtMBVyXDaXmxHx1BxUxCDWVXMfAu3LDEates8/UlTf231BNk1rJ5irMNm7HUUDuRQyNlPZINlNfLxvEM4Zep+wxfo6pQZdxPGHjfTkpgXIGjoqPiFNnLz3GiFVK+6Ry2RF5wML5d5F6exeI1O7NOlAJtHl1YmBLW9MWobOiTZCpqwGQwj+Iwq3Ty7VLzJs6C/QItoNdZaaGpK9vDkkiicaoUVeyB9O2yEff/v2+4CTRcOBPRuCAl9TFSkrz1VfhrVHn2+6v33ZURs=
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JbKQpFqZXJ2T76Sg"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad14c58-e1c0-4b0c-a165-08d6a2cdf0e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 07:24:32.1110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 06, 2019 at 06:14:09PM -0800, Bart Van Assche wrote:
> On 3/6/19 5:24 PM, Jason Gunthorpe wrote:
> > On Wed, Mar 06, 2019 at 05:01:53PM -0800, Bart Van Assche wrote:
> > > This patch avoids that the following warning is reported when building
> > > the mlx5 driver with W=1:
> > >
> > > drivers/infiniband/hw/mlx5/qp.c: In function set_user_rq_size:
> > > ./include/linux/overflow.h:230:6: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
> > >     _s >= 0 && _s < 8 * sizeof(*d) ? _s : 0;  \
> > >        ^
> > > drivers/infiniband/hw/mlx5/qp.c:5820:6: note: in expansion of macro check_shl_overflow
> > >    if (check_shl_overflow(rwq->wqe_count, rwq->wqe_shift, &rwq->buf_size))
> > >        ^~~~~~~~~~~~~~~~~~
> > >
> > > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > > Cc: Leon Romanovsky <leonro@mellanox.com>
> > > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > Fixes: 0c66847793d1 ("overflow.h: Add arithmetic shift helper") # v4.19
> > > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > >   include/linux/overflow.h | 22 ++++++++++++++++++++--
> > >   1 file changed, 20 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > > index 40b48e2133cb..8afe0c0ada6f 100644
> > > +++ b/include/linux/overflow.h
> > > @@ -202,6 +202,24 @@
> > >   #endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
> > > +/*
> > > + * Evaluate a >= 0 without triggering a compiler warning if the type of a
> > > + * is an unsigned type.
> > > + */
> > > +#define is_positive(a) ({					\
> > > +	typeof(a) _minus_one = -1LL;				\
> > > +	typeof((a) + 0U) _sign_mask = _minus_one > 0 ? 0 :	\
> >
> > This is probably just is_signed_type(a)
>
> Hi Jason,
>
> I don't think that gcc accepts something like is_signed_type(typeof(a)) so
> I'm not sure that the is_signed_type() macro is useful in this context.
>
> > > +				1ULL << (8 * sizeof(a) - 1);	\
> > > +								\
> > > +	((a) & _sign_mask) == 0;				\
> > This is the same sort of obfuscation that Leon was building, do you
> > think the & is better than his ==, >  version?
> >
> > Will gcc shortcircuit the warning if we write it as
> >
> > (is_signed_type(a) && a < 0)
> >
> > ?
>
> I have tested this patch. With this patch applied no warnings are reported
> while building the mlx5 driver and the tests in lib/test_overflow.c pass.

Bart,

My simple patch passes too :).

>
> Thanks,
>
> Bart.

--JbKQpFqZXJ2T76Sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcgMcsAAoJEORje4g2clinN7wP/RCNy6kC+EsmjSjuH1eRgAS/
6MX3F0bdMG/G97BeY+gDOlfjQEMKLMmMZAvodKphcxnSkpPX1IZ6qxf8MtysuYxb
fZlihUBQv/yJI3EOO9Up2oF7q0l5uiT96iuEYKDYcP9dgcUn8Kd/gyORjRvWRC4o
pjpLSnRwdXy0h6diibfjbqN/uaXEoEPnC+Ft2QaYYaQl2/V9WtQcJeIY7gYFjYyF
1ZMLlM3IIXr1rHZUl7T7SAYfI76Hv/pUJQQxmut7t8Jz12ThHd6M4+GeDeM0c6F/
UH4969dWytz5mqFILfW43bY1VTivSkwq9YdnqA5PqYBxsrDasdN3UZyePEho8NYt
PYerMfZNL8f7oTL3tpBUr50rlFF/7xEDkm6/0mFHIvvclznwK6Yb4kBwkQptzRLa
D9Fy+Sew+1GKzsakgBcyiN9Vd/tTaMf8gkExXF9GUIo2Ga2gftNoTCdXPoWK+Ajf
pWUKAcwl0LdXsmebcb7xZJsdvYwWgTw33gEYm9Wph/qhZ6KBozvYAQsgnWj5bUIN
8N/qfOIg4/BhVGCPW7jjLn1GdZLub691lm4r1kHHebEmeM1kCH8kagz7ii8tsfwR
Xelr0MWx52aNGzBUQSbStJBto4TvEHCOG2b23VV2tVaoD4f+WE7c6ckAN4aBBcr9
pTOtoYlyIVgELsDZBoIT
=k04u
-----END PGP SIGNATURE-----

--JbKQpFqZXJ2T76Sg--
