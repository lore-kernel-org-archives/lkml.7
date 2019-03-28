Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FE7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C6C20700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfC1LHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:07:02 -0400
Received: from foss.arm.com ([217.140.101.70]:42750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfC1LHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:07:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76E3715AB;
        Thu, 28 Mar 2019 04:06:59 -0700 (PDT)
Received: from [10.37.12.55] (unknown [10.37.12.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63F5C3F59C;
        Thu, 28 Mar 2019 04:06:57 -0700 (PDT)
Subject: Re: [PATCH 13/25] coresight: etb10: Clean up device specific data
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-14-git-send-email-suzuki.poulose@arm.com>
 <20190327213903.GA778@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <67c7b74e-62d9-1f73-0622-b861af44c6b4@arm.com>
Date:   Thu, 28 Mar 2019 11:09:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190327213903.GA778@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2019 09:39 PM, Mathieu Poirier wrote:
> On Wed, Mar 20, 2019 at 06:49:30PM +0000, Suzuki K Poulose wrote:
>> Track the coresight device instead of the real device.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

>>   
>> @@ -701,7 +701,6 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>>   	if (!drvdata)
>>   		return -ENOMEM;
>>   
>> -	drvdata->dev = &adev->dev;
>>   	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
>>   	if (!IS_ERR(drvdata->atclk)) {
>>   		ret = clk_prepare_enable(drvdata->atclk);
>> @@ -740,6 +739,7 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>>   	if (IS_ERR(drvdata->csdev))
>>   		return PTR_ERR(drvdata->csdev);
>>   
>> +	drvdata->dev = &drvdata->csdev->dev;
> 
> For patch 11, 12, 13 - same comment as earlier.  Let's use drvdata::csdev
> and get rid of drvdata::dev.
> 

Sure, will do.

Thanks for the detailed review !

Suzuki
