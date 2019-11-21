Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FDFC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5212067D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gm9eYgFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKUJyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:54:06 -0500
Received: from mail-db3eur04hn2072.outbound.protection.outlook.com ([52.101.138.72]:34119
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726132AbfKUJyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:54:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwWc8V/KNd8MAw1lpXu4rYnwVH7S8pP+nK4V42Rcb6XlfSiKdqGirWgGzCU2HoyBgoEVpJb7SjlYSof+3E72AGV0+swi3hUsUe2hamhd/xOTseZIqE5RbSCC2/MmwSVlmjzJs3RnIex3EdMGrDbUIsjuNYBUh3OTy6NBButxRE0qGG/0QcUPGESrAmP+KkJbjz03cnScGZwgbvwT0hnzRTcgtRjS3+1RiVdjRuoiUagu4Un+u8X8E2w6dy1niViaY37F29ufBdk0m/7qA5mHYrmWEwlS3v5ml44TX+b4Qqk993+l+3UpbwnOVDNvgFFtsuU3BI9LZzM/kFmt8Wd+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIZVv3TFo/dJ6EzmU/US86BfGFgQY1aSIoMMtIrpxbQ=;
 b=ogNU8bYuDjMjkt99sRomh/PJF9Y5XDpFPOTWmEA75/wKgfzL0oA36QrNyjWEmbzkGklJLrShlDAnuB+K7O8JtcjirbL4x3OadU9uMc4V7pbcN/SQ0LQSJNaUhttPGyUdgmUfbaI4DgnS/EK3kM/6dOUyVQ+IcM76RP3ZclEBik0Vyl+GOASV9pu33Rp5AB64vldrve8yQs8o+kfCtffdrhxtgDPWa1O/oRLWycJ+Cgp+PmP4QUk4LPnvcChS9knhJxA+4S0KkX+BzToWHXlpKTkTj+/k2z1vF9gNfyiLK/SeIOrAlzbd5wrHoLuA5Are6EAPJTe3+WJgeGfYV3yPKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIZVv3TFo/dJ6EzmU/US86BfGFgQY1aSIoMMtIrpxbQ=;
 b=Gm9eYgFhIG+jyP/klYoV7tZCpHMySzidWjv6KnTPAlBVWRZUmRcmp0wGPcOR7+MdDsVBHRMomCi7prDZoWFgSplt69ACkmjCLsIeVxzi+oeimVyXkSvu3XdR98oaVjnfNobfHNwxjKZdWCTOLlCeLeq537YmSm5pYM+7zmt+30Y=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB4061.eurprd04.prod.outlook.com (10.171.182.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Thu, 21 Nov 2019 09:54:02 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9%7]) with mapi id 15.20.2451.032; Thu, 21 Nov 2019
 09:54:02 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Ran Wang <ran.wang_1@nxp.com>
CC:     Rob Herring <robh+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, Jun Li <jun.li@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] usb: dwc3: Add cache type configuration support
Thread-Topic: [PATCH v3 2/2] usb: dwc3: Add cache type configuration support
Thread-Index: AQHVoBVSAvvkYeBt2E6+VjH8nSE3k6eVYwIA
Date:   Thu, 21 Nov 2019 09:54:01 +0000
Message-ID: <20191121095356.GB7503@b29397-desktop>
References: <20191121024206.32933-1-ran.wang_1@nxp.com>
 <20191121024206.32933-2-ran.wang_1@nxp.com>
