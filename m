Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2DCC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CFB2070D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfDHKYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:24:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45798 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfDHKYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:24:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B13515AD;
        Mon,  8 Apr 2019 03:24:02 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C9BB3F718;
        Mon,  8 Apr 2019 03:23:59 -0700 (PDT)
Subject: Re: [PATCH] stm class: Fix out of bound access from bitmap allocation
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mulu He <muluhe@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190405122256.27840-1-saiprakash.ranjan@codeaurora.org>
 <fe3a301b03b84761a08d5b15962b8110@AcuMS.aculab.com>
 <dd266f56-b4ea-dc6b-eab1-50e13c820166@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <850ba66b-0e4a-2027-5640-0ee339a7868c@arm.com>
Date:   Mon, 8 Apr 2019 11:23:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <dd266f56-b4ea-dc6b-eab1-50e13c820166@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2019 05:31, Sai Prakash Ranjan wrote:
> On 4/5/2019 6:44 PM, David Laight wrote:
>> From: Sai Prakash Ranjan
>>>
>>> diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
>>> index 93ce3aa740a9..21a5838f6e67 100644
>>> --- a/drivers/hwtracing/stm/core.c
>>> +++ b/drivers/hwtracing/stm/core.c
>>> @@ -168,7 +168,7 @@ static int stp_master_alloc(struct stm_device 
>>> *stm, unsigned int idx)
>>>       struct stp_master *master;
>>>       size_t size;
>>>
>>> -    size = ALIGN(stm->data->sw_nchannels, 8) / 8;
>>> +    size = ALIGN(stm->data->sw_nchannels, STM_MASTER_SZ) / 
>>> STM_MASTER_SZ;
>>
>> I'm not sure that using STP_MASTER_SZ improves readability at all.
>>
> 
> I thought it was better to have a macro than directly specifying
> sizeof(unsigned long), anyways I can change it.
> 
>> Is there something that gives the size of a bitmap for 'n' items?
>>
> 
> Not sure if there is something.

If you were to ask the question "how does the bitmap code itself know 
what the total size of a bitmap is?", that would quickly lead you 
towards BITS_TO_LONGS() ;)

And given that stp_master::chan_map is already an appropriate type, that 
suggests simplifying the entire calculation down to something neat and 
tidy like:

size = offsetof(struct stp_master, 
chan_map[BITS_TO_LONGS(stm->data->sw_nchannels)]);


Robin.
