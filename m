Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E394CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 21:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1502071B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 21:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xto1aq4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfKVVuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 16:50:39 -0500
Received: from mail-eopbgr20050.outbound.protection.outlook.com ([40.107.2.50]:47685
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726089AbfKVVuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 16:50:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUDjeTAin+s/dgydtVAn4iYJKY0S/Btt6OHeLKWV3nNj2Axs8K9j/F+KOQmqEA3uiIR9CJaAFh7dytBcU0H+R0r90TTmI5BNXnN0p+AwB5XlVs+viaZcTblYeCLHTd1Ne4jWKkks6OVvMcnbnDeAzZHQ/3IsDeKLa+StYAp6KIaybHaYr2by2ckCsROtxyvJrf/WaK9vwRD7mGyJevjCn+7HiJbzoHrlYtyfxDaHBhtOOdALaVMQIuikOawAd18UiPmi1goUlFOVGM3Ynhm9fjTZ4GrLQZS2KJUziU9O5nwKoLXlEMf2C7h6kgRvZrugXPSCIoZbrc07AQGHohS/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3fHPGJLQ/lGHHMZBkvo9UnvRNyLbSlataNJGo7rYMk=;
 b=Sjar8Yt3gq14BB2FrlfGb3k3YE6SBKRCKeLjmKP4R5JLPyvpgvsIYOAhXRScNnrq8gtOHjqkzlXggqA0uSbLUKnITgtYPhz8HCtI4kl9p1a7Eyuv62Z2rcSqYnqnBqjqU83PAGPgTFbYlYgEH24COYn+Vp7J1EReC5htxMYDyqLC8ilwkw45rkdtgkqpbBKRbTKJAUaZjDBi+UUVa/gUwEdmkjWO/MBA2F67ry3FP1GZT6Dam5DbkHUBClliShtnAtigwwIVH8vT2SAC83xPHmYsVxiCqvBa/E05ql4f+p0tDe0FrXsUVXp388P+ExwXRv9UiGWVf1D/1O3OS8qNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3fHPGJLQ/lGHHMZBkvo9UnvRNyLbSlataNJGo7rYMk=;
 b=Xto1aq4pKSklSN5ytmpKh93hLK4S5SyD52TzdTMQ9S1nZ2lma243FpfrbWhW0fCFLKB+ruk8K6RoCl2ox8Gx2TtQuf6TEsP68wZVXF3MLjm87mcEkH+K1xGrWYCwgxngfPEI15IfvP0Qznzw9uLtSDYNiIr80x3+ivdB/Tg+cbQ=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB3149.eurprd04.prod.outlook.com (10.170.229.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Fri, 22 Nov 2019 21:50:26 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2474.021; Fri, 22 Nov 2019
 21:50:26 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/11] clk: imx: Rename the SCCG to SSCG
Thread-Topic: [PATCH v2 02/11] clk: imx: Rename the SCCG to SSCG
Thread-Index: AQHVoSJWPnEyVXaurE6C0sqSvmTOAg==
Date:   Fri, 22 Nov 2019 21:50:26 +0000
Message-ID: <VI1PR04MB702329ECA12C1135819809DFEE490@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1574419679-3813-1-git-send-email-abel.vesa@nxp.com>
 <1574419679-3813-3-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49b21066-0472-464b-5fcb-08d76f95fbde
x-ms-traffictypediagnostic: VI1PR04MB3149:|VI1PR04MB3149:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB314973F2C8190F5FCDCA3409EE490@VI1PR04MB3149.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(189003)(199004)(3846002)(66066001)(55016002)(6246003)(102836004)(6436002)(4326008)(71200400001)(71190400001)(30864003)(86362001)(256004)(2906002)(14444005)(6116002)(186003)(4001150100001)(229853002)(26005)(6506007)(7736002)(966005)(74316002)(478600001)(44832011)(110136005)(52536014)(33656002)(9686003)(66946007)(76116006)(91956017)(66446008)(64756008)(66476007)(5660300002)(66556008)(53546011)(305945005)(8936002)(81166006)(446003)(6306002)(76176011)(25786009)(7696005)(316002)(14454004)(99286004)(81156014)(8676002)(54906003)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3149;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: asE0otjpsRaNiLTfOTIkmO5cKOfXrnDIOKV3u/eJ6j6e+z2POpkAkSjT4YWd1DLSUygfWJFVuJJJq9PhW+vyKkJKYgfy1BbLNoPhG7dGhP45l6OlL3aSrI9nWXpV49Hyxc6+REyrkI2DwGLCIVTb6+bwqdAt49N+zDn7tvUqNjFuNmXorfXMRmG7buCq8ItaTluM1AIPTttsc5kYxmXnw317y8LtMcyiNJjn06CxFdhb870450b1JVoP7Rjd/K+v8AJxuAsN+y+sdguNF/5zEftmAZ7s+qdVoW5RP1KpvjG1+m0n8JT/Zt5/yVb+ySxCyjBC7j6LQiR2huYC7EEyPhu4mBaD/o6xeAhBRmfFI2jQH10mHhQn5F+U6vW7ehzKIYbidV7R6DMQwyvGv9u+OlBkMVmz3HL9pFc6LMZYfU/GjRXHqX3WufYPp3sluKv4RvaZ8zrUsC3k/CR3GSdJ/qQ8xmMgBbmRC3CYYjQdpe4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b21066-0472-464b-5fcb-08d76f95fbde
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 21:50:26.1295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBYP2vxmBL106Gde5m5C6sZ6RCAvsagNNseDvHcGXPe3zuwtlghBaqIoFs3UrVl5nqKTP3dCgh0sMNg+fzfSdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-22 12:48 PM, Abel Vesa wrote:=0A=
> According to the manual the acronym stands for=0A=
> Spread Sprectum Clock Generator.=0A=
> =0A=
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>=0A=
=0A=
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
=0A=
This misspelling bothered me for some reason.=0A=
=0A=
> ---=0A=
>   drivers/clk/imx/Makefile       |   2 +-=0A=
>   drivers/clk/imx/clk-imx8mq.c   |   6 +-=0A=
>   drivers/clk/imx/clk-sccg-pll.c | 549 ----------------------------------=
-------=0A=
>   drivers/clk/imx/clk-sscg-pll.c | 549 ++++++++++++++++++++++++++++++++++=
+++++++=0A=
>   drivers/clk/imx/clk.h          |   4 +-=0A=
>   5 files changed, 555 insertions(+), 555 deletions(-)=0A=
>   delete mode 100644 drivers/clk/imx/clk-sccg-pll.c=0A=
>   create mode 100644 drivers/clk/imx/clk-sscg-pll.c=0A=
> =0A=
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile=0A=
> index 77a3d71..3724ba7 100644=0A=
> --- a/drivers/clk/imx/Makefile=0A=
> +++ b/drivers/clk/imx/Makefile=0A=
> @@ -18,7 +18,7 @@ obj-$(CONFIG_MXC_CLK) +=3D \=0A=
>   	clk-pllv2.o \=0A=
>   	clk-pllv3.o \=0A=
>   	clk-pllv4.o \=0A=
> -	clk-sccg-pll.o \=0A=
> +	clk-sscg-pll.o \=0A=
>   	clk-pll14xx.o=0A=
>   =0A=
>   obj-$(CONFIG_MXC_CLK_SCU) +=3D \=0A=
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c=
=0A=
> index 5f10a60..f2a35b1 100644=0A=
> --- a/drivers/clk/imx/clk-imx8mq.c=0A=
> +++ b/drivers/clk/imx/clk-imx8mq.c=0A=
> @@ -342,9 +342,9 @@ static int imx8mq_clocks_probe(struct platform_device=
 *pdev)=0A=
>   =0A=
>   	clks[IMX8MQ_SYS1_PLL_OUT] =3D imx_clk_fixed("sys1_pll_out", 800000000)=
;=0A=
>   	clks[IMX8MQ_SYS2_PLL_OUT] =3D imx_clk_fixed("sys2_pll_out", 1000000000=
);=0A=
> -	clks[IMX8MQ_SYS3_PLL_OUT] =3D imx_clk_sccg_pll("sys3_pll_out", sys3_pll=
_out_sels, ARRAY_SIZE(sys3_pll_out_sels), 0, 0, 0, base + 0x48, CLK_IS_CRIT=
ICAL);=0A=
> -	clks[IMX8MQ_DRAM_PLL_OUT] =3D imx_clk_sccg_pll("dram_pll_out", dram_pll=
_out_sels, ARRAY_SIZE(dram_pll_out_sels), 0, 0, 0, base + 0x60, CLK_IS_CRIT=
ICAL);=0A=
> -	clks[IMX8MQ_VIDEO2_PLL_OUT] =3D imx_clk_sccg_pll("video2_pll_out", vide=
o2_pll_out_sels, ARRAY_SIZE(video2_pll_out_sels), 0, 0, 0, base + 0x54, 0);=
=0A=
> +	clks[IMX8MQ_SYS3_PLL_OUT] =3D imx_clk_sscg_pll("sys3_pll_out", sys3_pll=
_out_sels, ARRAY_SIZE(sys3_pll_out_sels), 0, 0, 0, base + 0x48, CLK_IS_CRIT=
ICAL);=0A=
> +	clks[IMX8MQ_DRAM_PLL_OUT] =3D imx_clk_sscg_pll("dram_pll_out", dram_pll=
_out_sels, ARRAY_SIZE(dram_pll_out_sels), 0, 0, 0, base + 0x60, CLK_IS_CRIT=
ICAL);=0A=
> +	clks[IMX8MQ_VIDEO2_PLL_OUT] =3D imx_clk_sscg_pll("video2_pll_out", vide=
o2_pll_out_sels, ARRAY_SIZE(video2_pll_out_sels), 0, 0, 0, base + 0x54, 0);=
=0A=
>   =0A=
>   	/* SYS PLL1 fixed output */=0A=
>   	clks[IMX8MQ_SYS1_PLL_40M_CG] =3D imx_clk_gate("sys1_pll_40m_cg", "sys1=
_pll_out", base + 0x30, 9);=0A=
> diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-pl=
l.c=0A=
> deleted file mode 100644=0A=
> index 5d65f65..00000000=0A=
> --- a/drivers/clk/imx/clk-sccg-pll.c=0A=
> +++ /dev/null=0A=
> @@ -1,549 +0,0 @@=0A=
> -// SPDX-License-Identifier: (GPL-2.0 OR MIT)=0A=
> -/*=0A=
> - * Copyright 2018 NXP.=0A=
> - *=0A=
> - * This driver supports the SCCG plls found in the imx8m SOCs=0A=
> - *=0A=
> - * Documentation for this SCCG pll can be found at:=0A=
> - *   https://www.nxp.com/docs/en/reference-manual/IMX8MDQLQRM.pdf#page=
=3D834=0A=
> - */=0A=
> -=0A=
> -#include <linux/clk-provider.h>=0A=
> -#include <linux/err.h>=0A=
> -#include <linux/io.h>=0A=
> -#include <linux/iopoll.h>=0A=
> -#include <linux/slab.h>=0A=
> -#include <linux/bitfield.h>=0A=
> -=0A=
> -#include "clk.h"=0A=
> -=0A=
> -/* PLL CFGs */=0A=
> -#define PLL_CFG0		0x0=0A=
> -#define PLL_CFG1		0x4=0A=
> -#define PLL_CFG2		0x8=0A=
> -=0A=
> -#define PLL_DIVF1_MASK		GENMASK(18, 13)=0A=
> -#define PLL_DIVF2_MASK		GENMASK(12, 7)=0A=
> -#define PLL_DIVR1_MASK		GENMASK(27, 25)=0A=
> -#define PLL_DIVR2_MASK		GENMASK(24, 19)=0A=
> -#define PLL_DIVQ_MASK           GENMASK(6, 1)=0A=
> -#define PLL_REF_MASK		GENMASK(2, 0)=0A=
> -=0A=
> -#define PLL_LOCK_MASK		BIT(31)=0A=
> -#define PLL_PD_MASK		BIT(7)=0A=
> -=0A=
> -/* These are the specification limits for the SSCG PLL */=0A=
> -#define PLL_REF_MIN_FREQ		25000000UL=0A=
> -#define PLL_REF_MAX_FREQ		235000000UL=0A=
> -=0A=
> -#define PLL_STAGE1_MIN_FREQ		1600000000UL=0A=
> -#define PLL_STAGE1_MAX_FREQ		2400000000UL=0A=
> -=0A=
> -#define PLL_STAGE1_REF_MIN_FREQ		25000000UL=0A=
> -#define PLL_STAGE1_REF_MAX_FREQ		54000000UL=0A=
> -=0A=
> -#define PLL_STAGE2_MIN_FREQ		1200000000UL=0A=
> -#define PLL_STAGE2_MAX_FREQ		2400000000UL=0A=
> -=0A=
> -#define PLL_STAGE2_REF_MIN_FREQ		54000000UL=0A=
> -#define PLL_STAGE2_REF_MAX_FREQ		75000000UL=0A=
> -=0A=
> -#define PLL_OUT_MIN_FREQ		20000000UL=0A=
> -#define PLL_OUT_MAX_FREQ		1200000000UL=0A=
> -=0A=
> -#define PLL_DIVR1_MAX			7=0A=
> -#define PLL_DIVR2_MAX			63=0A=
> -#define PLL_DIVF1_MAX			63=0A=
> -#define PLL_DIVF2_MAX			63=0A=
> -#define PLL_DIVQ_MAX			63=0A=
> -=0A=
> -#define PLL_BYPASS_NONE			0x0=0A=
> -#define PLL_BYPASS1			0x2=0A=
> -#define PLL_BYPASS2			0x1=0A=
> -=0A=
> -#define SSCG_PLL_BYPASS1_MASK           BIT(5)=0A=
> -#define SSCG_PLL_BYPASS2_MASK           BIT(4)=0A=
> -#define SSCG_PLL_BYPASS_MASK		GENMASK(5, 4)=0A=
> -=0A=
> -#define PLL_SCCG_LOCK_TIMEOUT		70=0A=
> -=0A=
> -struct clk_sccg_pll_setup {=0A=
> -	int divr1, divf1;=0A=
> -	int divr2, divf2;=0A=
> -	int divq;=0A=
> -	int bypass;=0A=
> -=0A=
> -	uint64_t vco1;=0A=
> -	uint64_t vco2;=0A=
> -	uint64_t fout;=0A=
> -	uint64_t ref;=0A=
> -	uint64_t ref_div1;=0A=
> -	uint64_t ref_div2;=0A=
> -	uint64_t fout_request;=0A=
> -	int fout_error;=0A=
> -};=0A=
> -=0A=
> -struct clk_sccg_pll {=0A=
> -	struct clk_hw	hw;=0A=
> -	const struct clk_ops  ops;=0A=
> -=0A=
> -	void __iomem *base;=0A=
> -=0A=
> -	struct clk_sccg_pll_setup setup;=0A=
> -=0A=
> -	u8 parent;=0A=
> -	u8 bypass1;=0A=
> -	u8 bypass2;=0A=
> -};=0A=
> -=0A=
> -#define to_clk_sccg_pll(_hw) container_of(_hw, struct clk_sccg_pll, hw)=
=0A=
> -=0A=
> -static int clk_sccg_pll_wait_lock(struct clk_sccg_pll *pll)=0A=
> -{=0A=
> -	u32 val;=0A=
> -=0A=
> -	val =3D readl_relaxed(pll->base + PLL_CFG0);=0A=
> -=0A=
> -	/* don't wait for lock if all plls are bypassed */=0A=
> -	if (!(val & SSCG_PLL_BYPASS2_MASK))=0A=
> -		return readl_poll_timeout(pll->base, val, val & PLL_LOCK_MASK,=0A=
> -						0, PLL_SCCG_LOCK_TIMEOUT);=0A=
> -=0A=
> -	return 0;=0A=
> -}=0A=
> -=0A=
> -static int clk_sccg_pll2_check_match(struct clk_sccg_pll_setup *setup,=
=0A=
> -					struct clk_sccg_pll_setup *temp_setup)=0A=
> -{=0A=
> -	int new_diff =3D temp_setup->fout - temp_setup->fout_request;=0A=
> -	int diff =3D temp_setup->fout_error;=0A=
> -=0A=
> -	if (abs(diff) > abs(new_diff)) {=0A=
> -		temp_setup->fout_error =3D new_diff;=0A=
> -		memcpy(setup, temp_setup, sizeof(struct clk_sccg_pll_setup));=0A=
> -=0A=
> -		if (temp_setup->fout_request =3D=3D temp_setup->fout)=0A=
> -			return 0;=0A=
> -	}=0A=
> -	return -1;=0A=
> -}=0A=
> -=0A=
> -static int clk_sccg_divq_lookup(struct clk_sccg_pll_setup *setup,=0A=
> -				struct clk_sccg_pll_setup *temp_setup)=0A=
> -{=0A=
> -	int ret =3D -EINVAL;=0A=
> -=0A=
> -	for (temp_setup->divq =3D 0; temp_setup->divq <=3D PLL_DIVQ_MAX;=0A=
> -	     temp_setup->divq++) {=0A=
> -		temp_setup->vco2 =3D temp_setup->vco1;=0A=
> -		do_div(temp_setup->vco2, temp_setup->divr2 + 1);=0A=
> -		temp_setup->vco2 *=3D 2;=0A=
> -		temp_setup->vco2 *=3D temp_setup->divf2 + 1;=0A=
> -		if (temp_setup->vco2 >=3D PLL_STAGE2_MIN_FREQ &&=0A=
> -				temp_setup->vco2 <=3D PLL_STAGE2_MAX_FREQ) {=0A=
> -			temp_setup->fout =3D temp_setup->vco2;=0A=
> -			do_div(temp_setup->fout, 2 * (temp_setup->divq + 1));=0A=
> -=0A=
> -			ret =3D clk_sccg_pll2_check_match(setup, temp_setup);=0A=
> -			if (!ret) {=0A=
> -				temp_setup->bypass =3D PLL_BYPASS1;=0A=
> -				return ret;=0A=
> -			}=0A=
> -		}=0A=
> -	}=0A=
> -=0A=
> -	return ret;=0A=
> -}=0A=
> -=0A=
> -static int clk_sccg_divf2_lookup(struct clk_sccg_pll_setup *setup,=0A=
> -					struct clk_sccg_pll_setup *temp_setup)=0A=
> -{=0A=
> -	int ret =3D -EINVAL;=0A=
> -=0A=
> -	for (temp_setup->divf2 =3D 0; temp_setup->divf2 <=3D PLL_DIVF2_MAX;=0A=
> -	     temp_setup->divf2++) {=0A=
> -		ret =3D clk_sccg_divq_lookup(setup, temp_setup);=0A=
> -		if (!ret)=0A=
> -			return ret;=0A=
> -	}=0A=
> -=0A=
> -	return ret;=0A=
> -}=0A=
> -=0A=
> -static int clk_sccg_divr2_lookup(struct clk_sccg_pll_setup *setup,=0A=
> -				struct clk_sccg_pll_setup *temp_setup)=0A=
> -{=0A=
> -	int ret =3D -EINVAL;=0A=
> -=0A=
> -	for (temp_setup->divr2 =3D 0; temp_setup->divr2 <=3D PLL_DIVR2_MAX;=0A=
> -	     temp_setup->divr2++) {=0A=
> -		temp_setup->ref_div2 =3D temp_setup->vco1;=0A=
> -		do_div(temp_setup->ref_div2, temp_setup->divr2 + 1);=0A=
> -		if (temp_setup->ref_div2 >=3D PLL_STAGE2_REF_MIN_FREQ &&=0A=
> -		    temp_setup->ref_div2 <=3D PLL_STAGE2_REF_MAX_FREQ) {=0A=
> -			ret =3D clk_sccg_divf2_lookup(setup, temp_setup);=0A=
> -			if (!ret)=0A=
> -				return ret;=0A=
> -		}=0A=
> -	}=0A=
> -=0A=
> -	return ret;=0A=
> -}=0A=
> -=0A=
> -static int clk_sccg_pll2_find_setup(struct clk_sccg_pll_setup *setup,=0A=
> -					struct clk_sccg_pll_setup *temp_setup,=0A=
> -					uint64_t ref)=0A=
> -{=0A=
> -=0A=
> -	int ret =3D -EINVAL;=0A=
> -=0A=
> -	if (ref < PLL_STAGE1_MIN_FREQ || ref > PLL_STAGE1_MAX_FREQ)=0A=
> -		return ret;=0A=
> -=0A=
> -	temp_setup->vco1 =3D ref;=0A=
> -=0A=
> -	ret =3D clk_sccg_divr2_lookup(setup, temp_setup);=0A=
> -	return ret;=0A=
> -}=0A=
> -=0A=
> -static int clk_sccg_divf1_lookup(struct clk_sccg_pll_setup *setup,=0A=
> -				struct clk_sccg_pll_setup *temp_setup)=0A=
> -{=0A=
> -	int ret =3D -EINVAL;=0A=
> -=0A=
> -	for (temp_setup->divf1 =3D 0; temp_setup->divf1 <=3D PLL_DIVF1_MAX;=0A=
> -	     temp_setup->divf1++) {=0A=
> -		uint64_t vco1 =3D temp_setup->ref;=0A=
> -=0A=
> -		do_div(vco1, temp_setup->divr1 + 1);=0A=
> -		vco1 *=3D 2;=0A=
> -		vco1 *=3D temp_setup->divf1 + 1;=0A=
> -=0A=
> -		ret =3D clk_sccg_pll2_find_setup(setup, temp_setup, vco1);=0A=
> -		if (!ret) {=0A=
> -			temp_setup->bypass =3D PLL_BYPASS_NONE;=0A=
> -			return ret;=0A=
> -		}=0A=
> -	}=0A=
> -=0A=
> -	return ret;=0A=
> -}=0A=
> -=0A=
> -static int clk_sccg_divr1_lookup(struct clk_sccg_pll_setup *setup,=0A=
> -				struct clk_sccg_pll_setup *temp_setup)=0A=
> -{=0A=
> -	int ret =3D -EINVAL;=0A=
> -=0A=
> -	for (temp_setup->divr1 =3D 0; temp_setup->divr1 <=3D PLL_DIVR1_MAX;=0A=
> -	     temp_setup->divr1++) {=0A=
> -		temp_setup->ref_div1 =3D temp_setup->ref;=0A=
> -		do_div(temp_setup->ref_div1, temp_setup->divr1 + 1);=0A=
> -		if (temp_setup->ref_div1 >=3D PLL_STAGE1_REF_MIN_FREQ &&=0A=
> -		    temp_setup->ref_div1 <=3D PLL_STAGE1_REF_MAX_FREQ) {=0A=
> -			ret =3D clk_sccg_divf1_lookup(setup, temp_setup);=0A=
> -			if (!ret)=0A=
> -				return ret;=0A=
> -		}=0A=
> -	}=0A=
> -=0A=
> -	return ret;=0A=
> -}=0A=
> -=0A=
> -static int clk_sccg_pll1_find_setup(struct clk_sccg_pll_setup *setup,=0A=
> -					struct clk_sccg_pll_setup *temp_setup,=0A=
> -					uint64_t ref)=0A=
> -{=0A=
> -=0A=
> -	int ret =3D -EINVAL;=0A=
> -=0A=
> -	if (ref < PLL_REF_MIN_FREQ || ref > PLL_REF_MAX_FREQ)=0A=
> -		return ret;=0A=
> -=0A=
> -	temp_setup->ref =3D ref;=0A=
> -=0A=
> -	ret =3D clk_sccg_divr1_lookup(setup, temp_setup);=0A=
> -=0A=
> -	return ret;=0A=
> -}=0A=
> -=0A=
> -static int clk_sccg_pll_find_setup(struct clk_sccg_pll_setup *setup,=0A=
> -					uint64_t prate,=0A=
> -					uint64_t rate, int try_bypass)=0A=
> -{=0A=
> -	struct clk_sccg_pll_setup temp_setup;=0A=
> -	int ret =3D -EINVAL;=0A=
> -=0A=
> -	memset(&temp_setup, 0, sizeof(struct clk_sccg_pll_setup));=0A=
> -	memset(setup, 0, sizeof(struct clk_sccg_pll_setup));=0A=
> -=0A=
> -	temp_setup.fout_error =3D PLL_OUT_MAX_FREQ;=0A=
> -	temp_setup.fout_request =3D rate;=0A=
> -=0A=
> -	switch (try_bypass) {=0A=
> -=0A=
> -	case PLL_BYPASS2:=0A=
> -		if (prate =3D=3D rate) {=0A=
> -			setup->bypass =3D PLL_BYPASS2;=0A=
> -			setup->fout =3D rate;=0A=
> -			ret =3D 0;=0A=
> -		}=0A=
> -		break;=0A=
> -=0A=
> -	case PLL_BYPASS1:=0A=
> -		ret =3D clk_sccg_pll2_find_setup(setup, &temp_setup, prate);=0A=
> -		break;=0A=
> -=0A=
> -	case PLL_BYPASS_NONE:=0A=
> -		ret =3D clk_sccg_pll1_find_setup(setup, &temp_setup, prate);=0A=
> -		break;=0A=
> -	}=0A=
> -=0A=
> -	return ret;=0A=
> -}=0A=
> -=0A=
> -=0A=
> -static int clk_sccg_pll_is_prepared(struct clk_hw *hw)=0A=
> -{=0A=
> -	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);=0A=
> -=0A=
> -	u32 val =3D readl_relaxed(pll->base + PLL_CFG0);=0A=
> -=0A=
> -	return (val & PLL_PD_MASK) ? 0 : 1;=0A=
> -}=0A=
> -=0A=
> -static int clk_sccg_pll_prepare(struct clk_hw *hw)=0A=
> -{=0A=
> -	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);=0A=
> -	u32 val;=0A=
> -=0A=
> -	val =3D readl_relaxed(pll->base + PLL_CFG0);=0A=
> -	val &=3D ~PLL_PD_MASK;=0A=
> -	writel_relaxed(val, pll->base + PLL_CFG0);=0A=
> -=0A=
> -	return clk_sccg_pll_wait_lock(pll);=0A=
> -}=0A=
> -=0A=
> -static void clk_sccg_pll_unprepare(struct clk_hw *hw)=0A=
> -{=0A=
> -	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);=0A=
> -	u32 val;=0A=
> -=0A=
> -	val =3D readl_relaxed(pll->base + PLL_CFG0);=0A=
> -	val |=3D PLL_PD_MASK;=0A=
> -	writel_relaxed(val, pll->base + PLL_CFG0);=0A=
> -}=0A=
> -=0A=
> -static unsigned long clk_sccg_pll_recalc_rate(struct clk_hw *hw,=0A=
> -					 unsigned long parent_rate)=0A=
> -{=0A=
> -	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);=0A=
> -	u32 val, divr1, divf1, divr2, divf2, divq;=0A=
> -	u64 temp64;=0A=
> -=0A=
> -	val =3D readl_relaxed(pll->base + PLL_CFG2);=0A=
> -	divr1 =3D FIELD_GET(PLL_DIVR1_MASK, val);=0A=
> -	divr2 =3D FIELD_GET(PLL_DIVR2_MASK, val);=0A=
> -	divf1 =3D FIELD_GET(PLL_DIVF1_MASK, val);=0A=
> -	divf2 =3D FIELD_GET(PLL_DIVF2_MASK, val);=0A=
> -	divq =3D FIELD_GET(PLL_DIVQ_MASK, val);=0A=
> -=0A=
> -	temp64 =3D parent_rate;=0A=
> -=0A=
> -	val =3D readl(pll->base + PLL_CFG0);=0A=
> -	if (val & SSCG_PLL_BYPASS2_MASK) {=0A=
> -		temp64 =3D parent_rate;=0A=
> -	} else if (val & SSCG_PLL_BYPASS1_MASK) {=0A=
> -		temp64 *=3D divf2;=0A=
> -		do_div(temp64, (divr2 + 1) * (divq + 1));=0A=
> -	} else {=0A=
> -		temp64 *=3D 2;=0A=
> -		temp64 *=3D (divf1 + 1) * (divf2 + 1);=0A=
> -		do_div(temp64, (divr1 + 1) * (divr2 + 1) * (divq + 1));=0A=
> -	}=0A=
> -=0A=
> -	return temp64;=0A=
> -}=0A=
> -=0A=
> -static int clk_sccg_pll_set_rate(struct clk_hw *hw, unsigned long rate,=
=0A=
> -			    unsigned long parent_rate)=0A=
> -{=0A=
> -	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);=0A=
> -	struct clk_sccg_pll_setup *setup =3D &pll->setup;=0A=
> -	u32 val;=0A=
> -=0A=
> -	/* set bypass here too since the parent might be the same */=0A=
> -	val =3D readl(pll->base + PLL_CFG0);=0A=
> -	val &=3D ~SSCG_PLL_BYPASS_MASK;=0A=
> -	val |=3D FIELD_PREP(SSCG_PLL_BYPASS_MASK, setup->bypass);=0A=
> -	writel(val, pll->base + PLL_CFG0);=0A=
> -=0A=
> -	val =3D readl_relaxed(pll->base + PLL_CFG2);=0A=
> -	val &=3D ~(PLL_DIVF1_MASK | PLL_DIVF2_MASK);=0A=
> -	val &=3D ~(PLL_DIVR1_MASK | PLL_DIVR2_MASK | PLL_DIVQ_MASK);=0A=
> -	val |=3D FIELD_PREP(PLL_DIVF1_MASK, setup->divf1);=0A=
> -	val |=3D FIELD_PREP(PLL_DIVF2_MASK, setup->divf2);=0A=
> -	val |=3D FIELD_PREP(PLL_DIVR1_MASK, setup->divr1);=0A=
> -	val |=3D FIELD_PREP(PLL_DIVR2_MASK, setup->divr2);=0A=
> -	val |=3D FIELD_PREP(PLL_DIVQ_MASK, setup->divq);=0A=
> -	writel_relaxed(val, pll->base + PLL_CFG2);=0A=
> -=0A=
> -	return clk_sccg_pll_wait_lock(pll);=0A=
> -}=0A=
> -=0A=
> -static u8 clk_sccg_pll_get_parent(struct clk_hw *hw)=0A=
> -{=0A=
> -	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);=0A=
> -	u32 val;=0A=
> -	u8 ret =3D pll->parent;=0A=
> -=0A=
> -	val =3D readl(pll->base + PLL_CFG0);=0A=
> -	if (val & SSCG_PLL_BYPASS2_MASK)=0A=
> -		ret =3D pll->bypass2;=0A=
> -	else if (val & SSCG_PLL_BYPASS1_MASK)=0A=
> -		ret =3D pll->bypass1;=0A=
> -	return ret;=0A=
> -}=0A=
> -=0A=
> -static int clk_sccg_pll_set_parent(struct clk_hw *hw, u8 index)=0A=
> -{=0A=
> -	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);=0A=
> -	u32 val;=0A=
> -=0A=
> -	val =3D readl(pll->base + PLL_CFG0);=0A=
> -	val &=3D ~SSCG_PLL_BYPASS_MASK;=0A=
> -	val |=3D FIELD_PREP(SSCG_PLL_BYPASS_MASK, pll->setup.bypass);=0A=
> -	writel(val, pll->base + PLL_CFG0);=0A=
> -=0A=
> -	return clk_sccg_pll_wait_lock(pll);=0A=
> -}=0A=
> -=0A=
> -static int __clk_sccg_pll_determine_rate(struct clk_hw *hw,=0A=
> -					struct clk_rate_request *req,=0A=
> -					uint64_t min,=0A=
> -					uint64_t max,=0A=
> -					uint64_t rate,=0A=
> -					int bypass)=0A=
> -{=0A=
> -	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);=0A=
> -	struct clk_sccg_pll_setup *setup =3D &pll->setup;=0A=
> -	struct clk_hw *parent_hw =3D NULL;=0A=
> -	int bypass_parent_index;=0A=
> -	int ret =3D -EINVAL;=0A=
> -=0A=
> -	req->max_rate =3D max;=0A=
> -	req->min_rate =3D min;=0A=
> -=0A=
> -	switch (bypass) {=0A=
> -	case PLL_BYPASS2:=0A=
> -		bypass_parent_index =3D pll->bypass2;=0A=
> -		break;=0A=
> -	case PLL_BYPASS1:=0A=
> -		bypass_parent_index =3D pll->bypass1;=0A=
> -		break;=0A=
> -	default:=0A=
> -		bypass_parent_index =3D pll->parent;=0A=
> -		break;=0A=
> -	}=0A=
> -=0A=
> -	parent_hw =3D clk_hw_get_parent_by_index(hw, bypass_parent_index);=0A=
> -	ret =3D __clk_determine_rate(parent_hw, req);=0A=
> -	if (!ret) {=0A=
> -		ret =3D clk_sccg_pll_find_setup(setup, req->rate,=0A=
> -						rate, bypass);=0A=
> -	}=0A=
> -=0A=
> -	req->best_parent_hw =3D parent_hw;=0A=
> -	req->best_parent_rate =3D req->rate;=0A=
> -	req->rate =3D setup->fout;=0A=
> -=0A=
> -	return ret;=0A=
> -}=0A=
> -=0A=
> -static int clk_sccg_pll_determine_rate(struct clk_hw *hw,=0A=
> -				       struct clk_rate_request *req)=0A=
> -{=0A=
> -	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);=0A=
> -	struct clk_sccg_pll_setup *setup =3D &pll->setup;=0A=
> -	uint64_t rate =3D req->rate;=0A=
> -	uint64_t min =3D req->min_rate;=0A=
> -	uint64_t max =3D req->max_rate;=0A=
> -	int ret =3D -EINVAL;=0A=
> -=0A=
> -	if (rate < PLL_OUT_MIN_FREQ || rate > PLL_OUT_MAX_FREQ)=0A=
> -		return ret;=0A=
> -=0A=
> -	ret =3D __clk_sccg_pll_determine_rate(hw, req, req->rate, req->rate,=0A=
> -						rate, PLL_BYPASS2);=0A=
> -	if (!ret)=0A=
> -		return ret;=0A=
> -=0A=
> -	ret =3D __clk_sccg_pll_determine_rate(hw, req, PLL_STAGE1_REF_MIN_FREQ,=
=0A=
> -						PLL_STAGE1_REF_MAX_FREQ, rate,=0A=
> -						PLL_BYPASS1);=0A=
> -	if (!ret)=0A=
> -		return ret;=0A=
> -=0A=
> -	ret =3D __clk_sccg_pll_determine_rate(hw, req, PLL_REF_MIN_FREQ,=0A=
> -						PLL_REF_MAX_FREQ, rate,=0A=
> -						PLL_BYPASS_NONE);=0A=
> -	if (!ret)=0A=
> -		return ret;=0A=
> -=0A=
> -	if (setup->fout >=3D min && setup->fout <=3D max)=0A=
> -		ret =3D 0;=0A=
> -=0A=
> -	return ret;=0A=
> -}=0A=
> -=0A=
> -static const struct clk_ops clk_sccg_pll_ops =3D {=0A=
> -	.prepare	=3D clk_sccg_pll_prepare,=0A=
> -	.unprepare	=3D clk_sccg_pll_unprepare,=0A=
> -	.is_prepared	=3D clk_sccg_pll_is_prepared,=0A=
> -	.recalc_rate	=3D clk_sccg_pll_recalc_rate,=0A=
> -	.set_rate	=3D clk_sccg_pll_set_rate,=0A=
> -	.set_parent	=3D clk_sccg_pll_set_parent,=0A=
> -	.get_parent	=3D clk_sccg_pll_get_parent,=0A=
> -	.determine_rate	=3D clk_sccg_pll_determine_rate,=0A=
> -};=0A=
> -=0A=
> -struct clk *imx_clk_sccg_pll(const char *name,=0A=
> -				const char * const *parent_names,=0A=
> -				u8 num_parents,=0A=
> -				u8 parent, u8 bypass1, u8 bypass2,=0A=
> -				void __iomem *base,=0A=
> -				unsigned long flags)=0A=
> -{=0A=
> -	struct clk_sccg_pll *pll;=0A=
> -	struct clk_init_data init;=0A=
> -	struct clk_hw *hw;=0A=
> -	int ret;=0A=
> -=0A=
> -	pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);=0A=
> -	if (!pll)=0A=
> -		return ERR_PTR(-ENOMEM);=0A=
> -=0A=
> -	pll->parent =3D parent;=0A=
> -	pll->bypass1 =3D bypass1;=0A=
> -	pll->bypass2 =3D bypass2;=0A=
> -=0A=
> -	pll->base =3D base;=0A=
> -	init.name =3D name;=0A=
> -	init.ops =3D &clk_sccg_pll_ops;=0A=
> -=0A=
> -	init.flags =3D flags;=0A=
> -	init.parent_names =3D parent_names;=0A=
> -	init.num_parents =3D num_parents;=0A=
> -=0A=
> -	pll->base =3D base;=0A=
> -	pll->hw.init =3D &init;=0A=
> -=0A=
> -	hw =3D &pll->hw;=0A=
> -=0A=
> -	ret =3D clk_hw_register(NULL, hw);=0A=
> -	if (ret) {=0A=
> -		kfree(pll);=0A=
> -		return ERR_PTR(ret);=0A=
> -	}=0A=
> -=0A=
> -	return hw->clk;=0A=
> -}=0A=
> diff --git a/drivers/clk/imx/clk-sscg-pll.c b/drivers/clk/imx/clk-sscg-pl=
l.c=0A=
> new file mode 100644=0A=
> index 00000000..0669e17=0A=
> --- /dev/null=0A=
> +++ b/drivers/clk/imx/clk-sscg-pll.c=0A=
> @@ -0,0 +1,549 @@=0A=
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)=0A=
> +/*=0A=
> + * Copyright 2018 NXP.=0A=
> + *=0A=
> + * This driver supports the SCCG plls found in the imx8m SOCs=0A=
> + *=0A=
> + * Documentation for this SCCG pll can be found at:=0A=
> + *   https://www.nxp.com/docs/en/reference-manual/IMX8MDQLQRM.pdf#page=
=3D834=0A=
> + */=0A=
> +=0A=
> +#include <linux/clk-provider.h>=0A=
> +#include <linux/err.h>=0A=
> +#include <linux/io.h>=0A=
> +#include <linux/iopoll.h>=0A=
> +#include <linux/slab.h>=0A=
> +#include <linux/bitfield.h>=0A=
> +=0A=
> +#include "clk.h"=0A=
> +=0A=
> +/* PLL CFGs */=0A=
> +#define PLL_CFG0		0x0=0A=
> +#define PLL_CFG1		0x4=0A=
> +#define PLL_CFG2		0x8=0A=
> +=0A=
> +#define PLL_DIVF1_MASK		GENMASK(18, 13)=0A=
> +#define PLL_DIVF2_MASK		GENMASK(12, 7)=0A=
> +#define PLL_DIVR1_MASK		GENMASK(27, 25)=0A=
> +#define PLL_DIVR2_MASK		GENMASK(24, 19)=0A=
> +#define PLL_DIVQ_MASK           GENMASK(6, 1)=0A=
> +#define PLL_REF_MASK		GENMASK(2, 0)=0A=
> +=0A=
> +#define PLL_LOCK_MASK		BIT(31)=0A=
> +#define PLL_PD_MASK		BIT(7)=0A=
> +=0A=
> +/* These are the specification limits for the SSCG PLL */=0A=
> +#define PLL_REF_MIN_FREQ		25000000UL=0A=
> +#define PLL_REF_MAX_FREQ		235000000UL=0A=
> +=0A=
> +#define PLL_STAGE1_MIN_FREQ		1600000000UL=0A=
> +#define PLL_STAGE1_MAX_FREQ		2400000000UL=0A=
> +=0A=
> +#define PLL_STAGE1_REF_MIN_FREQ		25000000UL=0A=
> +#define PLL_STAGE1_REF_MAX_FREQ		54000000UL=0A=
> +=0A=
> +#define PLL_STAGE2_MIN_FREQ		1200000000UL=0A=
> +#define PLL_STAGE2_MAX_FREQ		2400000000UL=0A=
> +=0A=
> +#define PLL_STAGE2_REF_MIN_FREQ		54000000UL=0A=
> +#define PLL_STAGE2_REF_MAX_FREQ		75000000UL=0A=
> +=0A=
> +#define PLL_OUT_MIN_FREQ		20000000UL=0A=
> +#define PLL_OUT_MAX_FREQ		1200000000UL=0A=
> +=0A=
> +#define PLL_DIVR1_MAX			7=0A=
> +#define PLL_DIVR2_MAX			63=0A=
> +#define PLL_DIVF1_MAX			63=0A=
> +#define PLL_DIVF2_MAX			63=0A=
> +#define PLL_DIVQ_MAX			63=0A=
> +=0A=
> +#define PLL_BYPASS_NONE			0x0=0A=
> +#define PLL_BYPASS1			0x2=0A=
> +#define PLL_BYPASS2			0x1=0A=
> +=0A=
> +#define SSCG_PLL_BYPASS1_MASK           BIT(5)=0A=
> +#define SSCG_PLL_BYPASS2_MASK           BIT(4)=0A=
> +#define SSCG_PLL_BYPASS_MASK		GENMASK(5, 4)=0A=
> +=0A=
> +#define PLL_SCCG_LOCK_TIMEOUT		70=0A=
> +=0A=
> +struct clk_sscg_pll_setup {=0A=
> +	int divr1, divf1;=0A=
> +	int divr2, divf2;=0A=
> +	int divq;=0A=
> +	int bypass;=0A=
> +=0A=
> +	uint64_t vco1;=0A=
> +	uint64_t vco2;=0A=
> +	uint64_t fout;=0A=
> +	uint64_t ref;=0A=
> +	uint64_t ref_div1;=0A=
> +	uint64_t ref_div2;=0A=
> +	uint64_t fout_request;=0A=
> +	int fout_error;=0A=
> +};=0A=
> +=0A=
> +struct clk_sscg_pll {=0A=
> +	struct clk_hw	hw;=0A=
> +	const struct clk_ops  ops;=0A=
> +=0A=
> +	void __iomem *base;=0A=
> +=0A=
> +	struct clk_sscg_pll_setup setup;=0A=
> +=0A=
> +	u8 parent;=0A=
> +	u8 bypass1;=0A=
> +	u8 bypass2;=0A=
> +};=0A=
> +=0A=
> +#define to_clk_sscg_pll(_hw) container_of(_hw, struct clk_sscg_pll, hw)=
=0A=
> +=0A=
> +static int clk_sscg_pll_wait_lock(struct clk_sscg_pll *pll)=0A=
> +{=0A=
> +	u32 val;=0A=
> +=0A=
> +	val =3D readl_relaxed(pll->base + PLL_CFG0);=0A=
> +=0A=
> +	/* don't wait for lock if all plls are bypassed */=0A=
> +	if (!(val & SSCG_PLL_BYPASS2_MASK))=0A=
> +		return readl_poll_timeout(pll->base, val, val & PLL_LOCK_MASK,=0A=
> +						0, PLL_SCCG_LOCK_TIMEOUT);=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static int clk_sscg_pll2_check_match(struct clk_sscg_pll_setup *setup,=
=0A=
> +					struct clk_sscg_pll_setup *temp_setup)=0A=
> +{=0A=
> +	int new_diff =3D temp_setup->fout - temp_setup->fout_request;=0A=
> +	int diff =3D temp_setup->fout_error;=0A=
> +=0A=
> +	if (abs(diff) > abs(new_diff)) {=0A=
> +		temp_setup->fout_error =3D new_diff;=0A=
> +		memcpy(setup, temp_setup, sizeof(struct clk_sscg_pll_setup));=0A=
> +=0A=
> +		if (temp_setup->fout_request =3D=3D temp_setup->fout)=0A=
> +			return 0;=0A=
> +	}=0A=
> +	return -1;=0A=
> +}=0A=
> +=0A=
> +static int clk_sscg_divq_lookup(struct clk_sscg_pll_setup *setup,=0A=
> +				struct clk_sscg_pll_setup *temp_setup)=0A=
> +{=0A=
> +	int ret =3D -EINVAL;=0A=
> +=0A=
> +	for (temp_setup->divq =3D 0; temp_setup->divq <=3D PLL_DIVQ_MAX;=0A=
> +	     temp_setup->divq++) {=0A=
> +		temp_setup->vco2 =3D temp_setup->vco1;=0A=
> +		do_div(temp_setup->vco2, temp_setup->divr2 + 1);=0A=
> +		temp_setup->vco2 *=3D 2;=0A=
> +		temp_setup->vco2 *=3D temp_setup->divf2 + 1;=0A=
> +		if (temp_setup->vco2 >=3D PLL_STAGE2_MIN_FREQ &&=0A=
> +				temp_setup->vco2 <=3D PLL_STAGE2_MAX_FREQ) {=0A=
> +			temp_setup->fout =3D temp_setup->vco2;=0A=
> +			do_div(temp_setup->fout, 2 * (temp_setup->divq + 1));=0A=
> +=0A=
> +			ret =3D clk_sscg_pll2_check_match(setup, temp_setup);=0A=
> +			if (!ret) {=0A=
> +				temp_setup->bypass =3D PLL_BYPASS1;=0A=
> +				return ret;=0A=
> +			}=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static int clk_sscg_divf2_lookup(struct clk_sscg_pll_setup *setup,=0A=
> +					struct clk_sscg_pll_setup *temp_setup)=0A=
> +{=0A=
> +	int ret =3D -EINVAL;=0A=
> +=0A=
> +	for (temp_setup->divf2 =3D 0; temp_setup->divf2 <=3D PLL_DIVF2_MAX;=0A=
> +	     temp_setup->divf2++) {=0A=
> +		ret =3D clk_sscg_divq_lookup(setup, temp_setup);=0A=
> +		if (!ret)=0A=
> +			return ret;=0A=
> +	}=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static int clk_sscg_divr2_lookup(struct clk_sscg_pll_setup *setup,=0A=
> +				struct clk_sscg_pll_setup *temp_setup)=0A=
> +{=0A=
> +	int ret =3D -EINVAL;=0A=
> +=0A=
> +	for (temp_setup->divr2 =3D 0; temp_setup->divr2 <=3D PLL_DIVR2_MAX;=0A=
> +	     temp_setup->divr2++) {=0A=
> +		temp_setup->ref_div2 =3D temp_setup->vco1;=0A=
> +		do_div(temp_setup->ref_div2, temp_setup->divr2 + 1);=0A=
> +		if (temp_setup->ref_div2 >=3D PLL_STAGE2_REF_MIN_FREQ &&=0A=
> +		    temp_setup->ref_div2 <=3D PLL_STAGE2_REF_MAX_FREQ) {=0A=
> +			ret =3D clk_sscg_divf2_lookup(setup, temp_setup);=0A=
> +			if (!ret)=0A=
> +				return ret;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static int clk_sscg_pll2_find_setup(struct clk_sscg_pll_setup *setup,=0A=
> +					struct clk_sscg_pll_setup *temp_setup,=0A=
> +					uint64_t ref)=0A=
> +{=0A=
> +=0A=
> +	int ret =3D -EINVAL;=0A=
> +=0A=
> +	if (ref < PLL_STAGE1_MIN_FREQ || ref > PLL_STAGE1_MAX_FREQ)=0A=
> +		return ret;=0A=
> +=0A=
> +	temp_setup->vco1 =3D ref;=0A=
> +=0A=
> +	ret =3D clk_sscg_divr2_lookup(setup, temp_setup);=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static int clk_sscg_divf1_lookup(struct clk_sscg_pll_setup *setup,=0A=
> +				struct clk_sscg_pll_setup *temp_setup)=0A=
> +{=0A=
> +	int ret =3D -EINVAL;=0A=
> +=0A=
> +	for (temp_setup->divf1 =3D 0; temp_setup->divf1 <=3D PLL_DIVF1_MAX;=0A=
> +	     temp_setup->divf1++) {=0A=
> +		uint64_t vco1 =3D temp_setup->ref;=0A=
> +=0A=
> +		do_div(vco1, temp_setup->divr1 + 1);=0A=
> +		vco1 *=3D 2;=0A=
> +		vco1 *=3D temp_setup->divf1 + 1;=0A=
> +=0A=
> +		ret =3D clk_sscg_pll2_find_setup(setup, temp_setup, vco1);=0A=
> +		if (!ret) {=0A=
> +			temp_setup->bypass =3D PLL_BYPASS_NONE;=0A=
> +			return ret;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static int clk_sscg_divr1_lookup(struct clk_sscg_pll_setup *setup,=0A=
> +				struct clk_sscg_pll_setup *temp_setup)=0A=
> +{=0A=
> +	int ret =3D -EINVAL;=0A=
> +=0A=
> +	for (temp_setup->divr1 =3D 0; temp_setup->divr1 <=3D PLL_DIVR1_MAX;=0A=
> +	     temp_setup->divr1++) {=0A=
> +		temp_setup->ref_div1 =3D temp_setup->ref;=0A=
> +		do_div(temp_setup->ref_div1, temp_setup->divr1 + 1);=0A=
> +		if (temp_setup->ref_div1 >=3D PLL_STAGE1_REF_MIN_FREQ &&=0A=
> +		    temp_setup->ref_div1 <=3D PLL_STAGE1_REF_MAX_FREQ) {=0A=
> +			ret =3D clk_sscg_divf1_lookup(setup, temp_setup);=0A=
> +			if (!ret)=0A=
> +				return ret;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static int clk_sscg_pll1_find_setup(struct clk_sscg_pll_setup *setup,=0A=
> +					struct clk_sscg_pll_setup *temp_setup,=0A=
> +					uint64_t ref)=0A=
> +{=0A=
> +=0A=
> +	int ret =3D -EINVAL;=0A=
> +=0A=
> +	if (ref < PLL_REF_MIN_FREQ || ref > PLL_REF_MAX_FREQ)=0A=
> +		return ret;=0A=
> +=0A=
> +	temp_setup->ref =3D ref;=0A=
> +=0A=
> +	ret =3D clk_sscg_divr1_lookup(setup, temp_setup);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static int clk_sscg_pll_find_setup(struct clk_sscg_pll_setup *setup,=0A=
> +					uint64_t prate,=0A=
> +					uint64_t rate, int try_bypass)=0A=
> +{=0A=
> +	struct clk_sscg_pll_setup temp_setup;=0A=
> +	int ret =3D -EINVAL;=0A=
> +=0A=
> +	memset(&temp_setup, 0, sizeof(struct clk_sscg_pll_setup));=0A=
> +	memset(setup, 0, sizeof(struct clk_sscg_pll_setup));=0A=
> +=0A=
> +	temp_setup.fout_error =3D PLL_OUT_MAX_FREQ;=0A=
> +	temp_setup.fout_request =3D rate;=0A=
> +=0A=
> +	switch (try_bypass) {=0A=
> +=0A=
> +	case PLL_BYPASS2:=0A=
> +		if (prate =3D=3D rate) {=0A=
> +			setup->bypass =3D PLL_BYPASS2;=0A=
> +			setup->fout =3D rate;=0A=
> +			ret =3D 0;=0A=
> +		}=0A=
> +		break;=0A=
> +=0A=
> +	case PLL_BYPASS1:=0A=
> +		ret =3D clk_sscg_pll2_find_setup(setup, &temp_setup, prate);=0A=
> +		break;=0A=
> +=0A=
> +	case PLL_BYPASS_NONE:=0A=
> +		ret =3D clk_sscg_pll1_find_setup(setup, &temp_setup, prate);=0A=
> +		break;=0A=
> +	}=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +=0A=
> +static int clk_sscg_pll_is_prepared(struct clk_hw *hw)=0A=
> +{=0A=
> +	struct clk_sscg_pll *pll =3D to_clk_sscg_pll(hw);=0A=
> +=0A=
> +	u32 val =3D readl_relaxed(pll->base + PLL_CFG0);=0A=
> +=0A=
> +	return (val & PLL_PD_MASK) ? 0 : 1;=0A=
> +}=0A=
> +=0A=
> +static int clk_sscg_pll_prepare(struct clk_hw *hw)=0A=
> +{=0A=
> +	struct clk_sscg_pll *pll =3D to_clk_sscg_pll(hw);=0A=
> +	u32 val;=0A=
> +=0A=
> +	val =3D readl_relaxed(pll->base + PLL_CFG0);=0A=
> +	val &=3D ~PLL_PD_MASK;=0A=
> +	writel_relaxed(val, pll->base + PLL_CFG0);=0A=
> +=0A=
> +	return clk_sscg_pll_wait_lock(pll);=0A=
> +}=0A=
> +=0A=
> +static void clk_sscg_pll_unprepare(struct clk_hw *hw)=0A=
> +{=0A=
> +	struct clk_sscg_pll *pll =3D to_clk_sscg_pll(hw);=0A=
> +	u32 val;=0A=
> +=0A=
> +	val =3D readl_relaxed(pll->base + PLL_CFG0);=0A=
> +	val |=3D PLL_PD_MASK;=0A=
> +	writel_relaxed(val, pll->base + PLL_CFG0);=0A=
> +}=0A=
> +=0A=
> +static unsigned long clk_sscg_pll_recalc_rate(struct clk_hw *hw,=0A=
> +					 unsigned long parent_rate)=0A=
> +{=0A=
> +	struct clk_sscg_pll *pll =3D to_clk_sscg_pll(hw);=0A=
> +	u32 val, divr1, divf1, divr2, divf2, divq;=0A=
> +	u64 temp64;=0A=
> +=0A=
> +	val =3D readl_relaxed(pll->base + PLL_CFG2);=0A=
> +	divr1 =3D FIELD_GET(PLL_DIVR1_MASK, val);=0A=
> +	divr2 =3D FIELD_GET(PLL_DIVR2_MASK, val);=0A=
> +	divf1 =3D FIELD_GET(PLL_DIVF1_MASK, val);=0A=
> +	divf2 =3D FIELD_GET(PLL_DIVF2_MASK, val);=0A=
> +	divq =3D FIELD_GET(PLL_DIVQ_MASK, val);=0A=
> +=0A=
> +	temp64 =3D parent_rate;=0A=
> +=0A=
> +	val =3D readl(pll->base + PLL_CFG0);=0A=
> +	if (val & SSCG_PLL_BYPASS2_MASK) {=0A=
> +		temp64 =3D parent_rate;=0A=
> +	} else if (val & SSCG_PLL_BYPASS1_MASK) {=0A=
> +		temp64 *=3D divf2;=0A=
> +		do_div(temp64, (divr2 + 1) * (divq + 1));=0A=
> +	} else {=0A=
> +		temp64 *=3D 2;=0A=
> +		temp64 *=3D (divf1 + 1) * (divf2 + 1);=0A=
> +		do_div(temp64, (divr1 + 1) * (divr2 + 1) * (divq + 1));=0A=
> +	}=0A=
> +=0A=
> +	return temp64;=0A=
> +}=0A=
> +=0A=
> +static int clk_sscg_pll_set_rate(struct clk_hw *hw, unsigned long rate,=
=0A=
> +			    unsigned long parent_rate)=0A=
> +{=0A=
> +	struct clk_sscg_pll *pll =3D to_clk_sscg_pll(hw);=0A=
> +	struct clk_sscg_pll_setup *setup =3D &pll->setup;=0A=
> +	u32 val;=0A=
> +=0A=
> +	/* set bypass here too since the parent might be the same */=0A=
> +	val =3D readl(pll->base + PLL_CFG0);=0A=
> +	val &=3D ~SSCG_PLL_BYPASS_MASK;=0A=
> +	val |=3D FIELD_PREP(SSCG_PLL_BYPASS_MASK, setup->bypass);=0A=
> +	writel(val, pll->base + PLL_CFG0);=0A=
> +=0A=
> +	val =3D readl_relaxed(pll->base + PLL_CFG2);=0A=
> +	val &=3D ~(PLL_DIVF1_MASK | PLL_DIVF2_MASK);=0A=
> +	val &=3D ~(PLL_DIVR1_MASK | PLL_DIVR2_MASK | PLL_DIVQ_MASK);=0A=
> +	val |=3D FIELD_PREP(PLL_DIVF1_MASK, setup->divf1);=0A=
> +	val |=3D FIELD_PREP(PLL_DIVF2_MASK, setup->divf2);=0A=
> +	val |=3D FIELD_PREP(PLL_DIVR1_MASK, setup->divr1);=0A=
> +	val |=3D FIELD_PREP(PLL_DIVR2_MASK, setup->divr2);=0A=
> +	val |=3D FIELD_PREP(PLL_DIVQ_MASK, setup->divq);=0A=
> +	writel_relaxed(val, pll->base + PLL_CFG2);=0A=
> +=0A=
> +	return clk_sscg_pll_wait_lock(pll);=0A=
> +}=0A=
> +=0A=
> +static u8 clk_sscg_pll_get_parent(struct clk_hw *hw)=0A=
> +{=0A=
> +	struct clk_sscg_pll *pll =3D to_clk_sscg_pll(hw);=0A=
> +	u32 val;=0A=
> +	u8 ret =3D pll->parent;=0A=
> +=0A=
> +	val =3D readl(pll->base + PLL_CFG0);=0A=
> +	if (val & SSCG_PLL_BYPASS2_MASK)=0A=
> +		ret =3D pll->bypass2;=0A=
> +	else if (val & SSCG_PLL_BYPASS1_MASK)=0A=
> +		ret =3D pll->bypass1;=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static int clk_sscg_pll_set_parent(struct clk_hw *hw, u8 index)=0A=
> +{=0A=
> +	struct clk_sscg_pll *pll =3D to_clk_sscg_pll(hw);=0A=
> +	u32 val;=0A=
> +=0A=
> +	val =3D readl(pll->base + PLL_CFG0);=0A=
> +	val &=3D ~SSCG_PLL_BYPASS_MASK;=0A=
> +	val |=3D FIELD_PREP(SSCG_PLL_BYPASS_MASK, pll->setup.bypass);=0A=
> +	writel(val, pll->base + PLL_CFG0);=0A=
> +=0A=
> +	return clk_sscg_pll_wait_lock(pll);=0A=
> +}=0A=
> +=0A=
> +static int __clk_sscg_pll_determine_rate(struct clk_hw *hw,=0A=
> +					struct clk_rate_request *req,=0A=
> +					uint64_t min,=0A=
> +					uint64_t max,=0A=
> +					uint64_t rate,=0A=
> +					int bypass)=0A=
> +{=0A=
> +	struct clk_sscg_pll *pll =3D to_clk_sscg_pll(hw);=0A=
> +	struct clk_sscg_pll_setup *setup =3D &pll->setup;=0A=
> +	struct clk_hw *parent_hw =3D NULL;=0A=
> +	int bypass_parent_index;=0A=
> +	int ret =3D -EINVAL;=0A=
> +=0A=
> +	req->max_rate =3D max;=0A=
> +	req->min_rate =3D min;=0A=
> +=0A=
> +	switch (bypass) {=0A=
> +	case PLL_BYPASS2:=0A=
> +		bypass_parent_index =3D pll->bypass2;=0A=
> +		break;=0A=
> +	case PLL_BYPASS1:=0A=
> +		bypass_parent_index =3D pll->bypass1;=0A=
> +		break;=0A=
> +	default:=0A=
> +		bypass_parent_index =3D pll->parent;=0A=
> +		break;=0A=
> +	}=0A=
> +=0A=
> +	parent_hw =3D clk_hw_get_parent_by_index(hw, bypass_parent_index);=0A=
> +	ret =3D __clk_determine_rate(parent_hw, req);=0A=
> +	if (!ret) {=0A=
> +		ret =3D clk_sscg_pll_find_setup(setup, req->rate,=0A=
> +						rate, bypass);=0A=
> +	}=0A=
> +=0A=
> +	req->best_parent_hw =3D parent_hw;=0A=
> +	req->best_parent_rate =3D req->rate;=0A=
> +	req->rate =3D setup->fout;=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static int clk_sscg_pll_determine_rate(struct clk_hw *hw,=0A=
> +				       struct clk_rate_request *req)=0A=
> +{=0A=
> +	struct clk_sscg_pll *pll =3D to_clk_sscg_pll(hw);=0A=
> +	struct clk_sscg_pll_setup *setup =3D &pll->setup;=0A=
> +	uint64_t rate =3D req->rate;=0A=
> +	uint64_t min =3D req->min_rate;=0A=
> +	uint64_t max =3D req->max_rate;=0A=
> +	int ret =3D -EINVAL;=0A=
> +=0A=
> +	if (rate < PLL_OUT_MIN_FREQ || rate > PLL_OUT_MAX_FREQ)=0A=
> +		return ret;=0A=
> +=0A=
> +	ret =3D __clk_sscg_pll_determine_rate(hw, req, req->rate, req->rate,=0A=
> +						rate, PLL_BYPASS2);=0A=
> +	if (!ret)=0A=
> +		return ret;=0A=
> +=0A=
> +	ret =3D __clk_sscg_pll_determine_rate(hw, req, PLL_STAGE1_REF_MIN_FREQ,=
=0A=
> +						PLL_STAGE1_REF_MAX_FREQ, rate,=0A=
> +						PLL_BYPASS1);=0A=
> +	if (!ret)=0A=
> +		return ret;=0A=
> +=0A=
> +	ret =3D __clk_sscg_pll_determine_rate(hw, req, PLL_REF_MIN_FREQ,=0A=
> +						PLL_REF_MAX_FREQ, rate,=0A=
> +						PLL_BYPASS_NONE);=0A=
> +	if (!ret)=0A=
> +		return ret;=0A=
> +=0A=
> +	if (setup->fout >=3D min && setup->fout <=3D max)=0A=
> +		ret =3D 0;=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static const struct clk_ops clk_sscg_pll_ops =3D {=0A=
> +	.prepare	=3D clk_sscg_pll_prepare,=0A=
> +	.unprepare	=3D clk_sscg_pll_unprepare,=0A=
> +	.is_prepared	=3D clk_sscg_pll_is_prepared,=0A=
> +	.recalc_rate	=3D clk_sscg_pll_recalc_rate,=0A=
> +	.set_rate	=3D clk_sscg_pll_set_rate,=0A=
> +	.set_parent	=3D clk_sscg_pll_set_parent,=0A=
> +	.get_parent	=3D clk_sscg_pll_get_parent,=0A=
> +	.determine_rate	=3D clk_sscg_pll_determine_rate,=0A=
> +};=0A=
> +=0A=
> +struct clk *imx_clk_sscg_pll(const char *name,=0A=
> +				const char * const *parent_names,=0A=
> +				u8 num_parents,=0A=
> +				u8 parent, u8 bypass1, u8 bypass2,=0A=
> +				void __iomem *base,=0A=
> +				unsigned long flags)=0A=
> +{=0A=
> +	struct clk_sscg_pll *pll;=0A=
> +	struct clk_init_data init;=0A=
> +	struct clk_hw *hw;=0A=
> +	int ret;=0A=
> +=0A=
> +	pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);=0A=
> +	if (!pll)=0A=
> +		return ERR_PTR(-ENOMEM);=0A=
> +=0A=
> +	pll->parent =3D parent;=0A=
> +	pll->bypass1 =3D bypass1;=0A=
> +	pll->bypass2 =3D bypass2;=0A=
> +=0A=
> +	pll->base =3D base;=0A=
> +	init.name =3D name;=0A=
> +	init.ops =3D &clk_sscg_pll_ops;=0A=
> +=0A=
> +	init.flags =3D flags;=0A=
> +	init.parent_names =3D parent_names;=0A=
> +	init.num_parents =3D num_parents;=0A=
> +=0A=
> +	pll->base =3D base;=0A=
> +	pll->hw.init =3D &init;=0A=
> +=0A=
> +	hw =3D &pll->hw;=0A=
> +=0A=
> +	ret =3D clk_hw_register(NULL, hw);=0A=
> +	if (ret) {=0A=
> +		kfree(pll);=0A=
> +		return ERR_PTR(ret);=0A=
> +	}=0A=
> +=0A=
> +	return hw->clk;=0A=
> +}=0A=
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h=0A=
> index 30ddbc1..9330632 100644=0A=
> --- a/drivers/clk/imx/clk.h=0A=
> +++ b/drivers/clk/imx/clk.h=0A=
> @@ -24,7 +24,7 @@ enum imx_pllv1_type {=0A=
>   	IMX_PLLV1_IMX35,=0A=
>   };=0A=
>   =0A=
> -enum imx_sccg_pll_type {=0A=
> +enum imx_sscg_pll_type {=0A=
>   	SCCG_PLL1,=0A=
>   	SCCG_PLL2,=0A=
>   };=0A=
> @@ -109,7 +109,7 @@ struct clk *imx_clk_pllv2(const char *name, const cha=
r *parent,=0A=
>   struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,=
=0A=
>   			     void __iomem *base);=0A=
>   =0A=
> -struct clk *imx_clk_sccg_pll(const char *name,=0A=
> +struct clk *imx_clk_sscg_pll(const char *name,=0A=
>   				const char * const *parent_names,=0A=
>   				u8 num_parents,=0A=
>   				u8 parent, u8 bypass1, u8 bypass2,=0A=
> =0A=
=0A=
