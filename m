Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21E3206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfC1K5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:57:45 -0400
Received: from foss.arm.com ([217.140.101.70]:42600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfC1K5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:57:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6885115AB;
        Thu, 28 Mar 2019 03:57:44 -0700 (PDT)
Received: from [10.37.12.55] (unknown [10.37.12.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 846153F59C;
        Thu, 28 Mar 2019 03:57:42 -0700 (PDT)
Subject: Re: [PATCH 18/25] coresight: Introduce generic platform data helper
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-19-git-send-email-suzuki.poulose@arm.com>
 <20190327225721.GC778@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <5268e8bd-2c6d-72bd-7628-e7d5ff90b2da@arm.com>
Date:   Thu, 28 Mar 2019 10:59:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190327225721.GC778@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2019 10:57 PM, Mathieu Poirier wrote:
> On Wed, Mar 20, 2019 at 06:49:35PM +0000, Suzuki K Poulose wrote:
>> So far we have hard coded the DT platform parsing code in
>> every driver. Introduce generic helper to parse the information
>> provided by the firmware in a platform agnostic manner, in preparation
>> for the ACPI support.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>


>>   
>> +static int coresight_alloc_conns(struct device *dev,
>> +				 struct coresight_platform_data *pdata)
>> +{
>> +	if (pdata->nr_outport) {
>> +		pdata->conns = devm_kzalloc(dev, pdata->nr_outport *
>> +					    sizeof(*pdata->conns),
>> +					    GFP_KERNEL);
>> +		if (!pdata->conns)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	return 0;
>> +}
>> +

>> -	ret = of_coresight_alloc_memory(dev, pdata);
>> +	ret = coresight_alloc_conns(dev, pdata);
> 
> I'm pretty sure you're doing this because you want to use
> coresight_alloc_conns() for ACPI as well, and I'm fine with that.  But it is
> quite orthogonal to the rest of the work done in this patch and as such I think
> it needs a patch of its own.
> 

Sure, will split this into a separate patch.

Suzuki
