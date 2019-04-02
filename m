Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2607AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95F22082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="UDzASZdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDBUAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:00:45 -0400
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:29305
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbfDBUAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWz0Pgh1A2QJa/2WvZKznA/mtqPkO98pyg1w/vjIQP0=;
 b=UDzASZdHfO7ny6Frb2yUAZHYT1VXgqw/5pjuqBZ7phVJ6ZKHMs67Q/hMIMRfUMHJ1UR+/apwZpgNXml3ZFv5xiaBkKKb5aevbeWKItM4DjwQ5uZFHTPpVf6Hb30VwBe/yyEVv5+fUD/nQoAJ2+HuL2ayHel95Gihhlm/1lUr5Us=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2557.eurprd05.prod.outlook.com (10.168.136.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Tue, 2 Apr 2019 19:59:58 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1750.017; Tue, 2 Apr 2019
 19:59:58 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Cornelia Huck <cohuck@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "cjia@nvidia.com" <cjia@nvidia.com>
Subject: RE: [PATCHv1 6/7] vfio/mdev: Fix aborting mdev child device removal
 if one fails
Thread-Topic: [PATCHv1 6/7] vfio/mdev: Fix aborting mdev child device removal
 if one fails
Thread-Index: AQHU5E+dJf9QAJFIHk20LqMQj/k/6qYnmwgAgAG5A9A=
Date:   Tue, 2 Apr 2019 19:59:58 +0000
Message-ID: <VI1PR0501MB2271173823AB3881973A69DDD1560@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1553658345-43995-1-git-send-email-parav@mellanox.com>
        <1553658345-43995-7-git-send-email-parav@mellanox.com>
 <20190401193916.3d2c6552.cohuck@redhat.com>
In-Reply-To: <20190401193916.3d2c6552.cohuck@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e08fc1e-a7bd-4ab0-418d-08d6b7a5c898
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0501MB2557;
x-ms-traffictypediagnostic: VI1PR0501MB2557:
x-microsoft-antispam-prvs: <VI1PR0501MB25574BDDCA6C24C346F73DC2D1560@VI1PR0501MB2557.eurprd05.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(136003)(396003)(346002)(199004)(13464003)(189003)(2906002)(102836004)(66066001)(4326008)(305945005)(3846002)(6116002)(74316002)(14454004)(6916009)(8676002)(86362001)(6436002)(97736004)(25786009)(53936002)(54906003)(316002)(81166006)(52536014)(7736002)(81156014)(229853002)(71200400001)(71190400001)(5660300002)(99286004)(76176011)(7696005)(486006)(55016002)(9686003)(256004)(106356001)(446003)(476003)(14444005)(68736007)(33656002)(186003)(6246003)(8936002)(105586002)(478600001)(53546011)(26005)(6506007)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2557;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 04Pv2nxAR/CGhrdeAjK9ji2hrUpigYYj0iGU3YRfdKp4ywfW9yDClyTos0j0H2MG/7P0b5c1jUAR/2u7wFJMXrVKu19asOaMdXZInrkogAn7UJPEPRrtln9pcEjezGaF34DB65gbqyIjBBrXW1F7zUkazjjErCBjK4ZBNcF+qap0cAdCskThe3vtpwGARwS2hVY7xJBeWvSJN+WybZDMSt34JLuL+IWChygU6jYDw6yBcLVfLlQF4dRkVNRqa0O7PU0CA/HT3kebVXPiUW4tZORz8ICs6cR2n4/4cBWMWVM+ABY40Ra4zxiCBtzuwikjymGePDMhktgJW+ivsMAqNPC3ZK3MILy/oj2YCJD8iIz1akTeIaC1yRNFAgg5fYF3o44DSd23VSVSyQuqU1WKZ4XaLTyLCY26NJIShYxttUc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e08fc1e-a7bd-4ab0-418d-08d6b7a5c898
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 19:59:58.1361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Monday, April 1, 2019 12:39 PM
> To: Parav Pandit <parav@mellanox.com>
> Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> kwankhede@nvidia.com; alex.williamson@redhat.com; cjia@nvidia.com
> Subject: Re: [PATCHv1 6/7] vfio/mdev: Fix aborting mdev child device
> removal if one fails
>=20
> On Tue, 26 Mar 2019 22:45:44 -0500
> Parav Pandit <parav@mellanox.com> wrote:
>=20
> > device_for_each_child() stops executing callback function for
> > remaining child devices, if callback hits an error.
> > Each child mdev device is independent of each other.
> > While unregistering parent device, mdev core must remove all child
> > mdev devices.
> > Therefore, mdev_device_remove_cb() always returns success so that
>=20
> s/always returns/must always return/ ?
>=20
Must always return.
:-)

