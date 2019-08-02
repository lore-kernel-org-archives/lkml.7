Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A394C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7842087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbfHBQlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:41:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:52979 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729353AbfHBQlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:41:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 09:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,338,1559545200"; 
   d="scan'208";a="175637656"
Received: from vivekcha-mobl1.amr.corp.intel.com (HELO [10.251.131.115]) ([10.251.131.115])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2019 09:41:06 -0700
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
 <c4d31804-48af-30e3-4b4f-4b03dac6addd@linux.intel.com>
 <20190802160115.GS12733@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1326bf1d-8289-2838-e2bd-48dba78b4a6c@linux.intel.com>
Date:   Fri, 2 Aug 2019 11:41:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802160115.GS12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/19 11:01 AM, Vinod Koul wrote:
> On 02-08-19, 10:29, Pierre-Louis Bossart wrote:
>> On 8/2/19 7:20 AM, Vinod Koul wrote:
>>> On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> 
>>>> +				status[i] = SDW_SLAVE_UNATTACHED;
>>>> +				break;
>>>> +			case 1:
>>>> +				status[i] = SDW_SLAVE_ATTACHED;
>>>> +				break;
>>>> +			case 2:
>>>> +				status[i] = SDW_SLAVE_ALERT;
>>>> +				break;
>>>> +			default:
>>>> +				status[i] = SDW_SLAVE_RESERVED;
>>>> +				break;
>>>> +			}
>>>
>>> we have same logic in the code block preceding this, maybe good idea to
>>> write a helper and use for both
>>
>> Yes, I am thinking about this. There are multiple cases where we want to
>> re-check the status and clear some bits, so helpers would be good.
>>
>>>
>>> Also IIRC we can have multiple status set right?
>>
>> Yes, the status bits are sticky and mirror all values reported in PING
>> frames. I am still working on how to clear those bits, there are cases where
>> we clear bits and end-up never hearing from that device ever again. classic
>> edge/level issue I suppose.
> 
> Then the case logic above doesn't work, it should be like the code block
> preceding this..

what I was referring to already is a problem even in single status mode.

Let's say for example that a device shows up as Device0, then we try to 
enumerate it and program a non-zero device number. If that fails, we 
currently clear the Attached status for Device0, so will never have an 
interrupt ever again. The device is there, attached as Device0, but 
we've lost the single opportunity to make it usable. The link is in most 
cases going to be extremely reliable, but if we know of state machines 
that lead to a terminal state then we should proactively have a recovery 
mechanism to avoid complicated debug down the road for cases where the 
hardware has transient issues.

For the multiple status case, we will have to look at the details and 
figure out which of the flags get cleared and which ones don't.

One certainty is that we absolutely have to track IO errors in interrupt 
context. They are recoverable in regular context but not quite in 
interrupt context if we clear the status bits unconditionally.

Maybe a tangent here but to be transparent there are really multiple 
topics we are tracking at the moment:

1. error handling in interrupts. I found a leak where if a device goes 
in the weeds while we program its device number and resynchronizes then 
we allocate a new device number instead of reusing the initial one. The 
bit clearing is also to be checked as explained above.

2. module dependencies: there is a race condition leading to a kernel 
oops if the Slave probe is not complete before the .update_status is 
invoked.

3. jack detection. The jack detection routine is called as a result of 
an imp-def Slave interrupt. We never documented the assumption that if 
this jack detection takes time then it needs to be done offline, e.g. in 
a work queue. Or if we still want it to be done in a the interrupt 
thread then we need to re-enable interrupts earlier, otherwise one 
device can stop interrupt handling for a fairly long duration.

4. streaming stop on link errors. We've seen in tests that if you reset 
the link or a Slave device with debugfs while audio is playing then 
streaming continues. This condition could happen if a device loses sync, 
and the spec says the Slave needs to reset its channel enable bits. At 
the command level, we handle this situation and will recover, but there 
is no notification to the ALSA layers to try and recover on the PCM side 
of things (as if it were an underflow condition). We also try to disable 
a stream but get all kinds of errors since it's lost state.

All of those points are corner cases but they are important to solve for 
actual products.
