Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4D0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF7A20811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="DVncrk+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfCHHDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 02:03:08 -0500
Received: from mail-eopbgr150072.outbound.protection.outlook.com ([40.107.15.72]:24464
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfCHHDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 02:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqcQfbw0y/A1pM2dU1X0o2AFYiXF5apgzGWbdwuuQZg=;
 b=DVncrk+NVKOaHv4VqPAYakezK2ED9KjvL7LRIpH9I9dNDLF13aAKmZeus/TgVxFdBjgv/rfa7791hhO5e1iR0pLbJD1DhBzeNatw1mULddPJRcRsFpK+AiViovzbfedYTE9KihM3wHh9v6LUb1H0s+B1HBDpYxe6SsD5HT4SlZ4=
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com (10.172.226.9) by
 DB6PR0501MB2390.eurprd05.prod.outlook.com (10.168.75.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Fri, 8 Mar 2019 07:03:02 +0000
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2]) by DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2%9]) with mapi id 15.20.1686.016; Fri, 8 Mar 2019
 07:03:02 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Kees Cook <keescook@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
Thread-Topic: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
Thread-Index: AQHU1IFjo1AIqyRPikaxzNyP0OOhK6X/X/kAgAAN6YCAAFa0AIAAfZIAgAAM+QCAABRDgIAAArIAgAAC1wCAADbJgIAAsTMA
Date:   Fri, 8 Mar 2019 07:03:02 +0000
Message-ID: <20190308070258.GF32625@mtr-leonro.mtl.com>
References: <20190307010153.81157-1-bvanassche@acm.org>
 <20190307012417.GU1758@mellanox.com>
 <8a5bd9ae-ebfe-687c-2868-d0f2a610d1e0@acm.org>
 <20190307072428.GJ1789@mtr-leonro.mtl.com>
 <4d90c392-5b6a-fea0-e6cf-c49ac19fdf30@acm.org>
 <20190307154020.GN1789@mtr-leonro.mtl.com>
 <CAGXu5jLBPpKOT-NV1P0nuFeSQYfoNY_8B0V4gcQg18xHPUVbhQ@mail.gmail.com>
 <20190307170230.GR1789@mtr-leonro.mtl.com>
 <CAGXu5jJDmEFA7=WuDnr0U6t9BTDFtd_WsB5HeryNKoZSaBW8oA@mail.gmail.com>
 <926da814-b21d-d01d-d0bb-6304bf545218@rasmusvillemoes.dk>