> > device_for_each_child doesn't abort if one child removal hits error.
> >
> > While at it, improve remove and unregister functions for below simplici=
ty.
> >
> > There isn't need to pass forced flag pointer during mdev parent
> > removal which invokes mdev_device_remove(). So simplify the flow.
> >
> > mdev_device_remove() is called from two paths.
> > 1. mdev_unregister_driver()
> >      mdev_device_remove_cb()
> >        mdev_device_remove()
> > 2. remove_store()
> >      mdev_device_remove()
> >
> > When device is removed by user using remote_store(), device under
> > removal is mdev device.
> > When device is removed during parent device removal using generic
> > child iterator, mdev check is already done using dev_is_mdev().
>=20
> Isn't there still a possible race condition (which you seem to address wi=
th
> the following patch)? IOW, you cannot remove that loop-under-mutex yet?

The loop checks if the remove() is called on the mdev or not.
This is already checked from both the paths from remove is invoked.
I didn't remove the 'active' check. So it should be fine.

> >
> > Hence, remove the unnecessary loop in mdev_device_remove().
> >
> > Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > ---
> >  drivers/vfio/mdev/mdev_core.c | 23 +++++------------------
> >  1 file changed, 5 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/vfio/mdev/mdev_core.c
> > b/drivers/vfio/mdev/mdev_core.c index 836d319..aefcf34 100644
> > --- a/drivers/vfio/mdev/mdev_core.c
> > +++ b/drivers/vfio/mdev/mdev_core.c
> > @@ -149,10 +149,10 @@ static int mdev_device_remove_ops(struct
> > mdev_device *mdev, bool force_remove)
> >
>=20
> Maybe add
>=20
> /* only called during parent device unregistration */
>=20
> to avoid headscratching in the future?
>=20
> >  static int mdev_device_remove_cb(struct device *dev, void *data)  {
> > -	if (!dev_is_mdev(dev))
> > -		return 0;
> > +	if (dev_is_mdev(dev))
> > +		mdev_device_remove(dev, true);
> >
> > -	return mdev_device_remove(dev, data ? *(bool *)data : true);
> > +	return 0;
> >  }
> >
> >  /*
> > @@ -240,7 +240,6 @@ int mdev_register_device(struct device *dev, const
> > struct mdev_parent_ops *ops)  void mdev_unregister_device(struct
> > device *dev)  {
> >  	struct mdev_parent *parent;
> > -	bool force_remove =3D true;
> >
> >  	mutex_lock(&parent_list_lock);
> >  	parent =3D __find_parent_device(dev);
> > @@ -254,8 +253,7 @@ void mdev_unregister_device(struct device *dev)
> >  	list_del(&parent->next);
> >  	class_compat_remove_link(mdev_bus_compat_class, dev, NULL);
> >
> > -	device_for_each_child(dev, (void *)&force_remove,
> > -			      mdev_device_remove_cb);
> > +	device_for_each_child(dev, NULL, mdev_device_remove_cb);
> >
> >  	parent_remove_sysfs_files(parent);
> >
>=20
> Up to this chunk, the patch looks good to me.
>=20
> > @@ -348,24 +346,13 @@ int mdev_device_create(struct kobject *kobj,
> >
> >  int mdev_device_remove(struct device *dev, bool force_remove)  {
> > -	struct mdev_device *mdev, *tmp;
> > +	struct mdev_device *mdev;
> >  	struct mdev_parent *parent;
> >  	struct mdev_type *type;
> >  	int ret;
> >
> >  	mdev =3D to_mdev_device(dev);
> > -
> >  	mutex_lock(&mdev_list_lock);
> > -	list_for_each_entry(tmp, &mdev_list, next) {
> > -		if (tmp =3D=3D mdev)
> > -			break;
> > -	}
> > -
> > -	if (tmp !=3D mdev) {
> > -		mutex_unlock(&mdev_list_lock);
> > -		return -ENODEV;
> > -	}
> > -
> >  	if (!mdev->active) {
> >  		mutex_unlock(&mdev_list_lock);
> >  		return -EAGAIN;

