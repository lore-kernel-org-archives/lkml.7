Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9317C5DF61
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968912087E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iVlWBSGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfKEVKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 16:10:50 -0500
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:23010
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725806AbfKEVKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 16:10:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTzsE6K1nu8xfUFT8xZjPQtk/u7RJmZvqjwBCkI+iWdLBxJOasEKMzvPibaxLEg6dd1xl1xC7VaibDibVSDWFmZL8e3x+hSKf3KBvXgNiTjwmYnCmhW3nu/cKOexlV0gLPEChtuduOSflyArsn0lyjw3uF9yLZC7i6U1BhwJNjKj+sWisC/Si6DbQqm/oiAakb46ciEVeWl/4UTNcyxut4x/3uJ3OEn6GXtGNBW7H/GVlKAhNEoTyQWqeei6BN961M8N2EBZz29A/OFGaEnYL6d/eznn/vd6Wzdmc9rx/kFbPKe0bEhB6CPWHLGGoCWFgUkTES1gvj+BfiJjze2k2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwwsoL1S/S5IqUWkHlCBm7OUPk3o1AiLXXXGJNJhbwc=;
 b=n8sT3TGU3jhj9SHyk9Pr/rOn/wW1LcsJUbZokQh2+ppiz9VKyX7ybHJuebvB9Ggo0uLxiKrRlTbL/jKfcwSLYcBjLFQ0vWyWB8ao4L+E86hu4oCo0V9Jz5fYqlTBmbou6ikB2ihesQ5fwi34DMuwUPxNeMUmb7hyyXEDjC8xFh4Nqgk22XJV1gr1VBqhGFMt+1NECGn32WWYAaxAnY5+yVQFMjBTDEPXO9wkbv5HHF+x95kWyXLyVlvlnoZOgFyAjmDdO27/GpuqxEaQ8C8pA5/9kMmHcFjSoU5q7+IT4/ysur4gq8V9BoA3Kvo40xZyETgC7Jf0lGUpGkK9JdMJmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwwsoL1S/S5IqUWkHlCBm7OUPk3o1AiLXXXGJNJhbwc=;
 b=iVlWBSGKjLTOnvkIfB62Cga6Sy2OJ9SmKLwiQ6tLprDQ7HWiD8/Z/MixYNQVrqlGmePywta5X4fMVa+OKklGJ/0R2sl4tHQGslBW52gWL4McLVs5H9RD3Hbh3CreZxROvmOp/iGCdnejhMlm/vWHTRz9S3FrGPuikdI6PXzBQh4=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.234.30) by
 VE1PR04MB6464.eurprd04.prod.outlook.com (20.179.233.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 5 Nov 2019 21:10:40 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::e948:7a32:ae88:906d]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::e948:7a32:ae88:906d%4]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 21:10:40 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Wen He <wen.he_1@nxp.com>,
        "linux-devel@linux.nxdi.nxp.com" <linux-devel@linux.nxdi.nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wen He <wen.he_1@nxp.com>
Subject: RE: [v6 2/2] clk: ls1028a: Add clock driver for Display output
 interface
Thread-Topic: [v6 2/2] clk: ls1028a: Add clock driver for Display output
 interface
Thread-Index: AQHVk7lU88tsMjTdfEquEIjcGZbafad84Hiw
Date:   Tue, 5 Nov 2019 21:10:40 +0000
Message-ID: <VE1PR04MB66879681CE5231F5C80F85148F7E0@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20191105090221.45381-1-wen.he_1@nxp.com>
 <20191105090221.45381-2-wen.he_1@nxp.com>
