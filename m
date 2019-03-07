Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36944C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E405920840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="xx2+9yGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfCGRgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:36:52 -0500
Received: from mail-eopbgr40052.outbound.protection.outlook.com ([40.107.4.52]:15155
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfCGRgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVGg3+/FHjDPA6iAriMZEOu+1BiNvZZMELDbmda7eHY=;
 b=xx2+9yGU5b4M6kXXLJ9irjj7fDoXTvhGXjj3CklbTvaak4yoId9tk5/NkNVToeZZBg8eOcqsqFCrrB30dbRnYSifbQvHgb77R31aJYcDDg4UDgwMlBXSjn+hMpqLVTj4oRzNtZzGXTHMsrMW/eG/y06f67dseTojMiOo4b3OLRI=
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com (10.172.226.9) by
 DB6PR0501MB2439.eurprd05.prod.outlook.com (10.168.73.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Thu, 7 Mar 2019 17:36:44 +0000
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2]) by DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2%9]) with mapi id 15.20.1686.016; Thu, 7 Mar 2019
 17:36:44 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
Thread-Topic: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
Thread-Index: AQHU1IFjo1AIqyRPikaxzNyP0OOhK6X/X/kAgAAN6YCAAFa0AIAAfZIAgAAM+QCAABRDgIAAArIAgAAC1wCAAAa1AA==
Date:   Thu, 7 Mar 2019 17:36:44 +0000
Message-ID: <20190307173640.GB32625@mtr-leonro.mtl.com>
References: <20190307010153.81157-1-bvanassche@acm.org>
 <20190307012417.GU1758@mellanox.com>
 <8a5bd9ae-ebfe-687c-2868-d0f2a610d1e0@acm.org>
 <20190307072428.GJ1789@mtr-leonro.mtl.com>
 <4d90c392-5b6a-fea0-e6cf-c49ac19fdf30@acm.org>
 <20190307154020.GN1789@mtr-leonro.mtl.com>
 <CAGXu5jLBPpKOT-NV1P0nuFeSQYfoNY_8B0V4gcQg18xHPUVbhQ@mail.gmail.com>
 <20190307170230.GR1789@mtr-leonro.mtl.com>
 <CAGXu5jJDmEFA7=WuDnr0U6t9BTDFtd_WsB5HeryNKoZSaBW8oA@mail.gmail.com>
