Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322E4C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C5F21850
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfGZOJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:09:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:50913 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGZOJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:09:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 07:09:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="322049406"
Received: from msmall-mobl.amr.corp.intel.com (HELO [10.251.154.62]) ([10.251.154.62])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 07:09:56 -0700
Subject: Re: [alsa-devel] [RFC PATCH 15/40] soundwire: cadence_master: handle
 multiple status reports per Slave
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-16-pierre-louis.bossart@linux.intel.com>
 <20190725223100.GC16003@ubuntu>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fe63b365-5251-fab0-ab7f-bb2290534e4b@linux.intel.com>
Date:   Fri, 26 Jul 2019 09:09:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725223100.GC16003@ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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
> 
> Superfluous parentheses.

Humm, I don't know my left from my right and I can't remember operator 
precedence, so i'd rather make it explicit...

> 
>> +
>> +			switch (val & 0x3) {
>> +			case 0:
>> +				status[i] = SDW_SLAVE_UNATTACHED;
>> +				break;
>> +			case 1:
>> +				status[i] = SDW_SLAVE_ATTACHED;
>> +				break;
>> +			case 2:
>> +				status[i] = SDW_SLAVE_ALERT;
>> +				break;
>> +			default:
> 
> There aren't many values left for the "default" case :-) But I'm not sure whether
> any of
> 
> +			case 3:
> 
> or
> 
> +			case 3:
> +			default:
> 
> would improve readability.
> 
> Thanks
> Guennadi
> 
>> +				status[i] = SDW_SLAVE_RESERVED;
>> +				break;

Yes, those defaults are annoying. Some tools complain so I tend to leave 
them.
