Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F05AC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379292332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfHUFdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 01:33:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:60327 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfHUFdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 01:33:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 22:33:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,411,1559545200"; 
   d="scan'208";a="179952645"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 20 Aug 2019 22:33:17 -0700
Received: from [10.226.38.21] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.21])
        by linux.intel.com (Postfix) with ESMTP id BA1DD580258;
        Tue, 20 Aug 2019 22:33:15 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] phy: intel-lgm-emmc: Add support for eMMC PHY
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, peter.harliman.liem@intel.com
References: <20190820103133.53776-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190820103133.53776-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190820135602.GN30120@smile.fi.intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <8aadf00b-048a-0db8-ba31-307cc6e7eb2e@linux.intel.com>
Date:   Wed, 21 Aug 2019 13:33:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820135602.GN30120@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/8/2019 9:56 PM, Andy Shevchenko wrote:
> On Tue, Aug 20, 2019 at 06:31:33PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add support for eMMC PHY on Intel's Lightning Mountain SoC.
> Thanks for an update.
> Looks better though several minor comments below.
>
Thanks a lot! Andy,  for the review comments.

>> +/* eMMC phy register definitions */
>> +#define EMMC_PHYCTRL0_REG	0xa8
>> +#define DR_TY_MASK		GENMASK(30, 28)
>> +#define DR_TY_50OHM(x)		((~(x) << 28) & DR_TY_MASK)
> For consistency it should be
>
> #define DR_TY_SHIFT(x)		(((x) << 28) & DR_TY_MASK)
>
> with explanation about 50 Ohm in the code below.
>
>> +#define OTAPDLYENA		BIT(14)
>> +#define OTAPDLYSEL_MASK		GENMASK(13, 10)
>> +#define OTAPDLYSEL_SHIFT(x)	(((x) << 10) & OTAPDLYSEL_MASK)
>> +
>> +#define EMMC_PHYCTRL1_REG	0xac
>> +#define PDB_MASK		BIT(0)
>> +#define ENDLL_MASK		BIT(7)
>> +#define ENDLL_VAL		BIT(7)
> Again, inconsistency here,
>
> #define ENDLL_SHIFT(x)		(((x) << 7) & ENDLL_MASK)
Agreed
>> +#define EMMC_PHYCTRL2_REG	0xb0
>> +#define FRQSEL_25M		0
>> +#define FRQSEL_150M		3
>> +#define FRQSEL_MASK		GENMASK(24, 22)
>> +#define FRQSEL_SHIFT(x)		((x) << 22)
> And here
>
> #define FRQSEL_SHIFT(x)		(((x) << 22) & FRQSEL_MASK)
Agreed
>> +	/*
>> +	 * According to the user manual, calpad calibration
>> +	 * cycle takes more than 2us without the minimal recommended
>> +	 * value, so we may need a little margin here
>> +	 */
>> +	usleep_range(3, 6);
> Actually for this low values it's recommended to use udelay() disregard to
> context.
>
> 	udelay(5);
Agreed
>> +	regmap_update_bits(priv->syscfg, EMMC_PHYCTRL1_REG, PDB_MASK, 1);
> 1 looks like a magic that has to be changed in the same way as for the rest, i.e.
>
> #define PDB_SHIFT(x)	(((x) << 0) & PDB_MASK)
>
> 	..., PDB_MASK, PDB_SHIFT(1)...
Agreed
>> +static int intel_emmc_phy_power_on(struct phy *phy)
>> +{
>> +	struct intel_emmc_phy *priv = phy_get_drvdata(phy);
>> +	int ret;
>> +
>> +	/* Drive impedance: 50 Ohm */
> Nice, you have already a comment here. Just use DR_TY_SHIFT(1)
>
>> +	ret = regmap_update_bits(priv->syscfg, EMMC_PHYCTRL0_REG, DR_TY_MASK,
>> +				 DR_TY_50OHM(1));
>> +	ret = regmap_update_bits(priv->syscfg, EMMC_PHYCTRL0_REG, OTAPDLYENA,
>> +				 0x0);
> 0x0 -> 0
Noted
>> +static int intel_emmc_phy_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct intel_emmc_phy *priv;
>> +	struct phy *generic_phy;
>> +	struct phy_provider *phy_provider;
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	/* Get eMMC phy (accessed via chiptop) regmap */
>> +	priv->syscfg = syscon_regmap_lookup_by_phandle(dev->of_node,
>> +						       "intel,syscon");
> Perhaps
>
> 	struct device_node *np = dev->of_node;
> 	...
> 	priv->syscfg = syscon_regmap_lookup_by_phandle(np, "intel,syscon");
>
>> +	generic_phy = devm_phy_create(dev, dev->of_node, &ops);
> And here.

Noted, will update

With Best Regards
Vadivel
