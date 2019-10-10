Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0043C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDA1206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=daktronics.com header.i=@daktronics.com header.b="hKGTBtrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfJJOzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:55:44 -0400
Received: from mail-eopbgr680061.outbound.protection.outlook.com ([40.107.68.61]:46695
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbfJJOzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:55:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTWh3CDqdCaUcqQcwmC7w+LSBu2mmUyn9E+iw+PXHhe9sI2cYYeGwyq2ZMW4fLuX1CALLp/cJNDbrFIa/hzJBN9rLNgM2tglQR47lxj4y6Lyq8mVJSx0bbYBcGtXdIjlQsrGnDHPfeMh/Vd/J5s+TgmPE/98BPmYUZYWweR2WRPhk2Y7QJVgqab/AkB7w+d33d9EI6/Tg98I9aWVe8tGxmxYvcjFNRxAkEL+HPtW7Sw16Xde4NsjNp8tyNw9d3mXfx0zfuta3b+eJMxcQY2B8O6+zM7gxzF5uR1G86GPCkVPzASiumkFpXFvFV+47QBdGpIBsvhMaqDp0gsvyMFDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvG0EKYDYGz3Y40vwwpNNVOPf2vKPpDUfqp+eN24uCI=;
 b=AxnVDMVeiN1Igx9thbq1CIwTBeSGtjemrsAL0Ui15wU+WgThLk7/rCXpqVX/jPALFWiH5ZNJOuPxh02eMtXvHRJ8cS0hebVBwLkVnXWNeyogrbA9XWcM+/gKELspibJuwFMvNtV5KE2ALY2nKFnRxIck/hgWJeACw8WNgOoXH8fjF7xS94oF7mV35rIuK3rRHEqCxDg+krLbDtMMJVftAcAW1A4sPX63C3N2krKaHZicYkW1zTJasXtcb9a4UVmJWOW0YvyHXBjIC9jshY9DTyC5znKkIHMyiYEfAPzGPB2h+a6SPxHAxb3mklORYODQ2DtJXCs6t3k8sj9iQ2Al9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=daktronics.com; dmarc=pass action=none
 header.from=daktronics.com; dkim=pass header.d=daktronics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=daktronics.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvG0EKYDYGz3Y40vwwpNNVOPf2vKPpDUfqp+eN24uCI=;
 b=hKGTBtrzr3jCuG5Ky25C18akGT8pnQGLyCFB5a1NOHUCSdlsmJgHNP+in8LGBLa1WkNi3zKLobBIPLqMuX1qBAl+lYCP9J0d2EgRmBy/WCbrL7+vL8kX77R6PUXcWwJPzKwtppJNXmD98X8wfvprrMPfwUYN0685A09EqtOYiG0=
Received: from SN6PR02MB4016.namprd02.prod.outlook.com (52.135.69.145) by
 SN6PR02MB4669.namprd02.prod.outlook.com (52.135.113.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 14:54:59 +0000
Received: from SN6PR02MB4016.namprd02.prod.outlook.com
 ([fe80::ec31:ae9d:c354:319a]) by SN6PR02MB4016.namprd02.prod.outlook.com
 ([fe80::ec31:ae9d:c354:319a%5]) with mapi id 15.20.2347.016; Thu, 10 Oct 2019
 14:54:59 +0000
From:   Matt Sickler <Matt.Sickler@daktronics.com>
To:     Chandra Annamaneni <chandra627@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "gneukum1@gmail.com" <gneukum1@gmail.com>,
        "fabian.krueger@fau.de" <fabian.krueger@fau.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "simon@nikanor.nu" <simon@nikanor.nu>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
Subject: RE: [PATCH] KPC2000: kpc2000_spi.c: Fix style issues (line length)
Thread-Topic: [PATCH] KPC2000: kpc2000_spi.c: Fix style issues (line length)
Thread-Index: AQHVfxglkDfKSozqZkux2cu69VsGV6dT8Nnw
Date:   Thu, 10 Oct 2019 14:54:59 +0000
Message-ID: <SN6PR02MB40166D599A07440D26EBE7F1EE940@SN6PR02MB4016.namprd02.prod.outlook.com>
References: <1570676937-3975-1-git-send-email-chandra627@gmail.com>
In-Reply-To: <1570676937-3975-1-git-send-email-chandra627@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Matt.Sickler@daktronics.com; 
x-originating-ip: [2620:9b:8000:6046:fb0a:2a78:c036:e564]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8679d0e5-cfcc-4600-5ba5-08d74d91d2bc
x-ms-traffictypediagnostic: SN6PR02MB4669:
x-microsoft-antispam-prvs: <SN6PR02MB466914554C7E8A4CC3F92D96EE940@SN6PR02MB4669.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(366004)(39850400004)(136003)(13464003)(189003)(199004)(102836004)(2501003)(6246003)(71200400001)(71190400001)(11346002)(446003)(6506007)(76116006)(46003)(5660300002)(66946007)(476003)(33656002)(486006)(4326008)(66476007)(66556008)(64756008)(66446008)(52536014)(74316002)(2906002)(54906003)(8676002)(7696005)(305945005)(81166006)(7736002)(256004)(81156014)(14454004)(316002)(478600001)(186003)(86362001)(110136005)(25786009)(76176011)(6116002)(6436002)(9686003)(8936002)(55016002)(229853002)(14444005)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4669;H:SN6PR02MB4016.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: daktronics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: okZ0Zb8hJ2XoseC8OPSx304xZ9Az7jeeURDcQl1/AW+jpgksHl8s+FzL0Ly+9uniVwcFiaqLSABSS+yfOraiF++A2FvxBUyr3TayozI+n4BbJCnwc5noJrmwEzrGFLrFtvzzeqcC2NPEqeYRqrXl3+gsItuHiDDxqjlFuLnx/DL4Jj0SI/bGsAinySIZQa6vyf7SzG2wdL1aYm6AGD87WKqAE5xVXMHfqLOJPG7Of1vH2bxj70b7YkXKuso+/91+Ma5Kl2AiYQKK+Cj7y07SSTKHDvBauPTbvdoLYDZqBUFBcHlktDsT2WYse+VdVFFSks4r/uUf0L1HgDHxANoVzjELBn2LXShKN9QQPLow4AtIQU6xtbymdRRcZtRGxrIs+h2zjIrLDQbxNJNvboInzpTZ3j/rugdddBdf964cU+8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: daktronics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8679d0e5-cfcc-4600-5ba5-08d74d91d2bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 14:54:59.6980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be88af81-0945-42aa-a3d2-b122777351a2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ns6lBsKwPmNFzsbNld3jb6cjgpfXq4GCaFC2Z4Nt9T8AcCeqCQJCgQnB4QHuFmVg+DQHkD6fmqXOjq4j4n/gBFd1KnbA2+c2AuPAKOy/1pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4669
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: devel <driverdev-devel-bounces@linuxdriverproject.org> On Behalf Of =
Chandra Annamaneni
>Sent: Wednesday, October 09, 2019 10:09 PM
>To: gregkh@linuxfoundation.org
>Cc: devel@driverdev.osuosl.org; gneukum1@gmail.com; chandra627@gmail.com; =
fabian.krueger@fau.de; linux-
>kernel@vger.kernel.org; simon@nikanor.nu; dan.carpenter@oracle.com
>Subject: [PATCH] KPC2000: kpc2000_spi.c: Fix style issues (line length)
>
>Resoved: "WARNING: line over 80 characters" from checkpatch.pl
>
>Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
>---
> drivers/staging/kpc2000/kpc2000_spi.c | 20 ++++++++++----------
> 1 file changed, 10 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc20=
00/kpc2000_spi.c
>index 3be33c4..ef78b6d 100644
>--- a/drivers/staging/kpc2000/kpc2000_spi.c
>+++ b/drivers/staging/kpc2000/kpc2000_spi.c
>@@ -30,19 +30,19 @@
> #include "kpc.h"
>
> static struct mtd_partition p2kr0_spi0_parts[] =3D {
>-       { .name =3D "SLOT_0",     .size =3D 7798784,                .offse=
t =3D 0,                },
>-       { .name =3D "SLOT_1",     .size =3D 7798784,                .offse=
t =3D MTDPART_OFS_NXTBLK},
>-       { .name =3D "SLOT_2",     .size =3D 7798784,                .offse=
t =3D MTDPART_OFS_NXTBLK},
>-       { .name =3D "SLOT_3",     .size =3D 7798784,                .offse=
t =3D MTDPART_OFS_NXTBLK},
>-       { .name =3D "CS0_EXTRA",  .size =3D MTDPART_SIZ_FULL,       .offse=
t =3D MTDPART_OFS_NXTBLK},
>+       { .name =3D "SLOT_0",  .size =3D 7798784,  .offset =3D 0,},
>+       { .name =3D "SLOT_1",  .size =3D 7798784,  .offset =3D MTDPART_OFS=
_NXTBLK},
>+       { .name =3D "SLOT_2",  .size =3D 7798784,  .offset =3D MTDPART_OFS=
_NXTBLK},
>+       { .name =3D "SLOT_3",  .size =3D 7798784,  .offset =3D MTDPART_OFS=
_NXTBLK},
>+       { .name =3D "CS0_EXTRA", .size =3D MTDPART_SIZ_FULL, .offset =3D M=
TDPART_OFS_NXTBLK},
> };
>
> static struct mtd_partition p2kr0_spi1_parts[] =3D {
>-       { .name =3D "SLOT_4",     .size =3D 7798784,                .offse=
t =3D 0,                },
>-       { .name =3D "SLOT_5",     .size =3D 7798784,                .offse=
t =3D MTDPART_OFS_NXTBLK},
>-       { .name =3D "SLOT_6",     .size =3D 7798784,                .offse=
t =3D MTDPART_OFS_NXTBLK},
>-       { .name =3D "SLOT_7",     .size =3D 7798784,                .offse=
t =3D MTDPART_OFS_NXTBLK},
>-       { .name =3D "CS1_EXTRA",  .size =3D MTDPART_SIZ_FULL,       .offse=
t =3D MTDPART_OFS_NXTBLK},
>+       { .name =3D "SLOT_4",  .size =3D 7798784,  .offset =3D 0,},
>+       { .name =3D "SLOT_5",  .size =3D 7798784,  .offset =3D MTDPART_OFS=
_NXTBLK},
>+       { .name =3D "SLOT_6",  .size =3D 7798784,  .offset =3D MTDPART_OFS=
_NXTBLK},
>+       { .name =3D "SLOT_7",  .size =3D 7798784,  .offset =3D MTDPART_OFS=
_NXTBLK},
>+       { .name =3D "CS1_EXTRA",  .size =3D MTDPART_SIZ_FULL, .offset =3D =
MTDPART_OFS_NXTBLK},
> };
>
> static struct flash_platform_data p2kr0_spi0_pdata =3D {

Is the line length limit a hard rule or can exceptions be made?  I really f=
eel that these data tables are more easily read when they're formatted like=
 tables...