In-Reply-To: <20191105090221.45381-2-wen.he_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4fb5be94-95f2-48d8-70ea-08d762349cf1
x-ms-traffictypediagnostic: VE1PR04MB6464:|VE1PR04MB6464:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6464CA5618B15C5A12313F598F7E0@VE1PR04MB6464.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(13464003)(189003)(199004)(66476007)(33656002)(66446008)(110136005)(66556008)(2501003)(64756008)(76116006)(4326008)(316002)(76176011)(66946007)(6246003)(6506007)(2906002)(229853002)(26005)(53546011)(102836004)(9686003)(55016002)(8676002)(5660300002)(52536014)(6436002)(6116002)(14454004)(3846002)(7696005)(186003)(256004)(14444005)(476003)(305945005)(86362001)(11346002)(446003)(486006)(25786009)(66066001)(81156014)(81166006)(74316002)(478600001)(7736002)(99286004)(71190400001)(30864003)(71200400001)(8936002)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6464;H:VE1PR04MB6687.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ZNzwBd0r2q3Ge8lC+ePP4cvFiUNDsMp5rfXNq9QAJT5ZUhtzHnC/8DFP789jKacCJeH4NjOFykI3jPnDtKdw0zntYfga3aOaeutSQUB3NstdO7JXrVBEoZKKcY/lnyD8O9jsrm19AEXBRNqE6VmQR0ZSW9Jped/T7KovPFFqdhAEL3cxhn5sYCKKlPlAQYAs0eNbtGV1UeDZC5DNAE477hhMrwX+nQc7uXUm8PGpRv8SPgo+had6/k7TzS+3olit8UyfvJglA+L3FpDtYeKpwaENzukRHA37OQwizUroTNovmIxyaagz+uYzaag4HwyI/BvKnWZ3a9tG/Rf7p7IIpPVlNkI+oINfn13+1Zwb7j+3vuHKSOOlrY6SHUDP31grKZJzs93UmR4FWNBuR9+9DTZy/MZ6KOdDtsu4stfc+gqar1NtWtQnbYQ0hviFsYj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb5be94-95f2-48d8-70ea-08d762349cf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 21:10:40.6035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mFPOK6iC/3Z2FhZauQR8bqHn1WiD0rVQcelkMjkpS5/TpoKkO6SdX8iviAmGAa2kbm0vtiffSxTsdCnkcks2LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Wen He <wen.he_1@nxp.com>
> Sent: Tuesday, November 5, 2019 3:02 AM
> To: linux-devel@linux.nxdi.nxp.com; Michael Turquette
> <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Leo Li <leoyang.li@nxp.com>; devicetree@vger.kernel.org; linux-
> clk@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Wen He <wen.he_1@nxp.com>
> Subject: [v6 2/2] clk: ls1028a: Add clock driver for Display output inter=
face
>=20
> Add clock driver for QorIQ LS1028A Display output interfaces(LCD, DPHY), =
as
> implemented in TSMC CLN28HPM PLL, this PLL supports the programmable
> integer division and range of the display output pixel clock's 27-594MHz.
>=20
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> ---
> change in v6:
>         - Add get the best loop multiplication divider from DTS.
>=20
>  drivers/clk/Kconfig      |  10 ++
>  drivers/clk/Makefile     |   1 +
>  drivers/clk/clk-plldig.c | 294
> +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 305 insertions(+)
>  create mode 100644 drivers/clk/clk-plldig.c
>=20
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig index
> 0530bebfc25a..9f6b0196c604 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -218,6 +218,16 @@ config CLK_QORIQ
>  	  This adds the clock driver support for Freescale QorIQ platforms
>  	  using common clock framework.
>=20
> +config CLK_LS1028A_PLLDIG
> +        tristate "Clock driver for LS1028A Display output"
> +        depends on ARCH_LAYERSCAPE || COMPILE_TEST
> +        default ARCH_LAYERSCAPE
> +        help
> +          This driver support the Display output interfaces(LCD, DPHY) p=
ixel
> clocks
> +          of the QorIQ Layerscape LS1028A, as implemented TSMC CLN28HPM
> PLL. Not all
> +          features of the PLL are currently supported by the driver. By =
default,
> +          configured bypass mode with this PLL.
> +
>  config COMMON_CLK_XGENE
>  	bool "Clock driver for APM XGene SoC"
>  	default ARCH_XGENE
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile index
> 0138fb14e6f8..d23b7464aba8 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_COMMON_CLK_OXNAS)		+=3D
> clk-oxnas.o
>  obj-$(CONFIG_COMMON_CLK_PALMAS)		+=3D clk-palmas.o
>  obj-$(CONFIG_COMMON_CLK_PWM)		+=3D clk-pwm.o
>  obj-$(CONFIG_CLK_QORIQ)			+=3D clk-qoriq.o
> +obj-$(CONFIG_CLK_LS1028A_PLLDIG)	+=3D clk-plldig.o

