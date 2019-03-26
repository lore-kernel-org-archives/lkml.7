Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B09C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 03:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5592220828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 03:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="jXCi6kmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbfCZDTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 23:19:22 -0400
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:63342
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729993AbfCZDTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 23:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/0NieMJCol+W16eD4yiiiooD3/6IotKoUgmGf9rdjM=;
 b=jXCi6kmZBUkyuHZoPUFN1Zyb2OgGWckAHLYo7xsdah2lTA4sboEW8heYLsdg8eu+l0XMV71kIT9P9ImOHEj0705gCf3AdFm3OUcK6O0JDr9kOGy4XTNvDo88waoXIciDsR36qCD8OeIC6Kvuk5ccsgfPQ8+ILB42quNXtk3y9UY=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2719.eurprd05.prod.outlook.com (10.172.15.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.17; Tue, 26 Mar 2019 03:19:15 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 03:19:14 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>
Subject: RE: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
Thread-Topic: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
Thread-Index: AQHU4QXvNq2tSD+YZ0aNNrE4+GOfm6YdABKAgAAAkkCAAAyXgIAABJ/ggAAgBYCAABDwMA==
Date:   Tue, 26 Mar 2019 03:19:14 +0000
Message-ID: <VI1PR0501MB227124A89CF30D12E89CF5D8D15F0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
        <1553296835-37522-9-git-send-email-parav@mellanox.com>
        <20190325171831.1ac2a441@x1.home>
        <VI1PR0501MB2271CD34DCA1D1D5EDAFDBD7D15E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
        <20190325180537.11842c03@x1.home>
        <VI1PR0501MB2271CECD3B2200BB5A7DEC00D15F0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190325201645.1ba4e9bf@x1.home>
In-Reply-To: <20190325201645.1ba4e9bf@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [2605:6000:ec80:6500:886:ad5:427f:de73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc046f9a-6290-4c52-ffe8-08d6b199d31c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2719;
x-ms-traffictypediagnostic: VI1PR0501MB2719:
x-microsoft-antispam-prvs: <VI1PR0501MB27198F3625C026B2372F5337D15F0@VI1PR0501MB2719.eurprd05.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(39860400002)(396003)(13464003)(199004)(189003)(446003)(102836004)(316002)(4326008)(81166006)(81156014)(106356001)(105586002)(93886005)(52536014)(6116002)(8676002)(5660300002)(11346002)(7736002)(54906003)(53936002)(478600001)(6436002)(6246003)(305945005)(86362001)(486006)(8936002)(14444005)(476003)(256004)(30864003)(55016002)(25786009)(7696005)(14454004)(99286004)(68736007)(33656002)(76176011)(74316002)(71190400001)(229853002)(71200400001)(2906002)(97736004)(6506007)(53546011)(46003)(9686003)(6916009)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2719;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Od9WWMY+1bFWVylU3ady8rw3b720fWAezV0+v+iAqWjKsiUKAKk+40sBcC1JZU+/sYK1kkEmQFwLYUMEibhx5tMy+cdabs3WO3Lqj25nM2SBwfCA158NLUwdP1wYjQjhuDo+64H7CJH3ZnQ6TDI8Zt2Ve9+3jvprDrUJvxzK6ooNRMrqIwiZ4T5s2FWToXRWcMmlStSKjNQIgV9+GMa8HMK1/ZtFBcSkWPbcCK2+0NrhhFYHTIc8/IGl37B+53+eKuFm/rax/40CCrIiepwAfGCRUiMQp8VpuKCHsbYjm+Q9Dz5hY2j8HHpfpcruvJyou1c8BxoLqYnsjajseZNjU3p4PJ1rEyQKe96LpvzF5wStg0F02NPdvq9df3IrCst8yk7DVlF0jBthL3Ea5iw6xIrov/fehjJC+O7PU9mAIKg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc046f9a-6290-4c52-ffe8-08d6b199d31c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 03:19:14.9059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2719
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Monday, March 25, 2019 9:17 PM
> To: Parav Pandit <parav@mellanox.com>
> Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> kwankhede@nvidia.com
> Subject: Re: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
>=20
> On Tue, 26 Mar 2019 01:43:44 +0000
> Parav Pandit <parav@mellanox.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Monday, March 25, 2019 7:06 PM
> > > To: Parav Pandit <parav@mellanox.com>
> > > Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > kwankhede@nvidia.com
> > > Subject: Re: [PATCH 8/8] vfio/mdev: Improve the create/remove
> > > sequence
> > >
> > > On Mon, 25 Mar 2019 23:34:28 +0000
> > > Parav Pandit <parav@mellanox.com> wrote:
> > >
> > > > > -----Original Message-----
> > > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > > Sent: Monday, March 25, 2019 6:19 PM
> > > > > To: Parav Pandit <parav@mellanox.com>
> > > > > Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > > kwankhede@nvidia.com
> > > > > Subject: Re: [PATCH 8/8] vfio/mdev: Improve the create/remove
> > > > > sequence
> > > > >
> > > > > On Fri, 22 Mar 2019 18:20:35 -0500 Parav Pandit
> > > > > <parav@mellanox.com> wrote:
> > > > >
> > > > > > There are five problems with current code structure.
> > > > > > 1. mdev device is placed on the mdev bus before it is created
> > > > > > in the vendor driver. Once a device is placed on the mdev bus
> > > > > > without creating its supporting underlying vendor device, an
> > > > > > open() can get triggered by userspace on partially initialized =
device.
> > > > > > Below ladder diagram highlight it.
> > > > > >
> > > > > >       cpu-0                                       cpu-1
> > > > > >       -----                                       -----
> > > > > >    create_store()
> > > > > >      mdev_create_device()
> > > > > >        device_register()
> > > > > >           ...
> > > > > >          vfio_mdev_probe()
> > > > > >          ...creates char device
> > > > > >                                         vfio_mdev_open()
> > > > > >                                           parent->ops->open(mde=
v)
> > > > > >                                             vfio_ap_mdev_open()
> > > > > >                                               matrix_mdev =3D N=
ULL
> > > > > >         [...]
> > > > > >         parent->ops->create()
> > > > > >           vfio_ap_mdev_create()
> > > > > >             mdev_set_drvdata(mdev, matrix_mdev);
> > > > > >             /* Valid pointer set above */
> > > > > >
> > > > > > 2. Current creation sequence is,
> > > > > >    parent->ops_create()
> > > > > >    groups_register()
> > > > > >
> > > > > > Remove sequence is,
> > > > > >    parent->ops->remove()
> > > > > >    groups_unregister()
> > > > > > However, remove sequence should be exact mirror of creation
> > > sequence.
> > > > > > Once this is achieved, all users of the mdev will be
> > > > > > terminated first before removing underlying vendor device.
> > > > > > (Follow standard linux driver model).
> > > > > > At that point vendor's remove() ops shouldn't failed because
> > > > > > device is taken off the bus that should terminate the users.
> > > > > >
> > > > > > 3. Additionally any new mdev driver that wants to work on mdev
> > > > > > device during probe() routine registered using
> > > > > > mdev_register_driver() needs to get stable mdev structure.
> > > > > >
> > > > > > 4. In following sequence, child devices created while removing
> > > > > > mdev parent device can be left out, or it may lead to race of
> > > > > > removing half initialized child mdev devices.
> > > > > >
> > > > > > issue-1:
> > > > > > --------
> > > > > >        cpu-0                         cpu-1
> > > > > >        -----                         -----
> > > > > >                                   mdev_unregister_device()
> > > > > >                                      device_for_each_child()
> > > > > >                                         mdev_device_remove_cb()
> > > > > >
> > > > > > mdev_device_remove()
> > > > > > create_store()
> > > > > >   mdev_device_create()                   [...]
> > > > > >        device_register()
> > > > > >                                   parent_remove_sysfs_files()
> > > > > >                                   /* BUG: device added by cpu-0
> > > > > >                                    * whose parent is getting re=
moved.
> > > > > >                                    */
> > > > > >
> > > > > > issue-2:
> > > > > > --------
> > > > > >        cpu-0                         cpu-1
> > > > > >        -----                         -----
> > > > > > create_store()
> > > > > >   mdev_device_create()                   [...]
> > > > > >        device_register()
> > > > > >
> > > > > >        [...]                      mdev_unregister_device()
> > > > > >                                      device_for_each_child()
> > > > > >                                         mdev_device_remove_cb()
> > > > > >
> > > > > > mdev_device_remove()
> > > > > >
> > > > > >        mdev_create_sysfs_files()
> > > > > >        /* BUG: create is adding
> > > > > >         * sysfs files for a device
> > > > > >         * which is undergoing removal.
> > > > > >         */
> > > > > >                                  parent_remove_sysfs_files()
> > > > >
> > > > > In both cases above, it looks like the device will hold a
> > > > > reference to the parent, so while there is a race, the parent obj=
ect
> isn't released.
> > > > Yes, parent object is not released but parent fields are not stable=
.
> > > >
> > > > >
> > > > > >
> > > > > > 5. Below crash is observed when user initiated remove is in
> > > > > > progress and mdev_unregister_driver() completes parent
> > > unregistration.
> > > > > >
> > > > > >        cpu-0                         cpu-1
> > > > > >        -----                         -----
> > > > > > remove_store()
> > > > > >    mdev_device_remove()
> > > > > >    active =3D false;
> > > > > >                                   mdev_unregister_device()
> > > > > >                                     remove type
> > > > > >    [...]
> > > > > >    mdev_remove_ops() crashes.
> > > > > >
> > > > > > This is similar race like create() racing with
> mdev_unregister_device().
> > > > >
> > > > > Not sure I catch this, the device should have a reference to the
> > > > > parent, and we don't specifically clear parent->ops, so what's
> > > > > getting removed that causes this oops?  Is .remove pointing at
> > > > > bad text
> > > regardless?
> > > > >
> > > > I guess the mdev_attr_groups being stale now.
> > > >
> > > > > > mtty mtty: MDEV: Registered
> > > > > > iommu: Adding device 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001 to
> > > > > > group
> > > > > > 57 vfio_mdev 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001: MDEV:
> > > > > > group_id =3D 57 mdev_device_remove sleep started mtty mtty: MDE=
V:
> > > > > > Unregistering
> > > > > > mtty_dev: Unloaded!
> > > > > > BUG: unable to handle kernel paging request at
> > > > > > ffffffffc027d668 PGD
> > > > > > af9818067 P4D af9818067 PUD af981a067 PMD 8583c3067 PTE 0
> > > > > > Oops: 0000 [#1] SMP PTI
> > > > > > CPU: 15 PID: 3517 Comm: bash Kdump: loaded Not tainted
> > > > > > 5.0.0-rc7-vdevbus+ #2 Hardware name: Supermicro
> > > > > > SYS-6028U-TR4+/X10DRU-i+, BIOS 2.0b 08/09/2016
> > > > > > RIP: 0010:mdev_device_remove_ops+0x1a/0x50 [mdev] Call Trace:
> > > > > >  mdev_device_remove+0xef/0x130 [mdev]
> > > > > >  remove_store+0x77/0xa0 [mdev]
> > > > > >  kernfs_fop_write+0x113/0x1a0
> > > > > >  __vfs_write+0x33/0x1b0
> > > > > >  ? rcu_read_lock_sched_held+0x64/0x70
> > > > > >  ? rcu_sync_lockdep_assert+0x2a/0x50  ?
> > > > > > __sb_start_write+0x121/0x1b0  ? vfs_write+0x17c/0x1b0
> > > > > >  vfs_write+0xad/0x1b0
> > > > > >  ? trace_hardirqs_on_thunk+0x1a/0x1c
> > > > > >  ksys_write+0x55/0xc0
> > > > > >  do_syscall_64+0x5a/0x210
> > > > > >
> > > > > > Therefore, mdev core is improved in following ways to overcome
> > > > > > above issues.
> > > > > >
> > > > > > 1. Before placing mdev devices on the bus, perform vendor
> > > > > > drivers creation which supports the mdev creation.
> > > > > > This ensures that mdev specific all necessary fields are
> > > > > > initialized before a given mdev can be accessed by bus driver.
> > > > > >
> > > > > > 2. During remove flow, first remove the device from the bus.
> > > > > > This ensures that any bus specific devices and data is cleared.
> > > > > > Once device is taken of the mdev bus, perform remove() of mdev
> > > > > > from the vendor driver.
> > > > > >
> > > > > > 3. Linux core device model provides way to register and auto
> > > > > > unregister the device sysfs attribute groups at dev->groups.
> > > > > > Make use of this groups to let core create the groups and
> > > > > > simplify code to avoid explicit groups creation and removal.
> > > > > >
> > > > > > 4. Wait for any ongoing mdev create() and remove() to finish
> > > > > > before unregistering parent device using srcu. This continues
> > > > > > to allow multiple create and remove to progress in parallel.
> > > > > > At the same time guard parent removal while parent is being
> > > > > > access by
> > > > > > create() and remove
> > > > > callbacks.
> > > > >
> > > > > So there should be 4-5 separate patches here?  Wishful thinking?
> > > > >
> > > > create, remove racing with unregister is handled using srcu.
> > > > Change-3 cannot be done without fixing the sequence so it should
> > > > be in
> > > patch that fixes it.
> > > > Change described changes 1-2-3 are just one change. It is just the
> > > > patch
> > > description to bring clarity.
> > > > Change-4 can be possibly done as split to different patch.
> > > >
> > > > > > Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> > > > > > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > > > > > ---
> > > > > >  drivers/vfio/mdev/mdev_core.c    | 142 +++++++++++++++++++++--=
--
> -----
> > > -----
> > > > > ----
> > > > > >  drivers/vfio/mdev/mdev_private.h |   7 +-
> > > > > >  drivers/vfio/mdev/mdev_sysfs.c   |   6 +-
> > > > > >  3 files changed, 84 insertions(+), 71 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/vfio/mdev/mdev_core.c
> > > > > > b/drivers/vfio/mdev/mdev_core.c index 944a058..8fe0ed1 100644
> > > > > > --- a/drivers/vfio/mdev/mdev_core.c
> > > > > > +++ b/drivers/vfio/mdev/mdev_core.c
> > > > > > @@ -84,6 +84,7 @@ static void mdev_release_parent(struct kref
> *kref)
> > > > > >  						  ref);
> > > > > >  	struct device *dev =3D parent->dev;
> > > > > >
> > > > > > +	cleanup_srcu_struct(&parent->unreg_srcu);
> > > > > >  	kfree(parent);
> > > > > >  	put_device(dev);
> > > > > >  }
> > > > > > @@ -103,56 +104,30 @@ static inline void
> > > > > > mdev_put_parent(struct
> > > > > mdev_parent *parent)
> > > > > >  		kref_put(&parent->ref, mdev_release_parent);  }
> > > > > >
> > > > > > -static int mdev_device_create_ops(struct kobject *kobj,
> > > > > > -				  struct mdev_device *mdev)
> > > > > > +static int mdev_device_must_remove(struct mdev_device *mdev)
> > > > >
> > > > > Naming is off here, mdev_device_remove_common()?
> > > > >
> > > > Yes, sounds better.
> > > >
> > > > > >  {
> > > > > > -	struct mdev_parent *parent =3D mdev->parent;
> > > > > > +	struct mdev_parent *parent;
> > > > > > +	struct mdev_type *type;
> > > > > >  	int ret;
> > > > > >
> > > > > > -	ret =3D parent->ops->create(kobj, mdev);
> > > > > > -	if (ret)
> > > > > > -		return ret;
> > > > > > +	type =3D to_mdev_type(mdev->type_kobj);
> > > > > >
> > > > > > -	ret =3D sysfs_create_groups(&mdev->dev.kobj,
> > > > > > -				  parent->ops->mdev_attr_groups);
> > > > > > +	mdev_remove_sysfs_files(&mdev->dev, type);
> > > > > > +	device_del(&mdev->dev);
> > > > > > +	parent =3D mdev->parent;
> > > > > > +	ret =3D parent->ops->remove(mdev);
> > > > > >  	if (ret)
> > > > > > -		parent->ops->remove(mdev);
> > > > > > +		dev_err(&mdev->dev, "Remove failed: err=3D%d\n",
> ret);
> > > > >
> > > > > Let the caller decide whether to be verbose with the error,
> > > > > parent removal might want to warn, sysfs remove might just return
> an error.
> > > > >
> > > > I didn't follow. Caller meaning mdev_device_remove_common() or
> > > > vendor
> > > driver?
> > >
> > > I mean the callback iterator on the parent remove can do a WARN_ON
> > > if this returns an error while the device remove path can silently
> > > return -EBUSY, the common function doesn't need to decide whether
> > > the parent ops remove function deserves a dev_err.
> > >
> > Ok. I understood.
> > But device remove returning silent -EBUSY looks an error that should
> > get logged in, because this is something not expected. Its probably
> > late for sysfs layer to return report an error by that time it prints
> > device name, because put_device() is done. So if remove() returns an
> > error, I think its legitimate failure to do WARN_ON or dev_err().
>=20
> Calling put_device() if the parent remove op fails looks like a bug intro=
duced
> by this series, the current code allows that failure leaving the device i=
n a
> coherent state and returning errno to the sysfs store function.
>=20
Why should it fail?
We are taking off the device bus first as describe in commit log.
This ensures that everything is closed before calling the remove().
We cannot avoid put_device() and put_parent, it all buggy path...
