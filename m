Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BDEC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D804920870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfHVGyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:54:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:23674 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfHVGyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:54:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 23:54:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,415,1559545200"; 
   d="scan'208";a="183780244"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 21 Aug 2019 23:54:54 -0700
Received: from [10.226.38.19] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.19])
        by linux.intel.com (Postfix) with ESMTP id 2F071580258;
        Wed, 21 Aug 2019 23:54:52 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] phy: intel-lgm-emmc: Add support for eMMC PHY
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, peter.harliman.liem@intel.com
References: <20190821101118.42774-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190821101118.42774-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190821120142.GX30120@smile.fi.intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <ca523af8-4d6b-ad1a-322b-7142c77a3c3b@linux.intel.com>
Date:   Thu, 22 Aug 2019 14:54:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821120142.GX30120@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,
On 21/8/2019 8:01 PM, Andy Shevchenko wrote:
> On Wed, Aug 21, 2019 at 06:11:18PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add support for eMMC PHY on Intel's Lightning Mountain SoC.
>> --- /dev/null
>> +++ b/drivers/phy/intel/Kconfig
>> @@ -0,0 +1,8 @@
> Missed licence tag
Thank you so much for the review comments, will update.
>> +#
>> +# Phy drivers for Intel X86 LGM platform
>> +#
>> +#define EMMC_PHYCTRL2_REG	0xb0
>> +#define FRQSEL_25M		0
> I would still leave 1 and 2 with corresponding names for sake of documentation.
Ok, will add for the sake of documentation.
>> +#define FRQSEL_150M		3
>> +#define FRQSEL_MASK		GENMASK(24, 22)
>> +#define FRQSEL_SHIFT(x)		(((x) << 22) & FRQSEL_MASK)
>> +	unsigned int freqsel = 0;
> Redundant assignment.
Noted, will update.
>> +	udelay(5);
> + blank line
Noted, will update
>
>> +	regmap_update_bits(priv->syscfg, EMMC_PHYCTRL1_REG, PDB_MASK, 1);
> And here missed to address one of my comments.
Yes, will update.
>> +	/*
>> +	 * We purposely get the clock here and not in probe to avoid the
>> +	 * circular dependency problem.  We expect:
> We don't use double space
Noted, will update.
>> +	 * - PHY driver to probe
>> +	 * - SDHCI driver to start probe
>> +	 * - SDHCI driver to register it's clock
>> +	 * - SDHCI driver to get the PHY
>> +	 * - SDHCI driver to init the PHY
>> +	 *
>> +	 * The clock is optional, so upon any error just return it like
>> +	 * any other error to user.
>> +	 *
>> +	 */
>> +	struct device *dev = &pdev->dev;
>> +	struct intel_emmc_phy *priv;
>> +	struct phy *generic_phy;
>> +	struct phy_provider *phy_provider;
>> +	struct device_node *np = dev->of_node;
> Group it with other assignment(s), i.e. dev = ... above.
>
> 	struct device *dev = ...;
> 	struct device_node *np = ...;

agree, will update.

---
With Best Regards
Vadivel Murugan
