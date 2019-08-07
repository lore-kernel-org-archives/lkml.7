Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF1FC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D41121E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbfHGOHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:07:42 -0400
Received: from foss.arm.com ([217.140.110.172]:49116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbfHGOHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:07:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 731E428;
        Wed,  7 Aug 2019 07:07:41 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D259A3F706;
        Wed,  7 Aug 2019 07:07:40 -0700 (PDT)
Subject: Re: [PATCH] firmware: arm_scmi: Use {get,put}_unaligned_le32
 accessors
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190807130038.26878-1-sudeep.holla@arm.com>
 <1565184971.5048.8.camel@pengutronix.de> <20190807135757.GA27278@e107155-lin>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4e6de98c-833b-a80b-acef-6e88391e80f2@arm.com>
Date:   Wed, 7 Aug 2019 15:07:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190807135757.GA27278@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2019 14:57, Sudeep Holla wrote:
> On Wed, Aug 07, 2019 at 03:36:11PM +0200, Philipp Zabel wrote:
>> Hi Sudeep,
>>
>> On Wed, 2019-08-07 at 14:00 +0100, Sudeep Holla wrote:
>>> Instead of type-casting the {tx,rx}.buf all over the place while
>>> accessing them to read/write __le32 from/to the firmware, let's use
>>> the nice existing {get,put}_unaligned_le32 accessors to hide all the
>>> type cast ugliness.
>>>
>>> Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>> ---
>>>   drivers/firmware/arm_scmi/base.c    |  2 +-
>>>   drivers/firmware/arm_scmi/clock.c   | 10 ++++------
>>>   drivers/firmware/arm_scmi/common.h  |  2 ++
>>>   drivers/firmware/arm_scmi/perf.c    |  8 ++++----
>>>   drivers/firmware/arm_scmi/power.c   |  6 +++---
>>>   drivers/firmware/arm_scmi/reset.c   |  2 +-
>>>   drivers/firmware/arm_scmi/sensors.c | 12 +++++-------
>>>   7 files changed, 20 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
>>> index 204390297f4b..f804e8af6521 100644
>>> --- a/drivers/firmware/arm_scmi/base.c
>>> +++ b/drivers/firmware/arm_scmi/base.c
>> [...]
>>> @@ -204,14 +204,12 @@ scmi_clock_rate_get(const struct scmi_handle *handle, u32 clk_id, u64 *value)
>>>   	if (ret)
>>>   		return ret;
>>>
>>> -	*(__le32 *)t->tx.buf = cpu_to_le32(clk_id);
>>> +	put_unaligned_le32(clk_id, t->tx.buf);
>>>
>>>   	ret = scmi_do_xfer(handle, t);
>>>   	if (!ret) {
>>> -		__le32 *pval = t->rx.buf;
>>> -
>>> -		*value = le32_to_cpu(*pval);
>>> -		*value |= (u64)le32_to_cpu(*(pval + 1)) << 32;
>>> +		*value = get_unaligned_le32(t->rx.buf);
>>> +		*value |= (u64)get_unaligned_le32(t->rx.buf + 1) << 32;
>>
>> Isn't t->rx.buf a void pointer? If I am not mistaken, you'd either have
>> to keep the pval local variables, or cast to (__le32 *) before doing
>> pointer arithmetic.
>>
> 
> Ah right, that's the reason I added it at the first place. I will fix that.

Couldn't you just use get_unaligned_le64() here anyway?

Robin.
