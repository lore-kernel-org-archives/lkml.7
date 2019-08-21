Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE483C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802992070B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfHUMBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:01:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:27218 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfHUMBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:01:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 05:01:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="178483430"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga008.fm.intel.com with ESMTP; 21 Aug 2019 05:01:44 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1i0PJ8-0007BJ-Av; Wed, 21 Aug 2019 15:01:42 +0300
Date:   Wed, 21 Aug 2019 15:01:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, peter.harliman.liem@intel.com
Subject: Re: [PATCH v3 2/2] phy: intel-lgm-emmc: Add support for eMMC PHY
Message-ID: <20190821120142.GX30120@smile.fi.intel.com>
References: <20190821101118.42774-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190821101118.42774-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821101118.42774-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 06:11:18PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add support for eMMC PHY on Intel's Lightning Mountain SoC.

> --- /dev/null
> +++ b/drivers/phy/intel/Kconfig
> @@ -0,0 +1,8 @@

Missed licence tag

> +#
> +# Phy drivers for Intel X86 LGM platform
> +#

> +#define EMMC_PHYCTRL2_REG	0xb0
> +#define FRQSEL_25M		0

I would still leave 1 and 2 with corresponding names for sake of documentation.

> +#define FRQSEL_150M		3
> +#define FRQSEL_MASK		GENMASK(24, 22)
> +#define FRQSEL_SHIFT(x)		(((x) << 22) & FRQSEL_MASK)

> +	unsigned int freqsel = 0;

Redundant assignment.

> +	udelay(5);

+ blank line

> +	regmap_update_bits(priv->syscfg, EMMC_PHYCTRL1_REG, PDB_MASK, 1);

And here missed to address one of my comments.

> +	/*
> +	 * We purposely get the clock here and not in probe to avoid the
> +	 * circular dependency problem.  We expect:

We don't use double space

> +	 * - PHY driver to probe
> +	 * - SDHCI driver to start probe
> +	 * - SDHCI driver to register it's clock
> +	 * - SDHCI driver to get the PHY
> +	 * - SDHCI driver to init the PHY
> +	 *
> +	 * The clock is optional, so upon any error just return it like
> +	 * any other error to user.
> +	 *
> +	 */

> +	struct device *dev = &pdev->dev;
> +	struct intel_emmc_phy *priv;
> +	struct phy *generic_phy;
> +	struct phy_provider *phy_provider;

> +	struct device_node *np = dev->of_node;

Group it with other assignment(s), i.e. dev = ... above.

	struct device *dev = ...;
	struct device_node *np = ...;

-- 
With Best Regards,
Andy Shevchenko


