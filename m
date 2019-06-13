Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74468C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45952207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="QTCbjZMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733154AbfFMPCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:02:17 -0400
Received: from mail-eopbgr10053.outbound.protection.outlook.com ([40.107.1.53]:47938
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732517AbfFMO1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtBIuhBXRVlxxD+ll8fmCwqj4wgCi6dpMg6N1Cr03BE=;
 b=QTCbjZMiiY06q08WZDr9b5a8MLgaod64YaRTLmJrYtD1h5jjmBadtbL5UrOS+lUEiDBQOI4aMCx+Z/QTHff/RPyQrnfw6OD4l8H5ImYVZOYWQfqBKsIugg55bxXklA8RJYZYDMvuLjyqdoHSwEeQ5QBf2DD6NUcN/PEoFOTelZA=
Received: from AM0PR08MB4226.eurprd08.prod.outlook.com (20.179.36.17) by
 AM0PR08MB5393.eurprd08.prod.outlook.com (52.132.213.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 13 Jun 2019 14:27:41 +0000
Received: from AM0PR08MB4226.eurprd08.prod.outlook.com
 ([fe80::bc0c:5148:629e:1a31]) by AM0PR08MB4226.eurprd08.prod.outlook.com
 ([fe80::bc0c:5148:629e:1a31%6]) with mapi id 15.20.1987.010; Thu, 13 Jun 2019
 14:27:41 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Enable/Disable vblank interrupts
Thread-Topic: [PATCH] drm/komeda: Enable/Disable vblank interrupts
Thread-Index: AQHVHUIw9rNeEORvRUuKBGT248hnN6aQgGsAgAktYAA=
Date:   Thu, 13 Jun 2019 14:27:41 +0000
Message-ID: <20190613142740.GA32394@arm.com>
References: <20190607150323.20395-1-ayan.halder@arm.com>
 <20190607181856.GK21222@phenom.ffwll.local>
In-Reply-To: <20190607181856.GK21222@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::19) To AM0PR08MB4226.eurprd08.prod.outlook.com
 (2603:10a6:208:147::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff2ace66-3059-4dee-b6fa-08d6f00b4b0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR08MB5393;
x-ms-traffictypediagnostic: AM0PR08MB5393:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR08MB5393E97FC979225C44697FC6E4EF0@AM0PR08MB5393.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(366004)(40434004)(189003)(199004)(476003)(2616005)(44832011)(8676002)(81156014)(11346002)(2501003)(446003)(6486002)(8936002)(486006)(81166006)(6436002)(72206003)(966005)(14454004)(478600001)(6306002)(53936002)(6512007)(305945005)(7736002)(68736007)(86362001)(2201001)(229853002)(2906002)(6116002)(3846002)(5660300002)(66446008)(64756008)(66556008)(66476007)(73956011)(110136005)(6636002)(53386004)(6246003)(25786009)(66066001)(66946007)(587094005)(99286004)(71190400001)(71200400001)(386003)(6506007)(102836004)(26005)(186003)(1076003)(52116002)(76176011)(14444005)(5024004)(33656002)(36756003)(256004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5393;H:AM0PR08MB4226.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1oX8Cwi+vN+Wo3865LYNyyo0lRKJUGBLx7d3A2Gf3bXWHDuHtKByDtpt4dWD3tNWSReyCiEPjl4mMrbYR5siUTRMc/wa4V1M7X8rxI/QCiOMFyCtU+pJYWz/6e3QSUGqCI58EE0qm8IsFEKjGTyjdyHiW4oeHdmkHIK8ZgP5Ek5F6Jdau+OsyiwM2yoxxtThAYwTyE/12OxPq1HhuYhTjzE04AsdvaTwL2dzlCQbNl/iBTD/8ydkUbebspPcBCelioMHhi03OAP/V459dpyLdqp6uEzgGdfQl14fQ7EwGwxxt1awJET9/e0gQ4NKO78lexyEUeYPswlWZtTzeUjPQ3mmozhCHZVH7jChAxfw6Tfshbo8ptQV0YLXRz7E5zaclnUdN9Ru12j0Nt4sUXfAZlwyH/yT8F0bAVaPs9BYDrw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DBCC2575CF0E6F489A9EC8C188EF6B4F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2ace66-3059-4dee-b6fa-08d6f00b4b0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 14:27:41.7793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ayan.Halder@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5393
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 08:18:56PM +0200, Daniel Vetter wrote:

Hi Daniel,

> On Fri, Jun 07, 2019 at 03:03:39PM +0000, Ayan Halder wrote:
> > One needs to set "(struct drm_device *)->irq_enabled =3D true" to signa=
l drm core
> > to enable vblank interrupts after the hardware has been initialized.
> > Correspondingly, one needs to disable vblank interrupts by setting
> > "(struct drm_device *)->irq_enabled =3D false" at the beginning of the
> > de-initializing routine.
>
> Only if you don't use the drm_irq_install helper. Quoting the kerneldoc i=
n
> full:
>
> /**
>  * @irq_enabled:
>  *
>  * Indicates that interrupt handling is enabled, specifically vblank
>  * handling. Drivers which don't use drm_irq_install() need to set this
>  * to true manually.
>  */
> bool irq_enabled;
>
> Not entirely sure where you've found your quote, but it's not complete.
>
> Cheers, Daniel

Thanks for your review.

That was my quote which reflects my half-baked understanding of the
issue :(. I had missed reading the header files.

That said, I will squash my previous patch "drm/komeda: Avoid using
DRIVER_IRQ_SHARED" into this one as the current patch is a consequence
of the changes made in the previous patch.

Regards,
Ayan Kumar Halder
>
> >
> > Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> > ---
> >  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_kms.c
> > index 7b5cde14e3ba..b4fd8ee0d05f 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > @@ -204,6 +204,8 @@ struct komeda_kms_dev *komeda_kms_attach(struct kom=
eda_dev *mdev)
> >  if (err)
> >  goto uninstall_irq;
> >
> > +drm->irq_enabled =3D true;
> > +
> >  err =3D drm_dev_register(drm, 0);
> >  if (err)
> >  goto uninstall_irq;
> > @@ -211,6 +213,7 @@ struct komeda_kms_dev *komeda_kms_attach(struct kom=
eda_dev *mdev)
> >  return kms;
> >
> >  uninstall_irq:
> > +drm->irq_enabled =3D false;
> >  drm_irq_uninstall(drm);
> >  cleanup_mode_config:
> >  drm_mode_config_cleanup(drm);
> > @@ -225,6 +228,7 @@ void komeda_kms_detach(struct komeda_kms_dev *kms)
> >  struct drm_device *drm =3D &kms->base;
> >  struct komeda_dev *mdev =3D drm->dev_private;
> >
> > +drm->irq_enabled =3D false;
> >  mdev->funcs->disable_irq(mdev);
> >  drm_dev_unregister(drm);
> >  drm_irq_uninstall(drm);
> > --
> > 2.21.0
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
