Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EA2C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE3520C01
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfHETMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:12:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:53964 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728870AbfHETMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:12:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 12:12:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="373177998"
Received: from amerhebi-mobl1.amr.corp.intel.com (HELO [10.251.154.70]) ([10.251.154.70])
  by fmsmga005.fm.intel.com with ESMTP; 05 Aug 2019 12:12:07 -0700
Subject: Re: [alsa-devel] [RFC PATCH 23/40] soundwire: stream: fix disable
 sequence
To:     Sanyog Kale <sanyog.r.kale@intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-24-pierre-louis.bossart@linux.intel.com>
 <20190805095620.GD22437@buildpc-HP-Z230>
 <12799e97-d6e3-5027-a409-0fe37dba86fd@linux.intel.com>
 <20190805163233.GA24889@buildpc-HP-Z230>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <078f19d4-5a2f-91bf-43a3-7c92eacd8fc1@linux.intel.com>
Date:   Mon, 5 Aug 2019 14:12:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805163233.GA24889@buildpc-HP-Z230>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/19 11:32 AM, Sanyog Kale wrote:
> On Mon, Aug 05, 2019 at 10:33:25AM -0500, Pierre-Louis Bossart wrote:
>>
>>
>> On 8/5/19 4:56 AM, Sanyog Kale wrote:
>>> On Thu, Jul 25, 2019 at 06:40:15PM -0500, Pierre-Louis Bossart wrote:
>>>> When we disable the stream and then call hw_free, two bank switches
>>>> will be handled and as a result we re-enable the stream on hw_free.
>>>>
>>>
>>> I didnt quite get why there will be two bank switches as part of disable flow
>>> which leads to enabling of stream?
>>
>> You have two bank switches, one to stop streaming and on in de-prepare. It's
>> symmetrical with the start sequence, where we do a bank switch to prepare
>> and another to enable.
> 
> Got it. I misunderstood it that two bank switches are performed as part of
> disable_stream.
> 
>>
>> Let's assume we are using bank0 when streaming.
>>
>> Before the first bank switch, the channel_enable is set to false in the
>> alternate bank1. When the bank switch happens, bank1 become active and the
>> streaming stops. But bank0 registers have not been modified so when we do
>> the second bank switch in de-prepare we make bank0 active, and the ch_enable
>> bits are still set so streaming will restart... When we stop streaming, we
>> need to make sure the ch_enable bits are cleared in the two banks.
> 
> This is clear. Even though the channels remains enabled, i believe there
> won't be any data pushed on lines as stream will be closed.

Actually the link remains active. We tested this by setting the PRBS 
data mode and the Slave device detects when we artificially inject errors.

There is however no data consumption on the DMA side of the Master IP 
since the DMA is indeed stopped.

> 
> Regarding mirroring approach, I assume after bank switch we will take
> snapshot of active bank and program same in inactive bank.

That should be the approach yes.

> 
>>
>>
>>>
>>>> Make sure the stream is disabled on both banks.
>>>>
>>>> TODO: we need to completely revisit all this and make sure we have a
>>>> mirroring mechanism between current and alternate banks.
>>>>
>>>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>>> ---
>>>>    drivers/soundwire/stream.c | 19 ++++++++++++++++++-
>>>>    1 file changed, 18 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
>>>> index 53f5e790fcd7..75b9ad1fb1a6 100644
>>>> --- a/drivers/soundwire/stream.c
>>>> +++ b/drivers/soundwire/stream.c
>>>> @@ -1637,7 +1637,24 @@ static int _sdw_disable_stream(struct sdw_stream_runtime *stream)
>>>>    		}
>>>>    	}
>>>> -	return do_bank_switch(stream);
>>>> +	ret = do_bank_switch(stream);
>>>> +	if (ret < 0) {
>>>> +		dev_err(bus->dev, "Bank switch failed: %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	/* make sure alternate bank (previous current) is also disabled */
>>>> +	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
>>>> +		bus = m_rt->bus;
>>>> +		/* Disable port(s) */
>>>> +		ret = sdw_enable_disable_ports(m_rt, false);
>>>> +		if (ret < 0) {
>>>> +			dev_err(bus->dev, "Disable port(s) failed: %d\n", ret);
>>>> +			return ret;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return 0;
>>>>    }
>>>>    /**
>>>> -- 
>>>> 2.20.1
>>>>
>>>
> 
