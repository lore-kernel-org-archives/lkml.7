Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EE9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4524420848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ISiwKb/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfCYXel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:34:41 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:4354
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726061AbfCYXel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUHXyeyctqe3Fvk9c6qi0jHC3hiYXvmsxlU0jsptffI=;
 b=ISiwKb/vXyxcY0zGBcz2h/JcQh3tGefvD04HRX7vi1USiQopRIELukqPsm+kvhOKsg5XxSVsGPiebQgg3geuZhH3dASSfqAntt2M7posbA6OGxM8sU53m7QGj0VppNiruRQtjAmTslJYWOjtGYO/JSfyt6fsx5Ia5MGA6SqjzbA=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2862.eurprd05.prod.outlook.com (10.172.12.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 23:34:29 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 23:34:29 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>
Subject: RE: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
Thread-Topic: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
Thread-Index: AQHU4QXvNq2tSD+YZ0aNNrE4+GOfm6YdABKAgAAAkkA=
Date:   Mon, 25 Mar 2019 23:34:28 +0000
Message-ID: <VI1PR0501MB2271CD34DCA1D1D5EDAFDBD7D15E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
        <1553296835-37522-9-git-send-email-parav@mellanox.com>
 <20190325171831.1ac2a441@x1.home>
In-Reply-To: <20190325171831.1ac2a441@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ced4608b-03a1-4d3e-ecd4-08d6b17a6cf6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2862;
x-ms-traffictypediagnostic: VI1PR0501MB2862:
x-microsoft-antispam-prvs: <VI1PR0501MB286234C7017A4B6FCC12D723D15E0@VI1PR0501MB2862.eurprd05.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(136003)(376002)(346002)(13464003)(199004)(189003)(99286004)(81156014)(4326008)(81166006)(25786009)(86362001)(66066001)(8936002)(478600001)(53546011)(14444005)(106356001)(8676002)(105586002)(30864003)(5660300002)(3846002)(76176011)(7696005)(53946003)(68736007)(6116002)(9686003)(33656002)(102836004)(6506007)(14454004)(55016002)(256004)(6246003)(26005)(53936002)(229853002)(97736004)(2906002)(186003)(305945005)(7736002)(74316002)(6436002)(6916009)(316002)(54906003)(446003)(11346002)(476003)(71200400001)(486006)(52536014)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2862;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wQZG7p1dL1OghBY6LW+2Bb1jbZRwwO1utBZXJuC/dIpwXvhLRtlFYa1qcpZoQZA0Y9amJK0RhIuk7Kc0jALy7rYy0JNbVtEd++thNmC84JS8oJhKUFgDzQ+CcfgUVvA0SMqEvqnPChpyUAPn1VSOQKCVipcfMaxyeYiIvIuB708ONvnT9SynyPYSmOmuNGN3VQoj+XbCveeTuwjkwmioHxYkPq8YoeOeXWCrezjG3bcnJZIKWhNNHQHI4dCQfU5dvuXOle9fY2EIhu1m+oFpu5ZSZTjptO8Ji5WayimDxG1JpnzZoq8fVPYEATiD8lfiXLlFijrgoNSlPe0XAIFouLP5BTvtioriLHzMITiLc2tD4mjdTsHE3DkdVBrcbDFTltuNEcqoIi9fmYbsXESBaPgneZj1p8DcmJb5m/lMBe0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced4608b-03a1-4d3e-ecd4-08d6b17a6cf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 23:34:28.9970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2862
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Monday, March 25, 2019 6:19 PM
> To: Parav Pandit <parav@mellanox.com>
> Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> kwankhede@nvidia.com
> Subject: Re: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
>=20
> On Fri, 22 Mar 2019 18:20:35 -0500
> Parav Pandit <parav@mellanox.com> wrote:
>=20
> > There are five problems with current code structure.
> > 1. mdev device is placed on the mdev bus before it is created in the
> > vendor driver. Once a device is placed on the mdev bus without
> > creating its supporting underlying vendor device, an open() can get
> > triggered by userspace on partially initialized device.
> > Below ladder diagram highlight it.
> >
> >       cpu-0                                       cpu-1
> >       -----                                       -----
> >    create_store()
> >      mdev_create_device()
> >        device_register()
> >           ...
> >          vfio_mdev_probe()
> >          ...creates char device
> >                                         vfio_mdev_open()
> >                                           parent->ops->open(mdev)
> >                                             vfio_ap_mdev_open()
> >                                               matrix_mdev =3D NULL
> >         [...]
> >         parent->ops->create()
> >           vfio_ap_mdev_create()
> >             mdev_set_drvdata(mdev, matrix_mdev);
> >             /* Valid pointer set above */
> >
> > 2. Current creation sequence is,
> >    parent->ops_create()
> >    groups_register()
> >
> > Remove sequence is,
> >    parent->ops->remove()
> >    groups_unregister()
> > However, remove sequence should be exact mirror of creation sequence.
> > Once this is achieved, all users of the mdev will be terminated first
> > before removing underlying vendor device.
> > (Follow standard linux driver model).
> > At that point vendor's remove() ops shouldn't failed because device is
> > taken off the bus that should terminate the users.
> >
> > 3. Additionally any new mdev driver that wants to work on mdev device
> > during probe() routine registered using mdev_register_driver() needs
> > to get stable mdev structure.
> >
> > 4. In following sequence, child devices created while removing mdev
> > parent device can be left out, or it may lead to race of removing half
> > initialized child mdev devices.
> >
> > issue-1:
> > --------
> >        cpu-0                         cpu-1
> >        -----                         -----
> >                                   mdev_unregister_device()
> >                                      device_for_each_child()
> >                                         mdev_device_remove_cb()
> >                                             mdev_device_remove()
> > create_store()
> >   mdev_device_create()                   [...]
> >        device_register()
> >                                   parent_remove_sysfs_files()
> >                                   /* BUG: device added by cpu-0
> >                                    * whose parent is getting removed.
> >                                    */
> >
> > issue-2:
> > --------
> >        cpu-0                         cpu-1
> >        -----                         -----
> > create_store()
> >   mdev_device_create()                   [...]
> >        device_register()
> >
> >        [...]                      mdev_unregister_device()
> >                                      device_for_each_child()
> >                                         mdev_device_remove_cb()
> >                                             mdev_device_remove()
> >
> >        mdev_create_sysfs_files()
> >        /* BUG: create is adding
> >         * sysfs files for a device
> >         * which is undergoing removal.
> >         */
> >                                  parent_remove_sysfs_files()
>=20
> In both cases above, it looks like the device will hold a reference to th=
e
> parent, so while there is a race, the parent object isn't released.
Yes, parent object is not released but parent fields are not stable.

>=20
> >
> > 5. Below crash is observed when user initiated remove is in progress
> > and mdev_unregister_driver() completes parent unregistration.
> >
> >        cpu-0                         cpu-1
> >        -----                         -----
> > remove_store()
> >    mdev_device_remove()
> >    active =3D false;
> >                                   mdev_unregister_device()
> >                                     remove type
> >    [...]
> >    mdev_remove_ops() crashes.
> >
> > This is similar race like create() racing with mdev_unregister_device()=
.
>=20
> Not sure I catch this, the device should have a reference to the parent, =
and
> we don't specifically clear parent->ops, so what's getting removed that
> causes this oops?  Is .remove pointing at bad text regardless?
>=20
I guess the mdev_attr_groups being stale now.

> > mtty mtty: MDEV: Registered
> > iommu: Adding device 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001 to group 57
> > vfio_mdev 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001: MDEV: group_id =3D 57
> > mdev_device_remove sleep started mtty mtty: MDEV: Unregistering
> > mtty_dev: Unloaded!
> > BUG: unable to handle kernel paging request at ffffffffc027d668 PGD
> > af9818067 P4D af9818067 PUD af981a067 PMD 8583c3067 PTE 0
> > Oops: 0000 [#1] SMP PTI
> > CPU: 15 PID: 3517 Comm: bash Kdump: loaded Not tainted
> > 5.0.0-rc7-vdevbus+ #2 Hardware name: Supermicro
> > SYS-6028U-TR4+/X10DRU-i+, BIOS 2.0b 08/09/2016
> > RIP: 0010:mdev_device_remove_ops+0x1a/0x50 [mdev] Call Trace:
> >  mdev_device_remove+0xef/0x130 [mdev]
> >  remove_store+0x77/0xa0 [mdev]
> >  kernfs_fop_write+0x113/0x1a0
> >  __vfs_write+0x33/0x1b0
> >  ? rcu_read_lock_sched_held+0x64/0x70
> >  ? rcu_sync_lockdep_assert+0x2a/0x50
> >  ? __sb_start_write+0x121/0x1b0
> >  ? vfs_write+0x17c/0x1b0
> >  vfs_write+0xad/0x1b0
> >  ? trace_hardirqs_on_thunk+0x1a/0x1c
> >  ksys_write+0x55/0xc0
> >  do_syscall_64+0x5a/0x210
> >
> > Therefore, mdev core is improved in following ways to overcome above
> > issues.
> >
> > 1. Before placing mdev devices on the bus, perform vendor drivers
> > creation which supports the mdev creation.
> > This ensures that mdev specific all necessary fields are initialized
> > before a given mdev can be accessed by bus driver.
> >
> > 2. During remove flow, first remove the device from the bus. This
> > ensures that any bus specific devices and data is cleared.
> > Once device is taken of the mdev bus, perform remove() of mdev from
> > the vendor driver.
> >
> > 3. Linux core device model provides way to register and auto
> > unregister the device sysfs attribute groups at dev->groups.
> > Make use of this groups to let core create the groups and simplify
> > code to avoid explicit groups creation and removal.
> >
> > 4. Wait for any ongoing mdev create() and remove() to finish before
> > unregistering parent device using srcu. This continues to allow
> > multiple create and remove to progress in parallel. At the same time
> > guard parent removal while parent is being access by create() and remov=
e
> callbacks.
>=20
> So there should be 4-5 separate patches here?  Wishful thinking?
>=20
create, remove racing with unregister is handled using srcu.
Change-3 cannot be done without fixing the sequence so it should be in patc=
h that fixes it.
Change described changes 1-2-3 are just one change. It is just the patch de=
scription to bring clarity.
Change-4 can be possibly done as split to different patch.

> > Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > ---
> >  drivers/vfio/mdev/mdev_core.c    | 142 +++++++++++++++++++++----------=
----
> ----
> >  drivers/vfio/mdev/mdev_private.h |   7 +-
> >  drivers/vfio/mdev/mdev_sysfs.c   |   6 +-
> >  3 files changed, 84 insertions(+), 71 deletions(-)
> >
> > diff --git a/drivers/vfio/mdev/mdev_core.c
> > b/drivers/vfio/mdev/mdev_core.c index 944a058..8fe0ed1 100644
> > --- a/drivers/vfio/mdev/mdev_core.c
> > +++ b/drivers/vfio/mdev/mdev_core.c
> > @@ -84,6 +84,7 @@ static void mdev_release_parent(struct kref *kref)
> >  						  ref);
> >  	struct device *dev =3D parent->dev;
> >
> > +	cleanup_srcu_struct(&parent->unreg_srcu);
> >  	kfree(parent);
> >  	put_device(dev);
> >  }
> > @@ -103,56 +104,30 @@ static inline void mdev_put_parent(struct
> mdev_parent *parent)
> >  		kref_put(&parent->ref, mdev_release_parent);  }
> >
> > -static int mdev_device_create_ops(struct kobject *kobj,
> > -				  struct mdev_device *mdev)
> > +static int mdev_device_must_remove(struct mdev_device *mdev)
>=20
> Naming is off here, mdev_device_remove_common()?
>=20
Yes, sounds better.

