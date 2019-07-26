Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4F9C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D57821743
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfGZOYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:24:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:51935 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfGZOYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:24:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 07:24:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="322052065"
Received: from msmall-mobl.amr.corp.intel.com (HELO [10.251.154.62]) ([10.251.154.62])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 07:24:51 -0700
Subject: Re: [alsa-devel] [RFC PATCH 26/40] soundwire: cadence_master: fix
 divider setting in clock register
To:     Bard liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-27-pierre-louis.bossart@linux.intel.com>
 <f38a5e3a-c797-ae53-f0d4-31ac46ec360b@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <616012b9-d4a2-b980-68e6-d9ba7e6d819b@linux.intel.com>
Date:   Fri, 26 Jul 2019 09:24:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f38a5e3a-c797-ae53-f0d4-31ac46ec360b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/19 12:19 AM, Bard liao wrote:
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
>>   #define CDNS_MCP_STAT                0x40
>> @@ -988,9 +989,11 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>>       /* Set clock divider */
>>       divider    = (prop->mclk_freq / prop->max_clk_freq) - 1;
>>       val = cdns_readl(cdns, CDNS_MCP_CLK_CTRL0);
> 
> 
> Do we still need to read cdns_readl(cdns, CDNS_MCP_CLK_CTRL0)
> 
> after this change?

no I don't think we do indeed.
> 
> 
>> -    val |= divider;
>> -    cdns_writel(cdns, CDNS_MCP_CLK_CTRL0, val);
>> -    cdns_writel(cdns, CDNS_MCP_CLK_CTRL1, val);
>> +
>> +    cdns_updatel(cdns, CDNS_MCP_CLK_CTRL0,
>> +             CDNS_MCP_CLK_MCLKD_MASK, divider);
>> +    cdns_updatel(cdns, CDNS_MCP_CLK_CTRL1,
>> +             CDNS_MCP_CLK_MCLKD_MASK, divider);
>>       pr_err("plb: mclk %d max_freq %d divider %d register %x\n",
>>              prop->mclk_freq,

and this log needs to go away or done in a better way, I missed this.

>> @@ -1064,8 +1067,7 @@ int cdns_bus_conf(struct sdw_bus *bus, struct 
>> sdw_bus_params *params)
>>           mcp_clkctrl_off = CDNS_MCP_CLK_CTRL0;
>>       mcp_clkctrl = cdns_readl(cdns, mcp_clkctrl_off);
> 
> 
> Same here.

yep.

> 
> 
>> -    mcp_clkctrl |= divider;
>> -    cdns_writel(cdns, mcp_clkctrl_off, mcp_clkctrl);
>> +    cdns_updatel(cdns, mcp_clkctrl_off, CDNS_MCP_CLK_MCLKD_MASK, 
>> divider);
>>       pr_err("plb: mclk * 2 %d curr_dr_freq %d divider %d register %x\n",
>>              prop->mclk_freq * SDW_DOUBLE_RATE_FACTOR,
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