Wrong ordering.  This section of Makefile requires ordering by driver file =
name:

# hardware specific clock types
# please keep this section sorted lexicographically by file path name

>  obj-$(CONFIG_COMMON_CLK_RK808)		+=3D clk-rk808.o
>  obj-$(CONFIG_COMMON_CLK_HI655X)		+=3D clk-hi655x.o
>  obj-$(CONFIG_COMMON_CLK_S2MPS11)	+=3D clk-s2mps11.o
> diff --git a/drivers/clk/clk-plldig.c b/drivers/clk/clk-plldig.c new file=
 mode
> 100644 index 000000000000..57d8121990bd
> --- /dev/null
> +++ b/drivers/clk/clk-plldig.c
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 NXP
> + *
> + * Clock driver for LS1028A Display output interfaces(LCD, DPHY).
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/bitfield.h>
> +
> +/* PLLDIG register offsets and bit masks */
> +#define PLLDIG_REG_PLLSR            0x24
> +#define PLLDIG_REG_PLLDV            0x28
> +#define PLLDIG_REG_PLLFM            0x2c
> +#define PLLDIG_REG_PLLFD            0x30
> +#define PLLDIG_REG_PLLCAL1          0x38
> +#define PLLDIG_REG_PLLCAL2          0x3c
> +#define PLLDIG_LOCK_MASK            BIT(2)
> +#define PLLDIG_REG_FIELD_SSCGBYP    BIT(30)
> +#define PLLDIG_REG_FIELD_FDEN       BIT(30)
> +#define PLLDIG_REG_FIELD_DTHDIS     GENMASK(17, 16)
> +#define PLLDIG_REG_FIELD_MULT       GENMASK(7, 0)
> +#define PLLDIG_REG_FIELD_RFDPHI1    GENMASK(30, 25)
> +
> +/* Minimum output clock frequency, in Hz */ #define PHI1_MIN_FREQ
> +27000000
> +
> +/* Maximum output clock frequency, in Hz */ #define PHI1_MAX_FREQ
> +600000000
> +
> +/* Maximum of the divider */
> +#define MAX_RFDPHI1          63
> +
> +/*
> + * Clock configuration relationship between the PHI1
> +frequency(fpll_phi) and
> + * the output frequency of the PLL is determined by the PLLDV,
> +according to
> + * the following equation:
> + * fpll_phi =3D (pll_ref * mfd) / div_rfdphi1  */ struct
> +plldig_phi1_param {
> +	unsigned long rate;
> +	unsigned int rfdphi1;
> +	unsigned int mfd;
> +};
> +
> +static const struct clk_parent_data parent_data[] =3D {
> +	{.index =3D 0},
> +};
> +
> +struct clk_plldig {
> +	struct clk_hw hw;
> +	void __iomem *regs;
> +	unsigned int mfd;
> +};
> +
> +#define to_clk_plldig(_hw)	container_of(_hw, struct clk_plldig, hw)
> +
> +static int plldig_enable(struct clk_hw *hw) {
> +	struct clk_plldig *data =3D to_clk_plldig(hw);
> +	u32 val;
> +
> +	val =3D readl(data->regs + PLLDIG_REG_PLLFM);
> +	/*
> +	 * Use Bypass mode with PLL off by default, the frequency overshoot
> +	 * detector output was disable. SSCG Bypass mode should be enable.
> +	 */
> +	val |=3D PLLDIG_REG_FIELD_SSCGBYP;
> +	writel(val, data->regs + PLLDIG_REG_PLLFM);
> +
> +	val =3D readl(data->regs + PLLDIG_REG_PLLFD);
> +	/* Disable dither and Sigma delta modulation in bypass mode */
> +	val |=3D FIELD_PREP(PLLDIG_REG_FIELD_FDEN, 0x1) |
> +	       FIELD_PREP(PLLDIG_REG_FIELD_DTHDIS, 0x3);
> +
> +	writel(val, data->regs + PLLDIG_REG_PLLFD);
> +
> +	return 0;
> +}
> +
> +static void plldig_disable(struct clk_hw *hw) {
> +	struct clk_plldig *data =3D to_clk_plldig(hw);
> +	u32 val;
> +
> +	val =3D readl(data->regs + PLLDIG_REG_PLLFM);
> +
> +	val &=3D ~PLLDIG_REG_FIELD_SSCGBYP;
> +	val |=3D FIELD_PREP(PLLDIG_REG_FIELD_SSCGBYP, 0x0);
> +
> +	writel(val, data->regs + PLLDIG_REG_PLLFM); }
> +
> +static int plldig_is_enabled(struct clk_hw *hw) {
> +	struct clk_plldig *data =3D to_clk_plldig(hw);
> +
> +	return (readl(data->regs + PLLDIG_REG_PLLFM) &
> +			      PLLDIG_REG_FIELD_SSCGBYP);
> +}
> +
> +static unsigned long plldig_recalc_rate(struct clk_hw *hw,
> +		unsigned long parent_rate)
> +{
> +	struct clk_plldig *data =3D to_clk_plldig(hw);
> +	u32 mult, div, val;
> +
> +	val =3D readl(data->regs + PLLDIG_REG_PLLDV);
> +
> +	/* Check if PLL is bypassed */
> +	if (val & PLLDIG_REG_FIELD_SSCGBYP)
> +		return parent_rate;
> +
> +	/* Checkout multiplication factor divider value */
> +	mult =3D FIELD_GET(PLLDIG_REG_FIELD_MULT, val);
> +
> +	/* Checkout divider value of the output frequency */
> +	div =3D FIELD_GET(PLLDIG_REG_FIELD_RFDPHI1, val);
> +
> +	return (parent_rate * mult) / div;
> +}
> +
> +static int plldig_calc_target_rate(unsigned long target_rate,
> +				   unsigned long parent_rate,
> +				   struct plldig_phi1_param *phi1)
> +{
> +	unsigned int div, ret;
> +	unsigned long round_rate;
> +
> +	/* Range limitation of the request target rate */
> +	if (target_rate > PHI1_MAX_FREQ)
> +		target_rate =3D PHI1_MAX_FREQ;
> +	else if (target_rate < PHI1_MIN_FREQ)
> +		target_rate =3D PHI1_MIN_FREQ;
> +
> +	/*
> +	 * Firstly, check the request target rate whether is divisible
> +	 * by the best VCO frequency.
> +	 */
> +	round_rate =3D parent_rate * phi1->mfd;
> +	div =3D round_rate / target_rate;
> +	if (!div || div > MAX_RFDPHI1)
> +		return -EINVAL;
> +
> +	ret =3D round_rate % target_rate;
> +	if (ret) {
> +		/*
> +		 * Rounded down the request target rate, VESA specifies
> +		 * 0.5% pixel clock tolerance, therefore this algorithm
> +		 * can able to compatible a lot of request rates within
> +		 * range of the tolerance.
> +		 */
> +		round_rate +=3D (target_rate / 2);
> +		div =3D round_rate / target_rate;
> +		if (!div || div > MAX_RFDPHI1)
> +			return -EINVAL;
> +	}
> +
> +	phi1->rfdphi1 =3D div;
> +	phi1->rate =3D target_rate;
> +
> +	return 0;
> +}
> +
> +static int plldig_determine_rate(struct clk_hw *hw,
> +				 struct clk_rate_request *req)
> +{
> +	int ret;
> +	unsigned long parent_rate;
> +	struct clk_hw *parent;
> +	struct plldig_phi1_param phi1_param;
> +	struct clk_plldig *data =3D to_clk_plldig(hw);
> +
> +	if (!req->rate)
> +		return -ERANGE;
> +
> +	phi1_param.mfd =3D data->mfd;
> +	parent =3D clk_hw_get_parent(hw);
> +	parent_rate =3D clk_hw_get_rate(parent);
> +
> +	ret =3D plldig_calc_target_rate(req->rate, parent_rate, &phi1_param);
> +	if (ret)
> +		return ret;
> +
> +	req->rate =3D phi1_param.rate;
> +
> +	return 0;
> +}
> +
> +static int plldig_set_rate(struct clk_hw *hw, unsigned long rate,
> +		unsigned long parent_rate)
> +{
> +	struct clk_plldig *data =3D to_clk_plldig(hw);
> +	struct plldig_phi1_param phi1_param;
> +	unsigned int val, cond;
> +	int ret;
> +
> +	ret =3D plldig_calc_target_rate(rate, parent_rate, &phi1_param);
> +	if (ret)
> +		return ret;
> +
> +	val =3D readl(data->regs + PLLDIG_REG_PLLDV);
> +	val =3D FIELD_PREP(PLLDIG_REG_FIELD_MULT, data->mfd) |
> +	      FIELD_PREP(PLLDIG_REG_FIELD_RFDPHI1, phi1_param.rfdphi1);
> +
> +	writel(val, data->regs + PLLDIG_REG_PLLDV);
> +
> +	/* delay 200us make sure that old lock state is cleared */
> +	udelay(200);
> +
> +	/* Wait until PLL is locked or timeout (maximum 1000 usecs) */
> +	return readl_poll_timeout_atomic(data->regs + PLLDIG_REG_PLLSR,
> cond,
> +					 cond & PLLDIG_LOCK_MASK, 0,
> +					 USEC_PER_MSEC);
> +}
> +
> +static const struct clk_ops plldig_clk_ops =3D {
> +	.enable =3D plldig_enable,
> +	.disable =3D plldig_disable,
> +	.is_enabled =3D plldig_is_enabled,
> +	.recalc_rate =3D plldig_recalc_rate,
> +	.determine_rate =3D plldig_determine_rate,
> +	.set_rate =3D plldig_set_rate,
> +};
> +
> +static int plldig_clk_probe(struct platform_device *pdev) {
> +	struct clk_plldig *data;
> +	struct resource *mem;
> +	struct device *dev =3D &pdev->dev;
> +	int ret;
> +
> +	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->regs =3D devm_ioremap_resource(dev, mem);
> +	if (IS_ERR(data->regs))
> +		return PTR_ERR(data->regs);
> +
> +	 /*
> +	  * Support to get the best loop multiplication divider value
> +	  * from DTS file, since this PLL can't changed this value on
> +	  * the fly, write the fixed value.
> +	  */
> +	ret =3D of_property_read_u32(dev->of_node, "best-mfd", &data-
> >mfd);
> +	if (ret)
> +		data->mfd =3D 0x2c;
> +
> +	data->hw.init =3D CLK_HW_INIT_PARENTS_DATA("dpclk",
> +						 parent_data,
> +						 &plldig_clk_ops,
> +						 0);
> +
> +	ret =3D devm_clk_hw_register(dev, &data->hw);
> +	if (ret) {
> +		dev_err(dev, "failed to register %s clock\n",
> +						dev->of_node->name);
> +		return ret;
> +	}
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
> +					   &data->hw);
> +}
> +
> +static const struct of_device_id plldig_clk_id[] =3D {
> +	{ .compatible =3D "fsl,ls1028a-plldig"},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, plldig_clk_id);
> +
> +static struct platform_driver plldig_clk_driver =3D {
> +	.driver =3D {
> +		.name =3D "plldig-clock",
> +		.of_match_table =3D plldig_clk_id,
> +	},
> +	.probe =3D plldig_clk_probe,
> +};
> +module_platform_driver(plldig_clk_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Wen He <wen.he_1@nxp.com>");
> MODULE_DESCRIPTION("LS1028A
> +Display output interface pixel clock driver");
> --
> 2.17.1

