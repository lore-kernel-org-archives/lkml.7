Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD9DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5672084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ZskSCOcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfCKMqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:46:39 -0400
Received: from mail-eopbgr130072.outbound.protection.outlook.com ([40.107.13.72]:15936
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726652AbfCKMqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azDlBmGcZhYpCpGJY2T4MJgtxIjUhuTecZZR1WeI86o=;
 b=ZskSCOcc48sUOMHtNrCPfnKmj5UsybXPO5llg55zNwin0JNcDqQWv9CUMU+IYNImBCvf3DylUMN6xy7tziXIlzBvGJilfUxMyBgu/0wXymvATTpKIKeCkeX6r96944dOFjMSCJ0w+xHDeN7qAcBNX1Inh8n5d98C8EyDrVvewPw=
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com (10.172.226.9) by
 DB6PR0501MB2757.eurprd05.prod.outlook.com (10.172.225.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.19; Mon, 11 Mar 2019 12:46:33 +0000
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2]) by DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2%9]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 12:46:33 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the xarray tree
Thread-Topic: linux-next: build failure after merge of the xarray tree
Thread-Index: AQHUyayWu8bVWYg18UOivP+JxM5jJqXqMEcAgBulGACAAKgtAA==
Date:   Mon, 11 Mar 2019 12:46:33 +0000
Message-ID: <20190311124630.GG32625@mtr-leonro.mtl.com>
References: <20190221171332.262cf619@canb.auug.org.au>
 <20190221123440.GD17501@mtr-leonro.mtl.com>
 <20190311024434.GA19508@bombadil.infradead.org>