In-Reply-To: <CAGXu5jJDmEFA7=WuDnr0U6t9BTDFtd_WsB5HeryNKoZSaBW8oA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P195CA0056.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::33) To DB6PR0501MB2694.eurprd05.prod.outlook.com
 (2603:10a6:4:82::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.138.135.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc1d1202-0641-498d-60ae-08d6a323774b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(49563074)(7193020);SRVR:DB6PR0501MB2439;
x-ms-traffictypediagnostic: DB6PR0501MB2439:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DB6PR0501MB2439;23:iJ/ZrvYHGBZ7xoBPkTFt3Ax8ZjIflUonvDht99O?=
 =?us-ascii?Q?z8hYn8153NgvMtPlqEV32XVYIvJCd8GEWE1tDOfleIsHQsdYVHbNWg0hANdr?=
 =?us-ascii?Q?uC6eTPgaW/WTwYzLaNX+962uV4pjqgP5y/ezZuFTszcdKl5N5Yfgu8Svcagf?=
 =?us-ascii?Q?mg2MwH9Cbpv6eTQxqvrgIzKuzVw794X0KjCiH+VD55mnwhyzVjXNg5V1Llt0?=
 =?us-ascii?Q?z3fgXjOZrY8hA41G6Owr3LVaOaKFRDua0VOmvkfLpBOkohWxpoO/8IwSIiq5?=
 =?us-ascii?Q?4KAOa84GuCA/uz7wGYoAUMtE2K0XHHB1NCK0Rq1f5thu4bUtW/zRW5LslBoA?=
 =?us-ascii?Q?W62iDTuMTlZP+2cl747i2NbpYj+bP6VQiwiWvRRgoxG/je6cDpLBPRZO4cJn?=
 =?us-ascii?Q?VR/8fTtb0M1/CglKHafe1MuTvpIGJ+ABNYTdi7uTpphmjxPrEyAnmOjFeZrB?=
 =?us-ascii?Q?mxYkYibCuvYAfeDALq056wjT8W3rJyVwvrpGnP3TSxvn+SCH1pMCAD06nqZj?=
 =?us-ascii?Q?l4cCrz1ac/Veijj9ZIeo8ejr8wOsQn9q96QJ3Rq2UFmWd207LT2ALgDmp4va?=
 =?us-ascii?Q?8iUdNom5AKP0n81laRAbVohR42Weu0pvZt1PgYJI2HWMohM746wJ0NJUG9sm?=
 =?us-ascii?Q?NcPGT6AaMvwuvnZd0TtRKEkPuRMpn/fKfRJUgzn/j/EMBNiyJHwE4i3h3akL?=
 =?us-ascii?Q?NZPShj4AwbuONxp+lAZHYY5A2eFroyZOuZQCs/ZeU6wyWkv8VLHubsyZTB0p?=
 =?us-ascii?Q?YCZF8g9c9sncw49QsYA9uc4Ga4NQFucfBwVSF+jtDBrLa7lYIkVbXru3+urK?=
 =?us-ascii?Q?ALPXtTsYmSO0u+mBvYZx/jS5pATFvNN7eJvSDuDr9Q5Z64VeyG8mP2GUzISu?=
 =?us-ascii?Q?2aAHc6aFw6Z80dSQ03FEgZSp4Yp4h7ekAkB+LfbJXVKC73xgL8CpAn9ZFcDb?=
 =?us-ascii?Q?Sg2OjGSHyfyHXNJKX4z3huh9Zm1H6jfDVZ+EWuyiepwYgTvUUmrZB10X+q5P?=
 =?us-ascii?Q?+QK50mORxof2apWtlyOE9mF05VAenC94r+NlIN7l8Eu83zVqXu2UxWuR1oH2?=
 =?us-ascii?Q?AyQzW6rUsoPsEVpSpaAGZCP79n2O2ySuIGXqbcvBgmXNT/PrZuYM6JpwY5Vl?=
 =?us-ascii?Q?lCe51kAXY+YX8gIVXss3eOr6WOGQSnXvWqLCWCOhPACOa/4pdG+N6Xw1vndn?=
 =?us-ascii?Q?kBFvuJ0+Bnk/uNdedPhOYHK2RrLSobHA9qj2eJswWJGsy2lJVVfQu4EmqGDS?=
 =?us-ascii?Q?2EcaZZQ8twaUF6sDqMedBzpAmylyPXV3qvLqaxwT9qzI9Gaj8gIB8neIB3oG?=
 =?us-ascii?Q?UmenFaXW2J38ie7s0T4s976hJNmXAK9aic3Iz4DojHq3CjYF6j19Ws+fI7B/?=
 =?us-ascii?Q?fsWxK3g=3D=3D?=
x-microsoft-antispam-prvs: <DB6PR0501MB2439CE6563D8AA67660A6BCFB04C0@DB6PR0501MB2439.eurprd05.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(396003)(136003)(199004)(189003)(6116002)(71190400001)(105586002)(3846002)(86362001)(386003)(4326008)(6486002)(5660300002)(25786009)(229853002)(6436002)(19627235002)(97736004)(66066001)(71200400001)(106356001)(256004)(9686003)(6306002)(1076003)(6512007)(966005)(99286004)(446003)(33656002)(68736007)(6246003)(99936001)(14454004)(76176011)(305945005)(102836004)(11346002)(476003)(478600001)(186003)(2906002)(54906003)(93886005)(8936002)(316002)(81156014)(81166006)(26005)(8676002)(52116002)(6916009)(6506007)(53546011)(7736002)(53936002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2439;H:DB6PR0501MB2694.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U59FTdOOvTwte7kIBCVO/5jHCQLFIasMp56NOZ0ZJDlcAUEJA35XEgGAubDjYArpDYb5+K/iZGpozo0Gr9gQsyjHlAIZAGKi0Kz7y+JL0Kozps5S674RVsl/5IQJXMVaIKCKK5YmpOcd3F5Hp7ahFdkzN5d53WlxCyalnMRkKsAUr9kEEa9um6z1iFCrYhe82enYU025PSi5zvDMr6cHIWo/Sre+Ye8kSO4Y7LL6OeeXWNK4+/ezDSoaJqmaOXTvwRVwnLX57n8vC+g65FrBsiZKAbV19W0elvOweBhAZlupGUsWmYsXB8euGTI0os7W5hnY3vvvPY/MOLJdHUUG1XNQXbg2xoRJsmxgQLLhUwa6w2mI32eUb0zYUOZ5iN1OeINIIbpZJlB60BzG6oDJZsq/MnKaJNo003jDk+jt05U=
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1d1202-0641-498d-60ae-08d6a323774b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 17:36:44.2927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2439
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 07, 2019 at 09:12:40AM -0800, Kees Cook wrote:
> On Thu, Mar 7, 2019 at 9:02 AM Leon Romanovsky <leonro@mellanox.com> wrote:
> >
> > On Thu, Mar 07, 2019 at 08:52:51AM -0800, Kees Cook wrote:
> > > On Thu, Mar 7, 2019 at 7:40 AM Leon Romanovsky <leonro@mellanox.com> wrote:
> > > >
> > > > On Thu, Mar 07, 2019 at 06:53:54AM -0800, Bart Van Assche wrote:
> > > > > On 3/6/19 11:24 PM, Leon Romanovsky wrote:
> > > > > > My simple patch passes too :).
> > > > >
> > > > > Can you repost your patch?
> > > >
> > > > https://patchwork.kernel.org/patch/10841079/
> > > >
> > > > As Rasmus wrote, the thing is to avoid a < 0 check. In my patch,
> > > > I converted a <= 0 to !(a > 0 || a == 0) expression.
> > >
> > > I'd be happy either way. Is there a larger benefit to having a safe
> > > "is_non_negative()" helper, or should we go with the minimal change to
> > > the shl macro?
> >
> > I personally prefer simplest possible solution.
>
> Acked-by: Kees Cook <keescook@chromium.org>

Thanks

>
> Can this go via the rdma tree?

I think so, Jason advertised that we will have second PR to Linus
this merge window.

Thanks

>
> -Kees
>
> >
> > >
> > > -Kees
> > >
> > > --
> > > Kees Cook
> > -----BEGIN PGP SIGNATURE-----
> >
> > iQIcBAEBAgAGBQJcgU6mAAoJEORje4g2clinE94P/0pHFmUgwzRrVLxjqmnynNPC
> > e+azQISKrZ4EBI5Is7VwFJuxtiZvsTveCxX0NpRxk3TLfHbA4V9jz4meJ6smp4UQ
> > Z1uRnPbj2z5iucFN/8SelQvNTmqfvbuRSKpZ08XLxBB4XIAjFaNBbmD+REe7iSGD
> > xiYNp96oHvKnzGZq/eViqz0rogewsTLHoEBwDkfgyDIqwO0/3qVElNhW7Z6g/v/7
> > 2D4yZiB82wIBf+00taEQNnpI/3naVvqdfl34iYGuq51Fd2S36lfmMZ1DUffd/Eq+
> > jRq8PiNisFK+0A/96hwi2npVN0LS4tA5at6PHhqOfVxMOt/XAmeKu3cCaxHhjbfb
> > Oi2+X9/EBDdgVmylssQFwjNaLuXB00109IVDcQGgzTsN8xoTNiwla8gt3fVhDWt+
> > X0jQuSnqtANt75/0mucirBoUppCB59aZ9ygolWe4UwBpVV0ZGH/0MFwcOhlpglGB
> > PbrKaTxP3qQeil8wGXQsJyPGOCLBGh1Qj0C6NG1wsJSX/Zq8awEoz+JlYCXezaq6
> > 4R0jSHu50BGp7gt5iePRGeUhjPFVGHucJZ2b6fuDZ3ARN8MtQYmrYDyRqnFJZsCE
> > UZFd4SZ8UzfIETd17IowOmOs62HwXyIi1WzoWjiHsNjH2dxwiB6Lh1JBvAFQgzJ1
> > 0wRa0DMnyLzmIoOdyvQm
> > =NFtk
> > -----END PGP SIGNATURE-----
>
>
>
> --
> Kees Cook

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcgVaoAAoJEORje4g2clin1mkP/jb8KmYOHBicEmayoFE3mCoW
tQyvyXfGZNoFcZ0dl8dpuS7cgKG/TIMMjf+syUer1IOzBsBL0OriQHb2p65Xbn0a
i/b+leVAcGe4b6AQCCLgbuDk/lpEvNLW8H3jA3PU5SESa+tdnTowWUJmrm3geyLw
4XPvYzI9wxToDwlUci6vEnqicv0Y8P5tjQ7Incj+J8lrf69snFvoZwpDuaHO4iE0
uDidfdmAVplIhOHpsHCUlJzwRITNLhRlCqPQRSE/+RXDG8mZRVWK8+WD8JwCl3V4
hPA26izmBcJ8buIHL2zhRnB78Zro8Bv0jG23Mz5DtLtLSoBTWGmZ8oQHqavgv5Hw
jYZK7g8N6eKCe4Jf6JfjIFxtIHx+rjGjr4/i7YI3hOo3ohJ6x1Sem2p9oScXB/6j
ajQErde2zOX5hW0uyPwTFVp306K5oqJqemfK6dxD6Xzdir592hzfNYj3o6+bNNeM
Elz5nl6q7JVuMQsKm5wZk4AVGiazR94M7PnxBplO65zO6LCm+qVKMGHZr3VGI5A1
8Q7hFJf2Zz/V0P78lRzJOrH/C8QrIvK45sFhcHCSVnK88wq3CR+97uQRc+VsN6nj
SAi/NCLpM/SSa1078KP2XLnVnoxIvRGQR3YryTyhzfAPJhCCVDRGD0EWfrR4EZKv
thuY4wOJ0b+vviJE3QCp
=xnKU
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
