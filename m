Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF6BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA872075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Cj2yf8Ev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfCKMN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:13:59 -0400
Received: from mail-eopbgr40065.outbound.protection.outlook.com ([40.107.4.65]:56235
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbfCKMN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0ALZI2thFH0Um/PEJ3HRSMwSWoutCmI+B3vIowtITU=;
 b=Cj2yf8Ev745au0nLi1s95MQY5QrxRZ6iMGSkEWdcz2PF7pFpbMRYwq+coAGq/1r/E5HVhMmHBwZC854fYgYM6hfHgF33n2pNgN7Krc5je2JXCoutn+0Tfoc3xrpoXWf66hGUhtJwuNAwsz36T/IwYUuBPT0GcGDUyGt65g+iPKE=
Received: from DBBPR05MB6570.eurprd05.prod.outlook.com (20.179.44.81) by
 DBBPR05MB6362.eurprd05.prod.outlook.com (20.179.41.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 12:13:54 +0000
Received: from DBBPR05MB6570.eurprd05.prod.outlook.com
 ([fe80::5d59:2e1c:c260:ea6f]) by DBBPR05MB6570.eurprd05.prod.outlook.com
 ([fe80::5d59:2e1c:c260:ea6f%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 12:13:54 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the xarray tree
Thread-Topic: linux-next: build failure after merge of the xarray tree
Thread-Index: AQHUyayWFZfOlBmck0G6zKDUm21wO6XqMEkAgBulFgCAAJ8KAA==
Date:   Mon, 11 Mar 2019 12:13:54 +0000
Message-ID: <20190311121348.GD22862@mellanox.com>
References: <20190221171332.262cf619@canb.auug.org.au>
 <20190221123440.GD17501@mtr-leonro.mtl.com>
 <20190311024434.GA19508@bombadil.infradead.org>
In-Reply-To: <20190311024434.GA19508@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::41) To DBBPR05MB6570.eurprd05.prod.outlook.com
 (2603:10a6:10:d1::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [24.137.65.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8aea64af-0e56-42d4-30ff-08d6a61b077e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DBBPR05MB6362;
x-ms-traffictypediagnostic: DBBPR05MB6362:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DBBPR05MB6362;23:WtzC3unT9bTGlT5NSLWjXPBX12/EtDBv1wJl7GdEU?=
 =?us-ascii?Q?6sM6EUrVxORAqEKdbXCdbppwl5dBASjjwGtF1Ki2MTP0WmOKNu613MglzCCd?=
 =?us-ascii?Q?knIXzYGpn/AVm0nZAAUG41tvzhta7kfyrWThJ/UdFzao+7LP75cLRwq79rPR?=
 =?us-ascii?Q?1n6KDUy5jQdIDlxpH4ydrTOVZMny544a4siWCPFHw+BuCU+lleyOQhSsrp+S?=
 =?us-ascii?Q?NvAtbcS87XvXT2BXYorvLL4oRQFXJz5b+cZJcWS17HIFqvgX9cDY4HFZ3xM/?=
 =?us-ascii?Q?t//wsTKG8QysDxgqOe4RQAJlEJ052JCp9UxVUrcX/jX004SFTBeElwGdUttp?=
 =?us-ascii?Q?yVxSYRDo+bblTxz/xgJmAi4q8LOY+BnrXpzi44IYifo6fB9IjaPdkhr46ucp?=
 =?us-ascii?Q?EcqQ4jecv1GiGVyVEqBhY59EjoN6okXJ3VOUhbe7nFKwxgZ8d21toA7wSyv6?=
 =?us-ascii?Q?A/YOyE1Lk/8+BZx5I3T2Zh7+qRwfSI5uG0HIDdTmjtZ6jkp+vnMBdJ6Gq2Bq?=
 =?us-ascii?Q?71d7tkIvzEjWWM5TcZZsgVf5kSvOfHT5z8yBjS4MdweCwGvkf13A7Nrxcj8h?=
 =?us-ascii?Q?CghVagaSTkELXyBNfAmikMnedXaPxHFai9oWZtipKEwdlNdasA7YCPwNk7Ux?=
 =?us-ascii?Q?XSN+HYxUREq5fwY8nblrbtTxm7m5132FVLEQHcbzJE5K0umdLSgY6d/Kb6rv?=
 =?us-ascii?Q?09pGfc0fKZTORfp7+y4t+fOTKrVxursp+YQq0Uj/YzNw9KRgAiF29wMUwFx1?=
 =?us-ascii?Q?cWb/FWfYixtypks0O8kKTXBe1JkI/IrSdQC48W5Xu9YCz945mlaPlIcRnamU?=
 =?us-ascii?Q?TaK58ge3b1SOMpSPqczufIHyOFfkGMoNwejYL/ZEmxbuQiNswEo8YCyCU/tl?=
 =?us-ascii?Q?9Msg8ZRY2JEWT66uEceHZWN2rkpy8CtM/X/MRBBYN5ZIH2lUtm2u8XuNcsSI?=
 =?us-ascii?Q?547s+GmSje2Gi2vtEUnWb9IT1n+uH5Z9x7Lc0exMhYSzq/kBJ+fWvxH3RYuO?=
 =?us-ascii?Q?Oh6a9n9zpIb/UxpIINfwLYw/+0Bf/rJwXgU4+SsuBwK8ut7xZO8fl+Qjl4EB?=
 =?us-ascii?Q?xodbf9PH9LYQDHszJDsmpyWZ2QlTqTqdgTPHWsW0sO0gmcK07yObGEBN2Wu9?=
 =?us-ascii?Q?wbgvoINj/RWgLKkeU+FrPolZWu75MKE81WAT8P88kGuKR0f60qCeAnAJ3ytN?=
 =?us-ascii?Q?0kVAa1tgOQ4AkU2pi/J9f0YvoP6xBF6qkXIVFkdtmec8MdfvWGxwU5PeIl1o?=
 =?us-ascii?Q?Ft2R4rbM6RHBWK2sP56vGo1S+ger/6BIwfYDasLQsmN+RKR4mVq5ctzNPFl6?=
 =?us-ascii?B?dz09?=
x-microsoft-antispam-prvs: <DBBPR05MB6362D3146F26FE63184F6A98CF480@DBBPR05MB6362.eurprd05.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(366004)(199004)(189003)(53754006)(86362001)(386003)(6506007)(66066001)(71200400001)(71190400001)(25786009)(54906003)(6116002)(7736002)(1076003)(316002)(2906002)(97736004)(52116002)(76176011)(99286004)(305945005)(36756003)(3846002)(102836004)(2616005)(476003)(6512007)(5660300002)(6916009)(486006)(105586002)(6486002)(6436002)(33656002)(26005)(11346002)(446003)(256004)(14444005)(229853002)(8676002)(4326008)(478600001)(81166006)(81156014)(106356001)(14454004)(186003)(8936002)(68736007)(53936002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6362;H:DBBPR05MB6570.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1i3MF2aPlAdma7sT2oVTOtz4WuCLD4kpi5NgGk/An/ofIZpQNuKzBtYBpb1Ia7BfAodzDj0ZyDrTbT8UFfZfrEy7IWJHU2/nglqq13rPL5QUsoZMRw1Oo9AgXws8pgv2l1Wj9ZvpO9eSzLNCln2x37f4KDh1bzbdexcf3eqab1iAeSSl4ytMqr8/fcGmdHg0prQJJREKYFqtUN1BB5I+5ruSncy1SbDNGf3gXh73pZ4AWnMVbwH9GngQEZK6eOyX9YJ6SCfP1UT5clpLyfv+KHadNdBS0GCOvXQcsIIQtE6byCsWzvQJG9BhhLgdxyahYue1XBy/krRY2MUY3AOjZxo91q2U2N9YFn5hf0TiP9iRByAVN5KoWhVIluyCAQnmcZRi0AcbORbMk2eHLrS3V+vt7k6SXkKfHrPAhybQmkA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EBE5CE1B7C68F442BF1EABFF6745DAF5@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aea64af-0e56-42d4-30ff-08d6a61b077e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 12:13:54.2344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6362
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
>=20
> [API change]
>=20
> So I ended up being really busy last week and not having time to send
> my merge request for XArray yet.  I'm going to send a request this week;
> Leon and Jason, how does this merge resolution look?
>=20
> Compile tested only.
>=20
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index a9f29156e486..8a93c0c95953 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -668,19 +668,10 @@ static int assign_name(struct ib_device *device, co=
nst char *name)
>  	}
>  	strlcpy(device->name, dev_name(&device->dev), IB_DEVICE_NAME_MAX);
> =20
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
> =20
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

blank line after locals, but other wise these all looks fine..=20

Should have started out with the xa_insert version above..

Thanks,
Jason
