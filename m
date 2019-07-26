Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB81AC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C911A2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfGZOzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:55:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:55215 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727172AbfGZOzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:55:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 07:55:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="322057986"
Received: from msmall-mobl.amr.corp.intel.com (HELO [10.251.154.62]) ([10.251.154.62])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 07:55:22 -0700
Subject: Re: [alsa-devel] [RFC PATCH 32/40] soundwire: intel: add helper for
 initialization
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-33-pierre-louis.bossart@linux.intel.com>
 <b0f7d11d-b9db-af98-3036-ef2a165f7427@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <41d9d18f-9df2-9c7e-6cbd-8e7abb916f71@linux.intel.com>
Date:   Fri, 26 Jul 2019 09:55:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b0f7d11d-b9db-af98-3036-ef2a165f7427@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/19 5:42 AM, Cezary Rojewski wrote:
> On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
>> Move code to helper for reuse in power management routines
>>
>> Signed-off-by: Pierre-Louis Bossart 
>> <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/intel.c | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index c40ab443e723..215dc81cdf73 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -984,6 +984,15 @@ static struct sdw_master_ops sdw_intel_ops = {
>>       .post_bank_switch = intel_post_bank_switch,
>>   };
>> +static int intel_init(struct sdw_intel *sdw)
>> +{
>> +    /* Initialize shim and controller */
>> +    intel_link_power_up(sdw);
>> +    intel_shim_init(sdw);
>> +
>> +    return sdw_cdns_init(&sdw->cdns);
>> +}
> 
> Why don't we check polling status for _link_power_up? I've already met 
> slow starting devices in the past. If polling fails and -EAGAIN is 
> returned, flow of initialization should react appropriately e.g. poll 
> till MAX_TIMEOUT of some sort -or- collapse.

The code does what it states, it initializes the Intel and Cadence IPs.

What you are referring to is a different problem: once the bus starts, 
then Slave devices will report as attached, and will be enumerated. This 
will take time. The devices I tested show up immediately and within a 
couple of ms the bus is operational. But MIPI allows to the sync to take 
up to 4096 frames, which is 85ms with a 48kHz frame rate, so yes we do 
need to look into this.

We currently do not have a notification that tells us the bus is back to 
normal, that's a design flaw - see the last patch of the series where I 
kicked the can down the road but adding an artificial delay.

So yes good point indeed but on the wrong patch :-)
