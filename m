Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE4AC2D0DA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 02:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF1120718
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 02:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q/wVf18d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfL3CZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 21:25:06 -0500
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:38979
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726726AbfL3CZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 21:25:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvQPpELGP9337wYBTWEOxDKKDHlvwmh1h//HzJOkMHbpawFbg5ePwOJppPIG0HTw4G+9rupw7M3kwmR6F7Wxpx59gHwiElBF3lf2pmw1mG7t1FZgoD9qVn8YoGie+utfmTX9BzsTz/tyH+bD5dJuSgp2FR4jOsEK9fvjhQjJrn/nTmtWWT2stcVl+m24E3yP6rj8MLMvqj7EvRbYon/B8RxxwHPyMdLo6egTLzhkdXaAPRTMHoebNSG4mxmanLFcP+s7ud+8zUt3oUIX0BrZgkpieoEdwgJD5lkGx/j5zmHNR5TfOLbReGYvlE1k07SH6LJizrSYxR4S0B5RDkwIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfhh2EOAF8f2TivPWQOHIbZ7P4neJ5grvLsaz+zgjuM=;
 b=j6a6IyHcDohTSrqC5WGUynJE+N9u+O0/Cb5nD9B5UNMBFCGu0fkmgSb+kbXiqY8hZ7xVw+ZXdvmgFKP8FCgcEIq8z5FdmylMirZNBCnQwCGnZ33gSUL3/rvz9LVWy/7hDDRawVBwyVR6ebR/y2+mSRCGFZ/XQFv/frLM8mvVboCZSyJTtg2XXIW3977rv2u6GJoismCVJUfM2TLTcHU6/w6znsM5F0ey+wDeLYscnFTkkoFg2fcahTWerZDIcg3fwB3/5EgYgpH6yn1ErL3lv1anhy5yZXYbLhtfAnIujLmbFHOn9HQuOh91L8sOGLN0hQ2A0KZs2BV4zpoylVx2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfhh2EOAF8f2TivPWQOHIbZ7P4neJ5grvLsaz+zgjuM=;
 b=Q/wVf18d5QlxTeT1+xz8M+209AmwiCUwuEDzt08ghEG2jPJqkzIkC5VLgv6GBVGpaRskWRLIlyXBkPGjyN2it90FZyEvky8FkV+Y15ir8WV/ItKsrN56nIuP6rL9usYZodecTyF5iU31a6TQeQqULOuDUFsgXilYaTkusmtXeWM=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB2975.eurprd04.prod.outlook.com (10.170.228.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Mon, 30 Dec 2019 02:25:02 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e%6]) with mapi id 15.20.2581.007; Mon, 30 Dec 2019
 02:25:01 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 15/16] usb: chipidea: tegra: Add USB_TEGRA_PHY to
 driver's dependencies
Thread-Topic: [PATCH v3 15/16] usb: chipidea: tegra: Add USB_TEGRA_PHY to
 driver's dependencies
Thread-Index: AQHVvb5y5vIp7vVIpkSbyUzjwb7RoafR9S2A
Date:   Mon, 30 Dec 2019 02:25:01 +0000
Message-ID: <20191230022459.GD5283@b29397-desktop>
References: <20191228203358.23490-1-digetx@gmail.com>
 <20191228203358.23490-16-digetx@gmail.com>
In-Reply-To: <20191228203358.23490-16-digetx@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dac6836f-74b9-4e2a-27f4-08d78ccf7970
x-ms-traffictypediagnostic: VI1PR04MB2975:
x-microsoft-antispam-prvs: <VI1PR04MB2975A57BDDCE33D8F6C36A038B270@VI1PR04MB2975.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0267E514F9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(189003)(199004)(71200400001)(86362001)(5660300002)(44832011)(186003)(6486002)(7416002)(54906003)(2906002)(6916009)(4326008)(316002)(6512007)(9686003)(1076003)(33716001)(66556008)(66446008)(8676002)(6506007)(53546011)(91956017)(33656002)(66946007)(81156014)(64756008)(76116006)(81166006)(26005)(66476007)(478600001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB2975;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0+qhb1ztc0PygW1s7kY6LObVReHbHDneRpFYsnGhOhtA62N/gOmwTKfk01HHf7CWG2tvEdc1CWPQ46JjFhTfuwWa0szNl6bm3j9hMxyzww1K0lCNC8f0gUQkOIENZ/5OrJnjFjzxnwZUUf5SiTkWfobX6YAiL9DAOFjHj60u2+cACNGokUgpYdYcJmCydI2Z7Mc2UDFtLAnvuc01rYS4P1ByAUOQDio2NCfBfySlf5N9luKaaJbEAb4oO8qM4V6PpzWPoI60uhfot+oLYlJ/XQp+j62gr4w3ak1lr/9kYNuQR7FpsAb+j+iF321YSvIYcEM1NnzSgMP9wibdsccC5YHbYtkB6dUJd6ih2xWEQHUj3Ir0egZ5YDHNJks9lvL/Oyy8pKkx8ZZBhzT713QZyfKobPf6qhIfWK4K+OeDv4YcRwYCGQ2oBc34VUJBK9zG
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E439EE9989653A4D8683C7AE56AF83FC@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac6836f-74b9-4e2a-27f4-08d78ccf7970
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2019 02:25:01.8407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RM/29Omht+LZbxuUpqbraNYuowkmJyNHAxqNUztxwd4ABa8/mlkLk3+9pZJcAx77Md2kN6Sl6HRVe9yj3D+8wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2975
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-12-28 23:33:57, Dmitry Osipenko wrote:
> Now, when ci_hdrc_tegra kernel module is loaded, the phy_tegra_usb module
> is loaded too regardless of kernel's configuration. Previously this
> problem was masked because Tegra's EHCI driver is usually enabled in
> kernel's config and thus PHY driver was getting loaded because of it, but
> now I was making some more thorough testing and noticed that PHY's module
> isn't getting auto-loaded without the host driver.
>=20
> Note that ChipIdea's driver doesn't use any of the exported functions of
> phy_tegra_usb module and thus the module needs to be requested explicitly=
.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/usb/chipidea/Kconfig         | 1 +
>  drivers/usb/chipidea/ci_hdrc_tegra.c | 6 ++++++
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
> index ae850b3fddf2..d53db520e209 100644
> --- a/drivers/usb/chipidea/Kconfig
> +++ b/drivers/usb/chipidea/Kconfig
> @@ -7,6 +7,7 @@ config USB_CHIPIDEA
>  	select RESET_CONTROLLER
>  	select USB_ULPI_BUS
>  	select USB_ROLE_SWITCH
> +	select USB_TEGRA_PHY if ARCH_TEGRA
>  	help
>  	  Say Y here if your system has a dual role high speed USB
>  	  controller based on ChipIdea silicon IP. It supports:
> diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/=
ci_hdrc_tegra.c
> index 7455df0ede49..8bc11100245d 100644
> --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
> +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
> @@ -53,6 +53,12 @@ static int tegra_udc_probe(struct platform_device *pde=
v)
>  	struct tegra_udc *udc;
>  	int err;
> =20
> +	if (IS_MODULE(CONFIG_USB_TEGRA_PHY)) {
> +		err =3D request_module("phy_tegra_usb");
> +		if (err)
> +			return err;
> +	}
> +
>  	udc =3D devm_kzalloc(&pdev->dev, sizeof(*udc), GFP_KERNEL);
>  	if (!udc)
>  		return -ENOMEM;
> --=20
> 2.24.0
>=20

Acked-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=
