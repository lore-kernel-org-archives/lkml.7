Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FFBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584A12177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="K2mpAYZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfDDXFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 19:05:51 -0400
Received: from mail-eopbgr30065.outbound.protection.outlook.com ([40.107.3.65]:26854
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730539AbfDDXFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 19:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89YO4ievQl/iVsQXnJ5C4wiZ4xDt/oRiks/Uv8aAsb8=;
 b=K2mpAYZWH0wxuDQHD76VMxsSn8rjiA9FHzCkjztLmq6xvGlnIUtca3SzQLHKIdos43E8Umzxl7Ba2WjGcQ734rZWAQ4wxXkt2NL5KJeiHgslKIj+WcGSp2/ydABHnL3R8avlxRaOqFopIeWv/t/5gqUo3oxTbumCICjJ0OwA7gw=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2512.eurprd05.prod.outlook.com (10.168.136.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Thu, 4 Apr 2019 23:05:43 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::69dd:d89b:56a4:877d]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::69dd:d89b:56a4:877d%5]) with mapi id 15.20.1771.014; Thu, 4 Apr 2019
 23:05:43 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "cjia@nvidia.com" <cjia@nvidia.com>
Subject: RE: [PATCHv1 7/7] vfio/mdev: Fix race conditions with mdev device
 life cycle APIs
Thread-Topic: [PATCHv1 7/7] vfio/mdev: Fix race conditions with mdev device
 life cycle APIs
Thread-Index: AQHU5E+fUzbTxof5gUmmXNBNyohq0KYq/2wAgAAqTZCAAVwMAIAAJL4A
Date:   Thu, 4 Apr 2019 23:05:43 +0000
Message-ID: <VI1PR0501MB2271E8894B77BA8F316B6148D1500@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1553658345-43995-1-git-send-email-parav@mellanox.com>
        <1553658345-43995-8-git-send-email-parav@mellanox.com>
        <20190403152722.24efc561@x1.home>
        <VI1PR0501MB22714BE24CEA00E14A811918D1500@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190404144428.1fa6afb2@x1.home>
