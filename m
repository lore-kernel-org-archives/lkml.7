Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F60C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B782054F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="fshasjTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfCGBY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:24:29 -0500
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:24096
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727216AbfCGBY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RwbUQDxcG7Qdkxwh0R5FiogAq0aPjjDEWjPTZYQ8uE=;
 b=fshasjTT++p7NGyJvT5y0tzGV64ZV26rmhb2rIamFL4Mai/posVuDydaBFmplL+YmkXoXhGhE40shKT6sMI0MRvhGiZVDYBBGv4Kj01hMRg7ZIPbp5q6/pexuZR9wK+U955Fa0tAyTAQ7v0IFdIxDatUmXMm5dsU4RtkLAF+/w0=
Received: from DBBPR05MB6570.eurprd05.prod.outlook.com (20.179.44.81) by
 DB3SPR01MB09.eurprd05.prod.outlook.com (52.134.73.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Thu, 7 Mar 2019 01:24:22 +0000
Received: from DBBPR05MB6570.eurprd05.prod.outlook.com
 ([fe80::5d59:2e1c:c260:ea6f]) by DBBPR05MB6570.eurprd05.prod.outlook.com
 ([fe80::5d59:2e1c:c260:ea6f%2]) with mapi id 15.20.1686.018; Thu, 7 Mar 2019
 01:24:22 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
Thread-Topic: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
Thread-Index: AQHU1IFiJurjf70LZES7WXoyxSnl0KX/X/OA
Date:   Thu, 7 Mar 2019 01:24:22 +0000
Message-ID: <20190307012417.GU1758@mellanox.com>
References: <20190307010153.81157-1-bvanassche@acm.org>
In-Reply-To: <20190307010153.81157-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: QB1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::40) To DBBPR05MB6570.eurprd05.prod.outlook.com
 (2603:10a6:10:d1::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [24.137.65.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46037c0c-40c3-4d7f-8c84-08d6a29ba0b6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3SPR01MB09;
x-ms-traffictypediagnostic: DB3SPR01MB09:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DB3SPR01MB09;23:MiMlRuo3N8v/PP1kDay+NTizBOm+upDZOVoEqF5nj6?=
 =?us-ascii?Q?xVja4pUdDbL6ttaSKg8HJZ331kPg757n1gfkDRE/Xh6uzUrYHxpv0RxyHD/M?=
 =?us-ascii?Q?OaUjMC0vffDJC2WzS5N76iyKgULVPPLf0CF1re1Uh11fJAE1AYMc18EbuWBK?=
 =?us-ascii?Q?H1cv0KPEXaVdN3mscaXF8kwpU6uQKvyBTr2VXldOpoadKexU7aNTxnk3fzxa?=
 =?us-ascii?Q?NTSCqLkYDzoaMZ0YUXG9ebxqwNNQaAWgQL1Q2oH4BP+CJPr65Zjf5PuYOHIr?=
 =?us-ascii?Q?RE7C2rGBrF4nHCvtD+rmh4/tLJOFOu0q3+kKuTWytsJMFMXPJryRxBi3WMPN?=
 =?us-ascii?Q?mODyqV6jMMor6wK1YQAu0hUJ5PyRkJGR3r3Tu1vTAk+UaUGbpGcae5FSEpgv?=
 =?us-ascii?Q?r9znyqmEKHUIIop5hKWTqLwGvXA/dfszUPUDIZDw0RPUuRHaB52NyP/iBGVg?=
 =?us-ascii?Q?AiaofkoYD0PvvB7d2axCubjVtQ4vbg42bTEQMV7151b1ZDxE+Ftic7N6P4Pk?=
 =?us-ascii?Q?90GIgtku6A4lgLqjNWe4ugw8TNSN75vo0WxAs7speYsSrUy7PNG4rg2Xpvb1?=
 =?us-ascii?Q?X1RcVKwUaUaI5aZB1fBPuM9QW1j6HWMoTmkBxQdyND7H4VVs4CSgwnXz07Gr?=
 =?us-ascii?Q?fS/Qg2BsT7GvWym4UjSD9Vr3TvOig5aDsWlpC71qAlWL0MkJpS16o5lXtifw?=
 =?us-ascii?Q?EdxBoDZowRMW5wKizyGNI/Zhwwn/PvURiPdbYypt4fa5XJwR8Gq6GRbb7kAU?=
 =?us-ascii?Q?coZiKuM4Qrkpo6aJU+WKguRjqbhiLIAvZgtyX6DtSNqYXcoSAuqK5BxVFB4M?=
 =?us-ascii?Q?v/KoO76s64PkSG1wyolZfwo6o7VuVBnJ5YtvnS+N17lHzdxls0IPXuocC10K?=
 =?us-ascii?Q?wx2T+ifc7o1kHZ85r3GhGvXtoofnx3w1JGhaGV9DIubYOvtVR0FXflxnzyd/?=
 =?us-ascii?Q?1ctZ+rAP5NIv1NDpsUGU8z5JKi+gCbwhPEDtCh3+Hdm1KqsyW/lO/Y4LBwLc?=
 =?us-ascii?Q?7FwGronjrbqlmYezWzmNWsWSH69e+zeAX1NSlnJk1m+2ojcFIb9JTmHf2kaS?=
 =?us-ascii?Q?ztMi9t45xXNmQZ+Akh1XjGde4cs0NW5ObHzqAEooSI3n2XALIXJqgawJfNQA?=
 =?us-ascii?Q?yGIXuUL2Osscx6RuHLpxZ+wNgWs/rGwiS7xHb6jr8EeGOf7hTQBjFnVp1kSv?=
 =?us-ascii?Q?nfAt/plg/Fp3mCIkKvopI+DGqBZ6eSyVVisXcDQ/KDhUNmgnxMLzpG6AuU5y?=
 =?us-ascii?Q?i7lS3OD0sKaohBiXA1Xpu+IDsXMslTh4rf3Oia?=
x-microsoft-antispam-prvs: <DB3SPR01MB09F07B04BBD6FD507FD83ECF4C0@DB3SPR01MB09.eurprd05.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(366004)(376002)(39860400002)(189003)(199004)(186003)(6246003)(26005)(53936002)(54906003)(386003)(3846002)(81166006)(8676002)(6116002)(81156014)(4326008)(14454004)(229853002)(25786009)(7736002)(305945005)(478600001)(6512007)(14444005)(33656002)(11346002)(486006)(2616005)(476003)(446003)(1076003)(8936002)(256004)(6486002)(105586002)(86362001)(68736007)(66066001)(2906002)(106356001)(6436002)(52116002)(6916009)(76176011)(316002)(99286004)(102836004)(71200400001)(71190400001)(5660300002)(6506007)(97736004)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3SPR01MB09;H:DBBPR05MB6570.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 65oPSHWmnnlJ1QMQaC6TQs4gmQXTtiQqZJq9Sv5C7Kz8PGh0hi9rX9bdTenUL+Cw3/rIA6SJvfZAGSb4HwUrjsAeE56Epi/d+e8PiIZZQnUiUq9bSNl1u6hFpnTtR1rFVhB4utp30DQGL/hq/PS5f7Vu/iVl/lZB39MfMGyDZxc2gcFC2trMrao0990urpP5XegUMQGrKAJWebvZfa7VdEhLZ7GuaIRsea9Sckb3HyilEclJf8hw5UKTDL2VNVX9s58HierCGn8MBmlxtr2acBkAOZ9jKo2ibC2q8EIw0j8l1DpoKKUWMkigy+wuvueTIOLLyH0do3XnfCHqV1uRbYtH2c1d10+ujtanG6863LXhQ9OVvhOICJLVy91ETVQ1gvd8y98tpZVQeLUdmUPI9pzx80hpxgNfBXe4CmT4cn4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8AD71A8C1147B4C987C76406F5F818A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46037c0c-40c3-4d7f-8c84-08d6a29ba0b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 01:24:22.4696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3SPR01MB09
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 05:01:53PM -0800, Bart Van Assche wrote:
> This patch avoids that the following warning is reported when building
> the mlx5 driver with W=3D1:
>=20
> drivers/infiniband/hw/mlx5/qp.c: In function set_user_rq_size:
> ./include/linux/overflow.h:230:6: warning: comparison of unsigned express=
ion >=3D 0 is always true [-Wtype-limits]
>    _s >=3D 0 && _s < 8 * sizeof(*d) ? _s : 0;  \
>       ^
> drivers/infiniband/hw/mlx5/qp.c:5820:6: note: in expansion of macro check=
_shl_overflow
>   if (check_shl_overflow(rwq->wqe_count, rwq->wqe_shift, &rwq->buf_size))
>       ^~~~~~~~~~~~~~~~~~
>=20
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Fixes: 0c66847793d1 ("overflow.h: Add arithmetic shift helper") # v4.19
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>  include/linux/overflow.h | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 40b48e2133cb..8afe0c0ada6f 100644
> +++ b/include/linux/overflow.h
> @@ -202,6 +202,24 @@
> =20
>  #endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
> =20
> +/*
> + * Evaluate a >=3D 0 without triggering a compiler warning if the type o=
f a
> + * is an unsigned type.
> + */
> +#define is_positive(a) ({					\
> +	typeof(a) _minus_one =3D -1LL;				\
> +	typeof((a) + 0U) _sign_mask =3D _minus_one > 0 ? 0 :	\

This is probably just is_signed_type(a)

> +				1ULL << (8 * sizeof(a) - 1);	\
> +								\
> +	((a) & _sign_mask) =3D=3D 0;				\


This is the same sort of obfuscation that Leon was building, do you
think the & is better than his =3D=3D, >  version?

Will gcc shortcircuit the warning if we write it as

(is_signed_type(a) && a < 0)

?

Jason