In-Reply-To: <20191121024206.32933-2-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e44b0f3-a9b3-4b85-016e-08d76e68bce4
x-ms-traffictypediagnostic: VI1PR04MB4061:|VI1PR04MB4061:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB406102213B78E5515E8A225A8B4E0@VI1PR04MB4061.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:SPM;SFS:(10009020)(4636009)(7916004)(366004)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(229853002)(64756008)(66946007)(305945005)(7736002)(66556008)(76116006)(66446008)(256004)(14444005)(66476007)(6486002)(6436002)(91956017)(86362001)(8936002)(44832011)(71200400001)(71190400001)(6512007)(54906003)(316002)(9686003)(33716001)(26005)(81166006)(8676002)(81156014)(5660300002)(6246003)(186003)(66066001)(11346002)(25786009)(446003)(76176011)(6116002)(3846002)(53546011)(2906002)(478600001)(99286004)(6506007)(1076003)(4326008)(102836004)(6636002)(6862004)(33656002)(14454004)(989001);DIR:OUT;SFP:1501;SCL:6;SRVR:VI1PR04MB4061;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l9D4+c6MmN0jd0tP5Y6/TMc5EvfWwSusbPcdIamPAql99BTLDi9qnil4Xo4T7GzhqWTs5nGF2K6uvxFa6INpYr6gedb6cwQvTbdG9wg67Qv5hm5rKBWPre1pxZsKT6K/qks03bkOIGPCNyCFUgMgOwTXDGMNGa6WAdEA78eTxsyW2OIHcPgNXgB89G5Ijsd+7ESZkldFqe7pvJwmHuU5528Gt2WtncEa+XNyPEqumNlM7lmL8Q/SfnK6tV1ii0eOcmr4Kxg4yTRSm/OMOodrWoPwAjpX3FuW+rqv6mtE38NGiNNw1zwalg0JP5FVnQ+8OVftGfMLUGYQJP7bFrAadr2UJ7gRTe2KacHV5kaIsken8iC2X2bBchEaVeEfO8tF2AaRXmGKsUjF3eR0xIqs9DE7cughRfgYs239MUANf1haXRRJEnaXkLHpjPzbIF5/W4r6zTJvszoGSS1wZ6y2i/ccSO3A022otBF6z6NRC0APqpob8a/Ut/AFXzNs2xb52g8Gxl5yV+ueHqsTtIXvKlTbWO+s9IzfiFSN6v4W09zjnNakq2arkUJBfni9DR5CSXboslkjUX1CZNml2cHqeCePYu6MK9f0wWG9lNCt2L5Um5M3cbZbdMkIggyFJeB8lCTtuesgtW3k8ocCxZqLgQve5dskKGNIXMsNXYlq9AjC4Nz/5F1bvXxmqkklOB8G9QX4PfaINOyogdYGzIYpFQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BB4A3445FF491245890EE9FC582979D2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e44b0f3-a9b3-4b85-016e-08d76e68bce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 09:54:01.9998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+ol4dN82ZcGgZ7dd7o63qpuXHUWwm5aRNPEk4A0iIAlsYyaSICQA8Z9eNTb36zIUdzAsPm1QMacePvrOOz47w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-21 10:42:06, Ran Wang wrote:
> This feature is telling how to configure cache type on 4 different
> transfer types: Data Read, Desc Read, Data Write and Desc write. For each
> treasfer type, controller has a 4-bit register field to enable different

%s/treasfer/transfer

> cache type. Quoted from DWC3 data book Table 6-5 Cache Type Bit Assignmen=
ts:
> ----------------------------------------------------------------
> MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]
> ----------------------------------------------------------------
> AHB      |Cacheable     |Bufferable   |Privilegge |Data
> AXI3     |Write Allocate|Read Allocate|Cacheable  |Bufferable
> AXI4     |Allocate Other|Allocate     |Modifiable |Bufferable
> AXI4     |Other Allocate|Allocate     |Modifiable |Bufferable
> Native   |Same as AXI   |Same as AXI  |Same as AXI|Same as AXI
> ----------------------------------------------------------------
> Note: The AHB, AXI3, AXI4, and PCIe busses use different names for certai=
n
> signals, which have the same meaning:
>   Bufferable =3D Posted
>   Cacheable =3D Modifiable =3D Snoop (negation of No Snoop)
>=20
> In most cases, driver support is not required unless the default values o=
f
> registers are not correct *and* DWC3 node has enabled dma-coherent. So fa=
r we
> have observed USB device detect failure on some Layerscape platforms if t=
his
> programming was not applied.
>=20
> Related struct:
> struct dwc3_cache_type {
> 	u8 transfer_type_datard;
> 	u8 transfer_type_descrd;
> 	u8 transfer_type_datawr;
> 	u8 transfer_type_descwr;
> };
>=20
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Change in v3:
> 	- Replace cache type sub-node parsing with chip-specifc data parsing.

If it is SoC implementation specific, you may move the implementation to
dwc3-of-simmple.c, and change your dts accordingly.

Feplie, what do you think?

Peter

