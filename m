Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E18C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814B62070D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="dmkmFb4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfCYVgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:36:48 -0400
Received: from mail-eopbgr40085.outbound.protection.outlook.com ([40.107.4.85]:22596
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729569AbfCYVgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fe8H28SM4p9YRyTVjKHVoAyGhRF67jzl616u5xiC+hU=;
 b=dmkmFb4bJnvrKvgSG4W+4S8rqM8ZtlAse2QV5M8JT5UaMxyAQfe+Uev8AhKv6a+XG0wmonI22c+2CeWa2ki6jtdOgtJOBG4uOnG6TRtRTS174hGJjv78X2R5ql+x5EE2ccduHb3b18BYAmVo0/aGzw6bxzP7aaPlUZjijRQnMNc=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2558.eurprd05.prod.outlook.com (10.168.136.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 21:36:42 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 21:36:42 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 7/8] vfio/mdev: Fix aborting mdev child device removal if
 one fails
Thread-Topic: [PATCH 7/8] vfio/mdev: Fix aborting mdev child device removal if
 one fails
Thread-Index: AQHU4QXu/KXQZzutKU+Hm3fBOhyR36YcwcgAgAAUroCAAAyTwA==
Date:   Mon, 25 Mar 2019 21:36:42 +0000
Message-ID: <VI1PR0501MB2271F32EF956C838A19D460CD15E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
        <1553296835-37522-8-git-send-email-parav@mellanox.com>
        <d3a9ba59-59dd-7924-72e0-09652dce8914@nvidia.com>
 <20190325144935.0696668a@x1.home>
In-Reply-To: <20190325144935.0696668a@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c872543-9e2a-4b17-d56f-08d6b169f8dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2558;
x-ms-traffictypediagnostic: VI1PR0501MB2558:
x-microsoft-antispam-prvs: <VI1PR0501MB2558A2BA89BF90C438D7AFB2D15E0@VI1PR0501MB2558.eurprd05.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(376002)(136003)(39860400002)(13464003)(189003)(199004)(486006)(54906003)(4326008)(476003)(110136005)(478600001)(14454004)(86362001)(5660300002)(102836004)(2906002)(186003)(76176011)(7696005)(8936002)(53546011)(26005)(6506007)(97736004)(25786009)(33656002)(14444005)(99286004)(106356001)(105586002)(256004)(7736002)(3846002)(68736007)(316002)(6116002)(52536014)(66066001)(6246003)(305945005)(229853002)(81156014)(8676002)(74316002)(93886005)(11346002)(6436002)(71190400001)(53936002)(71200400001)(446003)(81166006)(55016002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2558;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KSDAqd3+2HEuovCcieZg77hKIRaHcfKljcoj8vJHag0RW9icBnXeD1XLs2rLJlETO2Eflh22sT61P/aStiM3lvPPW7mHMUsxq4kMc4I83kEvUuWF6144aYoGcmZQsW3eN/pzLlxb7gL9UKyYYk8IdTYs0Ywd0CDCSvudmWRc8ab6X5yD8FMMjnlSC7mnNmoeU6+fQH1GiUbn4EOI+aWkvZqcbtJ8qiRnuQUsP8JPSsY3l+ipku8EXKtBrNxI7iV3lGybArE5hpubUYD0w0UzxbIjxurFuxEeHUCAQEZ3er/gZpkyfm11/aBFEHFTX9Q54FFjIW2UqvzeiifrUKl3FRD+4myENkNL3FFVhI6pmmLPuwJvJ4A5BBgWtVKJ6qi/mWp2du/AtX7dZ1+2UzbcCFJ/RG0/gJKur5JDnDJENp4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c872543-9e2a-4b17-d56f-08d6b169f8dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 21:36:42.1921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2558
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Monday, March 25, 2019 3:50 PM
> To: Kirti Wankhede <kwankhede@nvidia.com>
> Cc: Parav Pandit <parav@mellanox.com>; kvm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 7/8] vfio/mdev: Fix aborting mdev child device remova=
l if
> one fails
>=20
> On Tue, 26 Mar 2019 01:05:34 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>=20
> > On 3/23/2019 4:50 AM, Parav Pandit wrote:
> > > device_for_each_child() stops executing callback function for
> > > remaining child devices, if callback hits an error.
> > > Each child mdev device is independent of each other.
> > > While unregistering parent device, mdev core must remove all child
> > > mdev devices.
> > > Therefore, mdev_device_remove_cb() always returns success so that
> > > device_for_each_child doesn't abort if one child removal hits error.
> > >
> >
> > When unregistering parent device, force_remove is set to true amd
> > mdev_device_remove_ops() always returns success.
>=20
> Can we know that?  mdev_device_remove() doesn't guarantee to return
> zero.
>=20
> > > While at it, improve remove and unregister functions for below
> simplicity.
> > >
> > > There isn't need to pass forced flag pointer during mdev parent
> > > removal which invokes mdev_device_remove().
> >
> > There is a need to pass the flag, pasting here the comment above
> > mdev_device_remove_ops() which explains why the flag is needed:
> >
> > /*
> >  * mdev_device_remove_ops gets called from sysfs's 'remove' and when
> > parent
> >  * device is being unregistered from mdev device framework.
> >  * - 'force_remove' is set to 'false' when called from sysfs's 'remove'
> > which
> >  *   indicates that if the mdev device is active, used by VMM or usersp=
ace
> >  *   application, vendor driver could return error then don't remove th=
e
> > device.
> >  * - 'force_remove' is set to 'true' when called from
> > mdev_unregister_device()
> >  *   which indicate that parent device is being removed from mdev devic=
e
> >  *   framework so remove mdev device forcefully.
> >  */
>=20
> I don't see that this changes the force behavior, it's simply noting that=
 in
> order to continue the device_for_each_child() iterator, we need to return
> zero, regardless of what mdev_device_remove() returns, and the parent
> remove path is the only caller of mdev_device_remove_cb(), so we can
> assume force =3D true when calling mdev_device_remove().  Aside from mayb=
e
> a WARN_ON if mdev_device_remove() returns non-zero, that much looks
> reasonable to me.
>=20
> >  So simplify the flow.
> > >
> > > mdev_device_remove() is called from two paths.
> > > 1. mdev_unregister_driver()
> > >      mdev_device_remove_cb()
> > >        mdev_device_remove()
> > > 2. remove_store()
> > >      mdev_device_remove()
> > >
> > > When device is removed by user using remote_store(), device under
> > > removal is mdev device.
> > > When device is removed during parent device removal using generic
> > > child iterator, mdev check is already done using dev_is_mdev().
> > >
> > > Hence, remove the unnecessary loop in mdev_device_remove().
>=20
> I don't think knowing the device type is the only reason for this loop th=
ough.
> Both paths you mention above can race with each other, so we need to
> serialize them and pick a winner.  The mdev_list_lock allows us to do tha=
t.
> Additionally...
>=20
> > >
> > > Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> > > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > > ---
> > >  drivers/vfio/mdev/mdev_core.c | 24 +++++-------------------
> > >  1 file changed, 5 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/drivers/vfio/mdev/mdev_core.c
> > > b/drivers/vfio/mdev/mdev_core.c index ab05464..944a058 100644
> > > --- a/drivers/vfio/mdev/mdev_core.c
> > > +++ b/drivers/vfio/mdev/mdev_core.c
> > > @@ -150,10 +150,10 @@ static int mdev_device_remove_ops(struct
> > > mdev_device *mdev, bool force_remove)
> > >
> > >  static int mdev_device_remove_cb(struct device *dev, void *data)  {
> > > -	if (!dev_is_mdev(dev))
> > > -		return 0;
> > > +	if (dev_is_mdev(dev))
> > > +		mdev_device_remove(dev, true);
> > >
> > > -	return mdev_device_remove(dev, data ? *(bool *)data : true);
> > > +	return 0;
> > >  }
> > >
> > >  /*
> > > @@ -241,7 +241,6 @@ int mdev_register_device(struct device *dev,
> > > const struct mdev_parent_ops *ops)  void
> > > mdev_unregister_device(struct device *dev)  {
> > >  	struct mdev_parent *parent;
> > > -	bool force_remove =3D true;
> > >
> > >  	mutex_lock(&parent_list_lock);
> > >  	parent =3D __find_parent_device(dev); @@ -255,8 +254,7 @@ void
> > > mdev_unregister_device(struct device *dev)
> > >  	list_del(&parent->next);
> > >  	class_compat_remove_link(mdev_bus_compat_class, dev, NULL);
> > >
> > > -	device_for_each_child(dev, (void *)&force_remove,
> > > -			      mdev_device_remove_cb);
> > > +	device_for_each_child(dev, NULL, mdev_device_remove_cb);
> > >
> > >  	parent_remove_sysfs_files(parent);
> > >
> > > @@ -346,24 +344,12 @@ int mdev_device_create(struct kobject *kobj,
> > > struct device *dev, uuid_le uuid)
> > >
> > >  int mdev_device_remove(struct device *dev, bool force_remove)  {
> > > -	struct mdev_device *mdev, *tmp;
> > > +	struct mdev_device *mdev;
> > >  	struct mdev_parent *parent;
> > >  	struct mdev_type *type;
> > >  	int ret;
> > >
> > >  	mdev =3D to_mdev_device(dev);
> > > -
> > > -	mutex_lock(&mdev_list_lock);
>=20
> Acquiring the lock is removed, but...
>=20
Crap. Missed the lower part.

> > > -	list_for_each_entry(tmp, &mdev_list, next) {
> > > -		if (tmp =3D=3D mdev)
> > > -			break;
> > > -	}
> > > -
> > > -	if (tmp !=3D mdev) {
> > > -		mutex_unlock(&mdev_list_lock);
> > > -		return -ENODEV;
> > > -	}
> > > -
> > >  	if (!mdev->active) {
> > >  		mutex_unlock(&mdev_list_lock);
> > >  		return -EAGAIN;
> > >
>=20
> We still release it in this path and the code below here.  If we don't fi=
nd the
> device on the list under lock, then we're working with a stale device and
> playing with the 'active' flag of that device outside of any sort of mutu=
al
> exclusion is racy.  Thanks,
Subsequent patch makes the order sane.
I think I should merge this change with patch-8 in the series.
