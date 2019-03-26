Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055A0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A104120823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="G2sxt9A7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbfCZFxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 01:53:30 -0400
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:11905
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbfCZFx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 01:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjqcYsZ8X8n9tYOWDfDO7YDq0MESI/P/ERdPheon36s=;
 b=G2sxt9A7knVcqQzfl3uWIK3lOXaZjB8ZTnEsfFaYCJzKPdlyhny3RdfSN3AxWGZvb6WK/HbWfydJ3T707iEd7lIlQOl+wf1Ej2F3B/z5NwpGiR4Nrxu4kvcx6tgiJ5YFtlsaoX6pXtknvhqQ8LY9xXC4VL6q+M67stcJ1wq75BE=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2381.eurprd05.prod.outlook.com (10.168.135.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Tue, 26 Mar 2019 05:53:22 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 05:53:22 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Parav Pandit <parav@mellanox.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>
Subject: RE: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
Thread-Topic: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
Thread-Index: AQHU4QXvNq2tSD+YZ0aNNrE4+GOfm6YdABKAgAAAkkCAAAyXgIAABJ/ggAAgBYCAABDwMIAAKvYw
Date:   Tue, 26 Mar 2019 05:53:22 +0000
Message-ID: <VI1PR0501MB22715E9A784070A9169B7B5BD15F0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
        <1553296835-37522-9-git-send-email-parav@mellanox.com>
        <20190325171831.1ac2a441@x1.home>
        <VI1PR0501MB2271CD34DCA1D1D5EDAFDBD7D15E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
        <20190325180537.11842c03@x1.home>
        <VI1PR0501MB2271CECD3B2200BB5A7DEC00D15F0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190325201645.1ba4e9bf@x1.home>
 <VI1PR0501MB227124A89CF30D12E89CF5D8D15F0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
In-Reply-To: <VI1PR0501MB227124A89CF30D12E89CF5D8D15F0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [2605:6000:ec80:6500:d94e:5f01:4575:4c65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbd7f6ba-a2f2-4bda-5e7b-08d6b1af5af4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2381;
x-ms-traffictypediagnostic: VI1PR0501MB2381:
x-microsoft-antispam-prvs: <VI1PR0501MB2381DEF2112B538CEFD3AA56D15F0@VI1PR0501MB2381.eurprd05.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(366004)(376002)(13464003)(199004)(189003)(6116002)(4326008)(6246003)(186003)(74316002)(305945005)(105586002)(52536014)(102836004)(76176011)(6506007)(11346002)(446003)(53546011)(25786009)(486006)(476003)(2906002)(106356001)(46003)(5660300002)(7736002)(14444005)(256004)(86362001)(7696005)(81156014)(81166006)(229853002)(8936002)(71190400001)(71200400001)(14454004)(93156006)(93886005)(110136005)(2940100002)(54906003)(99286004)(8676002)(33656002)(316002)(9686003)(68736007)(55016002)(53936002)(97736004)(478600001)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2381;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ADzXYxGGLs6FQeG9heSQBDzg5gU+Y2wrk0Oq5smg2CnJqUzXcgq6CmV1PkKtCO3F2f9Jj7i2IXv8hCwzyIo4Di/J3kDQ3Rfl0wNARffVcWpbJYXCr7AolH+xG+baUCGgBHy1z7buu1dAXQ2DmO9+nBcDf33NhDsjJOt6fnIoAaT08KxyUz414pGxVhMh5PvIQQtMLbWaNe1jWNHKBYJ8X5lRTpqdFJZEDQo4kClcEv4XC3Nc7nfGQLTg3Hyo8ujRhxMqGHSqbHDOWEFTgWRhU3Wglm4vB6CRyw38hGuCw1Fsfz5diHMhkoJMYZeYgiFdmj6sRm2kDXjyp77W/PQ/6TlnWvCuUJIoQb8EVW0oowfYUOzX+6vbqu9h6Lb7yac3i+dF7Bp6KDc+ZvmR1tHy4hLTj86gHKfopJZsFIDRkC4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd7f6ba-a2f2-4bda-5e7b-08d6b1af5af4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 05:53:22.1660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Parav Pandit
> Sent: Monday, March 25, 2019 10:19 PM
> To: Alex Williamson <alex.williamson@redhat.com>
> Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> kwankhede@nvidia.com
> Subject: RE: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
>=20
>=20
>=20
> > -----Original Message-----
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Monday, March 25, 2019 9:17 PM
> > To: Parav Pandit <parav@mellanox.com>
> > Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > kwankhede@nvidia.com
> > Subject: Re: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
> >
> > On Tue, 26 Mar 2019 01:43:44 +0000
> > Parav Pandit <parav@mellanox.com> wrote:
> >
> > > > -----Original Message-----
> > > > From: Alex Williamson <alex.williamson@redhat.com>

> > > > I mean the callback iterator on the parent remove can do a WARN_ON
> > > > if this returns an error while the device remove path can silently
> > > > return -EBUSY, the common function doesn't need to decide whether
> > > > the parent ops remove function deserves a dev_err.
> > > >
> > > Ok. I understood.
> > > But device remove returning silent -EBUSY looks an error that should
> > > get logged in, because this is something not expected. Its probably
> > > late for sysfs layer to return report an error by that time it
> > > prints device name, because put_device() is done. So if remove()
> > > returns an error, I think its legitimate failure to do WARN_ON or
> dev_err().
> >
> > Calling put_device() if the parent remove op fails looks like a bug
> > introduced by this series, the current code allows that failure
> > leaving the device in a coherent state and returning errno to the sysfs
> store function.
> >
> Why should it fail?
> We are taking off the device bus first as describe in commit log.
> This ensures that everything is closed before calling the remove().
> We cannot avoid put_device() and put_parent, it all buggy path...

I audited remove() callbacks of kvmgt.c, vfio_ccw_ops.c, vfio_ap_ops.c, mbo=
chs.c, mdpy.c, mtty.c, who makes the remove possible once the device releas=
e is executed.
This should complete once the device is taken off the bus.
This was not the case before this sequence where remove() is done while dev=
ice is open...hence the check was needed in past.
dev_err() is to help catch any errors/bugs in this area.

I doubt we need to retry remove() like vfio_del_group_dev(), in mdev_core i=
f release() is not yet complete.
