Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E0FC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE2D20675
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RnC5wvFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbfDYBuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:50:24 -0400
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:2033
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388113AbfDYBuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 21:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvRGGczhBv9R/JuNzvYp8+4j7dyKqVApPNSTY3OpvdY=;
 b=RnC5wvFfxcFul91dFf6F+czvzteajMxDNOHENXb164WEOEBFAeNSPEKvor8PSUuA0IUtBX/hK1VIt5VSxm2cUg+H4mwZkluko8Z+aVxLaWjxrk8FCW9C5gKP9Jj9X72unOHxspyQ6gLKgomnafTHy3rSuElL/o1A6olu2h2ykBI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3801.eurprd04.prod.outlook.com (52.134.65.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Thu, 25 Apr 2019 01:49:39 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 01:49:39 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [RESEND] input: keyboard: imx: make sure keyboard can always wake
 up system
Thread-Topic: [RESEND] input: keyboard: imx: make sure keyboard can always
 wake up system
Thread-Index: AQHU6odaZd/8EWsin0yXXO1zjKS4q6ZMPHMg
Date:   Thu, 25 Apr 2019 01:49:39 +0000
Message-ID: <DB3PR0402MB39167BC7D996F4FF70B5DD2FF53D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1554341727-16084-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554341727-16084-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f5bbced-a2c6-4731-f26d-08d6c9204795
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3801;
x-ms-traffictypediagnostic: DB3PR0402MB3801:
x-microsoft-antispam-prvs: <DB3PR0402MB38013559C6964056E3CB2CF1F53D0@DB3PR0402MB3801.eurprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(13464003)(478600001)(53936002)(55016002)(4326008)(76116006)(11346002)(9686003)(2906002)(316002)(99286004)(25786009)(44832011)(476003)(33656002)(486006)(110136005)(68736007)(14454004)(6246003)(2501003)(66476007)(73956011)(66066001)(229853002)(97736004)(7696005)(6436002)(64756008)(66446008)(66556008)(66946007)(305945005)(7736002)(86362001)(71190400001)(52536014)(74316002)(71200400001)(26005)(6506007)(5660300002)(446003)(2201001)(256004)(14444005)(6116002)(3846002)(81156014)(8676002)(81166006)(8936002)(76176011)(53546011)(186003)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3801;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gxrG07kf+ZdehCurIMdDjYpS6vPP88NKy0lQmfajTIcw9//MseFT+iXcVfHAzt5HgjYZuTEw8A9dZYeoorrjfflicfbc84LjYotKsMx2XQeMW4QDgop4q2hbxfvteRuRDIdM7OtSG6ygwyLIy+e3UOZDUd2DPzVvQy4L7VQLMt3q1l7f8ZhuvwEcCmOQnf17nonflDsyBhz+9C2RJPJKqYL1Qgzpr/1/1fqitb37HqM685jJmb2iLl29iAiBqfy7lDAXPqQqsZ5xWhPpMaUcm1hFqwMZCzNovsq1YHXpIc4CcBnI14iRfvHn/pRuZM0F86S/ogyNO60kK5dKO86WU9po55elIvU4PyASM6NCWkrbDplxekITA2d70OGBGg5rCSeWFFUMpmQkxnDZdGC/pXWbytTfKFPLOmeZWbnRcJk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5bbced-a2c6-4731-f26d-08d6c9204795
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 01:49:39.6069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3801
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping...

> -----Original Message-----
> From: Anson Huang
> Sent: Thursday, April 4, 2019 9:40 AM
> To: dmitry.torokhov@gmail.com; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> linux-input@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Cc: dl-linux-imx <linux-imx@nxp.com>
> Subject: [RESEND] input: keyboard: imx: make sure keyboard can always
> wake up system
>=20
> There are several scenarios that keyboard can NOT wake up system from
> suspend, e.g., if a keyboard is depressed between system device suspend
> phase and device noirq suspend phase, the keyboard ISR will be called and
> both keyboard depress and release interrupts will be disabled, then
> keyboard will no longer be able to wake up system. Another scenario would
> be, if a keyboard is kept depressed, and then system goes into suspend, t=
he
> expected behavior would be when keyboard is released, system will be
> waked up, but current implementation can NOT achieve that, because both
> depress and release interrupts are disabled in ISR, and the event check i=
s still
> in progress.
>=20
> To fix these issues, need to make sure keyboard's depress or release
> interrupt is enabled after noirq device suspend phase, this patch moves t=
he
> suspend/resume callback to noirq suspend/resume phase, and enable the
> corresponding interrupt according to current keyboard status.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/input/keyboard/imx_keypad.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/imx_keypad.c
> b/drivers/input/keyboard/imx_keypad.c
> index cf08f4a..97500a2 100644
> --- a/drivers/input/keyboard/imx_keypad.c
> +++ b/drivers/input/keyboard/imx_keypad.c
> @@ -524,11 +524,12 @@ static int imx_keypad_probe(struct
> platform_device *pdev)
>  	return 0;
>  }
>=20
> -static int __maybe_unused imx_kbd_suspend(struct device *dev)
> +static int __maybe_unused imx_kbd_noirq_suspend(struct device *dev)
>  {
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	struct imx_keypad *kbd =3D platform_get_drvdata(pdev);
>  	struct input_dev *input_dev =3D kbd->input_dev;
> +	unsigned short reg_val =3D readw(kbd->mmio_base + KPSR);
>=20
>  	/* imx kbd can wake up system even clock is disabled */
>  	mutex_lock(&input_dev->mutex);
> @@ -538,13 +539,20 @@ static int __maybe_unused
> imx_kbd_suspend(struct device *dev)
>=20
>  	mutex_unlock(&input_dev->mutex);
>=20
> -	if (device_may_wakeup(&pdev->dev))
> +	if (device_may_wakeup(&pdev->dev)) {
> +		if (reg_val & KBD_STAT_KPKD)
> +			reg_val |=3D KBD_STAT_KRIE;
> +		if (reg_val & KBD_STAT_KPKR)
> +			reg_val |=3D KBD_STAT_KDIE;
> +		writew(reg_val, kbd->mmio_base + KPSR);
> +
>  		enable_irq_wake(kbd->irq);
> +	}
>=20
>  	return 0;
>  }
>=20
> -static int __maybe_unused imx_kbd_resume(struct device *dev)
> +static int __maybe_unused imx_kbd_noirq_resume(struct device *dev)
>  {
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	struct imx_keypad *kbd =3D platform_get_drvdata(pdev); @@ -568,7
> +576,9 @@ static int __maybe_unused imx_kbd_resume(struct device *dev)
>  	return ret;
>  }
>=20
> -static SIMPLE_DEV_PM_OPS(imx_kbd_pm_ops, imx_kbd_suspend,
> imx_kbd_resume);
> +static const struct dev_pm_ops imx_kbd_pm_ops =3D {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_kbd_noirq_suspend,
> +imx_kbd_noirq_resume) };
>=20
>  static struct platform_driver imx_keypad_driver =3D {
>  	.driver		=3D {
> --
> 2.7.4

