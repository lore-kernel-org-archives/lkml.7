Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33187C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0417D2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfLBO2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:28:44 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57231 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfLBO2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 09:28:43 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ibmgp-0007e7-2S; Mon, 02 Dec 2019 15:28:39 +0100
Message-ID: <3dff516c16dbb8c654293e16c49b4c59d29fd707.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] soc: imx: gpcv2: Add support for imx8mm
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Mon, 02 Dec 2019 15:28:38 +0100
In-Reply-To: <20191129234108.12732-1-aford173@gmail.com>
References: <20191129234108.12732-1-aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-29 at 17:41 -0600, Adam Ford wrote:
> The technical reference manual for both the i.MX8MQ and i.MX8M Mini
> appear to show the same register definitions and locations for the
> General Power Controller (GPC).
> 
> This patch expands the table of compatible SoC's to include
> the i.MX8m Mini
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index b0dffb06c05d..67c54cbb6c81 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -641,6 +641,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
>  static const struct of_device_id imx_gpcv2_dt_ids[] = {
>  	{ .compatible = "fsl,imx7d-gpc", .data = &imx7_pgc_domain_data, },
>  	{ .compatible = "fsl,imx8mq-gpc", .data = &imx8m_pgc_domain_data, },
> +	{ .compatible = "fsl,imx8mm-gpc", .data = &imx8m_pgc_domain_data, },

According to the 5.2.5.1 "PGC power domains" chapters in both the i.MX
8M Dual/8M QuadLite/8M Quad and i.MX 8M Mini Applications Processor
Reference Manuals (Rev.1), the two SoCs have a different list of power
domains:

i.MX8MQ:
	PGC_C0
	PGC_C1
	PGC_C2
	PGC_C3
	PGC_SCU
	PGC_MF
	PGC_OTG1
	PGC_OTG2
	PGC_PCIE
	PGC_MIPI
	PGC_DDR1
	PGC_DDR2
	PGC_VPU
	PGC_GPU
	PGC_HDMI
	PGC_DISP
	PGC_MIPI_CSI1
	PGC_MIPI_CSI2
	PGC_PCIE2

i.MX8MM:
	PGC_C0
	PGC_C1
	PGC_C2
	PGC_C3
	PGC_SCU
	PGC_NOC
	PGC_PCIE
	PGC_OTG1
	PGC_OTG2
	PGC_DDR1
	PGC_DISPMIX
	GPC_MIPI
	PGC_GPUMIX
	PGC_GPU_3D
	PGC_GPU_2D
	PGC_VPUMIX
	PGC_VPU_G1
	PGC_VPU_G2
	PGC_VPU_H1

regards
Philipp

