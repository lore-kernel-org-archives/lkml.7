Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947E1CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AA121E6F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388345AbfKDV4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:56:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:20673 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388302AbfKDV4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:56:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 13:56:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400"; 
   d="scan'208";a="226888844"
Received: from trowland-mobl.amr.corp.intel.com (HELO [10.254.97.182]) ([10.254.97.182])
  by fmsmga004.fm.intel.com with ESMTP; 04 Nov 2019 13:56:11 -0800
Subject: Re: [alsa-devel] [PATCH 13/14] soundwire: intel: free all resources
 on hw_free()
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
 <20191023212823.608-14-pierre-louis.bossart@linux.intel.com>
 <42403ea0-e337-81b6-f11a-2a32c1473750@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0374d162-2cea-2fca-ec12-a0377130c711@linux.intel.com>
Date:   Mon, 4 Nov 2019 15:46:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <42403ea0-e337-81b6-f11a-2a32c1473750@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/19 2:08 PM, Cezary Rojewski wrote:
> On 2019-10-23 23:28, Pierre-Louis Bossart wrote:
>> Make sure all calls to the SoundWire stream API are done and involve
>> callback
>>
>> Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
>> Signed-off-by: Pierre-Louis Bossart 
>> <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/intel.c | 40 +++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 38 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index af24fa048add..cad1c0b64ee3 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -548,6 +548,25 @@ static int intel_params_stream(struct sdw_intel 
>> *sdw,
>>       return -EIO;
>>   }
>> +static int intel_free_stream(struct sdw_intel *sdw,
>> +                 struct snd_pcm_substream *substream,
>> +                 struct snd_soc_dai *dai,
>> +                 int link_id)
>> +{
>> +    struct sdw_intel_link_res *res = sdw->link_res;
>> +    struct sdw_intel_stream_free_data free_data;
>> +
>> +    free_data.substream = substream;
>> +    free_data.dai = dai;
>> +    free_data.link_id = link_id;
>> +
>> +    if (res->ops && res->ops->free_stream && res->dev)
> 
> Can res->dev even be null?

in error cases yes. this 'res' structure is setup by the DSP driver, and 
it could be wrong or not set.

Note that in the previous solution we tested the res->arg pointer, we 
did find a case where we could oops here.

> 
>> +        return res->ops->free_stream(res->dev,
>> +                         &free_data);
>> +
>> +    return 0;
>> +}
>> +
>>   /*
>>    * bank switch routines
>>    */
>> @@ -816,6 +835,7 @@ static int
>>   intel_hw_free(struct snd_pcm_substream *substream, struct 
>> snd_soc_dai *dai)
>>   {
>>       struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
>> +    struct sdw_intel *sdw = cdns_to_intel(cdns);
>>       struct sdw_cdns_dma_data *dma;
>>       int ret;
>> @@ -823,12 +843,28 @@ intel_hw_free(struct snd_pcm_substream 
>> *substream, struct snd_soc_dai *dai)
>>       if (!dma)
>>           return -EIO;
>> +    ret = sdw_deprepare_stream(dma->stream);
>> +    if (ret) {
>> +        dev_err(dai->dev, "sdw_deprepare_stream: failed %d", ret);
>> +        return ret;
>> +    }
>> +
> 
> I understand that you want to be transparent to caller with failure 
> reasons via dev_err/_warn. However, sdw_deprepare_stream already dumps 
> all the logs we need. The same applies for most of the other calls (and 
> not just in this patch..).
> 
> Do we really need to be that verbose? Maybe just agree on caller -or- 
> subject being the source for the messaging, align existing usages and 
> thus preventing further duplication?
> 
> Not forcing anything, just asking for your opinion on this.

the sdw_prepare/deprepare_stream calls provide error logs, but they are 
not mapped to specific devices/dais (pr_err vs. dev_dbg). I found it was 
easier to check for which dai the error was reported.

We are also in the middle of integration with new hardware/boards, and 
erring on the side of more traces will help everyone involved. We can 
revisit later which ones are strictly necessary.

> 
>>       ret = sdw_stream_remove_master(&cdns->bus, dma->stream);
>> -    if (ret < 0)
>> +    if (ret < 0) {
>>           dev_err(dai->dev, "remove master from stream %s failed: %d\n",
>>               dma->stream->name, ret);
>> +        return ret;
>> +    }
>> -    return ret;
>> +    ret = intel_free_stream(sdw, substream, dai, sdw->instance);
>> +    if (ret < 0) {
>> +        dev_err(dai->dev, "intel_free_stream: failed %d", ret);
>> +        return ret;
>> +    }
>> +
>> +    sdw_release_stream(dma->stream);
>> +
>> +    return 0;
>>   }
> 
> Given the structure of this function, shouldn't the generic flow be 
> handled by upper layer i.e. part of sdw core?. Apart from 
> intel_free_stream, the rest looks pretty generic to me and this sole 
> call could easily be extracted into ops.

The mapping between DAI and stream is not necessarily the same for all 
platforms, we just had this discussion while reviewing the QCOM patches 
last week. whether you release the resources in .hw_free() or 
.shutdown() is also platform dependent.

Also this code will change when we support the multi-CPU dais, more work 
will be handled at the dailink level than at the dai.
We can (and will) refactor at a later point.
