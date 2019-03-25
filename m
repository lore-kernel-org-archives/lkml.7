Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620E6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3161B20823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="V+bk5GRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbfCYVMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:12:03 -0400
Received: from mail-eopbgr70088.outbound.protection.outlook.com ([40.107.7.88]:52102
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729569AbfCYVMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAwPvXsCWZ3cpcvf9QbzipmitR/zHEsIecZYq3OfFf8=;
 b=V+bk5GRP9Ge/kOY0ih11e/knq+OJ+MZPP+SLWSw//YXn8FH4H/OQc4if19NGT/LoEbahX2Ch1lzQ/iJxNL9nrN0fd39g1LJgZhQBTsg79ctf/O/nlJI9v8PWRIaQQ9Wp1RyoXoj61RdStZmm1epUae3fA54l37vgBZ2FNnpgNDE=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2749.eurprd05.prod.outlook.com (10.172.11.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 21:11:58 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 21:11:58 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/8] vfio/mdev: Fix to not do put_device on
 device_register failure
Thread-Topic: [PATCH 1/8] vfio/mdev: Fix to not do put_device on
 device_register failure
Thread-Index: AQHU4QX8efp2y+k+mUSt3U8lp+tcVaYcq/gAgAAR3oCAAB6vMA==
Date:   Mon, 25 Mar 2019 21:11:58 +0000
Message-ID: <VI1PR0501MB2271463ABA9D5D208E7F68B5D15E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
        <1553296835-37522-2-git-send-email-parav@mellanox.com>
        <2c096714-74cd-48ff-496f-b3919990e3e5@nvidia.com>
 <20190325132127.7430864b@x1.home>
In-Reply-To: <20190325132127.7430864b@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22141de8-91f6-4ecc-2567-08d6b1668439
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2749;
x-ms-traffictypediagnostic: VI1PR0501MB2749:
x-microsoft-antispam-prvs: <VI1PR0501MB2749FF0EA8AEF29C529B6E6ED15E0@VI1PR0501MB2749.eurprd05.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(366004)(39860400002)(376002)(189003)(199004)(13464003)(99286004)(316002)(3846002)(7736002)(186003)(446003)(11346002)(486006)(476003)(55016002)(9686003)(25786009)(26005)(4326008)(6246003)(6436002)(5660300002)(110136005)(229853002)(6116002)(93886005)(305945005)(52536014)(14444005)(97736004)(86362001)(8936002)(2906002)(102836004)(66066001)(76176011)(105586002)(478600001)(6506007)(53546011)(256004)(54906003)(71190400001)(71200400001)(74316002)(53936002)(68736007)(33656002)(81156014)(81166006)(8676002)(14454004)(7696005)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2749;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5E0bOlDo0retosB2Z21Ri/OOFO+KNYv3Lcnh5aKg4yN3P9EqXhl7mPeRBTVuLnaZtBmd3Z1b2YIpEmd1WTMib2XchUVkb72atVwVtc+5W5C/YKMR3+IBuSyO2jfOonZTuKF3HZIp6bGLV6lYjU7xwFINi/X8ykIYMZCacKYRnUnCOZdixvtwi6Encu91bpfx/wxVZaDxQ4ZVs1EvcQU5lUMykm/7YL5otTUqY8oAmoqJBBfaRwWY4Vu/Ac7xNZRopzsouHtHx1+GAvEVCWhoZs/BKRm5d0ibBxj+r7C9eE++PPvboPAg1nfi2ovYv+MG8OmPDnPmrNl2xxUbHk/KvT5Uy+mVK04TIDunGY4wj6BUPSOKZwYY8fSBoBQGxBb6QlnV6exmEQKs/To0C6ZWzkQrWRfvFMX8zkRiQ9wv18w=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22141de8-91f6-4ecc-2567-08d6b1668439
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 21:11:58.1280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2749
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Monday, March 25, 2019 2:21 PM
> To: Kirti Wankhede <kwankhede@nvidia.com>
> Cc: Parav Pandit <parav@mellanox.com>; kvm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 1/8] vfio/mdev: Fix to not do put_device on
> device_register failure
>=20
> On Mon, 25 Mar 2019 23:47:30 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>=20
> > On 3/23/2019 4:50 AM, Parav Pandit wrote:
> > > device_register() performs put_device() if device_add() fails.
> > > This balances with device_initialize().
> > >
> > > mdev core performing put_device() when device_register() fails, is
> > > an error that puts already released device again.
> > > Therefore, don't put the device on error.
> > >
> >
> > device_add() on all errors doesn't call put_device(dev). It releases
> > reference to its parent, put_device(parent), but not the device
> > itself, put_device(dev).
>=20
> Sort of, device_initialize() initializes the reference count to 1,
> device_add() increments the reference count to 2 via the get_device() and
> then drops it back to 1 on all exit paths.  The oddity is the failure pat=
h of
> get_device() itself, but that can only happen if passed a NULL device, wh=
ere
> put_device() is a no-op and not relevant here.  So in all cases
> device_register() returns with a reference count of 1 and we need to call
> put_device() to free the allocated object.  The below change would leak t=
he
> mdev on error.  Thanks,
>=20
Yes.
I missed the NOTE at the starting of device_add() comment block.
I will drop this patch in series.

> Alex
>=20
> > > Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> > > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > > ---
> > >  drivers/vfio/mdev/mdev_core.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/vfio/mdev/mdev_core.c
> > > b/drivers/vfio/mdev/mdev_core.c index 0212f0e..3e5880a 100644
> > > --- a/drivers/vfio/mdev/mdev_core.c
> > > +++ b/drivers/vfio/mdev/mdev_core.c
> > > @@ -318,10 +318,8 @@ int mdev_device_create(struct kobject *kobj,
> struct device *dev, uuid_le uuid)
> > >  	dev_set_name(&mdev->dev, "%pUl", uuid.b);
> > >
> > >  	ret =3D device_register(&mdev->dev);
> > > -	if (ret) {
> > > -		put_device(&mdev->dev);
> > > +	if (ret)
> > >  		goto mdev_fail;
> > > -	}
> > >
> > >  	ret =3D mdev_device_create_ops(kobj, mdev);
> > >  	if (ret)
> > >

