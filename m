Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550D5C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 11:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF26206C1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 11:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="GzP/42m6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfD1LwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 07:52:18 -0400
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:32324
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbfD1LwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 07:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMquvlFjTQDssD9fTifUhBOojEmzlZwjOzoMfBxvufc=;
 b=GzP/42m6/NqPYH+BFQwacQr5V5hlAJRMtFI8rd2YHbU4vFCIWeV663cJTmvrohOE7s0EaN/WjJ8VwCiBUz5bJv8xAgoKJW1eAJGWUza4mKhdLA3CLY9GXunv370dN7vA+HVDB49b6u1akgP8mlDaobSBfcwE3WKCBM8ZuUt6vmw=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5887.eurprd05.prod.outlook.com (20.178.125.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Sun, 28 Apr 2019 11:52:12 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1835.016; Sun, 28 Apr 2019
 11:52:12 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHU/bjRDQW4dOHvME6ENVPTZDYrAw==
Date:   Sun, 28 Apr 2019 11:52:12 +0000
Message-ID: <20190428115207.GA11924@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::35) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebfd1c76-87dd-453d-4ef4-08d6cbcff387
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(49563074)(7193020);SRVR:VI1PR05MB5887;
x-ms-traffictypediagnostic: VI1PR05MB5887:
x-microsoft-antispam-prvs: <VI1PR05MB588716C8A4DF6FCA5A703E55CF380@VI1PR05MB5887.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0021920B5A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(136003)(39860400002)(189003)(199004)(71190400001)(71200400001)(14454004)(305945005)(7736002)(476003)(486006)(97736004)(102836004)(316002)(54906003)(110136005)(186003)(478600001)(86362001)(26005)(99286004)(5660300002)(386003)(6506007)(8676002)(66946007)(25786009)(66476007)(66556008)(33656002)(6512007)(73956011)(2906002)(81156014)(66066001)(1076003)(81166006)(4326008)(99936001)(6486002)(14444005)(53936002)(256004)(3846002)(8936002)(9686003)(6436002)(52116002)(68736007)(6116002)(36756003)(66446008)(64756008)(66616009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5887;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UcaNjZZpvQpNBOH553RF40o1F/ezP74F1qKwmFyL2eqYpo6Ob3KJom3yf4dX1nSC5C83mKEPvzqrj4vLQ1vgoop6I5zXhdhWmwGzk+mE7e7dsJ66eSJEifVTkLXykFGPJqSPjpoFLz+n298Wn2GOQSlQ7Tw6DsPpZ4AX2evFqyZKZZTQH/ciYgKSJwBD0M9fiV4mddIcyAocCEIGU8+iqs4S3/w6UQSKF84Hy73HSpAhbJUMSl01dBDyH8jCDoeyljPM7POYK+TRKHtlybgkepp+4rpcM96nLLI5sf47JplHTXJYYtXu1TWY3bPmHp6WHuKMhq44dZaN6NnrWBXmb/44tD+tlYAmaEtFHedNf0xZOHuIgZ0oYw8iVqZ1NwEnKeaEpCJWHY2tbDrAk6kfxpoEENQ3XfiDbUOL2BfIucM=
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfd1c76-87dd-453d-4ef4-08d6cbcff387
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2019 11:52:12.6105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5887
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Third rc pull request

Nothing particularly special here. There is a small merge conflict
with Adrea's mm_still_valid patches which is resolved as below:

diff --cc drivers/infiniband/core/uverbs_main.c
index db20b6e0f253c9,f2e7ffe6fc5466..7843e89235c34b
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@@ -1039,7 -992,9 +1039,9 @@@ void uverbs_user_mmap_disassociate(stru
  		 * at a time to get the lock ordering right. Typically there
  		 * will only be one mm, so no big deal.
  		 */
 -		down_write(&mm->mmap_sem);
 +		down_read(&mm->mmap_sem);
+ 		if (!mmget_still_valid(mm))
+ 			goto skip_mm;
  		mutex_lock(&ufile->umap_lock);
  		list_for_each_entry_safe (priv, next_priv, &ufile->umaps,
  					  list) {
@@@ -1051,9 -1006,11 +1053,10 @@@
 =20
  			zap_vma_ptes(vma, vma->vm_start,
  				     vma->vm_end - vma->vm_start);
 -			vma->vm_flags &=3D ~(VM_SHARED | VM_MAYSHARE);
  		}
  		mutex_unlock(&ufile->umap_lock);
+ 	skip_mm:
 -		up_write(&mm->mmap_sem);
 +		up_read(&mm->mmap_sem);
  		mmput(mm);
  	}
  }

