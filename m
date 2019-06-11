Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEEAC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F5D207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388272AbfFKMVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:21:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:47451 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbfFKMVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:21:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 05:21:21 -0700
X-ExtLoop1: 1
Received: from rrgarris-mobl1.amr.corp.intel.com (HELO [10.252.136.137]) ([10.252.136.137])
  by orsmga003.jf.intel.com with ESMTP; 11 Jun 2019 05:21:20 -0700
Subject: Re: [alsa-devel] [RFC PATCH 6/6] soundwire: qcom: add support for
 SoundWire controller
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, vkoul@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-7-srinivas.kandagatla@linaro.org>
 <249f9647-94d0-41d7-3b95-64c36d90f8e8@linux.intel.com>
 <40ea774c-8aa8-295d-e91e-71423b03c88d@linaro.org>
 <7269521a-ac89-3856-c18c-ffaaf64c0806@linux.intel.com>
 <462620fc-ac91-6a36-46c7-7af0080f06cb@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0e836692-2297-4cb7-d681-76692db78a56@linux.intel.com>
Date:   Tue, 11 Jun 2019 07:21:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <462620fc-ac91-6a36-46c7-7af0080f06cb@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/19 5:29 AM, Srinivas Kandagatla wrote:
> 
> 
> On 10/06/2019 15:12, Pierre-Louis Bossart wrote:
>>>>> +
>>>>> +    if (dev_addr == SDW_BROADCAST_DEV_NUM) {
>>>>> +        ctrl->fifo_status = 0;
>>>>> +        ret = wait_for_completion_timeout(&ctrl->sp_cmd_comp,
>>>>> +                          msecs_to_jiffies(TIMEOUT_MS));
>>>>
>>>> This is odd. The SoundWire spec does not handle writes to a single 
>>>> device or broadcast writes differently. I don't see a clear reason 
>>>> why you would only timeout for a broadcast write.
>>>>
>>>
>>> There is danger of blocking here without timeout.
>>
>> Right, and it's fine to add a timeout. The question is why add a 
>> timeout *only* for a broadcast operation? It should be added for every 
>> transaction IMO, unless you have a reason not to do so.
>>
> 
> I did try this before, the issue is when we read/write registers from 
> interrupt handler, these can be deadlocked as we will be interrupt 
> handler waiting for another completion interrupt, which will never 
> happen unless we return from the first interrupt.

I don't quite get the issue. With the Intel hardware we only deal with 
Master registers (some of which mirror the bus state) in the handler and 
will only modify Slave registers in the thread. All changes to Slave 
registers will be subject to a timeout as well as a check for no 
response or NAK. Not sure what is specific about your solution that 
requires a different handling of commands depending on which device 
number is used. It could very well be that you've uncovered a flaw in 
the bus design but I still don't see how it would be Qualcomm-specific?
