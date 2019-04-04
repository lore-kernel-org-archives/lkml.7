Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D52C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663A72133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="X9OF25XA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfDDACc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:02:32 -0400
Received: from mail-eopbgr40041.outbound.protection.outlook.com ([40.107.4.41]:24800
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbfDDACc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTeQq97sQjiZhwjPEyDLP1v8soJURqztefJVVlIFYtw=;
 b=X9OF25XAWX+VV7zwzzN7Elt97Xm9U4oasTkLU7Go5itylnU2zb+twUyQO58eXtdvih48qwVosuhFvCeTEwKTQt5dJEvA4LLDAdeQ477C0TZDZHdrWZ4FiHbU+efDcZobc+k7cZI7V4wjAKRxgAamJArAqsY59rQUuwdHKtLuTa4=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2334.eurprd05.prod.outlook.com (10.169.135.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Thu, 4 Apr 2019 00:02:22 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::69dd:d89b:56a4:877d]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::69dd:d89b:56a4:877d%5]) with mapi id 15.20.1771.014; Thu, 4 Apr 2019
 00:02:22 +0000
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
Thread-Index: AQHU5E+fUzbTxof5gUmmXNBNyohq0KYq/2wAgAAqTZA=
Date:   Thu, 4 Apr 2019 00:02:22 +0000
Message-ID: <VI1PR0501MB22714BE24CEA00E14A811918D1500@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1553658345-43995-1-git-send-email-parav@mellanox.com>
        <1553658345-43995-8-git-send-email-parav@mellanox.com>
 <20190403152722.24efc561@x1.home>
