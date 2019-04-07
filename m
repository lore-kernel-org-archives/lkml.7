Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82CEC282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 04:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EFC214AE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 04:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UO74W5zh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BTqZ48Q3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfDGEbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 00:31:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56888 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfDGEbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 00:31:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9D0F560E5A; Sun,  7 Apr 2019 04:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554611503;
        bh=oNM9tJvVmOTCGt8t+HNwYOiEV7UThcneuW01axOfIs8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UO74W5zhttclC89EnOPnUaRgZdWj83tp8VMCbVY3H6zIFvHm3oHxatODmpbHgEE0U
         p3208R5BCjFc6fvX822U2o5ejj9hVtGlDoVBeGhPraoNw1Fv/GZ7Gzlk35TZSBqmaM
         HTOOHd61KtObd3qYynw9NNrmKeIffTn5nhjE4I9I=
Received: from [192.168.43.47] (unknown [27.59.118.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DB73601B4;
        Sun,  7 Apr 2019 04:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554611502;
        bh=oNM9tJvVmOTCGt8t+HNwYOiEV7UThcneuW01axOfIs8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BTqZ48Q3j1pCFqVEzNmcZjpao42K7aWMfJqPazPtlY7RWj4gMIiE2yOUM/KOMtG4a
         x5Va+iKgFEQzoEoS0UvgPggQKqzaDX6YnnYzX7MXO7hPwbIWtyVILB+3VECRwbbT5w
         smV6RYP2tuE/7CKqO+MT60ixuxpHxkPvaqJNMZEk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DB73601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH] stm class: Fix out of bound access from bitmap allocation
To:     David Laight <David.Laight@ACULAB.COM>,
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
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20190405122256.27840-1-saiprakash.ranjan@codeaurora.org>
 <fe3a301b03b84761a08d5b15962b8110@AcuMS.aculab.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <dd266f56-b4ea-dc6b-eab1-50e13c820166@codeaurora.org>
Date:   Sun, 7 Apr 2019 10:01:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <fe3a301b03b84761a08d5b15962b8110@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/2019 6:44 PM, David Laight wrote:
> From: Sai Prakash Ranjan
>>
>> diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
>> index 93ce3aa740a9..21a5838f6e67 100644
>> --- a/drivers/hwtracing/stm/core.c
>> +++ b/drivers/hwtracing/stm/core.c
>> @@ -168,7 +168,7 @@ static int stp_master_alloc(struct stm_device *stm, unsigned int idx)
>>   	struct stp_master *master;
>>   	size_t size;
>>
>> -	size = ALIGN(stm->data->sw_nchannels, 8) / 8;
>> +	size = ALIGN(stm->data->sw_nchannels, STM_MASTER_SZ) / STM_MASTER_SZ;
> 
> I'm not sure that using STP_MASTER_SZ improves readability at all.
> 

I thought it was better to have a macro than directly specifying
sizeof(unsigned long), anyways I can change it.

> Is there something that gives the size of a bitmap for 'n' items?
> 

Not sure if there is something.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
