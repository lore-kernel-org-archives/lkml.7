Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F855C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D5921670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfIDRnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:43:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:35516 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfIDRnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:43:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 10:43:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="194813269"
Received: from enagase-mobl1.amr.corp.intel.com (HELO [10.251.133.230]) ([10.251.133.230])
  by orsmga002.jf.intel.com with ESMTP; 04 Sep 2019 10:43:49 -0700
Subject: Re: [alsa-devel] [PATCH 2/6] soundwire: cadence_master: add hw_reset
 capability in debugfs
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
 <20190813213227.5163-3-pierre-louis.bossart@linux.intel.com>
 <20190904071317.GJ2672@vkoul-mobl>
 <71411347-93cf-2617-4edd-f6b401fe7a9b@linux.intel.com>
 <20190904164926.GA2672@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <63fc57dd-3df4-191c-2676-732f3748c55b@linux.intel.com>
Date:   Wed, 4 Sep 2019 12:43:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904164926.GA2672@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/19 11:49 AM, Vinod Koul wrote:
> On 04-09-19, 08:18, Pierre-Louis Bossart wrote:
>> On 9/4/19 2:13 AM, Vinod Koul wrote:
>>> On 13-08-19, 16:32, Pierre-Louis Bossart wrote:
>>>> Provide debugfs capability to kick link and devices into hard-reset
>>>> (as defined by MIPI). This capability is really useful when some
>>>> devices are no longer responsive and/or to check the software handling
>>>> of resynchronization.
>>>>
>>>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>>> ---
>>>>    drivers/soundwire/cadence_master.c | 20 ++++++++++++++++++++
>>>>    1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
>>>> index 046622e4b264..bd58d80ff636 100644
>>>> --- a/drivers/soundwire/cadence_master.c
>>>> +++ b/drivers/soundwire/cadence_master.c
>>>> @@ -340,6 +340,23 @@ static int cdns_reg_show(struct seq_file *s, void *data)
>>>>    }
>>>>    DEFINE_SHOW_ATTRIBUTE(cdns_reg);
>>>> +static int cdns_hw_reset(void *data, u64 value)
>>>> +{
>>>> +	struct sdw_cdns *cdns = data;
>>>> +	int ret;
>>>> +
>>>> +	if (value != 1)
>>>> +		return 0;
>>>
>>> Should this not be EINVAL to indicate invalid value passed?
>>
>> Maybe. I must admit I don't know what -EINVAL would do, this is used for
>> debugfs so it's not clear to me if the user will see a difference?
> 
> Well user should see "write error: Invalid argument" when he writes
> anything other than valid values :)

ok then, will do.
