Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF934C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC188206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="e4YyzcQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKUPji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:39:38 -0500
Received: from mail-eopbgr820070.outbound.protection.outlook.com ([40.107.82.70]:49376
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfKUPji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:39:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJ4O0gQGwTtZ83Tpi4BXyYFwP0eLT4TG16AZaJhCJBgITM0gS2s89i1JqR+z0TvBhgLlZk1ou4RJcG1aQhVUY1EWqe8zb6Jey3tWN6OfLeS//7CjUiDLJw+N4tjZQLF86RQzr3Iuw0ln7YDAXDKi3DZZquuV2e0hBR9FZvgx6msPnZntBWAtJ+MINiFiKEyzTsEsMCS5K06nINgOxqq6JxLCDIeumaHSlN3qcxRo/bwHIiBVpTPHtNR5IvGVwJv8NqV+xSC+FtEfekPzWqNa/lMum/qEnW1tznO7BJ5kcjVL6jNAXGLqiy5N4TRM7XSu5RZqFhimt+Gl2fuRFfpBlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Od/uDTeY3UWISwWIwkIRj7tuK7aglFLdoTEDYm6u2VE=;
 b=cY556D+syNzcjm6iQ2BFuyi8+rgvKubz8OG+0ArhqmBxOA1p5C2FosTr1QVonYJbc6NzdA1dODvvUvqzpwS0DqYs43K1eibSOht89hwKx9VgRFt3oUnHNAoRfzPLE3FKbWHjJARa+mbwezlRFGvdKeFZ/VlxlRETV2hbL4DWRDgOMCL294urTWFo4QKMLDTYm8gvN3AIusVObFVvavxOVs1tTR2/l1AI2hOPzdrxXreKRU+exF+U65xcQv+SBWMH47jytvnJpcAJK6N3MPa2LCNhrUmYQhy+77tY6ix8xgUGA316KPbDHgHAY0L+mXsxrZKNWFaIAzo0UI2GCJ8hlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Od/uDTeY3UWISwWIwkIRj7tuK7aglFLdoTEDYm6u2VE=;
 b=e4YyzcQbtJEgy1XoSV9GEFmUo/jVKqX5xwP+/3oJoXhieqO8Sw/G6JwbFwiCCBVADxYUmLQGKH3K8dhUgrI8Y3ULppbEmWxNK9y8da/o3fFm0Ffr542K3v7UfSPnHzRT0kuHBeksc54O4aeC7WzNa/IkKmHHcL+WrSS7TfyvTOM=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.230.25) by
 CH2PR02MB6264.namprd02.prod.outlook.com (52.132.230.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Thu, 21 Nov 2019 15:39:34 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::e81d:489c:2bd7:918a]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::e81d:489c:2bd7:918a%7]) with mapi id 15.20.2451.031; Thu, 21 Nov 2019
 15:39:34 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Derek Kiernan <dkiernan@xilinx.com>
