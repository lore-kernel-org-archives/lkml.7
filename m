Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8983C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654BA20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="er2o4goQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfCDElM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 23:41:12 -0500
Received: from mail-eopbgr150074.outbound.protection.outlook.com ([40.107.15.74]:8678
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbfCDElM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 23:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixFf63HJArVazntyG2C57nnbd4gDNN2grSDvEC+B/wQ=;
 b=er2o4goQeYZZmkfjqmpObZatvKHQYXSmy8uypgczMVNlH3orPVadhCeqfhybWeCsztnEAnTNAtFaKvzL1A6wdyYdsInNW1kMQgQwlmqdz6k/AnzA7VcQZclenax+CzK/0zXhMgrmst51KoRmvhapTzwOfdnL+5L9YqkGdkTTv4I=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2621.eurprd05.prod.outlook.com (10.172.13.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Mon, 4 Mar 2019 04:41:01 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1665.019; Mon, 4 Mar 2019
 04:41:01 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Or Gerlitz <gerlitz.or@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jiri Pirko <jiri@mellanox.com>
Subject: RE: [RFC net-next 0/8] Introducing subdev bus and devlink extension
Thread-Topic: [RFC net-next 0/8] Introducing subdev bus and devlink extension
Thread-Index: AQHUz/D0zHEkReNVsEa2RSWOI/Q4NKX3M+0AgAOlj4A=
Date:   Mon, 4 Mar 2019 04:41:01 +0000
Message-ID: <VI1PR0501MB227107F2EB29C7462DEE3637D1710@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <20190301120358.7970f0ad@cakuba.netronome.com>
In-Reply-To: <20190301120358.7970f0ad@cakuba.netronome.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [68.203.16.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5469ae62-0895-4f94-da91-08d6a05b9a68
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2621;
x-ms-traffictypediagnostic: VI1PR0501MB2621:
x-ms-exchange-purlcount: 3
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR0501MB2621;23:6sjLNj2b41V/dX9S8PCBRlgyrrykPju840G1ii1?=
 =?us-ascii?Q?8bolzhnqCjXGYlz3O+yjRgmv/pSP+uCpE+StrqQb7Boul0fAHi/QUKcpCcTO?=
 =?us-ascii?Q?tPyHs11wuHdRJZqnDfGD4Y0VCUIgmuseOSHsktROa5PPmExKBuKi2gtRs93l?=
 =?us-ascii?Q?4F3Ha7NO9MJf3zey7+neQUKeOr85eJFypFaQWm/pqD6xt8fFwJ3G6QIjf4U2?=
 =?us-ascii?Q?HlmZEV2wVNbhu19jxzaRX+nnLfbTEfEiklP2SLxcwVRBwZ+58OV8jwCKinfP?=
 =?us-ascii?Q?iV5Ci3/EZSb/6eCbgyMyu0SeVD3WEiYP8ZWh2uTRlHifmoFFxEP3anTVIuq4?=
 =?us-ascii?Q?nF8tQUZDf1Kk4NUJtUgtwJ4rJjcdgpLCf7EJD3rc6vcxIk6OvuAujJLYH8NN?=
 =?us-ascii?Q?YO8WGqislhvriclGqfXfg4fIh0LsP/MeBQM34nWo1i8IRppSg1WTt2nwS6KQ?=
 =?us-ascii?Q?TOK0e4HsOpKAgHtBFWPbc4gOPi2/jCyRwFvD4tjuR2jpf1dkBjqXw2cJ31ba?=
 =?us-ascii?Q?5rTYSImzodWU8A1lvhJ7fCODPkpp/8IoK2Sk+kgWo5HEvyNu60fPP2TF0Ms9?=
 =?us-ascii?Q?d9ARmbJiQSBt/M/SDWzYDOuUNZp3NRuHA4YTeKdNhGwfiUbZd6jTBPqTl9Tc?=
 =?us-ascii?Q?V+5SZVtGlNkrlGCdLCnQRtD+WqDtQNzOFsas7ue7tY6AESCse82XGCuYwZUW?=
 =?us-ascii?Q?+J4wBm16c8yRG+gHdvt72aBemoxvcbkgECkmZaSTuhFRq9DMWLyunSyIRFuP?=
 =?us-ascii?Q?OCEQk2B0/6DQGiw6MN5AXKE2fSEIK6sze4vADczculpGK0GgnL+3UakUh4M6?=
 =?us-ascii?Q?dQz1ArDGw0JQzPGsL8derVW2plKyMCFM9fHfy6Hyek81HK1wkgPqz14sv4Te?=
 =?us-ascii?Q?4oP9tr131QPJMac8nzKyZ6sZVKM0/5LtYGF9teZdfg5vRopJuuAcHafLN5ci?=
 =?us-ascii?Q?F/M6WP0siwdgZpMnhAzThHTx1vnUgEaX/MWKmoA50sH7XjUPuQ+tSyAsnSmU?=
 =?us-ascii?Q?N+esKxL6tsMdR/aTs8gr8A/R43evaEMhxTpVB0Huv1UCfHFlBQt3SQzfqfyx?=
 =?us-ascii?Q?Mz6h7I9UumTnuezo+0SXme8lqKABDwZjHQHnuag07ms6Eht/NCGuiMlqzC69?=
 =?us-ascii?Q?AsMVvd/Rw+/WVlcAT7026Xn9xtUlv9cw/+Hyh7vIlelD75KkIQbUFP89wGUS?=
 =?us-ascii?Q?NIF5W5as+kfHNsww6+yhi0VJNAq0ljh7BzNuSdFMbcaJyUuAb5N9MW2HLVNS?=
 =?us-ascii?Q?1ydikRNVgU8yRjIrO38xwuWqXvDFWE28nLoVjUQ5LDVfHUThTjwze5lKvnpa?=
 =?us-ascii?Q?8Vqbhw139gseY18pQMhhNsw9gLTQI18lz9Etx7SE4mgwsOx28He0pnTWQIuZ?=
 =?us-ascii?Q?Ry2tYlrx2KvQUdTA4ne8c5UfQXUJcC+3e0LYbw9eMeKIqRkCE+gSfknHCEsn?=
 =?us-ascii?Q?Rm08feScHexkrUSrkb2CULK35VoyvWGQP8QZPLHgX42XwJsIBsYNwu8QmH0S?=
 =?us-ascii?Q?Hm3KQd+EMwT27HGEdbNbZLV4qnK0H2GjMZMs=3D?=
x-microsoft-antispam-prvs: <VI1PR0501MB2621EF807906088105269FEDD1710@VI1PR0501MB2621.eurprd05.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(39850400004)(376002)(136003)(366004)(346002)(189003)(199004)(13464003)(486006)(6506007)(305945005)(53546011)(97736004)(25786009)(7736002)(33656002)(54906003)(107886003)(186003)(110136005)(74316002)(99286004)(14454004)(2906002)(4326008)(76176011)(86362001)(52536013)(71190400001)(71200400001)(68736007)(5660300002)(7696005)(5024004)(8936002)(6436002)(256004)(229853002)(106356001)(8676002)(6306002)(53936002)(55016002)(9686003)(105586002)(81166006)(81156014)(6246003)(66066001)(14444005)(561944003)(102836004)(11346002)(476003)(26005)(6116002)(3846002)(446003)(966005)(478600001)(316002)(15398625002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2621;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +1ztcsANFVoHx/VmkcqDLsbHwEFvbyrA62OgiruTRJ7zdWjnsRUYu6yyR3QKMGQ0mz3oYwV9zZu3MUEryLfs56rH4Bag2e1M/Bt8WeOZTMYsXD+jHAuyu3ptqT52FXoG5i2u7sLEVnROedqpUwSO0fFuBh+/1i62iESa3oFulgcxTMA8DvhZpG9MHHQQFT+1Zavf93av8w38rtcdJwjmztqoZqE+KVi7NCTxTOqWSS6bKkN8KgF0eXUH33LJmWOLrk89ItJkEASfPgWHgIjCB9clmmCApQTnbDauFFDRA0DtJ3Mz7472lt0Z/+PN/5aHeMjp+p1ZLaePQiU9ZOMbKVcqqZn6KCFGKAS/xG/v+KYcrG4fzjM3YfQPCaZZtwiEZO3LDoCsD9u0HQzJl8TyJLFcPTnc2uJmqrOLPEEq764=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5469ae62-0895-4f94-da91-08d6a05b9a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 04:41:01.0603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2621
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jakub Kicinski <jakub.kicinski@netronome.com>
> Sent: Friday, March 1, 2019 2:04 PM
> To: Parav Pandit <parav@mellanox.com>; Or Gerlitz <gerlitz.or@gmail.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> michal.lkml@markovi.net; davem@davemloft.net;
> gregkh@linuxfoundation.org; Jiri Pirko <jiri@mellanox.com>
> Subject: Re: [RFC net-next 0/8] Introducing subdev bus and devlink extens=
ion
>=20
> On Thu, 28 Feb 2019 23:37:44 -0600, Parav Pandit wrote:
> > Requirements for above use cases:
> > --------------------------------
> > 1. We need a generic user interface & core APIs to create sub devices
> > from a parent pci device but should be generic enough for other parent
> > devices 2. Interface should be vendor agnostic 3. User should be able
> > to set device params at creation time 4. In future if needed, tool
> > should be able to create passthrough device to map to a virtual
> > machine
>=20
> Like a mediated device?
>
Yes.
=20
> https://www.kernel.org/doc/Documentation/vfio-mediated-device.txt
> https://www.dpdk.org/wp-content/uploads/sites/35/2018/06/Mediated-
> Devices-Better-Userland-IO.pdf
>=20
> Other than pass-through it is entirely unclear to me why you'd need a bus=
.
> (Or should I say VM pass through or DPDK?)  Could you clarify why the nee=
d
> for a bus?
>=20
A bus follow standard linux kernel device driver model to attach a driver t=
o specific device.
Platform device with my limited understanding looks a hack/abuse of it base=
d on documentation [1], but it can possibly be an alternative to bus if it =
looks fine to Greg and others.

> My thinking is that we should allow spawning subports in devlink and if u=
ser
> specifies "passthrough" the device spawned would be an mdev.
>
devlink device is much more comprehensive way to create sub-devices than su=
b-ports for at least below reasons.

1. devlink device already defines device->port relation which enables to cr=
eate multiport device.
subport breaks that.
2. With bus model, it enables us to load driver of same vendor or generic o=
ne such a vfio in future.
3. Devices live on the bus, mapping a subport to 'struct device' is not int=
uitive.
4. sub-device allows to use existing devlink port, registers, health infras=
tructure to sub devices, which otherwise need to be duplicated for ports.
5. Even though current devlink devices are networking devices, there is not=
hing restricts it to be that way.
So subport is a restricted view.
6. devlink device already covers port sub-object, hence creating devlink de=
vice is desired.

> > 5. A device can have multiple ports
>=20
> What does this mean, in practice?  You want to spawn a subdev which can
> access both ports?  That'd be for RDMA use cases, more than Ethernet,
> right?  (Just clarifying :))
>
Yep, you got it right. :-)
=20
> > So how is it done?
> > ------------------
> > (a) user in control
> > To address above requirements, a generic tool iproute2/devlink is
> > extended for sub device's life cycle.
> > However a devlink tool and its kernel counter part is not sufficient
> > to create protocol agnostic devices on a existing PCI bus.
>=20
> "Protocol agnostic"?...  What does that mean?
>=20
Devlink works on bus,device model. It doesn't matter what class of device i=
s.
For example, for pci class can be anything. So newly created sub-devices ar=
e not limited to netdev/rdma devices.
Its agnostic to protocol.
More importantly, we don't want to create these sub-devices who bus type is=
 'pci'.
Because as described below, PCI has its addressing scheme and pci bus must =
not have mix-n match devices.

So probably better wording should be,
'a devlink tool and its kernel counterpart is not sufficient to create sub-=
devices of same class as that of PCI device.

> > (b) subdev bus
> > A given bus defines well defined addressing scheme. Creating sub
> > devices on existing PCI bus with a different naming scheme is just weir=
d.
> > So, creating well named devices on appropriate bus is desired.
>=20
> What's that address scheme you're referring to, you seem to assign IDs in
> sequence?
>
Yes. a device on subdev bus follows standard linux driver model based id as=
signment scheme =3D u32.
And devices are well named as 'subdev0'. Prefix + id as the default scheme =
of core driver model.
=20
> >
> > Given that, these are user created devices for a given hardware and in
> > absence of a central entity like PCISIG to assign vendor and device
> > ids, A unique vendor and device id are maintained as enum in
> > include/linux/subdev_ids.h.
>=20
> Why do we need IDs?  The sysfs hierarchy isn't sufficient? =20

> Do we need a driver to match on those again?  Is it going to be a differe=
nt driver?
>=20
IDs are used to match driver against the created device.
It can be same or different driver.
Even in same driver case, it provides a clear code separation for creating =
sub-devices and their respective one or more protocol devices (netdev, rep-=
netdev, rdma ..)

> > subdev bus device names follow default device naming scheme of Linux
> > kernel. It is done as 'subdev<instance_id>' such as, subdev0, subdev3.
> >
> > System example view:
> > --------------------
> >
> > $ devlink dev show
> > pci/0000:05:00.0
> >
> > $ devlink dev add pci/0000:05:00.0
>=20
> That does not look great.
>
Yes, It must return bus+device attributes in user output too
Code in existing patchset returns it, it is not shown here.
I will fix the cover-letter.

> Also you have to return the id of the spawned device, otherwise this is v=
ery
> racy.
>=20
Yes, that is correct. It must return an devlink device id =3D {bus+device} =
attr.
I will update the example in v2.

> > $ devlink dev show
> > pci/0000:05:00.0
> > subdev/subdev0
>=20
> Please don't spawn devlink instances.  Devlink instance is supposed to
> represent an ASIC.  If we start spawning them willy nilly for whatever
> software construct we want to model the clarity of the ontology will suff=
er a
> lot.
Devlink devices not restricted to ASIC even though today it is representing=
 ASIC for one vendor.
Today for one ASIC, it already presents multiple devlink devices (128 or mo=
re) for PF and VFs, two PFs on same ASIC etc.
VF is just a sub-device which is well defined by PCISIG, whereas sub-device=
 is not.
Sub-device do consume actual ASIC resources (just like PFs and VFs),
Hence point-(6) of cover-letter indicate that the devlink capability to tel=
l how many such sub-devices can be created.

In above example, they are created for a given bus-device following existin=
g devlink construct.

>=20
> Please see the discussion on my recent patchset.  I think Jiri CCed you.
>
I will review the discussion in short while after this reply, and provide c=
omments.

> > Alternatives considered:
> > ------------------------
> > Will discuss separately if needed to keep this RFC short.
>=20
> Please do discuss.
>
(a) subports instead of subdevices.
We dropped this option because its two restrictive; I explained above the b=
enefits of devlink device.

(b) extending iproute2/ip link and iproute2/rdma tools to creating sub-devi=
ces.
But that is too limiting which doesn't provide all the features we get usin=
g devlink.
It also doesn't address the passthrough needs and its just ugly to create a=
nd manage PCI level devices using high level tools like 'ip' and 'rdma'.

(c) creating platform device and platform driver instead of subdev bus
Our understanding is that - platform device for this purpose would be an ab=
use/misuse, but our view is limited based on kernel documentation in [2].
[1] says "platform devices typically appear as autonomous entities"
Sub-devices are well managed, created, configurable by user.
Most things of [1] -> "Platform devices" section do not match with subdev.

Greg suggested to use mfd framework (wrapper to platform), which also needs=
 extension.
mfd_remove_devices() removes all the devices, while here based on user requ=
est, we want to add/remove individual device.
Will wait if he is ok with subdev bus or he prefers to extend the platform =
documentation and mfd for removing individual devices.

(d) drivers/visorbus
This bus is limited to UUID/GUID based naming scheme and very specific to s=
-Par standard and vendor.
Additionally its guest drivers are living in staging for more than year.
So it doesn't appear the right direction.

(e) creating subdev as child objects of devlink device (such as port, regis=
ters, health, etc).
In this mode, a given devlink device has multiport child device which is an=
chored using 'struct device' and life cycled through devlink.
Only difference with current proposal is it doesn't follow standard driver =
model to bind to other driver.
It also doesn't show in unified way using devlink dev show.

So instead of these alternatives, devlink device that matches PF, VF, sub-d=
evice, + subdev bus seems better design.
This follows all standard constructs of 1. Devlink, 2. Linux driver model.
It is not limited to ports and generic enough for networking and not networ=
king devices.
=20
> The things key thing for me on the netdev side is what is the forwarding
> model to this new entity.  Is this basically VMDQ?
> Should we just go ahead and mandate "switchdev mode" here?
>=20
It will follow the switchdev mode, but it not limited to it.
Switchdev mode is for the eswitch functionality. There isn't a need to comb=
ine this.
rdma Infiniband will be able to use this without switchdev mode.

> Thanks for working on a common architecture and suffering through
> people's reviews rather than adding a debugfs interface that does this li=
ke a
> different vendor did :)
Oh yes, lets not do debugfs.
Thanks a lot Jakub for the review.
This common architecture should be able to address such common needs.
Please let me know if this needs more refinement, if I missed something.

[1] https://www.kernel.org/doc/Documentation/driver-model/platform.txt

