Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371CDCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF2121A4A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732808AbfJWR54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:57:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:46634 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732626AbfJWR5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:57:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 10:57:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; 
   d="scan'208";a="196854544"
Received: from kmaklai-mobl2.amr.corp.intel.com (HELO [10.252.137.221]) ([10.252.137.221])
  by fmsmga008.fm.intel.com with ESMTP; 23 Oct 2019 10:57:52 -0700
Subject: Re: [alsa-devel] [PATCH v2 4/5] soundwire: intel/cadence: add flag
 for interrupt enable
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20190916190952.32388-1-pierre-louis.bossart@linux.intel.com>
 <20190916190952.32388-5-pierre-louis.bossart@linux.intel.com>
 <20191021041404.GY2654@vkoul-mobl>
 <8ba388e7-e344-068b-b233-8d96903abf6b@linux.intel.com>
 <20191022045518.GJ2654@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c6aeb19f-8646-6396-10a7-47acac540106@linux.intel.com>
Date:   Tue, 22 Oct 2019 15:41:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022045518.GJ2654@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/19 11:55 PM, Vinod Koul wrote:
> On 21-10-19, 05:26, Pierre-Louis Bossart wrote:
>> On 10/20/19 11:14 PM, Vinod Koul wrote:
>>> On 16-09-19, 14:09, Pierre-Louis Bossart wrote:
>>>> Prepare for future PM support and fix error handling by disabling
>>>> interrupts as needed.
>>>>
>>>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>>> ---
>>>>    drivers/soundwire/cadence_master.c | 18 ++++++++++++------
>>>>    drivers/soundwire/cadence_master.h |  2 +-
>>>>    drivers/soundwire/intel.c          | 12 +++++++-----
>>>>    3 files changed, 20 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
>>>> index 5f900cf2acb9..a71df99ca18f 100644
>>>> --- a/drivers/soundwire/cadence_master.c
>>>> +++ b/drivers/soundwire/cadence_master.c
>>>> @@ -819,14 +819,17 @@ EXPORT_SYMBOL(sdw_cdns_exit_reset);
>>>>     * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
>>>>     * @cdns: Cadence instance
>>>>     */
>>>> -int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>>>> +int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state)
>>>>    {
>>>> -	u32 mask;
>>>> +	u32 slave_intmask0 = 0;
>>>> +	u32 slave_intmask1 = 0;
>>>> +	u32 mask = 0;
>>>> +
>>>> +	if (!state)
>>>> +		goto update_masks;
>>>> -	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0,
>>>> -		    CDNS_MCP_SLAVE_INTMASK0_MASK);
>>>> -	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
>>>> -		    CDNS_MCP_SLAVE_INTMASK1_MASK);
>>>> +	slave_intmask0 = CDNS_MCP_SLAVE_INTMASK0_MASK;
>>>> +	slave_intmask1 = CDNS_MCP_SLAVE_INTMASK1_MASK;
>>>>    	/* enable detection of all slave state changes */
>>>>    	mask = CDNS_MCP_INT_SLAVE_MASK;
>>>> @@ -849,6 +852,9 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>>>>    	if (interrupt_mask) /* parameter override */
>>>>    		mask = interrupt_mask;
>>>> +update_masks:
>>>> +	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0, slave_intmask0);
>>>> +	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1, slave_intmask1);
>>>>    	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
>>>>    	/* commit changes */
>>>> diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
>>>> index 1a67728c5000..302351808098 100644
>>>> --- a/drivers/soundwire/cadence_master.h
>>>> +++ b/drivers/soundwire/cadence_master.h
>>>> @@ -162,7 +162,7 @@ int sdw_cdns_init(struct sdw_cdns *cdns);
>>>>    int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
>>>>    		      struct sdw_cdns_stream_config config);
>>>>    int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
>>>> -int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
>>>> +int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state);
>>>>    #ifdef CONFIG_DEBUG_FS
>>>>    void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
>>>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>>>> index cdb3243e8823..08530c136c5f 100644
>>>> --- a/drivers/soundwire/intel.c
>>>> +++ b/drivers/soundwire/intel.c
>>>> @@ -1036,7 +1036,7 @@ static int intel_probe(struct platform_device *pdev)
>>>>    	ret = sdw_add_bus_master(&sdw->cdns.bus);
>>>>    	if (ret) {
>>>>    		dev_err(&pdev->dev, "sdw_add_bus_master fail: %d\n", ret);
>>>> -		goto err_master_reg;
>>>> +		return ret;
>>>
>>> I am not sure I like this line change, before this IIRC the function and
>>> single place of return, so changing this doesn't seem to improve
>>> anything here..?
>>
>> Doing a goto to do a return is not very nice either.
> 
> Hrmm, isn't that what you are doing few lines below. The point here is
> that this line of change here doesnt change anything, doesnt improve
> anything so why change :)

I knew there was a reason.. the existing code on your soundwire/next 
branch mixes goto and return, so I chose to use a return for the first 
case as well.

	ret = sdw_add_bus_master(&sdw->cdns.bus);
	if (ret) {
		dev_err(&pdev->dev, "sdw_add_bus_master fail: %d\n", ret);
		goto err_master_reg; >>> changed to return ret;
	}

	if (sdw->cdns.bus.prop.hw_disabled) {
		dev_info(&pdev->dev, "SoundWire master %d is disabled, ignoring\n",
			 sdw->cdns.bus.link_id);
		return 0;
	}



> 
>> I can change this, but it doesn't really matter: this entire code will be
>> removed anyways to get rid of platform_devices and the probe itself will be
>> split in two.
>>
>>>
>>>>    	}
>>>>    	if (sdw->cdns.bus.prop.hw_disabled) {
>>>> @@ -1067,7 +1067,7 @@ static int intel_probe(struct platform_device *pdev)
>>>>    		goto err_init;
>>>>    	}
>>>> -	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
>>>> +	ret = sdw_cdns_enable_interrupt(&sdw->cdns, true);
>>>>    	if (ret < 0) {
>>>>    		dev_err(sdw->cdns.dev, "cannot enable interrupts\n");
>>>>    		goto err_init;
>>>> @@ -1076,7 +1076,7 @@ static int intel_probe(struct platform_device *pdev)
>>>>    	ret = sdw_cdns_exit_reset(&sdw->cdns);
>>>>    	if (ret < 0) {
>>>>    		dev_err(sdw->cdns.dev, "unable to exit bus reset sequence\n");
>>>> -		goto err_init;
>>>> +		goto err_interrupt;
>>>>    	}
>>>>    	/* Register DAIs */
>>>> @@ -1084,18 +1084,19 @@ static int intel_probe(struct platform_device *pdev)
>>>>    	if (ret) {
>>>>    		dev_err(sdw->cdns.dev, "DAI registration failed: %d\n", ret);
>>>>    		snd_soc_unregister_component(sdw->cdns.dev);
>>>> -		goto err_dai;
>>>> +		goto err_interrupt;
>>>>    	}
>>>>    	intel_debugfs_init(sdw);
>>>>    	return 0;
>>>> +err_interrupt:
>>>> +	sdw_cdns_enable_interrupt(&sdw->cdns, false);
>>>>    err_dai:
>>>
>>> Isn't this unused now?
> 
> ??? you missed this.

fixed.