>=20
> Change in v2:
> 	- Change most program logic to meet new DTS property define.
> 	- Rename related register address macros.
> 	- Rename function  dwc3_enable_snooping() to dwc3_set_cache_type().
>=20
>  drivers/usb/dwc3/core.c | 67 +++++++++++++++++++++++++++++++++++++++++++=
+-----
>  drivers/usb/dwc3/core.h | 15 +++++++++++
>  2 files changed, 76 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 97d6ae3..0baa972 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -894,6 +894,53 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dw=
c)
>  	dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, cfg);
>  }
> =20
> +#ifdef CONFIG_OF
> +struct dwc3_cache_type {
> +	u8 transfer_type_datard;
> +	u8 transfer_type_descrd;
> +	u8 transfer_type_datawr;
> +	u8 transfer_type_descwr;
> +};
> +
> +static const struct dwc3_cache_type ls1088a_dwc3_cache_type =3D {
> +	.transfer_type_datard =3D 2,
> +	.transfer_type_descrd =3D 2,
> +	.transfer_type_datawr =3D 2,
> +	.transfer_type_descwr =3D 2,
> +};
> +
> +/**
> + * dwc3_set_cache_type - Configure cache type registers
> + * @dwc: Pointer to our controller context structure
> + */
> +static void dwc3_set_cache_type(struct dwc3 *dwc)
> +{
> +	u32 tmp, reg;
> +	const struct dwc3_cache_type *cache_type =3D
> +		device_get_match_data(dwc->dev);
> +
> +	if (cache_type) {
> +		reg =3D dwc3_readl(dwc->regs,  DWC3_GSBUSCFG0);
> +		tmp =3D reg;
> +
> +		reg &=3D ~DWC3_GSBUSCFG0_DATARD(~0);
> +		reg |=3D DWC3_GSBUSCFG0_DATARD(cache_type->transfer_type_datard);
> +
> +		reg &=3D ~DWC3_GSBUSCFG0_DESCRD(~0);
> +		reg |=3D DWC3_GSBUSCFG0_DESCRD(cache_type->transfer_type_descrd);
> +
> +		reg &=3D ~DWC3_GSBUSCFG0_DATAWR(~0);
> +		reg |=3D DWC3_GSBUSCFG0_DATAWR(cache_type->transfer_type_datawr);
> +
> +		reg &=3D ~DWC3_GSBUSCFG0_DESCWR(~0);
> +		reg |=3D DWC3_GSBUSCFG0_DESCWR(cache_type->transfer_type_descwr);
> +
> +		if (tmp !=3D reg)
> +			dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, reg);
> +	}
> +}
> +#endif
> +
>  /**
>   * dwc3_core_init - Low-level initialization of DWC3 Core
>   * @dwc: Pointer to our controller context structure
> @@ -952,6 +999,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
> =20
>  	dwc3_set_incr_burst_type(dwc);
> =20
> +#ifdef CONFIG_OF
> +	dwc3_set_cache_type(dwc);
> +#endif
> +
>  	usb_phy_set_suspend(dwc->usb2_phy, 0);
>  	usb_phy_set_suspend(dwc->usb3_phy, 0);
>  	ret =3D phy_power_on(dwc->usb2_generic_phy);
> @@ -1837,12 +1888,16 @@ static const struct dev_pm_ops dwc3_dev_pm_ops =
=3D {
> =20
>  #ifdef CONFIG_OF
>  static const struct of_device_id of_dwc3_match[] =3D {
> -	{
> -		.compatible =3D "snps,dwc3"
> -	},
> -	{
> -		.compatible =3D "synopsys,dwc3"
> -	},
> +	{ .compatible =3D "fsl,ls1012a-dwc3", .data =3D &ls1088a_dwc3_cache_typ=
e, },
> +	{ .compatible =3D "fsl,ls1021a-dwc3", .data =3D &ls1088a_dwc3_cache_typ=
e, },
> +	{ .compatible =3D "fsl,ls1028a-dwc3", .data =3D &ls1088a_dwc3_cache_typ=
e, },
> +	{ .compatible =3D "fsl,ls1043a-dwc3", .data =3D &ls1088a_dwc3_cache_typ=
e, },
> +	{ .compatible =3D "fsl,ls1046a-dwc3", .data =3D &ls1088a_dwc3_cache_typ=
e, },
> +	{ .compatible =3D "fsl,ls1088a-dwc3", .data =3D &ls1088a_dwc3_cache_typ=
e, },
> +	{ .compatible =3D "fsl,ls2088a-dwc3", .data =3D &ls1088a_dwc3_cache_typ=
e, },
> +	{ .compatible =3D "fsl,lx2160a-dwc3", .data =3D &ls1088a_dwc3_cache_typ=
e, },
> +	{ .compatible =3D "snps,dwc3" },
> +	{ .compatible =3D "synopsys,dwc3"	},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, of_dwc3_match);
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 1c8b3493..ac51dfe 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -165,6 +165,21 @@
>  /* Bit fields */
> =20
>  /* Global SoC Bus Configuration INCRx Register 0 */
> +#ifdef CONFIG_OF
> +#define DWC3_GSBUSCFG0_DATARD_SHIFT	28
> +#define DWC3_GSBUSCFG0_DATARD(n)	(((n) & 0xf)		\
> +			<< DWC3_GSBUSCFG0_DATARD_SHIFT)
> +#define DWC3_GSBUSCFG0_DESCRD_SHIFT	24
> +#define DWC3_GSBUSCFG0_DESCRD(n)	(((n) & 0xf)		\
> +			<< DWC3_GSBUSCFG0_DESCRD_SHIFT)
> +#define DWC3_GSBUSCFG0_DATAWR_SHIFT	20
> +#define DWC3_GSBUSCFG0_DATAWR(n)	(((n) & 0xf)		\
> +			<< DWC3_GSBUSCFG0_DATAWR_SHIFT)
> +#define DWC3_GSBUSCFG0_DESCWR_SHIFT	16
> +#define DWC3_GSBUSCFG0_DESCWR(n)	(((n) & 0xf)		\
> +			<< DWC3_GSBUSCFG0_DESCWR_SHIFT)
> +#endif
> +
>  #define DWC3_GSBUSCFG0_INCR256BRSTENA	(1 << 7) /* INCR256 burst */
>  #define DWC3_GSBUSCFG0_INCR128BRSTENA	(1 << 6) /* INCR128 burst */
>  #define DWC3_GSBUSCFG0_INCR64BRSTENA	(1 << 5) /* INCR64 burst */
> --=20
> 2.7.4
>=20

--=20

Thanks,
Peter Chen=