In-Reply-To: <20190403152722.24efc561@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcd4585e-b2e8-477c-acc3-08d6b890d04d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0501MB2334;
x-ms-traffictypediagnostic: VI1PR0501MB2334:
x-microsoft-antispam-prvs: <VI1PR0501MB23347E1A005FFD8AFF70E966D1500@VI1PR0501MB2334.eurprd05.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(136003)(346002)(199004)(189003)(13464003)(51914003)(30864003)(256004)(25786009)(71200400001)(5660300002)(81166006)(71190400001)(14444005)(66066001)(81156014)(106356001)(305945005)(8676002)(229853002)(6436002)(2906002)(186003)(7736002)(6246003)(476003)(76176011)(53936002)(102836004)(6916009)(6506007)(26005)(9686003)(446003)(33656002)(8936002)(11346002)(53546011)(7696005)(55016002)(486006)(4326008)(68736007)(3846002)(6116002)(54906003)(316002)(478600001)(97736004)(86362001)(99286004)(74316002)(52536014)(14454004)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2334;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HrGvl+hPwtTPPA+ASUQCvbVbzIcE86Tx9Rrzetrz3SHrPK5Zzjp86HqyIkCdTcigf+UHFHsdnuevfN5wsyJk9ddcykQpwQrz+kFti6MOe9DGjdUaHn70aAFgP6uWLTwgca02luW4MnDaZKMU/+vpOt4eHPNrb3Y3APoqbSuC1NoqACNuIhieLQuLQeza00LeeM0b7dQUCUx8l2yO4LJCLoc3nx/ZH5p26/tF2L06bKD71gKb/dEdbVEY+/HnrpklsuyFyDY50yK7dYiHrfbzdiWYTQXTn90e4OodOAIIyyu57WHbVtItZNmwBkOdyf4jM+osKHPeTPvs1p5L/0M4rkwaiMhCkxUu+1Nd0tJAZWGM5g9g1+JF+7kbfs0SRU/04AB1Tbu/meYmVs7b/eZTZUaIgGDDmaD/trDRHkKhfiU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd4585e-b2e8-477c-acc3-08d6b890d04d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 00:02:22.7565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Wednesday, April 3, 2019 4:27 PM
> To: Parav Pandit <parav@mellanox.com>
> Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> kwankhede@nvidia.com; cjia@nvidia.com
> Subject: Re: [PATCHv1 7/7] vfio/mdev: Fix race conditions with mdev devic=
e
> life cycle APIs
>=20
> On Tue, 26 Mar 2019 22:45:45 -0500
> Parav Pandit <parav@mellanox.com> wrote:
>=20
> > Below race condition and call trace exist with current device life
> > cycle sequence.
> >
> > 1. In following sequence, child devices created while removing mdev
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
> >
> > 2. Below crash is observed when user initiated remove is in progress
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
> >
> > mtty mtty: MDEV: Registered
> > iommu: Adding device 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001 to group 57
> > vfio_mdev 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001: MDEV: group_id =3D 57
> > mtty mtty: MDEV: Unregistering
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
> > Therefore, mdev core is improved to overcome above issues.
> >
> > Wait for any ongoing mdev create() and remove() to finish before
> > unregistering parent device using srcu. This continues to allow
> > multiple create and remove to progress in parallel. At the same time
> > guard parent removal while parent is being access by create() and remov=
e
> callbacks.
> >
> > mdev_device_remove() is refactored to not block on srcu when device is
> > removed as part of parent removal.
> >
> > Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > ---
> >  drivers/vfio/mdev/mdev_core.c    | 83
> ++++++++++++++++++++++++++++++++++------
> >  drivers/vfio/mdev/mdev_private.h |  6 +++
> >  2 files changed, 77 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/vfio/mdev/mdev_core.c
> > b/drivers/vfio/mdev/mdev_core.c index aefcf34..fa233c8 100644
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
> > @@ -147,10 +148,30 @@ static int mdev_device_remove_ops(struct
> mdev_device *mdev, bool force_remove)
> >  	return 0;
> >  }
> >
> > +static int mdev_device_remove_common(struct mdev_device *mdev,
> > +				     bool force_remove)
> > +{
> > +	struct mdev_type *type;
> > +	int ret;
> > +
> > +	type =3D to_mdev_type(mdev->type_kobj);
>=20
> I know you're just moving this into the common function, but I think we'r=
e
> just caching this for aesthetics, the mdev object is still valid after th=
e remove
> ops and I don't see anything touching this field.  If so, maybe we should
> remove 'type' or at least set it right before it's used so it doesn't app=
ear that
> we're preserving it before the remove op.
>=20
Sure, yes.
Type assignment should be done just before calling mdev_remove_sysfs_files(=
).
Will send v2.

> > +
> > +	ret =3D mdev_device_remove_ops(mdev, force_remove);
> > +	if (ret && !force_remove) {
> > +		mutex_lock(&mdev_list_lock);
> > +		mdev->active =3D true;
> > +		mutex_unlock(&mdev_list_lock);
>=20
> The mutex around this is a change from the previous code and I'm not sure
> it adds anything.  If there's a thread testing for active racing with thi=
s thread
> setting active to true, there's no meaningful difference in the result by
> acquiring the mutex.  'active' may change from false->true during the cri=
tical
> section of the other thread, but I don't think there are any strange out =
of
> order things that give the wrong result, the other thread either sees tru=
e or
> false and continues or exits, regardless of this mutex.
>=20
Yes, I can drop the mutex.
In future remove sequence fix, this will anyway vanish.

Shall we finish this series with these 7 patches?
Once you ack it will send v2 for these 7 patches and follow on to that we c=
leanup the sequencing?

> > +		return ret;
> > +	}
> > +	mdev_remove_sysfs_files(&mdev->dev, type);
> > +	device_unregister(&mdev->dev);
> > +	return ret;
> > +}
> > +
> >  static int mdev_device_remove_cb(struct device *dev, void *data)  {
> >  	if (dev_is_mdev(dev))
> > -		mdev_device_remove(dev, true);
> > +		mdev_device_remove_common(to_mdev_device(dev), true);
> >
> >  	return 0;
> >  }
> > @@ -193,6 +214,7 @@ int mdev_register_device(struct device *dev, const
> struct mdev_parent_ops *ops)
> >  	}
> >
> >  	kref_init(&parent->ref);
> > +	init_srcu_struct(&parent->unreg_srcu);
> >
> >  	parent->dev =3D dev;
> >  	parent->ops =3D ops;
> > @@ -213,6 +235,7 @@ int mdev_register_device(struct device *dev, const
> struct mdev_parent_ops *ops)
> >  	if (ret)
> >  		dev_warn(dev, "Failed to create compatibility class link\n");
> >
> > +	rcu_assign_pointer(parent->self, parent);
> >  	list_add(&parent->next, &parent_list);
> >  	mutex_unlock(&parent_list_lock);
> >
> > @@ -251,13 +274,31 @@ void mdev_unregister_device(struct device *dev)
> >  	dev_info(dev, "MDEV: Unregistering\n");
> >
> >  	list_del(&parent->next);
> > +	mutex_unlock(&parent_list_lock);
> > +
> > +	/*
> > +	 * Publish that this mdev parent is unregistering. So any new
> > +	 * create/remove cannot start on this parent anymore by user.
> > +	 */
> > +	rcu_assign_pointer(parent->self, NULL);
> > +
> > +	/*
> > +	 * Wait for any active create() or remove() mdev ops on the parent
> > +	 * to complete.
> > +	 */
> > +	synchronize_srcu(&parent->unreg_srcu);
> > +
> > +	/*
> > +	 * At this point it is confirmed that any pending user initiated
> > +	 * create or remove callbacks accessing the parent are completed.
> > +	 * It is safe to remove the parent now.
> > +	 */
>=20
> Thanks for the good documentation here.
>=20
> Alex
>=20
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
> > @@ -278,14 +319,24 @@ int mdev_device_create(struct kobject *kobj,
> >  		       struct device *dev, const guid_t *uuid)  {
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
> > @@ -334,44 +385,52 @@ int mdev_device_create(struct kobject *kobj,
> >  	mdev->type_kobj =3D kobj;
> >  	mdev->active =3D true;
> >  	dev_dbg(&mdev->dev, "MDEV: created\n");
> > +	srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
> >
> >  	return 0;
> >
> >  create_fail:
> >  	device_unregister(&mdev->dev);
> >  mdev_fail:
> > +	srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
> >  	mdev_put_parent(parent);
> >  	return ret;
> >  }
> >
> >  int mdev_device_remove(struct device *dev, bool force_remove)  {
> > +	struct mdev_parent *valid_parent;
> >  	struct mdev_device *mdev;
> >  	struct mdev_parent *parent;
> > -	struct mdev_type *type;
> > +	int srcu_idx;
> >  	int ret;
> >
> >  	mdev =3D to_mdev_device(dev);
> > +	parent =3D mdev->parent;
> > +
> > +	srcu_idx =3D srcu_read_lock(&parent->unreg_srcu);
> > +	valid_parent =3D srcu_dereference(parent->self, &parent->unreg_srcu);
> > +	if (!valid_parent) {
> > +		srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
> > +		/* parent is undergoing unregistration */
> > +		return -ENODEV;
> > +	}
> > +
> >  	mutex_lock(&mdev_list_lock);
> >  	if (!mdev->active) {
> >  		mutex_unlock(&mdev_list_lock);
> > +		srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
> >  		return -EAGAIN;
> >  	}
> >
> >  	mdev->active =3D false;
> >  	mutex_unlock(&mdev_list_lock);
> >
> > -	type =3D to_mdev_type(mdev->type_kobj);
> > -	parent =3D mdev->parent;
> > -
> > -	ret =3D mdev_device_remove_ops(mdev, force_remove);
> > -	if (ret) {
> > -		mdev->active =3D true;
> > +	ret =3D mdev_device_remove_common(mdev, force_remove);
> > +	srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
> > +	if (ret)
> >  		return ret;
> > -	}
> >
> > -	mdev_remove_sysfs_files(dev, type);
> > -	device_unregister(dev);
> >  	mdev_put_parent(parent);
> >
> >  	return 0;
> > diff --git a/drivers/vfio/mdev/mdev_private.h
> > b/drivers/vfio/mdev/mdev_private.h
> > index ddcf9c7..b799978 100644
> > --- a/drivers/vfio/mdev/mdev_private.h
> > +++ b/drivers/vfio/mdev/mdev_private.h
> > @@ -23,6 +23,12 @@ struct mdev_parent {
> >  	struct list_head next;
> >  	struct kset *mdev_types_kset;
> >  	struct list_head type_list;
> > +	/*
> > +	 * Protects unregistration to wait until create/remove
> > +	 * are completed.
> > +	 */
> > +	struct srcu_struct unreg_srcu;
> > +	struct mdev_parent __rcu *self;
> >  };
> >
> >  struct mdev_device {

