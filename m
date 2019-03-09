Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF221C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48939207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="vpCJy7fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfCID4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 22:56:30 -0500
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:48064
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbfCID4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 22:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqXvwmHyqdZZK2PgzhcYkvvR+ac0Q1Y054Rnb59CpSI=;
 b=vpCJy7fbtipU3MnOey+XsaxLfNs8rNhDBiU2U3VD5DalMuOcBhWqAclMdIdhIWPP1XjC0LAr3/UL2xqvhfBqhZOIyozczbe3Y0JdAJR46zxB9EjtlyVjbzCcin1GPj8QQPZ8kUb/6/zr8PQrBC4myNv7qvedk99eo4DgXhrvkDQ=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2448.eurprd05.prod.outlook.com (10.168.136.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Sat, 9 Mar 2019 03:55:43 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1686.020; Sat, 9 Mar 2019
 03:55:43 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jiri Pirko <jiri@mellanox.com>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        Vu Pham <vuhuong@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [RFC net-next v1 1/3] vfio/mdev: Inherit dma masks of parent
 device
Thread-Topic: [RFC net-next v1 1/3] vfio/mdev: Inherit dma masks of parent
 device
Thread-Index: AQHU1fuAviAqdDpTPkWiqma15LNdDaYCUbmAgABYnHA=
Date:   Sat, 9 Mar 2019 03:55:43 +0000
Message-ID: <VI1PR0501MB22714DFFB3C695D7433829E4D14E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1552082876-60228-1-git-send-email-parav@mellanox.com>
        <1552082876-60228-2-git-send-email-parav@mellanox.com>
 <20190308153243.49a31e1e@x1.home>
In-Reply-To: <20190308153243.49a31e1e@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [68.203.16.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa064b04-0a52-4073-a964-08d6a4431abb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2448;
x-ms-traffictypediagnostic: VI1PR0501MB2448:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR0501MB2448;23:sd8czAaxkkAbDLXp/DDrOXWUoBNguJETIrl6G2z?=
 =?us-ascii?Q?aOVaLpGyXU7QmzXn00Bj5ab+j+Goxi+UVWC+i6ychGKXj9mkZWRORCT5usfj?=
 =?us-ascii?Q?wL4uH+OmpiM57R6U43+qaXpu0UYuoxxjy8hIcZkIx6xpXZXgM8pcDIFQZJk2?=
 =?us-ascii?Q?iTy1mjeq8imo+KUKaWEtXePF3wiI0+NZEcQKwgLR4WEsMXW4269Na+mYjkKN?=
 =?us-ascii?Q?Divr4se/j8eZ3KZ/2N8HNVFtmIov9aRrMGa1rTRINoUObvaWzCqAh8h0FBVe?=
 =?us-ascii?Q?9Uoy8MltjIBTUxil69Cyhpaiss+OpFgMbAuu0WJunTkkbDh2T6cWGcRAb5i9?=
 =?us-ascii?Q?1b+jQYoZRrM2f66o5saHD7LEjp2Vb868VKR2sqCZMCQnAIC4Jtp2DBOTtY0g?=
 =?us-ascii?Q?OPmc1pF/aMFi5O34+zzn0xqdU7jB5s75uLATMfbM9hqTMDgGv4oK5Xj5p1E7?=
 =?us-ascii?Q?ELyKWpqQYMoXrHN3R6gXTgkRbUWdgIro/O6Kqmlc5dY1cEZoU5UOTP64Brfr?=
 =?us-ascii?Q?7TjoAzPyMYCmgtLanfj7GBv3oSKuZq102ed+SwZuOAUDQWGcFYX6TVZRSYUB?=
 =?us-ascii?Q?XnW4zXrJF8ASAdhfIcnUJlwzvWUlahLq9LCBRSrNDj82YGHUByPXN09Zv9GA?=
 =?us-ascii?Q?5WRdMDtHLQDaN+vg/IjL9EdGIXKc+Xj1nnV/zRnMwjLe30KBMKhzw7h1wrVu?=
 =?us-ascii?Q?xFoZYQgf8VyF+DxZxGIbR7vxa3coq0Nqdb0Cymh4c74ixj/VzJQO3LBw//S+?=
 =?us-ascii?Q?SI1QwMUgna/ZcLY3pZdfq5WzDG5uIQ3zFPQQgHslPYbugEoh1/8X4Ncqiqso?=
 =?us-ascii?Q?KJRV1tGkiSrbssickYksrLKXwf0bsZhDoWhtlNC+BIG8LWu0t77eD8lpH4HQ?=
 =?us-ascii?Q?EqjAcMvWmRvUj8Xo3+RSdykJKvKnD06qYwcQ9JkD79Dg9imXE85Bpq83LYKX?=
 =?us-ascii?Q?Jb5OFCJs2EjilYdD3mX9kwzleuF2cmRR+7XKkrXX0hs3Wacem6Onne8zNQ37?=
 =?us-ascii?Q?woJGuFjc2NZW6QmAORvayKw+H23b6OP8AbK9oo7G1LgwN3LWyVixZGdwaOdN?=
 =?us-ascii?Q?pO9o+xwWIZfX8D8r6lF0+9dAD5+LnzAQnsz3Hlt7G/44tHaF5wZqFgwiwefX?=
 =?us-ascii?Q?Z8JZohE8TxPNrkYj1KSO51IrFJoZfgPIikozQlwywrG7b7rzSVwzcw+CWEIU?=
 =?us-ascii?Q?pOBd27gVDQtzKcLkn50C0wKYqhPCMX6yJAbUxwwZPuU2UfZa1K0QXKg4OhMI?=
 =?us-ascii?Q?dpj3d0iOKj0dY+NOR6P0n8wCWpVaFZs9f8MU3KF1I?=
x-microsoft-antispam-prvs: <VI1PR0501MB24482DFF52FE8D6F45FB7923D14E0@VI1PR0501MB2448.eurprd05.prod.outlook.com>
x-forefront-prvs: 0971922F40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(366004)(346002)(376002)(396003)(199004)(189003)(13464003)(81156014)(3846002)(486006)(54906003)(316002)(5660300002)(6916009)(478600001)(6116002)(52536013)(106356001)(105586002)(33656002)(97736004)(305945005)(53936002)(7736002)(6246003)(4326008)(229853002)(25786009)(68736007)(55016002)(9686003)(6436002)(71190400001)(102836004)(26005)(71200400001)(446003)(476003)(14454004)(11346002)(66066001)(7696005)(74316002)(99286004)(6506007)(8936002)(53546011)(76176011)(186003)(14444005)(81166006)(8676002)(256004)(86362001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2448;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RQF0ehccGuBH6ptspz6lAirD3Odw8olJKD8flfKvu8VqbU4nE2thOo/GFwbBAXHyb0zRcK69jTpk+piFwj80E7YwuTFW6tmmcHkeiqj67ummNxRhqGkQgie4UbVhBIhJUd9kCM6kf/5I90gEqDQ/W1XXUUCaG6EP1RMq79FB8CP39kJJ2G/thetGlQYYuc0blKNqTJo5UAUOQRiLtDg3VmO0AZVDIV+w+SIpylZRTuoWKET2h7eNBGDczRV9YNxb/yZp2mvva5gsZ6vcYkYrThEL2BWbfBj4pzovnTIfzMBcXBV8KFFjRoczLd3GigUt9HjxqCziJguZ463AiX8Rm6hdf1LpN7Im/qF6U47waI3vSknlRGDgkdNn4tw8QwsHtfR6QtGlAJsnf3SHY7AH6vLEmvT7l+FC9B6V7UCRKVg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa064b04-0a52-4073-a964-08d6a4431abb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2019 03:55:43.5482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2448
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Friday, March 8, 2019 4:33 PM
> To: Parav Pandit <parav@mellanox.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> michal.lkml@markovi.net; davem@davemloft.net;
> gregkh@linuxfoundation.org; Jiri Pirko <jiri@mellanox.com>;
> kwankhede@nvidia.com; Vu Pham <vuhuong@mellanox.com>; Yuval Avnery
> <yuvalav@mellanox.com>; jakub.kicinski@netronome.com;
> kvm@vger.kernel.org
> Subject: Re: [RFC net-next v1 1/3] vfio/mdev: Inherit dma masks of parent
> device
>=20
> On Fri,  8 Mar 2019 16:07:54 -0600
> Parav Pandit <parav@mellanox.com> wrote:
>=20
> > Inherit dma mask of parent device in child mdev devices, so that
> > protocol stack can use right dma mask while doing dma mappings.
> >
> > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > ---
> >  drivers/vfio/mdev/mdev_core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/vfio/mdev/mdev_core.c
> > b/drivers/vfio/mdev/mdev_core.c index 0212f0e..9b8bdc9 100644
> > --- a/drivers/vfio/mdev/mdev_core.c
> > +++ b/drivers/vfio/mdev/mdev_core.c
> > @@ -315,6 +315,10 @@ int mdev_device_create(struct kobject *kobj,
> struct device *dev, uuid_le uuid)
> >  	mdev->dev.parent  =3D dev;
> >  	mdev->dev.bus     =3D &mdev_bus_type;
> >  	mdev->dev.release =3D mdev_device_release;
> > +	mdev->dev.dma_mask =3D dev->dma_mask;
> > +	mdev->dev.dma_parms =3D dev->dma_parms;
> > +	mdev->dev.coherent_dma_mask =3D dev->coherent_dma_mask;
> > +
> >  	dev_set_name(&mdev->dev, "%pUl", uuid.b);
> >
> >  	ret =3D device_register(&mdev->dev);
>=20
> This seems like a rather large assumption and none of the existing mdev
> drivers even make use of DMA ops.
So its non-harmful anyway.

> Why shouldn't this be done in mdev_parent_ops.create?  Thanks,
>=20
Struct device should be setup correctly before calling device_register().
That is the sane way to access device_register() API.
Doing this under mdev_parent_ops.create() will do it after device_register(=
).
If you want to make it optional, mdev_register_device() can pass a bool fla=
g to setup dma params or not which can be applied conditionally in mdev_dev=
ice_create() before device_register().
