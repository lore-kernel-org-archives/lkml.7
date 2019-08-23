Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381A7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E335D22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="iFfMTo5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393066AbfHWOzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 10:55:53 -0400
Received: from mail-eopbgr40074.outbound.protection.outlook.com ([40.107.4.74]:33959
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731863AbfHWOzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 10:55:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7Ra3XcwfQP+XPAWxOmCopzW5Fmu5XI7/nPYdCRjV5AxkslJETBno274wTiPee+YpA0h7eUbfqF2iu35Mtx34DC9RI+izeQh++I6KtxcEcV0p+Wd5/MBkSAk94rMTkufVhBzEpKMlwEWL7CF5x7R37ejEPUSwQCOORca+l5n4NUI3heBXtjD7YKTb1H6Jgk+B75GTWtuvKMr5vLlomGoAOqzvdoMqD8IFaJnjvBgEqgknEAE4SK4V5GCnlzVnC73VBC02hvnPnUltl+mT3MRQc8B1943IAgKPDLJ2MAMjmYxAPvj9vVFgEvrJXnDCVw/v0G87hidmmwmESyoDbmTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM2YGIH1b0yAhKDVbUyg2+K6/XvCj6yRkV6iXZp5+bY=;
 b=V7GTbIMzornvr+tnWIR5ZXc0+aSv52m2W0cze+1ZY6fFE+lrUSl9UKUidikx+XFrMvR2yvEOPLPhaTLYRYwrmfOxVj2qoTDiLZFK1w918r5UR5Qrm9EPY87aXKvbYkZkCYcnngXJvz5oyQ0ZOieLIFyuFDyt1XIYXizJ2a3ARsesaCBnK9zAWyt/kIHsixV2S5/ALAl1cjAnppXk+ztlqrlrw+2azKjYZd5WebABHf4ARbcWXXn7FshP8N+c71yihgrneSxEyL9jz/ZOFosYiHbJmufh8I/LcJ++oKOpuT/rT04eYMnwnT/ySQ3L4dQN8ou1CXFgWjbAr2oEGbGG+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=itdev.co.uk; dmarc=pass action=none header.from=itdev.co.uk;
 dkim=pass header.d=itdev.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector2-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM2YGIH1b0yAhKDVbUyg2+K6/XvCj6yRkV6iXZp5+bY=;
 b=iFfMTo5wtQUFIAns9krxSZLLFLjV0vKmA3qIbbkIYqR7mS3WyY0QHMHGl2XNo5LAbC+ETHpS2pDBtQ3wP6a2al1LXN4ZbqrjOfcwVSiEDmCnVTr4mg2/l5+6gSPl96M5X7G/raLHqlAio/z5pJxW0U02O2GanfOIgbmqiMW2Qng=
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com (52.133.15.143) by
 VI1PR08MB3312.eurprd08.prod.outlook.com (52.134.31.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 14:55:46 +0000
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::586d:db76:56c3:51e5]) by VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::586d:db76:56c3:51e5%6]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 14:55:45 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     Markus Elfring <Markus.Elfring@web.de>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] staging: vt6656: Use common error handling code in
 vnt_alloc_bufs()
Thread-Topic: [PATCH] staging: vt6656: Use common error handling code in
 vnt_alloc_bufs()
