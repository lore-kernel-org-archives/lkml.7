Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CDEC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAEE2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="xZ0vneJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfCER6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:58:06 -0500
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]:11335
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726182AbfCER6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNL2PJU2VTCJ9kCQLtqfsrYqQCEpiCVPpaRc1i1tivk=;
 b=xZ0vneJyyK/uxEJwCC71e/WfGq2MKLiHscqi2hr4ICSZLf1jDNC46MzoXoBxI5uXnSBBXERyU06Vw+PzZOOV3U6Q8KPlixioPg6De2+HvzhznzN/3wypIkfdRvd5zJZLkJPymTQ2PQxm0Y07RqYltj6KHwyV6gK5Q5J5r0rabdc=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2558.eurprd05.prod.outlook.com (10.168.136.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Tue, 5 Mar 2019 17:57:59 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 17:57:59 +0000
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
Thread-Index: AQHUz/EC2njdeQVegE6Mw8pbS3FanaX2XwcAgACa0LCABawngIAAm4yA
Date:   Tue, 5 Mar 2019 17:57:58 +0000
Message-ID: <VI1PR0501MB2271AA91B5D29CA69778268BD1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <1551418672-12822-9-git-send-email-parav@mellanox.com>
 <20190301072158.GC8975@kroah.com>
 <AM4PR0501MB22603530A59C625CDF48D978D1760@AM4PR0501MB2260.eurprd05.prod.outlook.com>
 <20190305071331.GA2060@kroah.com>
In-Reply-To: <20190305071331.GA2060@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddea6bad-9373-4177-8528-08d6a1941a7a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2558;
x-ms-traffictypediagnostic: VI1PR0501MB2558:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR0501MB2558;23:TArtHYUFM967kvJ9Rc0C1IDM8Yn8ZrXkdeYBcu4?=
 =?us-ascii?Q?CajVNf6t4OPmacRhzWKqFhSYGntj+HdYX6ixPqnaeG/lYjEEno0Fb5RWS655?=
 =?us-ascii?Q?ImvQGLghQxYQirByv0XDw0J2AtbglTyDYXXDb5iaScJMm+vcZnm0SDwgseU9?=
 =?us-ascii?Q?kuJvAKQTwqP8avnGeEW0dHXIoVVGRg1vZdPNuBVroSS8357v/nZpi/Hf5rPQ?=
 =?us-ascii?Q?1/G0yRJcQMNFBaL8Ra5k4+lisdpHetDzAUT+b4xBLPhUNj7yRXBrl4IpqhkL?=
 =?us-ascii?Q?n0THrSoiWttUkXWhar1W80yMmtvcSz6fNIzG+DG1dcObD8x3NIC5rRjCOdNi?=
 =?us-ascii?Q?5SPEYZyHo5M+ymdTGSTF82oEXnNyJY8sMTD2Lo33IW5xCXGM4QAmTYc0aFsU?=
 =?us-ascii?Q?gjAwYRXmn361bjLowlmFCNX0AReDTBo1ULAeX50uThekULWUbwV6FScZt6gE?=
 =?us-ascii?Q?iRLYg5ZBvsgc/wZMUhgQzehCJcnfgXb6Hc9jxccaxGkEOwB2q513sbo45bKj?=
 =?us-ascii?Q?RVWH/60v2EibwtBEFCb/D9gLuFX6qPUJDo7dUKstjYE/+FT1rNcIKgFgydvN?=
 =?us-ascii?Q?Qttpzi5v2Sd9Bybc4W9RBU1WOKDH/5xkViAwE2ABjL/7sTBlWTjhChWbnO7/?=
 =?us-ascii?Q?lx2q3roOxVdnGpecH0ftOD6wdorRVuwr4BIV4yurSOB6r5zRIYRM7YsvaG3V?=
 =?us-ascii?Q?3kwjtC5rkxUUBbIhFeDU6HEUr0kkWyW1GGPeGzfkk9BwcFRg22DgypmkTm8L?=
 =?us-ascii?Q?HrmYKkbdMiFVYss7WLd+AcpVutTp4fXdMO1BidfPf5HZExKwfbBgyvnn5bcw?=
 =?us-ascii?Q?CmBHvqnmvO9I0iiwjyKMwPsQbf6ko97h9K8SfGKtlYwo8J8Nc52B5QJP4OJx?=
 =?us-ascii?Q?jS6umatuBTrYydWlmg3jAC7xWYECPryJt4hpLwOivwepX6l+nNlKUrjHP9mY?=
 =?us-ascii?Q?qRejwiBaNp38bnI1x0B46WPSINmOWL9bkxqmiRCQ9G/D9R+vCtV+LtooWOpx?=
 =?us-ascii?Q?dDxVtMrfe+JgkAEzVwQTJlifMx+Lwao3hkF+Drn7N9AJqzWz0MrGx80FU/uL?=
 =?us-ascii?Q?AIAp0s/nQs8XbuBAOzp/WSmN9jMtgpv8NxE0nbQiEPQgiTCfgBaMiK4Bqo4z?=
 =?us-ascii?Q?WdCtcedpTGBGjEOauZronB+G+IS7tGqM86sDHjFX3HSujRc7VRSxPuvM910a?=
 =?us-ascii?Q?Z6WTLCrmVHHqGhap/uI3OFAlSYSjznPIbAqRq/3nVZNUH3c5aV1BTf1ftJ8O?=
 =?us-ascii?Q?3GxHq5b4/VmYe2+tCWHkO9/jly7/hybPfMWxe18CwKnL3r0KpaVDPrhdWyRD?=
 =?us-ascii?Q?DFDCBC7AmouVQgHMlsjvmFLfS8Wak0BBUFvHL049U94V1roYooH8P/xEvkeC?=
 =?us-ascii?Q?FguuEXA4d4evexJlcqirNoOzCeBE=3D?=
x-microsoft-antispam-prvs: <VI1PR0501MB2558D3C91A8F0DC284B0DEFBD1720@VI1PR0501MB2558.eurprd05.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(13464003)(199004)(189003)(71200400001)(93886005)(71190400001)(6116002)(6916009)(3846002)(486006)(14454004)(7696005)(66066001)(76176011)(966005)(7736002)(476003)(478600001)(11346002)(53546011)(6506007)(105586002)(106356001)(561944003)(33656002)(99286004)(54906003)(446003)(68736007)(186003)(316002)(81156014)(81166006)(102836004)(5660300002)(26005)(5024004)(256004)(14444005)(52536013)(97736004)(8676002)(55016002)(86362001)(9686003)(74316002)(6306002)(229853002)(2906002)(8936002)(4326008)(53936002)(6436002)(6246003)(25786009)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2558;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AvNb9PfWlknTj1nkzDq+lGFFsFlAON94yVc6bY/k190oATNX3VFyohCK9+qXjFTOQcqNWyHZCrZdXa+5fMkdQ1CygZOClF2vpqvYpv0y7GhppVEMSlqQwDp4rxwereKqdTHD65KTxobz4XQ6yMQZy6d3f6Bsej6kKbxkFv97S57Cwi9Lol+2KHyycViL5ktIYRozXyH4Y0NuRofXPk98u8MdtNM5Ga3QFmEUTTFIQ0bPAIxZB1/hYKzFp8bppZuvN1wrKzXo+slxzNKh1YPtdQVEhw48VT+/Qs7D6bQb78/fqrBFB+VEM8LdZAgJ/tcFr2AjZZLJSQAY38gRjwxbVd9SjKlPmaiMqCUqY+rV82rhu6N4W+R15E3+s1shir9eXk/HbojbkrVzq4iWGiCr4P5LXvT1H0dmil+9qR8yddw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddea6bad-9373-4177-8528-08d6a1941a7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 17:57:58.9341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2558
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, March 5, 2019 1:14 AM
> To: Parav Pandit <parav@mellanox.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> michal.lkml@markovi.net; davem@davemloft.net; Jiri Pirko
> <jiri@mellanox.com>; Jakub Kicinski <jakub.kicinski@netronome.com>
> Subject: Re: [RFC net-next 8/8] net/mlx5: Add subdev driver to bind to
> subdev devices
>=20
> On Fri, Mar 01, 2019 at 05:21:13PM +0000, Parav Pandit wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Friday, March 1, 2019 1:22 AM
> > > To: Parav Pandit <parav@mellanox.com>
> > > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > michal.lkml@markovi.net; davem@davemloft.net; Jiri Pirko
> > > <jiri@mellanox.com>
> > > Subject: Re: [RFC net-next 8/8] net/mlx5: Add subdev driver to bind
> > > to subdev devices
> > >
> > > On Thu, Feb 28, 2019 at 11:37:52PM -0600, Parav Pandit wrote:
> > > > Add a subdev driver to probe the subdev devices and create fake
> > > > netdevice for it.
> > >
> > > So I'm guessing here is the "meat" of the whole goal here?
> > >
> > > You just want multiple netdevices per PCI device?  Why can't you do
> > > that today in your PCI driver?
> > >
> > Yes, but it just not multiple netdevices.
> > Let me please elaborate in detail.
> >
> > There is a swichdev mode of a PCI function for netdevices.
> > In this mode a given netdev has additional control netdev (called
> representor netdevice =3D rep-ndev).
> > This rep-ndev is attached to OVS for adding rules, offloads etc using
> standard tc, netfilter infra.
> > Currently this rep-ndev controls switch side of the settings, but not t=
he
> host side of netdev.
> > So there is discussion to create another netdev or devlink port..
> >
> > Additionally this subdev has optional rdma device too.
> >
> > And when we are in switchdev mode, this rdma dev has similar rdma rep
> device for control.
> >
> > In some cases we actually don't create netdev when it is in InfiniBand
> mode.
> > Here there is PCI device->rdma_device.
> >
> > In other case, a given sub device for rdma is dual port device, having
> netdevice for each that can use existing netdev->dev_port.
> >
> > Creating 4 devices of two different classes using one iproute2/ip or
> iproute2/rdma command is horrible thing to do.
>=20
> Why is that?
>=20
When user creates the device, user tool needs to return a device handle tha=
t got created.
Creating multiple devices doesn't make sense. I haven't seen any tool doing=
 such crazy thing.

> > In case if this sub device has to be a passthrough device, ip link comm=
and
> will fail badly that day, because we are creating some sub device which i=
s not
> even a netdevice.
>=20
> But it is a network device, right?
>=20
When there is passthrough subdevice, there won't be netdevice created.
We don't want to create passthrough subdevice using iproute2/ip tool which =
primarily works on netdevices.

> > So iproute2/devlink which works on bus+device, mainly PCI today, seems
> right abstraction point to create sub devices.
> > This also extends to map ports of the device, health, registers debug, =
etc
> rich infrastructure that is already built.
> >
> > Additionally, we don't want mlx driver and other drivers to go through =
its
> child devices (split logic in netdev and rdma) for power management.
>=20
> And how is power management going to work with your new devices?  All
> you have here is a tiny shim around a driver bus,=20
So subdevices power management is done before their parent's.
Vendor driver doesn't need to iterate its child devices to suspend/resume i=
t.

> I do not see any new
> functionality, and as others have said, no way to actually share, or spli=
t up,
> the PCI resources.
>=20
devlink tool create command will be able to accept more parameters during d=
evice creation time to share and split PCI resources.
This is just the start of the development and RFC is to agree on direction.
devlink tool has parameters options that can be queried/set and existing in=
fra will be used for granular device config.

> > Kernel core code does that well today, that we like to leverage through
> subdev bus or mfd pm callbacks.
> >
> > So it is lot more than just creating netdevices.
>=20
> But that's all you are showing here :)
>=20
Starting use case is netdev and rdma, but we don't want to create new tools=
 few months/a year later for passthrough mode or for different link layers =
etc.

> > > What problem are you trying to solve that others also are having
> > > that requires all of this?
> > >
> > > Adding a new bus type and subsystem is fine, but usually we want
> > > more than just one user of it, as this does not really show how it
> > > is exercised very well.
> > This subdev and devlink infrastructure solves this problem of creating
> smaller sub devices out of one PCI device.
> > Someone has to start.. :-)
>=20
> That is what a mfd should allow you to do.
>=20
I did cursory look at mfd.
It lacks removing specific devices, but that is small. It can be enhanced t=
o remove specific mfd device.

