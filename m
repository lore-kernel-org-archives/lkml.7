Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FF0C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24ACA21842
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406227AbfHBRoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:44:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:22791 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406087AbfHBRoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:44:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 10:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,339,1559545200"; 
   d="scan'208";a="191893041"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2019 10:44:53 -0700
Received: from cwhanson-mobl.amr.corp.intel.com (unknown [10.252.133.191])
        by linux.intel.com (Postfix) with ESMTP id 3CE915800BD;
        Fri,  2 Aug 2019 10:44:52 -0700 (PDT)
Subject: Re: [RFC PATCH 35/40] soundwire: intel: export helper to exit reset
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-36-pierre-louis.bossart@linux.intel.com>
 <20190802173115.GE12733@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0d76e6ed-1ab3-6a9d-b33c-deb248d5cb9d@linux.intel.com>
Date:   Fri, 2 Aug 2019 12:44:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802173115.GE12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/19 12:31 PM, Vinod Koul wrote:
> On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> 
> Here as well

I squashed this with earlier patches to fix the init sequence in one shot

> 
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/cadence_master.c | 9 +++++++--
>>   drivers/soundwire/cadence_master.h | 1 +
>>   drivers/soundwire/intel.c          | 4 ++++
>>   3 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
>> index 4a189e487830..f486fe15fb46 100644
>> --- a/drivers/soundwire/cadence_master.c
>> +++ b/drivers/soundwire/cadence_master.c
>> @@ -780,7 +780,11 @@ EXPORT_SYMBOL(sdw_cdns_thread);
>>    * init routines
>>    */
>>   
>> -static int do_reset(struct sdw_cdns *cdns)
>> +/**
>> + * sdw_cdns_exit_reset() - Program reset parameters and start bus operations
>> + * @cdns: Cadence instance
>> + */
>> +int sdw_cdns_exit_reset(struct sdw_cdns *cdns)
>>   {
>>   	int ret;
>>   
>> @@ -804,6 +808,7 @@ static int do_reset(struct sdw_cdns *cdns)
>>   
>>   	return ret;
>>   }
>> +EXPORT_SYMBOL(sdw_cdns_exit_reset);
>>   
>>   /**
>>    * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
>> @@ -839,7 +844,7 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>>   
>>   	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
>>   
>> -	return do_reset(cdns);
>> +	return 0;
>>   }
>>   EXPORT_SYMBOL(sdw_cdns_enable_interrupt);
>>   
>> diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
>> index de97bc22acb7..2b551f9226f3 100644
>> --- a/drivers/soundwire/cadence_master.h
>> +++ b/drivers/soundwire/cadence_master.h
>> @@ -161,6 +161,7 @@ irqreturn_t sdw_cdns_thread(int irq, void *dev_id);
>>   int sdw_cdns_init(struct sdw_cdns *cdns);
>>   int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
>>   		      struct sdw_cdns_stream_config config);
>> +int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
>>   int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
>>   
>>   void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index a976480d6f36..9ebe38e4d979 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -1112,6 +1112,8 @@ static int intel_probe(struct platform_device *pdev)
>>   
>>   	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
>>   
>> +	ret = sdw_cdns_exit_reset(&sdw->cdns);
>> +
>>   	/* Register DAIs */
>>   	ret = intel_register_dai(sdw);
>>   	if (ret) {
>> @@ -1199,6 +1201,8 @@ static int intel_resume(struct device *dev)
>>   
>>   	sdw_cdns_enable_interrupt(&sdw->cdns);
>>   
>> +	ret = sdw_cdns_exit_reset(&sdw->cdns);
>> +
>>   	return ret;
>>   }
>>   
>> -- 
>> 2.20.1
> 

