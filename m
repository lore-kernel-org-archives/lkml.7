Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4152DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CB82147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="P4CmKJBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfDCGer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:34:47 -0400
Received: from mail-eopbgr130087.outbound.protection.outlook.com ([40.107.13.87]:13851
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfDCGer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QxGLsWccJTfjaGQE7Q5YUbCx9DywyqaKTAuWtNNQjI=;
 b=P4CmKJBWg4a3qziaAi8rrhFRFF+XeVoEdYsfcW2fdtqrnHx7wdCbc/8xx+/MjUh6Sj7LchMhC2u1DBv2YOFlg3k8ldoj8pQi30lJ8DpxJL2kyAXc5vA4ewaJN+QpBvcUD0GNqYpGvrAqcbTcs9nsKwZAA83KXDCpkvN/ZrJplMc=
Received: from AM4PR0501MB2260.eurprd05.prod.outlook.com (10.165.82.137) by
 AM4PR0501MB2804.eurprd05.prod.outlook.com (10.172.216.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Wed, 3 Apr 2019 06:34:41 +0000
Received: from AM4PR0501MB2260.eurprd05.prod.outlook.com
 ([fe80::b0d1:b636:4817:5803]) by AM4PR0501MB2260.eurprd05.prod.outlook.com
 ([fe80::b0d1:b636:4817:5803%10]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 06:34:41 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Cornelia Huck <cohuck@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "cjia@nvidia.com" <cjia@nvidia.com>
Subject: RE: [PATCHv1 6/7] vfio/mdev: Fix aborting mdev child device removal
 if one fails
Thread-Topic: [PATCHv1 6/7] vfio/mdev: Fix aborting mdev child device removal
 if one fails
Thread-Index: AQHU5E+dJf9QAJFIHk20LqMQj/k/6qYnmwgAgAG5A9CAACtugIAAhYGA
Date:   Wed, 3 Apr 2019 06:34:41 +0000
Message-ID: <AM4PR0501MB2260A8364B9C8E93C698BFC9D1570@AM4PR0501MB2260.eurprd05.prod.outlook.com>
References: <1553658345-43995-1-git-send-email-parav@mellanox.com>
        <1553658345-43995-7-git-send-email-parav@mellanox.com>
        <20190401193916.3d2c6552.cohuck@redhat.com>
        <VI1PR0501MB2271173823AB3881973A69DDD1560@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190402163309.414c45ad@x1.home>
In-Reply-To: <20190402163309.414c45ad@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [68.203.16.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc543d62-baa4-44e4-3afb-08d6b7fe73e3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM4PR0501MB2804;
x-ms-traffictypediagnostic: AM4PR0501MB2804:
x-microsoft-antispam-prvs: <AM4PR0501MB2804947B2C80EA51F7AFF84FD1570@AM4PR0501MB2804.eurprd05.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(13464003)(6246003)(25786009)(53546011)(102836004)(99286004)(53936002)(8676002)(97736004)(316002)(106356001)(6116002)(26005)(4326008)(2906002)(8936002)(7736002)(71190400001)(71200400001)(186003)(6506007)(66066001)(305945005)(105586002)(81166006)(74316002)(81156014)(76176011)(54906003)(52536014)(14454004)(9686003)(7696005)(93886005)(55016002)(14444005)(256004)(3846002)(6436002)(33656002)(5660300002)(478600001)(229853002)(11346002)(68736007)(446003)(476003)(86362001)(486006)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0501MB2804;H:AM4PR0501MB2260.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qA8CbX/xDSncpLAIRVcA659zsOyiZv3nAr5BhpphlJr3XKQr1MiR2HgRNHh/rvu7H+wt44dtJopMXegWGJWUsJtvE08wA58kfKod18nFqDVRGhsDpt5Fvh1VYm/dKSN6AiGBW2+4E4t9dqmEdos+fmWDm6YS8Hg3tHsCFZNlWf3uBsTkcXKHQ1OwvRs/ciSrjhkt2o4dTDGxcqksIorIDkY8i21hyxuLLyVeXkePnT91RAVBNb6B6ygn4OcDr94l2mWCvxtPYrjSuthrNiQkWgOnfvyecNgsBdFi+kPzjOOYz9pY12BTJW+79sL3U5odA/XSQzJ9RhJQ2UW9cO44WMNWhWe0uPbBK2KuDlsPBu3LQNWywG8ACjetI3O7apfC3+X4Vy7cBr0flANPMfsdYXeTUzyPVFqe6CVs9F0GaRk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc543d62-baa4-44e4-3afb-08d6b7fe73e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 06:34:41.2310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2804
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Tuesday, April 2, 2019 5:33 PM
> To: Parav Pandit <parav@mellanox.com>
> Cc: Cornelia Huck <cohuck@redhat.com>; kvm@vger.kernel.org; linux-
> kernel@vger.kernel.org; kwankhede@nvidia.com; cjia@nvidia.com
> Subject: Re: [PATCHv1 6/7] vfio/mdev: Fix aborting mdev child device
> removal if one fails
>=20
> On Tue, 2 Apr 2019 19:59:58 +0000
> Parav Pandit <parav@mellanox.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Cornelia Huck <cohuck@redhat.com>
> > > Sent: Monday, April 1, 2019 12:39 PM
> > > To: Parav Pandit <parav@mellanox.com>
> > > Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > kwankhede@nvidia.com; alex.williamson@redhat.com; cjia@nvidia.com
> > > Subject: Re: [PATCHv1 6/7] vfio/mdev: Fix aborting mdev child device
> > > removal if one fails
> > >
> > > On Tue, 26 Mar 2019 22:45:44 -0500
> > > Parav Pandit <parav@mellanox.com> wrote:
> > >
> > > > device_for_each_child() stops executing callback function for
> > > > remaining child devices, if callback hits an error.
> > > > Each child mdev device is independent of each other.
> > > > While unregistering parent device, mdev core must remove all child
> > > > mdev devices.
> > > > Therefore, mdev_device_remove_cb() always returns success so that
> > >
> > > s/always returns/must always return/ ?
> > >
> > Must always return.
> > :-)
> >
> > > > device_for_each_child doesn't abort if one child removal hits error=
.
> > > >
> > > > While at it, improve remove and unregister functions for below
> simplicity.
> > > >
> > > > There isn't need to pass forced flag pointer during mdev parent
> > > > removal which invokes mdev_device_remove(). So simplify the flow.
> > > >
> > > > mdev_device_remove() is called from two paths.
> > > > 1. mdev_unregister_driver()
> > > >      mdev_device_remove_cb()
> > > >        mdev_device_remove()
> > > > 2. remove_store()
> > > >      mdev_device_remove()
> > > >
> > > > When device is removed by user using remote_store(), device under
> > > > removal is mdev device.
> > > > When device is removed during parent device removal using generic
> > > > child iterator, mdev check is already done using dev_is_mdev().
> > >
> > > Isn't there still a possible race condition (which you seem to
> > > address with the following patch)? IOW, you cannot remove that loop-
> under-mutex yet?
> >
> > The loop checks if the remove() is called on the mdev or not.
> > This is already checked from both the paths from remove is invoked.
> > I didn't remove the 'active' check. So it should be fine.
>=20
> I believe the loop was actually trying to sanitize the mdev pointer, for
> example if it's not in our list of devices we should not even de-referenc=
e
> 'active'.  I think maybe this was more fallout from allowing remove to fa=
il.
> For instance, it seems like manipulating active within the list lock crit=
ical
> section should provide us with mutual exclusion, the mdev object should b=
e
> valid until the sysfs remove attribute is removed, but remove_store() its=
elf
> removes that attribute allowing mdev_remove_sysfs_files() to skip over it=
,
> but
> mdev_remove_device() can fail on the remove_store() path causing it to
> recreate the remove attribute.  Now we're in trouble because I'm not sure=
 if
> recreating the sysfs attribute ever takes a reference to the device.  If =
it does,
> it's at least racy.  Is it time to put the nail in the coffin of these re=
move
> failure paths?  It seems too fundamental to our code base that drivers
> cannot do this.  Thanks,
>

Yes, I agree.
We should follow the right remove/create sequence.
+ we need this for power management too anyway.
There is no point in re-inventing the device model differently.

If this series looks fine/merged, I can send v1 of the patch that fixes the=
 callback order.
Or you want to update this series?

I haven't had chance to go through other email thread yet.

=20
> Alex
>=20
> > > >
> > > > Hence, remove the unnecessary loop in mdev_device_remove().
> > > >
> > > > Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> > > > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > > > ---
> > > >  drivers/vfio/mdev/mdev_core.c | 23 +++++------------------
> > > >  1 file changed, 5 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/drivers/vfio/mdev/mdev_core.c
> > > > b/drivers/vfio/mdev/mdev_core.c index 836d319..aefcf34 100644
> > > > --- a/drivers/vfio/mdev/mdev_core.c
> > > > +++ b/drivers/vfio/mdev/mdev_core.c
> > > > @@ -149,10 +149,10 @@ static int mdev_device_remove_ops(struct
> > > > mdev_device *mdev, bool force_remove)
> > > >
> > >
> > > Maybe add
> > >
> > > /* only called during parent device unregistration */
> > >
> > > to avoid headscratching in the future?
> > >
> > > >  static int mdev_device_remove_cb(struct device *dev, void *data)  =
{
> > > > -	if (!dev_is_mdev(dev))
> > > > -		return 0;
> > > > +	if (dev_is_mdev(dev))
> > > > +		mdev_device_remove(dev, true);
> > > >
> > > > -	return mdev_device_remove(dev, data ? *(bool *)data : true);
> > > > +	return 0;
> > > >  }
> > > >
> > > >  /*
> > > > @@ -240,7 +240,6 @@ int mdev_register_device(struct device *dev,
> > > > const struct mdev_parent_ops *ops)  void
> > > > mdev_unregister_device(struct device *dev)  {
> > > >  	struct mdev_parent *parent;
> > > > -	bool force_remove =3D true;
> > > >
> > > >  	mutex_lock(&parent_list_lock);
> > > >  	parent =3D __find_parent_device(dev); @@ -254,8 +253,7 @@ void
> > > > mdev_unregister_device(struct device *dev)
> > > >  	list_del(&parent->next);
> > > >  	class_compat_remove_link(mdev_bus_compat_class, dev, NULL);
> > > >
> > > > -	device_for_each_child(dev, (void *)&force_remove,
> > > > -			      mdev_device_remove_cb);
> > > > +	device_for_each_child(dev, NULL, mdev_device_remove_cb);
> > > >
> > > >  	parent_remove_sysfs_files(parent);
> > > >
> > >
> > > Up to this chunk, the patch looks good to me.
> > >
> > > > @@ -348,24 +346,13 @@ int mdev_device_create(struct kobject *kobj,
> > > >
> > > >  int mdev_device_remove(struct device *dev, bool force_remove)  {
> > > > -	struct mdev_device *mdev, *tmp;
> > > > +	struct mdev_device *mdev;
> > > >  	struct mdev_parent *parent;
> > > >  	struct mdev_type *type;
> > > >  	int ret;
> > > >
> > > >  	mdev =3D to_mdev_device(dev);
> > > > -
> > > >  	mutex_lock(&mdev_list_lock);
> > > > -	list_for_each_entry(tmp, &mdev_list, next) {
> > > > -		if (tmp =3D=3D mdev)
> > > > -			break;
> > > > -	}
> > > > -
> > > > -	if (tmp !=3D mdev) {
> > > > -		mutex_unlock(&mdev_list_lock);
> > > > -		return -ENODEV;
> > > > -	}
> > > > -
> > > >  	if (!mdev->active) {
> > > >  		mutex_unlock(&mdev_list_lock);
> > > >  		return -EAGAIN;
> >

