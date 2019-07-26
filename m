Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8449C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED18217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfGZF4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 01:56:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:39824 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfGZF4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 01:56:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 22:56:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,309,1559545200"; 
   d="scan'208";a="175500246"
Received: from yuxiwan1-mobl1.ccr.corp.intel.com (HELO [10.239.197.176]) ([10.239.197.176])
  by orsmga006.jf.intel.com with ESMTP; 25 Jul 2019 22:56:46 -0700
Subject: Re: [alsa-devel] [RFC PATCH 26/40] soundwire: cadence_master: fix
 divider setting in clock register
To:     Bard liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-27-pierre-louis.bossart@linux.intel.com>
 <f38a5e3a-c797-ae53-f0d4-31ac46ec360b@linux.intel.com>
From:   "rander.wang" <rander.wang@linux.intel.com>
Message-ID: <552565d2-1734-3c24-3a78-379d08e35110@linux.intel.com>
Date:   Fri, 26 Jul 2019 13:56:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <f38a5e3a-c797-ae53-f0d4-31ac46ec360b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 7/26/2019 1:19 PM, Bard liao 写道:
>
> On 7/26/2019 7:40 AM, Pierre-Louis Bossart wrote:
>> From: Rander Wang <rander.wang@linux.intel.com>
>>
>> The existing code uses an OR operation which would mix the original
>> divider setting with the new one, resulting in an invalid
>> configuration that can make codecs hang.
>>
>> Add the mask definition and use cdns_updatel to update divider
>>
>> Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
>> Signed-off-by: Pierre-Louis Bossart 
>> <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/cadence_master.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/soundwire/cadence_master.c 
>> b/drivers/soundwire/cadence_master.c
>> index 10ebcef2e84e..18c6ac026e85 100644
>> --- a/drivers/soundwire/cadence_master.c
>> +++ b/drivers/soundwire/cadence_master.c
>> @@ -57,6 +57,7 @@
>>   #define CDNS_MCP_SSP_CTRL1            0x28
>>   #define CDNS_MCP_CLK_CTRL0            0x30
>>   #define CDNS_MCP_CLK_CTRL1            0x38
>> +#define CDNS_MCP_CLK_MCLKD_MASK        GENMASK(7, 0)
>>     #define CDNS_MCP_STAT                0x40
>>   @@ -988,9 +989,11 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>>       /* Set clock divider */
>>       divider    = (prop->mclk_freq / prop->max_clk_freq) - 1;
>>       val = cdns_readl(cdns, CDNS_MCP_CLK_CTRL0);
>
>
> Do we still need to read cdns_readl(cdns, CDNS_MCP_CLK_CTRL0)
>
> after this change?
>
The val is used to print debug message,  and my opinion is to change the log

from pr_err("plb: ........") to dev_dbg(bus->dev, "........") to follow 
the dev_dbg

usage in this file.

>
>> -    val |= divider;
>> -    cdns_writel(cdns, CDNS_MCP_CLK_CTRL0, val);
>> -    cdns_writel(cdns, CDNS_MCP_CLK_CTRL1, val);
>> +
>> +    cdns_updatel(cdns, CDNS_MCP_CLK_CTRL0,
>> +             CDNS_MCP_CLK_MCLKD_MASK, divider);
>> +    cdns_updatel(cdns, CDNS_MCP_CLK_CTRL1,
>> +             CDNS_MCP_CLK_MCLKD_MASK, divider);
>>         pr_err("plb: mclk %d max_freq %d divider %d register %x\n",
>>              prop->mclk_freq,
>> @@ -1064,8 +1067,7 @@ int cdns_bus_conf(struct sdw_bus *bus, struct 
>> sdw_bus_params *params)
>>           mcp_clkctrl_off = CDNS_MCP_CLK_CTRL0;
>>         mcp_clkctrl = cdns_readl(cdns, mcp_clkctrl_off);
>
>
> Same here.
>
Also refine the debug log.
>
>> -    mcp_clkctrl |= divider;
>> -    cdns_writel(cdns, mcp_clkctrl_off, mcp_clkctrl);
>> +    cdns_updatel(cdns, mcp_clkctrl_off, CDNS_MCP_CLK_MCLKD_MASK, 
>> divider);
>>         pr_err("plb: mclk * 2 %d curr_dr_freq %d divider %d register 
>> %x\n",
>>              prop->mclk_freq * SDW_DOUBLE_RATE_FACTOR,
