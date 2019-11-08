Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2324EFC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0201A21D82
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfKHPr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:47:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:28413 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfKHPrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:47:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 07:47:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,281,1569308400"; 
   d="scan'208";a="377794934"
Received: from nupoorko-mobl1.amr.corp.intel.com (HELO [10.251.157.201]) ([10.251.157.201])
  by orsmga005.jf.intel.com with ESMTP; 08 Nov 2019 07:47:42 -0800
Subject: Re: [alsa-devel] [PATCH 13/14] soundwire: intel: free all resources
 on hw_free()
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de,
        gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
 <20191023212823.608-14-pierre-louis.bossart@linux.intel.com>
 <42403ea0-e337-81b6-f11a-2a32c1473750@intel.com>
 <0374d162-2cea-2fca-ec12-a0377130c711@linux.intel.com>
 <20191108041435.GV952516@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6daf0d90-a5f9-d510-f458-879528500134@linux.intel.com>
Date:   Fri, 8 Nov 2019 08:39:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191108041435.GV952516@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/19 10:14 PM, Vinod Koul wrote:
> On 04-11-19, 15:46, Pierre-Louis Bossart wrote:
>> On 11/4/19 2:08 PM, Cezary Rojewski wrote:
>>> On 2019-10-23 23:28, Pierre-Louis Bossart wrote:
>>>> @@ -816,6 +835,7 @@ static int
>>>>    intel_hw_free(struct snd_pcm_substream *substream, struct
>>>> snd_soc_dai *dai)
>>>>    {
>>>>        struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
>>>> +    struct sdw_intel *sdw = cdns_to_intel(cdns);
>>>>        struct sdw_cdns_dma_data *dma;
>>>>        int ret;
>>>> @@ -823,12 +843,28 @@ intel_hw_free(struct snd_pcm_substream
>>>> *substream, struct snd_soc_dai *dai)
>>>>        if (!dma)
>>>>            return -EIO;
>>>> +    ret = sdw_deprepare_stream(dma->stream);
>>>> +    if (ret) {
>>>> +        dev_err(dai->dev, "sdw_deprepare_stream: failed %d", ret);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>
>>> I understand that you want to be transparent to caller with failure
>>> reasons via dev_err/_warn. However, sdw_deprepare_stream already dumps
>>> all the logs we need. The same applies for most of the other calls (and
>>> not just in this patch..).
> 
> I think this is a valid concern! In linux we do not do that, for example
> we ask people to not log errors on kmalloc as it will be logged on
> failures so drivers do not need to do that.
> 
>>> Do we really need to be that verbose? Maybe just agree on caller -or-
>>> subject being the source for the messaging, align existing usages and
>>> thus preventing further duplication?
>>>
>>> Not forcing anything, just asking for your opinion on this.
>>
>> the sdw_prepare/deprepare_stream calls provide error logs, but they are not
>> mapped to specific devices/dais (pr_err vs. dev_dbg). I found it was easier
>> to check for which dai the error was reported.
> 
> Well in that case we should fix pr_err, there are only 17 instances of
> these in core, and few of them are justified in core (no dev pointer)
> and 11 in stream (few of them valid (no stream pointer) but rest can be
> converted to use dev_err! Even then they print stream name, so checking
> error is not justified argument!

the stream has no notion of device, it can be made of multiple devices, 
so which one would you choose?

> 
>> We are also in the middle of integration with new hardware/boards, and
>> erring on the side of more traces will help everyone involved. We can
>> revisit later which ones are strictly necessary.
> 
> Naah you are having duplicate logs, it does *not* help in debug seems
> 1000 line logs and few lines conveying duplicate info, I would rather
> have each line unique so that I dont have to skip duplicate ones while
> debugging!

They are not all duplicates.

Again, if I remove the logs in stream.c, then I do lose valuable 
information on bad state machines transitions, etc. An error code is not 
enough to reconstruct the issues from intel.c

If I remove the logs in intel.c, I can't know which dai had an error and 
what caused it.

seriously, these are all details, you have over 50 patches to review 
with a complete rework of this subsystem and we argue about dev_err 
verbosity?
