Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F5AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AAF20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="xvrHg+wQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCGRDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:03:22 -0500
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:39718
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726166AbfCGRDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7hINFEGLwee94lnHnoOAVXhZqILrUVVrY7RTlu6bJo=;
 b=xvrHg+wQeVngBwAYEU2/sO+I67NUcQ8uGtR9ZOImgb55cfrLOyMcE60q5/AoKYIEULU72KktjzNH7ss4WcGySVLjLAUpjh+BtViUk7qEGsICB0nEAFkxZWG/jO8x3NlUfpsKq7HNwhcjMLsaxr0280jihxn5b0cyvqTlzQ4hHms=
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com (10.172.226.9) by
 DB6PR0501MB2613.eurprd05.prod.outlook.com (10.172.225.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Thu, 7 Mar 2019 17:02:36 +0000
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2]) by DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2%9]) with mapi id 15.20.1686.016; Thu, 7 Mar 2019
 17:02:36 +0000
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
Thread-Index: AQHU1IFjo1AIqyRPikaxzNyP0OOhK6X/X/kAgAAN6YCAAFa0AIAAfZIAgAAM+QCAABRDgIAAArIA
Date:   Thu, 7 Mar 2019 17:02:36 +0000
Message-ID: <20190307170230.GR1789@mtr-leonro.mtl.com>
References: <20190307010153.81157-1-bvanassche@acm.org>
 <20190307012417.GU1758@mellanox.com>
 <8a5bd9ae-ebfe-687c-2868-d0f2a610d1e0@acm.org>
 <20190307072428.GJ1789@mtr-leonro.mtl.com>
 <4d90c392-5b6a-fea0-e6cf-c49ac19fdf30@acm.org>
 <20190307154020.GN1789@mtr-leonro.mtl.com>
 <CAGXu5jLBPpKOT-NV1P0nuFeSQYfoNY_8B0V4gcQg18xHPUVbhQ@mail.gmail.com>
