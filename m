Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19CAC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DA42087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="RfJZNHXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCHPx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:53:27 -0500
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:17673
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726254AbfCHPx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5818Q6tHh9oupXrQSEDwExJT2+kHcjmoHgfmZGgngkY=;
 b=RfJZNHXSEzTZhitwTd3IchDviBKSIps9dCgs+tpaFx8mS9NVbOiianm9gTtWj1fETk0vGlKYKAvWGRqfJ2RJPxoY2CMJYBtR3k/VuotvTJUfOU9wX5wnIBMWblwd/ctBB+cLlcMYvge7x/XPgbgcdHx2IjktImEoHROUZyP50lU=
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com (10.172.226.9) by
 DB6PR0501MB2376.eurprd05.prod.outlook.com (10.168.75.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Fri, 8 Mar 2019 15:53:22 +0000
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2]) by DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2%9]) with mapi id 15.20.1686.016; Fri, 8 Mar 2019
 15:53:22 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
Thread-Topic: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
Thread-Index: AQHU1UMLo1AIqyRPikaxzNyP0OOhK6YBTuGAgAATLgCAAIGDAA==
Date:   Fri, 8 Mar 2019 15:53:22 +0000
Message-ID: <20190308155318.GG32625@mtr-leonro.mtl.com>
References: <20190307010153.81157-1-bvanassche@acm.org>
 <20190307012417.GU1758@mellanox.com>
 <8a5bd9ae-ebfe-687c-2868-d0f2a610d1e0@acm.org>
 <2c122567-d14b-7867-9230-67f570c13d15@rasmusvillemoes.dk>
 <1552003703.45180.17.camel@acm.org>
 <20190308070107.GE32625@mtr-leonro.mtl.com>
 <ca0d8714-3258-3155-247c-af2d63c28273@rasmusvillemoes.dk>
