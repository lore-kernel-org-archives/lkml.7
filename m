Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB5BC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D47921901
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387737AbfGZPF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:05:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:54533 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387661AbfGZPF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:05:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 08:05:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="322060204"
Received: from msmall-mobl.amr.corp.intel.com (HELO [10.251.154.62]) ([10.251.154.62])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 08:05:55 -0700
Subject: Re: [alsa-devel] [RFC PATCH 23/40] soundwire: stream: fix disable
 sequence
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-24-pierre-louis.bossart@linux.intel.com>
 <20190726145129.GI16003@ubuntu>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8ec39464-81f7-e29d-7a2c-b2903a7fbf60@linux.intel.com>
Date:   Fri, 26 Jul 2019 10:05:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726145129.GI16003@ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Unrelated to this specific patch, but I looked at _sdw_disable_stream()
> and I see this there (again, maybe my version is outdated already):
> 
> 	struct sdw_master_runtime *m_rt = NULL;
> 	struct sdw_bus *bus = NULL;
> 
> where both those initialisations are redundant. Moreover:

will look at this, thanks.

> 
> On Thu, Jul 25, 2019 at 06:40:15PM -0500, Pierre-Louis Bossart wrote:
>> When we disable the stream and then call hw_free, two bank switches
>> will be handled and as a result we re-enable the stream on hw_free.
>>
>> Make sure the stream is disabled on both banks.
>>
>> TODO: we need to completely revisit all this and make sure we have a
>> mirroring mechanism between current and alternate banks.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/stream.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
>> index 53f5e790fcd7..75b9ad1fb1a6 100644
>> --- a/drivers/soundwire/stream.c
>> +++ b/drivers/soundwire/stream.c
>> @@ -1637,7 +1637,24 @@ static int _sdw_disable_stream(struct sdw_stream_runtime *stream)
>>   		}
>>   	}
>>   
>> -	return do_bank_switch(stream);
>> +	ret = do_bank_switch(stream);
>> +	if (ret < 0) {
>> +		dev_err(bus->dev, "Bank switch failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* make sure alternate bank (previous current) is also disabled */
>> +	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
>> +		bus = m_rt->bus;
> 
> "bus" is only used below, so at least take that line under "if (ret < 0)"
> or even just do "dev_err(m_rt->bus->dev,...)" everywhere in this function
> and remove the variable altogether...

will look at this, thanks Guennadi

> 
> Thanks
> Guennadi
> 
>> +		/* Disable port(s) */
>> +		ret = sdw_enable_disable_ports(m_rt, false);
>> +		if (ret < 0) {
>> +			dev_err(bus->dev, "Disable port(s) failed: %d\n", ret);
>> +			return ret;
