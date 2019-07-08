Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8EAC606C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CD320693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="UjQy/5ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391492AbfGHQIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:08:31 -0400
Received: from mail-eopbgr00060.outbound.protection.outlook.com ([40.107.0.60]:47236
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729062AbfGHQIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeD22x2qu+E+nXXZqFU5iuBwex3iZJyWZOj/1xg4mVw=;
 b=UjQy/5lyimJXQMngqpeNrWyY46OAfwmxNeu/DoagKF0ZDIzhxY8KWVXHs1oYrIX0AfTUYRvdoOn3nYcHEGviU1viszBezez7Zjs8iYCkIcW+yUawVKY1C9q2nwpyWuhrbW1aEvOkVTywLDmFsla561hXd9sX6dJcL+CmDREOTE8=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5648.eurprd05.prod.outlook.com (20.178.120.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Mon, 8 Jul 2019 16:08:27 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 16:08:27 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Doug Ledford <dledford@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: linux-next: build failure after merge of the rdma tree
Thread-Topic: linux-next: build failure after merge of the rdma tree
Thread-Index: AQHVNTjoB8aYc7vyLEKUSeiDY6rDZ6bA5EqA
Date:   Mon, 8 Jul 2019 16:08:27 +0000
Message-ID: <20190708160823.GH23966@mellanox.com>
References: <20190708125725.25c38fa7@canb.auug.org.au>
In-Reply-To: <20190708125725.25c38fa7@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:208:120::33) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a567b7a6-5a96-4f3e-7d90-08d703be82d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5648;
x-ms-traffictypediagnostic: VI1PR05MB5648:
x-microsoft-antispam-prvs: <VI1PR05MB5648176402E5223F3FC9640FCFF60@VI1PR05MB5648.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(53754006)(189003)(199004)(26005)(53546011)(76176011)(6512007)(186003)(99286004)(4326008)(102836004)(6506007)(386003)(7736002)(66066001)(305945005)(81166006)(81156014)(5660300002)(36756003)(6246003)(14444005)(54906003)(316002)(53936002)(33656002)(68736007)(52116002)(8676002)(478600001)(25786009)(3846002)(6116002)(8936002)(256004)(86362001)(2906002)(1076003)(6436002)(14454004)(486006)(229853002)(476003)(2616005)(446003)(64756008)(66476007)(66556008)(71190400001)(73956011)(66946007)(66446008)(71200400001)(11346002)(6916009)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5648;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eE0eMjDzXoKSKMuz7U4vgPkEGxiHLZ3Ob/PbbL4N2Gzk7+c7kpW8tC5bsWH2/2ByeSHzc/gQgtkh7V3K5Q2OeG1+05l4opiWQTvYmfA9XrlcKYxs9ksNC+D02l26Mu7KdIYUKMKSKwwoPo02UkaE6W+YQLNPuxBqqIb4q7aPrgiB/89gh1BrPHjaPmQtG8c8E+qklfIqb5p7T96+GA4LGhrHs96X4zuvl0yq0xklYW4ClDzvsTlBQZ7+Zjc+o5NBvetTuZHGCNWMg+hF1m4IdQ1/IIt7mE3VHDymtGY4HZY02ubRoXyS+Tx8voAGaLtRd01Z5Xbyy+Q5OrQv9r/SHkoXqAY8Ceg1v+gORlRIWnWpnMxguVuniDxTKoGh6xU/ECx5ciGb3RpZCNw/B8yrytYaX6l52jHbNhwzPYVhkoA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B68358B9440FE4D909878D8CE94B3C7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a567b7a6-5a96-4f3e-7d90-08d703be82d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 16:08:27.2408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5648
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 12:57:25PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the rdma tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> In file included from <command-line>:32:
> ./usr/include/rdma/rvt-abi.h:13:10: fatal error: rdma/ib_verbs.h: No such=
 file or directory
>  #include <rdma/ib_verbs.h>
>           ^~~~~~~~~~~~~~~~~
>=20
> Caused by commits
>=20
>   dabac6e460ce ("IB/hfi1: Move receive work queue struct into uapi direct=
ory")
>=20
> interacting with commit
>=20
>   0c422a3d4e1b ("kbuild: compile-test exported headers to ensure they are=
 self-contained")
>=20
> from the kbuild tree.
>=20
> You can't reference the include/linux headers from uapi headers ...
>=20
> I have used the rmda tree from 20190628 again today (given the previous
> errors).

This is a bug that will break our userspace package too, we must fix
it, very happy to see the functionality in "kbuild: compile-test
exported headers to ensure they are self-contained"

Dennis, you must put stuff in rdma-core and run the rdma-core CI if
you are messing with the uapi headers.

I'm adding this fixup so we can progress with the merge window. Please
check it right away.

From f10ff380fd7dfba4a36d40f8dd00fe17da8a1a10 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@mellanox.com>
Date: Mon, 8 Jul 2019 12:17:48 -0300
Subject: [PATCH] RDMA/rvt: Do not use a kernel header in the ABI

rvt was using ib_sge as part of it's ABI, which is not allowed. Introduce
a new struct with the same layout and use it instead.

Fixes: dabac6e460ce ("IB/hfi1: Move receive work queue struct into uapi dir=
ectory")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/sw/rdmavt/qp.c | 32 ++++++++++++++++++++++++++-----
 include/uapi/rdma/rvt-abi.h       |  9 +++++++--
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdma=
vt/qp.c
index 11b4d3c1efd486..0b0a241c57ff37 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1847,8 +1847,11 @@ int rvt_post_recv(struct ib_qp *ibqp, const struct i=
b_recv_wr *wr,
 			wqe =3D rvt_get_rwqe_ptr(&qp->r_rq, wq->head);
 			wqe->wr_id =3D wr->wr_id;
 			wqe->num_sge =3D wr->num_sge;
-			for (i =3D 0; i < wr->num_sge; i++)
-				wqe->sg_list[i] =3D wr->sg_list[i];
+			for (i =3D 0; i < wr->num_sge; i++) {
+				wqe->sg_list[i].addr =3D wr->sg_list[i].addr;
+				wqe->sg_list[i].length =3D wr->sg_list[i].length;
+				wqe->sg_list[i].lkey =3D wr->sg_list[i].lkey;
+			}
 			/*
 			 * Make sure queue entry is written
 			 * before the head index.
@@ -2250,8 +2253,11 @@ int rvt_post_srq_recv(struct ib_srq *ibsrq, const st=
ruct ib_recv_wr *wr,
 		wqe =3D rvt_get_rwqe_ptr(&srq->rq, wq->head);
 		wqe->wr_id =3D wr->wr_id;
 		wqe->num_sge =3D wr->num_sge;
-		for (i =3D 0; i < wr->num_sge; i++)
-			wqe->sg_list[i] =3D wr->sg_list[i];
+		for (i =3D 0; i < wr->num_sge; i++) {
+			wqe->sg_list[i].addr =3D wr->sg_list[i].addr;
+			wqe->sg_list[i].length =3D wr->sg_list[i].length;
+			wqe->sg_list[i].lkey =3D wr->sg_list[i].lkey;
+		}
 		/* Make sure queue entry is written before the head index. */
 		smp_store_release(&wq->head, next);
 		spin_unlock_irqrestore(&srq->rq.kwq->p_lock, flags);
@@ -2259,6 +2265,22 @@ int rvt_post_srq_recv(struct ib_srq *ibsrq, const st=
ruct ib_recv_wr *wr,
 	return 0;
 }
=20
+/*
+ * rvt used the internal kernel struct as part of its ABI, for now make su=
re
+ * the kernel struct does not change layout. FIXME: rvt should never cast =
the
+ * user struct to a kernel struct.
+ */
+static struct ib_sge *rvt_cast_sge(struct rvt_wqe_sge *sge)
+{
+	BUILD_BUG_ON(offsetof(struct ib_sge, addr) !=3D
+		     offsetof(struct rvt_wqe_sge, addr));
+	BUILD_BUG_ON(offsetof(struct ib_sge, length) !=3D
+		     offsetof(struct rvt_wqe_sge, length));
+	BUILD_BUG_ON(offsetof(struct ib_sge, lkey) !=3D
+		     offsetof(struct rvt_wqe_sge, lkey));
+	return (struct ib_sge *)sge;
+}
+
 /*
  * Validate a RWQE and fill in the SGE state.
  * Return 1 if OK.
@@ -2282,7 +2304,7 @@ static int init_sge(struct rvt_qp *qp, struct rvt_rwq=
e *wqe)
 			continue;
 		/* Check LKEY */
 		ret =3D rvt_lkey_ok(rkt, pd, j ? &ss->sg_list[j - 1] : &ss->sge,
-				  NULL, &wqe->sg_list[i],
+				  NULL, rvt_cast_sge(&wqe->sg_list[i]),
 				  IB_ACCESS_LOCAL_WRITE);
 		if (unlikely(ret <=3D 0))
 			goto bad_lkey;
diff --git a/include/uapi/rdma/rvt-abi.h b/include/uapi/rdma/rvt-abi.h
index d2e35d24f1a9e6..7328293c715cfb 100644
--- a/include/uapi/rdma/rvt-abi.h
+++ b/include/uapi/rdma/rvt-abi.h
@@ -10,11 +10,16 @@
=20
 #include <linux/types.h>
 #include <rdma/ib_user_verbs.h>
-#include <rdma/ib_verbs.h>
 #ifndef RDMA_ATOMIC_UAPI
 #define RDMA_ATOMIC_UAPI(_type, _name) struct{ _type val; } _name
 #endif
=20
+struct rvt_wqe_sge {
+	__aligned_u64 addr;
+	__u32 length;
+	__u32 lkey;
+};
+
 /*
  * This structure is used to contain the head pointer, tail pointer,
  * and completion queue entries as a single memory allocation so
@@ -39,7 +44,7 @@ struct rvt_rwqe {
 	__u64 wr_id;
 	__u8 num_sge;
 	__u8 padding[7];
-	struct ib_sge sg_list[];
+	struct rvt_wqe_sge sg_list[];
 };
=20
 /*
--=20
2.21.0


