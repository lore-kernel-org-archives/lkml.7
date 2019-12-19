Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD4BC2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0E3227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jVx6jYCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfLSG4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 01:56:33 -0500
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:29047
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726294AbfLSG4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 01:56:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUej38PzijELrR4ocjJ5lPgiIYAMTYF3uNKWEClRXM2HGoIkVBd/UF9/Rsbkb0okBFskmiAM0XmT5PUYCmsjvRSbKt3xNeEU+zTZ8khe3m3HsHkCzTWamAJD6jW/VKtQ5FDf4xK2Kai3Yw53xLmGQrVMCDCdVETqfmeKUewLYiYAAWHpCe8rmU3iLiCxEPJm+fKQo4shVloaJEF57WcyYdS0y/QKO+fVl1LyuggFxZxo+hlPs3wSm5+aJjt9kp6MU3ma8daIcaGdnGn6czVzCW724sxgr7Z8UNSms4W0rAUUBUoCf8ALeTYYnRd0IFgMFm3lTjP2GRs9Tu56WdlDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtGolgXMHR/UtZ6oKSPc8y2g6Zz4D4wQxfGs0Vplx/k=;
 b=H+AQ1LMCR/PNgDteLLYotWfFZjBpZjT0vQ/qzkqm5Kv9LD6kWltrFCMDgYqNFYfbPjhqxqYOPDAKZwMUPki6y5epqmAcRGqCLNaeKHUPU5TLq5an1QUK1NVXXzFKriFZFOHG73kTwvZbBfnoZLuSw/sAgeRKrGBtf4gi+XtjEIJ43kYRgNHQOeIu/BmR77ek4TgEtPiGD0EGYDJzRdH2Rzmzq7AkvVchw7fneLJq93T0OPXHPKNLBvW/2wDnpXWWr6xa7UVE1OfK1PG7xCPru6eGNsUlEpEaJ76ri3yf1KoBfQZoknERVyj50JyR6jMRud2RiVrC7HXpTu6C+SCZKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtGolgXMHR/UtZ6oKSPc8y2g6Zz4D4wQxfGs0Vplx/k=;
 b=jVx6jYCMDwIfWd7644/2a6y4m0WZb9kdcjq625DWq+RU5Rr96MhdJSDLHcz0cSF4WirLTuspfWemD4jlKAxunxzYxNbt5BAgMPivJtybyq9m21QQqawS5x2ZdydNSC71rzUyotkBVZJAHhK66LZJG7ZYW6BVQ8J7WqMXONFfzKU=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB4815.eurprd04.prod.outlook.com (20.177.51.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 19 Dec 2019 06:56:22 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9%7]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 06:56:22 +0000
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
Subject: Re: [PATCH v1 2/4] usb: phy: tegra: Hook up init/shutdown callbacks
Thread-Topic: [PATCH v1 2/4] usb: phy: tegra: Hook up init/shutdown callbacks
Thread-Index: AQHVtcwUpAw1wFH/pEGfUN+1P4eKkqfBBzyA
Date:   Thu, 19 Dec 2019 06:56:22 +0000
Message-ID: <20191219065619.GA19921@b29397-desktop>
References: <20191218175313.16235-1-digetx@gmail.com>
 <20191218175313.16235-3-digetx@gmail.com>
