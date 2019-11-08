Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320F5FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6C3215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfKHPrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:47:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:28413 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfKHPry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:47:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 07:47:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,281,1569308400"; 
   d="scan'208";a="377794945"
Received: from nupoorko-mobl1.amr.corp.intel.com (HELO [10.251.157.201]) ([10.251.157.201])
  by orsmga005.jf.intel.com with ESMTP; 08 Nov 2019 07:47:44 -0800
Subject: Re: [alsa-devel] [PATCH 07/14] soundwire: add initial definitions for
 sdw_master_device
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
 <20191023212823.608-8-pierre-louis.bossart@linux.intel.com>
 <20191103063051.GJ2695@vkoul-mobl.Dlink>
 <9a8fb9ec-1ccb-4931-1ec6-bfae043e8c88@linux.intel.com>
 <20191108040427.GT952516@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d20c13c2-ffed-1147-769f-a483d4d9847b@linux.intel.com>
Date:   Fri, 8 Nov 2019 08:41:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191108040427.GT952516@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/19 10:04 PM, Vinod Koul wrote:
> On 04-11-19, 08:42, Pierre-Louis Bossart wrote:
>>
>>
>> On 11/3/19 1:30 AM, Vinod Koul wrote:
>>> On 23-10-19, 16:28, Pierre-Louis Bossart wrote:
>>>> Since we want an explicit support for the SoundWire Master device, add
>>>> the definitions, following the Grey Bus example.
>>>>
>>>> Open: do we need to set a variable when dealing with the master uevent?
>>>
>>> I dont think we want that or we need that!
>>
>> In GreyBus there are events and variables set, not sure what they were used
>> for. The code works without setting an event, but we'd need to make a
>> conscious design decision, and I am not too sure what usersace would use the
>> informatio for.
>>
>>>
>>> And to prevent that rather than adding a variable, can you please
>>> modify the device_type and use separate ones for master_device and
>>> slave_device
>>
>> sorry, I don't get the comment. There is only already a different device
>> type
>>
>>
>> struct bus_type sdw_bus_type = {
>> 	.name = "soundwire",
>> 	.match = sdw_bus_match,
>> 	.uevent = sdw_uevent,
> 
> We can remove this
> 
>> };
>>
>> struct device_type sdw_slave_type = {
>> 	.name =		"sdw_slave",
>> 	.release =	sdw_slave_release,
> 
> Add here:
> 
>          uevent = sdw_uevent,
> 
>> };
>>
>> struct device_type sdw_md_type = {
>> 	.name =		"soundwire_master",
>> 	.release =	sdw_md_release,
>> };
> 
> And not have here!
> 
> Problem solved!

I will give it a try but I don't know what the 'problem' was.
The code works as is, and btw you are commenting on the wrong version of 
the series, v2 was sent yesterday.
