Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F95DC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E1920B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="Zv+GPHH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfJIIA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:00:28 -0400
Received: from mail-eopbgr1410122.outbound.protection.outlook.com ([40.107.141.122]:7392
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfJIIA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:00:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJv/RnXXSSlJ5IhOO0/mYG2nGzkucbuwbuIoW8SNLOQwZvboesY2YfSnSlHDdvS0dgA6R347kxs0hpS6/8hRQaxJaKD9QbRWqra5A6SHVyJ1MuVaSLbWHp9zZQlU1Y7NjumV9akWWQLkbeVK1k8SS/A/lRyVYEYWjPh7F81UAOEQTx2/odTLjW8NAvwf78Cygd6g7EqgcsQFv/OSQms4djJ3to05qvw9RHOmUYANk3RE4zAuLTlglj68FCSNKqdj+MMo/u/7PtjXlujwPDDn4CtNV88U5lKOrCdYN3AbiF+5d/98Rw6+iJyn8G2oiTwdLn7BjM5Kb466sY+6B16ARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJHixULULdO8eZ8aXWPtCKXTThNEZY1ijYNhvzqD/JY=;
 b=lic2VlBpUJulTXZJZuaR/R1SwqQp0FtWLPs0SM+pwCMsAe3ftgYsmvRVaNulv9oIKl4pxaB+4DG9RfIKlSbjXu0tzeGtUD8Pzn1ivMOATQ/ITWDVMoxaLtscPcBdKE+1cZPHsQcWOrwh6ucsjYbV5kHwQWlK1X5E9s5AzTS/sT8cjYc3m7Oht3TxPT0hSGfhr0+GkHydxpP8KFJchRcxvnsZ2HF3xkJ5X4VCcn3YCdygl4fa/Qtq2tr9N1jRoIBT5g/BYtF0uDoA940Q63r1IHQBLmwwE3BlAOEDhSkT9MwRjHkL5qWfEm6+p4wlb/w9jEIRHlqDyoO9eVkJJzTELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJHixULULdO8eZ8aXWPtCKXTThNEZY1ijYNhvzqD/JY=;
 b=Zv+GPHH0aCuwiDSbCS6wrqXPPQEjptj6z1WYs7gXk9dK19EUSofny/w4yDZ7G0Op9byyZnHCpTsnMU8AXY6MwHO29HVRrHNEkBWy/gyWJ8YWbvORljJLDzJ06o9nHpwkNHDJmEo8s89O//YZof/ngiCjQWNgPJJ/Y2WywN6v7MI=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.242.17) by
 OSBPR01MB1638.jpnprd01.prod.outlook.com (52.134.227.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.25; Wed, 9 Oct 2019 08:00:23 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::dc33:9b1f:4522:550e]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::dc33:9b1f:4522:550e%3]) with mapi id 15.20.2347.016; Wed, 9 Oct 2019
 08:00:23 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Mao Wenan <maowenan@huawei.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: RE: [PATCH -next] usb: typec: add dependency for TYPEC_HD3SS3220
