Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED148C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87E222CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfHTN4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:56:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:56683 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbfHTN4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:56:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 06:56:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="195775716"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga001.fm.intel.com with ESMTP; 20 Aug 2019 06:56:04 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1i04cE-0003zo-6B; Tue, 20 Aug 2019 16:56:02 +0300
Date:   Tue, 20 Aug 2019 16:56:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, peter.harliman.liem@intel.com
Subject: Re: [PATCH v2 2/2] phy: intel-lgm-emmc: Add support for eMMC PHY
Message-ID: <20190820135602.GN30120@smile.fi.intel.com>
References: <20190820103133.53776-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190820103133.53776-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820103133.53776-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 06:31:33PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add support for eMMC PHY on Intel's Lightning Mountain SoC.

Thanks for an update.
Looks better though several minor comments below.


> +/* eMMC phy register definitions */
> +#define EMMC_PHYCTRL0_REG	0xa8
> +#define DR_TY_MASK		GENMASK(30, 28)

> +#define DR_TY_50OHM(x)		((~(x) << 28) & DR_TY_MASK)

For consistency it should be

#define DR_TY_SHIFT(x)		(((x) << 28) & DR_TY_MASK)

with explanation about 50 Ohm in the code below.

> +#define OTAPDLYENA		BIT(14)
> +#define OTAPDLYSEL_MASK		GENMASK(13, 10)
> +#define OTAPDLYSEL_SHIFT(x)	(((x) << 10) & OTAPDLYSEL_MASK)
> +
> +#define EMMC_PHYCTRL1_REG	0xac
> +#define PDB_MASK		BIT(0)
> +#define ENDLL_MASK		BIT(7)

> +#define ENDLL_VAL		BIT(7)

Again, inconsistency here,

#define ENDLL_SHIFT(x)		(((x) << 7) & ENDLL_MASK)

> +#define EMMC_PHYCTRL2_REG	0xb0
> +#define FRQSEL_25M		0
> +#define FRQSEL_150M		3
> +#define FRQSEL_MASK		GENMASK(24, 22)

> +#define FRQSEL_SHIFT(x)		((x) << 22)

And here

#define FRQSEL_SHIFT(x)		(((x) << 22) & FRQSEL_MASK)

> +	/*
> +	 * According to the user manual, calpad calibration
> +	 * cycle takes more than 2us without the minimal recommended
> +	 * value, so we may need a little margin here
> +	 */

> +	usleep_range(3, 6);

Actually for this low values it's recommended to use udelay() disregard to
context.

	udelay(5);

> +	regmap_update_bits(priv->syscfg, EMMC_PHYCTRL1_REG, PDB_MASK, 1);

1 looks like a magic that has to be changed in the same way as for the rest, i.e.

#define PDB_SHIFT(x)	(((x) << 0) & PDB_MASK)

	..., PDB_MASK, PDB_SHIFT(1)...

> +static int intel_emmc_phy_power_on(struct phy *phy)
> +{
> +	struct intel_emmc_phy *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	/* Drive impedance: 50 Ohm */

Nice, you have already a comment here. Just use DR_TY_SHIFT(1)

> +	ret = regmap_update_bits(priv->syscfg, EMMC_PHYCTRL0_REG, DR_TY_MASK,
> +				 DR_TY_50OHM(1));

> +	ret = regmap_update_bits(priv->syscfg, EMMC_PHYCTRL0_REG, OTAPDLYENA,
> +				 0x0);

0x0 -> 0

> +static int intel_emmc_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct intel_emmc_phy *priv;
> +	struct phy *generic_phy;
> +	struct phy_provider *phy_provider;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	/* Get eMMC phy (accessed via chiptop) regmap */

> +	priv->syscfg = syscon_regmap_lookup_by_phandle(dev->of_node,
> +						       "intel,syscon");

Perhaps

	struct device_node *np = dev->of_node;
	...
	priv->syscfg = syscon_regmap_lookup_by_phandle(np, "intel,syscon");

> +	generic_phy = devm_phy_create(dev, dev->of_node, &ops);

And here.

-- 
With Best Regards,
Andy Shevchenko


