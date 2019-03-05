Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF35C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14920205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="sQgeoZdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfCETqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:46:35 -0500
Received: from mail-eopbgr00050.outbound.protection.outlook.com ([40.107.0.50]:22056
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726221AbfCETqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O8ACooDGr8UBJwi/W/Tvqr01NcjoQ/XuCqtjZ/a3Xs=;
 b=sQgeoZdC8OT9AJZFRuNKiXYqbYltEGkpEdeS1RpxjqcJp8dwoMDRMhgWZMEz0+6ma78G4RIAvmaZabrEwH/rFshLaUuWewI5WeX2n8COamJZQRuB+BNR/RyjpTuS1hlM9OpcO+WAifShnJ0ksaf8yrkHRuDjb3bolNtD7iz6yu0=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2191.eurprd05.prod.outlook.com (10.169.134.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Tue, 5 Mar 2019 19:46:27 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 19:46:27 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Or Gerlitz <gerlitz.or@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jiri Pirko <jiri@mellanox.com>
Subject: RE: [RFC net-next 0/8] Introducing subdev bus and devlink extension
Thread-Topic: [RFC net-next 0/8] Introducing subdev bus and devlink extension
Thread-Index: AQHUz/D0zHEkReNVsEa2RSWOI/Q4NKX3M+0AgAOlj4CAAW4QgIABFdqg
Date:   Tue, 5 Mar 2019 19:46:27 +0000
Message-ID: <VI1PR0501MB227144934A3FE9460D6970E5D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
        <20190301120358.7970f0ad@cakuba.netronome.com>
        <VI1PR0501MB227107F2EB29C7462DEE3637D1710@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190304173529.59aef2b3@cakuba.netronome.com>
In-Reply-To: <20190304173529.59aef2b3@cakuba.netronome.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7044325a-92c9-47a6-4264-08d6a1a341d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2191;
x-ms-traffictypediagnostic: VI1PR0501MB2191:
x-ms-exchange-purlcount: 2
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR0501MB2191;23:O1kq8yXUgiwE0qyOIS/7VimhN7U9pWQizCmda2o?=
 =?us-ascii?Q?jgBe3SrAgmo8zsQhqOzA+u8IFTn+46GI2mr7jpKdbA0HtuuDX1vvHoqNgh3i?=
 =?us-ascii?Q?DeLe2XfPc9WczkQPubehldQxlNxj7I0SqSh6fppD4jSHgri0b432tQOD72cO?=
 =?us-ascii?Q?2bUoFcv6HTgEId15lgckI3l55t6O1kIaQFeZalhtsHOF2WJPpOKKssH4Fqjf?=
 =?us-ascii?Q?B+woU5XaIUw1U9N3f0rUHo4UXVqZfblEEfK3x6HMusV9zAflQN6JaoRX0P14?=
 =?us-ascii?Q?J24niGn2VztbcN2XQgNns8ixCOk4e9rLoo03p+Ji2ZZT2jGQ803pLe/hm6lq?=
 =?us-ascii?Q?YDTJX3T5TAuMpNtz6iA51fsTlXFpLQLgw1djVQy4LR+AUjvZ51Dh9dg7gBEw?=
 =?us-ascii?Q?40fFW1HyfzP30bnmZRgGYefz1Y+geIWiSCMnjuG8uXC2fvjAo+MvhtOip4EJ?=
 =?us-ascii?Q?9H8HdzLsKBlJoktQ4n68ny7FMADHjo8cTwGUt74mw5UenC5HVWgn3c03DJGI?=
 =?us-ascii?Q?BRmA/IuHmI4QIaNFDU0wQBu62s2JxRsFyKG7/pOQCdTz1qvfDWcV0dVjDdBD?=
 =?us-ascii?Q?eshJh5XhsyZGm2dBH7nrQEb5UsLEAjfTRIbo5MZnhooQc0x9axe0icqxFxbz?=
 =?us-ascii?Q?Dr/TR8jMN8rZZ+3bbfD2Wyuek42Ctt+mpYJ87cYryNsOmrKGgBAcLEHBzM1Q?=
 =?us-ascii?Q?YbygipTyRy5CMggYfwQ/vWzQSKmyl7HHfO2s0Wyvbvwkt4Siih8R3WqLzP1j?=
 =?us-ascii?Q?8FLvc29W2SsE0To4UQzDTxvieGoFlnmIhPajnK0MjTXb6Vt2pxQ7lpxOPrym?=
 =?us-ascii?Q?kEWJiFTwQ8rvWjUv3GX5HyJ3qNlpk98y6IL0c+eGUDlW3IfcXsJ6PgaDn8/Y?=
 =?us-ascii?Q?UKCUTwk+mWudI6HFeo2rGaLlqg1N4QSn+is0fgmYdbhpiCWjqVp9aY7x/PU6?=
 =?us-ascii?Q?lNPG2lMhnTWTdnOpMptq7BxCcdUYCdUyF4v4bB4niQamu1tBpLYNsrv2XxXh?=
 =?us-ascii?Q?/Aan3EffpDxl7i1TFPDrMsv4yrQAGbePlQl9GRs94vD8Oi2RhisyRe+e8eD7?=
 =?us-ascii?Q?jkjSU5kB/e6XsMmqho8FGPgFgBdTuLdhbX8Tchg0sUZX8fUkNUTubk9jBuR8?=
 =?us-ascii?Q?1rWYCjP4OSyU898uwARa8PvatndjCvVIq5LPLJzFGTjGP8G6mkPbQA5MRscf?=
 =?us-ascii?Q?XG21m1FcCLpQV9CSlD7mGBGz0DXOmLyqMKGx2JLQIa5MSnHwEmPQ0DDFjWKj?=
 =?us-ascii?Q?gYkyaeD1i3VbkNgqPpYRha7njjyQEeSomH6Ur78CbDnaBPOWwHWMj/ggn1tt?=
 =?us-ascii?Q?El6EskceY66m9fO61RCrI5KfYSsguMAOI5ssuRb4Jk55G2DuMklJjftrh5ct?=
 =?us-ascii?Q?lk1EBknctB9fPL+unHrG0VlcGVm+CuDN83qmBvEYQA6fAzcYo?=
x-microsoft-antispam-prvs: <VI1PR0501MB21919D111EF244CF8CC9187FD1720@VI1PR0501MB2191.eurprd05.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(396003)(376002)(189003)(199004)(13464003)(486006)(26005)(11346002)(54906003)(256004)(476003)(5024004)(14444005)(446003)(6916009)(55016002)(14454004)(478600001)(2906002)(105586002)(106356001)(9686003)(6306002)(229853002)(4326008)(966005)(316002)(186003)(25786009)(107886003)(6246003)(6436002)(71190400001)(93886005)(74316002)(53936002)(102836004)(97736004)(81156014)(81166006)(66066001)(76176011)(6506007)(7696005)(86362001)(8676002)(68736007)(71200400001)(6116002)(7736002)(52536013)(3846002)(99286004)(53546011)(33656002)(5660300002)(8936002)(305945005)(15398625002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2191;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A7DqmyYJXsDfj2t1moTS1SdUzOqZAr4W3VTVf0X6X9gA1RpBlZklMeEo7dJe0+zHLJ2TbBIgxRUsgkjGyydVXFDCr8C9W0yR0s+Zo5fYhS+8/e0Dq4cS85TF7Yyzg5uCX5kng1bMsMEtAaud1VZSEcMT6XsLEM/YDsDNrL62eBn6Zw3mnIP5s2JrEmdw7EBeUF0CHHtM0n+uslwDIOJNEHIOUgCPVH8F1PmveryZZMkIjZYQc55MKWvyPcTvCGv4OHz769m6S/bEPUjslGCvAv99hglAEVq99vqKJ2DnK+q6AamzwgwoKGQhKLLjOOv5m1nXROt/Y8xD7916PLBk04ydPyS9sBShPGw/S9SvCq66XO3pHv4fbXL7tYxB1Irv3DotzQ7Ixss7e1wmxiRQOFUfs2rXvWKMeJFMxhPfJlg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7044325a-92c9-47a6-4264-08d6a1a341d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 19:46:27.4815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jakub Kicinski <jakub.kicinski@netronome.com>
> Sent: Monday, March 4, 2019 7:35 PM
> To: Parav Pandit <parav@mellanox.com>
> Cc: Or Gerlitz <gerlitz.or@gmail.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; michal.lkml@markovi.net; davem@davemloft.net;
> gregkh@linuxfoundation.org; Jiri Pirko <jiri@mellanox.com>
> Subject: Re: [RFC net-next 0/8] Introducing subdev bus and devlink extens=
ion
>=20
> Parav, please wrap your responses to at most 80 characters.
> This is hard to read.
>=20
Sorry about it. I will wrap now on.

> On Mon, 4 Mar 2019 04:41:01 +0000, Parav Pandit wrote:
> > > -----Original Message-----
> > > From: Jakub Kicinski <jakub.kicinski@netronome.com>
> > > Sent: Friday, March 1, 2019 2:04 PM
> > > To: Parav Pandit <parav@mellanox.com>; Or Gerlitz
> > > <gerlitz.or@gmail.com>
> > > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > michal.lkml@markovi.net; davem@davemloft.net;
> > > gregkh@linuxfoundation.org; Jiri Pirko <jiri@mellanox.com>
> > > Subject: Re: [RFC net-next 0/8] Introducing subdev bus and devlink
> > > extension
> > >
> > > On Thu, 28 Feb 2019 23:37:44 -0600, Parav Pandit wrote:
> > > > Requirements for above use cases:
> > > > --------------------------------
> > > > 1. We need a generic user interface & core APIs to create sub
> > > > devices from a parent pci device but should be generic enough for
> > > > other parent devices 2. Interface should be vendor agnostic 3.
> > > > User should be able to set device params at creation time 4. In
> > > > future if needed, tool should be able to create passthrough device
> > > > to map to a virtual machine
> > >
> > > Like a mediated device?
> >
> > Yes.
> >
> > > https://www.kernel.org/doc/Documentation/vfio-mediated-device.txt
> > > https://www.dpdk.org/wp-content/uploads/sites/35/2018/06/Mediated-
> > > Devices-Better-Userland-IO.pdf
> > >
> > > Other than pass-through it is entirely unclear to me why you'd need a
> bus.
> > > (Or should I say VM pass through or DPDK?)  Could you clarify why
> > > the need for a bus?
> > >
> > A bus follow standard linux kernel device driver model to attach a
> > driver to specific device. Platform device with my limited
> > understanding looks a hack/abuse of it based on documentation [1], but
> > it can possibly be an alternative to bus if it looks fine to Greg and
> > others.
>=20
> I grok from this text that the main advantage you see is the ability to c=
hoose
> a driver for the subdevice.
>=20
Yes.

> > > My thinking is that we should allow spawning subports in devlink and
> > > if user specifies "passthrough" the device spawned would be an mdev.
> >
> > devlink device is much more comprehensive way to create sub-devices
> > than sub-ports for at least below reasons.
> >
> > 1. devlink device already defines device->port relation which enables
> > to create multiport device.
>=20
> I presume that by devlink device you mean devlink instance?  Yes, this pa=
rt
> I'm following.
>=20
Yes -> 'struct devlink'=20
> > subport breaks that.
>=20
> Breaks what?  The ability to create a devlink instance with multiple port=
s?
>=20
Right.

> > 2. With bus model, it enables us to load driver of same vendor or
> > generic one such a vfio in future.
>=20
> Yes, sorry, I'm not an expert on mdevs, but isn't that the goal of those?
> Could you go into more detail why not just use mdevs?
>=20
I am novice at mdev level too. mdev or vfio mdev.
Currently by default we bind to same vendor driver, but when it was created=
 as passthrough device, vendor driver won't create netdevice or rdma device=
 for it.
And vfio/mdev or whatever mature available driver would bind at that point.

> > 3. Devices live on the bus, mapping a subport to 'struct device' is
> > not intuitive.
>=20
> Are you saying that the main devlink instance would not have any port
> information for the subdevices?
>=20
Right, this newly created devlink device is the control point of its port(s=
).

> Devices live on a bus.  Software constructs - depend on how one wants to
> model them - don't have to.
>=20
> > 4. sub-device allows to use existing devlink port, registers, health
> > infrastructure to sub devices, which otherwise need to be duplicated
> > for ports.
>=20
> Health stuff is not tied to a port, I'm not following you.  You can creat=
e a
> reporter per port, per ACL rule or per SB or per whatever your heart desi=
res..
>=20
Instead of creating multiple reporters and inventing these reporter naming =
schemes,
creating devlink instance leverage all health reporting done for a devliink=
 instance.
So whatever is done for instance A (parent), can be available for instance =
B (subdev).

> > 5. Even though current devlink devices are networking devices, there
> > is nothing restricts it to be that way. So subport is a restricted
> > view.
> > 6. devlink device already covers
> > port sub-object, hence creating devlink device is desired.
> >
> > > > 5. A device can have multiple ports
> > >
> > > What does this mean, in practice?  You want to spawn a subdev which
> > > can access both ports?  That'd be for RDMA use cases, more than
> > > Ethernet, right?  (Just clarifying :))
> > >
> > Yep, you got it right. :-)
> >
> > > > So how is it done?
> > > > ------------------
> > > > (a) user in control
> > > > To address above requirements, a generic tool iproute2/devlink is
> > > > extended for sub device's life cycle.
> > > > However a devlink tool and its kernel counter part is not
> > > > sufficient to create protocol agnostic devices on a existing PCI
> > > > bus.
> > >
> > > "Protocol agnostic"?...  What does that mean?
> > >
> > Devlink works on bus,device model. It doesn't matter what class of
> > device is. For example, for pci class can be anything. So newly
> > created sub-devices are not limited to netdev/rdma devices. Its
> > agnostic to protocol. More importantly, we don't want to create these
> > sub-devices who bus type is 'pci'. Because as described below, PCI has
> > its addressing scheme and pci bus must not have mix-n match devices.
> >
> > So probably better wording should be,
> > 'a devlink tool and its kernel counterpart is not sufficient to create
> > sub-devices of same class as that of PCI device.
>=20
> Let me clarify - for networking devices the partition will most likely en=
d up as
> a subport, but its not a requirement that each partition must be a subpor=
t..
> The question was about the necessity to invent a new bus, and have every
> resource have a struct device..
>=20

A device object and bus connecting all software objects correctly. This inc=
ludes,
1. devlink bus/name handle based access
2. matching such device in sysfs
3. parent child hierarchy in sysfs
4. ability to bind different driver
5. multi-ports per device
6. still usable for single port use case
7. parameters setting at devlink instance level
8. parent-child relation handling power mgmt
9. follows standard linux driver model

Some are achievable to through mfd too, instead of subdev bus.
Will follow Greg's guidance on this.

> > > > (b) subdev bus
> > > > A given bus defines well defined addressing scheme. Creating sub
> > > > devices on existing PCI bus with a different naming scheme is just
> > > > weird. So, creating well named devices on appropriate bus is
> > > > desired.
> > >
> > > What's that address scheme you're referring to, you seem to assign
> > > IDs in sequence?
> > >
> > Yes. a device on subdev bus follows standard linux driver model based
> > id assignment scheme =3D u32. And devices are well named as 'subdev0'.
> > Prefix + id as the default scheme of core driver model.
>=20
> I thought "well defined addressing scheme" means I can address subdevice =
X
> of device Y with your scheme.  I can't, it's just an global ID.  Thanks f=
or
> clarifying.
>=20
It's a global ID on the subdev bus.
subdevice X are listed under parent device Y.

We did consider embedding parent PCI address in child was considered, but i=
ts duplicate info that doesn't seem worth.

devlink will show its parent device link, like
$devlink dev show
pci/0000:05:00.0
subdev/subdev0 parent pci/0000:05:00.0

> > > The things key thing for me on the netdev side is what is the
> > > forwarding model to this new entity.  Is this basically VMDQ?
> > > Should we just go ahead and mandate "switchdev mode" here?
> > >
> > It will follow the switchdev mode, but it not limited to it.
> > Switchdev mode is for the eswitch functionality. There isn't a need to
> > combine this. rdma Infiniband will be able to use this without
> > switchdev mode.
>=20
> It's the devlink instance that's in "switchdev mode", regardless of type =
of any
> of its ports.
>=20
I didn't follow your comment.
What I wanted to say, is,=20
When $devlink dev add pci/0000:05:00.0 is done,
devlink instance pci/0000:05:00.0, doesn't have to be in switchdev mode.
We do not plan to support switchdev, but it is not devlink's domain to enfo=
rce it.

switchdev mode has nothing to do with sriov, even though it might have star=
ted with that vision.

