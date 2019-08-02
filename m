Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDC8C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FA7204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391416AbfHBPSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:18:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:16123 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729449AbfHBPSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:18:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 08:18:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,338,1559545200"; 
   d="scan'208";a="175610200"
Received: from vivekcha-mobl1.amr.corp.intel.com (HELO [10.251.131.115]) ([10.251.131.115])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2019 08:18:02 -0700
Subject: Re: [RFC PATCH 07/40] soundwire: intel: fix channel number reported
 by hardware
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-8-pierre-louis.bossart@linux.intel.com>
 <20190802115719.GJ12733@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c8c035fd-9a68-260b-7909-66a43695cea0@linux.intel.com>
Date:   Fri, 2 Aug 2019 10:18:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802115719.GJ12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/19 6:57 AM, Vinod Koul wrote:
> On 25-07-19, 18:39, Pierre-Louis Bossart wrote:
>> PDI2 reports an invalid count, force the correct hardware-supported
>> value
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/intel.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index 497879dd9c0d..51990b192dc0 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -401,6 +401,15 @@ intel_pdi_get_ch_cap(struct sdw_intel *sdw, unsigned int pdi_num, bool pcm)
>>   
>>   	if (pcm) {
>>   		count = intel_readw(shim, SDW_SHIM_PCMSYCHC(link_id, pdi_num));
>> +
>> +		/*
>> +		 * TODO: pdi number 2 reports channel count as 1 even though
>> +		 * it supports 8 channel. Performing hardcoding for pdi
>> +		 * number 2.
>> +		 */
>> +		if (pdi_num == 2)
>> +			count = 7;
> 
> Is that true for all Intel controllers or some generations. Would it not
> be better to put this under some flag which is set on platform basis?

This is true of all controllers released so far.
We will change this if the hardware changes.

> 
>> +
>>   	} else {
>>   		count = intel_readw(shim, SDW_SHIM_PDMSCAP(link_id));
>>   		count = ((count & SDW_SHIM_PDMSCAP_CPSS) >>
>> -- 
>> 2.20.1
> 
