Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41529CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E00520650
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfJXMg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:36:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:57170 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfJXMgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:36:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 05:36:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; 
   d="scan'208";a="373201097"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 24 Oct 2019 05:36:55 -0700
Received: from atirumal-mobl1.amr.corp.intel.com (unknown [10.251.26.228])
        by linux.intel.com (Postfix) with ESMTP id 1888258013F;
        Thu, 24 Oct 2019 05:36:54 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] soundwire: intel: fix PDI/stream mapping for
 Bulk
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20191022232948.17156-1-pierre-louis.bossart@linux.intel.com>
 <20191024112356.GA2620@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6bcfe0bc-5b8e-fb23-f221-b82f2201feb9@linux.intel.com>
Date:   Thu, 24 Oct 2019 07:37:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024112356.GA2620@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/19 6:23 AM, Vinod Koul wrote:
> On 22-10-19, 18:29, Pierre-Louis Bossart wrote:
>> The previous formula is incorrect for PDI0/1, the mapping is not
>> linear but has a discontinuity between PDI1 and PDI2.
>>
>> This change has no effect on PCM PDIs (same mapping).
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/intel.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index b403ccc832b6..c984261fcc33 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -480,7 +480,10 @@ intel_pdi_shim_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
>>   	unsigned int link_id = sdw->instance;
>>   	int pdi_conf = 0;
>>   
>> -	pdi->intel_alh_id = (link_id * 16) + pdi->num + 5;
>> +	/* the Bulk and PCM streams are not contiguous */
>> +	pdi->intel_alh_id = (link_id * 16) + pdi->num + 3;
>> +	if (pdi->num >= 2)
>> +		pdi->intel_alh_id += 2;
>>   
>>   	/*
>>   	 * Program stream parameters to stream SHIM register
>> @@ -509,7 +512,10 @@ intel_pdi_alh_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
>>   	unsigned int link_id = sdw->instance;
>>   	unsigned int conf;
>>   
>> -	pdi->intel_alh_id = (link_id * 16) + pdi->num + 5;
>> +	/* the Bulk and PCM streams are not contiguous */
>> +	pdi->intel_alh_id = (link_id * 16) + pdi->num + 3;
>> +	if (pdi->num >= 2)
>> +		pdi->intel_alh_id += 2;
> 
> The change is repeated so how about:
> 
>          intel_pdi_update_alh() or similar which does this rather than
> repeat the pattern

The initial code was also repeated by the initial contributors, this 
patch does not refactor the code but corrects an invalid mapping. We 
will do this refactoring at a later point, when we add the clock-stop mode.

> 
>>   
>>   	/* Program Stream config ALH register */
>>   	conf = intel_readl(alh, SDW_ALH_STRMZCFG(pdi->intel_alh_id));
>> -- 
>> 2.20.1
> 

