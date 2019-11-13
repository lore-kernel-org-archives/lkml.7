Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432F4C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 06:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C15222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 06:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YXDTsRA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfKMGcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 01:32:02 -0500
Received: from mail-eopbgr00074.outbound.protection.outlook.com ([40.107.0.74]:49479
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbfKMGcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 01:32:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TldWNxQcW02NydTMtqFpfj/3+/cX72h3qIW+ycbZUQ30sqILBKwTnvPri8quM2pWI30G6w/Bkmuz8RrFaCg8m2ptq2dhTtWtAl442DfBjlmh4V7C6+3/clwJBDsAR2mW0+JC3I/QZAf5PLXPATrk2hA1ZxuZFeEwtn6ltdMtFi3sddkl0OQTAfl5f5m2mb7iTaT2PWZk/8RS0490oXKy67G2BM+HbqzZk9kySmOybUcKfsrOM2PcJtC5NWFKAXqQKdWtTsFlnFPsLs//v8CmhdYxufT+nrAVt+zlytVpECflZFOaED3Azxcw2yYMerkewDWDxINg8BclnaFBKj/riA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkXQl1iMrAdZslXPvn4N2pMZSSYVfopXDfEg3ObCP7w=;
 b=gDmUC6CpJAp8xRrEQgK6ysOlGHOvVNobUizK2SHt1ap4O6DkYHytPIiF6XvWEC2Ud/chVGsvPH9dH6ASnJ0jUkcVsU0HUi9nJqdKQelTA8cM7Z5HRV/e45X4Q1pBBQ7kcgChb3RyYEJx4CYK9dBWOmry/yI03s4hMwG1HKEOZyu4O+e5KRJ+nZY+cHUXCMs/YXaltN9l5OhrGMNiDytLBatci4DBcXyOlmVS5PnkS/XoETf3swRB6Fvt65ww4I1QQ71wwebNPi4C0hT86CeaYxqQWBkVeFJwHKkpTyfky6gdwEllRUsGRb7WACSOAzTOeCDgMt7wAXZ0Op1mgeH89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkXQl1iMrAdZslXPvn4N2pMZSSYVfopXDfEg3ObCP7w=;
 b=YXDTsRA2Bj334oVMZeKdYreoDTysg8F6YnVRnbgf2HFxBUG1L7aLB81mfp2oX6+aPUzdjPYjcsFTCY87d66GzipKuqbHldV6yBv/r8dWWQlDrLGtai5G6z3OkWZKa3lH9gylcYhOqdUUUwONhU33o3YbHlq0eWu7uNfS5f4NMnI=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB5037.eurprd04.prod.outlook.com (20.177.49.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Wed, 13 Nov 2019 06:31:56 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 06:31:56 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Michael Olbrich <m.olbrich@pengutronix.de>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: composite: split spinlock to avoid recursion
Thread-Topic: [PATCH] usb: gadget: composite: split spinlock to avoid
 recursion
Thread-Index: AQHVmTxEIjD1nt2RjUO3vLFSiYOzzqeIpkIA
Date:   Wed, 13 Nov 2019 06:31:55 +0000
Message-ID: <20191113063414.GA30608@b29397-desktop>
References: <20191112093318.12936-1-m.olbrich@pengutronix.de>
In-Reply-To: <20191112093318.12936-1-m.olbrich@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5a53291-8d9d-4cef-d046-08d768032e07
x-ms-traffictypediagnostic: VI1PR04MB5037:
x-microsoft-antispam-prvs: <VI1PR04MB5037653D0B57DCF78BF6EBBF8B760@VI1PR04MB5037.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(256004)(6246003)(76116006)(66446008)(1076003)(99286004)(66476007)(64756008)(9686003)(66556008)(91956017)(6916009)(4326008)(6506007)(53546011)(54906003)(316002)(26005)(66946007)(14444005)(186003)(6512007)(102836004)(5660300002)(6436002)(66066001)(71200400001)(71190400001)(478600001)(6116002)(3846002)(25786009)(7736002)(6486002)(44832011)(76176011)(2906002)(229853002)(8936002)(33656002)(11346002)(446003)(476003)(305945005)(8676002)(81166006)(486006)(81156014)(86362001)(14454004)(33716001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5037;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 46BtI0Cg9f9h3E7lg/5OaZTFzvrg81e8KiHd2AxU/nrqBHMEbflB80Hqk5S96Pjpxg+NVD9MgsevxEEc3DZbQyOlGKRnCTLXPyub1aFevUusvVlO3tkTNz5GApFvEmHkyWemQx6V6vjgMrK1VcVX+uGBcuTFEpNIxQt4o5h3K2ylE4UgktrJlvGVjKmKGvz5J7zHubMYQ/+/BglA9vgF8cHAM27ZJwm8tkUCaLgnDll2uAMgJXaw1VI8I2EewQ/XZ0gypb2NYGHNz1LO2l2K1/oCNvUaCZccgyNtC0/l9NfHftqu9A7XYoruRUjSwtmtb5fksBZGaT4xFMYXjiYTdEgQV7Erl5fUoio2PhExHJAjMoz6cxh8wuSl8Q4a3Frbg8m+VO/S2IowJ/v+EBiKLUXRW8W6lKwD2/RmzyqsZ0bEDCW14S01VQXTSV2xugKM
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F27BA1A301D1514CAFC165B036B58A9C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a53291-8d9d-4cef-d046-08d768032e07
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 06:31:55.8551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZ4xCZlp7A+8+ubCjMuEqjTo6qnZUdbHD2HyFWykQy7ogD1FqM8WctEfH6LTQCHbmZ4BtLAsF+ajDQVyFSUARg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-12 10:33:18, Michael Olbrich wrote:
> 'delayed_status' and 'deactivations' are used completely independent but
> they share the same spinlock. This can result in spinlock recursion:
>=20
> BUG: spinlock recursion on CPU#1, uvc-gadget/322
>  lock: 0xffffffc0570364e0, .magic: dead4ead, .owner: uvc-gadget/322, .own=
er_cpu: 1
> CPU: 1 PID: 322 Comm: uvc-gadget Tainted: G         C O      5.3.0-201909=
16-1+ #55
> Hardware name: XXXXX (DT)
> Call trace:
>  dump_backtrace+0x0/0x178
>  show_stack+0x24/0x30
>  dump_stack+0xc0/0x104
>  spin_dump+0x90/0xa0
>  do_raw_spin_lock+0xd8/0x108
>  _raw_spin_lock_irqsave+0x40/0x50
>  composite_disconnect+0x2c/0x80
>  usb_gadget_disconnect+0x84/0x150
>  usb_gadget_deactivate+0x64/0x120
>  usb_function_deactivate+0x70/0x80
>  uvc_function_disconnect+0x20/0x58
>  uvc_v4l2_release+0x34/0x90
>  v4l2_release+0xbc/0xf0
>  __fput+0xb0/0x218
>  ____fput+0x20/0x30
>  task_work_run+0xa0/0xd0
>  do_notify_resume+0x2f4/0x340
>  work_pending+0x8/0x14
>=20
> Fix this by using separate spinlocks.

This issue may be introduced by 0a55187a1ec8c ("USB: gadget core: Issue
->disconnect() callback from usb_gadget_disconnect()"), which adds
gadget's disconnect at usb_gadget_disconnect. Add Alan, if he is Ok
with your patch, you may cc to stable tree.

>=20
> Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
> ---
>  drivers/usb/gadget/composite.c | 9 +++++----
>  drivers/usb/gadget/configfs.c  | 1 +
>  include/linux/usb/composite.h  | 4 +++-
>  3 files changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composit=
e.c
> index 76883ff4f5bb..35c792e5b408 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -346,14 +346,14 @@ int usb_function_deactivate(struct usb_function *fu=
nction)
>  	unsigned long			flags;
>  	int				status =3D 0;
> =20
> -	spin_lock_irqsave(&cdev->lock, flags);
> +	spin_lock_irqsave(&cdev->deactivations_lock, flags);
> =20
>  	if (cdev->deactivations =3D=3D 0)
>  		status =3D usb_gadget_deactivate(cdev->gadget);
>  	if (status =3D=3D 0)
>  		cdev->deactivations++;
> =20
> -	spin_unlock_irqrestore(&cdev->lock, flags);
> +	spin_unlock_irqrestore(&cdev->deactivations_lock, flags);
>  	return status;
>  }
>  EXPORT_SYMBOL_GPL(usb_function_deactivate);
> @@ -374,7 +374,7 @@ int usb_function_activate(struct usb_function *functi=
on)
>  	unsigned long			flags;
>  	int				status =3D 0;
> =20
> -	spin_lock_irqsave(&cdev->lock, flags);
> +	spin_lock_irqsave(&cdev->deactivations_lock, flags);
> =20
>  	if (WARN_ON(cdev->deactivations =3D=3D 0))
>  		status =3D -EINVAL;
> @@ -384,7 +384,7 @@ int usb_function_activate(struct usb_function *functi=
on)
>  			status =3D usb_gadget_activate(cdev->gadget);
>  	}
> =20
> -	spin_unlock_irqrestore(&cdev->lock, flags);
> +	spin_unlock_irqrestore(&cdev->deactivations_lock, flags);
>  	return status;
>  }
>  EXPORT_SYMBOL_GPL(usb_function_activate);
> @@ -2196,6 +2196,7 @@ static int composite_bind(struct usb_gadget *gadget=
,
>  		return status;
> =20
>  	spin_lock_init(&cdev->lock);
> +	spin_lock_init(&cdev->deactivations_lock);
>  	cdev->gadget =3D gadget;
>  	set_gadget_data(gadget, cdev);
>  	INIT_LIST_HEAD(&cdev->configs);
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.=
c
> index 025129942894..45f717fcdb89 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -521,6 +521,7 @@ static const struct config_item_type gadget_root_type=
 =3D {
>  static void composite_init_dev(struct usb_composite_dev *cdev)
>  {
>  	spin_lock_init(&cdev->lock);
> +	spin_lock_init(&cdev->deactivations_lock);
>  	INIT_LIST_HEAD(&cdev->configs);
>  	INIT_LIST_HEAD(&cdev->gstrings);
>  }
> diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.=
h
> index 8675e145ea8b..86eb6f2c03ac 100644
> --- a/include/linux/usb/composite.h
> +++ b/include/linux/usb/composite.h
> @@ -505,8 +505,10 @@ struct usb_composite_dev {
>  	 */
>  	int				delayed_status;
> =20
> -	/* protects deactivations and delayed_status counts*/
> +	/* protects delayed_status counts*/
>  	spinlock_t			lock;

In fact, this lock is used many places, not only at setup delayed cases.
You may change comments or delete the comments.

> +	/* protects deactivations counts*/

Add one space after 'counts'.

> +	spinlock_t			deactivations_lock;
> =20

--=20

Thanks,
Peter Chen=