The tag for-linus-merged with my merge resolution to your tree is also avai=
lable to pull.

Thanks,
Jason

The following changes since commit dc4060a5dc2557e6b5aa813bf5b73677299d62d2:

  Linux 5.1-rc5 (2019-04-14 15:17:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 2557fabd6e29f349bfa0ac13f38ac98aa5eafc74:

  RDMA/hns: Bugfix for mapping user db (2019-04-25 10:40:04 -0300)

----------------------------------------------------------------
5.1 Third RC pull request

One core bug fix and a few driver ones

- FRWR memory registration for hfi1/qib didn't work with with some iovas
  causing a NFSoRDMA failure regression due to a fix in the NFS side

- A command flow error in mlx5 allowed user space to send a corrupt
  command (and also smash the kernel stack we've since learned)

- Fix a regression and some bugs with device hot unplug that was
  discovered while reviewing Andrea's patches

- hns has a failure if the user asks for certain QP configurations

----------------------------------------------------------------
Guy Levi (1):
      IB/mlx5: Fix scatter to CQE in DCT QP creation

Jason Gunthorpe (3):
      RDMA/mlx5: Do not allow the user to write to the clock page
      RDMA/mlx5: Use rdma_user_map_io for mapping BAR pages
      RDMA/ucontext: Fix regression with disassociate

Josh Collier (1):
      IB/rdmavt: Fix frwr memory registration

Lijun Ou (1):
      RDMA/hns: Bugfix for mapping user db

 drivers/infiniband/core/uverbs.h        |  1 +
 drivers/infiniband/core/uverbs_main.c   | 52 +++++++++++++++++++++++++++++=
++--
 drivers/infiniband/hw/hns/hns_roce_qp.c |  2 +-
 drivers/infiniband/hw/mlx5/main.c       | 12 ++++----
 drivers/infiniband/hw/mlx5/qp.c         | 11 ++++---
 drivers/infiniband/sw/rdmavt/mr.c       | 17 ++++++-----
 include/uapi/rdma/mlx5-abi.h            |  1 +
 7 files changed, 76 insertions(+), 20 deletions(-)
(diffstat from tag for-linus-merged)

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAlzFk+QACgkQOG33FX4g
mxqIkA/+JBDrzPRJjwhMY0PJLS+MYMKNnFLRkU7JymP40qMKVxSfqxiNTHztP+Rb
UoKipsXh654KpVWCwaPS2JvEcy4BNRLhI15zym5fFXsgCGK1oxlnjLbI22lBBshm
8YXK1KVZtzdXkPpdgR+kz8whssk0HzKKPIh0sloph/RG8+VR47Kl17y3bo2NuOP6
tBfyVRUdSPd0tPXmqaEo7UqokMcw/DBXL08U0QTkISzQgqvWI4DdQnxo+u5L85V/
wyvK26TOZaKU/Lb4zMWOgy5NTrmwNwcuxpdWl2z4oTcb0DQKNMkCYWW1UIfC9azW
1com9jPngNnivOAWYp1qLvpwMfBia7yJnMfr6te0swXQUfrVeyStndRiuAOMM4E5
3Y5YJ51VynWT1cpky+tLiKUGl2BMlD/vu7x7VV2OR2V+hIoYyd2eDJ0qun7K7Ytq
hXM4MOhTfuVDnGZxpIWf+92GwzqJjgQYzqi175nTDWcUdCKwM4NM/fUUEHMy4gmb
rbUtCxq4JPq65a64tfJt8D2lu6Ppp09U6d2hrtUfcAcwZWOT+DSSoJrzVivW9Hiq
xKjU64LDk9v3G1kHKsV5NRXuQeLDQn7sxzE8T+cZR6YvoLopX6LlBw9DwYrJglgO
1lgBNNBzQQsexkqw9PQkrusLq/h1/RozDaXvsOYr2s5+/Z9R9tc=
=2zuv
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