> > To my knowledge, currently Netronome, Broadcom and Mellanox are
> actively using this devlink and switchdev infra today.
>=20
> Where are they "using it"?  This patchset does not show that.
>=20
devlink and swhichdev mode for SRIOV is common among these vendors and more=
.
The code is in,
drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
drivers/net/ethernet/netronome/nfp/nfp_net_main.c
drivers/net/ethernet/mellanox/mlx5/core/main.c

This patchset covers only mlx5, but other vendors who also intent to create=
 subdevices will be able to reuse it.
This RFC doesn't cover other vendors.
Jakub and netdev list in CC. We are discussing with Jakub in this patchset =
discussion.

> > > Ideally 3 users would be there as that is when it proves itself that
> > > it is flexible enough.
> > >
> >
> > We were looking at drivers/visorbus if we can repurpose it, but GUID
> device naming scheme is just not user friendly.
>=20
> You can always change the naming scheme if needed.  But why isn't a GUID
> ok?=20
I think it was ok.
vendor-device id scheme seems more user friendly and in kernels control, al=
so fits with existing modpost tools.
GUID can be used instead of vendor, device id.
However visorbus is tied to acpi and device life cycle is very different un=
der workqueue handlering.
It is also meant for a vendor s-Par devices.
Its guest drivers are in staging without a clear roadmap for more than year=
 now.
