Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B5BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166832087E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="b4sk7IoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732669AbfC0DTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 23:19:46 -0400
Received: from mail-eopbgr10080.outbound.protection.outlook.com ([40.107.1.80]:37605
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731701AbfC0DTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 23:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrV0K9ME+G53zFZ7Q4s2ET0bS00vi6T6CjahPrru9kA=;
 b=b4sk7IoHZ76FcOOgl8+1jdPOA6LifPLDALZB4kLfj2t0X8njti5vY6pPPUtoBxnml6npLwqvECTorSlHUwaUdiH+EA4GN0UqGndrQaR3AJHWi+n41lKrXNSod0zmeWkUNf6nuq/ZZXU8l1VHB3EkAqSRhET8qSLg4Sh2tGE+o0A=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2733.eurprd05.prod.outlook.com (10.172.11.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Wed, 27 Mar 2019 03:19:33 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 03:19:33 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Neo Jia <cjia@nvidia.com>
Subject: RE: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
Thread-Topic: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
Thread-Index: AQHU4QXvNq2tSD+YZ0aNNrE4+GOfm6YdgsoAgACL1gCAAMXboA==
Date:   Wed, 27 Mar 2019 03:19:33 +0000
Message-ID: <VI1PR0501MB2271BBAC7ADB9895B5B24A49D1580@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
        <1553296835-37522-9-git-send-email-parav@mellanox.com>
        <244348f7-4d72-b7c5-9d82-34db296ff885@nvidia.com>
 <20190326092652.2876030d@x1.home>
In-Reply-To: <20190326092652.2876030d@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [2605:6000:ec80:6500:dc01:6645:55b9:495a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a4c2c39-ea63-4458-7c84-08d6b26308b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2733;
x-ms-traffictypediagnostic: VI1PR0501MB2733:
x-microsoft-antispam-prvs: <VI1PR0501MB2733226378D8BA552CEFCC21D1580@VI1PR0501MB2733.eurprd05.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(136003)(396003)(189003)(13464003)(199004)(6506007)(478600001)(8936002)(486006)(53546011)(55016002)(446003)(2906002)(11346002)(68736007)(5660300002)(54906003)(476003)(76176011)(33656002)(6116002)(105586002)(7696005)(186003)(102836004)(106356001)(93886005)(316002)(110136005)(256004)(14454004)(7736002)(71200400001)(14444005)(71190400001)(99286004)(6436002)(52536014)(229853002)(46003)(81156014)(6246003)(8676002)(81166006)(305945005)(25786009)(9686003)(97736004)(86362001)(4326008)(53936002)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2733;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 14/BI4s4Pb3KW7qdJgEB8Qt2ZZ7d4a3APedqp5zTu00gEYg80TEc1pjvPfQbmvyEcJSXWKRXPhil3PPezmUy3PrlODtIzBrV/xqW0+hbXSfEz9dCWRkkzXtpkZkkGJNQR/kl2390gxBEFJMiBltFW62D5ldz31bV9Rjj8tSATysk/pp/RuvLFiJPjZqWPu0fifaLx20mEH771emD2sTT4sRhs5NFzSjpmJieFehlLcaSMop3o/m0BivxyENfjGs6kBiw9n8Q5wn/LwE2sby+wHhu5K6kw2kNRaOdih4v3VX2Y6hYNmBu3ZS4aOdyJMaSJLRmJ1TwHrbl+EBgctFZdVQXhbQ1qu/Z7HuhxISytEyX7+l4mW/pl0bt06UnwbE0DmN9MiEGgGWGk2GRnZwIOHKLLkRtJkg4tTBMtWCWGGg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4c2c39-ea63-4458-7c84-08d6b26308b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 03:19:33.5612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2733
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Tuesday, March 26, 2019 10:27 AM
> To: Kirti Wankhede <kwankhede@nvidia.com>
> Cc: Parav Pandit <parav@mellanox.com>; kvm@vger.kernel.org; linux-
> kernel@vger.kernel.org; Neo Jia <cjia@nvidia.com>
> Subject: Re: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
>=20
> On Tue, 26 Mar 2019 12:36:22 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>=20
> > On 3/23/2019 4:50 AM, Parav Pandit wrote:
> > > There are five problems with current code structure.
> > > 1. mdev device is placed on the mdev bus before it is created in the
> > > vendor driver. Once a device is placed on the mdev bus without
> > > creating its supporting underlying vendor device, an open() can get
> > > triggered by userspace on partially initialized device.
> > > Below ladder diagram highlight it.
> > >
> > >       cpu-0                                       cpu-1
> > >       -----                                       -----
> > >    create_store()
> > >      mdev_create_device()
> > >        device_register()
> > >           ...
> > >          vfio_mdev_probe()
> > >          ...creates char device
> > >                                         vfio_mdev_open()
> > >                                           parent->ops->open(mdev)
> > >                                             vfio_ap_mdev_open()
> > >                                               matrix_mdev =3D NULL
> > >         [...]
> > >         parent->ops->create()
> > >           vfio_ap_mdev_create()
> > >             mdev_set_drvdata(mdev, matrix_mdev);
> > >             /* Valid pointer set above */
> > >
> >
> > VFIO interface uses sysfs path of device or PCI device's BDF where it
> > checks sysfs file for that device exist.
> > In case of VFIO mdev device, above situation will never happen as open
> > will only get called if sysfs entry for that device exist.
> >
> > If you don't use VFIO interface then this situation can arise. In that
> > case probe() can be used for very basic initialization then create
> > actual char device from create().
> >
> >
> > > 2. Current creation sequence is,
> > >    parent->ops_create()
> > >    groups_register()
> > >
> > > Remove sequence is,
> > >    parent->ops->remove()
> > >    groups_unregister()
> > > However, remove sequence should be exact mirror of creation sequence.
> > > Once this is achieved, all users of the mdev will be terminated
> > > first before removing underlying vendor device.
> > > (Follow standard linux driver model).
> > > At that point vendor's remove() ops shouldn't failed because device
> > > is taken off the bus that should terminate the users.
> > >
> >
> > If VMM or user space application is using mdev device,
> > parent->ops->remove() can return failure. In that case sysfs files
> > shouldn't be removed. Hence above sequence is followed for remove.
> >
> > Standard linux driver model doesn't allow remove() to fail, but in of
> > mdev framework, interface is defined to handle such error case.
> >
> >
> > > 3. Additionally any new mdev driver that wants to work on mdev
> > > device during probe() routine registered using
> > > mdev_register_driver() needs to get stable mdev structure.
> > >
> >
> > Things that you are trying to handle with mdev structure from probe(),
> > couldn't that be moved to create()?
> >
> >
> > > 4. In following sequence, child devices created while removing mdev
> > > parent device can be left out, or it may lead to race of removing
> > > half initialized child mdev devices.
> > >
> > > issue-1:
> > > --------
> > >        cpu-0                         cpu-1
> > >        -----                         -----
> > >                                   mdev_unregister_device()
> > >                                      device_for_each_child()
> > >                                         mdev_device_remove_cb()
> > >                                             mdev_device_remove()
> > > create_store()
> > >   mdev_device_create()                   [...]
> > >        device_register()
> > >                                   parent_remove_sysfs_files()
> > >                                   /* BUG: device added by cpu-0
> > >                                    * whose parent is getting removed.
> > >                                    */
> > >
> > > issue-2:
> > > --------
> > >        cpu-0                         cpu-1
> > >        -----                         -----
> > > create_store()
> > >   mdev_device_create()                   [...]
> > >        device_register()
> > >
> > >        [...]                      mdev_unregister_device()
> > >                                      device_for_each_child()
> > >                                         mdev_device_remove_cb()
> > >                                             mdev_device_remove()
> > >
> > >        mdev_create_sysfs_files()
> > >        /* BUG: create is adding
> > >         * sysfs files for a device
> > >         * which is undergoing removal.
> > >         */
> > >                                  parent_remove_sysfs_files()
> > >
> > > 5. Below crash is observed when user initiated remove is in progress
> > > and mdev_unregister_driver() completes parent unregistration.
> > >
> > >        cpu-0                         cpu-1
> > >        -----                         -----
> > > remove_store()
> > >    mdev_device_remove()
> > >    active =3D false;
> > >                                   mdev_unregister_device()
> > >                                     remove type
> > >    [...]
> > >    mdev_remove_ops() crashes.
> > >
> > > This is similar race like create() racing with mdev_unregister_device=
().
> > >
> > > mtty mtty: MDEV: Registered
> > > iommu: Adding device 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001 to group
> > > 57 vfio_mdev 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001: MDEV: group_id =3D
> > > 57 mdev_device_remove sleep started mtty mtty: MDEV: Unregistering
> > > mtty_dev: Unloaded!
> > > BUG: unable to handle kernel paging request at ffffffffc027d668 PGD
> > > af9818067 P4D af9818067 PUD af981a067 PMD 8583c3067 PTE 0
> > > Oops: 0000 [#1] SMP PTI
> > > CPU: 15 PID: 3517 Comm: bash Kdump: loaded Not tainted
> > > 5.0.0-rc7-vdevbus+ #2 Hardware name: Supermicro
> > > SYS-6028U-TR4+/X10DRU-i+, BIOS 2.0b 08/09/2016
> > > RIP: 0010:mdev_device_remove_ops+0x1a/0x50 [mdev] Call Trace:
> > >  mdev_device_remove+0xef/0x130 [mdev]
> > >  remove_store+0x77/0xa0 [mdev]
> > >  kernfs_fop_write+0x113/0x1a0
> > >  __vfs_write+0x33/0x1b0
> > >  ? rcu_read_lock_sched_held+0x64/0x70
> > >  ? rcu_sync_lockdep_assert+0x2a/0x50  ? __sb_start_write+0x121/0x1b0
> > > ? vfs_write+0x17c/0x1b0
> > >  vfs_write+0xad/0x1b0
> > >  ? trace_hardirqs_on_thunk+0x1a/0x1c
> > >  ksys_write+0x55/0xc0
> > >  do_syscall_64+0x5a/0x210
> > >
> > > Therefore, mdev core is improved in following ways to overcome above
> > > issues.
> > >
> > > 1. Before placing mdev devices on the bus, perform vendor drivers
> > > creation which supports the mdev creation.
> > > This ensures that mdev specific all necessary fields are initialized
> > > before a given mdev can be accessed by bus driver.
> > >
> > > 2. During remove flow, first remove the device from the bus. This
> > > ensures that any bus specific devices and data is cleared.
> > > Once device is taken of the mdev bus, perform remove() of mdev from
> > > the vendor driver.
> > >
> >
> > If user space application is using the device and someone underneath
> > remove the device from bus, how would use space application know that
> > device is being removed?
> > If DMA is setup, user space application is accessing that memory and
> > device is removed from bus - how will you restrict to not to remove
> > that device? If remove() is not restricted then host might crash.
> > I know Linux kernel device core model doesn't allow remove() to fail,
> > but we had tackled that problem for mdev devices in this framework. I
> > prefer not to change this behavior. This will regress existing working
> > drivers.
>=20
>=20
> We have exactly this issue with vfio-pci, or really any vfio driver, wher=
e the
> solution is that a remove request is blocked until the device becomes
> unused by the user.  In fact there's a notification that userspace can co=
nnect
> to so that we don't need to silently wait for userspace to be done.  We c=
ould
> also potentially kill the userspace application using the device, or if w=
e ever
> implemented revoke support for mmaps, we could unmap the device and
> the use could handle the SIGBUS.  With Parav's suggestion to fix the orde=
ring
> such that the device is first removed from the bus, where the blocking
> opportunity comes into play, it might be time to let go of this one-off
> force/not-force behavior.  Thanks,
>
=20
Yes. I think we should do it.
For now (for next few days), I am dropping this particular order fixing pat=
ch from the series.
From my last 8th patch, I am keeping only the fix for create/remove race wi=
th parent removal along with other fixes and cleanup.
Posting the v1 in sometime to make progress on already reviewed parts and p=
art of the 8th patch.

I cannot split the remove_common() helper function to a different patch, be=
cause remove_cb() will bypass mdev->active check without srcu().
So as individual patch, its not correct behavior.
Hence, that small refactor is part of srcu fix.
