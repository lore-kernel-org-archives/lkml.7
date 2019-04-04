Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825E9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE962075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfDDRYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:24:46 -0400
Received: from foss.arm.com ([217.140.101.70]:36444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728663AbfDDRYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:24:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4292169E;
        Thu,  4 Apr 2019 10:24:45 -0700 (PDT)
Received: from [192.168.100.242] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4B923F557;
        Thu,  4 Apr 2019 10:24:41 -0700 (PDT)
Subject: Re: [PATCH 4/4] perf: arm_spe: Enable ACPI/Platform automatic module
 loading
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        rjw@rjwysocki.net, lenb@kernel.org, mark.rutland@arm.com,
        sudeep.holla@arm.com, james.morse@arm.com,
        lorenzo.pieralisi@arm.com, linuxarm@huawei.com
References: <20190326223938.5365-1-jeremy.linton@arm.com>
 <20190326223938.5365-5-jeremy.linton@arm.com>
 <20190404170423.GC28932@fuggles.cambridge.arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <065cc8ae-f2c0-e493-b0a6-5c7340db37f5@arm.com>
Date:   Thu, 4 Apr 2019 12:24:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190404170423.GC28932@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/4/19 12:04 PM, Will Deacon wrote:
> On Tue, Mar 26, 2019 at 05:39:38PM -0500, Jeremy Linton wrote:
>> Lets add the MODULE_TABLE and platform id_table entries so that
>> the SPE driver can attach to the ACPI platform device created by
>> the core pmu code.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   drivers/perf/arm_spe_pmu.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
>> index 7cb766dafe85..ffa2c76c08bb 100644
>> --- a/drivers/perf/arm_spe_pmu.c
>> +++ b/drivers/perf/arm_spe_pmu.c
>> @@ -1176,7 +1176,13 @@ static const struct of_device_id arm_spe_pmu_of_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, arm_spe_pmu_of_match);
>>   
>> -static int arm_spe_pmu_device_dt_probe(struct platform_device *pdev)
>> +static const struct platform_device_id arm_spe_match[] = {
>> +	{ "arm,spe-v1", 0},
> 
> It would be nice if we could avoid duplicating this string from the ACPI
> parsing code.

Ok sure, I just need to find a good common place for it.

> 
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(platform, arm_spe_match);
>> +
>> +static int arm_spe_pmu_device_probe(struct platform_device *pdev)
>>   {
>>   	int ret;
>>   	struct arm_spe_pmu *spe_pmu;
>> @@ -1236,11 +1242,12 @@ static int arm_spe_pmu_device_remove(struct platform_device *pdev)
>>   }
>>   
>>   static struct platform_driver arm_spe_pmu_driver = {
>> +	.id_table = arm_spe_match,
>>   	.driver	= {
>>   		.name		= DRVNAME,
>>   		.of_match_table	= of_match_ptr(arm_spe_pmu_of_match),
> 
> Hmm, so some other drivers don't hook .id_table like you do, but instead
> hook .acpi_match_table in the driver structure. Is that not better?

This isn't actually an ACPI device, (aka not defined in the namespace), 
so its missing much of the ACPI functionality. I think that also means 
its needs to be declared this way.


> 
> Will
> 