Thread-Topic: [PATCH -next] usb: typec: add dependency for TYPEC_HD3SS3220
Thread-Index: AQHVfkOKloVrfMGidkOyU5GyOdNjm6dR8ZyQ
Date:   Wed, 9 Oct 2019 08:00:22 +0000
Message-ID: <OSBPR01MB21038DCAFE45CE0FFC06EE91B8950@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <20191009014707.38716-1-maowenan@huawei.com>
In-Reply-To: <20191009014707.38716-1-maowenan@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72e3dddf-8098-4bfa-eedb-08d74c8ebcb6
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: OSBPR01MB1638:
x-microsoft-antispam-prvs: <OSBPR01MB1638F55DF223197C5239B413B8950@OSBPR01MB1638.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(51914003)(189003)(199004)(25786009)(110136005)(11346002)(446003)(26005)(6246003)(74316002)(8676002)(8936002)(14454004)(71190400001)(305945005)(7736002)(71200400001)(44832011)(6436002)(256004)(229853002)(186003)(102836004)(81166006)(81156014)(86362001)(2201001)(498600001)(54906003)(55016002)(5660300002)(76176011)(2501003)(76116006)(9686003)(66066001)(64756008)(4326008)(6506007)(33656002)(486006)(66446008)(66476007)(66556008)(66946007)(476003)(99286004)(7696005)(3846002)(6116002)(52536014)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1638;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TTl29+G9Zw0O/YCvTqksnWgGeZgW05IgKtjwokd8yuvVs/BfqHJAsy0H0AGLo5RXCGmQRHLS0JK9V7Dvac1EBMQpOxan004s6oshvrgTvbit2Ox4TBWhfDL1HKgt704SHYSFE/CYke6X3vW28B5BrGgxZK4ARx+LRF/0uiI6wS01QG176xupdcULNWMX7nK3gMFQWS8w4MrA6M/lvEnjINXeEgEq2qFuNScWRK90aV7ILcHpk7IX2KCs/0O5NARVkgfYZv/sIz8R0dqs8IFoHAJli3kBMEVO0bauBU71FGyNVnqeAHY6RNl+czaQ8/UVp3NlaUXhPSn1y8tTJw9u3W7BL9G4v/X2FlbX1Y3FJchdo7HRknfTgZSGU6ZFO8x0NuYtFmwLg9PC8BFax4zx/bi4lmBfxhnLik4lGSy/MyI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e3dddf-8098-4bfa-eedb-08d74c8ebcb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 08:00:22.9128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z4rN1M1F55uKUOjNOBEmLBWcpNjxgyXZ6MO5lUYaYxCU1WbBiQH5Xm64R8I+RsgxS6TOTR9/xg+sPENtNJqftw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1638
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mao Wenan,

Thanks for the patch.

> Subject: [PATCH -next] usb: typec: add dependency for TYPEC_HD3SS3220
>=20
> If CONFIG_TYPEC_HD3SS3220=3Dy, CONFIG_USB_ROLE_SWITCH=3Dm, below
> errors can be found:
> drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_remove':
> hd3ss3220.c:(.text+0x64): undefined reference to `usb_role_switch_put'
> drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_dr_set':
> hd3ss3220.c:(.text+0x154): undefined reference to
> `usb_role_switch_set_role'
> drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_set_role':
> hd3ss3220.c:(.text+0x294): undefined reference to
> `usb_role_switch_set_role'
> hd3ss3220.c:(.text+0x2f4): undefined reference to
> `usb_role_switch_set_role'
> hd3ss3220.c:(.text+0x348): undefined reference to
> `usb_role_switch_set_role'
> hd3ss3220.c:(.text+0x390): undefined reference to
> `usb_role_switch_set_role'
> drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_probe':
> hd3ss3220.c:(.text+0x5e8): undefined reference to
> `fwnode_usb_role_switch_get'
> hd3ss3220.c:(.text+0x8a4): undefined reference to `usb_role_switch_put'
> make: *** [vmlinux] Error 1
>=20
> This patch add dependency USB_ROLE_SWITCH for TYPEC_HD3SS3220.
>=20
> Fixes: 1c48c759ef4b ("usb: typec: driver for TI HD3SS3220 USB Type-C DRP
> port controller")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>

Reviewed-by: Biju Das <biju.das@bp.renesas.com>

Regards,
Biju
> ---
>  drivers/usb/typec/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig index
> aceb2af..b4f2aac 100644
> --- a/drivers/usb/typec/Kconfig
> +++ b/drivers/usb/typec/Kconfig
> @@ -53,6 +53,7 @@ source "drivers/usb/typec/ucsi/Kconfig"
>  config TYPEC_HD3SS3220
>  	tristate "TI HD3SS3220 Type-C DRP Port controller driver"
>  	depends on I2C
> +	depends on USB_ROLE_SWITCH
>  	help
>  	  Say Y or M here if your system has TI HD3SS3220 Type-C DRP Port
>  	  controller driver.
> --
> 2.7.4

