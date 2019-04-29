Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135E4C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDBE20645
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfD2IyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:54:22 -0400
Received: from foss.arm.com ([217.140.101.70]:50684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbfD2IyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:54:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5561B80D;
        Mon, 29 Apr 2019 01:54:21 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 734CF3F71A;
        Mon, 29 Apr 2019 01:54:19 -0700 (PDT)
Subject: Re: [PATCH v2 33/36] coresight: acpi: Support for components
To:     rjw@rjwysocki.net
Cc:     mathieu.poirier@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-34-git-send-email-suzuki.poulose@arm.com>
 <20190425174553.GB4080@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <876c6e2c-0a6a-1814-c9ad-1e81d16b0cb0@arm.com>
Date:   Mon, 29 Apr 2019 09:54:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425174553.GB4080@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael,

On 25/04/2019 18:45, Mathieu Poirier wrote:
> On Mon, Apr 15, 2019 at 05:04:16PM +0100, Suzuki K Poulose wrote:
>> All AMBA devices are handled via ACPI AMBA scan notifier
>> infrastructure. The platform devices get the ACPI id
>> added to their driver.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/acpi/acpi_amba.c                           | 9 +++++++++
>>   drivers/hwtracing/coresight/coresight-replicator.c | 9 ++++++++-
>>   2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
>> index 7f77c07..eef5a69 100644
>> --- a/drivers/acpi/acpi_amba.c
>> +++ b/drivers/acpi/acpi_amba.c
>> @@ -24,6 +24,15 @@
>>   
>>   static const struct acpi_device_id amba_id_list[] = {
>>   	{"ARMH0061", 0}, /* PL061 GPIO Device */
>> +	{"ARMHC500", 0}, /* ARM CoreSight ETM4x */
>> +	{"ARMHC501", 0}, /* ARM CoreSight ETR */
>> +	{"ARMHC502", 0}, /* ARM CoreSight STM */
>> +	{"ARMHC503", 0}, /* ARM CoreSight Debug */
>> +	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
>> +	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
>> +	{"ARMHC98D", 0}, /* ARM CoreSight Dynamic Replicator */
>> +	{"ARMHC9CA", 0}, /* ARM CoreSight CATU */
>> +	{"ARMHC9FF", 0}, /* ARM CoreSight Funnel */
>>   	{"", 0},
>>   };
>>   
>> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
>> index 2eb489c..a8f42df 100644
>> --- a/drivers/hwtracing/coresight/coresight-replicator.c
>> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
>> @@ -5,6 +5,7 @@
>>    * Description: CoreSight Replicator driver
>>    */
>>   
>> +#include <linux/acpi.h>
>>   #include <linux/amba/bus.h>
>>   #include <linux/kernel.h>
>>   #include <linux/device.h>
>> @@ -290,11 +291,17 @@ static const struct of_device_id static_replicator_match[] = {
>>   	{}
>>   };
>>   
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id static_replicator_acpi_ids[] = {
>> +	{"ARMHC985", 0}, /* ARM CoreSight Static Replicator */
>> +};
>> +#endif
>>   static struct platform_driver static_replicator_driver = {
>>   	.probe          = static_replicator_probe,
>>   	.driver         = {
>>   		.name   = "coresight-replicator",
>> -		.of_match_table = static_replicator_match,
>> +		.of_match_table = of_match_ptr(static_replicator_match),
>> +		.acpi_match_table = ACPI_PTR(static_replicator_acpi_ids),
>>   		.pm	= &replicator_dev_pm_ops,
>>   		.suppress_bind_attrs = true,
>>   	},
> 
> For the coresight part: Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> You probably want to split this patch in half so that Rafael can pick up the
> the first part of it in his tree.
> 


We have the CoreSight components span over AMBA and platform devices. This
series is almost getting ready, so for the next revision I would like to
get your view on how to split this particular patch.

We have components in AMBA and Platform devices. Would you prefer to split
the patch and pull the ACPI_AMBA changes above in to your tree ? Or are
you happy with Mathieu pushing this change together with the other ACPI
bindings support in the CoreSight drivers ?

FWIW, we should still be fine if we split and the patches reach at different
times. Please let me know your thoughts.

Suzuki
