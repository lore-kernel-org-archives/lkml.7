Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B20C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3209206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="IC510iY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbfCZBnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:43:51 -0400
Received: from mail-eopbgr50085.outbound.protection.outlook.com ([40.107.5.85]:18050
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727427AbfCZBnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ScvCUNuhkDRSQJHycOu2zUaYDygUe8XzCeTVwEm3C0=;
 b=IC510iY2HnrJo5gK2lbZKmhnX2axXFg6sBXdPR8pLtBCdbVH+hR5Eqd616T9YoA06ud3Z1W7ev8PxhBNgIitAIwnXN6wiOBCxCfUJxN6xcNZMWkXF9/8zerJx2WkqWoQPtxRC9vVS8TFL2rSoRXq7mX0ZQ2+gm+LlMz8B7rwVaI=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 01:43:45 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 01:43:45 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>
Subject: RE: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
Thread-Topic: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
Thread-Index: AQHU4QXvNq2tSD+YZ0aNNrE4+GOfm6YdABKAgAAAkkCAAAyXgIAABJ/g
Date:   Tue, 26 Mar 2019 01:43:44 +0000
Message-ID: <VI1PR0501MB2271CECD3B2200BB5A7DEC00D15F0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
        <1553296835-37522-9-git-send-email-parav@mellanox.com>
        <20190325171831.1ac2a441@x1.home>
        <VI1PR0501MB2271CD34DCA1D1D5EDAFDBD7D15E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190325180537.11842c03@x1.home>
In-Reply-To: <20190325180537.11842c03@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1c2889e-728e-4bac-ec33-08d6b18c7be3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2271;
x-ms-traffictypediagnostic: VI1PR0501MB2271:
x-microsoft-antispam-prvs: <VI1PR0501MB227142923DA009FA4B69DD1BD15F0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(39860400002)(136003)(346002)(189003)(199004)(13464003)(26005)(52536014)(2906002)(68736007)(97736004)(186003)(305945005)(102836004)(86362001)(5660300002)(6506007)(229853002)(4326008)(8936002)(71200400001)(74316002)(76176011)(33656002)(99286004)(6436002)(55016002)(7696005)(8676002)(81166006)(93886005)(71190400001)(81156014)(14454004)(106356001)(66066001)(6246003)(9686003)(3846002)(6116002)(316002)(53936002)(256004)(54906003)(6916009)(53946003)(14444005)(478600001)(446003)(53546011)(7736002)(30864003)(25786009)(486006)(11346002)(105586002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2271;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uneKI6EvcYzs2kRhjqrh1EoktK+xBwqlK3TjYD8XCWdhKHznFYSe6jAZvRRWOiaLktAPW/fRdxuqDUWb7JHLK7SWBsoawMlfpjHPtrq5CSzWOzJFmvr3JTK3yt31hHxZp2aHW51JbNGIORxyg/Xo+mHryFnLqKwciKlVO4sxfgoA/QXZUC0qfe8yFSzKvHUW8/riqvPPo+e0bXWeMBueDrclrdsobHP1U1mxrr0/VrOPgDDvBFDOWRVnyikauC8Lcsh6C8vKuGyRsulaQgQtU/LyvuQHDzr2TnEMJmEbffnNKpEpWWv78edlH5eWjL94Z9pwayHt/ulFfPvctHYQirpDcMi0JBhctpq0Y2Ldj5GMVFFs6nHQv7O7qlN/ImYJ3Ny7cZ8ti5ayeAxPUSLb7vPjWy/SwaG+G/VvUYInrGo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c2889e-728e-4bac-ec33-08d6b18c7be3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 01:43:44.7112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Monday, March 25, 2019 7:06 PM
> To: Parav Pandit <parav@mellanox.com>
> Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> kwankhede@nvidia.com
> Subject: Re: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
>=20
> On Mon, 25 Mar 2019 23:34:28 +0000
> Parav Pandit <parav@mellanox.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Monday, March 25, 2019 6:19 PM
> > > To: Parav Pandit <parav@mellanox.com>
> > > Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > kwankhede@nvidia.com
> > > Subject: Re: [PATCH 8/8] vfio/mdev: Improve the create/remove
> > > sequence
> > >
> > > On Fri, 22 Mar 2019 18:20:35 -0500
> > > Parav Pandit <parav@mellanox.com> wrote:
> > >
> > > > There are five problems with current code structure.
> > > > 1. mdev device is placed on the mdev bus before it is created in
> > > > the vendor driver. Once a device is placed on the mdev bus without
> > > > creating its supporting underlying vendor device, an open() can
> > > > get triggered by userspace on partially initialized device.
> > > > Below ladder diagram highlight it.
> > > >
> > > >       cpu-0                                       cpu-1
> > > >       -----                                       -----
> > > >    create_store()
> > > >      mdev_create_device()
> > > >        device_register()
> > > >           ...
> > > >          vfio_mdev_probe()
> > > >          ...creates char device
> > > >                                         vfio_mdev_open()
> > > >                                           parent->ops->open(mdev)
> > > >                                             vfio_ap_mdev_open()
> > > >                                               matrix_mdev =3D NULL
> > > >         [...]
> > > >         parent->ops->create()
> > > >           vfio_ap_mdev_create()
> > > >             mdev_set_drvdata(mdev, matrix_mdev);
> > > >             /* Valid pointer set above */
> > > >
> > > > 2. Current creation sequence is,
> > > >    parent->ops_create()
> > > >    groups_register()
> > > >
> > > > Remove sequence is,
> > > >    parent->ops->remove()
> > > >    groups_unregister()
> > > > However, remove sequence should be exact mirror of creation
> sequence.
> > > > Once this is achieved, all users of the mdev will be terminated
> > > > first before removing underlying vendor device.
> > > > (Follow standard linux driver model).
> > > > At that point vendor's remove() ops shouldn't failed because
> > > > device is taken off the bus that should terminate the users.
> > > >
> > > > 3. Additionally any new mdev driver that wants to work on mdev
> > > > device during probe() routine registered using
> > > > mdev_register_driver() needs to get stable mdev structure.
> > > >
> > > > 4. In following sequence, child devices created while removing
> > > > mdev parent device can be left out, or it may lead to race of
> > > > removing half initialized child mdev devices.
> > > >
> > > > issue-1:
> > > > --------
> > > >        cpu-0                         cpu-1
> > > >        -----                         -----
> > > >                                   mdev_unregister_device()
> > > >                                      device_for_each_child()
> > > >                                         mdev_device_remove_cb()
> > > >                                             mdev_device_remove()
> > > > create_store()
> > > >   mdev_device_create()                   [...]
> > > >        device_register()
> > > >                                   parent_remove_sysfs_files()
> > > >                                   /* BUG: device added by cpu-0
> > > >                                    * whose parent is getting remove=
d.
> > > >                                    */
> > > >
> > > > issue-2:
> > > > --------
> > > >        cpu-0                         cpu-1
> > > >        -----                         -----
> > > > create_store()
> > > >   mdev_device_create()                   [...]
> > > >        device_register()
> > > >
> > > >        [...]                      mdev_unregister_device()
> > > >                                      device_for_each_child()
> > > >                                         mdev_device_remove_cb()
> > > >                                             mdev_device_remove()
> > > >
> > > >        mdev_create_sysfs_files()
> > > >        /* BUG: create is adding
> > > >         * sysfs files for a device
> > > >         * which is undergoing removal.
> > > >         */
> > > >                                  parent_remove_sysfs_files()
> > >
> > > In both cases above, it looks like the device will hold a reference
> > > to the parent, so while there is a race, the parent object isn't rele=
ased.
> > Yes, parent object is not released but parent fields are not stable.
> >
> > >
> > > >
> > > > 5. Below crash is observed when user initiated remove is in
> > > > progress and mdev_unregister_driver() completes parent
> unregistration.
> > > >
> > > >        cpu-0                         cpu-1
> > > >        -----                         -----
> > > > remove_store()
> > > >    mdev_device_remove()
> > > >    active =3D false;
> > > >                                   mdev_unregister_device()
> > > >                                     remove type
> > > >    [...]
> > > >    mdev_remove_ops() crashes.
> > > >
> > > > This is similar race like create() racing with mdev_unregister_devi=
ce().
> > >
> > > Not sure I catch this, the device should have a reference to the
> > > parent, and we don't specifically clear parent->ops, so what's
> > > getting removed that causes this oops?  Is .remove pointing at bad te=
xt
> regardless?
> > >
> > I guess the mdev_attr_groups being stale now.
> >
> > > > mtty mtty: MDEV: Registered
> > > > iommu: Adding device 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001 to group
> > > > 57 vfio_mdev 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001: MDEV: group_id
> > > > =3D 57 mdev_device_remove sleep started mtty mtty: MDEV:
> > > > Unregistering
> > > > mtty_dev: Unloaded!
> > > > BUG: unable to handle kernel paging request at ffffffffc027d668
> > > > PGD
> > > > af9818067 P4D af9818067 PUD af981a067 PMD 8583c3067 PTE 0
> > > > Oops: 0000 [#1] SMP PTI
> > > > CPU: 15 PID: 3517 Comm: bash Kdump: loaded Not tainted
> > > > 5.0.0-rc7-vdevbus+ #2 Hardware name: Supermicro
> > > > SYS-6028U-TR4+/X10DRU-i+, BIOS 2.0b 08/09/2016
> > > > RIP: 0010:mdev_device_remove_ops+0x1a/0x50 [mdev] Call Trace:
> > > >  mdev_device_remove+0xef/0x130 [mdev]
> > > >  remove_store+0x77/0xa0 [mdev]
> > > >  kernfs_fop_write+0x113/0x1a0
> > > >  __vfs_write+0x33/0x1b0
> > > >  ? rcu_read_lock_sched_held+0x64/0x70
> > > >  ? rcu_sync_lockdep_assert+0x2a/0x50  ?
> > > > __sb_start_write+0x121/0x1b0  ? vfs_write+0x17c/0x1b0
> > > >  vfs_write+0xad/0x1b0
> > > >  ? trace_hardirqs_on_thunk+0x1a/0x1c
> > > >  ksys_write+0x55/0xc0
> > > >  do_syscall_64+0x5a/0x210
> > > >
> > > > Therefore, mdev core is improved in following ways to overcome
> > > > above issues.
> > > >
> > > > 1. Before placing mdev devices on the bus, perform vendor drivers
> > > > creation which supports the mdev creation.
> > > > This ensures that mdev specific all necessary fields are
> > > > initialized before a given mdev can be accessed by bus driver.
> > > >
> > > > 2. During remove flow, first remove the device from the bus. This
> > > > ensures that any bus specific devices and data is cleared.
> > > > Once device is taken of the mdev bus, perform remove() of mdev
> > > > from the vendor driver.
> > > >
> > > > 3. Linux core device model provides way to register and auto
> > > > unregister the device sysfs attribute groups at dev->groups.
> > > > Make use of this groups to let core create the groups and simplify
> > > > code to avoid explicit groups creation and removal.
> > > >
> > > > 4. Wait for any ongoing mdev create() and remove() to finish
> > > > before unregistering parent device using srcu. This continues to
> > > > allow multiple create and remove to progress in parallel. At the
> > > > same time guard parent removal while parent is being access by
> > > > create() and remove
> > > callbacks.
> > >
> > > So there should be 4-5 separate patches here?  Wishful thinking?
> > >
> > create, remove racing with unregister is handled using srcu.
> > Change-3 cannot be done without fixing the sequence so it should be in
> patch that fixes it.
> > Change described changes 1-2-3 are just one change. It is just the patc=
h
> description to bring clarity.
> > Change-4 can be possibly done as split to different patch.
> >
> > > > Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> > > > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > > > ---
> > > >  drivers/vfio/mdev/mdev_core.c    | 142 +++++++++++++++++++++------=
---
> -----
> > > ----
> > > >  drivers/vfio/mdev/mdev_private.h |   7 +-
> > > >  drivers/vfio/mdev/mdev_sysfs.c   |   6 +-
> > > >  3 files changed, 84 insertions(+), 71 deletions(-)
> > > >
> > > > diff --git a/drivers/vfio/mdev/mdev_core.c
> > > > b/drivers/vfio/mdev/mdev_core.c index 944a058..8fe0ed1 100644
> > > > --- a/drivers/vfio/mdev/mdev_core.c
> > > > +++ b/drivers/vfio/mdev/mdev_core.c
> > > > @@ -84,6 +84,7 @@ static void mdev_release_parent(struct kref *kref=
)
> > > >  						  ref);
> > > >  	struct device *dev =3D parent->dev;
> > > >
> > > > +	cleanup_srcu_struct(&parent->unreg_srcu);
> > > >  	kfree(parent);
> > > >  	put_device(dev);
> > > >  }
> > > > @@ -103,56 +104,30 @@ static inline void mdev_put_parent(struct
> > > mdev_parent *parent)
> > > >  		kref_put(&parent->ref, mdev_release_parent);  }
> > > >
> > > > -static int mdev_device_create_ops(struct kobject *kobj,
> > > > -				  struct mdev_device *mdev)
> > > > +static int mdev_device_must_remove(struct mdev_device *mdev)
> > >
> > > Naming is off here, mdev_device_remove_common()?
> > >
> > Yes, sounds better.
> >
> > > >  {
> > > > -	struct mdev_parent *parent =3D mdev->parent;
> > > > +	struct mdev_parent *parent;
> > > > +	struct mdev_type *type;
> > > >  	int ret;
> > > >
> > > > -	ret =3D parent->ops->create(kobj, mdev);
> > > > -	if (ret)
> > > > -		return ret;
> > > > +	type =3D to_mdev_type(mdev->type_kobj);
> > > >
> > > > -	ret =3D sysfs_create_groups(&mdev->dev.kobj,
> > > > -				  parent->ops->mdev_attr_groups);
> > > > +	mdev_remove_sysfs_files(&mdev->dev, type);
> > > > +	device_del(&mdev->dev);
> > > > +	parent =3D mdev->parent;
> > > > +	ret =3D parent->ops->remove(mdev);
> > > >  	if (ret)
> > > > -		parent->ops->remove(mdev);
> > > > +		dev_err(&mdev->dev, "Remove failed: err=3D%d\n", ret);
> > >
> > > Let the caller decide whether to be verbose with the error, parent
> > > removal might want to warn, sysfs remove might just return an error.
> > >
> > I didn't follow. Caller meaning mdev_device_remove_common() or vendor
> driver?
>=20
> I mean the callback iterator on the parent remove can do a WARN_ON if thi=
s
> returns an error while the device remove path can silently return -EBUSY,=
 the
> common function doesn't need to decide whether the parent ops remove
> function deserves a dev_err.
>=20
Ok. I understood.=20
But device remove returning silent -EBUSY looks an error that should get lo=
gged in, because this is something not expected.
Its probably late for sysfs layer to return report an error by that time it=
 prints device name, because put_device() is done.
So if remove() returns an error, I think its legitimate failure to do WARN_=
ON or dev_err().

> > > >
> > > > +	/* Balances with device_initialize() */
> > > > +	put_device(&mdev->dev);
> > > >  	return ret;
> > > >  }
> > > >
> > > > -/*
> > > > - * mdev_device_remove_ops gets called from sysfs's 'remove' and
> > > > when parent
> > > > - * device is being unregistered from mdev device framework.
> > > > - * - 'force_remove' is set to 'false' when called from sysfs's 're=
move'
> which
> > > > - *   indicates that if the mdev device is active, used by VMM or
> userspace
> > > > - *   application, vendor driver could return error then don't remo=
ve
> the
> > > device.
> > > > - * - 'force_remove' is set to 'true' when called from
> > > mdev_unregister_device()
> > > > - *   which indicate that parent device is being removed from mdev
> device
> > > > - *   framework so remove mdev device forcefully.
> > > > - */
> > > > -static int mdev_device_remove_ops(struct mdev_device *mdev, bool
> > > > force_remove) -{
> > > > -	struct mdev_parent *parent =3D mdev->parent;
> > > > -	int ret;
> > > > -
> > > > -	/*
> > > > -	 * Vendor driver can return error if VMM or userspace application=
 is
> > > > -	 * using this mdev device.
> > > > -	 */
> > > > -	ret =3D parent->ops->remove(mdev);
> > > > -	if (ret && !force_remove)
> > > > -		return ret;
> > > > -
> > > > -	sysfs_remove_groups(&mdev->dev.kobj, parent->ops-
> > > >mdev_attr_groups);
> > > > -	return 0;
> > > > -}
> > >
> > > Seems like there's easily a separate patch in pushing the
> > > create/remove ops into the calling function and separating for the
> > > iterator callback, that would make this easier to review.
> > >
> > > > -
> > > >  static int mdev_device_remove_cb(struct device *dev, void *data)  =
{
> > > >  	if (dev_is_mdev(dev))
> > > > -		mdev_device_remove(dev, true);
> > > > -
> > > > +		mdev_device_must_remove(to_mdev_device(dev));
> > > >  	return 0;
> > > >  }
> > > >
> > > > @@ -194,6 +169,7 @@ int mdev_register_device(struct device *dev,
> > > > const
> > > struct mdev_parent_ops *ops)
> > > >  	}
> > > >
> > > >  	kref_init(&parent->ref);
> > > > +	init_srcu_struct(&parent->unreg_srcu);
> > > >
> > > >  	parent->dev =3D dev;
> > > >  	parent->ops =3D ops;
> > > > @@ -214,6 +190,7 @@ int mdev_register_device(struct device *dev,
> > > > const
> > > struct mdev_parent_ops *ops)
> > > >  	if (ret)
> > > >  		dev_warn(dev, "Failed to create compatibility class link\n");
> > > >
> > > > +	rcu_assign_pointer(parent->self, parent);
> > > >  	list_add(&parent->next, &parent_list);
> > > >  	mutex_unlock(&parent_list_lock);
> > > >
> > > > @@ -244,21 +221,36 @@ void mdev_unregister_device(struct device
> > > > *dev)
> > > >
> > > >  	mutex_lock(&parent_list_lock);
> > > >  	parent =3D __find_parent_device(dev);
> > > > -
> > > >  	if (!parent) {
> > > >  		mutex_unlock(&parent_list_lock);
> > > >  		return;
> > > >  	}
> > > > +	list_del(&parent->next);
> > > > +	mutex_unlock(&parent_list_lock);
> > > > +
> > > >  	dev_info(dev, "MDEV: Unregistering\n");
> > > >
> > > > -	list_del(&parent->next);
> > > > +	/* Publish that this mdev parent is unregistering. So any new
> > > > +	 * create/remove cannot start on this parent anymore by user.
> > > > +	 */
> > >
> > > Comment style, we're not in netdev.
> > Yep. Will fix it.
> > >
> > > > +	rcu_assign_pointer(parent->self, NULL);
> > > > +
> > > > +	/*
> > > > +	 * Wait for any active create() or remove() mdev ops on the paren=
t
> > > > +	 * to complete.
> > > > +	 */
> > > > +	synchronize_srcu(&parent->unreg_srcu);
> > > > +
> > > > +	/* At this point it is confirmed that any pending user initiated
> > > > +	 * create or remove callbacks accessing the parent are completed.
> > > > +	 * It is safe to remove the parent now.
> > > > +	 */
> > > >  	class_compat_remove_link(mdev_bus_compat_class, dev, NULL);
> > > >
> > > >  	device_for_each_child(dev, NULL, mdev_device_remove_cb);
> > > >
> > > >  	parent_remove_sysfs_files(parent);
> > > >
> > > > -	mutex_unlock(&parent_list_lock);
> > > >  	mdev_put_parent(parent);
> > > >  }
> > > >  EXPORT_SYMBOL(mdev_unregister_device);
> > > > @@ -278,14 +270,24 @@ static void mdev_device_release(struct
> > > > device
> > > > *dev)  int mdev_device_create(struct kobject *kobj, struct device
> > > > *dev, uuid_le uuid)  {
> > > >  	int ret;
> > > > +	struct mdev_parent *valid_parent;
> > > >  	struct mdev_device *mdev, *tmp;
> > > >  	struct mdev_parent *parent;
> > > >  	struct mdev_type *type =3D to_mdev_type(kobj);
> > > > +	int srcu_idx;
> > > >
> > > >  	parent =3D mdev_get_parent(type->parent);
> > > >  	if (!parent)
> > > >  		return -EINVAL;
> > > >
> > > > +	srcu_idx =3D srcu_read_lock(&parent->unreg_srcu);
> > > > +	valid_parent =3D srcu_dereference(parent->self, &parent->unreg_sr=
cu);
> > > > +	if (!valid_parent) {
> > > > +		/* parent is undergoing unregistration */
> > > > +		ret =3D -ENODEV;
> > > > +		goto mdev_fail;
> > > > +	}
> > > > +
> > > >  	mutex_lock(&mdev_list_lock);
> > > >
> > > >  	/* Check for duplicate */
> > > > @@ -310,68 +312,76 @@ int mdev_device_create(struct kobject *kobj,
> > > > struct device *dev, uuid_le uuid)
> > > >
> > > >  	mdev->parent =3D parent;
> > > >
> > > > +	device_initialize(&mdev->dev);
> > > >  	mdev->dev.parent  =3D dev;
> > > >  	mdev->dev.bus     =3D &mdev_bus_type;
> > > >  	mdev->dev.release =3D mdev_device_release;
> > > > +	mdev->dev.groups =3D type->parent->ops->mdev_attr_groups;
> > > >  	dev_set_name(&mdev->dev, "%pUl", uuid.b);
> > > >
> > > > -	ret =3D device_register(&mdev->dev);
> > > > +	ret =3D type->parent->ops->create(kobj, mdev);
> > > >  	if (ret)
> > > > -		goto mdev_fail;
> > > > +		goto create_fail;
> > > >
> > > > -	ret =3D mdev_device_create_ops(kobj, mdev);
> > > > +	ret =3D device_add(&mdev->dev);
> > >
> > > Separating device_initialize() and device_add() also looks like a
> > > separate patch, then the srcu could be added at the end.  Thanks,
> > >
> > > Alex
> >
> > I saw little more core generated that way, but I think its fine.
> > Basically, create/remove callback sequencing that does the
> > device_inititailze/add etc in one patch and User side race handling usi=
ng
> srcu in another patch.
> > Sounds good?
>=20
> Splitting device_register into device_intialize/device_add solves the fir=
st
> issue alone, that can be one patch. =20
Yes, once this is done, mdev_device_create_ops() is just a one line wrapper=
 to groups creation.
Hence I was considering to do in same patch, but its fine as a separate cle=
an up patch.
More split details below.

> Creating the common remove function
> seems like a logical next patch.  The third patch could be using the driv=
er-
> core group attribute via those paths.  Another patch could then incorpora=
te
> the srcu code to gate the create/remove around parent removal.  This
> basically matches your steps to address these issues, it seems very split=
-able.
> Thanks,
>=20
So I reworked to split this one patch to following smaller refactor and fix=
es.
1. use of device_inititalize/add/remove helpers without fixing the sequence=
 as prep patch
2. fix the create/remove sequence
3. factor out groups creation
4. remove helper function
5. srcu fix

> Alex