So do not want to depend on it. mfd or dedicated bus seems better fit.

> It's very easy to reserve properly, and you do not need a central naming
> "authority".
>=20
> > > Would just using the mfd subsystem work better for you?  That
> > > provides core support for "multi-function" drivers/devices already.
> > > What is missing from that subsystem that does not work for you here?
> > >
> > We were not aware of mfd until now. I looked at very high level now. It=
's a
> wrapper to platform devices and seems widely use.
> > Before subdev proposal, Jason suggested an alternative is to create
> platform devices and driver attach to it.
> >
> > When I read kernel documentation [1], it says "platform devices typical=
ly
> appear as autonomous entities"
> > Here instead of autonomy, it is in user's control.
> > Platform devices probably don't disappear a lot in live system as oppos=
ed
> to subdevices which are created and removed dynamically a lot often.
> >
> > Not sure if platform device is abuse for this purpose or not.
>=20
> No, do not abuse a platform device.=20
Yes. that is my point mfd devices are platform devices.
mfd creates platform devices. and to match to it, platfrom_register_driver(=
) have to be called to bind to it.
I do not know currently if we have the flexibility to say that instead of b=
inding X driver, bind Y driver for platform devices.

> You should be able to just use a normal
> PCI device for this just fine, and if not, we should be able to make the
> needed changes to mfd for that.
>=20
Ok. so parent pci device and mfd devices.
mfd seems to fit this use case.
Do you think 'Platform devices' section is stale in [1] for autonomy, host =
bridge, soc platform etc points?
Should we update the documentation to indicate that it can be used for non-=
autonomous, user created devices and it can be used for creating devices on=
 top of PCI parent device etc?

 [1] https://www.kernel.org/doc/Documentation/driver-model/platform.txt