Thread-Index: AQHVWbbu5uhEbt5BlEGgbiFaMjR5MKcI0j0A
Date:   Fri, 23 Aug 2019 14:55:45 +0000
Message-ID: <20190823145540.GA2536@qd-ubuntu>
References: <91e8a9b7-e79d-dafc-10b8-dd79eb59eff9@web.de>
In-Reply-To: <91e8a9b7-e79d-dafc-10b8-dd79eb59eff9@web.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0115.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::31) To VI1PR08MB3168.eurprd08.prod.outlook.com
 (2603:10a6:803:47::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.21.227.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b620ed57-c342-4be7-77c1-08d727d9f9c3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR08MB3312;
x-ms-traffictypediagnostic: VI1PR08MB3312:
x-microsoft-antispam-prvs: <VI1PR08MB3312B05DE8302ADE51437EE7B3A40@VI1PR08MB3312.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39830400003)(136003)(346002)(396003)(376002)(366004)(199004)(189003)(66066001)(53936002)(25786009)(1076003)(316002)(14454004)(6436002)(44832011)(6506007)(6486002)(386003)(4326008)(6246003)(6916009)(66946007)(446003)(26005)(11346002)(476003)(66446008)(64756008)(66556008)(66476007)(54906003)(186003)(2906002)(9686003)(99286004)(52116002)(508600001)(486006)(305945005)(71190400001)(71200400001)(229853002)(256004)(33656002)(8676002)(102836004)(5660300002)(3846002)(81166006)(81156014)(8936002)(6116002)(6512007)(76176011)(33716001)(7736002)(86362001)(334744003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3312;H:VI1PR08MB3168.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: avT6Jw14HzHdd+QQwU4fYd5nGDfM2ifyBtNA4RsVVYR35lus53wOnDviltvxQJ9gnz7AyNA8xMFy6V8VLoqjh4bF4RywcDs+u4n0NTvFp5QCY6evHqeZhG5o0IcR2MgHQW9Xeh8Y6kIp0+gNlV55npB5IkiXon+o4va1aQksVqNMe2YhR0mscOlE3oFws99kzCmTQz4Tzw1uBtLKmb3pVd1Uh20snH0tkeeDaf0gnSR2MNsyK/2FXCKj4FQql7QK+cPeKcNHp77YAs2AWl24cnU7H1bVBIr2jblhp+1WCsruihJBSkEh+pbnn0HaBiMpm1E6ztsMSjADmqdkXXsB1Bu/j9Kfg1q0t9FuWYVClsJa8utQJ4Xxf4dbjD8ogaTctcpDAB/WYiSfXLuNE+GXdbVbQmc+h1SnXp5HOBgl9BQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F80DB4D0BA6D474C82A0EFABD86EB8BA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: b620ed57-c342-4be7-77c1-08d727d9f9c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 14:55:45.8801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0eCCJJ4ZdgJXXr/JVaG55QP2ae8zz59p3LN+sj0LvS9ZAKUGyDARrgXvZUUH69nthmOnf7Le6FvipPg5eJH0KrvKABuFsEn61oK+Tmr3uIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3312
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 03:30:11PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 23 Aug 2019 15:15:41 +0200
>=20
> Adjust jump targets so that a bit of exception handling can be better
> reused at the end of this function.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/staging/vt6656/main_usb.c | 46 +++++++++++++------------------
>  1 file changed, 19 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/m=
ain_usb.c
> index 856ba97aec4f..d9f14da37bbc 100644
> --- a/drivers/staging/vt6656/main_usb.c
> +++ b/drivers/staging/vt6656/main_usb.c
> @@ -443,10 +443,8 @@ static int vnt_alloc_bufs(struct vnt_private *priv)
>=20
>  	for (ii =3D 0; ii < priv->num_tx_context; ii++) {
>  		tx_context =3D kmalloc(sizeof(*tx_context), GFP_KERNEL);
> -		if (!tx_context) {
> -			ret =3D -ENOMEM;
> -			goto free_tx;
> -		}
> +		if (!tx_context)
> +			goto e_nomem_tx;
>=20
>  		priv->tx_context[ii] =3D tx_context;
>  		tx_context->priv =3D priv;
> @@ -454,20 +452,16 @@ static int vnt_alloc_bufs(struct vnt_private *priv)
>=20
>  		/* allocate URBs */
>  		tx_context->urb =3D usb_alloc_urb(0, GFP_KERNEL);
> -		if (!tx_context->urb) {
> -			ret =3D -ENOMEM;
> -			goto free_tx;
> -		}
> +		if (!tx_context->urb)
> +			goto e_nomem_tx;
>=20
>  		tx_context->in_use =3D false;
>  	}
>=20
>  	for (ii =3D 0; ii < priv->num_rcb; ii++) {
>  		priv->rcb[ii] =3D kzalloc(sizeof(*priv->rcb[ii]), GFP_KERNEL);
> -		if (!priv->rcb[ii]) {
> -			ret =3D -ENOMEM;
> -			goto free_rx_tx;
> -		}
> +		if (!priv->rcb[ii])
> +			goto e_nomem_rx;
>=20
>  		rcb =3D priv->rcb[ii];
>=20
> @@ -475,16 +469,12 @@ static int vnt_alloc_bufs(struct vnt_private *priv)
>=20
>  		/* allocate URBs */
>  		rcb->urb =3D usb_alloc_urb(0, GFP_KERNEL);
> -		if (!rcb->urb) {
> -			ret =3D -ENOMEM;
> -			goto free_rx_tx;
> -		}
> +		if (!rcb->urb)
> +			goto e_nomem_rx;
>=20
>  		rcb->skb =3D dev_alloc_skb(priv->rx_buf_sz);
> -		if (!rcb->skb) {
> -			ret =3D -ENOMEM;
> -			goto free_rx_tx;
> -		}
> +		if (!rcb->skb)
> +			goto e_nomem_rx;
>=20
>  		rcb->in_use =3D false;
>=20
> @@ -495,21 +485,23 @@ static int vnt_alloc_bufs(struct vnt_private *priv)
>  	}
>=20
>  	priv->interrupt_urb =3D usb_alloc_urb(0, GFP_KERNEL);
> -	if (!priv->interrupt_urb) {
> -		ret =3D -ENOMEM;
> -		goto free_rx_tx;
> -	}
> +	if (!priv->interrupt_urb)
> +		goto e_nomem_rx;
>=20
>  	priv->int_buf.data_buf =3D kmalloc(MAX_INTERRUPT_SIZE, GFP_KERNEL);
> -	if (!priv->int_buf.data_buf) {
> -		ret =3D -ENOMEM;
> +	if (!priv->int_buf.data_buf)
>  		goto free_rx_tx_urb;
> -	}
>=20
>  	return 0;
>=20
> +e_nomem_tx:
> +	ret =3D -ENOMEM;
> +	goto free_tx;
> +
>  free_rx_tx_urb:
>  	usb_free_urb(priv->interrupt_urb);
> +e_nomem_rx:
> +	ret =3D -ENOMEM;
>  free_rx_tx:
>  	vnt_free_rx_bufs(priv);
>  free_tx:
> --
> 2.23.0
>=20

Your patch remove redundant code, which is fine. However, and IMHO, the
code you changed was simple enough to be understand quickly. I think replac=
ing
it with a crossed goto (even if it remove redundant code) might not be the =
best
option.

A solution might be to move the second loop to the top of the function so
you should be able to replace the end of the cleanup calls with:

enomem:
	ret =3D -ENOMEM;
free_rx:
	vnt_free_rx_bufs(priv);
	return ret;

This way, only a failed call to vnt_submit_rx_urb() should jump to
free_rx, another failed call should jump to enomem or previously defined
label, so we can correctly forward errors. With such solution it might
be worth adding a comment to describe that all error should be ENOMEM
except for vnt_submit_rx_urb(). Does that looks good to you?

Regards,
Quentin
