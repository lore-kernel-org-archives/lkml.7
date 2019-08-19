Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BE9C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE0C2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfHSQGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:06:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:21544 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfHSQGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:06:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 09:06:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,405,1559545200"; 
   d="scan'208";a="195566523"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga001.fm.intel.com with ESMTP; 19 Aug 2019 09:06:44 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1hzkB8-0000AT-TM; Mon, 19 Aug 2019 19:06:42 +0300
Date:   Mon, 19 Aug 2019 19:06:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, peter.harliman.liem@intel.com
Subject: Re: [PATCH v1 2/2] phy: intel-lgm-emmc: Add support for eMMC PHY
Message-ID: <20190819160642.GC30120@smile.fi.intel.com>
References: <20190819034416.45192-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190819034416.45192-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819034416.45192-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 11:44:16AM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Adds support for eMMC PHY on Intel's Lightning Mountain SoC.

Adds -> Add.

> +/* eMMC phy register definitions */
> +#define EMMC_PHYCTRL0_REG	0xa8
> +#define DR_TY_MASK		GENMASK(30, 28)
> +#define DR_TY_50OHM(x)		((~(x) << 28) & DR_TY_MASK)
> +#define OTAPDLYENA		BIT(14)
> +#define OTAPDLYSEL_MASK		GENMASK(13, 10)
> +#define OTAPDLYSEL_SHIFT(x)	(((x) << 10) & OTAPDLYSEL_MASK)
> +
> +#define EMMC_PHYCTRL1_REG	0xac

> +#define PDB_MASK		1

BIT(0)

> +#define ENDLL_MASK		BIT(7)
> +#define ENDLL_VAL		BIT(7)
> +
> +#define EMMC_PHYCTRL2_REG	0xb0
> +#define FRQSEL_25M		0
> +#define FRQSEL_150M		3
> +#define FRQSEL_MASK		GENMASK(24, 22)
> +#define FRQSEL_SHIFT(x)		((x) << 22)
> +
> +#define EMMC_PHYSTAT_REG	0xbc

> +#define CALDONE_MASK		1
> +#define DLLRDY_MASK		1
> +#define IS_CALDONE(x)	((((x) >> 9) & CALDONE_MASK) == 1)
> +#define IS_DLLRDY(x)	((((x) >> 8) & DLLRDY_MASK) == 1)

These are inconsistent with above:

	#define CALDONE_MASK	BIT(9)
	...
	#define IS_CALDONE	((x) & CALDONE_MASK)

Note redundant == part.

> +static int intel_emmc_phy_power(struct phy *phy, bool on_off)
> +{
> +	 * - PHY driver to probe
> +	 * - SDHCI driver to start probe
> +	 * - SDHCI driver to register it's clock
> +	 * - SDHCI driver to get the PHY
> +	 * - SDHCI driver to init the PHY
> +	 *


> +	 * The clock is optional, so upon any error we just set to NULL.

No, the clock framework will do it for you.

> +	 *
> +	 * NOTE: we don't do anything special for EPROBE_DEFER here.  Given the
> +	 * above expected use case, EPROBE_DEFER isn't sensible to expect, so
> +	 * it's just like any other error.

This comment is not correct...

> +	 */
> +	priv->emmcclk = clk_get_optional(&phy->dev, "emmcclk");
> +	if (IS_ERR(priv->emmcclk)) {

> +		dev_warn(&phy->dev, "ERROR: getting emmcclk\n");

...because here you have to return an error...

> +		priv->emmcclk = NULL;

...and here is redundant assignment.


> +	}
> +
> +	return 0;
> +}

When you send out patches, check that you do this for latest version you got reviewed internally.

-- 
With Best Regards,
Andy Shevchenko


