Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EC0C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BED120869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ryENtxO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfDZTCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:02:48 -0400
Received: from mail-eopbgr10075.outbound.protection.outlook.com ([40.107.1.75]:44964
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbfDZTCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R96mNGUc9TzvKwe4faIeBjYKM1yC9JhuKJ3J3FNoT1o=;
 b=ryENtxO0M4pGOntvm7pypFWxd5nRNS85TIBAaYShYQP8//4Djp2CzVIg5cXwhRJntkkrmQ0J1x8tfkBHajw+h4FxQd67ASmLhImuAjuXVGxyqWrewFn3Js3VU0RrwC5dX8vDazwV+nQWeFVgnsAKbsuRaS01y61/e67e//BL1io=
Received: from AM4PR0501MB2260.eurprd05.prod.outlook.com (10.165.45.148) by
 AM4PR0501MB2818.eurprd05.prod.outlook.com (10.172.217.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Fri, 26 Apr 2019 19:02:41 +0000
Received: from AM4PR0501MB2260.eurprd05.prod.outlook.com
 ([fe80::5959:917c:7329:cffd]) by AM4PR0501MB2260.eurprd05.prod.outlook.com
 ([fe80::5959:917c:7329:cffd%7]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 19:02:40 +0000
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
Thread-Index: AQHU5E+fUzbTxof5gUmmXNBNyohq0KYq/2wAgAAqTZCAAVwMAIAAJL4AgB2gawCAA2ZPoIABEQgAgAAFkcCAAARfAIAALiDQ
Date:   Fri, 26 Apr 2019 19:02:40 +0000
Message-ID: <AM4PR0501MB22602E3F3480FAC5DC297D4DD13E0@AM4PR0501MB2260.eurprd05.prod.outlook.com>
References: <1553658345-43995-1-git-send-email-parav@mellanox.com>
        <1553658345-43995-8-git-send-email-parav@mellanox.com>
        <20190403152722.24efc561@x1.home>
        <VI1PR0501MB22714BE24CEA00E14A811918D1500@VI1PR0501MB2271.eurprd05.prod.outlook.com>
        <20190404144428.1fa6afb2@x1.home>
        <VI1PR0501MB2271E8894B77BA8F316B6148D1500@VI1PR0501MB2271.eurprd05.prod.outlook.com>
        <20190423132140.18b0d892@x1.home>
        <AM4PR0501MB2260154A21D3E471A838CF5CD13D0@AM4PR0501MB2260.eurprd05.prod.outlook.com>
        <20190426093350.47619260@x1.home>
        <AM4PR0501MB22608CA6D17273F0E2B4A96ED13E0@AM4PR0501MB2260.eurprd05.prod.outlook.com>
 <20190426100924.4bf48708@x1.home>
In-Reply-To: <20190426100924.4bf48708@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d69cf3da-0a6b-460a-fa95-08d6ca79c1b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM4PR0501MB2818;
x-ms-traffictypediagnostic: AM4PR0501MB2818:
x-microsoft-antispam-prvs: <AM4PR0501MB2818F1253310AEFFAA826A88D13E0@AM4PR0501MB2818.eurprd05.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(366004)(136003)(39860400002)(189003)(199004)(13464003)(6916009)(446003)(478600001)(97736004)(476003)(316002)(55016002)(11346002)(99286004)(486006)(7736002)(8676002)(33656002)(305945005)(81156014)(81166006)(6436002)(54906003)(102836004)(6506007)(53546011)(74316002)(229853002)(66446008)(73956011)(66476007)(66946007)(66556008)(64756008)(186003)(76116006)(26005)(66066001)(8936002)(86362001)(6246003)(4326008)(68736007)(52536014)(9686003)(14454004)(7696005)(2906002)(53936002)(93886005)(71190400001)(5660300002)(6116002)(14444005)(3846002)(71200400001)(25786009)(256004)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0501MB2818;H:AM4PR0501MB2260.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ueS3l04XVS/cQlUH4TJkJxNRPQAwzXx+1MdMaSko9aYJ5KspARtJpeJiguW/YpQ4+Rk+ni1Bc2w51H0EBlVIoN1sRfibA8udpPyp2/ccpJRzxgGYtDjBHYYws971wwQAiyL3UybiPONLd+ywc8dAC4ipqNJNPxBC+3KJjQ51JH3tVg3BYffZBMjREnjrLZ9pMh9saZeNfJn5Pp32gRZ3ByjqWKkFgqRpaF4+RB15QlYQ552pqlORXOYWSyexAqbHUhD3I1NLi3JmkOGVDDIP9CBkcgxBJRqFTSiNvJZ79uWdBgMdRrB/02fyP52ErqBVRNgafOtRhSQfYEFGe/BuGvvyAD8Us2yZB8GZMEC+9LmD2MbbimKW3z0G9z4BCGkljzStyRtH2LD3Y0HMKz4cOeQn2v9J2wB4eMhioYIfPq0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69cf3da-0a6b-460a-fa95-08d6ca79c1b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 19:02:40.7759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2818
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,


> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Friday, April 26, 2019 11:09 AM
> To: Parav Pandit <parav@mellanox.com>
> Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> kwankhede@nvidia.com; cjia@nvidia.com
> Subject: Re: [PATCHv1 7/7] vfio/mdev: Fix race conditions with mdev devic=
e
> life cycle APIs

[..]

> > > >
> > > > > Patch 6 looks ok, except I'd rather see the sanitizing loop stay
> > > > > until we can otherwise fix the race above.
> > > > I can put back the sanitizing look, once it looks valid. Will wait
> > > > for your response.
> > >
> > > Yep, I think patch 6 is good w/o the removal of the sanitizing loop.
> > > Will you repost it?
> > >
> > Just the patch-6 or 1 to 6?
>=20
> Your choice, please roll in reviews/acks if you repost the rest.
>=20
> > > > > Patch 7 needed more work, iirc.  Thanks,
> > > > For a moment if we assume sanitizing loop exists, than patch-7
> > > > looks good?
> > >
> > > Patch 7 is a bit less trivial, so I think as we're close to the
> > > merge window for v5.2, I'd rather push it out to be included with
> > > the later re-works.  Thanks,
> > >
> > I agree it little less trivial, I tried to place as much comment as pos=
sible,
> but it is an important fix.
> > Let me repost 6-7 and decide if it can be included or not?
>=20
> Sounds good.  Thanks,
>=20
I am dropping patch-7 for today and reworking the patch-6 for now.

Even after keeping that that crazy loop, I am easily able to create this be=
low [1] call trace on adding file when mdev_remove() fails with the thread =
sequence we discussed above.

I think this is high time, we fix the sequence to match the linux bus seque=
nce.
I have some cycles this week.
Post these 6 patches,
I like to get total 3 patches done.
1. fix the bus sequence
2. race with parent device removal
3. do not try to add sysfs file on remove() failure

Is there any possibility above 3 patches can make to 5.2, given that merge =
window closes in June?
If yes, I will get them in 2-3 days. I will test with sample drivers and ml=
x5 driver.
Can we get some tests also done from Kirti also done on their hw?

kernel: WARNING: CPU: 2 PID: 9348 at fs/sysfs/file.c:327 sysfs_create_file_=
ns+0x7f/0x90
kernel: CPU: 2 PID: 9348 Comm: bash Kdump: loaded Not tainted 5.1.0-rc6-vde=
vbus+ #6
kernel: Hardware name: Supermicro SYS-6028U-TR4+/X10DRU-i+, BIOS 2.0b 08/09=
/2016
kernel: RIP: 0010:sysfs_create_file_ns+0x7f/0x90
kernel: Call Trace:
kernel: remove_store+0xdc/0x100 [mdev]
kernel: kernfs_fop_write+0x113/0x1a0
kernel: vfs_write+0xad/0x1b0
kernel: ksys_write+0x5a/0xe0
kernel: do_syscall_64+0x5a/0x210
kernel: entry_SYSCALL_64_after_hwframe+0x49/0xbe

