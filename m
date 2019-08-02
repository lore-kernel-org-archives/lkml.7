Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C656C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D70E2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732972AbfHBP33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:29:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:33602 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732701AbfHBP33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:29:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 08:29:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,338,1559545200"; 
   d="scan'208";a="175612955"
Received: from vivekcha-mobl1.amr.corp.intel.com (HELO [10.251.131.115]) ([10.251.131.115])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2019 08:29:27 -0700
Subject: Re: [RFC PATCH 15/40] soundwire: cadence_master: handle multiple
 status reports per Slave
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-16-pierre-louis.bossart@linux.intel.com>
 <20190802122003.GQ12733@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c4d31804-48af-30e3-4b4f-4b03dac6addd@linux.intel.com>
Date:   Fri, 2 Aug 2019 10:29:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802122003.GQ12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/19 7:20 AM, Vinod Koul wrote:
> On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
>> When a Slave reports multiple status in the sticky bits, find the
>> latest configuration from the mirror of the PING frame status and
>> update the status directly.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/cadence_master.c | 34 ++++++++++++++++++++++++------
>>   1 file changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
>> index 889fa2cd49ae..25d5c7267c15 100644
>> --- a/drivers/soundwire/cadence_master.c
>> +++ b/drivers/soundwire/cadence_master.c
>> @@ -643,13 +643,35 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
>>   
>>   		/* first check if Slave reported multiple status */
>>   		if (set_status > 1) {
>> +			u32 val;
>> +
>>   			dev_warn_ratelimited(cdns->dev,
>> -					     "Slave reported multiple Status: %d\n",
>> -					     mask);
>> -			/*
>> -			 * TODO: we need to reread the status here by
>> -			 * issuing a PING cmd
>> -			 */
>> +					     "Slave %d reported multiple Status: %d\n",
>> +					     i, mask);
>> +
>> +			/* re-check latest status extracted from PING commands */
>> +			val = cdns_readl(cdns, CDNS_MCP_SLAVE_STAT);
>> +			val >>= (i * 2);
>> +
>> +			switch (val & 0x3) {
>> +			case 0:
> 
> why not case CDNS_MCP_SLAVE_INTSTAT_NPRESENT:

ok

> 
>> +				status[i] = SDW_SLAVE_UNATTACHED;
>> +				break;
>> +			case 1:
>> +				status[i] = SDW_SLAVE_ATTACHED;
>> +				break;
>> +			case 2:
>> +				status[i] = SDW_SLAVE_ALERT;
>> +				break;
>> +			default:
>> +				status[i] = SDW_SLAVE_RESERVED;
>> +				break;
>> +			}
> 
> we have same logic in the code block preceding this, maybe good idea to
> write a helper and use for both

Yes, I am thinking about this. There are multiple cases where we want to 
re-check the status and clear some bits, so helpers would be good.

> 
> Also IIRC we can have multiple status set right?

Yes, the status bits are sticky and mirror all values reported in PING 
frames. I am still working on how to clear those bits, there are cases 
where we clear bits and end-up never hearing from that device ever 
again. classic edge/level issue I suppose.
