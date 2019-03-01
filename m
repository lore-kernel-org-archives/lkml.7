Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3986C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CC520850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="n7dSlOzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389416AbfCARVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:21:22 -0500
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:27440
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726416AbfCARVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr2AVbD56R8K1BbP8bBkIO65IwlcDxT4CWIpEXstr/Q=;
 b=n7dSlOzLcGWEgakhVUSuqr/ArSKTNa8qIq4k2WA600Ufq/gT8TumXMEkXMCADAy17odfBDbaL/uHAfc7w3/FsLEPqRGZmNPisAvupNSokicrJWW6SEcnJdSAvt3bZDVyn0Prkb5XklbWHUpRYD/qw7uSL9IgdJuY1z+F6Tla3/w=
Received: from AM4PR0501MB2260.eurprd05.prod.outlook.com (10.165.82.137) by
 AM4PR0501MB2610.eurprd05.prod.outlook.com (10.172.215.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Fri, 1 Mar 2019 17:21:13 +0000
Received: from AM4PR0501MB2260.eurprd05.prod.outlook.com
 ([fe80::493b:13fd:1969:bb2b]) by AM4PR0501MB2260.eurprd05.prod.outlook.com
 ([fe80::493b:13fd:1969:bb2b%6]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 17:21:13 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: RE: [RFC net-next 8/8] net/mlx5: Add subdev driver to bind to subdev
 devices
Thread-Topic: [RFC net-next 8/8] net/mlx5: Add subdev driver to bind to subdev
 devices
Thread-Index: AQHUz/EC2njdeQVegE6Mw8pbS3FanaX2XwcAgACa0LA=
Date:   Fri, 1 Mar 2019 17:21:13 +0000
Message-ID: <AM4PR0501MB22603530A59C625CDF48D978D1760@AM4PR0501MB2260.eurprd05.prod.outlook.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <1551418672-12822-9-git-send-email-parav@mellanox.com>
 <20190301072158.GC8975@kroah.com>
In-Reply-To: <20190301072158.GC8975@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1486a780-e11a-4f9a-f087-08d69e6a4df2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0501MB2610;
x-ms-traffictypediagnostic: AM4PR0501MB2610:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM4PR0501MB2610;23:ozDMkzVav9FTapMLwPMnHpm/STYCSLAqYMFcJjq?=
 =?us-ascii?Q?q4MYPiAVHla57Z5o5HAGdVo3FCDwI0X4A0nlJsqM/SMhwrbmwfyvJPSAA1Hh?=
 =?us-ascii?Q?mX4CHUpHT20c0G0JwBbd+WV1D1eVNoQ8pbltIZwWfQLvUsSfSiD/qJMq3u60?=
 =?us-ascii?Q?oB9Hsf8/thNYBknwlOxr21a142Pg4DogEkhUlj6TO28v9NlkmDiDKCJSBSTS?=
 =?us-ascii?Q?vTIqN+wPYG5Ju5e+/VSl6vJpFXfv69wYR/dBjpLKtqmbovYAWKUHZWn4IQcm?=
 =?us-ascii?Q?hPtPZZjbhlHeaDd8+H1jsfR9fNtnpYncoYJgtvhzSAr1O74ubhxENrNz7PjV?=
 =?us-ascii?Q?QRrjyFmhTWU98wQHB+jNOr/sXRGetYM2v084kLUv5q/gWM7PeG+/P3HjwMut?=
 =?us-ascii?Q?cfLc5ed9KIL+Qhs+tZ4esbQ69ko6IXZiq10tEIlHMB6QoT9GlSrLYJ7jdnEm?=
 =?us-ascii?Q?4lOnhBWBNT5QdFqMnSgqPnUXIzyHQbT21xw1k5Mqgu4CnJGwrQ98bfak334V?=
 =?us-ascii?Q?jpJViIcW71RT90c5VEalq6hkDQnrbyrIdABJLGRku03xdOT4xaga2TsSUNkA?=
 =?us-ascii?Q?xxJySpHnsoB3Gjk9xPM+QLxvCRi1UXfMFVoYPSHOHteGKg2GVTegJLdzes1a?=
 =?us-ascii?Q?uZoStm5Rku2Y7oxjzrEyc7rjmsIgVesuOnXBklx5NO9irccdS95fboaBiL/t?=
 =?us-ascii?Q?aqbx7+VLsXWX+p5Tm5v7BoSG70i9nAvya2o+uJNzEYLqPm8+5c2bXlIny3Vy?=
 =?us-ascii?Q?ILE0yIVLwFylVUjuFHIMvEpJ2vKFMPLgCMxKsN0OKgYADHwNso5zBkgXDAQv?=
 =?us-ascii?Q?MO8xHE7ROu5N9Dq9EenEo4yUUYmiD/31iEvvWKAu52XL+nW4swEcfFU6l5Qx?=
 =?us-ascii?Q?HXE8o5m/jMRpPdzEZME2Tx2ugCy8yRBHnXOw/KScukKfC3h90LI5M1XcnxbF?=
 =?us-ascii?Q?C1xRKext9Pgmv6SKLlAiYmg7BGkSEPR12LWtnwQM3lncDANT2Z4UqOP65BB7?=
 =?us-ascii?Q?w9eRZjA48cAtOdMoC0JD2GEwUfgTQQRe15YvgmqKcZjCvs+Me4ujQmfdD73q?=
 =?us-ascii?Q?d0ULBA2dEhI5TfnMJ2BGW1oQB/RYDUq1TbwUf7D4/Q5xeL4JHdO6etDuKcXb?=
 =?us-ascii?Q?SpOWqImh4eRNE3H0MRl8g57JllQBNsWf5Wx96UGGWvBXRIoBqzh7hBgGEFWt?=
 =?us-ascii?Q?XsfD0TD2S+qU3++HkEwU+jOMKLx6F1albKKYuMstO3QqLlWP6meVpiyaDGE4?=
 =?us-ascii?Q?CIcqaVZx66U3I9v+4TKUNidy/CfTqqjSZUH9fP7+kdoxaeaCZCrHP7SH57/8?=
 =?us-ascii?Q?A8cmevaOiAhD+hpSjK7mX0I24tHYcRNiKv9ExoaWvzFnK?=
x-microsoft-antispam-prvs: <AM4PR0501MB26103296BBB4496D7CBA9039D1760@AM4PR0501MB2610.eurprd05.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(396003)(346002)(376002)(199004)(189003)(13464003)(102836004)(6246003)(6436002)(6506007)(53546011)(5660300002)(4326008)(52536013)(53936002)(66066001)(99286004)(25786009)(71190400001)(71200400001)(97736004)(105586002)(86362001)(106356001)(186003)(26005)(74316002)(305945005)(6916009)(7736002)(54906003)(966005)(256004)(5024004)(8936002)(14454004)(561944003)(478600001)(68736007)(9686003)(81156014)(8676002)(11346002)(316002)(81166006)(55016002)(76176011)(7696005)(486006)(6306002)(476003)(229853002)(446003)(6116002)(2906002)(33656002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0501MB2610;H:AM4PR0501MB2260.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AtMdW7i+ReLMqPV5p8XijzsWM+mHBaHfKrdP2zhJ0dciu0y1iL9yPEnJWFPJTwvXSumqJpcW6UxJRUl9ffq1yaxBdqx8+Q+ZmJorF6k4rFZiT8eiwIJXxED+JQ2pk2uHu8ooYVfbOoSWCtME8irLtUo5olKFYuMgC8UdAif2H//8QmUc5IMu55wJ34yPpe0BXbnFXN2UzD+Zt1ICIJ+dnWFr1Quzov4hVmQSyRLHJGaSymLuGuF/EXzIFsura+d3XBOHPM/ATwoPK2U2tIw+S8a0D9ijlTAd1oK/r2bhMbB4pMsfzWGCYN0GsRI3tuLwHkCwaq4B4fwCCqvZnSYTJ9MWuY8aLU6Map3XEFSknthlfEwCxsaDGVKXaC8t+mufEO3Vx2iB3ntKUNGk/gEKX7brznv8bzkPfKhs17vWKzA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1486a780-e11a-4f9a-f087-08d69e6a4df2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 17:21:13.0312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, March 1, 2019 1:22 AM
> To: Parav Pandit <parav@mellanox.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> michal.lkml@markovi.net; davem@davemloft.net; Jiri Pirko
> <jiri@mellanox.com>
> Subject: Re: [RFC net-next 8/8] net/mlx5: Add subdev driver to bind to
> subdev devices
>=20
> On Thu, Feb 28, 2019 at 11:37:52PM -0600, Parav Pandit wrote:
> > Add a subdev driver to probe the subdev devices and create fake
> > netdevice for it.
>=20
> So I'm guessing here is the "meat" of the whole goal here?
>=20
> You just want multiple netdevices per PCI device?  Why can't you do that
> today in your PCI driver?
>=20
Yes, but it just not multiple netdevices.
Let me please elaborate in detail.

There is a swichdev mode of a PCI function for netdevices.
In this mode a given netdev has additional control netdev (called represent=
or netdevice =3D rep-ndev).
This rep-ndev is attached to OVS for adding rules, offloads etc using stand=
ard tc, netfilter infra.
Currently this rep-ndev controls switch side of the settings, but not the h=
ost side of netdev.
So there is discussion to create another netdev or devlink port..

Additionally this subdev has optional rdma device too.

And when we are in switchdev mode, this rdma dev has similar rdma rep devic=
e for control.

In some cases we actually don't create netdev when it is in InfiniBand mode=
.
Here there is PCI device->rdma_device.

In other case, a given sub device for rdma is dual port device, having netd=
evice for each that can use existing netdev->dev_port.

Creating 4 devices of two different classes using one iproute2/ip or iprout=
e2/rdma command is horrible thing to do.

In case if this sub device has to be a passthrough device, ip link command =
will fail badly that day, because we are creating some sub device which is =
not even a netdevice.

So iproute2/devlink which works on bus+device, mainly PCI today, seems righ=
t abstraction point to create sub devices.
This also extends to map ports of the device, health, registers debug, etc =
rich infrastructure that is already built.

Additionally, we don't want mlx driver and other drivers to go through its =
child devices (split logic in netdev and rdma) for power management.
Kernel core code does that well today, that we like to leverage through sub=
dev bus or mfd pm callbacks.

So it is lot more than just creating netdevices.

> What problem are you trying to solve that others also are having that
> requires all of this?
>=20
> Adding a new bus type and subsystem is fine, but usually we want more
> than just one user of it, as this does not really show how it is exercise=
d very
> well.
This subdev and devlink infrastructure solves this problem of creating smal=
ler sub devices out of one PCI device.
Someone has to start.. :-)

To my knowledge, currently Netronome, Broadcom and Mellanox are actively us=
ing this devlink and switchdev infra today.
I added Jakub from Netronome, he is in netdev mailing list, but added in CC=
, to listen his feedback.

> Ideally 3 users would be there as that is when it proves itself that it i=
s
> flexible enough.
>=20

We were looking at drivers/visorbus if we can repurpose it, but GUID device=
 naming scheme is just not user friendly.
It has only single s-Par user and whose guest drivers are still in staging =
for more than a year now. So doesn't really fit well.

> Would just using the mfd subsystem work better for you?  That provides
> core support for "multi-function" drivers/devices already.  What is missi=
ng
> from that subsystem that does not work for you here?
>=20
We were not aware of mfd until now. I looked at very high level now. It's a=
 wrapper to platform devices and seems widely use.
Before subdev proposal, Jason suggested an alternative is to create platfor=
m devices and driver attach to it.

When I read kernel documentation [1], it says "platform devices typically a=
ppear as autonomous entities"
Here instead of autonomy, it is in user's control.
Platform devices probably don't disappear a lot in live system as opposed t=
o subdevices which are created and removed dynamically a lot often.

Not sure if platform device is abuse for this purpose or not.
So which direction to go, devlink->mfd(platform wrapper) or devlink->subdev=
 would be obviously a huge blessing.

[1] https://www.kernel.org/doc/Documentation/driver-model/platform.txt