In-Reply-To: <ca0d8714-3258-3155-247c-af2d63c28273@rasmusvillemoes.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0119.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::35) To DB6PR0501MB2694.eurprd05.prod.outlook.com
 (2603:10a6:4:82::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.138.135.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aaa78eec-5e6c-4056-5481-08d6a3de30ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(49563074)(7193020);SRVR:DB6PR0501MB2376;
x-ms-traffictypediagnostic: DB6PR0501MB2376:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DB6PR0501MB2376;23:Cjx6hBf6YUd75R/5OXSovCa994+SQMf88i2ta5D?=
 =?us-ascii?Q?Bk0uJ9i5niv1I7UYR6T6Pv6Ck2qWWJmH+w079m4xxaWZocZa8h/4Bucsr7Rs?=
 =?us-ascii?Q?vNTBh5w87NdJvXTKg83fkgrUGIJAmb3fP6Gy0gs8DC7z7pszvKgmeKjIXDea?=
 =?us-ascii?Q?U5jD+pgJmjBIIEoocQOEK3N5/4VHySoUTaPv1HebVKQ8qj/kyWWLlobTILHT?=
 =?us-ascii?Q?z04JIWhZIVOzYxKNJ1X2rKhBN4wCFrqL6mBrouPTYF4itkCyf/VNnclMtpw0?=
 =?us-ascii?Q?IidH+IuH4ozU/SsHDNQUi/vgDhyBeM/Zw6NsT29hr8f5/IK0gOb+lWo8U7sR?=
 =?us-ascii?Q?6vEor035ojhO1itMdMAs7C+AcA0VVFV5ZA1vIMZoO7NA6ABuMSH/2AZ8i/d/?=
 =?us-ascii?Q?/j1NhXmKdfVA+ovZx9jJ7EqhFcNhv5ux7MzSV7rwNlDu1ujgH2zFPrCoIyyC?=
 =?us-ascii?Q?8bicCBAuI4TRlZJ+/U4RpQsILc7E7Fm8amHgz9qLsDYEo610cwu7bellE4pd?=
 =?us-ascii?Q?q6LDajGamCyAd+hNEJRMPFi5d7TfVTvCub0czFFumcBFQseqhvpVygz/jU5h?=
 =?us-ascii?Q?Njj9PEap3AclxwQGE1MbZJefU6CA1NomHU3bs3dXoBDn/gIRAvEQwJ1WOa0H?=
 =?us-ascii?Q?tHxFRmooQsm/soAZlM1h9ttnDbBpe5btrniQIxrmXOIa+lGdMeEM6RhJoRgW?=
 =?us-ascii?Q?oERs9rRoPOprzAPQI/48HvQhwQPZ8zFICxEbSy3J4GrRh6ZasPqYD2qoCD7M?=
 =?us-ascii?Q?POikZx4kutu+2gcfNXJw/LUtoTkVWazvKRb+Ivmc96XJXmvarnTLraXr46xJ?=
 =?us-ascii?Q?2ZsHnEADM99wq9f5sCPxQjnXUemM5EntSb8zyiRBjUt8Vy3xmGEkqaIQZoBb?=
 =?us-ascii?Q?SUfEBd6LoMEXTc/fxuUJdMdy7lKU1ydG+PoMiftCUq0JMrcaTn50Elc8llvZ?=
 =?us-ascii?Q?sthmHadCX00bL514wqFvDGjFhSy2WHTqBZtVFgNkUePujZByC1nGMg6mQmyT?=
 =?us-ascii?Q?fs4ftv4PNftipzUBOgyL330y3NsubFvWWdy7pxUGaUFwLdnk4phWCPENABTD?=
 =?us-ascii?Q?Ce93LULLAZVAUlhnfA49Na21nwj3y4EWu9x0ZJXJTdaNNKEACLq4uLAMWQrd?=
 =?us-ascii?Q?+PlF5ZmJlrHuF0PjpMl6agVmjXJDAwfmPqZyPiAI6j49fd2uW2f8oVsB3WI6?=
 =?us-ascii?Q?UbPbgKeYw+y5bLd1MaQFmnat8OBULrE5TOifLe+YsdYXCBSCArsfUJwgbQ17?=
 =?us-ascii?Q?kxEg/bF7FK1ohY+zBwerxWT67Ea8EgLRTAIXeZ0e0DvIkM3i/EVnOTd+UWPH?=
 =?us-ascii?Q?VGrA1Zb1LENvHU8vx8E6YS6c=3D?=
x-microsoft-antispam-prvs: <DB6PR0501MB2376A8E77D0B5D37897F4F05B04D0@DB6PR0501MB2376.eurprd05.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(366004)(189003)(199004)(105586002)(68736007)(54906003)(81166006)(316002)(6916009)(8676002)(81156014)(305945005)(3846002)(7736002)(6116002)(93886005)(8936002)(6436002)(6306002)(9686003)(106356001)(97736004)(86362001)(229853002)(6512007)(6486002)(33656002)(25786009)(4326008)(6246003)(53936002)(386003)(2906002)(99936001)(6506007)(11346002)(5660300002)(186003)(71200400001)(71190400001)(99286004)(52116002)(256004)(5024004)(14454004)(102836004)(476003)(26005)(76176011)(478600001)(486006)(966005)(66066001)(1076003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2376;H:DB6PR0501MB2694.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TPJppla/bhM6Q8B5A3myMiFGKuHg3E+AFnkak7QXsFkabey6kEn6aMRi3S3/LgVZZbVu0fu5BSCA4hoRZ9Q3YBTYeZ26jDmyRE+gpxfJycgw2PoSlDNCVea8TEXtlsVRckzDSvc5PtgLD/U2zBss5L80AkbaZALh5l6spR/AMfDzxBxoD2Go6zxtQhNN1PSY9eJg59PjbPH8koX/FrciD10aGfAhs0A7g+HibAPeUU5M6fFHG7hY3zToR5qVA4G1I6uuI4hXNDVngaWhXTNn2KXZ/YxPwUi2CgASdK7xMFC92VCaZL/6pz8bfvGJ/bub+0wH3RdgG1HOikQAMIIfIhBZe7f19yxzE64/t4D9SbXZhJ7jVTyhCpwmyg9LoEZn3MjFki44y5vbn2532OLIkidI3o5zhM3QxpE6r0ymQCo=
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa78eec-5e6c-4056-5481-08d6a3de30ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 15:53:22.2315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2376
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2019 at 09:09:46AM +0100, Rasmus Villemoes wrote:
> On 08/03/2019 08.01, Leon Romanovsky wrote:
> >
> > Mathematical therm for discrete numbers greater or equal to zero is
> > "normal numbers".
>
> Sorry, WHAT? "Normal" is used and abused for a lot of things in
> mathematics, but I have never heard it used that way. When attached to
> the word "number", it means a real number with certain properties
> related to its digit expansion(s). And then of course there's the
> isnormal() thing for floating point values in C/computing.

It is hard to argue with this type of arguments: "never heard -> doesn't
exist". Luckily enough for me who can't find my fifth grade textbook
=66rom school, we have Wikipedia which has pointer to ISO standard with
clear declaration of "normal numbers" as 0,1,2, ....

https://en.wikipedia.org/wiki/Natural_number#cite_note-ISO80000-1
 "Standard number sets and intervals". ISO 80000-2:2009. International
 Organization for Standardization. p. 6.

>
> Strong NAK to using is_normal/is_negative.
>
> Rasmus
>
>

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcgo/uAAoJEORje4g2clind/0QAJOqxgxotPh9GL4ZtVmTw7z2
f34auUTr+b0kOf75wVidwT3vKwj7t8AusO2TWB+vUflWEB7GPxU0GH8/RowS19eK
3ErShQkPUoPjfVMf563twCh9GVigffWl513t/6/Gf2YghA+T8iMTZywVAqIIUPgU
a/Nl5/OzKLbbkzQez06NVFLf0sOalas8H601HWdZ5SeilmH4+1JXqGw8LQVrsElX
OByYOag9kAESwN+PrWReoSDb2hbLbVh1Fag/c9PG4ZG/7SMOzvWUxDxH8Uh2MGlk
5MpOR3HXR4F5sZi79KtrQ8vQoj8jfNLaQuwgbJKRgqmBREBbbSrsQndah5nzX8lS
lmZW2lThKBy/CnHMIYkqD2WdqnRA32Jy0AhVHNoXoYZGda5AExjSVzJ2X61kkGct
4hYveN/ZuUXBjlpD1FmU/CgbAlGWy6DGA3K8shFGrpc17qWPTt1X8N4//k/mAsvw
BIH4oeo8NXtFMGnqTCRmtRzGD9RWgDiInXq93J2yyeVRhXXUln5c9LO9VgCD/Q2h
SpIR/Z3zAObPU0q3rZkLK+AZ0V2cdoVbMQQRcfz2fRQmYCqi3ubS871f94PEaR+N
O0TdmGgRgaF4zsjXd7OWzdooWo0OdAoS8c6fVuY8P1xwy8oiZSIEE9x7HMkxt9Pj
KLbvewlWk9H6zZZttcIF
=Kvh+
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
