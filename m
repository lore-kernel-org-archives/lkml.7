Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44CAC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E42B216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfHEPlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:41:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:36573 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728868AbfHEPlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:41:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 08:41:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="164686579"
Received: from nupurjai-mobl.amr.corp.intel.com (HELO [10.251.149.179]) ([10.251.149.179])
  by orsmga007.jf.intel.com with ESMTP; 05 Aug 2019 08:41:20 -0700
Subject: Re: [alsa-devel] [RFC PATCH 26/40] soundwire: cadence_master: fix
 divider setting in clock register
To:     Sanyog Kale <sanyog.r.kale@intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Rander Wang <rander.wang@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-27-pierre-louis.bossart@linux.intel.com>
 <20190805104047.GG22437@buildpc-HP-Z230>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <acad7ddf-4b83-0019-2f6f-8fd7c80a0fcc@linux.intel.com>
Date:   Mon, 5 Aug 2019 10:41:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805104047.GG22437@buildpc-HP-Z230>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> @@ -988,9 +989,11 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>>   	/* Set clock divider */
>>   	divider	= (prop->mclk_freq / prop->max_clk_freq) - 1;
>>   	val = cdns_readl(cdns, CDNS_MCP_CLK_CTRL0);
> 
> reg read of CLK_CTRL0 can be removed.

yes for both comments. Thanks for the review Sanyog, appreciate it.

> 
>> -	val |= divider;
>> -	cdns_writel(cdns, CDNS_MCP_CLK_CTRL0, val);
>> -	cdns_writel(cdns, CDNS_MCP_CLK_CTRL1, val);
>> +
>> +	cdns_updatel(cdns, CDNS_MCP_CLK_CTRL0,
>> +		     CDNS_MCP_CLK_MCLKD_MASK, divider);
>> +	cdns_updatel(cdns, CDNS_MCP_CLK_CTRL1,
>> +		     CDNS_MCP_CLK_MCLKD_MASK, divider);
>>   
>>   	pr_err("plb: mclk %d max_freq %d divider %d register %x\n",
>>   	       prop->mclk_freq,
>> @@ -1064,8 +1067,7 @@ int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params)
>>   		mcp_clkctrl_off = CDNS_MCP_CLK_CTRL0;
>>   
>>   	mcp_clkctrl = cdns_readl(cdns, mcp_clkctrl_off);
> 
> same as above.
> 
>> -	mcp_clkctrl |= divider;
>> -	cdns_writel(cdns, mcp_clkctrl_off, mcp_clkctrl);
>> +	cdns_updatel(cdns, mcp_clkctrl_off, CDNS_MCP_CLK_MCLKD_MASK, divider);
>>   
>>   	pr_err("plb: mclk * 2 %d curr_dr_freq %d divider %d register %x\n",
>>   	       prop->mclk_freq * SDW_DOUBLE_RATE_FACTOR,
>> -- 
>> 2.20.1
>>
> 
