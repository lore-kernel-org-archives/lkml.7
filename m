Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA1AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C9120675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="HLOQSoKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfCEVhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:37:55 -0500
Received: from mail-eopbgr60042.outbound.protection.outlook.com ([40.107.6.42]:45994
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbfCEVhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPD8ehomrlbyN7A/s2eNuQe2fb2Rce/FNq3QIHgokkU=;
 b=HLOQSoKCFqqPY9fpNxyVHslcv2l+lVIE3h/JEAg+bpfwG2rJG4dyE5YsZDS+U13adPplYUlU8p7Qo3cY//gOV6TVWr5VhX/AGADbieIKf9bLvQQKkTHtYJZ6SJNaBwylC78K+fsB+syxbq1+WjlJdsqSZR/JOHCpOl3fyTnci14=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2463.eurprd05.prod.outlook.com (10.168.136.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Tue, 5 Mar 2019 21:37:46 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 21:37:46 +0000
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
Thread-Index: AQHUz/EC2njdeQVegE6Mw8pbS3FanaX2XwcAgACa0LCABawngIAAm4yAgAAxhYCAAAmMYA==
Date:   Tue, 5 Mar 2019 21:37:46 +0000
Message-ID: <VI1PR0501MB2271596CB9BDE2CC1A11AC46D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <1551418672-12822-9-git-send-email-parav@mellanox.com>
 <20190301072158.GC8975@kroah.com>
 <AM4PR0501MB22603530A59C625CDF48D978D1760@AM4PR0501MB2260.eurprd05.prod.outlook.com>
 <20190305071331.GA2060@kroah.com>
 <VI1PR0501MB2271AA91B5D29CA69778268BD1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190305192729.GA17047@kroah.com>
In-Reply-To: <20190305192729.GA17047@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 669afcc3-a962-40a9-669e-08d6a1b2cf0d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2463;
x-ms-traffictypediagnostic: VI1PR0501MB2463:
x-ms-exchange-purlcount: 4
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR0501MB2463;23:Z865UhyKSJJHEYpEe1GnC9eZpRY3OL4pK1O9K5k?=
 =?us-ascii?Q?Z6j1IrjUDjBGLFDVi3RbcuDGaf5yakHGg92ZjR/VRWVdVOiZv7ii0mMuKzYR?=
 =?us-ascii?Q?ZmVh0yGZq62a6zNtOdFWJ55W+h2zkPCJDRiYU70Q1LT14WArX8tAtgqQ6982?=
 =?us-ascii?Q?cUxK6+uQXbldI2JlcWerRNXhRv5dcIDOxinLZoeVjXblWPm76k8Q4oGz8McA?=
 =?us-ascii?Q?APmgCyl2gMn7R84uyH6gWkB/g9kKZj6tiFJDhP8WHiY73uKbXhpp+FFfq3y7?=
 =?us-ascii?Q?Y4N+n8tSn71QoTjueshV+L7ZhH9MPI2eB/pKdqa5x0R9A/ieX/npkcb6M5Fr?=
 =?us-ascii?Q?2JkqLdJd5Qu4zAfesBhpxsVGOe2/tc4qCOgfJQhoqhQkZOmud+pxbB+dsiQw?=
 =?us-ascii?Q?/JwWRVvq7RM1G5h9pyF0SKoktk8jiIRMjAA76x9I6jceNGszeIw6HvN+nCbC?=
 =?us-ascii?Q?ecpOxozEBHmVqqBO+HQeYwC2gmTLipzTspbEwUCnN9JRXPij66+pW/VDAJ2G?=
 =?us-ascii?Q?Q7BAvtcQrc6xiD9HG81nMnXQiXhd+gn7T1sF7S4M4vPzhTLtIBViu8D4+qtv?=
 =?us-ascii?Q?v7PyTliHLHmzxSZul2cziW9VMCsISEpsw8uJipD2dqx4mzJFVf4xvNHSIhb1?=
 =?us-ascii?Q?MMHjh1WTiGEkeb2yo3Bzi78funrkY/9N4ZhWxnGR3cLUlZD1FGpKcydajNOi?=
 =?us-ascii?Q?o+JZlgtkOV9xgey2qSQqFaZKfl33jQAWcpFwIP2OKNG91+iCVbnSgPXbs9V+?=
 =?us-ascii?Q?JiI3nRmDvKHXH3oDMhy4WlU5/7WZyubKTFa496STJSAa1ReH/8PHwVSSFkOo?=
 =?us-ascii?Q?FNvM9cc9ULZiujr0ju3RywU0pnHPldQ+xypxU1Pq1Z7CQqtcBV7uMWyDb0+h?=
 =?us-ascii?Q?i1xwyB6rVwbYXLkqduPnl0isOC+aDJw9GYqhPFU5XE963t7fqy2+UD1e0CRP?=
 =?us-ascii?Q?rVGSClmBXeqaYj8/nmgtGemLDK0ZyRUpinAZ3BKm1pd/d+mJre2wcKYhbnW2?=
 =?us-ascii?Q?Iucgy10CJYGnihoO0xEBoixI27BfIdUV9dZfEQVuVZvhTw/WEXW9YegvUFMH?=
 =?us-ascii?Q?2R2w1CbIJ8tOztfcaaQIlgLTPn5LF02EYo7A0pA6b8WyHD2Ygux0FeQ6SToc?=
 =?us-ascii?Q?N0vvZRcBeQ7BcnfEwPBuW5SgozdXhDl0+eIFtXo4eR4HyLpMvHCYOcdkwPlR?=
 =?us-ascii?Q?6NzEsybclcqHVjNpM5GKVdiNTHvMjpnSQ6G4e6FCWpuTyPCD5bBYYvaPTE6e?=
 =?us-ascii?Q?/u4eDf0+apS81ROlwnCP1tvCDWvo2jkgu6gFOWmXk1PKFPkDduwL/8a/xThG?=
 =?us-ascii?Q?oEbq9qXofEf751HYaFF+7zJbn6IoO3So20CR/hhSYZQZG8TnYJBySICtSHEw?=
 =?us-ascii?Q?Zd2R3eF8Z63tEmucERNSEamIz2d8=3D?=
x-microsoft-antispam-prvs: <VI1PR0501MB2463B7E23E10B71D3E1AB662D1720@VI1PR0501MB2463.eurprd05.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(376002)(346002)(13464003)(199004)(189003)(7696005)(55016002)(6306002)(478600001)(9686003)(966005)(106356001)(6436002)(68736007)(105586002)(97736004)(8936002)(53936002)(11346002)(86362001)(229853002)(446003)(486006)(74316002)(186003)(7736002)(305945005)(6916009)(14454004)(3846002)(2906002)(76176011)(8676002)(53376002)(93886005)(5660300002)(71200400001)(71190400001)(25786009)(53546011)(6506007)(14444005)(476003)(33656002)(5024004)(54906003)(26005)(256004)(81166006)(81156014)(6116002)(316002)(6246003)(52536013)(99286004)(4326008)(102836004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2463;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 48ZhjRvs4FFEzxE7WGaL3VBNKdXwKZKYhP4R6n868LdmoKcn/M2EKmOKy+MlQlvU2FZ3p7ZX+UDAgK3RsRT4/J42MbrVJefhfzpz25dTLjJKZMgj59gy4Jz6P6+V2swk7N23nO5Ok7Tm47/CW6ZaQKdNtoioplnUdfHSYUSElKsqLHNnnrJ9fDeloKXixRgnRQMR/Mg0pBVrL45Bv/akF43oalB3LbZ8XpigPbgiC8oLvgVdP9TRniiBxj4dWdgNMF4TiYh1obp4gbHEXdhK+6XP8xY8AjHjWomNArOhalTPZPEuwIyMm4iTm7UNOKRDa1+aqE5SJlrbbkY5kJEWIgDui2AJXAxXFJMC/RToXV2TR4wSjvL2Fr4Glqhktt6BpxZu+WdOG9KxusfRSykVWWhyE2oA32nu5jgGP0AKb78=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669afcc3-a962-40a9-669e-08d6a1b2cf0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 21:37:46.8475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, March 5, 2019 1:27 PM
> To: Parav Pandit <parav@mellanox.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> michal.lkml@markovi.net; davem@davemloft.net; Jiri Pirko
> <jiri@mellanox.com>; Jakub Kicinski <jakub.kicinski@netronome.com>
> Subject: Re: [RFC net-next 8/8] net/mlx5: Add subdev driver to bind to
> subdev devices
>=20
> On Tue, Mar 05, 2019 at 05:57:58PM +0000, Parav Pandit wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Tuesday, March 5, 2019 1:14 AM
> > > To: Parav Pandit <parav@mellanox.com>
> > > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > michal.lkml@markovi.net; davem@davemloft.net; Jiri Pirko
> > > <jiri@mellanox.com>; Jakub Kicinski <jakub.kicinski@netronome.com>
> > > Subject: Re: [RFC net-next 8/8] net/mlx5: Add subdev driver to bind
> > > to subdev devices
> > >
> > > On Fri, Mar 01, 2019 at 05:21:13PM +0000, Parav Pandit wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > > Sent: Friday, March 1, 2019 1:22 AM
> > > > > To: Parav Pandit <parav@mellanox.com>
> > > > > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > > michal.lkml@markovi.net; davem@davemloft.net; Jiri Pirko
> > > > > <jiri@mellanox.com>
> > > > > Subject: Re: [RFC net-next 8/8] net/mlx5: Add subdev driver to
> > > > > bind to subdev devices
> > > > >
> > > > > On Thu, Feb 28, 2019 at 11:37:52PM -0600, Parav Pandit wrote:
> > > > > > Add a subdev driver to probe the subdev devices and create
> > > > > > fake netdevice for it.
> > > > >
> > > > > So I'm guessing here is the "meat" of the whole goal here?
> > > > >
> > > > > You just want multiple netdevices per PCI device?  Why can't you
> > > > > do that today in your PCI driver?
> > > > >
> > > > Yes, but it just not multiple netdevices.
> > > > Let me please elaborate in detail.
> > > >
> > > > There is a swichdev mode of a PCI function for netdevices.
> > > > In this mode a given netdev has additional control netdev (called
> > > representor netdevice =3D rep-ndev).
> > > > This rep-ndev is attached to OVS for adding rules, offloads etc
> > > > using
> > > standard tc, netfilter infra.
> > > > Currently this rep-ndev controls switch side of the settings, but
> > > > not the
> > > host side of netdev.
> > > > So there is discussion to create another netdev or devlink port..
> > > >
> > > > Additionally this subdev has optional rdma device too.
> > > >
> > > > And when we are in switchdev mode, this rdma dev has similar rdma
> > > > rep
> > > device for control.
> > > >
> > > > In some cases we actually don't create netdev when it is in
> > > > InfiniBand
> > > mode.
> > > > Here there is PCI device->rdma_device.
> > > >
> > > > In other case, a given sub device for rdma is dual port device,
> > > > having
> > > netdevice for each that can use existing netdev->dev_port.
> > > >
> > > > Creating 4 devices of two different classes using one iproute2/ip
> > > > or
> > > iproute2/rdma command is horrible thing to do.
> > >
> > > Why is that?
> > >
> > When user creates the device, user tool needs to return a device handle
> that got created.
> > Creating multiple devices doesn't make sense. I haven't seen any tool
> doing such crazy thing.
>=20
> And what do you mean by "device handle"?  All you get here is a sysfs dev=
ice
> tree.
>=20
Subdev devices are created using devlink tool that works on device handle.
Device handle is defined using bus/device of a 'struct device'.
It is described in [1].
$ devlink dev add DEV creates new devlink device instance and its holding '=
struct device'.
This command returns device handle =3D new devlink instance bus/name.
Patch 6 in the series returns device handle.
Patch 6 is at [2] with example in it where sysfs name and devlink matches w=
ith each other.

> > > > In case if this sub device has to be a passthrough device, ip link
> > > > command
> > > will fail badly that day, because we are creating some sub device
> > > which is not even a netdevice.
> > >
> > > But it is a network device, right?
> > >
> > When there is passthrough subdevice, there won't be netdevice created.
> > We don't want to create passthrough subdevice using iproute2/ip tool
> which primarily works on netdevices.
>=20
> I don't know enough networking to claim anything here, so I'll ignore thi=
s :)
>=20
> > > > So iproute2/devlink which works on bus+device, mainly PCI today,
> > > > seems
> > > right abstraction point to create sub devices.
> > > > This also extends to map ports of the device, health, registers
> > > > debug, etc
> > > rich infrastructure that is already built.
> > > >
> > > > Additionally, we don't want mlx driver and other drivers to go
> > > > through its
> > > child devices (split logic in netdev and rdma) for power management.
> > >
> > > And how is power management going to work with your new devices?
> > > All you have here is a tiny shim around a driver bus,
> > So subdevices power management is done before their parent's.
> > Vendor driver doesn't need to iterate its child devices to suspend/resu=
me
> it.
>=20
> True, so we can just autosuspend these "children" device and the "vendor
> driver" is not going to care?  You are going to care as you are talking t=
o the
> same PCI device. =20
Oh, vendor driver certainly care.
subdev vendor driver implements driver->pm callbacks to work on just a spec=
ific subdev.
Patch-2 in series at [3] implement shim layer by connecting core pm layer t=
o driver pm callbacks.

> This goes to the other question about "how are you
> sharing PCI device resources?"
>=20
Currently its equal distribution among all subdevices.
But when actual user arise to ask for specific resource reservation etc, we=
 add those parameters using existing devlink infra [4].

> > > I do not see any new
> > > functionality, and as others have said, no way to actually share, or
> > > split up, the PCI resources.
> > >
> > devlink tool create command will be able to accept more parameters
> during device creation time to share and split PCI resources.
> > This is just the start of the development and RFC is to agree on direct=
ion.
> > devlink tool has parameters options that can be queried/set and existin=
g
> infra will be used for granular device config.
>=20
> Pointers to this beast?
>=20
[1] and [4].

> > > > Kernel core code does that well today, that we like to leverage
> > > > through
> > > subdev bus or mfd pm callbacks.
> > > >
> > > > So it is lot more than just creating netdevices.
> > >
> > > But that's all you are showing here :)
> > >
> > Starting use case is netdev and rdma, but we don't want to create new
> > tools few months/a year later for passthrough mode or for different
> > link layers etc.
>=20
> And I don't want to see duplicated driver model code happen either, which
> is why I point out the MFD layer :)
>=20
Yes. Sure.

