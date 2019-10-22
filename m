Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE2FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DED620882
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cusJZX/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfJVCL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:11:27 -0400
Received: from mail-eopbgr50067.outbound.protection.outlook.com ([40.107.5.67]:50121
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727264AbfJVCL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:11:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h60NX779rnSKX6/cRwG0kRCb7JTx3+SgQSzfblrSnvQv6I1ZpYp9g4QszUJlcLf4kAMp2tfCQcPWzuAXU3nEZ/TU5K1pdC4AvzFwpbdTBdyzJ69Wic0+qE9ec2tGZQOUXWTBNDssh3BDWLm4dYkLKBwNksLuingGCQ7xdVfQZNlb8NOJ2YneURZ2xPMn9ko6Ghs1GGQ9QNWjnjyZMYKWk+xvmU86eaoVAfmFd+nwqiKJE8jmcG8E7JdUPt2HRUd/McYVmhXLa32/O3CU36wDSpuH+6mtvS+setSqv9NQ7j8174eBjVzWhwK4nolgnI9Paw7ULzdzdtsAplKjrXYTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhWBFj4GG/r6NeFcThnj4HJ0/rx61Alv7ojLPC+rrQ4=;
 b=lDaUMxFZDczQqfAz5ya8beiadIpUPxG8fXY6FlmKpJbddkg+8/k6vAW13FJdHI7iOrbsmlZU1uOZv1TadV3cqwsMOrJEe9sAwEa8eAtfRi7UbpgkIVz1PDHsXs4aB7wem7zwWO1QGU9mfA7XNNHJ/p/g0ShrlRP7L7IaFn8OBdqoGWvKBu0NMOV1aOobwT6h9FPIMs/7e3OOcekCbiyryWGmenyS13ENn4qR/XUAsp2npAlq1zPEp2HMFefZ1b1jc/tDYcQKXy6KsGEYD9jm844WABPHI7BZQ8jBacpmtfyOO+hpbEG+wseNO0HEjNDf2pPaXQrEUwFR5wNi9FGvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhWBFj4GG/r6NeFcThnj4HJ0/rx61Alv7ojLPC+rrQ4=;
 b=cusJZX/clHF2pqq9c7lwVz02lEoPdLipzorPNWEBQ8Ihh5YxI4xRUIEHlVta0D8My/03Me2ciy6MfTZc7BY5z68fa9yz4qi5CMpJnYr3bjkZZX1TvattgfqZ738WWqLSC4b2GdvNEIRN2f7EiR2lWVxadHHw8jbxaovN696uxZw=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB6829.eurprd04.prod.outlook.com (52.133.244.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.23; Tue, 22 Oct 2019 02:11:19 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133%3]) with mapi id 15.20.2347.029; Tue, 22 Oct 2019
 02:11:19 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Igor Opaniuk <igor.opaniuk@gmail.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] usb: chipidea: use of extcon framework to work for
 non OTG case
Thread-Topic: [PATCH v1 1/2] usb: chipidea: use of extcon framework to work
 for non OTG case
