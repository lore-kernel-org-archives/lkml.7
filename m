Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6807EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2464221881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TEk9ISn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfH0Jfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:35:54 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:26074 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfH0Jfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:35:54 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d64f8450000>; Tue, 27 Aug 2019 17:30:47 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 27 Aug 2019 02:30:47 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 27 Aug 2019 02:30:47 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 09:30:45 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.53) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 27 Aug 2019 09:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8dXiOIPhT4jf7IgyxXf+YGsVj0KtgUL5B9P3fmc2iLg2XERmn5+0OSF+sYfnwsjpLiOk25du0CMkxcxb7Pjde3a8KjKDpHfW+atIDIs2iut5l8c0k8Wph+azflbek1SYRD3zxBiGsZSy9PJnuzMQ0KnBX5LHQuNBSPNXhNeeZO/7fzmBI2iVoI+7fYV8854Hv5BtQLsbIl48LZevhpGRpGACP3WNKldwirUaakMhxULu/LUeZfQ7hfk6jSA07ffBhHOS5vy25xRLP/cYZNVyCBhigsxR5hpRk5oy2LejWTAzIkCr9jN/HSWWJulsfnBpk5Lh7H6mK/mK83YwKFdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Coa6BnCJJ3WvwmtgvRB0/AfluLl7Ijigb/xCWcjHFXs=;
 b=n3VwjUIUmTH3cEjIQmvbPVVtVTUOg4a/5RVAs83BWuFkfOR7TjXNSTsKp9WUK8cUHq+WcnIQoEQ7z9tN7G9x3QAlcP6/UoTRmzlBVMgpuNVnnl3fNcxd4qW5YoXPle1S4mhbTDuGRQdFtkYMFqcytUL63Cjf9PJ/d/xMDgvX42w3LeS6NsRZl7K8aVMjSDqyLEDLpwf5Wjp3xN0R6okvlq1Nb07lW+NuVQBDEpnrkH2shqxl60EeScntULuGYpjui5OC28TdR0n9GfP+T9Ed+ObslmhQ+mLu+sQvt79mXlMcKgbSPqNJko/F9feE7baaVGS7CMjvgkOw5DPzIuDT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from SN6PR12MB2734.namprd12.prod.outlook.com (52.135.107.25) by
 SN6PR12MB2831.namprd12.prod.outlook.com (20.177.251.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 09:30:42 +0000
Received: from SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::fdaf:cdfc:c0da:f84b]) by SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::fdaf:cdfc:c0da:f84b%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 09:30:42 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Laxman Dewangan" <ldewangan@nvidia.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shardar Mohammed" <smohammed@nvidia.com>
Subject: RE: [PATCH 09/14] serial: tegra: set maximum num of uart ports to 8
Thread-Topic: [PATCH 09/14] serial: tegra: set maximum num of uart ports to 8
Thread-Index: AQHVUQExUyznRTz+t0+oKzAcdhhF3ab430uAgBXuDxA=
Date:   Tue, 27 Aug 2019 09:30:42 +0000
Message-ID: <SN6PR12MB273486EC7A958CFA427C0B37C3A00@SN6PR12MB2734.namprd12.prod.outlook.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-10-git-send-email-kyarlagadda@nvidia.com>
 <20190813101955.GN1137@ulmo>
