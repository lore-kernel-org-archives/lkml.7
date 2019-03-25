Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA53AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A27F2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="He/MlQaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfCYVcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:32:01 -0400
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:33747
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730392AbfCYVcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GH0w7mCvRkq6fIjKobNL06A2ORlf8si9CY/OvguCXzY=;
 b=He/MlQaTEK9jh9q6ZVt87xpOhIsDGNukkdLcEHnA80Iu1tAFbgZOVLZ1dit0IdTCXq0TjXOSmDamUs1wn4DsO6JvXp6HkIYvG+TIwgojJph+VA5GdttZKMTMo0lgfHHImjc8f57k4RMn/fL7RE/cQIFhbks9ZdQ+DLl0HYw3qxc=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2558.eurprd05.prod.outlook.com (10.168.136.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 21:31:56 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 21:31:56 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>
Subject: RE: [PATCH 6/8] vfio/mdev: Follow correct remove sequence
Thread-Topic: [PATCH 6/8] vfio/mdev: Follow correct remove sequence
Thread-Index: AQHU4QXsGXyTbWya80qZJiW0bEB/Q6YcznAAgAATTsA=
Date:   Mon, 25 Mar 2019 21:31:56 +0000
Message-ID: <VI1PR0501MB2271EC2E7F748DB29E7E2B4CD15E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
        <1553296835-37522-7-git-send-email-parav@mellanox.com>
 <20190325142052.423badda@x1.home>
In-Reply-To: <20190325142052.423badda@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0617ad33-769e-421b-f7e3-08d6b1694e8e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2558;
x-ms-traffictypediagnostic: VI1PR0501MB2558:
x-microsoft-antispam-prvs: <VI1PR0501MB25584278015347BA3BBC3244D15E0@VI1PR0501MB2558.eurprd05.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(376002)(136003)(39860400002)(13464003)(189003)(199004)(486006)(54906003)(4326008)(476003)(6916009)(478600001)(14454004)(86362001)(5660300002)(102836004)(2906002)(186003)(76176011)(7696005)(8936002)(53546011)(26005)(6506007)(97736004)(25786009)(33656002)(14444005)(99286004)(106356001)(105586002)(256004)(7736002)(3846002)(68736007)(316002)(6116002)(52536014)(66066001)(6246003)(305945005)(229853002)(81156014)(8676002)(74316002)(11346002)(6436002)(71190400001)(53936002)(71200400001)(446003)(81166006)(55016002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2558;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jxLBpyXwz9v7x47IXbXZnB6BPb30EZj6SAs567FxLoQ+SgA6DPQAN2cmbw9+mvRXPhmIgyDfkYjIpOUe0HlH+zsEcPTTkvDlXQAVHq954tjlRAvopFdclt0xiVBrXFFayxFxp65i+0j7c7KfltBB1fAdUg2pWTcmqBBNPNU8RLcmZcqplsWZ7iHHs90vK6pSJq451M8jfLR3GlBVaVyMJzqoNMY0Rre9xKGCCswQN6khs6YhudYgWLzyjchEdZoFo0seJz4ovvZL0ww5wzwNrKosyE9IFPHodhciTavCPZkf+M34RWz+XeYPFMOY3b1CcJQMp3NYcqqVBghhbrq4wroACOfNOwgqwXGcNaFPDPRl9I942ltrniR/7UFTJso6iVl4SIkFnQ/NPpq/adKdXqs8GAxSYhkmx9QNAQz0gsA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0617ad33-769e-421b-f7e3-08d6b1694e8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 21:31:56.5977
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
> Sent: Monday, March 25, 2019 3:21 PM
> To: Parav Pandit <parav@mellanox.com>
> Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> kwankhede@nvidia.com
> Subject: Re: [PATCH 6/8] vfio/mdev: Follow correct remove sequence
>=20
> On Fri, 22 Mar 2019 18:20:33 -0500
> Parav Pandit <parav@mellanox.com> wrote:
>=20
> > mdev_remove_sysfs_files() should follow exact mirror sequence of a
> > create, similar to what is followed in error unwinding path of
> > mdev_create_sysfs_files().
> >
> > Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > ---
> >  drivers/vfio/mdev/mdev_sysfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/mdev/mdev_sysfs.c
> > b/drivers/vfio/mdev/mdev_sysfs.c index ce5dd21..c782fa9 100644
> > --- a/drivers/vfio/mdev/mdev_sysfs.c
> > +++ b/drivers/vfio/mdev/mdev_sysfs.c
> > @@ -280,7 +280,7 @@ int  mdev_create_sysfs_files(struct device *dev,
> > struct mdev_type *type)
> >
> >  void mdev_remove_sysfs_files(struct device *dev, struct mdev_type
> > *type)  {
> > +	sysfs_remove_files(&dev->kobj, mdev_device_attrs);
> >  	sysfs_remove_link(&dev->kobj, "mdev_type");
> >  	sysfs_remove_link(type->devices_kobj, dev_name(dev));
> > -	sysfs_remove_files(&dev->kobj, mdev_device_attrs);
> >  }
>=20
> Ok, I agree this is good practice, but what qualifies a "Fixes:" tag here=
?  The
> fixes reference is incorrect in any case, 6a62c1dfb5c7 changed the creati=
on
> ordering and didn't update the remove ordering to match, but I still don'=
t
> see an actual problem with the remove ordering that necessitates the tag.
> Please clarify.  Thanks,
>=20
In netdev and rdma subsystem we always follow Fixes tag line whenever there=
 is fix, small or big.
So following good practice is better.
I will fix the tag number in v1.

> Alex