Thread-Index: AQHViCsAqaE2F5BkzEikzWHSfo+rUadl6qoA
Date:   Tue, 22 Oct 2019 02:11:19 +0000
Message-ID: <20191022020748.GA26973@b29397-desktop>
References: <20191021161654.14353-1-igor.opaniuk@gmail.com>
In-Reply-To: <20191021161654.14353-1-igor.opaniuk@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e250347-f577-4c17-878b-08d7569520c3
x-ms-traffictypediagnostic: VI1PR04MB6829:|VI1PR04MB6829:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VI1PR04MB6829AD6ACF1BE434DD0686018B680@VI1PR04MB6829.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(446003)(7736002)(44832011)(305945005)(8936002)(256004)(66446008)(99286004)(316002)(486006)(7416002)(476003)(76116006)(33716001)(25786009)(11346002)(76176011)(66066001)(66476007)(6436002)(66946007)(64756008)(8676002)(91956017)(54906003)(4326008)(14444005)(66556008)(478600001)(6916009)(71200400001)(33656002)(229853002)(6486002)(86362001)(2906002)(6246003)(5660300002)(1076003)(6512007)(53546011)(81166006)(9686003)(81156014)(6116002)(3846002)(186003)(102836004)(6506007)(14454004)(71190400001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6829;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oS3sRJSwP2GnuLeIU81uCvPuoB5d8TfenSpM+U2cuXJh7hZBOjN/QWLstrD5GX0RbAniCoGZnC9LzeH566mueg06DeBoxM7E5zK4E7Z1QfHguhn5iug9fgV6675OgoLc4kGRd084a5a1BWJt83T0D1hz2w0arxHv9KNSdbKWYMD2p4dD89/pm29vr5IIwiqLb6twTfjW+9/Nz0s+MzI7eA7Z5ekDjmxDgw1lqxYYFF0BT30Ju2PoRtZu6mfj6QppqAZdErJWil87wnI47q+h1Ab4znlL11O3M2Pvtyjs+TDBPfuY1FpITpoi0nzvIYYwgX0DC2Zn/IyMnmaGjHPvU3lIyfvOIsMn3NgoyW0tMrvUQ66Ydmr3FnJUk1k9jqwgDwW54IR05vSQOsF9jX0F9c6FJSgLiDv3I4Z0tbVQCIU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <088447436885784E8770E611C058FD73@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e250347-f577-4c17-878b-08d7569520c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 02:11:19.4513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7W3zP5Nr+AJh6G4eDTMekxhNN6j+4b5+7DZkUE4VvAd/LP1td2FjnwwakOgS5UzhbFHuLKn4y9BYNf7DpZjnnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6829
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-21 19:16:53, Igor Opaniuk wrote:
> From: Stefan Agner <stefan.agner@toradex.com>
>=20
> The existing usage of extcon in chipidea driver freezes the kernel
> presumably due to OTGSC register access.
>=20
> Prevent accessing any OTG registers for SoC with dual role devices
> but no true OTG support. Use the flag CI_HDRC_DUAL_ROLE_NOT_OTG for
> those devices and in case extcon is present, do the role switch
> using extcon only.

Hi Igor & Stefan,

I have several questions about the problem you met:
- Which vendor's controller you have used?
- What do you mean "no true OTG"? Does it mean no "OTGSC" register?

>  	if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_HOST) =
{
>  		ret =3D ci_hdrc_host_init(ci);
> @@ -1145,8 +1208,18 @@ static int ci_hdrc_probe(struct platform_device *p=
dev)
> =20
>  	if (!ci_otg_is_fsm_mode(ci)) {
>  		/* only update vbus status for peripheral */
> -		if (ci->role =3D=3D CI_ROLE_GADGET)
> -			ci_handle_vbus_change(ci);
> +		if (dr_mode =3D=3D USB_DR_MODE_PERIPHERAL) {
> +			usb_gadget_vbus_connect(&ci->gadget);

We only use ci->role at runtime, since it has already considered the
dts setting, kernel configuration and hardware setting.

If your controller doesn't otgsc register, but do need to support
role switch, you may enhance the function ci_get_role

Peter

> +		} else if (ci->role =3D=3D CI_ROLE_GADGET) {
> +			struct ci_hdrc_cable *vbus =3D &ci->platdata->vbus_extcon;
> +
> +			/* Use vbus state from extcon if provided */
> +			if (!IS_ERR(vbus->edev) &&
> +			    extcon_get_state(vbus->edev, EXTCON_USB))
> +				usb_gadget_vbus_connect(&ci->gadget);
> +			else
> +				ci_handle_vbus_change(ci);
> +		}
> =20
>  		ret =3D ci_role_start(ci, ci->role);
>  		if (ret) {
> @@ -1161,10 +1234,6 @@ static int ci_hdrc_probe(struct platform_device *p=
dev)
>  	if (ret)
>  		goto stop;
> =20
> -	ret =3D ci_extcon_register(ci);
> -	if (ret)
> -		goto stop;
> -
>  	if (ci->supports_runtime_pm) {
>  		pm_runtime_set_active(&pdev->dev);
>  		pm_runtime_enable(&pdev->dev);
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=