Subject: RE: [PATCH] misc: xilinx_sdfec: fix xsdfec_poll()'s return type
Thread-Topic: [PATCH] misc: xilinx_sdfec: fix xsdfec_poll()'s return type
Thread-Index: AQHVnzbvRwd5Ss/ZH0ugJQL96aPqOKeVxQvA
Date:   Thu, 21 Nov 2019 15:39:33 +0000
Message-ID: <CH2PR02MB6359877D5963764F718FAAF4CB4E0@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <20191120001030.30779-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20191120001030.30779-1-luc.vanoostenryck@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e51010c7-7f11-40e2-3699-08d76e990217
x-ms-traffictypediagnostic: CH2PR02MB6264:|CH2PR02MB6264:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB62646107CB2AF0A549C9BAAFCB4E0@CH2PR02MB6264.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(39850400004)(396003)(136003)(13464003)(199004)(189003)(33656002)(66946007)(66476007)(66556008)(64756008)(66446008)(76116006)(8936002)(3846002)(14454004)(11346002)(446003)(6246003)(6116002)(25786009)(81156014)(81166006)(6436002)(107886003)(8676002)(9686003)(229853002)(55016002)(110136005)(305945005)(7736002)(52536014)(74316002)(478600001)(256004)(14444005)(7696005)(2906002)(76176011)(4326008)(26005)(316002)(53546011)(99286004)(102836004)(2501003)(71190400001)(71200400001)(66066001)(86362001)(186003)(5660300002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6264;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OzWLdJIu7Ky48KJfDT8NQ89LezVt8HHGtV4WssEHCC9UKqUh3DD+NhDsWcH7kKaYL+73ynxAaLowhzN+CQUqfMURHyQuwPBo3Rl0baRdR7RXb/M12lyAOSlWiqou0F9WS/KemkkjxV3Aq0s944mqzFL3RYGagk/HQFKANl7UfNxdPTr7BAWzzBEoIGLaJCDA5G3gvDY2jQBvBv57ltFCLjjwTwmz31cQv9riDxq8/8JvxGPbJNy7pt/Z3WVA4s21sJ8XUIRm4mIP02dLupKD+UyJPgNEy/USQmtBpxq1v0cTxyYgQcGcNX8cX/I97rzI77qSNFbWfQRXxvB93ou7onE9/cD7nGGnFiprczooyt4tud3PTUWJKwVhOyowhXpXv4EimmiIXdA0FrFlCHq3yR2MFL4LbVtJ194AQwjEVl/+FxoYWPSnHfww9ssUybfQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51010c7-7f11-40e2-3699-08d76e990217
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 15:39:33.7413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDuVIRcEfQbPkrjEirRCqSKlhhKOehaiNxASdy1mgsA84D+Hsgs/WvycR/zLU0a9/jI4IF2C7Zll4C8RTsyuIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6264
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

please find my comments below.


> -----Original Message-----
> From: Luc Van Oostenryck [mailto:luc.vanoostenryck@gmail.com]
> Sent: Wednesday 20 November 2019 00:11
> To: linux-kernel@vger.kernel.org
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>; Derek Kiernan <dkie=
rnan@xilinx.com>; Dragan Cvetic
> <draganc@xilinx.com>
> Subject: [PATCH] misc: xilinx_sdfec: fix xsdfec_poll()'s return type
>=20
> xsdfec_poll() is defined as returning 'unsigned int' but the
> .poll method is declared as returning '__poll_t', a bitwise type.
>=20
> Fix this by using the proper return type and using the EPOLL
> constants instead of the POLL ones, as required for __poll_t.
>=20
> CC: Derek Kiernan <derek.kiernan@xilinx.com>
> CC: Dragan Cvetic <dragan.cvetic@xilinx.com>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/misc/xilinx_sdfec.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> index 11835969e982..48ba7e02bed7 100644
> --- a/drivers/misc/xilinx_sdfec.c
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -1025,25 +1025,25 @@ static long xsdfec_dev_compat_ioctl(struct file *=
file, unsigned int cmd,
>  }
>  #endif
>=20
> -static unsigned int xsdfec_poll(struct file *file, poll_table *wait)
> +static __poll_t xsdfec_poll(struct file *file, poll_table *wait)
>  {
> -	unsigned int mask =3D 0;
> +	__poll_t mask =3D 0;
>  	struct xsdfec_dev *xsdfec;
>=20
>  	xsdfec =3D container_of(file->private_data, struct xsdfec_dev, miscdev)=
;
>=20
>  	if (!xsdfec)
> -		return POLLNVAL | POLLHUP;
> +		return EPOLLNVAL | EPOLLHUP;
>=20
>  	poll_wait(file, &xsdfec->waitq, wait);
>=20
>  	/* XSDFEC ISR detected an error */
>  	spin_lock_irqsave(&xsdfec->error_data_lock, xsdfec->flags);
>  	if (xsdfec->state_updated)
> -		mask |=3D POLLIN | POLLPRI;
> +		mask |=3D EPOLLIN | EPOLLPRI;
>=20
>  	if (xsdfec->stats_updated)
> -		mask |=3D POLLIN | POLLRDNORM;
> +		mask |=3D EPOLLIN | EPOLLRDNORM;
>  	spin_unlock_irqrestore(&xsdfec->error_data_lock, xsdfec->flags);
>=20
>  	return mask;
> --
> 2.24.0

Acked-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
