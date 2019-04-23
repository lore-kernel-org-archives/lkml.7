Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4E4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3151020811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfDWJbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:31:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52512 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfDWJbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:31:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D0BE374;
        Tue, 23 Apr 2019 02:31:16 -0700 (PDT)
Received: from [10.37.12.155] (unknown [10.37.12.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C071F3F557;
        Tue, 23 Apr 2019 02:31:14 -0700 (PDT)
Subject: Re: [PATCH v2 05/36] coresight: tmc: Cleanup power management
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-6-git-send-email-suzuki.poulose@arm.com>
 <CANLsYkykMjiW3JAUr7vm4x2GAN=pDO1neThe-XuWrnTfH5RJyw@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <204642c0-e83e-9a46-12f2-8b17e6ff8467@arm.com>
Date:   Tue, 23 Apr 2019 10:33:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CANLsYkykMjiW3JAUr7vm4x2GAN=pDO1neThe-XuWrnTfH5RJyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2019 09:03 PM, Mathieu Poirier wrote:
> On Mon, 15 Apr 2019 at 10:05, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> Drop the power only if we were successful in probing the device.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tmc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
>> index 647b6aa..c6a5462 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
>> @@ -432,8 +432,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>>                  drvdata->size = readl_relaxed(drvdata->base + TMC_RSZ) * 4;
>>          }
>>
>> -       pm_runtime_put(&adev->dev);
>> -
>>          desc.pdata = pdata;
>>          desc.dev = dev;
>>          desc.groups = coresight_tmc_groups;
>> @@ -476,6 +474,8 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>>          ret = misc_register(&drvdata->miscdev);
>>          if (ret)
>>                  coresight_unregister(drvdata->csdev);
>> +       else
>> +               pm_runtime_put(&adev->dev);
>>   out:
>>          return ret;
>>   }
> 
> I have applied patches 1 to 5.

Thanks Mathieu !
