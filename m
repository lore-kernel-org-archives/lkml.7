Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26529C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00344216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfHEPkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:40:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:26647 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfHEPkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:40:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 08:40:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="164686112"
Received: from nupurjai-mobl.amr.corp.intel.com (HELO [10.251.149.179]) ([10.251.149.179])
  by orsmga007.jf.intel.com with ESMTP; 05 Aug 2019 08:40:13 -0700
Subject: Re: [alsa-devel] [RFC PATCH 25/40] soundwire: intel: use BIOS
 information to set clock dividers
To:     Sanyog Kale <sanyog.r.kale@intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-26-pierre-louis.bossart@linux.intel.com>
 <20190805102828.GF22437@buildpc-HP-Z230>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <dc04e596-a16e-257c-ee53-3bc820b7eea0@linux.intel.com>
Date:   Mon, 5 Aug 2019 10:40:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805102828.GF22437@buildpc-HP-Z230>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/19 5:28 AM, Sanyog Kale wrote:
> On Thu, Jul 25, 2019 at 06:40:17PM -0500, Pierre-Louis Bossart wrote:
>> The BIOS provides an Intel-specific property, let's use it to avoid
>> hard-coded clock dividers.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/cadence_master.c | 26 ++++++++++++++++++++++----
>>   drivers/soundwire/intel.c          | 26 ++++++++++++++++++++++++++
>>   include/linux/soundwire/sdw.h      |  2 ++
>>   3 files changed, 50 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
>> index d84344e29f71..10ebcef2e84e 100644
>> --- a/drivers/soundwire/cadence_master.c
>> +++ b/drivers/soundwire/cadence_master.c
>> @@ -173,8 +173,6 @@
>>   #define CDNS_PDI_CONFIG_PORT			GENMASK(4, 0)
>>   
>>   /* Driver defaults */
>> -
>> -#define CDNS_DEFAULT_CLK_DIVIDER		0
>>   #define CDNS_DEFAULT_SSP_INTERVAL		0x18
>>   #define CDNS_TX_TIMEOUT				2000
>>   
>> @@ -973,7 +971,10 @@ static u32 cdns_set_default_frame_shape(int n_rows, int n_cols)
>>    */
>>   int sdw_cdns_init(struct sdw_cdns *cdns)
>>   {
>> +	struct sdw_bus *bus = &cdns->bus;
>> +	struct sdw_master_prop *prop = &bus->prop;
>>   	u32 val;
>> +	int divider;
>>   	int ret;
>>   
>>   	/* Exit clock stop */
>> @@ -985,9 +986,17 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>>   	}
>>   
>>   	/* Set clock divider */
>> +	divider	= (prop->mclk_freq / prop->max_clk_freq) - 1;
> 
> Do you expect mclk_freq and max_clk_freq to be same?

Nope. For Icelake the MCLK is 38.4 MHz and is, but the max_clk needs to 
be 9.6 max (can't be higher per the SoundWire spec).

The max_clk_freq may even be lower thank 9.6 MHz due to specific 
topologies where the higher frequencies are problematic if the trace 
lengths are too long.

For CNL/CML the MCLK is 24 MHz but ironically we run the bus at 12 MHz, 
so the divider is smaller.

> 
>>   	val = cdns_readl(cdns, CDNS_MCP_CLK_CTRL0);
>> -	val |= CDNS_DEFAULT_CLK_DIVIDER;
>> +	val |= divider;
>>   	cdns_writel(cdns, CDNS_MCP_CLK_CTRL0, val);
>> +	cdns_writel(cdns, CDNS_MCP_CLK_CTRL1, val);
>> +
>> +	pr_err("plb: mclk %d max_freq %d divider %d register %x\n",
>> +	       prop->mclk_freq,
>> +	       prop->max_clk_freq,
>> +	       divider,
>> +	       val);
> 
> This can be removed.

yes, done already.

> 
>>   
>>   	/* Set the default frame shape */
>>   	val = cdns_set_default_frame_shape(prop->default_row,
>> @@ -1035,6 +1044,7 @@ EXPORT_SYMBOL(sdw_cdns_init);
>>   
>>   int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params)
>>   {
>> +	struct sdw_master_prop *prop = &bus->prop;
>>   	struct sdw_cdns *cdns = bus_to_cdns(bus);
>>   	int mcp_clkctrl_off, mcp_clkctrl;
>>   	int divider;
>> @@ -1044,7 +1054,9 @@ int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params)
>>   		return -EINVAL;
>>   	}
>>   
>> -	divider	= (params->max_dr_freq / params->curr_dr_freq) - 1;
>> +	divider	= prop->mclk_freq * SDW_DOUBLE_RATE_FACTOR /
> 
> What is the reason for not using max_dr_freq? Its precomputed as
> prop->max_clk_freq * SDW_DOUBLE_RATE_FACTOR;

no, as explained above the divider needs to start from the clock 
provided to the IP, which is different from the max frequency clock the 
bus operates at. the MCLK is a fixed value for all platforms using the 
same SOC/PCH, the max_clk is platform-dependent and its value is 
provided by the firmware (BIOS/DT).
