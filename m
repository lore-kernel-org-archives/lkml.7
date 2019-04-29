Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CF8C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCB6205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=daktronics.com header.i=@daktronics.com header.b="o7j9Sxnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfD2PCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:02:14 -0400
Received: from mail-eopbgr810047.outbound.protection.outlook.com ([40.107.81.47]:59712
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727554AbfD2PCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 11:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=daktronics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kakRN+MK0q1R/BRbo+r48QXnvGmOubtzyEDHe7/bu/g=;
 b=o7j9SxnfVtkaaWypM4/YeK3NcdCvwnROGHfQ6174Zk8AXm7EhRaj6cZpSOi/65FbnzOjqSEczyOUDQU7R4TuPzwRqacyoB1zX57T//LnGd271rsaaLLmaVs8h2Ht3To9X8+ZRPwfYi6gKcW0/wKiiposl/viKT2dGbJmLr8Z+yQ=
Received: from SN6PR02MB4016.namprd02.prod.outlook.com (52.135.69.145) by
 SN6PR02MB4494.namprd02.prod.outlook.com (52.135.121.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Mon, 29 Apr 2019 15:02:10 +0000
Received: from SN6PR02MB4016.namprd02.prod.outlook.com
 ([fe80::9159:5594:9b0a:df2d]) by SN6PR02MB4016.namprd02.prod.outlook.com
 ([fe80::9159:5594:9b0a:df2d%2]) with mapi id 15.20.1835.018; Mon, 29 Apr 2019
 15:02:10 +0000
From:   Matt Sickler <Matt.Sickler@daktronics.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC V2] staging: kpc2000: use int for
 wait_for_completion_interruptible
Thread-Topic: [PATCH RFC V2] staging: kpc2000: use int for
 wait_for_completion_interruptible
Thread-Index: AQHU/NprkXgP4dxHiEqrWO1iDMxlTqZTPadg
Date:   Mon, 29 Apr 2019 15:02:10 +0000
Message-ID: <SN6PR02MB4016A8EC6E8402A26BDE54CDEE390@SN6PR02MB4016.namprd02.prod.outlook.com>
References: <1556356474-8575-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1556356474-8575-1-git-send-email-hofrat@osadl.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Matt.Sickler@daktronics.com; 
x-originating-ip: [2620:9b:8000:6046:19fb:aecb:6f49:261c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 333dc2d1-0ed9-47cf-2162-08d6ccb3a7f5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN6PR02MB4494;
x-ms-traffictypediagnostic: SN6PR02MB4494:
x-microsoft-antispam-prvs: <SN6PR02MB4494D47D6CA5C1FE86AB48C2EE390@SN6PR02MB4494.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39850400004)(376002)(346002)(136003)(396003)(199004)(13464003)(189003)(6436002)(74316002)(14454004)(6246003)(229853002)(7736002)(25786009)(33656002)(305945005)(46003)(186003)(53936002)(9686003)(97736004)(4326008)(66946007)(110136005)(54906003)(316002)(6506007)(76176011)(99286004)(73956011)(7696005)(486006)(52536014)(68736007)(102836004)(66446008)(476003)(8676002)(66476007)(6116002)(71200400001)(66556008)(71190400001)(64756008)(81166006)(81156014)(2906002)(5660300002)(86362001)(256004)(8936002)(478600001)(446003)(55016002)(11346002)(72206003)(14444005)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4494;H:SN6PR02MB4016.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: daktronics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tEmVBHPHxCkbZkmGG4x0iU469wHoWILVGnwoJ+YWVFku+GrWRgwJZir63Uoz1is2s/7g7l+ScDt1sYAdeqKZIc2zcxdvDsw63k3d+kby1jbNt+1ZStGzsyNv4+73AEaow5d/4ofauDu7iubv8ngXW9i7qRPtWefnQt/4Nq15qkMHxep59uHvtvaSmjoEv4InSPCew5F87h8WM8aw3vbi2SL+cy8hPPxga5OVGb4KNKAbCiRP7v56ADr8eDMds8Il6GKsWFXQlJZmDlaF1ElrvGi2JolFOoVTOlWj3OkYy9wV3dwqRsGv8sWBVWNZv1xzEhDoUsCxVsam2w0IsC/tRrymvahmODIZkCX91lOArAqq237boYtHn4waRzDOsleavI8Q8vjU846HF9faFDH+59Jp9k1r5KcndUfq/QOdCjg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: daktronics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333dc2d1-0ed9-47cf-2162-08d6ccb3a7f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 15:02:10.6714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be88af81-0945-42aa-a3d2-b122777351a2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4494
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACK.   However, that part isn't the only part of that function that uses "r=
eturn rv" though.
There's another part that does "rv =3D get_user_pages(...)" and get_user_pa=
ges() returns a long.
Does this same kind of change need to happen for that case?

>-----Original Message-----
>From: Nicholas Mc Guire <hofrat@osadl.org>
>Sent: Saturday, April 27, 2019 4:15 AM
>To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: Matt Sickler <Matt.Sickler@daktronics.com>; devel@driverdev.osuosl.org=
;
>linux-kernel@vger.kernel.org; Nicholas Mc Guire <hofrat@osadl.org>
>Subject: [PATCH RFC V2] staging: kpc2000: use int for
>wait_for_completion_interruptible
>
>
>weit_for_completion_interruptible returns in (0 on completion and -
>ERESTARTSYS on interruption) - so use an int not long for API conformance
>and simplify the logic here a bit: need not check explicitly for =3D=3D 0 =
as this is
>either -ERESTARTSYS or 0.
>
>Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
>---
>
>Problem located with experimental API conformance checking cocci script
>
>V2: kbuild reported a missing closing comment - seems that I managed
>    send out the the initial version before compile testing/checkpatching
>    sorry for the noise.
>
>Not sure if making such point-wise fixes makes much sense - this driver ha=
s a
>number of issues both style-wise and API compliance wise.
>
>Note that kpc_dma_transfer() returns int not long - currently rv (long) is=
 being
>returned in most places (some places do return int) - so the return handli=
ng
>here is a bit inconsistent.
>
>Patch was compile-tested with: x86_64_defconfig + KPC2000=3Dy,
>KPC2000_DMA=3Dy (with a number of unrelated sparse warnings about non-
>declared symbols, and  smatch warnings about overflowing constants as well
>as coccicheck warning  about usless casting)
>
>Patch is against 5.1-rc6 (localversion-next is next-20190426)
>
> drivers/staging/kpc2000/kpc_dma/fileops.c | 16 +++++++++-------
> 1 file changed, 9 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c
>b/drivers/staging/kpc2000/kpc_dma/fileops.c
>index 5741d2b..66f0d5a 100644
>--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
>+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
>@@ -38,6 +38,7 @@ int  kpc_dma_transfer(struct dev_private_data *priv,
>struct kiocb *kcb, unsigned  {
>        unsigned int i =3D 0;
>        long rv =3D 0;
>+       int ret =3D 0;
>        struct kpc_dma_device *ldev;
>        struct aio_cb_data *acd;
>        DECLARE_COMPLETION_ONSTACK(done); @@ -180,16 +181,17 @@ int
>kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigne=
d
>
>        // If this is a synchronous kiocb, we need to put the calling proc=
ess to
>sleep until the transfer is complete
>        if (kcb =3D=3D NULL || is_sync_kiocb(kcb)){
>-               rv =3D wait_for_completion_interruptible(&done);
>-               // If the user aborted (rv =3D=3D -ERESTARTSYS), we're no =
longer
>responsible for cleaning up the acd
>-               if (rv =3D=3D -ERESTARTSYS){
>+               ret =3D wait_for_completion_interruptible(&done);
>+               /* If the user aborted (ret =3D=3D -ERESTARTSYS), we're
>+                * no longer responsible for cleaning up the acd
>+                */
>+               if (ret) {
>                        acd->cpl =3D NULL;
>-               }
>-               if (rv =3D=3D 0){
>-                       rv =3D acd->len;
>+               } else {
>+                       ret =3D acd->len;
>                        kfree(acd);
>                }
>-               return rv;
>+               return ret;
>        }
>
>        return -EIOCBQUEUED;
>--
>2.1.4

