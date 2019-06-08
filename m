Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83837C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 20:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AF6208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 20:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfFHUEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 16:04:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:52446 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfFHUEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 16:04:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2019 13:04:37 -0700
X-ExtLoop1: 1
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.251.93.16]) ([10.251.93.16])
  by orsmga006.jf.intel.com with ESMTP; 08 Jun 2019 13:04:33 -0700
Subject: Re: [alsa-devel] [RFC PATCH 3/6] soundwire: core: define SDW_MAX_PORT
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, vkoul@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-4-srinivas.kandagatla@linaro.org>
 <a4b527af-c999-829d-c4a0-41f0a6775b65@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <641a22e7-6998-2a6a-bd90-ddf75d0cd9c8@intel.com>
Date:   Sat, 8 Jun 2019 22:04:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a4b527af-c999-829d-c4a0-41f0a6775b65@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019-06-07 14:31, Pierre-Louis Bossart wrote:
> On 6/7/19 3:56 AM, Srinivas Kandagatla wrote:
>> This patch adds SDW_MAX_PORT so that other driver can use it.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   include/linux/soundwire/sdw.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/soundwire/sdw.h 
>> b/include/linux/soundwire/sdw.h
>> index aac68e879fae..80ca997e4e5d 100644
>> --- a/include/linux/soundwire/sdw.h
>> +++ b/include/linux/soundwire/sdw.h
>> @@ -36,6 +36,7 @@ struct sdw_slave;
>>   #define SDW_FRAME_CTRL_BITS        48
>>   #define SDW_MAX_DEVICES            11
>> +#define SDW_MAX_PORTS    14
> 
> That's an ambiguous definition.
> You can have 16 ports per the SoundWire spec, but DP0 is reserved for 
> control and DP15 is an alias for all ports (same idea as device 15 for 
> broadcast operations but limited to a single device), which leaves 14 
> ports for audio usages.
> 
> In the MIPI specs, specifically the DisCo part, the difference is called 
> about with the the DP0 and DPn notations, so this could be SDW_MAX_DPn. 
> Alternatively you could use SDW_MAX_AUDIO_PORTS which is more 
> self-explanatory and does not require in-depth familiarity with the spec.
> 

This ambiguity spreads even further. Look at the name of #define below.
DP0 is by no means invalid. It's specific and has some optional 
registers, yes, but that's because of its engagement in BPT.

Given the fact SDW does not care about type of data being transported, 
even "AUDIO" seems misleading here. Though it's still better than no 
specifier at all.

>>   #define SDW_VALID_PORT_RANGE(n)        ((n) <= 14 && (n) >= 1)
>>   #define SDW_DAI_ID_RANGE_START        100
>>
> 
