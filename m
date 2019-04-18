Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6070AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E24214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="bq+KNHS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388182AbfDRHOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:14:49 -0400
Received: from mail-eopbgr1410092.outbound.protection.outlook.com ([40.107.141.92]:33760
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730258AbfDRHOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 03:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaesrHr/LWvI7YuH3tKdXyZ7w3JpG/cYs1DdgKiPDqk=;
 b=bq+KNHS2RA0y33hQ/FFPWVHjxMVAz3v32+tM+a3WnbARu6VWFU14QqtrW51MCy3DOgwJjir3W2NKYBLRBnBMF+TH/p54J5Syr/vG6SBis36y/HRtNcSjpIBQG5ZEJ17B881PR0AapBX5DMeECUpf+fDWJmk31vS07RQ3kx7R+Ic=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.242.17) by
 OSBPR01MB3063.jpnprd01.prod.outlook.com (52.134.252.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 07:14:43 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::6d2c:bd11:88b0:c53a]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::6d2c:bd11:88b0:c53a%3]) with mapi id 15.20.1813.011; Thu, 18 Apr 2019
 07:14:43 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "julien.grall@arm.com" <julien.grall@arm.com>,
        "horms@verge.net.au" <horms@verge.net.au>,
        "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: RE: [PATCH] ARM: mach-shmobile: Don't configure ARCH timer if PSCI is
 enabled
Thread-Topic: [PATCH] ARM: mach-shmobile: Don't configure ARCH timer if PSCI
 is enabled
Thread-Index: AQHU9UCJJrXLep/mxUmrfpQDMFE9GKZBf8rw
Date:   Thu, 18 Apr 2019 07:14:43 +0000
Message-ID: <OSBPR01MB21036296606B40DB2FE22CD2B8260@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1555521040-16706-1-git-send-email-olekstysh@gmail.com>
In-Reply-To: <1555521040-16706-1-git-send-email-olekstysh@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a98b62ae-99ca-4826-f040-08d6c3cd87bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:OSBPR01MB3063;
x-ms-traffictypediagnostic: OSBPR01MB3063:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <OSBPR01MB3063D7ADD5ACA503EDBF1464B8260@OSBPR01MB3063.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(366004)(346002)(396003)(43544003)(199004)(189003)(51914003)(446003)(6116002)(966005)(97736004)(33656002)(19627235002)(2501003)(305945005)(52536014)(53936002)(7736002)(11346002)(14444005)(55016002)(14454004)(25786009)(186003)(44832011)(66066001)(256004)(6436002)(5660300002)(102836004)(110136005)(476003)(54906003)(316002)(4326008)(486006)(71190400001)(7696005)(229853002)(26005)(6246003)(81166006)(8676002)(8936002)(99286004)(68736007)(71200400001)(2906002)(478600001)(86362001)(2201001)(6506007)(6306002)(76176011)(3846002)(9686003)(81156014)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB3063;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1RVHE7dPWORMJxzzazbZcfOGGB07FRx9ZEsuqpl+VY24w4zooHgftEwmJfOoMCDOYHUcSpKpOSH9C7VxU7R5LB6RPg8BhbxeUxnmn+X31RtIlaAvNAbcdqHj0AN6t8tspzwGBeOhHWM2g6k2Oiv5zk6Ym/p21g3IG5Fl5lZThjcLP8/ACjKiUnkMfFAyMs4GusJce/SIxNoPDC81icDZjHkLsZD5UiNDRN1bmCxdRgz8cM1C5NqxJnFlaga+XRDeVNxgNXjZSB5X/wjkVlixTM2huv0ZnLPydl8zg5MZCMDU5XcjGTj300DrtFTYpR2tnnm5UtOpDa/L0SbYrWRdzTB7/vrdwh1rSsLyHrGcf327D4yfGi+a2mX3ufUMnSo0ShTdG9cXIGUuBB2l5c/H4CGWgzHgWIlDWquJMmAhXM8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98b62ae-99ca-4826-f040-08d6c3cd87bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 07:14:43.1691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksandr,

Thanks for the patch.