In-Reply-To: <20190311024434.GA19508@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR08CA0010.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::22) To DB6PR0501MB2694.eurprd05.prod.outlook.com
 (2603:10a6:4:82::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccb3bf9d-93fc-42bf-d48d-08d6a61f9778
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2757;
x-ms-traffictypediagnostic: DB6PR0501MB2757:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DB6PR0501MB2757;23:j6I0HsGCQ4bzNnZtku94D0lHKrKqUGgF8JawB7x?=
 =?us-ascii?Q?rO4iMoKtCJXGla2K+v9/SQ7EBydwxVwdvp0hjuxGiFkihaJkVFnqoWNqIald?=
 =?us-ascii?Q?pTnCX5gRNh0Qeyg42FsB1nxvz2oxvY6tLkL/Uj1rL+It+wNWwuEybf7Q7BIR?=
 =?us-ascii?Q?d8zk7CWr5pfLgXH+mX+GyTY3heX9etLsoulJRlifwceOgeFC7nWnBDzOaLTx?=
 =?us-ascii?Q?BfCGyij9IplqismFKn+O/q/bhkQrysmGe1GmQ9pBqPmJ0+HfHsy4RhQtE+6z?=
 =?us-ascii?Q?PslNE0OoaO4VDods70sE0zzjoSDij1qlLoC7PICtDPXoO0wjiUdCvpTsWui3?=
 =?us-ascii?Q?8aARzb7THHEdXOWf/Znq3rmu8qqPcNQA/aKyIIu17tXSi9bWV9CpNJYfCFSn?=
 =?us-ascii?Q?6/hJdH41Ic9I/z64zOMEQ3BvJTNM9kVokgFk88WNvCXMp/IBpljz7JHjT8Or?=
 =?us-ascii?Q?QDPAEvUgW7USbFK9pZgevfrLYr8Y/qVeSesXQRcvD4xnwQqucWhwFG5UPmBj?=
 =?us-ascii?Q?aNdv3W4xdjdI2VpPA5XCY+Vj8Rq7Du12/ui2WFM3ehu0YY3yOWZQfewNrkbz?=
 =?us-ascii?Q?/trryV9pBgteyHeAfs+Q9kfnRSQqvev5Muc7edZBR8lrnFek2/BplGw8LNg1?=
 =?us-ascii?Q?47eWArnsmTIeB07be/zu11hbvzAWDHTI7JtL/7/1i23kGmAQBxPurYrQtZMd?=
 =?us-ascii?Q?LLobpoumHShk4H4fBtuw/rJVlQ3LCpYN3iylL4dyGSaXMK6EQ50Uansq9W3w?=
 =?us-ascii?Q?u9z1tFjR976OYQJo6TkwWSRsjN1s6sxgQwypGZKzuVZQd8lBjVKQCtrhhwkd?=
 =?us-ascii?Q?FM6MFckbyBmp5MlX8Trhkuo85k/HCbBjCo65E87gfjlbddsD+hESbl/k5uH3?=
 =?us-ascii?Q?SjSNXC+LbJC6APklpjFzg+dlsTWG+ZEWxxIoIGm1yc93+Xz/F5rh2t536buz?=
 =?us-ascii?Q?KUSbsLh3zmbM8KvsQjEiydDMdW3CRCZHE+ZuLZQbmmehTFlB4Nonywjo7uWl?=
 =?us-ascii?Q?NjB2LLnupoqVS1zhbDGfctdSoLUE2tIKvpTtCVmkNegXOoK8yuTtB9ukNu48?=
 =?us-ascii?Q?gRYTSyC6TkqriefQySI4osd4AkYZ55QpWc/Zk3p9zt93fqP3MRjlNGwazfS2?=
 =?us-ascii?Q?6H1bRWrYPVwtzP2t5Xq9/EL+y5arMilcBgzlB7dSZSZncwwaU+NbXeMUZFHG?=
 =?us-ascii?Q?93IFUnfNsmP4ISNEORoAODonE6vUQca/HmfyPFSx4bMw1cFh6eaOWnRL0pXy?=
 =?us-ascii?Q?RQRbw7tAGm7HVxw8uElmlqfePzQD/PmKdBkr+FEdN?=
x-microsoft-antispam-prvs: <DB6PR0501MB2757F63D35E68067D8F90065B0480@DB6PR0501MB2757.eurprd05.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(396003)(136003)(376002)(189003)(199004)(53754006)(316002)(305945005)(14454004)(54906003)(7736002)(11346002)(446003)(229853002)(6436002)(6486002)(33656002)(9686003)(6512007)(476003)(53936002)(68736007)(26005)(186003)(52116002)(105586002)(8936002)(6506007)(99286004)(106356001)(386003)(102836004)(76176011)(478600001)(8676002)(81156014)(81166006)(97736004)(5660300002)(6246003)(4326008)(71200400001)(71190400001)(6916009)(256004)(66066001)(3846002)(6116002)(486006)(86362001)(2906002)(1076003)(14444005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2757;H:DB6PR0501MB2694.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ru4DmXwz/KBnmrObsnZ1Pft2JBUuBgtMuwp4t7qb7SyeX6jLtLiTBZ2amMYcs8DwZwCh8IxN+Phshp0vf014OHC+kWmxFNIlccB3GKr+imdccQkPcngQsCZYZ0n/NrSgCkmhsO7ovmv5V3ZXr7+BAwdkR9DNE9rLljVfUhSpDovbb8iOwMVc9d7mHiXFoy0ORn68MS4xAdIEVlzBVtRAntlf0XZhWI6jWbF9KtmybdyNPiiy7Gx30bpMPDmlIZWZVLOgQy8IcWhfyxFWN+QZRtG+yug12ZvNzT+aW83Dq1mcsSWPo79sN8IUjBO3KKRHlysMsFmBFFezMF3ifzD/OQJUZ4e7y12eEW1E4i6n+F+g30G1IKwlTK9y47VwmcTqIx8Joo1D/4Rh87ftuk7oL67pUGjFaIGWbNLz4HcbDFc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2E402DCA1758E844B9A841313708E52F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb3bf9d-93fc-42bf-d48d-08d6a61f9778
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 12:46:33.8482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 07:44:34PM -0700, Matthew Wilcox wrote:
> On Thu, Feb 21, 2019 at 12:34:42PM +0000, Leon Romanovsky wrote:
> > On Thu, Feb 21, 2019 at 05:13:32PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > After merging the xarray tree, today's linux-next build (powerpc
> > > ppc64_defconfig) failed like this:
>
> [API change]
>
> So I ended up being really busy last week and not having time to send
> my merge request for XArray yet.  I'm going to send a request this week;
> Leon and Jason, how does this merge resolution look?
>
> Compile tested only.
>
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index a9f29156e486..8a93c0c95953 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -668,19 +668,10 @@ static int assign_name(struct ib_device *device, co=
nst char *name)
>  	}
>  	strlcpy(device->name, dev_name(&device->dev), IB_DEVICE_NAME_MAX);
>
> -	/* Cyclically allocate a user visible ID for the device */
> -	device->index =3D last_id;
> -	ret =3D xa_alloc(&devices, &device->index, INT_MAX, device, GFP_KERNEL)=
;
> -	if (ret =3D=3D -ENOSPC) {
> -		device->index =3D 0;
> -		ret =3D xa_alloc(&devices, &device->index, INT_MAX, device,
> -			       GFP_KERNEL);
> -	}
> -	if (ret)
> -		goto out;
> -	last_id =3D device->index + 1;
> -
> -	ret =3D 0;
> +	ret =3D xa_alloc_cyclic(&devices, &device->index, device, xa_limit_31b,
> +			&last_id, GFP_KERNEL);
> +	if (ret > 0)
> +		ret =3D 0;
>
>  out:
>  	up_write(&devices_rwsem);
> @@ -1059,14 +1050,14 @@ static int assign_client_id(struct ib_client *cli=
ent)
>  	 * to get the LIFO order. The extra linked list can go away if xarray
>  	 * learns to reverse iterate.
>  	 */
> -	if (list_empty(&client_list))
> +	if (list_empty(&client_list)) {
>  		client->client_id =3D 0;
> -	else
> -		client->client_id =3D
> -			list_last_entry(&client_list, struct ib_client, list)
> -				->client_id;
> -	ret =3D xa_alloc(&clients, &client->client_id, INT_MAX, client,
> -		       GFP_KERNEL);
> +	} else {
> +		struct ib_client *last =3D list_last_entry(&client_list,
> +				struct ib_client, list);
> +		client->client_id =3D last->client_id + 1;
> +	}
> +	ret =3D xa_insert(&clients, client->client_id, client, GFP_KERNEL);
>  	if (ret)
>  		goto out;
>
> diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core=
/restrack.c
> index fa804093fafb..3b5ff2f7b5f8 100644
> --- a/drivers/infiniband/core/restrack.c
> +++ b/drivers/infiniband/core/restrack.c
> @@ -13,28 +13,6 @@
>  #include "cma_priv.h"
>  #include "restrack.h"
>
> -static int rt_xa_alloc_cyclic(struct xarray *xa, u32 *id, void *entry,
> -			      u32 *next)
> -{
> -	int err;
> -
> -	*id =3D *next;
> -	if (*next =3D=3D U32_MAX)
> -		*id =3D 0;
> -
> -	xa_lock(xa);
> -	err =3D __xa_alloc(xa, id, U32_MAX, entry, GFP_KERNEL);
> -	if (err && *next !=3D U32_MAX) {
> -		*id =3D 0;
> -		err =3D __xa_alloc(xa, id, *next, entry, GFP_KERNEL);
> -	}
> -
> -	if (!err)
> -		*next =3D *id + 1;
> -	xa_unlock(xa);
> -	return err;
> -}
> -
>  /**
>   * rdma_restrack_init() - initialize and allocate resource tracking
>   * @dev:  IB device
> @@ -226,7 +204,8 @@ static void rdma_restrack_add(struct rdma_restrack_en=
try *res)
>  	kref_init(&res->kref);
>  	init_completion(&res->comp);
>  	if (res->type !=3D RDMA_RESTRACK_QP)
> -		ret =3D rt_xa_alloc_cyclic(&rt->xa, &res->id, res, &rt->next_id);
> +		ret =3D xa_alloc_cyclic(&rt->xa, &res->id, res, xa_limit_32b,
> +				&rt->next_id, GFP_KERNEL);

restrack.c part looks good.
Thanks


>  	else {
>  		/* Special case to ensure that LQPN points to right QP */
>  		struct ib_qp *qp =3D container_of(res, struct ib_qp, res);