In-Reply-To: <20191218175313.16235-3-digetx@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90867aa3-2395-4618-13d2-08d784508eff
x-ms-traffictypediagnostic: VI1PR04MB4815:
x-microsoft-antispam-prvs: <VI1PR04MB48159913B0E0C6745ECD5CB98B520@VI1PR04MB4815.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(189003)(199004)(9686003)(6512007)(2906002)(6486002)(26005)(33656002)(86362001)(33716001)(1076003)(54906003)(71200400001)(186003)(44832011)(53546011)(6506007)(91956017)(76116006)(66476007)(66556008)(66446008)(316002)(66946007)(64756008)(6916009)(8936002)(81166006)(81156014)(8676002)(5660300002)(478600001)(7416002)(4326008)(52103002)(158003001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4815;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oHC6vYEAE7+b9HcI4flYTNqACpXttTXDUQJ0FvDd19Q7YLxakaX34cho1K2ilzlFgnjSWDWO2WAbzGeGFbHJqoNR71y+5uLwlYy2UJraNZsbEGszlhIQQAQNQLvJ4TaepjaoSFEp9iOWb1dyU+DKyZXs4evBLX4JAGAbeis/7zwEek9a18miju9h5IqcLnJcz55AtKXe5g9bRoS97ajh81aVTR27pdnORH5RXum2K5HlIZaeSGjWSmR6X1fazNPQHKTJ/CXzVGOkZH+2wqGLuX1Dau2uhc9rD6iLneGu9qlENG9OG8U5SSVsTqoVEx8+Gb11FZlbpRPuCum4uf2rNI3ufuQmngl6EgueuWVWEAj1EpZU3sU1L9cdYnb8yH0FeDZvz4UWBE7xvwAi/mSlnjLytD8L6j2BzL96VR5FJanqMaV/o4QdxmMXoo9JcgEplXlzmdK7W8LrWMKiGfxaFl62vAPS0nBx9YEq5GnwN9bm8Q/b5P1ZYzw1noXFFA3i7Jfff5MZrBmdj2R1AH8aGA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0CB838B09A557D448A0D56A5C91782AA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90867aa3-2395-4618-13d2-08d784508eff
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 06:56:22.5327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSoseziofnDURQlzcuYf7Pb0jrsOiX+nLLylf8cObsXuMUQYUEofHUxgAQZp4WwnIF/1uxSYrjnfZG6PV/bmqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4815
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-12-18 20:53:11, Dmitry Osipenko wrote:
> Generic PHY provides init/shutdown callbacks which allow USB-host drivers
> to abstract PHY's hardware management in a common way. This change allows
> to remove Tegra-specific PHY handling from the ChipIdea driver.
>=20
> Note that ChipIdea's driver shall be changed at the same time because it
> turns PHY ON without the PHY's initialization and this doesn't work now,
> resulting in a NULL dereference of phy->freq because it's set during of
> the PHY's initialization.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/usb/chipidea/ci_hdrc_tegra.c |   9 --
>  drivers/usb/phy/phy-tegra-usb.c      | 165 +++++++++++++++++----------
>  2 files changed, 102 insertions(+), 72 deletions(-)
>=20
> diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/=
ci_hdrc_tegra.c
> index 0c9911d44ee5..7455df0ede49 100644
> --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
> +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
> @@ -83,13 +83,6 @@ static int tegra_udc_probe(struct platform_device *pde=
v)
>  		return err;
>  	}
> =20
> -	/*
> -	 * Tegra's USB PHY driver doesn't implement optional phy_init()
> -	 * hook, so we have to power on UDC controller before ChipIdea
> -	 * driver initialization kicks in.
> -	 */
> -	usb_phy_set_suspend(udc->phy, 0);
> -
>  	/* setup and register ChipIdea HDRC device */
>  	udc->data.name =3D "tegra-udc";
>  	udc->data.flags =3D soc->flags;
> @@ -109,7 +102,6 @@ static int tegra_udc_probe(struct platform_device *pd=
ev)
>  	return 0;
> =20
>  fail_power_off:
> -	usb_phy_set_suspend(udc->phy, 1);
>  	clk_disable_unprepare(udc->clk);
>  	return err;
>  }
> @@ -119,7 +111,6 @@ static int tegra_udc_remove(struct platform_device *p=
dev)
>  	struct tegra_udc *udc =3D platform_get_drvdata(pdev);
> =20
>  	ci_hdrc_remove_device(udc->dev);
> -	usb_phy_set_suspend(udc->phy, 1);
>  	clk_disable_unprepare(udc->clk);
> =20
>  	return 0;
> diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-=
usb.c
> index ea7ef1dc0b42..15bd253d53c9 100644
> --- a/drivers/usb/phy/phy-tegra-usb.c
> +++ b/drivers/usb/phy/phy-tegra-usb.c
> @@ -238,23 +238,6 @@ static int utmip_pad_open(struct tegra_usb_phy *phy)
>  {
>  	int ret;
> =20
> -	phy->pad_clk =3D devm_clk_get(phy->u_phy.dev, "utmi-pads");
> -	if (IS_ERR(phy->pad_clk)) {
> -		ret =3D PTR_ERR(phy->pad_clk);
> -		dev_err(phy->u_phy.dev,
> -			"Failed to get UTMIP pad clock: %d\n", ret);
> -		return ret;
> -	}
> -
> -	phy->pad_rst =3D devm_reset_control_get_optional_shared(
> -						phy->u_phy.dev, "utmi-pads");
> -	if (IS_ERR(phy->pad_rst)) {
> -		ret =3D PTR_ERR(phy->pad_rst);
> -		dev_err(phy->u_phy.dev,
> -			"Failed to get UTMI-pads reset: %d\n", ret);
> -		return ret;
> -	}
> -
>  	ret =3D clk_prepare_enable(phy->pad_clk);
>  	if (ret) {
>  		dev_err(phy->u_phy.dev,
> @@ -315,6 +298,18 @@ static int utmip_pad_close(struct tegra_usb_phy *phy=
)
>  	return ret;
>  }

Acked-by: Peter Chen <peter.chen@nxp.com>

Felipe, would you please queue this series after reviewing for USB PHY
changes? If not, Dmitry may need to split the patch.

Peter
> =20
> +static void ulpi_close(struct tegra_usb_phy *phy)
> +{
> +	int err;
> +
> +	err =3D gpio_direction_output(phy->reset_gpio, 1);
> +	if (err < 0) {
> +		dev_err(phy->u_phy.dev,
> +			"ULPI reset GPIO %d direction not asserted: %d\n",
> +			phy->reset_gpio, err);
> +	}
> +}
> +
>  static void utmip_pad_power_on(struct tegra_usb_phy *phy)
>  {
>  	unsigned long val, flags;
> @@ -761,14 +756,19 @@ static int ulpi_phy_power_off(struct tegra_usb_phy =
*phy)
>  	return gpio_direction_output(phy->reset_gpio, 0);
>  }
> =20
> -static void tegra_usb_phy_close(struct tegra_usb_phy *phy)
> +static void tegra_usb_phy_close(struct usb_phy *u_phy)
>  {
> -	if (!IS_ERR(phy->vbus))
> -		regulator_disable(phy->vbus);
> +	struct tegra_usb_phy *phy =3D container_of(u_phy, struct tegra_usb_phy,
> +						 u_phy);
> =20
> -	if (!phy->is_ulpi_phy)
> +	if (phy->is_ulpi_phy)
> +		ulpi_close(phy);
> +	else
>  		utmip_pad_close(phy);
> =20
> +	if (!IS_ERR(phy->vbus))
> +		regulator_disable(phy->vbus);
> +
>  	clk_disable_unprepare(phy->pll_u);
>  }
> =20
> @@ -788,7 +788,7 @@ static int tegra_usb_phy_power_off(struct tegra_usb_p=
hy *phy)
>  		return utmi_phy_power_off(phy);
>  }
> =20
> -static int	tegra_usb_phy_suspend(struct usb_phy *x, int suspend)
> +static int tegra_usb_phy_suspend(struct usb_phy *x, int suspend)
>  {
>  	struct tegra_usb_phy *phy =3D container_of(x, struct tegra_usb_phy, u_p=
hy);
>  	if (suspend)
> @@ -801,54 +801,25 @@ static int ulpi_open(struct tegra_usb_phy *phy)
>  {
>  	int err;
> =20
> -	phy->clk =3D devm_clk_get(phy->u_phy.dev, "ulpi-link");
> -	if (IS_ERR(phy->clk)) {
> -		err =3D PTR_ERR(phy->clk);
> -		dev_err(phy->u_phy.dev, "Failed to get ULPI clock: %d\n", err);
> -		return err;
> -	}
> -
> -	err =3D devm_gpio_request(phy->u_phy.dev, phy->reset_gpio,
> -		"ulpi_phy_reset_b");
> -	if (err < 0) {
> -		dev_err(phy->u_phy.dev, "Request failed for GPIO %d: %d\n",
> -			phy->reset_gpio, err);
> -		return err;
> -	}
> -
>  	err =3D gpio_direction_output(phy->reset_gpio, 0);
>  	if (err < 0) {
>  		dev_err(phy->u_phy.dev,
> -			"GPIO %d direction not set to output: %d\n",
> +			"ULPI reset GPIO %d direction not deasserted: %d\n",
>  			phy->reset_gpio, err);
>  		return err;
>  	}
> =20
> -	phy->ulpi =3D otg_ulpi_create(&ulpi_viewport_access_ops, 0);
> -	if (!phy->ulpi) {
> -		dev_err(phy->u_phy.dev, "Failed to create ULPI OTG\n");
> -		err =3D -ENOMEM;
> -		return err;
> -	}
> -
> -	phy->ulpi->io_priv =3D phy->regs + ULPI_VIEWPORT;
>  	return 0;
>  }
> =20
> -static int tegra_usb_phy_init(struct tegra_usb_phy *phy)
> +static int tegra_usb_phy_init(struct usb_phy *u_phy)
>  {
> +	struct tegra_usb_phy *phy =3D container_of(u_phy, struct tegra_usb_phy,
> +						 u_phy);
>  	unsigned long parent_rate;
>  	int i;
>  	int err;
> =20
> -	phy->pll_u =3D devm_clk_get(phy->u_phy.dev, "pll_u");
> -	if (IS_ERR(phy->pll_u)) {
> -		err =3D PTR_ERR(phy->pll_u);
> -		dev_err(phy->u_phy.dev,
> -			"Failed to get pll_u clock: %d\n", err);
> -		return err;
> -	}
> -
>  	err =3D clk_prepare_enable(phy->pll_u);
>  	if (err)
>  		return err;
> @@ -884,8 +855,17 @@ static int tegra_usb_phy_init(struct tegra_usb_phy *=
phy)
>  	if (err < 0)
>  		goto fail;
> =20
> +	err =3D tegra_usb_phy_power_on(phy);
> +	if (err)
> +		goto close_phy;
> +
>  	return 0;
> =20
> +close_phy:
> +	if (phy->is_ulpi_phy)
> +		ulpi_close(phy);
> +	else
> +		utmip_pad_close(phy);
>  fail:
>  	clk_disable_unprepare(phy->pll_u);
>  	return err;
> @@ -1134,22 +1114,77 @@ static int tegra_usb_phy_probe(struct platform_de=
vice *pdev)
>  		tegra_phy->vbus =3D ERR_PTR(-ENODEV);
>  	}
> =20
> -	tegra_phy->u_phy.dev =3D &pdev->dev;
> -	err =3D tegra_usb_phy_init(tegra_phy);
> -	if (err < 0)
> +	tegra_phy->pll_u =3D devm_clk_get(&pdev->dev, "pll_u");
> +	err =3D PTR_ERR_OR_ZERO(tegra_phy);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to get pll_u clock: %d\n", err);
>  		return err;
> +	}
> =20
> +	if (tegra_phy->is_ulpi_phy) {
> +		tegra_phy->clk =3D devm_clk_get(&pdev->dev, "ulpi-link");
> +		err =3D PTR_ERR_OR_ZERO(tegra_phy->clk);
> +		if (err) {
> +			dev_err(&pdev->dev,
> +				"Failed to get ULPI clock: %d\n", err);
> +			return err;
> +		}
> +
> +		err =3D devm_gpio_request(&pdev->dev, tegra_phy->reset_gpio,
> +			"ulpi_phy_reset_b");
> +		if (err < 0) {
> +			dev_err(&pdev->dev, "Request failed for GPIO %d: %d\n",
> +				tegra_phy->reset_gpio, err);
> +			return err;
> +		}
> +
> +		tegra_phy->ulpi =3D otg_ulpi_create(&ulpi_viewport_access_ops, 0);
> +		if (!tegra_phy->ulpi) {
> +			dev_err(&pdev->dev, "Failed to create ULPI OTG\n");
> +			err =3D -ENOMEM;
> +			return err;
> +		}
> +
> +		tegra_phy->ulpi->io_priv =3D tegra_phy->regs + ULPI_VIEWPORT;
> +	} else {
> +		tegra_phy->pad_clk =3D devm_clk_get(&pdev->dev, "utmi-pads");
> +		err =3D PTR_ERR_OR_ZERO(tegra_phy->pad_clk);
> +		if (err) {
> +			dev_err(&pdev->dev,
> +				"Failed to get UTMIP pad clock: %d\n", err);
> +			return err;
> +		}
> +
> +		tegra_phy->pad_rst =3D devm_reset_control_get_optional_shared(
> +						&pdev->dev, "utmi-pads");
> +		err =3D PTR_ERR_OR_ZERO(tegra_phy->pad_rst);
> +		if (err) {
> +			dev_err(&pdev->dev,
> +				"Failed to get UTMI-pads reset: %d\n", err);
> +			return err;
> +		}
> +	}
> +
> +	tegra_phy->u_phy.dev =3D &pdev->dev;
> +	tegra_phy->u_phy.init =3D tegra_usb_phy_init;
> +	tegra_phy->u_phy.shutdown =3D tegra_usb_phy_close;
>  	tegra_phy->u_phy.set_suspend =3D tegra_usb_phy_suspend;
> =20
>  	platform_set_drvdata(pdev, tegra_phy);
> =20
>  	err =3D usb_add_phy_dev(&tegra_phy->u_phy);
> -	if (err < 0) {
> -		tegra_usb_phy_close(tegra_phy);
> -		return err;
> -	}
> +	if (err < 0)
> +		goto free_ulpi;
> =20
>  	return 0;
> +
> +free_ulpi:
> +	if (tegra_phy->ulpi) {
> +		kfree(tegra_phy->ulpi->otg);
> +		kfree(tegra_phy->ulpi);
> +	}
> +
> +	return err;
>  }
> =20
>  static int tegra_usb_phy_remove(struct platform_device *pdev)
> @@ -1157,7 +1192,11 @@ static int tegra_usb_phy_remove(struct platform_de=
vice *pdev)
>  	struct tegra_usb_phy *tegra_phy =3D platform_get_drvdata(pdev);
> =20
>  	usb_remove_phy(&tegra_phy->u_phy);
> -	tegra_usb_phy_close(tegra_phy);
> +
> +	if (tegra_phy->ulpi) {
> +		kfree(tegra_phy->ulpi->otg);
> +		kfree(tegra_phy->ulpi);
> +	}
> =20
>  	return 0;
>  }
> --=20
> 2.24.0
>=20

--=20

Thanks,
Peter Chen=
