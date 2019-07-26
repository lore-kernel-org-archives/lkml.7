Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C90C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6E92189F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfGZRWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 13:22:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:63386 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfGZRWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 13:22:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 10:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="198460217"
Received: from andawes-mobl.amr.corp.intel.com (HELO [10.251.145.66]) ([10.251.145.66])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2019 10:22:15 -0700
Subject: Re: [alsa-devel] [RFC PATCH 35/40] soundwire: intel: export helper to
 exit reset
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-36-pierre-louis.bossart@linux.intel.com>
 <20190726155213.GK16003@ubuntu>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4b1f657c-e75f-d817-aa86-4224ce459a01@linux.intel.com>
Date:   Fri, 26 Jul 2019 12:22:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726155213.GK16003@ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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
> 
> This isn't something, that this patch changes, but if the return value above is
> ignored, maybe no need to assign it at all?

The return of these two functions was used with in some logs at some 
point but they obviously vanished.
I'll re-check if we care about the status, could be that it never fails
Thanks!


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