In-Reply-To: <20190813101955.GN1137@ulmo>
Accept-Language: en-IN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=kyarlagadda@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-08-27T09:30:40.6864833Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=bd6e89c5-a2ab-4a7f-9655-461699ad7276;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kyarlagadda@nvidia.com; 
x-originating-ip: [115.114.118.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce5098ae-d3cb-4303-761f-08d72ad13b65
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2831;
x-ms-traffictypediagnostic: SN6PR12MB2831:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB28317B1B468649DEC3BB532FC3A00@SN6PR12MB2831.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(39850400004)(136003)(199004)(189003)(13464003)(486006)(86362001)(55016002)(76116006)(66476007)(66556008)(64756008)(66446008)(26005)(186003)(66946007)(229853002)(66066001)(478600001)(54906003)(81156014)(81166006)(8676002)(8936002)(102836004)(71200400001)(53546011)(7736002)(3846002)(14454004)(6116002)(305945005)(74316002)(71190400001)(25786009)(52536014)(4326008)(446003)(5660300002)(11346002)(6246003)(55236004)(107886003)(76176011)(6916009)(316002)(256004)(9686003)(2906002)(476003)(53936002)(7696005)(6436002)(99286004)(6506007)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2831;H:SN6PR12MB2734.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sjR19ME2SKGEgYPDpK+crDIWqb63l4ZKYH4PBiRSBv3Hp4PyE/9ilyrbhHtpLc1SiVekHL3Fhct+b7aUOEFkdi1HcF7BsuTKwJHVVrqVvJj6zU9plRyrACfkGsfy/yYPEudJXILHUoJ9zjr+GUdpTBi9UkrdulqxQuB0AP3b72oMVLGI4Jj+GKgCCiYBluWWgjkeYhy39oLST7Y8aH1zw0gU6SscgQmGduWqoFbJ58q3EIvBx6wh2PdMFK8WfYzlRhz1CIJ7g1D+WwYhkqPeWKqDLLW3nBtykRBx81C0M6ogA4XvitLknk1l/ziCy5tpv9l06IyFnvEJ9jvdwEdIGLF5iAJnzvHNkjQktpEMgKn3ZpESvHPSY5uAcHVtKtyq4wcHayqn1AgL3JUACVv1OSLtnAATOok3i8ouzw1MfHY=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5098ae-d3cb-4303-761f-08d72ad13b65
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 09:30:42.7911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yUnKA/0g4bCzBGuFdq6JKAa3X7GgA7RpCwohemYUQfrAsGIkjOhd+Oa0QZbv8AspUF3/uBOUWu2vfBHuVBrjNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2831
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566898247; bh=Coa6BnCJJ3WvwmtgvRB0/AfluLl7Ijigb/xCWcjHFXs=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=TEk9ISn7s6v1HcVEae6bsUPwfJYepZSXu6CT9xF2ADuYP/HmhlqQNODZtuTDB7+wj
         UIDLzssB12ygvoW//CyZdvpvfh2wONFmBF0kDN8T+OgUjTIAKOi1ZsvT/oWWjzoblH
         ToxxAppCsk4nVZQ45SB/efLYuLfC/ShGexTXpUh4fa92hm4pvlGx+T5sE7fgT2ei2h
         FpSLGz/SzR/MJHxFlZeIcxNU5I/b1X9TkAwXHa9YZFXBoghY3qqUOwvG0WHLH6t+sx
         x4XsQC0p5cRMlMPqcF7oIzJz/Hu0qi5/Y6WakfvfaAM6gRZ6y36tZBOTRtYHdbO3Ir
         Sus5AHQROCyRw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: Tuesday, August 13, 2019 3:50 PM
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;=20
> mark.rutland@arm.com; Jonathan Hunter <jonathanh@nvidia.com>; Laxman=20
> Dewangan <ldewangan@nvidia.com>; jslaby@suse.com; linux-=20
> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-=20
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Shardar Mohammed=20
> <smohammed@nvidia.com>
> Subject: Re: [PATCH 09/14] serial: tegra: set maximum num of uart=20
> ports to 8
>=20
> On Mon, Aug 12, 2019 at 04:58:18PM +0530, Krishna Yarlagadda wrote:
> > From: Shardar Shariff Md <smohammed@nvidia.com>
> >
> > Set maximum number of UART ports to 8 as older chips have 7 ports=20
> > and
> > Tergra194 and later chips will have 8 ports. Add this info to chip=20
> > data and register uart driver in platform driver probe.
> >
> > Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  drivers/tty/serial/serial-tegra.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/tty/serial/serial-tegra.c
> > b/drivers/tty/serial/serial-tegra.c
> > index e0379d9..329923c 100644
> > --- a/drivers/tty/serial/serial-tegra.c
> > +++ b/drivers/tty/serial/serial-tegra.c
> > @@ -62,7 +62,7 @@
> >  #define TEGRA_UART_TX_TRIG_4B			0x20
> >  #define TEGRA_UART_TX_TRIG_1B			0x30
> >
> > -#define TEGRA_UART_MAXIMUM			5
> > +#define TEGRA_UART_MAXIMUM			8
> >
> >  /* Default UART setting when started: 115200 no parity, stop, 8 data b=
its */
> >  #define TEGRA_UART_DEFAULT_BAUD			115200
> > @@ -87,6 +87,7 @@ struct tegra_uart_chip_data {
> >  	bool	allow_txfifo_reset_fifo_mode;
> >  	bool	support_clk_src_div;
> >  	bool	fifo_mode_enable_status;
> > +	int	uart_max_port;
> >  };
> >
> >  struct tegra_uart_port {
> > @@ -1323,6 +1324,7 @@ static struct tegra_uart_chip_data
> tegra20_uart_chip_data =3D {
> >  	.allow_txfifo_reset_fifo_mode	=3D true,
> >  	.support_clk_src_div		=3D false,
> >  	.fifo_mode_enable_status	=3D false,
> > +	.uart_max_port			=3D 5,
> >  };
> >
> >  static struct tegra_uart_chip_data tegra30_uart_chip_data =3D { @@
> > -1330,6 +1332,7 @@ static struct tegra_uart_chip_data
> tegra30_uart_chip_data =3D {
> >  	.allow_txfifo_reset_fifo_mode	=3D false,
> >  	.support_clk_src_div		=3D true,
> >  	.fifo_mode_enable_status	=3D false,
> > +	.uart_max_port			=3D 5,
> >  };
> >
> >  static struct tegra_uart_chip_data tegra186_uart_chip_data =3D { @@
> > -1337,6 +1340,7 @@ static struct tegra_uart_chip_data
> tegra186_uart_chip_data =3D {
> >  	.allow_txfifo_reset_fifo_mode	=3D false,
> >  	.support_clk_src_div		=3D true,
> >  	.fifo_mode_enable_status	=3D true,
> > +	.uart_max_port			=3D 5,
>=20
> You say in the commit message that the older chips have 7 ports, but=20
> here you say they have 5. Which one is it?
>=20
> >  };
> >
> >  static const struct of_device_id tegra_uart_of_match[] =3D { @@=20
> > -1386,6
> > +1390,7 @@ static int tegra_uart_probe(struct platform_device *pdev)
> >  	u->type =3D PORT_TEGRA;
> >  	u->fifosize =3D 32;
> >  	tup->cdata =3D cdata;
> > +	tegra_uart_driver.nr =3D cdata->uart_max_port;
> >
> >  	platform_set_drvdata(pdev, tup);
> >  	resource =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@
> > -1411,6 +1416,13 @@ static int tegra_uart_probe(struct=20
> > platform_device
> *pdev)
> >  		return PTR_ERR(tup->rst);
> >  	}
> >
> > +	ret =3D uart_register_driver(&tegra_uart_driver);
> > +	if (ret < 0) {
> > +		pr_err("Could not register %s driver\n",
> > +		       tegra_uart_driver.driver_name);
> > +		return ret;
> > +	}
>=20
> I don't think this is the right place for this. You're going to try to=20
> register the driver once for each instance of the Tegra UART that will be=
 probed.
>=20
> I'm surprised that this works at all because there's a BUG_ON() early=20
> in
> uart_register_driver() that checks for the existence of drv->state,=20
> which means that the second instance of tegra_uart_probe() should=20
> trigger that and cause the kernel to crash.
>=20
> I think it's better to either create an additional of_device_id table=20
> that is used to match on the top-level node's compatible string and=20
> which only contains the maximum number of ports for the given SoC, or=20
> you could add code to
> tegra_uart_init() that counts the number of ports that do match and=20
> initialize tegra_uart_driver.nr using that number. It would something lik=
e this:
>=20
> 	unsigned int count =3D 0;
>=20
> 	for_each_matching_node(np, &tegra_uart_of_match)
> 		count++;
>=20
> 	tegra_uart_driver.nr =3D count;
>=20
> You could also add additional checks in the loop, perhaps something
> like:
>=20
> 	for_each_matching_node(np, &tegra_uart_of_match)
> 		if (of_device_is_available(np))
> 			count++
>=20
> Though that would prevent any UARTs from getting added via dynamic=20
> device tree manipulation.
>=20
> Thierry
>=20
Multiple port entries does result in failures which I missed. I will fix th=
is
as suggested.
KY
> > +
> >  	u->iotype =3D UPIO_MEM32;
> >  	ret =3D platform_get_irq(pdev, 0);
> >  	if (ret < 0) {
> > @@ -1472,13 +1484,6 @@ static int __init tegra_uart_init(void)  {
> >  	int ret;
> >
> > -	ret =3D uart_register_driver(&tegra_uart_driver);
> > -	if (ret < 0) {
> > -		pr_err("Could not register %s driver\n",
> > -			tegra_uart_driver.driver_name);
> > -		return ret;
> > -	}
> > -
> >  	ret =3D platform_driver_register(&tegra_uart_platform_driver);
> >  	if (ret < 0) {
> >  		pr_err("Uart platform driver register failed, e =3D %d\n", ret);
> > --
> > 2.7.4
> >