In-Reply-To: <CAGXu5jLBPpKOT-NV1P0nuFeSQYfoNY_8B0V4gcQg18xHPUVbhQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0073.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::14) To DB6PR0501MB2694.eurprd05.prod.outlook.com
 (2603:10a6:4:82::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.138.135.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53c05793-8661-41b1-e565-08d6a31eb27b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(49563074)(7193020);SRVR:DB6PR0501MB2613;
x-ms-traffictypediagnostic: DB6PR0501MB2613:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DB6PR0501MB2613;23:rO6ecNDorXAyxz9gwMVl3IIgNMihqXkQ6Gm6bxk?=
 =?us-ascii?Q?h3pabjXKpwDJ2tX3mhbHN3oJFcepF+h57l4y5SUY6J+5blZhpV+bprxQ3rgC?=
 =?us-ascii?Q?ikwhhmaVDFg7k12fwIRsNZYDzmUxqKMkhZYFGcarDTKkA7ASb3MLM0U9WiDY?=
 =?us-ascii?Q?vOBkVGkqEKcLI2DVyzdr24O/nJTlFIG75ARSwnxJDHJdl/8DW4xu95Ykzv3J?=
 =?us-ascii?Q?RonyVpyn2OEAZVGldlGjdSXgvZ+v15JIuzf5ZqaNQgSrQF2LVoQXwuSASTzz?=
 =?us-ascii?Q?sCghJLaZ/Fqo+nIaOYoYSvxzkbhy+Flsxqrpqn79ACr3ZCx23oBy3im6w2uW?=
 =?us-ascii?Q?NyKfAOFmfVb8LGc6tvEKts/mD1dqf7fJPA+aqaaMe8Gjn1bxiFzK4LVvvSUD?=
 =?us-ascii?Q?lVrlcVh0s4n98P268etmCKjGFq8VPOX79Uopc5yQh1JKRiy1bc9einz4mYDh?=
 =?us-ascii?Q?+gZT3a3ZDxcIYPNW8KjSVlEpuCeKULaYZsEao8klVsewx3bC0s96jUeL5lhL?=
 =?us-ascii?Q?ZK7xhQPEXz44bF7bTsGjI+AZj6VD7w+lLw78qirRnSnhVUOs3cCDwy6hvwiH?=
 =?us-ascii?Q?JtOc4Zle0655FnwHkyCsYSA4IeOtAQMXQa6KC+wqxrPrExm4E8KMc39VwHRs?=
 =?us-ascii?Q?jWAhwQ+O2UMXokLfwJtVTXvm81JByD6xMt0EGpW07/2jGJBFGUuC9LJ1ZzST?=
 =?us-ascii?Q?Zk7IajF4t1t8ztm1t6VCdNa/Spxr5oQy7IL/INH8DBIhoLhDudCctphbrIab?=
 =?us-ascii?Q?As34jJnKSoBFEWIUSW2351UJxegL+xyVE6loqaBZBuRIQwVHW41v05jZyzok?=
 =?us-ascii?Q?rGdT2giYdelHGZNf9nELp2WL7f/K8a0a1LSF7FNrmButPlOFHOp385Hxe8iQ?=
 =?us-ascii?Q?xR+8ilj/tYozYxv2dSKVFtI9JZrqyDf3SjqEqXG45gqukgwBd/r/0spe+GsN?=
 =?us-ascii?Q?qKvSUgD0SPyn/JKx9TAQq5QWdrexcC4+G+8slaoWCtzHf8wkrYlUzGxWdICE?=
 =?us-ascii?Q?M5XDBQZMV61HJ85zRd6RmmfMqXESm6ghcvPjeIbMDI1YakxItt8TgAmV1sRX?=
 =?us-ascii?Q?g6LPcqkXhSsFfVxkH/OYijbGix728uaQVmJr/ibci+EJANZ/pY0Gtxuk9eK9?=
 =?us-ascii?Q?TaZISgkPauHB3kbH/uVftmcNYgEiGWxtByneGlRqZdIMCu64ckq/7XYq7obc?=
 =?us-ascii?Q?VUpi0h+7eqc0w1ShJZF1byve9IWnyahF2ECCcz22GGeFoHB0NXdqjs+AiNMn?=
 =?us-ascii?Q?0PvXplPBEXkm+QiyHikcJZEdHUZLsRktl3SE/a3Zh6LQqCYwO4PvLyrH8/Qy?=
 =?us-ascii?Q?G8BZ9jwueh9yZ6ChHHDSYdiG736uYok2aC2KkfSTynS/S?=
x-microsoft-antispam-prvs: <DB6PR0501MB261347CE3FC9F8597737A259B04C0@DB6PR0501MB2613.eurprd05.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(7736002)(66066001)(33656002)(6916009)(8936002)(11346002)(446003)(476003)(486006)(305945005)(86362001)(97736004)(71200400001)(71190400001)(14454004)(966005)(105586002)(81156014)(81166006)(106356001)(8676002)(256004)(2906002)(68736007)(478600001)(99286004)(6486002)(76176011)(6246003)(186003)(4326008)(54906003)(25786009)(1076003)(316002)(4744005)(99936001)(5660300002)(93886005)(6436002)(3846002)(52116002)(26005)(53936002)(386003)(6506007)(53546011)(6512007)(9686003)(102836004)(6306002)(229853002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2613;H:DB6PR0501MB2694.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M/NKNIkbuXW16g8+Trvw6BHxX/0WzCGO7dUNbDAgA84MbMgL3NfGNCDfFWVwOX8hWa+MPvqEbRtRi550C44L8yK5187F2Uu25Twqw8yOuts3TTRSlcAKoGUl9ZMdUgkr8O+oYPrZaEODj5Hbfhov6fOMLb869/NEtNrPKEXmYaP02z4VKwm1CPy9vioJiM67ydWQcdZ7b6my+Ns0auwsmn77cMRfFGrzHpr+G8RPAiloYYds11HwiWFglZ+/q80O6Hz0+KxdZJTq2JjNZUVrMgQY7zT0KP8RMIdLadzK4/cdnRsTk6vi8A6eTKdQO/zxcO9G4huxG/X99XJxXMKZMWe1jklhHGBlXUDQW9SD9kzcW3NVGiqGI0T2eIh6qdDquA3IOu645KMGKw8DLnuzJaFsPt5nABh7367RlLilGz4=
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Mit9XoPEfICDqq/V"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c05793-8661-41b1-e565-08d6a31eb27b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 17:02:36.1506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2613
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Mit9XoPEfICDqq/V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 07, 2019 at 08:52:51AM -0800, Kees Cook wrote:
> On Thu, Mar 7, 2019 at 7:40 AM Leon Romanovsky <leonro@mellanox.com> wrote:
> >
> > On Thu, Mar 07, 2019 at 06:53:54AM -0800, Bart Van Assche wrote:
> > > On 3/6/19 11:24 PM, Leon Romanovsky wrote:
> > > > My simple patch passes too :).
> > >
> > > Can you repost your patch?
> >
> > https://patchwork.kernel.org/patch/10841079/
> >
> > As Rasmus wrote, the thing is to avoid a < 0 check. In my patch,
> > I converted a <= 0 to !(a > 0 || a == 0) expression.
>
> I'd be happy either way. Is there a larger benefit to having a safe
> "is_non_negative()" helper, or should we go with the minimal change to
> the shl macro?

I personally prefer simplest possible solution.

>
> -Kees
>
> --
> Kees Cook

--Mit9XoPEfICDqq/V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcgU6mAAoJEORje4g2clinE94P/0pHFmUgwzRrVLxjqmnynNPC
e+azQISKrZ4EBI5Is7VwFJuxtiZvsTveCxX0NpRxk3TLfHbA4V9jz4meJ6smp4UQ
Z1uRnPbj2z5iucFN/8SelQvNTmqfvbuRSKpZ08XLxBB4XIAjFaNBbmD+REe7iSGD
xiYNp96oHvKnzGZq/eViqz0rogewsTLHoEBwDkfgyDIqwO0/3qVElNhW7Z6g/v/7
2D4yZiB82wIBf+00taEQNnpI/3naVvqdfl34iYGuq51Fd2S36lfmMZ1DUffd/Eq+
jRq8PiNisFK+0A/96hwi2npVN0LS4tA5at6PHhqOfVxMOt/XAmeKu3cCaxHhjbfb
Oi2+X9/EBDdgVmylssQFwjNaLuXB00109IVDcQGgzTsN8xoTNiwla8gt3fVhDWt+
X0jQuSnqtANt75/0mucirBoUppCB59aZ9ygolWe4UwBpVV0ZGH/0MFwcOhlpglGB
PbrKaTxP3qQeil8wGXQsJyPGOCLBGh1Qj0C6NG1wsJSX/Zq8awEoz+JlYCXezaq6
4R0jSHu50BGp7gt5iePRGeUhjPFVGHucJZ2b6fuDZ3ARN8MtQYmrYDyRqnFJZsCE
UZFd4SZ8UzfIETd17IowOmOs62HwXyIi1WzoWjiHsNjH2dxwiB6Lh1JBvAFQgzJ1
0wRa0DMnyLzmIoOdyvQm
=NFtk
-----END PGP SIGNATURE-----

--Mit9XoPEfICDqq/V--
