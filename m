Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32B4C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935D92183F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406026AbfHBRmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:42:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:23521 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405700AbfHBRmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:42:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 10:42:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,339,1559545200"; 
   d="scan'208";a="181076587"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2019 10:42:31 -0700
Received: from cwhanson-mobl.amr.corp.intel.com (unknown [10.252.133.191])
        by linux.intel.com (Postfix) with ESMTP id 852B958046F;
        Fri,  2 Aug 2019 10:42:30 -0700 (PDT)
Subject: Re: [alsa-devel] [RFC PATCH 31/40] soundwire: intel: move shutdown()
 callback and don't export symbol
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-32-pierre-louis.bossart@linux.intel.com>
 <39318aab-b1b4-2cce-c408-792a5cc343dd@intel.com>
 <ee87d4bb-3f35-eb27-0112-e6e64a09a279@linux.intel.com>
 <20190802172843.GC12733@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f189bd38-32ec-ee7d-e0fa-4de108a18ea2@linux.intel.com>
Date:   Fri, 2 Aug 2019 12:42:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802172843.GC12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/19 12:28 PM, Vinod Koul wrote:
> On 26-07-19, 09:46, Pierre-Louis Bossart wrote:
>>
>>
>> On 7/26/19 5:38 AM, Cezary Rojewski wrote:
>>> On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
>>>> +void intel_shutdown(struct snd_pcm_substream *substream,
>>>> +            struct snd_soc_dai *dai)
>>>> +{
>>>> +    struct sdw_cdns_dma_data *dma;
>>>> +
>>>> +    dma = snd_soc_dai_get_dma_data(dai, substream);
>>>> +    if (!dma)
>>>> +        return;
>>>> +
>>>> +    snd_soc_dai_set_dma_data(dai, substream, NULL);
>>>> +    kfree(dma);
>>>> +}
>>>
>>> Correct me if I'm wrong, but do we really need to _get_dma_ here?
>>> _set_dma_ seems bulletproof, same for kfree.
>>
>> I must admit I have no idea why we have a reference to DMAs here, this looks
>> like an abuse to store a dai-specific context, and the initial test looks
>> like copy-paste to detect invalid configs, as done in other callbacks. Vinod
>> and Sanyog might have more history than me here.
> 
> I dont see snd_soc_dai_set_dma_data() call for
> sdw_cdns_dma_data so somthing is missing (at least in upstream code)
> 
> IIRC we should have a snd_soc_dai_set_dma_data() in alloc or some
> initialization routine and we free it here.. Sanyog?

the code does a bunch of get_dma_data() and this seems to work, but 
indeed I don't see where the _set_dma_data() is done. magic.

