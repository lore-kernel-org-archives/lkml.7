Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AF4C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57E320C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbfHFLHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:07:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728845AbfHFLHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:07:19 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5EE1996E0A4ABC13A6C9;
        Tue,  6 Aug 2019 19:07:16 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 6 Aug 2019
 19:07:06 +0800
Subject: Re: [PATCH v2 12/12] irqchip/gic-v3: Add quirks for HIP06/07 invalid
 GICD_TYPER erratum 161010803
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Jason Cooper" <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20190806100121.240767-1-maz@kernel.org>
 <20190806100121.240767-13-maz@kernel.org>
CC:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "Lokesh Vutla" <lokeshvutla@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5f8808f9-ca91-db68-042f-97dfcbe75508@huawei.com>
Date:   Tue, 6 Aug 2019 12:07:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190806100121.240767-13-maz@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2019 11:01, Marc Zyngier wrote:
> It looks like the HIP06/07 SoCs have extra bits in their GICD_TYPER
> registers, which confuse the GICv3.1 code (these systems appear to
> expose ESPIs while they actually don't).
>
> Detect these systems as early as possible and wipe the fields that
> should be RES0 in the register.
>

thanks,

Tested-by: John Garry <john.garry@huawei.com>

> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  Documentation/arm64/silicon-errata.rst |  2 +
>  drivers/irqchip/irq-gic-v3.c           | 54 +++++++++++++++++++++-----
>  2 files changed, 46 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
> index 3e57d09246e6..17ea3fecddaa 100644
> --- a/Documentation/arm64/silicon-errata.rst
> +++ b/Documentation/arm64/silicon-errata.rst
> @@ -115,6 +115,8 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | Hisilicon      | Hip0{6,7}       | #161010701      | N/A                         |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| Hisilicon      | Hip0{6,7}       | #161010803      | N/A                         |
> ++----------------+-----------------+-----------------+-----------------------------+
>  | Hisilicon      | Hip07           | #161600802      | HISILICON_ERRATUM_161600802 |
>  +----------------+-----------------+-----------------+-----------------------------+
>  | Hisilicon      | Hip08 SMMU PMCG | #162001800      | N/A                         |
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 334a10d9dbfb..bee141613b67 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1441,6 +1441,46 @@ static bool gic_enable_quirk_msm8996(void *data)
>  	return true;
>  }
>
> +static bool gic_enable_quirk_hip06_07(void *data)
> +{
> +	struct gic_chip_data *d = data;
> +
> +	/*
> +	 * HIP06 GICD_IIDR clashes with GIC-600 product number (despite
> +	 * not being an actual ARM implementation). The saving grace is
> +	 * that GIC-600 doesn't have ESPI, so nothing to do in that case.
> +	 * HIP07 doesn't even have a proper IIDR, and still pretends to
> +	 * have ESPI. In both cases, put them right.
> +	 */
> +	if (d->rdists.gicd_typer & GICD_TYPER_ESPI) {
> +		/* Zero both ESPI and the RES0 field next to it... */
> +		d->rdists.gicd_typer &= ~GENMASK(9, 8);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static const struct gic_quirk gic_quirks[] = {
> +	{
> +		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
> +		.compatible = "qcom,msm8996-gic-v3",
> +		.init	= gic_enable_quirk_msm8996,
> +	},
> +	{
> +		.desc	= "GICv3: HIP06 erratum 161010803",
> +		.iidr	= 0x0204043b,
> +		.init	= gic_enable_quirk_hip06_07,
> +	},
> +	{
> +		.desc	= "GICv3: HIP07 erratum 161010803",
> +		.iidr	= 0x00000000,
> +		.init	= gic_enable_quirk_hip06_07,
> +	},
> +	{
> +	}
> +};
> +
>  static void gic_enable_nmi_support(void)
>  {
>  	int i;
> @@ -1494,6 +1534,10 @@ static int __init gic_init_bases(void __iomem *dist_base,
>  	 */
>  	typer = readl_relaxed(gic_data.dist_base + GICD_TYPER);
>  	gic_data.rdists.gicd_typer = typer;
> +
> +	gic_enable_quirks(readl_relaxed(gic_data.dist_base + GICD_IIDR),
> +			  gic_quirks, &gic_data);
> +
>  	pr_info("%d SPIs implemented\n", GIC_LINE_NR - 32);
>  	pr_info("%d Extended SPIs implemented\n", GIC_ESPI_NR);
>  	gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
> @@ -1676,16 +1720,6 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
>  	gic_set_kvm_info(&gic_v3_kvm_info);
>  }
>
> -static const struct gic_quirk gic_quirks[] = {
> -	{
> -		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
> -		.compatible = "qcom,msm8996-gic-v3",
> -		.init	= gic_enable_quirk_msm8996,
> -	},
> -	{
> -	}
> -};
> -
>  static int __init gic_of_init(struct device_node *node, struct device_node *parent)
>  {
>  	void __iomem *dist_base;
>