> >  {
> > -	struct mdev_parent *parent =3D mdev->parent;
> > +	struct mdev_parent *parent;
> > +	struct mdev_type *type;
> >  	int ret;
> >
> > -	ret =3D parent->ops->create(kobj, mdev);
> > -	if (ret)
> > -		return ret;
> > +	type =3D to_mdev_type(mdev->type_kobj);
> >
> > -	ret =3D sysfs_create_groups(&mdev->dev.kobj,
> > -				  parent->ops->mdev_attr_groups);
> > +	mdev_remove_sysfs_files(&mdev->dev, type);
> > +	device_del(&mdev->dev);
> > +	parent =3D mdev->parent;
> > +	ret =3D parent->ops->remove(mdev);
> >  	if (ret)
> > -		parent->ops->remove(mdev);
> > +		dev_err(&mdev->dev, "Remove failed: err=3D%d\n", ret);
>=20
> Let the caller decide whether to be verbose with the error, parent remova=
l
> might want to warn, sysfs remove might just return an error.
>=20
I didn't follow. Caller meaning mdev_device_remove_common() or vendor drive=
r?

> >
> > +	/* Balances with device_initialize() */
> > +	put_device(&mdev->dev);
> >  	return ret;
> >  }
> >
> > -/*
> > - * mdev_device_remove_ops gets called from sysfs's 'remove' and when
> > parent
> > - * device is being unregistered from mdev device framework.
> > - * - 'force_remove' is set to 'false' when called from sysfs's 'remove=
' which
> > - *   indicates that if the mdev device is active, used by VMM or users=
pace
> > - *   application, vendor driver could return error then don't remove t=
he
> device.
> > - * - 'force_remove' is set to 'true' when called from
> mdev_unregister_device()
> > - *   which indicate that parent device is being removed from mdev devi=
ce
> > - *   framework so remove mdev device forcefully.
> > - */
> > -static int mdev_device_remove_ops(struct mdev_device *mdev, bool
> > force_remove) -{
> > -	struct mdev_parent *parent =3D mdev->parent;
> > -	int ret;
> > -
> > -	/*
> > -	 * Vendor driver can return error if VMM or userspace application is
> > -	 * using this mdev device.
> > -	 */
> > -	ret =3D parent->ops->remove(mdev);
> > -	if (ret && !force_remove)
> > -		return ret;
> > -
> > -	sysfs_remove_groups(&mdev->dev.kobj, parent->ops-
> >mdev_attr_groups);
> > -	return 0;
> > -}
>=20
> Seems like there's easily a separate patch in pushing the create/remove o=
ps
> into the calling function and separating for the iterator callback, that =
would
> make this easier to review.
>=20
> > -
> >  static int mdev_device_remove_cb(struct device *dev, void *data)  {
> >  	if (dev_is_mdev(dev))
> > -		mdev_device_remove(dev, true);
> > -
> > +		mdev_device_must_remove(to_mdev_device(dev));
> >  	return 0;
> >  }
> >
> > @@ -194,6 +169,7 @@ int mdev_register_device(struct device *dev, const
> struct mdev_parent_ops *ops)
> >  	}
> >
> >  	kref_init(&parent->ref);
> > +	init_srcu_struct(&parent->unreg_srcu);
> >
> >  	parent->dev =3D dev;
> >  	parent->ops =3D ops;
> > @@ -214,6 +190,7 @@ int mdev_register_device(struct device *dev, const
> struct mdev_parent_ops *ops)
> >  	if (ret)
> >  		dev_warn(dev, "Failed to create compatibility class link\n");
> >
> > +	rcu_assign_pointer(parent->self, parent);
> >  	list_add(&parent->next, &parent_list);
> >  	mutex_unlock(&parent_list_lock);
> >
> > @@ -244,21 +221,36 @@ void mdev_unregister_device(struct device *dev)
> >
> >  	mutex_lock(&parent_list_lock);
> >  	parent =3D __find_parent_device(dev);
> > -
> >  	if (!parent) {
> >  		mutex_unlock(&parent_list_lock);
> >  		return;
> >  	}
> > +	list_del(&parent->next);
> > +	mutex_unlock(&parent_list_lock);
> > +
> >  	dev_info(dev, "MDEV: Unregistering\n");
> >
> > -	list_del(&parent->next);
> > +	/* Publish that this mdev parent is unregistering. So any new
> > +	 * create/remove cannot start on this parent anymore by user.
> > +	 */
>=20
> Comment style, we're not in netdev.
Yep. Will fix it.
>=20
> > +	rcu_assign_pointer(parent->self, NULL);
> > +
> > +	/*
> > +	 * Wait for any active create() or remove() mdev ops on the parent
> > +	 * to complete.
> > +	 */
> > +	synchronize_srcu(&parent->unreg_srcu);
> > +
> > +	/* At this point it is confirmed that any pending user initiated
> > +	 * create or remove callbacks accessing the parent are completed.
> > +	 * It is safe to remove the parent now.
> > +	 */
> >  	class_compat_remove_link(mdev_bus_compat_class, dev, NULL);
> >
> >  	device_for_each_child(dev, NULL, mdev_device_remove_cb);
> >
> >  	parent_remove_sysfs_files(parent);
> >
> > -	mutex_unlock(&parent_list_lock);
> >  	mdev_put_parent(parent);
> >  }
> >  EXPORT_SYMBOL(mdev_unregister_device);
> > @@ -278,14 +270,24 @@ static void mdev_device_release(struct device
> > *dev)  int mdev_device_create(struct kobject *kobj, struct device
> > *dev, uuid_le uuid)  {
> >  	int ret;
> > +	struct mdev_parent *valid_parent;
> >  	struct mdev_device *mdev, *tmp;
> >  	struct mdev_parent *parent;
> >  	struct mdev_type *type =3D to_mdev_type(kobj);
> > +	int srcu_idx;
> >
> >  	parent =3D mdev_get_parent(type->parent);
> >  	if (!parent)
> >  		return -EINVAL;
> >
> > +	srcu_idx =3D srcu_read_lock(&parent->unreg_srcu);
> > +	valid_parent =3D srcu_dereference(parent->self, &parent->unreg_srcu);
> > +	if (!valid_parent) {
> > +		/* parent is undergoing unregistration */
> > +		ret =3D -ENODEV;
> > +		goto mdev_fail;
> > +	}
> > +
> >  	mutex_lock(&mdev_list_lock);
> >
> >  	/* Check for duplicate */
> > @@ -310,68 +312,76 @@ int mdev_device_create(struct kobject *kobj,
> > struct device *dev, uuid_le uuid)
> >
> >  	mdev->parent =3D parent;
> >
> > +	device_initialize(&mdev->dev);
> >  	mdev->dev.parent  =3D dev;
> >  	mdev->dev.bus     =3D &mdev_bus_type;
> >  	mdev->dev.release =3D mdev_device_release;
> > +	mdev->dev.groups =3D type->parent->ops->mdev_attr_groups;
> >  	dev_set_name(&mdev->dev, "%pUl", uuid.b);
> >
> > -	ret =3D device_register(&mdev->dev);
> > +	ret =3D type->parent->ops->create(kobj, mdev);
> >  	if (ret)
> > -		goto mdev_fail;
> > +		goto create_fail;
> >
> > -	ret =3D mdev_device_create_ops(kobj, mdev);
> > +	ret =3D device_add(&mdev->dev);
>=20
> Separating device_initialize() and device_add() also looks like a separat=
e
> patch, then the srcu could be added at the end.  Thanks,
>=20
> Alex

I saw little more core generated that way, but I think its fine.
Basically, create/remove callback sequencing that does the device_inititail=
ze/add etc in one patch and=20
User side race handling using srcu in another patch.
Sounds good?
