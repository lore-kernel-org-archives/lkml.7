Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDF6C606D8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFF421537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="C8iUPPrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfGIHEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:04:21 -0400
Received: from mail-eopbgr130087.outbound.protection.outlook.com ([40.107.13.87]:18014
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbfGIHEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3t26rAb6VdH5rRyxQqvYdKkzoBzfNiEGLiopPUw5R8I=;
 b=C8iUPPrgSQ5YhoSLsEwlds7FmrIpUkCyd3Vy4jaLnKsUzkzFumkycIeJMywm+HTNwuACW7sizGa7vPyDIxjC0eK+ze/5UQgmEZTFSvLZCCxA5kTA1t9xHZcHf4SrWmF6QtRrZPbIrUYRmdcWxE1LbqfkvHxr/VpavpKLOD+3OIg=
Received: from AM6PR05MB4472.eurprd05.prod.outlook.com (52.135.162.157) by
 AM6PR05MB6151.eurprd05.prod.outlook.com (20.178.93.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Tue, 9 Jul 2019 07:04:16 +0000
Received: from AM6PR05MB4472.eurprd05.prod.outlook.com
 ([fe80::b8a9:c816:7e52:b47]) by AM6PR05MB4472.eurprd05.prod.outlook.com
 ([fe80::b8a9:c816:7e52:b47%3]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 07:04:16 +0000
From:   Mark Zhang <markz@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        asahiro Yamada <yamada.masahiro@socionext.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: linux-next: build failure after merge of the rdma tree
Thread-Topic: linux-next: build failure after merge of the rdma tree
Thread-Index: AQHVNgam1ySKRGHBz0+LGfGH8/fuJ6bB3PCA
Date:   Tue, 9 Jul 2019 07:04:16 +0000
Message-ID: <ba1dd3e2-3091-816c-c308-2f9dd4385596@mellanox.com>
References: <20190709133019.25a8cd27@canb.auug.org.au>
In-Reply-To: <20190709133019.25a8cd27@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR01CA0117.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::21) To AM6PR05MB4472.eurprd05.prod.outlook.com
 (2603:10a6:209:43::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=markz@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [115.196.38.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4396a993-735d-4f88-97d2-08d7043ba7fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR05MB6151;
x-ms-traffictypediagnostic: AM6PR05MB6151:
x-microsoft-antispam-prvs: <AM6PR05MB6151A4BBC689071BF06F22E9CAF10@AM6PR05MB6151.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(53754006)(189003)(199004)(7736002)(305945005)(6636002)(66066001)(68736007)(31686004)(3846002)(81166006)(6116002)(73956011)(53936002)(81156014)(8936002)(8676002)(6436002)(5660300002)(66446008)(64756008)(2906002)(66556008)(66946007)(66476007)(386003)(256004)(486006)(478600001)(26005)(99286004)(316002)(54906003)(31696002)(110136005)(11346002)(2616005)(476003)(186003)(36756003)(446003)(14454004)(86362001)(53546011)(102836004)(6486002)(6506007)(229853002)(107886003)(6246003)(71190400001)(71200400001)(52116002)(76176011)(25786009)(6512007)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6151;H:AM6PR05MB4472.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RIXnNDpiFQu5/uOg/Nipsb5BHheArzeCBfmLRzKDkt9/cRvzukCHliBbAAU5AmV5WQu1bYZF+1ghyansu9y1VKzzsCIavdxP8HG53ad0q7XvweYmwbxvQQX+4L0XycJ+HvdfdHM6dXQUUkBsm58QrUgWujD16H0DLBNFOOol3LOyjlD2jYUUNCP+I/AyVnFEZTOSrG+UvTnCornBlNRC4OX/puvHOBq36XckC/lh4xuLeWVo8OY43pupLhLZVfzJp/y5/K9eWc0c1D3QgLHb2NGxuhpflav0XhxTImQMUhF6znHDHKbpVMQWWG+hDyF7KW/31IQP8FNMPHaruiOxqyTw3kA2jCk1cQ0ZU1+lf3mAy0FSNGvLNoeQjY172rNrq2Y43QOc9imHKdgM4geHVg37uvy6tEyQBgczcwFm8y8=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <3368234182CC824389CEFA42EF8F76B0@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4396a993-735d-4f88-97d2-08d7043ba7fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 07:04:16.6052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: markz@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Can you please try the patch below, thank you.

net/mlx5: Remove include ib_verbs.h in rdma_counter.h

rdma_counter.h include ib_verbs.h which in turn needs rdma_port_counter
from rdma_counter.h, but it is not defined yet.

Fixes: 413d3347503b ("RDMA/counter: Add set/clear per-port auto mode=20
support")
Signed-off-by: Mark Zhang <markz@mellanox.com>

diff --git a/include/rdma/rdma_counter.h b/include/rdma/rdma_counter.h
index 68827700ba95..eb99856e8b30 100644
--- a/include/rdma/rdma_counter.h
+++ b/include/rdma/rdma_counter.h
@@ -9,10 +9,10 @@
  #include <linux/mutex.h>
  #include <linux/pid_namespace.h>

-#include <rdma/ib_verbs.h>
  #include <rdma/restrack.h>
  #include <rdma/rdma_netlink.h>

+struct ib_device;
  struct ib_qp;

  struct auto_mode_param {

On 7/9/2019 11:30 AM, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the rdma tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> In file included from /home/sfr/next/next/include/rdma/rdma_counter.h:12,
>                   from <command-line>:
> /home/sfr/next/next/include/rdma/ib_verbs.h:2126:27: error: field 'port_c=
ounter' has incomplete type
>    struct rdma_port_counter port_counter;
>                             ^~~~~~~~~~~~
>=20
> Caused by commit
>=20
>    413d3347503b ("RDMA/counter: Add set/clear per-port auto mode support"=
)
>=20
> rdma_counter.h include ib_verbs.h which in turn needs rdma_port_counter
> from rdma_counter.h, but it is not defined yet :-(
>=20
> I have applied the following patch for today.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 9 Jul 2019 13:17:49 +1000
> Subject: [PATCH] RDMA: don't try to build rdma_counter.h for now
>=20
> rdma_counter.h include ib_verbs.h which in turn needs rdma_port_counter
> from rdma_counter.h, but it is not defined yet :-(
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>   include/Kbuild | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/include/Kbuild b/include/Kbuild
> index 78434c59701f..8dab85cdf4f4 100644
> --- a/include/Kbuild
> +++ b/include/Kbuild
> @@ -939,6 +939,7 @@ header-test-			+=3D rdma/ib.h
>   header-test-			+=3D rdma/iw_portmap.h
>   header-test-			+=3D rdma/opa_port_info.h
>   header-test-			+=3D rdma/rdmavt_cq.h
> +header-test-			+=3D rdma/rdma_counter.h
>   header-test-			+=3D rdma/restrack.h
>   header-test-			+=3D rdma/signature.h
>   header-test-			+=3D rdma/tid_rdma_defs.h
>=20

