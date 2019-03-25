Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191E0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99892075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Lz84ZSGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfCYWJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:09:22 -0400
Received: from mail-eopbgr40061.outbound.protection.outlook.com ([40.107.4.61]:23256
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729297AbfCYWJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLZCe2sjKYbAw8jI1zsOvtiypyRbzZpSX/aYxPaVicI=;
 b=Lz84ZSGwQDaNcwKJfDXuOCopFKHWwhVEMMcA+qV0AymCl9xPgru9WFcZ9WJ4ovq9Vgr1UUQ1LCvCUhm8rpKcPqc2ifTrdwzPmbHtOp9i66KYc1J36s/DOrCxo2TSMH9I/1M1vdcXwpBqFWZ/NZ+l/Tky3e7By+FJg+t1o3Y6xtc=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2814.eurprd05.prod.outlook.com (10.172.11.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 22:07:36 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 22:07:36 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Kirti Wankhede <kwankhede@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 7/8] vfio/mdev: Fix aborting mdev child device removal if
 one fails
Thread-Topic: [PATCH 7/8] vfio/mdev: Fix aborting mdev child device removal if
 one fails
Thread-Index: AQHU4QXu/KXQZzutKU+Hm3fBOhyR36YcwcgAgAAUroCAAAyTwIAABOwAgAAA/6A=
Date:   Mon, 25 Mar 2019 22:07:36 +0000
Message-ID: <VI1PR0501MB2271C425B1BFAC64D8B3422FD15E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
        <1553296835-37522-8-git-send-email-parav@mellanox.com>
        <d3a9ba59-59dd-7924-72e0-09652dce8914@nvidia.com>
        <20190325144935.0696668a@x1.home>
        <VI1PR0501MB2271F32EF956C838A19D460CD15E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190325155212.12cf7355@x1.home>
In-Reply-To: <20190325155212.12cf7355@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 124837ac-0cba-4566-eae2-08d6b16e49ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2814;
x-ms-traffictypediagnostic: VI1PR0501MB2814:
x-microsoft-antispam-prvs: <VI1PR0501MB281486780F44C2C7563F344ED15E0@VI1PR0501MB2814.eurprd05.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(396003)(136003)(346002)(13464003)(199004)(189003)(76176011)(53546011)(186003)(6116002)(6506007)(3846002)(6246003)(25786009)(26005)(14444005)(55016002)(99286004)(256004)(66066001)(7696005)(5660300002)(102836004)(33656002)(486006)(476003)(11346002)(106356001)(14454004)(105586002)(81166006)(81156014)(478600001)(8676002)(6916009)(446003)(2906002)(74316002)(86362001)(53936002)(9686003)(68736007)(97736004)(4326008)(229853002)(7736002)(6436002)(93886005)(305945005)(316002)(54906003)(52536014)(8936002)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2814;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VpAWxl5VkzlMAg7vZ1LmjxPghMMvbNogIQ18G5uAoYVuGWtFie1nxGIDeaaJPFcI3rXH2d+o/9Jr072sB/zmYlmD6BUcHBpT8eyolL9JlZydfOPDfs2McIHSRCIWGe2YZW+N4doUDSzN4+Z7a7MTzub4X/3MQXyEQ93MUQL0Yf+gQkoNMql9CWQAV0FzCqIwNbLcOxvfiX5DwJAnufgloRwCc4aE0+/lSZOSvTnUZZ1YEkfPVTR/XAmr4Ljc3udy5VM+dKmA3fF30zege185/i0qwTWZqYvYe4SNYEDU2N7/kQuD2Ffu7WMHxnVD0IYHqFrTJlKtZnH4YT/B60kVQyoeJyx2tm0QinRZkHEOy4si9ZbG6pvviRhki44/kw3sJLUiNCXgIQhoIPcIRcrveDVulR3LhHBbbiZkNO0iLtU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124837ac-0cba-4566-eae2-08d6b16e49ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 22:07:36.2644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2814
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Monday, March 25, 2019 4:52 PM
> To: Parav Pandit <parav@mellanox.com>
> Cc: Kirti Wankhede <kwankhede@nvidia.com>; kvm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 7/8] vfio/mdev: Fix aborting mdev child device remova=
l if
> one fails
>=20
> On Mon, 25 Mar 2019 21:36:42 +0000
> Parav Pandit <parav@mellanox.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Monday, March 25, 2019 3:50 PM
> > > To: Kirti Wankhede <kwankhede@nvidia.com>
> > > Cc: Parav Pandit <parav@mellanox.com>; kvm@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH 7/8] vfio/mdev: Fix aborting mdev child device
> > > removal if one fails
> > >
> > > On Tue, 26 Mar 2019 01:05:34 +0530
> > > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > >
> > > > On 3/23/2019 4:50 AM, Parav Pandit wrote:
> > > > > device_for_each_child() stops executing callback function for
> > > > > remaining child devices, if callback hits an error.
> > > > > Each child mdev device is independent of each other.
> > > > > While unregistering parent device, mdev core must remove all
> > > > > child mdev devices.
> > > > > Therefore, mdev_device_remove_cb() always returns success so
> > > > > that device_for_each_child doesn't abort if one child removal hit=
s
> error.
> > > > >
> > > >
> > > > When unregistering parent device, force_remove is set to true amd
> > > > mdev_device_remove_ops() always returns success.
> > >
> > > Can we know that?  mdev_device_remove() doesn't guarantee to return
> > > zero.
> > >
> > > > > While at it, improve remove and unregister functions for below
> > > simplicity.
> > > > >
> > > > > There isn't need to pass forced flag pointer during mdev parent
> > > > > removal which invokes mdev_device_remove().
> > > >
> > > > There is a need to pass the flag, pasting here the comment above
> > > > mdev_device_remove_ops() which explains why the flag is needed:
> > > >
> > > > /*
> > > >  * mdev_device_remove_ops gets called from sysfs's 'remove' and
> > > > when parent
> > > >  * device is being unregistered from mdev device framework.
> > > >  * - 'force_remove' is set to 'false' when called from sysfs's 'rem=
ove'
> > > > which
> > > >  *   indicates that if the mdev device is active, used by VMM or
> userspace
> > > >  *   application, vendor driver could return error then don't remov=
e the
> > > > device.
> > > >  * - 'force_remove' is set to 'true' when called from
> > > > mdev_unregister_device()
> > > >  *   which indicate that parent device is being removed from mdev
> device
> > > >  *   framework so remove mdev device forcefully.
> > > >  */
> > >
> > > I don't see that this changes the force behavior, it's simply noting
> > > that in order to continue the device_for_each_child() iterator, we
> > > need to return zero, regardless of what mdev_device_remove()
> > > returns, and the parent remove path is the only caller of
> > > mdev_device_remove_cb(), so we can assume force =3D true when calling
> > > mdev_device_remove().  Aside from maybe a WARN_ON if
> > > mdev_device_remove() returns non-zero, that much looks reasonable to
> me.
> > >
> > > >  So simplify the flow.
> > > > >
> > > > > mdev_device_remove() is called from two paths.
> > > > > 1. mdev_unregister_driver()
> > > > >      mdev_device_remove_cb()
> > > > >        mdev_device_remove()
> > > > > 2. remove_store()
> > > > >      mdev_device_remove()
> > > > >
> > > > > When device is removed by user using remote_store(), device
> > > > > under removal is mdev device.
> > > > > When device is removed during parent device removal using
> > > > > generic child iterator, mdev check is already done using
> dev_is_mdev().
> > > > >
> > > > > Hence, remove the unnecessary loop in mdev_device_remove().
> > >
> > > I don't think knowing the device type is the only reason for this loo=
p
> though.
> > > Both paths you mention above can race with each other, so we need to
> > > serialize them and pick a winner.  The mdev_list_lock allows us to do
> that.
> > > Additionally...
> > >
> > > > >
> > > > > Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> > > > > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > > > > ---
> > > > >  drivers/vfio/mdev/mdev_core.c | 24 +++++-------------------
> > > > >  1 file changed, 5 insertions(+), 19 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vfio/mdev/mdev_core.c
> > > > > b/drivers/vfio/mdev/mdev_core.c index ab05464..944a058 100644
> > > > > --- a/drivers/vfio/mdev/mdev_core.c
> > > > > +++ b/drivers/vfio/mdev/mdev_core.c
> > > > > @@ -150,10 +150,10 @@ static int mdev_device_remove_ops(struct
> > > > > mdev_device *mdev, bool force_remove)
> > > > >
> > > > >  static int mdev_device_remove_cb(struct device *dev, void *data)=
  {
> > > > > -	if (!dev_is_mdev(dev))
> > > > > -		return 0;
> > > > > +	if (dev_is_mdev(dev))
> > > > > +		mdev_device_remove(dev, true);
> > > > >
> > > > > -	return mdev_device_remove(dev, data ? *(bool *)data :
> true);
> > > > > +	return 0;
> > > > >  }
> > > > >
> > > > >  /*
> > > > > @@ -241,7 +241,6 @@ int mdev_register_device(struct device *dev,
> > > > > const struct mdev_parent_ops *ops)  void
> > > > > mdev_unregister_device(struct device *dev)  {
> > > > >  	struct mdev_parent *parent;
> > > > > -	bool force_remove =3D true;
> > > > >
> > > > >  	mutex_lock(&parent_list_lock);
> > > > >  	parent =3D __find_parent_device(dev); @@ -255,8 +254,7 @@
> void
> > > > > mdev_unregister_device(struct device *dev)
> > > > >  	list_del(&parent->next);
> > > > >  	class_compat_remove_link(mdev_bus_compat_class, dev,
> NULL);
> > > > >
> > > > > -	device_for_each_child(dev, (void *)&force_remove,
> > > > > -			      mdev_device_remove_cb);
> > > > > +	device_for_each_child(dev, NULL, mdev_device_remove_cb);
> > > > >
> > > > >  	parent_remove_sysfs_files(parent);
> > > > >
> > > > > @@ -346,24 +344,12 @@ int mdev_device_create(struct kobject
> > > > > *kobj, struct device *dev, uuid_le uuid)
> > > > >
> > > > >  int mdev_device_remove(struct device *dev, bool force_remove)  {
> > > > > -	struct mdev_device *mdev, *tmp;
> > > > > +	struct mdev_device *mdev;
> > > > >  	struct mdev_parent *parent;
> > > > >  	struct mdev_type *type;
> > > > >  	int ret;
> > > > >
> > > > >  	mdev =3D to_mdev_device(dev);
> > > > > -
> > > > > -	mutex_lock(&mdev_list_lock);
> > >
> > > Acquiring the lock is removed, but...
> > >
> > Crap. Missed the lower part.
> >
> > > > > -	list_for_each_entry(tmp, &mdev_list, next) {
> > > > > -		if (tmp =3D=3D mdev)
> > > > > -			break;
> > > > > -	}
> > > > > -
> > > > > -	if (tmp !=3D mdev) {
> > > > > -		mutex_unlock(&mdev_list_lock);
> > > > > -		return -ENODEV;
> > > > > -	}
> > > > > -
> > > > >  	if (!mdev->active) {
> > > > >  		mutex_unlock(&mdev_list_lock);
> > > > >  		return -EAGAIN;
> > > > >
> > >
> > > We still release it in this path and the code below here.  If we
> > > don't find the device on the list under lock, then we're working
> > > with a stale device and playing with the 'active' flag of that
> > > device outside of any sort of mutual exclusion is racy.  Thanks,
> > Subsequent patch makes the order sane.
> > I think I should merge this change with patch-8 in the series.
>=20
> Please don't incorporate more fixes into patch 8, it has too many already=
.  I'd
> really prefer to see patch 8 split into issues you've identified as much =
as
> possible.  Thanks,
>=20
I tried to split into two patches.
one for user initiated race conditions, second for driver side race conditi=
ons.
But its generating more code churn as synchronization is inter-related. So =
dropped it.

This patch is just fine, only thing I messed up is accidental mutex lock re=
moval.
Below is the fixup patch for patch-7 that I want to roll in v2.
Rest all stays same in patch-7 and 8.

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 5bd8d22..e09b94f 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -349,6 +349,7 @@ int mdev_device_remove(struct device *dev, bool force_r=
emove)
        struct mdev_type *type;
        int ret;

+       mutex_lock(&mdev_list_lock);
        mdev =3D to_mdev_device(dev);
        if (!mdev->active) {
                mutex_unlock(&mdev_list_lock);


> Alex
