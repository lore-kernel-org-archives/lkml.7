Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502E2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6ECA20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="UkyGR0uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389058AbfCAQf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:35:58 -0500
Received: from mail-eopbgr50072.outbound.protection.outlook.com ([40.107.5.72]:56118
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728449AbfCAQf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/zED+12AZ5fWhzSOLLUdpaRFHnGmGOCuP+CkeA9uk0=;
 b=UkyGR0uccy/LiDGCqgjSes85SqZMCePx2AJd2tETmEL9Fp+6wJJqrveDUze0KGW3FqYaCmvpbsQtIwbPnBaLMLKKsxgdkl97CDpndCh9SQtL8dBSsKYE1I3N3YovgqjSCVrKCaCc1RmtVOB7NSdWyxPJL2L2wxZX5OOjH+hUeno=
Received: from AM4PR0501MB2260.eurprd05.prod.outlook.com (10.165.82.137) by
 AM4PR0501MB2209.eurprd05.prod.outlook.com (10.165.82.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Fri, 1 Mar 2019 16:35:46 +0000
Received: from AM4PR0501MB2260.eurprd05.prod.outlook.com
 ([fe80::493b:13fd:1969:bb2b]) by AM4PR0501MB2260.eurprd05.prod.outlook.com
 ([fe80::493b:13fd:1969:bb2b%6]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 16:35:46 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>
Subject: RE: [RFC net-next 1/8] subdev: Introducing subdev bus
Thread-Topic: [RFC net-next 1/8] subdev: Introducing subdev bus
Thread-Index: AQHUz/D0gORm0okeck2hIBQM+5IMFaX2XcSAgACTYlA=
Date:   Fri, 1 Mar 2019 16:35:46 +0000
Message-ID: <AM4PR0501MB22601B097AF53AAFD59CB8B6D1760@AM4PR0501MB2260.eurprd05.prod.outlook.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <1551418672-12822-2-git-send-email-parav@mellanox.com>
 <20190301071727.GA8975@kroah.com>
In-Reply-To: <20190301071727.GA8975@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f1b1fa6-5477-447d-03e2-08d69e63f510
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0501MB2209;
x-ms-traffictypediagnostic: AM4PR0501MB2209:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM4PR0501MB2209;23:KHPRcQJtmC2uIrEAxgX0b3GGGvyfROIOmtnRR9C?=
 =?us-ascii?Q?mGKJDz1LMRA4R9R0p0pwt+Tc5bZwMnZ9tF5bP4TfBjyBXoQxwGQXwHQ+wjk6?=
 =?us-ascii?Q?J45dxr9fQo93uvs1OMpZe0L42qNidhoiiPnlaE1GmUi9x3z5D/lM1Vcw7AJw?=
 =?us-ascii?Q?qc2dbbArRAUjglKHKQzGEcz+5OUOF3iCWgllzDTzBCFVBf12sdBrniee6h1S?=
 =?us-ascii?Q?pjawKLO5bEqaBBRk8ej/0oJMHj67QZHQQqzGyivurVNl1wazL8hmShWzwA7R?=
 =?us-ascii?Q?EyoJ49TBJy5UWRrT98BK4HVT5V0WX9hx1zRknirRVR0TaTjiwZLnmLy3MWEG?=
 =?us-ascii?Q?4oW8x+25S8+f8xZpxbLgMUszcOupCKAFvHhcmWoektSw+bflIVPF61SSbUFq?=
 =?us-ascii?Q?Ppn0Mb/ZxbgmGrG/dwm3F2Qfsu4v8Jo4gTS0sOemldefoxvpnR7fsJjYYnt8?=
 =?us-ascii?Q?3wiXm1IBkOtitfIJLUywNWC8HR9jJC+ReoF3DTm3KgRmc6IWW/sKDurMnr1P?=
 =?us-ascii?Q?EzhcGo0dAuYAGwexJ+UG/3Aw4mS/rO1l0I0IYru/BM//P7Wbj0wmCNj9G1D1?=
 =?us-ascii?Q?jyVy3G60ZgvgjNvff/e6iPLjL0SbT0uzLp6Hw0ntS3C601uW7x1bWaQc1Rbc?=
 =?us-ascii?Q?YBn3D2lcbzICvEyyklWnKYpSdRH0SfA78wExi0fCCDyVMsNW8+OvscdcvHEo?=
 =?us-ascii?Q?suN3OJHudLs4VN22QYcC1iKE65njdGKGbN6mWnLNjRHTWLVhkUsQWCKO4iQp?=
 =?us-ascii?Q?SvfYJFImIgaGWXWwULXcEJDpjlhARZE7h7XBKLKVrMAuIgxNbl+KAyh/5LEJ?=
 =?us-ascii?Q?vndmlQJy2h8VO/zW6WzNUlwufSP3W0IiicwCcVEEBWRXZxhu6PbTmv9bv5y4?=
 =?us-ascii?Q?roG1QWxliYmH1h0jXh2Sbqbg5tZdB6Ud1sGlnhT5eEUhbQJa/cGKef1SnGjL?=
 =?us-ascii?Q?H5jVj/UmY3ZcWuXZ3T+MJacSxVPae49HycF1flg6HutTKZ0q9NCakH9IuUST?=
 =?us-ascii?Q?TBBLHxpAIDVEiNmdrL1Jw2tg15jUryggxHnsI352xGZeCKVaMUAe/fyzxAs+?=
 =?us-ascii?Q?27RoVV6zLBzvHbxoiTThMzCdBNVbK3vSrJMKV/ltJhdVoXk4M1459WNwvZci?=
 =?us-ascii?Q?bVhyX/0RLf2z2rllQTOFrmyniwAZkbneYCTAdkvrYNqbwimN+nwbxTLA5azB?=
 =?us-ascii?Q?9n0QK+cfHv+TdtJZOWWwjpzYsxktClYJ83V866geCURlfzFPcd2rCEyia15i?=
 =?us-ascii?Q?XMIZLmLkICqBRW3yWOLDRaUMtpsjHz4CEZUd6+uRW9+RghIoJC1bXFUqBanT?=
 =?us-ascii?Q?OkjjrDyvZvHiXPp3f/+/jouBpwOOtU0fEnlYhh9FAzmkyxnVR0irOokVrHlM?=
 =?us-ascii?Q?jmFOLV5b0p06W25n4lyNs8REK5UE=3D?=
x-microsoft-antispam-prvs: <AM4PR0501MB22092CC2704DD99F3A08B97DD1760@AM4PR0501MB2209.eurprd05.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(136003)(13464003)(189003)(199004)(6436002)(14454004)(14444005)(5024004)(6246003)(478600001)(2906002)(6116002)(3846002)(256004)(186003)(53546011)(6506007)(76176011)(316002)(102836004)(33656002)(54906003)(8676002)(486006)(11346002)(446003)(81156014)(476003)(55016002)(99286004)(9686003)(966005)(6306002)(26005)(561944003)(7696005)(81166006)(53936002)(25786009)(71190400001)(71200400001)(229853002)(4326008)(305945005)(106356001)(86362001)(68736007)(74316002)(52536013)(5660300002)(66066001)(7736002)(8936002)(105586002)(6916009)(97736004)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0501MB2209;H:AM4PR0501MB2260.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XPNO4q2kB8u46iZt3VkwJSi+PMeYF/SRIFu0aoGo4/SLDgSZzpp9YwLv7ozT7cfm5f1A4X2s9qBJE9B1O8cisC3YiLHTSLPSRs6iKDjgovrs3ZNv9VyylR7ZseanrqGAfw/BV6mtN31kpq331sJpOZmMcWTvraHUrnRtXidM75zwdEUNH+wP16xCT95PhiKwEHfyvppRQhqErwLs6I78+aBIeiMdRfWdNB1WmdVoodP/abnpj8sAnTHgoyEDS8hQFHMWcSleiEv6437idQy/ITeawe3qFwA1xb7lJ0ZsXDz0pryA4RL4fJnsv1oDff9Gub9AiX1amt9YYavyhOzlk4OBpt8WrVJGfQm4Sc0HB58cXTeQwUAG8FEvH2xXnG9FCUvWnX2fQPv8rXGZS5PmKkNHikVMIH+UHFFrXjFf9hw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1b1fa6-5477-447d-03e2-08d69e63f510
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 16:35:46.9001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, March 1, 2019 1:17 AM
> To: Parav Pandit <parav@mellanox.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> michal.lkml@markovi.net; davem@davemloft.net; Jiri Pirko
> <jiri@mellanox.com>
> Subject: Re: [RFC net-next 1/8] subdev: Introducing subdev bus
>=20
> On Thu, Feb 28, 2019 at 11:37:45PM -0600, Parav Pandit wrote:
> > Introduce a new subdev bus which holds sub devices created from a
> > primary device. These devices are named as 'subdev'.
> > A subdev is identified similarly to pci device using 16-bit vendor id
> > and device id.
> > Unlike PCI devices, scope of subdev is limited to Linux kernel.
>=20
> But these are limited to only PCI devices, right?
>=20
For Mellanox use case yes, its limited to PCI devices.

> This sounds a lot like that ARM proposal a week or so ago that asked for
> something like this, are you working with them to make sure your proposal
> works for them as well?  (sorry, can't find where that was announced, it =
was
> online somewhere...)
>=20
We were not aware of it, mostly because we are either on net side of mailin=
g lists (netdev, rdma, virt etc).
ARM proposal likely on linux-kernel, I guess.
I will lookup that proposal and surely see if both of us can use common inf=
rastructure.

> > A central entry that assigns unique subdev vendor and device id is:
> > include/linux/subdev_ids.h enums. Enum are chosen over define macro so
> > that two vendors do not end up with vendor id in kernel development
> > process.
>=20
> Why not just make it dynamic with on static ids?
>=20
Can you please elaborate?
Do you mean we should use something similar to pci_add_dynid() with enhance=
ment to catch duplicate id addition?

> > subdev bus holds subdevices of multiple devices. A typical created
> > subdev for a PCI device in sysfs tree appears under their parent's
> > device as using core's default device naming scheme:
> >
> > subdev<instance_id>.
> > i.e.
> > subdev0
> > subdev1
> >
> > $ ls -l /sys/bus/pci/devices/0000:05:00.0 [..]
> > drwxr-xr-x 4 root root        0 Feb 13 15:57 subvdev0
> > drwxr-xr-x 4 root root        0 Feb 13 15:57 subvdev1
> >
> > Device model view:
> > ------------------
> >                +------+    +------+       +------+
> >                |subdev|    |subdev|       |subdev|
> >           -----|  1   |----|  2   |-------|  3   |----------
> >           |    +--|---+    +-|----+       +--|---+         |
> >           --------|----------|---subdev bus--|--------------
> >                   |          |               |
> >                +--+----+-----+           +---+---+
> >                |pcidev |                 |pcidev |
> >           -----|   A   |-----------------|   B   |----------
> >           |    +-------+                 +-------+         |
> >           -------------------pci bus------------------------
>=20
> To be clear, "subdev bus" is just a logical grouping, there is no physica=
l
> backing "bus" here at all, right?
>=20
Yep. that's correct.

> What is going to "bind" to subdev devices?  PCI drivers?  Or new types of
> drivers?
>=20
Devices are placed on subdev bus using devlink interface. And drivers which=
 registers using subdev_register_driver(), their probe() method will be cal=
led.
So yes, those are PCI vendor driver.
I tried to capture this in cover-letter.
At present users didn't ask to map this subdev to VM, but there is very hig=
h chance that once we have this without PCI SR-IOV, they would like to exte=
nd to VMs too.
So in that case devlink will have option to say, add 'passthrough' device, =
and in that case instead of vendor's pci driver, some high level vfio type =
driver will bind to it.
That is just the anticipation, but we haven't really worked out this fully.
But this model allows to do so.

> > subdev are allocated and freed using subdev_alloc(), subdev_free() APIs=
.
> > A driver which wants to create actual class driver such as
> > net/block/infiniband need to use subdev_register_driver(),
> > subdev_unregister_driver() APIs.
> >
> > +++ b/drivers/subdev/Kconfig
> > @@ -0,0 +1,12 @@
> > +#
> > +# subdev configuration
> > +#
> > +
> > +config SUBDEV
> > +	tristate "subdev bus driver"
> > +	help
> > +	The subdev bus driver allows creating hardware based sub devices
> > +	from a parent device. The subdev bus driver is required to create,
> > +	discover devices and to attach device drivers to this subdev
> > +	devices. These subdev devices are created using devlink tool by
> > +	user.
>=20
>=20
> Your definition of the bus uses the name of the bus in the definition :)
>=20
I will better word this in v2 if we don't go mfd route.

> > diff --git a/drivers/subdev/Makefile b/drivers/subdev/Makefile new
> > file mode 100644 index 0000000..405b74a
> > --- /dev/null
> > +++ b/drivers/subdev/Makefile
> > @@ -0,0 +1,8 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Makefile for subdev bus driver
> > +#
> > +
> > +obj-$(CONFIG_SUBDEV)	+=3D subdev.o
> > +
> > +subdev-y :=3D subdev_main.o
> > diff --git a/drivers/subdev/subdev_main.c
> > b/drivers/subdev/subdev_main.c new file mode 100644 index
> > 0000000..4aabcaa
> > --- /dev/null
> > +++ b/drivers/subdev/subdev_main.c
> > @@ -0,0 +1,153 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/module.h>
> > +#include <linux/device.h>
> > +#include <linux/slab.h>
> > +#include <linux/subdev_bus.h>
> > +
> > +static DEFINE_XARRAY_FLAGS(subdev_ids, XA_FLAGS_ALLOC);
>=20
> Why not an idr?
>=20
Matt is running large patch series to get rid of idr/ida and replacing with=
 xarray.
So instead of creating more work for him, thought to start with xarray from=
 beginning.

> > +
> > +int __subdev_register_driver(struct subdev_driver *drv, struct module
> *owner,
> > +			     const char *mod_name)
> > +{
> > +	drv->driver.name =3D mod_name;
> > +	drv->driver.bus =3D &subdev_bus_type;
> > +	drv->driver.owner =3D owner;
> > +	drv->driver.mod_name =3D mod_name;
> > +
> > +	return driver_register(&drv->driver); }
> > +EXPORT_SYMBOL(__subdev_register_driver);
>=20
> EXPORT_SYMBOL_GPL() for this and the other ones as you are just wrapping
> the driver core logic loosely.
>=20
I see. Yes. will fix this.

> > +/**
> > + * subdev_add_dev - Add a sub device to bus.
> > + * @subdev:	subdev devie to be placed on the bus
> > + * @parent_dev:	Parent device of the subdev
> > + * @vid:	Vendor ID of the device
> > + * @did:	Device ID of the device
> > + *
> > + * Returns 0 on successfully adding subdev to bus or error code on fai=
lure.
> > + * Once the device is added, it can be probed by the device driver
> > +who
> > + * wish to match it.
> > + *
> > + */
> > +int subdev_add_dev(struct subdev *subdev, struct device *parent_dev,
> > +		   enum subdev_vendor_id vid, enum subdev_device_id did) {
> > +	u32 id =3D 0;
> > +	int ret;
> > +
> > +	if (!parent_dev)
> > +		return -EINVAL;
>=20
> No root devices?
>=20
I didn't get the comment. Intent of this check is subdev must have parent. =
Parent type doesn't matter.

> > +
> > +	ret =3D xa_alloc(&subdev_ids, &id, UINT_MAX, NULL, GFP_KERNEL);
>=20
> No locking needed?
>=20
Documentation at [1] describes that xa_alloc() and xa_erase() takes the loc=
k internally.
[1] https://www.kernel.org/doc/html/latest/core-api/xarray.html

> > +module_init(subdev_init);
> > +module_exit(subdev_exit);
> > +
> > +MODULE_LICENSE("GPL");
>=20
> Nit, for a few more weeks, this needs to be "GPL v2".
>=20
Ok.

> >  #endif /* LINUX_MOD_DEVICETABLE_H */
> > diff --git a/include/linux/subdev_bus.h b/include/linux/subdev_bus.h
> > new file mode 100644 index 0000000..c6410e3
> > --- /dev/null
> > +++ b/include/linux/subdev_bus.h
> > @@ -0,0 +1,63 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#ifndef SUBDEV_BUS_H
> > +#define SUBDEV_BUS_H
> > +
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/device.h>
> > +#include <linux/subdev_ids.h>
> > +
> > +struct subdev_driver {
> > +	const struct subdev_id *id_table;
> > +	struct device_driver driver;
> > +	struct list_head list;
> > +};
> > +
> > +#define to_subdev_driver(x) container_of(x, struct subdev_driver,
> > +driver)
> > +
> > +int __subdev_register_driver(struct subdev_driver *drv, struct module
> *owner,
> > +			     const char *mod_name);
> > +#define subdev_register_driver(driver)		\
> > +	__subdev_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
> > +
> > +void subdev_unregister_driver(struct subdev_driver *dev);
> > +
> > +/**
> > + * subdev - A subdev device representation
> > + *
> > + * @dev:	device struct that represent subdev device in core device
> model
> > + * @dev_id:	Unique vendor id, device id that subdev device drivers mat=
ch
> > + *		against. A unique id that defines this subdev assigned in
> > + *		include/linux/subdev_ids.h
> > + */
> > +struct subdev {
> > +	struct device dev;
> > +	struct subdev_id dev_id;
> > +};
> > +
> > +#endif
> > diff --git a/include/linux/subdev_ids.h b/include/linux/subdev_ids.h
> > new file mode 100644 index 0000000..361faa3
> > --- /dev/null
> > +++ b/include/linux/subdev_ids.h
> > @@ -0,0 +1,17 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#ifndef SUBDEV_IDS_H
> > +#define SUBDEV_IDS_H
> > +
> > +enum subdev_vendor_id {
> > +	SUBDEV_VENDOR_ID_MELLANOX,
> > +
> > +	/* new device id must be added above at the end */
>=20
> Again, why ids at all?
>=20
Do you mean, we should just string or something to match on which driver to=
 bind to the device?
Or do something similar to pci_add_dynid()?

> So far, this is just a very loose wrapping of the driver core bus functio=
nality,
Right, it is wrapped to avoid creating just random device_driver and random=
 device objects in device tree.

> which is fine, but I really don't see the goal here...

I see you have extended this question in mail where you ask about creating =
netdevices and using mfd.
So lets discuss in that context as it is more appropriate there. This patch=
 is just code..

