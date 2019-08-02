Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12821C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E012B2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391459AbfHBQw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:52:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:4984 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbfHBQw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:52:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 09:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,338,1559545200"; 
   d="scan'208";a="257031873"
Received: from mvicidom-mobl.amr.corp.intel.com (HELO [10.254.92.34]) ([10.254.92.34])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2019 09:52:27 -0700
Subject: Re: [alsa-devel] [RFC PATCH 06/40] soundwire: intel: prevent possible
 dereference in hw_params
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-7-pierre-louis.bossart@linux.intel.com>
 <20190802115537.GI12733@vkoul-mobl.Dlink>
 <6da5aeef-40bf-c9bb-fc18-4ac0b3961857@linux.intel.com>
 <20190802155738.GR12733@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <884a13fc-08eb-10c9-de9c-50cf38ff533d@linux.intel.com>
Date:   Fri, 2 Aug 2019 11:52:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802155738.GR12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/19 10:57 AM, Vinod Koul wrote:
> On 02-08-19, 10:16, Pierre-Louis Bossart wrote:
>>
>>
>> On 8/2/19 6:55 AM, Vinod Koul wrote:
>>> On 25-07-19, 18:39, Pierre-Louis Bossart wrote:
>>>> This should not happen in production systems but we should test for
>>>> all callback arguments before invoking the config_stream callback.
>>>
>>> so you are saying callback arg is mandatory, if so please document that
>>> assumption
>>
>> no, what this says is that if a config_stream is provided then it needs to
>> have a valid argument.
> 
> well typically args are not mandatory..
> 
>> I am not sure what you mean by "document that assumption", comment in the
>> code (where?) or SoundWire documentation?
> 
> The callback documentation which in this is in include/linux/soundwire/sdw_intel.h
> 

/**
  * struct sdw_intel_ops: Intel audio driver callback ops
  *
  * @config_stream: configure the stream with the hw_params
  */
struct sdw_intel_ops {
	int (*config_stream)(void *arg, void *substream,
			     void *dai, void *hw_params, int stream_num);
};

all parameters are mandatory really, not sure what you are trying to get at.