In-Reply-To: <926da814-b21d-d01d-d0bb-6304bf545218@rasmusvillemoes.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0062.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::26) To DB6PR0501MB2694.eurprd05.prod.outlook.com
 (2603:10a6:4:82::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.138.135.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66999494-c878-4722-6022-08d6a3941ab4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(49563074)(7193020);SRVR:DB6PR0501MB2390;
x-ms-traffictypediagnostic: DB6PR0501MB2390:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DB6PR0501MB2390;23:FWrUnjaDSx2XBpEXyg6z9uw/Juxuca6wwPlkqxe?=
 =?us-ascii?Q?LNF+tn1FDoTfGy/DufUyEmbdA+Ebd4aXT00XpTZfLDBOd1Y95s6p+qEt87RW?=
 =?us-ascii?Q?KtxjD8LDBhwlkm4DdUxPHEbkncYTmx1Spe6tZHJUhApmibT1GirVeKBUVHjn?=
 =?us-ascii?Q?9jADgakHsa+PcT+KQXCnUjFjh1P63zC5EHYtD22775fTg/7Kpy4MIgyc+qVT?=
 =?us-ascii?Q?ycJ/zLe0jLQSXpfAtoD/KVsmNoZUaHlEMkRxUviC3XtmeZElowomyO2VKNrA?=
 =?us-ascii?Q?IQQe/jzlXMDXhiui6/cb9yxztzO2DdROYpY+lkMX3D+hEMk9dH/v1zG2ozhf?=
 =?us-ascii?Q?TWhy7nsNfvbLRaXevQIPtpZ8aoN6a+yC281Av7miCei1CaaQfLYnrpRObiww?=
 =?us-ascii?Q?R69m0LRsrjyOSbuJjV8LFIF74cJy3sKpLd1VxGZWKqda0ccO0SfEMfKAUxN/?=
 =?us-ascii?Q?62eVNxUiEbIm/SwEztVXZ+JbuOC1CrDOdPCcKqVxVCoTNQlj96jjs4vC24iv?=
 =?us-ascii?Q?cgQY3xWC8EEH0ePvHI9lOf2ZB8lgH5wa2JlT3Eq8sNUXlOz8FXyt1X++/RXP?=
 =?us-ascii?Q?VMklHAoUyKcwAeDpOJWZjAIajsduaCjelz+/orxD+Ii6azc+btTR71tIaSxj?=
 =?us-ascii?Q?4sGyWcf/JA1DTbVc+ivd4wEj7NlH/l6ZNII2B/PJetMfEP6ZRCAqI9luvF0Q?=
 =?us-ascii?Q?reXZ50px8S/s2C9UdVYQdPf+jgSSF2RGIWJfXPXJNROcs5yi8OuRx3jb4tCt?=
 =?us-ascii?Q?mHqgmiDOBGahbh3nriRPLiwrP5ipIauPWCSZWMbXc9aEBg6J3Wb9vjDnwlex?=
 =?us-ascii?Q?bFdzLLrj0r5m0cBEKg79ZfOxxZ62XW0J1raDQGyANOHq3Qt+gU9YcKq1KDdO?=
 =?us-ascii?Q?GLU5RfxScmKcQqfLx/rpiizuwZby16yADoKwk8oqsc4dmOmrc9y41jrRXdl1?=
 =?us-ascii?Q?r00ZnQH1TmCXNe0XUje7G93edRqYL+i4eAMTzh3Zs7T6o/FHS4WZT5JPxofv?=
 =?us-ascii?Q?h5AJ9AKHamEf7hdzWAHa/694BwPQL4eiHrGmo6MgRHFoBhIF4btk1Dx/JwWC?=
 =?us-ascii?Q?Fe75SpRdfEZQj74XcicdbZ4/6Mx/ZVqEwEftfecin4dg7ilbKAVO9fmNdnuJ?=
 =?us-ascii?Q?S7dAnd3S0biGBFP0JHFdITXfC3N0X/9W+omq0oZo3FkY9ycKVKvT5abuH4l/?=
 =?us-ascii?Q?dfZHUdznvm1skBA51Zioc1CEpmql+GVCsCwdskg22f5QPJ+JMvkXz0oQDuzv?=
 =?us-ascii?Q?n//WgfQi0XLln1LQd6KOYfaA67q4nXx9//BtNeUJbEIOtRyblfnHOjwvxPVu?=
 =?us-ascii?Q?mFrttKA7CQATLVs7co7CSW+g=3D?=
x-microsoft-antispam-prvs: <DB6PR0501MB2390DB18726B46185EE2BEC2B04D0@DB6PR0501MB2390.eurprd05.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(136003)(376002)(199004)(189003)(386003)(6506007)(105586002)(26005)(52116002)(25786009)(5660300002)(99936001)(102836004)(106356001)(1076003)(76176011)(6916009)(7736002)(33656002)(305945005)(53546011)(4326008)(186003)(97736004)(71190400001)(71200400001)(8936002)(53936002)(93886005)(6306002)(81166006)(81156014)(6512007)(9686003)(966005)(3846002)(6116002)(68736007)(14454004)(6246003)(478600001)(229853002)(256004)(86362001)(66066001)(6436002)(316002)(54906003)(476003)(11346002)(8676002)(486006)(6486002)(99286004)(2906002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2390;H:DB6PR0501MB2694.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OuPTvtXvlQdyfodONjVkvSDpqwf/cmTPnOevy6ulo2hafHVM0QIjeRkUmOMEi8CzbbcF4ClSeRL0nNhDAtzYKjhXEwnd+pxTEOiMu9p6oyZReAs4T3DvlKBbUHOSkh5MSBRFZJxFZbWbzheTHyn83i2oMYT4B2Wps4N26tbAZAAQdvi9kfXa5zXBHpKCQgj74KxzRwksNLHttiYE4rCvKbChtzA0GLgxSzarLd8BkgPTpcLN7GdoSoYQqRK0hxZCeoDzwJmMcjuY33qpDEuyx86WyIoFAG/Cfv0fFHY2/JnKppy3WRHC7k6CA/gSEwUQOs6aNDCDnLXKYHnwX8yPut0F08QB0CRZEcd1c4N0SO7bxACeCWUoXSkb/WwXY8otbcz484MkOl0rIMl68yUKrt7LQIzoFTFAySW6sy2wUOM=
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66999494-c878-4722-6022-08d6a3941ab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 07:03:02.1152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2390
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 07, 2019 at 09:28:45PM +0100, Rasmus Villemoes wrote:
> On 07/03/2019 18.12, Kees Cook wrote:
> > On Thu, Mar 7, 2019 at 9:02 AM Leon Romanovsky <leonro@mellanox.com> wrote:
> >>
> >> On Thu, Mar 07, 2019 at 08:52:51AM -0800, Kees Cook wrote:
> >>> On Thu, Mar 7, 2019 at 7:40 AM Leon Romanovsky <leonro@mellanox.com> wrote:
> >>>>
> >>>> On Thu, Mar 07, 2019 at 06:53:54AM -0800, Bart Van Assche wrote:
> >>>>> On 3/6/19 11:24 PM, Leon Romanovsky wrote:
> >>>>>> My simple patch passes too :).
> >>>>>
> >>>>> Can you repost your patch?
> >>>>
> >>>> https://patchwork.kernel.org/patch/10841079/
> >>>>
> >>>> As Rasmus wrote, the thing is to avoid a < 0 check. In my patch,
> >>>> I converted a <= 0 to !(a > 0 || a == 0) expression.
> >>>
> >>> I'd be happy either way. Is there a larger benefit to having a safe
> >>> "is_non_negative()" helper, or should we go with the minimal change to
> >>> the shl macro?
> >>
> >> I personally prefer simplest possible solution.
>
> So, I played around with a few variants on godbolt.org, and it seems
> that gcc is smart enough to combine (a > 0 || a == 0) into (a >= 0) - in
> all the cases I tried Leon's patch resulted in the exact same generated
> code as the current version. Conversely, and rather surprising to me,
> Bart's patch seemed to cause worse code generation. So now I've changed
> my mind and also support Leon's version - however, I would _strongly_
> prefer if it introduced
>
> #define is_non_negative(a) (a > 0 || a == 0)
> #define is_negative(a) (!(is_non_negative(a))
>
> with appropriate comments and used that. check_shl_overflow is hard
> enough to read already.

What about if we call them is_normal(a) and is_negative(a)?

Thanks

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcghOiAAoJEORje4g2clin97QQAL6HF9ZSrST2hp50uEBHhn6R
DPczPjlSiClkDkd/khZ5/+50IXlJsZmeVPwnJ9qsfw6y65xD/Wufn498I/5ylgfF
m+yG5oJmt13ejF7XocEr3rRjY3gXCfi8wWYgomjaWyn028ty47xup6eAwFU+LEXA
aKcGm89Xa5HJcHY4KgkBuWT6AXyQjRrmWeQoCqw8hZZoCl0HC4S/8MQw7MTeptT7
xiRJLBrae9eJxnHpvh7myIIU7gU5CJlj88xONKCJ0HqKYEvQT4VH5gYPGvVUXls8
lkqoKhAhEsIhJy7nXQcPsNblTqmaNo1xkICd9rC16pQ5OCe3IPJt2rILdezPdu4w
IPUU0k66+vQod2t7glumpBaMQAZkOFlobadtV7q19H9ZK+cyuRL2F5XIn5gZF6gV
NLkGfO972V1bYcd25S1XJWn5p463u4Q1Jk2GqH+sBj2dKApogJXS/FJ1Q0RhPoTo
Qt4hn285CoFBPYHxEgLp5KRnvArUFP3H40KIm3daDudif4UiaXOHLc+9ebdhMtIA
XVLSEg7K7Kbcf/2fHKGKj8R+6T4C8ErmXxRpw2E0jkfBamdGhRDVoMJJpq+O7c4k
Auwz9jqfrlZafZxOky9KGIGfnkIPZl4/Cyre5ZcTlkuNAVHyUiF5Kc+/REf3dr5q
fQMbtd2nytU79Op65uO+
=wVhp
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--
