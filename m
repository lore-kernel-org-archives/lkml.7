Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC3AC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76D82075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfECRNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 13:13:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37594 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbfECRNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 13:13:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93F5215A2;
        Fri,  3 May 2019 10:13:39 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53B5F3F557;
        Fri,  3 May 2019 10:13:38 -0700 (PDT)
Subject: Re: [PATCH v2 08/36] coresight: tmc: Clean up device specific data
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-9-git-send-email-suzuki.poulose@arm.com>
 <20190417212325.GC14163@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <61ccfc44-c062-fa3e-6de9-825def4e9891@arm.com>
Date:   Fri, 3 May 2019 18:13:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417212325.GC14163@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu

On 17/04/2019 22:23, Mathieu Poirier wrote:
> On Mon, Apr 15, 2019 at 05:03:51PM +0100, Suzuki K Poulose wrote:
>> In preparation to use a consistent device naming scheme,
>> clean up the device link tracking in replicator driver.
>> Use the "coresight" device instead of the "real" parent device
>> for all internal purposes. All other requests (e.g, power management,
>> DMA operations) must use the "real" device which is the parent device.
>>
>> Since the CATU driver also uses the TMC-SG infrastructure, update
>> the callers to ensure they pass the appropriate device argument
>> for the tables.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index f684283..0911f9c 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -153,10 +153,11 @@ static void tmc_pages_free(struct tmc_pages *tmc_pages,
>>   			   struct device *dev, enum dma_data_direction dir)
>>   {
>>   	int i;
>> +	struct device *real_dev = dev->parent;
> 
> I would have kept the 'dev' as it is quite obvious from the dev->parent that we
> are getting a reference on the parent.  That is just my opinion and it is
> entirely up to you.

"dev" is already an argument to the function. Hence the "real_dev" choice.

>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
>> index 487c537..3eeadcf 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>> @@ -175,7 +175,6 @@ struct etr_buf {
>>    */
>>   struct tmc_drvdata {
>>   	void __iomem		*base;
>> -	struct device		*dev;
> 
> Please clean up the structure documentation.
> 
> With that and regardless of what you decide to do about the 'real_dev':

Done.

> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Cheers
Suzuki