In-Reply-To: <20190404144428.1fa6afb2@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25f2dd71-152a-4bc6-e26e-08d6b9521092
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0501MB2512;
x-ms-traffictypediagnostic: VI1PR0501MB2512:
x-microsoft-antispam-prvs: <VI1PR0501MB25124C2BDCC209E11B425CF4D1500@VI1PR0501MB2512.eurprd05.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(39860400002)(376002)(13464003)(199004)(51914003)(189003)(5660300002)(478600001)(33656002)(476003)(305945005)(25786009)(7736002)(102836004)(14444005)(7696005)(81156014)(76176011)(105586002)(11346002)(97736004)(6506007)(486006)(6246003)(81166006)(26005)(316002)(53546011)(256004)(106356001)(53936002)(52536014)(55016002)(93886005)(6916009)(446003)(68736007)(53946003)(14454004)(9686003)(99286004)(86362001)(3846002)(30864003)(6436002)(71200400001)(6116002)(66066001)(229853002)(8936002)(186003)(74316002)(54906003)(71190400001)(4326008)(2906002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2512;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I+V5i4rAL4CfU4OzWjzBPfE1XXT0DnG2EDuIR+6lm/xN/Eo3yFfE8uX4x2Ka/op3JA2ktLVE9uNvr6jmI3vTXw6RnJWQ9wUAqLfV1Ueinxn+OCAL63eBK6QZ9kGQvlCyzQm8hXKKOkhmw3U31aw+L0m7Je1VxARgB/XFg3brN5r/icQLI7kutsjP7SYX9TesXuzexVtAC+4xYYLmmBWnck1vS/BzC7BzNYsEBgOhOXSEO95sTc8Pg2UYt/haI4TdiEeLX1O8rFDPrYf999Hgphc2GoNMy1UVZrHXN4qmjWEuubmy/vEx8+Pmkz17Rs2vJ9mJcAgKhsCeTgCc6Ow864C7ALrdRaWmh5KRe4phV0+jR6ww5d1lpdiEeWMuym2exR5TQSKJObFt5/eSkDANeavM2WhlZQZFwSBCn877fdY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f2dd71-152a-4bc6-e26e-08d6b9521092
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 23:05:43.5351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Thursday, April 4, 2019 3:44 PM
> To: Parav Pandit <parav@mellanox.com>
> Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> kwankhede@nvidia.com; cjia@nvidia.com
> Subject: Re: [PATCHv1 7/7] vfio/mdev: Fix race conditions with mdev devic=
e
> life cycle APIs
>=20
> On Thu, 4 Apr 2019 00:02:22 +0000
> Parav Pandit <parav@mellanox.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Wednesday, April 3, 2019 4:27 PM
> > > To: Parav Pandit <parav@mellanox.com>
> > > Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > kwankhede@nvidia.com; cjia@nvidia.com
> > > Subject: Re: [PATCHv1 7/7] vfio/mdev: Fix race conditions with mdev
> > > device life cycle APIs
> > >
> > > On Tue, 26 Mar 2019 22:45:45 -0500
> > > Parav Pandit <parav@mellanox.com> wrote:
> > >
> > > > Below race condition and call trace exist with current device life
> > > > cycle sequence.
> > > >
> > > > 1. In following sequence, child devices created while removing
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
> > > >
> > > > 2. Below crash is observed when user initiated remove is in
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
> > > >
> > > > mtty mtty: MDEV: Registered
> > > > iommu: Adding device 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001 to group
> > > > 57 vfio_mdev 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001: MDEV: group_id
> > > > =3D 57 mtty mtty: MDEV: Unregistering
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
> > > > Therefore, mdev core is improved to overcome above issues.
> > > >
> > > > Wait for any ongoing mdev create() and remove() to finish before
> > > > unregistering parent device using srcu. This continues to allow
> > > > multiple create and remove to progress in parallel. At the same
> > > > time guard parent removal while parent is being access by create()
> > > > and remove
> > > callbacks.
> > > >
> > > > mdev_device_remove() is refactored to not block on srcu when
> > > > device is removed as part of parent removal.
> > > >
> > > > Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> > > > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > > > ---
> > > >  drivers/vfio/mdev/mdev_core.c    | 83
> > > ++++++++++++++++++++++++++++++++++------
> > > >  drivers/vfio/mdev/mdev_private.h |  6 +++
> > > >  2 files changed, 77 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/drivers/vfio/mdev/mdev_core.c
> > > > b/drivers/vfio/mdev/mdev_core.c index aefcf34..fa233c8 100644
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
> > > > @@ -147,10 +148,30 @@ static int mdev_device_remove_ops(struct
> > > mdev_device *mdev, bool force_remove)
> > > >  	return 0;
> > > >  }
> > > >
> > > > +static int mdev_device_remove_common(struct mdev_device *mdev,
> > > > +				     bool force_remove)
> > > > +{
> > > > +	struct mdev_type *type;
> > > > +	int ret;
> > > > +
> > > > +	type =3D to_mdev_type(mdev->type_kobj);
> > >
> > > I know you're just moving this into the common function, but I think
> > > we're just caching this for aesthetics, the mdev object is still
> > > valid after the remove ops and I don't see anything touching this
> > > field.  If so, maybe we should remove 'type' or at least set it
> > > right before it's used so it doesn't appear that we're preserving it =
before
> the remove op.
> > >
> > Sure, yes.
> > Type assignment should be done just before calling
> mdev_remove_sysfs_files().
> > Will send v2.
> >
> > > > +
> > > > +	ret =3D mdev_device_remove_ops(mdev, force_remove);
> > > > +	if (ret && !force_remove) {
> > > > +		mutex_lock(&mdev_list_lock);
> > > > +		mdev->active =3D true;
> > > > +		mutex_unlock(&mdev_list_lock);
> > >
> > > The mutex around this is a change from the previous code and I'm not
> > > sure it adds anything.  If there's a thread testing for active
> > > racing with this thread setting active to true, there's no
> > > meaningful difference in the result by acquiring the mutex.
> > > 'active' may change from false->true during the critical section of
> > > the other thread, but I don't think there are any strange out of
> > > order things that give the wrong result, the other thread either sees=
 true
> or false and continues or exits, regardless of this mutex.
> > >
> > Yes, I can drop the mutex.
> > In future remove sequence fix, this will anyway vanish.
> >
> > Shall we finish this series with these 7 patches?
> > Once you ack it will send v2 for these 7 patches and follow on to that =
we
> cleanup the sequencing?
>=20
> Do you intend to move the removal of the mdev sanitization loop from
> 6/7 to this patch?  I don't think we can really claim that what it's tryi=
ng to do
> is unnecessary until after we have the new code here that prevents the sy=
sfs
> remove path from running concurrent to the parent remove path.  It's not
> really related to the changes in 6/7 anyway.  In fact, rather than moving=
 that
> chunk here, it could be added as a follow-on patch with explanation of wh=
y
> it is now unnecessary.  Thanks,
>=20
Device type cannot change from mdev to something else when it was invoked b=
y the remove() sysfs cb.
Neither it can be something else in parent removal is passes bus comparison=
 check.

If vendor's remove fails, in current code we are not calling device_unregis=
ter(). So bus cannot become null.

I fail to understand how device type can change,=20
and let say if the sanitization loop exist, what prevents it to not change =
after that check is passed.

Do you know how can device type can change?

I was thinking to patch 6 as is and address comments of 7.


> Alex
>=20
> > > > +		return ret;
> > > > +	}
> > > > +	mdev_remove_sysfs_files(&mdev->dev, type);
> > > > +	device_unregister(&mdev->dev);
> > > > +	return ret;
> > > > +}
> > > > +
> > > >  static int mdev_device_remove_cb(struct device *dev, void *data)  =
{
> > > >  	if (dev_is_mdev(dev))
> > > > -		mdev_device_remove(dev, true);
> > > > +		mdev_device_remove_common(to_mdev_device(dev), true);
> > > >
> > > >  	return 0;
> > > >  }
> > > > @@ -193,6 +214,7 @@ int mdev_register_device(struct device *dev,
> > > > const
> > > struct mdev_parent_ops *ops)
> > > >  	}
> > > >
> > > >  	kref_init(&parent->ref);
> > > > +	init_srcu_struct(&parent->unreg_srcu);
> > > >
> > > >  	parent->dev =3D dev;
> > > >  	parent->ops =3D ops;
> > > > @@ -213,6 +235,7 @@ int mdev_register_device(struct device *dev,
> > > > const
> > > struct mdev_parent_ops *ops)
> > > >  	if (ret)
> > > >  		dev_warn(dev, "Failed to create compatibility class link\n");
> > > >
> > > > +	rcu_assign_pointer(parent->self, parent);
> > > >  	list_add(&parent->next, &parent_list);
> > > >  	mutex_unlock(&parent_list_lock);
> > > >
> > > > @@ -251,13 +274,31 @@ void mdev_unregister_device(struct device
> *dev)
> > > >  	dev_info(dev, "MDEV: Unregistering\n");
> > > >
> > > >  	list_del(&parent->next);
> > > > +	mutex_unlock(&parent_list_lock);
> > > > +
> > > > +	/*
> > > > +	 * Publish that this mdev parent is unregistering. So any new
> > > > +	 * create/remove cannot start on this parent anymore by user.
> > > > +	 */
> > > > +	rcu_assign_pointer(parent->self, NULL);
> > > > +
> > > > +	/*
> > > > +	 * Wait for any active create() or remove() mdev ops on the paren=
t
> > > > +	 * to complete.
> > > > +	 */
> > > > +	synchronize_srcu(&parent->unreg_srcu);
> > > > +
> > > > +	/*
> > > > +	 * At this point it is confirmed that any pending user initiated
> > > > +	 * create or remove callbacks accessing the parent are completed.
> > > > +	 * It is safe to remove the parent now.
> > > > +	 */
> > >
> > > Thanks for the good documentation here.
> > >
> > > Alex
> > >
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
> > > > @@ -278,14 +319,24 @@ int mdev_device_create(struct kobject *kobj,
> > > >  		       struct device *dev, const guid_t *uuid)  {
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
> > > > @@ -334,44 +385,52 @@ int mdev_device_create(struct kobject *kobj,
> > > >  	mdev->type_kobj =3D kobj;
> > > >  	mdev->active =3D true;
> > > >  	dev_dbg(&mdev->dev, "MDEV: created\n");
> > > > +	srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
> > > >
> > > >  	return 0;
> > > >
> > > >  create_fail:
> > > >  	device_unregister(&mdev->dev);
> > > >  mdev_fail:
> > > > +	srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
> > > >  	mdev_put_parent(parent);
> > > >  	return ret;
> > > >  }
> > > >
> > > >  int mdev_device_remove(struct device *dev, bool force_remove)  {
> > > > +	struct mdev_parent *valid_parent;
> > > >  	struct mdev_device *mdev;
> > > >  	struct mdev_parent *parent;
> > > > -	struct mdev_type *type;
> > > > +	int srcu_idx;
> > > >  	int ret;
> > > >
> > > >  	mdev =3D to_mdev_device(dev);
> > > > +	parent =3D mdev->parent;
> > > > +
> > > > +	srcu_idx =3D srcu_read_lock(&parent->unreg_srcu);
> > > > +	valid_parent =3D srcu_dereference(parent->self, &parent->unreg_sr=
cu);
> > > > +	if (!valid_parent) {
> > > > +		srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
> > > > +		/* parent is undergoing unregistration */
> > > > +		return -ENODEV;
> > > > +	}
> > > > +
> > > >  	mutex_lock(&mdev_list_lock);
> > > >  	if (!mdev->active) {
> > > >  		mutex_unlock(&mdev_list_lock);
> > > > +		srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
> > > >  		return -EAGAIN;
> > > >  	}
> > > >
> > > >  	mdev->active =3D false;
> > > >  	mutex_unlock(&mdev_list_lock);
> > > >
> > > > -	type =3D to_mdev_type(mdev->type_kobj);
> > > > -	parent =3D mdev->parent;
> > > > -
> > > > -	ret =3D mdev_device_remove_ops(mdev, force_remove);
> > > > -	if (ret) {
> > > > -		mdev->active =3D true;
> > > > +	ret =3D mdev_device_remove_common(mdev, force_remove);
> > > > +	srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
> > > > +	if (ret)
> > > >  		return ret;
> > > > -	}
> > > >
> > > > -	mdev_remove_sysfs_files(dev, type);
> > > > -	device_unregister(dev);
> > > >  	mdev_put_parent(parent);
> > > >
> > > >  	return 0;
> > > > diff --git a/drivers/vfio/mdev/mdev_private.h
> > > > b/drivers/vfio/mdev/mdev_private.h
> > > > index ddcf9c7..b799978 100644
> > > > --- a/drivers/vfio/mdev/mdev_private.h
> > > > +++ b/drivers/vfio/mdev/mdev_private.h
> > > > @@ -23,6 +23,12 @@ struct mdev_parent {
> > > >  	struct list_head next;
> > > >  	struct kset *mdev_types_kset;
> > > >  	struct list_head type_list;
> > > > +	/*
> > > > +	 * Protects unregistration to wait until create/remove
> > > > +	 * are completed.
> > > > +	 */
> > > > +	struct srcu_struct unreg_srcu;
> > > > +	struct mdev_parent __rcu *self;
> > > >  };
> > > >
> > > >  struct mdev_device {
> >