> > > > > What problem are you trying to solve that others also are having
> > > > > that requires all of this?
> > > > >
> > > > > Adding a new bus type and subsystem is fine, but usually we want
> > > > > more than just one user of it, as this does not really show how
> > > > > it is exercised very well.
> > > > This subdev and devlink infrastructure solves this problem of
> > > > creating
> > > smaller sub devices out of one PCI device.
> > > > Someone has to start.. :-)
> > >
> > > That is what a mfd should allow you to do.
> > >
> > I did cursory look at mfd.
> > It lacks removing specific devices, but that is small. It can be
> > enhanced to remove specific mfd device.
>=20
> That should be easy enough, work with the MFD developers.  I think
> something like that should work today as you can use USB devices with MFD=
,
> right?
>=20
> > >
> > > No, do not abuse a platform device.
> > Yes. that is my point mfd devices are platform devices.
> > mfd creates platform devices. and to match to it, platfrom_register_dri=
ver()
> have to be called to bind to it.
> > I do not know currently if we have the flexibility to say that instead =
of
> binding X driver, bind Y driver for platform devices.
>=20
> try it :)
>=20
> > > You should be able to just use a normal PCI device for this just
> > > fine, and if not, we should be able to make the needed changes to
> > > mfd for that.
> > >
> > Ok. so parent pci device and mfd devices.
> > mfd seems to fit this use case.
> > Do you think 'Platform devices' section is stale in [1] for autonomy, h=
ost
> bridge, soc platform etc points?
>=20
> Nope, they are still horrible things and I hate them :)
>=20
> Maybe we should just make MFD create "virtual" devices (bare ones, no
> need for platform stuff), and that would solve the issue of the platform
> device bloat being drug around everywhere.
>=20
If you mean virtual MFD devices in /sys/devices/virtual/, than, it becomes =
difficult to do their life cycle using devlink because, devlink handle =3D =
bus+device.
devlink will fail to work. Inventing new tool and make it work with devlink=
 wouldn't work.

virtual device has bus=3DNULL.
mfd device currently has bus_type=3Dplatform.

We still need to link subdevice to parent pci for power_mgmt to work, right=
?
And also to see right device hierarchy.
Don't you think subdev bus is actually able to link all the pieces together=
?
devlink, sysfs, core kernel, vendor drivers..

> > Should we update the documentation to indicate that it can be used for
> > non-autonomous, user created devices and it can be used for creating
> > devices on top of PCI parent device etc?
>=20
> Nope, leave it alone please.
>=20
> thanks,
>=20
> greg k-h

[1] http://man7.org/linux/man-pages/man8/devlink-dev.8.html
[2] https://lore.kernel.org/patchwork/patch/1046995/
[3] https://lore.kernel.org/patchwork/patch/1046996/
[4] https://lore.kernel.org/patchwork/patch/959280/