> Subject: [PATCH] ARM: mach-shmobile: Don't configure ARCH timer if PSCI i=
s
> enabled
>=20
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>=20
> If CONFIG_PSCI is enabled then most likely we are running on PSCI-enabled
> U-Boot which, we assume, has already taken care of configuring ARCH timer
> stuff before switching to non-secure mode.
>=20
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>=20
> ---
> A bit of context here...
>=20
> We are highly interested in Renesas "Stout" board support (r8a7790) in Xe=
n
> hypervisor. The reason is to have fully supported HW for performing
> "OSSTEST" (Xen automatic test system) on ARM32.
>=20
> To reach that target we need a "generic way" for the secondary CPU cores
> bring up and switching them to non-secure hyp mode.
> So, the PSCI as a generic well-known way to bring up CPUs, was chosen for
> that purpose.
>=20
> You can find corresponding patches for U-Boot here:
> http://u-boot.10912.n7.nabble.com/PATCH-0-3-PSCI-support-for-r8a7790-
> SoC-Lager-Stout-boards-td357352.html
>=20
> You can find corresponding patches for Xen hypervisor here:
> https://www.mail-archive.com/xen-
> devel@lists.xenproject.org/msg43332.html
>=20
> To sumarize:
> Together with enabling CONFIG_PSCI in shmobile_defconfig, current patch i=
s
> a minimal required change needed to run mainline Linux on top of PSCI-
> enabled U-Boot.
> There is no need to modify device tree. U-Boot will take care of insertin=
g
> proper "enable-method" strings in CPU nodes.
>=20
> ---
>  arch/arm/mach-shmobile/setup-rcar-gen2.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-
> shmobile/setup-rcar-gen2.c
> index eea60b2..bac4490 100644
> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
> @@ -32,7 +32,7 @@ static const struct of_device_id cpg_matches[]
> __initconst =3D {
>  	{ /* sentinel */ }
>  };
>=20
> -static unsigned int __init get_extal_freq(void)
> +static unsigned int __init __maybe_unused get_extal_freq(void)
>  {
>  	const struct of_device_id *match;
>  	struct device_node *cpg, *extal;
> @@ -60,6 +60,12 @@ static unsigned int __init get_extal_freq(void)
>=20
>  void __init rcar_gen2_timer_init(void)
>  {
> +/*
> + * If CONFIG_PSCI is enabled then most likely we are running on
> +PSCI-enabled
> + * U-Boot which, we assume, has already taken care of configuring ARCH
> +timer
> + * stuff before switching to non-secure mode.
> + */
> +#if !defined(CONFIG_ARM_PSCI)
Is it required?  If you see the below comment, it is already taken care
by the below code.

Is your code entering into this block, when booting  the kernel in NS mode?

<snip>
  /*                                                                      =
=20
 87          * Update the timer if it is either not running, or is not at t=
he       =20
 88          * right frequency. The timer is only configurable in secure mo=
de       =20
 89          * so this avoids an abort if the loader started the timer and =
         =20
 90          * entered the kernel in non-secure mode.                      =
         =20
 91          */                                                            =
         =20
 92                                                                        =
         =20
 93         if ((ioread32(base + CNTCR) & 1) =3D=3D 0 ||                   =
             =20
 94             ioread32(base + CNTFID0) !=3D freq) {                      =
           =20
 95                 /* Update registers with correct frequency */          =
         =20
 96                 iowrite32(freq, base + CNTFID0);                       =
         =20
 97                 asm volatile("mcr p15, 0, %0, c14, c0, 0" : : "r" (freq=
));      =20
 98                                                                        =
         =20
 99                 /* make sure arch timer is started by setting bit 0 of =
CNTCR */ =20
100                 iowrite32(1, base + CNTCR);                            =
         =20
101         }    =20


Regards,
Biju

>  	void __iomem *base;
>  	u32 freq;
>=20
> @@ -101,6 +107,7 @@ void __init rcar_gen2_timer_init(void)
>  	}
>=20
>  	iounmap(base);
> +#endif /* #if !defined(CONFIG_ARM_PSCI) */
>=20
>  	of_clk_init(NULL);
>  	timer_probe();
> --
> 2.7.4

