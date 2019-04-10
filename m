Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1000CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16522070D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="SJWj3FCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfDJSq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:46:28 -0400
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:47237
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727881AbfDJSq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oh4BSWKv9cPFZH8o/cVuyB7zmfLEvEwR23H7yexItpk=;
 b=SJWj3FCLqzMDrSP0Up7wjdaNI89ZRNx0xYpxLhOiFB6tb00JbKCEJbuBZR7JSTWQbX2j6wyDnplfOH8NRcrj2DDhRON2QEOMkVwuNyaQcIHnNW+aU173pqGyR7AFMfjymHcrimQc6GoVel/N1h1IyqrfdkDQhGAkQLpfnLtXrek=
Received: from AM6PR05MB4439.eurprd05.prod.outlook.com (52.135.162.148) by
 AM6PR05MB6198.eurprd05.prod.outlook.com (20.178.95.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 18:46:23 +0000
Received: from AM6PR05MB4439.eurprd05.prod.outlook.com
 ([fe80::24cd:a3f1:870b:bd92]) by AM6PR05MB4439.eurprd05.prod.outlook.com
 ([fe80::24cd:a3f1:870b:bd92%5]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 18:46:23 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHU782xs/1fWN+HjkqOp9kv1mKnBQ==
Date:   Wed, 10 Apr 2019 18:46:23 +0000
Message-ID: <20190410184618.GA6370@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::38) To AM6PR05MB4439.eurprd05.prod.outlook.com
 (2603:10a6:209:43::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7a7bc0b-c7f7-4a21-d016-08d6bde4d422
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(49563074)(7193020);SRVR:AM6PR05MB6198;
x-ms-traffictypediagnostic: AM6PR05MB6198:
x-microsoft-antispam-prvs: <AM6PR05MB6198B94E5BBB88485AE60093CF2E0@AM6PR05MB6198.eurprd05.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(366004)(396003)(199004)(189003)(106356001)(26005)(305945005)(2906002)(486006)(86362001)(478600001)(97736004)(7736002)(105586002)(6512007)(4326008)(476003)(9686003)(14454004)(186003)(52116002)(3846002)(6506007)(6436002)(36756003)(316002)(71190400001)(5660300002)(71200400001)(6116002)(256004)(110136005)(53936002)(99286004)(33656002)(6486002)(54906003)(25786009)(14444005)(99936001)(81166006)(1076003)(8936002)(81156014)(66066001)(102836004)(386003)(8676002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6198;H:AM6PR05MB4439.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VE4/VfPIKmFMw4PQz4jc/KQQbEZXLH3FJS8jW6RQJuaIEXjQPZi/+dGjhQEKYhOmYNsNJNIu0uGW4I2FkSZJQxTSMSXXnTAxqBZ0lAdR925RXXH0JjEiC35lHoUzYit/rnYP3Ak9r839/aI8lFr+qvy0XUqCJbrcDyzjLi+/xnor7ABAr8YirXltbAvyaQoCoVWBDH8bsQxMgvMkCf8PUAzeEgQRD+vHsap9Xaf5J2/hPv0xfFb0LpOW8OMDNkZ9qcR1MBX6aCzl5imBrNOmVTOq90v1/RBsHp5PDj2DQMeQqtoOB9BLS7/sjdIWXY3f6WYfzkh1jI2yy3IX2mRvSM+m/OP6QX/3EWDTVoig/GKknrJ4t8M/q5jwhcKMXTbdI40Z7AS/kyRNr3kGm56JMrh9AdAw34Cb9TUJZPJXipA=
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a7bc0b-c7f7-4a21-d016-08d6bde4d422
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 18:46:23.2290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Second rc pull request

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to d737b25b1ae0540ba13cbd45ebb9b58a1d6d7f0d:

  IB/hfi1: Do not flush send queue in the TID RDMA second leg (2019-04-10 15:09:30 -0300)

----------------------------------------------------------------
5.1 Second RC pull request

Several driver bug fixes posted in the last several weeks

- Several bug fixes for the hfi1 driver 'TID RDMA' functionality merged
  into 5.1. Since TID RDMA is on by default these all seem to be
  regressions.

- Wrong software permission checks on memory in mlx5

- Memory leak in vmw_pvrdma during driver remove

- Several bug fixes for hns driver features merged into 5.1

----------------------------------------------------------------
Kaike Wan (5):
      IB/hfi1: Failed to drain send queue when QP is put into error state
      IB/hfi1: Clear the IOWAIT pending bits when QP is put into error state
      IB/hfi1: Eliminate opcode tests on mr deref
      IB/hfi1: Fix the allocation of RSM table
      IB/hfi1: Do not flush send queue in the TID RDMA second leg

Kamal Heib (1):
      RDMA/vmw_pvrdma: Fix memory leak on pvrdma_pci_remove

Lijun Ou (1):
      RDMA/hns: Fix bug that caused srq creation to fail

Moni Shoua (1):
      IB/mlx5: Reset access mask when looping inside page fault handler

Yangyang Li (1):
      RDMA/hns: Bugfix for SCC hem free

 drivers/infiniband/hw/hfi1/chip.c              | 26 +++++++++++++++------
 drivers/infiniband/hw/hfi1/qp.c                |  4 +++-
 drivers/infiniband/hw/hfi1/rc.c                |  4 ++--
 drivers/infiniband/hw/hfi1/tid_rdma.c          | 31 +++++++-------------------
 drivers/infiniband/hw/hns/hns_roce_hem.c       |  6 +++--
 drivers/infiniband/hw/hns/hns_roce_mr.c        |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_qp.c        |  3 ---
 drivers/infiniband/hw/mlx5/odp.c               |  3 ++-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c |  2 ++
 9 files changed, 42 insertions(+), 41 deletions(-)

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAlyuOfcACgkQOG33FX4g
mxpNXRAAiJwNLggwfD3C90U4f/yXq7aAAEQjjbnu0q0LYkkAO+11OTyyu3X9maWr
Lyz4kZI4SUcW/cQNq04r0thMU7bmwJeifmiTTUVAn8KTisvbfHg7/4DAg1uOR+pf
1QamYCqwN4tYZuFpBEzn9nkOEeuN+ZplgLHwJLOMBKk9BIuJx1HhSoqvWr9UZjZm
Y7x8fWBmkgFB9p1xLzRznepxTZLL/r6YMRQxLeVVuTDmTqJ9Qz35oMi3fspHpPaD
v9isrQfrAYlxKePhk+cDcxE04FhTw2m63qUIiG0R2/f9npJiHfIkMebXX0gqhE1g
OzUUyMXY2d8F4V6J/Rt7Gje7colHLadFl4jYKEwMzJTcRBa+/XqfqVkVcrmQNI2D
d6GqWGmw6bW9YA8FV0jzh+7N5wPqYPC4kmAvScWuEpFIKde7dFxM6un4xq9fDJr0
0XzlialrNBLu79RjqPVKjkyfrjoKiByFB5grLq3gDMolyF6fQklp0fualRpJklfE
NrM6fjo6HHW0426ETZdbONnZPDFm6AV8o1KqcEEweHzK+gXW7IjWQVlELek7grls
LQVoQ6ZDDcsR3G2qJG4P+8R/S3lTxTsXvqSsA+tDgmCsZmcK1c7w+mv7B5D09tSo
wYT5xVhhr3Sxme8cBijJ6TUEm+sBnSUUBb1ytl7YniDrONPRwIY=
=gApV
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
