Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8E9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 01:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FD92085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 01:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ag50xHmt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfCRBES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 21:04:18 -0400
Received: from mail-eopbgr50061.outbound.protection.outlook.com ([40.107.5.61]:47143
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726122AbfCRBES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 21:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAC9/Zs/CnHp9jipIaTU29dVcS8rIT2pyY1ZWxstS/A=;
 b=ag50xHmtt1Hui9JybyolPbsMDQqZj/i15pgG0HmZ24aH02ufZCPDnUOnkZKo0RY3Y4u0VPmjpcC+kVJw0imAWEBDBCaOuV23OdTz4fNQgYf1Q1BuC+T2ERxMnCFNt43nigId6MS3f2QF/EjIcYJLP3E+FEQiHkkLY+cihkBUIos=
Received: from DBBPR05MB6570.eurprd05.prod.outlook.com (20.179.44.81) by
 DBBPR05MB6298.eurprd05.prod.outlook.com (20.179.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 01:04:12 +0000
Received: from DBBPR05MB6570.eurprd05.prod.outlook.com
 ([fe80::5d59:2e1c:c260:ea6f]) by DBBPR05MB6570.eurprd05.prod.outlook.com
 ([fe80::5d59:2e1c:c260:ea6f%2]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 01:04:12 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHU3SaAldW2vGMMFESjc7ggVhy3Ww==
Date:   Mon, 18 Mar 2019 01:04:12 +0000
Message-ID: <20190318010407.GA26545@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::14) To DBBPR05MB6570.eurprd05.prod.outlook.com
 (2603:10a6:10:d1::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [24.137.65.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27185891-b684-4b6e-3b85-08d6ab3da23e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(49563074)(7193020);SRVR:DBBPR05MB6298;
x-ms-traffictypediagnostic: DBBPR05MB6298:
x-microsoft-antispam-prvs: <DBBPR05MB6298C3FF5CB6C60DF4CE50D3CF470@DBBPR05MB6298.eurprd05.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(53936002)(14454004)(8676002)(476003)(68736007)(66066001)(105586002)(4326008)(81156014)(81166006)(36756003)(97736004)(25786009)(6486002)(5660300002)(7736002)(99936001)(9686003)(305945005)(6512007)(14444005)(6436002)(256004)(86362001)(2906002)(52116002)(99286004)(33656002)(1076003)(386003)(110136005)(8936002)(6506007)(54906003)(102836004)(71200400001)(316002)(71190400001)(3846002)(106356001)(6116002)(486006)(478600001)(26005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6298;H:DBBPR05MB6570.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vl6zuBd21gqxDMYEqAyLHsxzgjz7AdqacIpH2QcgQ5SagXbUeeNWAPR74vQo5XfI6/Mc/XwcsEeSbNB45+xW7mkuVY0pL/LcWFiWC40n98iX9s0xstbZ2hlrK2iO4wcFRxvG8nMKDpfvttKTx9QwEQPlYSyGOLL0mCLQcI2wlTsGavtk0ET+cpfo3bOAM1rQ4qfeiZQt0zBAVwp/h0HFCvKCWX/V0HXPI+mBgq5IV9rABZgI7CuoPlcl1a6wH7jLhGl5VjubKOWBZcrN4dqzIdJLd2rGd2if1XIYoAxtPg/yo4REZ4Bx3NrFoFhAzPfxH7+WAHd/BkEySiPXlSegnOrE70a8S4vGNFBemKuo7PxhfSisNUp3OKsv/HznEZZmWEhRA/wEdvx+GEkQdRvpWf/t5h8TeRkrw5l5g8U8Ww4=
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27185891-b684-4b6e-3b85-08d6ab3da23e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 01:04:12.7920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6298
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

First rc pull request - nothing too special, just some driver bug
fixes that have been sitting during the merge window.

Thanks,
Jason

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to ec4fe4bcc584b55e24e8d1768f5510a62c0fd619:

  i40iw: Avoid panic when handling the inetdev event (2019-03-17 21:40:40 -0300)

----------------------------------------------------------------
5.1 First RC pull request

Several driver bug fixes post in the last three weeks

- First part of a race condition fix in mlx4 with CATAS errors

- Bad interaction with FW causing resource leaks in the mlx5 DCT flow

- Bad reporting of link speed/width in new mlx5 devices

- Userspace triggable OOPs in i40iw

----------------------------------------------------------------
Aya Levin (1):
      IB/mlx5: Fix mapping of link-mode to IB width and speed

Feng Tang (1):
      i40iw: Avoid panic when handling the inetdev event

Jack Morgenstein (1):
      IB/mlx4: Fix race condition between catas error reset and aliasguid flows

Yishai Hadas (2):
      net/mlx5: Fix DCT creation bad flow
      IB/mlx5: Use mlx5 core to create/destroy a DEVX DCT

 drivers/infiniband/hw/i40iw/i40iw_utils.c    | 12 ++++-
 drivers/infiniband/hw/mlx4/alias_GUID.c      |  2 +-
 drivers/infiniband/hw/mlx5/devx.c            | 34 +++++++++----
 drivers/infiniband/hw/mlx5/main.c            |  7 +++
 drivers/infiniband/hw/mlx5/qp.c              |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/qp.c | 72 +++++++++++++++-------------
 include/linux/mlx5/qp.h                      |  3 +-
 7 files changed, 89 insertions(+), 45 deletions(-)

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAlyO7oQACgkQOG33FX4g
mxoq0A/8CVz+6BHYBGjJ2+oyoBCJXtApJzqEJdtGQhkqPdr0V5giW3hKOJNkveJk
v0ul6T5f+eRkJjko4Wk1JTz1NrDtemlPDSLTwg7Q4ZJYENJC+y35X7AS2RTCWFI6
Gs9doTx4EiyZbx3fizome3ZNgaGFmtSHvW+1ImIssP3neoK9ZFeMw/M58QpRpCIc
tM+RoRA3jo7VwnNqzIiud5EJCz4tmy9+cqrHff0Z15j6bvfEyzbtmKq3oe2bFw9z
Id3q4xBQ99pt51r3zVlMzFV6HCbDIJ2fUcl/Kp4m0Oj9dslBlBZrWUJ/pjaP/OkO
1U8seQTnCj+fOkLzvQ6hjG/TaPm1dU/TtTk84Jv5g3WgzKj49Ak4ZmE/5IyOh2z+
KMV8ooBDQnK35xF3dhwmWNpcAfNClLk3KEyK6lUPOrAfm4sXPevCD4SLovcZqmIa
daYlfO7YEJ5+L/XgYbgRJb6qfaLWQtGYCUC9JPPmtf8oyKnHayf7lvzQ2X5Kv9pk
krnRomQJNpV5FCgSF+JZ3Q5/SnGT6zZyMNWGPue/61L6/gLY/wwsdoVQuVF68DRB
DtFrr4jVrItIRk85SdGczXZuYMQa/Kj2BndSuTl5HWBlnb0QfGN7bGpURGsCMT1K
OufRuMC/2AgOB4qc7zTmEUAnuotsLZNZNIXqre5fXYtzpVtf7Gc=
=+ta4
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
