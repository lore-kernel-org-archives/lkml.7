Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D9FC2D0D1
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035CC24676
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WcUnfZW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfLTD46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 22:56:58 -0500
Received: from mail-eopbgr50055.outbound.protection.outlook.com ([40.107.5.55]:18150
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727110AbfLTD45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 22:56:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4fysIfjG/ucgKiZVqO/PJMCfd7mOfNbEmQUZlQILH2orYoUmRjk2Kgc2ULao1d3fszfXE6k2YAxM1mws70SFQc+dxR2tXcy+mJ12RFmoCkA5hTrxcbAWr/qcHqCO2lXfziOoIe4wlgq76MQWpUMHKMlwES1VRc12kEP6+GJjEocZuGzoaAR2iWjMoy9+VJi5YMml64zGVz61VyTMyMJaroEMVQ6ghlNPxoGpv+Yu4vqfuslcXdcaURDjnHJZIIxURbXmdlkCvoxPnGJUfuzNQ/2f32Jo75huQ6JvtAnBY4Jrs8Xm/9+dGTphbPrhSOhz8zhSvpydPLzzRrc4moBXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDTNwrQK1z9XKMuraU36FKTbyrjZnvS44UE5eRNPddE=;
 b=QgbykfUchcqizLqYaRaf/3eLbvNzhJ6THG6yeSs1lAzZQKrA4leMKTXJRsB4beMtd617oT/0KkIA5ad060rk/Qt5tsWjM92Cni4acQqa0rrP6TsG6xc+XyWqZn7NuVqJT6vtgRRzEO8TenzNp3hxzoEsAeFmZCVpr2dnDshvgG8W7bqzM3gX9qmKLSq/T+lN/pqEbOeuTSzyi3GYpQ2bW1aRXBkRGsoB9TsXXTXJtlqnm4J1ZQ8tiDPzFf5NANs7uCsm+AiRc1njF/iDjn9EOUxtSA71qpv2F7QBakpDUURmK9Q+GIeazOVPfssYGVxve7rh6+zYylkOVOc06sz1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDTNwrQK1z9XKMuraU36FKTbyrjZnvS44UE5eRNPddE=;
 b=WcUnfZW7+xvs7iX29LFcnlIRo9TR0HzuYYVWuSDdx6R04iPPEOXERiczFM6CW98BfvR27wjutXmZClsSPpq3J7nGeM3WpuSRFrMEVMyMTmPMLhvnauFmL7qyFWIWjSdF00ji6GTv11lOpRos5hVTuVIbzrypQSVdg2cr5qryiQY=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB5039.eurprd04.prod.outlook.com (20.177.50.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.13; Fri, 20 Dec 2019 03:56:53 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9%7]) with mapi id 15.20.2538.019; Fri, 20 Dec 2019
 03:56:53 +0000
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
Subject: Re: [PATCH v2 10/10] usb: chipidea: tegra: Add USB_TEGRA_PHY module
 to driver's dependencies
Thread-Topic: [PATCH v2 10/10] usb: chipidea: tegra: Add USB_TEGRA_PHY module
 to driver's dependencies
Thread-Index: AQHVttiri4OdXKSsD0CMcioiiuKO06fCZVIA
Date:   Fri, 20 Dec 2019 03:56:52 +0000
Message-ID: <20191220035650.GC19921@b29397-desktop>
References: <20191220015238.9228-1-digetx@gmail.com>
 <20191220015238.9228-11-digetx@gmail.com>
In-Reply-To: <20191220015238.9228-11-digetx@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e793f1e6-3711-4395-d6fc-08d78500a64f
x-ms-traffictypediagnostic: VI1PR04MB5039:
x-microsoft-antispam-prvs: <VI1PR04MB5039DA04944665C758AADF208B2D0@VI1PR04MB5039.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(189003)(199004)(81166006)(81156014)(6486002)(8936002)(5660300002)(8676002)(1076003)(6512007)(9686003)(44832011)(316002)(86362001)(54906003)(7416002)(2906002)(186003)(6506007)(26005)(66446008)(64756008)(66556008)(66946007)(66476007)(4326008)(53546011)(33656002)(33716001)(6916009)(76116006)(91956017)(71200400001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5039;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7jyo8m21i9AYpnHwyPwDgTRYke4sNbi8P9GRu9Eai69RVITarSI9U3qFpdIRUcKx/WNHfRL6ntCgM0DInOT6xDqJ4DWfeLW4tubmu+rmbxNJP3zpIqidlxpn2YgEVjgnFqQO88JdFP6uYzU891euwciiFeR+0ZlYBNRVkF7FWiwYe4/nDKOyfBno0urdFgoFpevzRMjBqPjbP+OTWg1xAoPOos+cHIxQbqtrABuX9JX2+d+2cNpzXv8lqkMihme9mW9ECeWQ88b1MBuTzxkCP0A68pu07oQIwd7PBZv+nhxDLCHiad+pVTdEi4H8zse0FsLXqHaH8FcLVp9qBZKpfbjyqVQO2sIFpQqALl+eVPKgLKNpb7vR4fJkAjObvu+HO+Ym68L7MLuLtNTy6MQoIedwSdzUvFjs/m3j1d4Ki5yFIo0c0tieHBgND5ctwkln
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10203C243BFDC44EAAFA846CC627E487@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e793f1e6-3711-4395-d6fc-08d78500a64f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 03:56:53.0570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oL/qMZq1tm99It1vb3G42wyTzbeDcnu0qSuknBZxqnV0FU/I78FK1CyBGtL2Mm+UliViQ4uVx5EuCzDGZgsUIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-12-20 04:52:38, Dmitry Osipenko wrote:
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

Why you do this dependency, if this controller driver can't
get USB PHY, it should return error. What's the return value
after calling below:

	udc->phy =3D devm_usb_get_phy_by_phandle(&pdev->dev, "nvidia,phy", 0);

Peter
>  	udc =3D devm_kzalloc(&pdev->dev, sizeof(*udc), GFP_KERNEL);
>  	if (!udc)
>  		return -ENOMEM;
> --=20
> 2.24.0
>=20

--=20

Thanks,
Peter Chen=
