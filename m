Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D807FC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4BA2070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbfFFM43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 08:56:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46990 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfFFM42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:56:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE25B374;
        Thu,  6 Jun 2019 05:56:27 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DA6C3F5AF;
        Thu,  6 Jun 2019 05:56:26 -0700 (PDT)
Subject: Re: [PATCH v4 17/30] coresight: Make device to CPU mapping generic
To:     mike.leach@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
 <1558521304-27469-18-git-send-email-suzuki.poulose@arm.com>
 <CAJ9a7ViQq-bdAw7HOOkSxinC0jhRjpAr-oJVv5GLHfBRpFu6hw@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <cb81b7e6-f698-6f90-411f-419598284477@arm.com>
Date:   Thu, 6 Jun 2019 13:56:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJ9a7ViQq-bdAw7HOOkSxinC0jhRjpAr-oJVv5GLHfBRpFu6hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/06/2019 11:07, Mike Leach wrote:
> Hi,
> 
> On Wed, 22 May 2019 at 11:37, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> The CoreSight components ETM and CPU-Debug are always associated
>> with CPUs. Replace the of_coresight_get_cpu() with a platform
>> agnostic helper, in preparation to add ACPI support.
>>
>> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-cpu-debug.c |  3 +--
>>   drivers/hwtracing/coresight/coresight-platform.c  | 18 +++++++++++++-----
>>   include/linux/coresight.h                         |  7 +------
>>   3 files changed, 15 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> index e8819d7..07a1367 100644
>> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> @@ -572,14 +572,13 @@ static int debug_probe(struct amba_device *adev, const struct amba_id *id)
>>          struct device *dev = &adev->dev;
>>          struct debug_drvdata *drvdata;
>>          struct resource *res = &adev->res;
>> -       struct device_node *np = adev->dev.of_node;
>>          int ret;
>>
>>          drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>>          if (!drvdata)
>>                  return -ENOMEM;
>>
>> -       drvdata->cpu = np ? of_coresight_get_cpu(np) : 0;
>> +       drvdata->cpu = coresight_get_cpu(dev);
>>          if (per_cpu(debug_drvdata, drvdata->cpu)) {
>>                  dev_err(dev, "CPU%d drvdata has already been initialized\n",
>>                          drvdata->cpu);
>> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
>> index 5d78f4f..ba8c146 100644
>> --- a/drivers/hwtracing/coresight/coresight-platform.c
>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
>> @@ -151,12 +151,14 @@ static void of_coresight_get_ports(const struct device_node *node,
>>          }
>>   }
>>
>> -int of_coresight_get_cpu(const struct device_node *node)
>> +static int of_coresight_get_cpu(struct device *dev)
>>   {
>>          int cpu;
>>          struct device_node *dn;
>>
>> -       dn = of_parse_phandle(node, "cpu", 0);
>> +       if (!dev->of_node)
>> +               return 0;
>> +       dn = of_parse_phandle(dev->of_node, "cpu", 0);
>>          /* Affinity defaults to CPU0 */
>>          if (!dn)
>>                  return 0;
>> @@ -166,7 +168,6 @@ int of_coresight_get_cpu(const struct device_node *node)
>>          /* Affinity to CPU0 if no cpu nodes are found */
>>          return (cpu < 0) ? 0 : cpu;
>>   }
>> -EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
>>
>>   /*
>>    * of_coresight_parse_endpoint : Parse the given output endpoint @ep
>> @@ -240,8 +241,6 @@ static int of_get_coresight_platform_data(struct device *dev,
>>          bool legacy_binding = false;
>>          struct device_node *node = dev->of_node;
>>
>> -       pdata->cpu = of_coresight_get_cpu(node);
>> -
>>          /* Get the number of input and output port for this component */
>>          of_coresight_get_ports(node, &pdata->nr_inport, &pdata->nr_outport);
>>
>> @@ -300,6 +299,14 @@ of_get_coresight_platform_data(struct device *dev,
>>   }
>>   #endif
>>
>> +int coresight_get_cpu(struct device *dev)
>> +{
>> +       if (is_of_node(dev->fwnode))
>> +               return of_coresight_get_cpu(dev);
> 
> No of_coresight_get_cpu() will be defined if CONFIG_OF _not_ defined.
> This will hit an implicit declaration compile error in this case.

Thanks for catching it and you're right. I will fix this.

Cheers
Suzuki
