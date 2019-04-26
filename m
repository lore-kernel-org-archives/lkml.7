Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FD2C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D576A206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbfDZA6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:58:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57104 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfDZA6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 20:58:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69AA680D;
        Thu, 25 Apr 2019 17:58:34 -0700 (PDT)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD0313F246;
        Thu, 25 Apr 2019 17:58:33 -0700 (PDT)
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
 <065cc8ae-f2c0-e493-b0a6-5c7340db37f5@arm.com>
 <20190416135055.GA3313@fuggles.cambridge.arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <1345818a-3a4a-e919-2168-e2950cee07b6@arm.com>
Date:   Thu, 25 Apr 2019 19:58:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190416135055.GA3313@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/16/19 8:50 AM, Will Deacon wrote:
> On Thu, Apr 04, 2019 at 12:24:38PM -0500, Jeremy Linton wrote:
>> On 4/4/19 12:04 PM, Will Deacon wrote:
>>> On Tue, Mar 26, 2019 at 05:39:38PM -0500, Jeremy Linton wrote:
>>>> Lets add the MODULE_TABLE and platform id_table entries so that
>>>> the SPE driver can attach to the ACPI platform device created by
>>>> the core pmu code.
>>>>
>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>>>> ---
>>>>    drivers/perf/arm_spe_pmu.c | 11 +++++++++--
>>>>    1 file changed, 9 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
>>>> index 7cb766dafe85..ffa2c76c08bb 100644
>>>> --- a/drivers/perf/arm_spe_pmu.c
>>>> +++ b/drivers/perf/arm_spe_pmu.c
>>>> @@ -1176,7 +1176,13 @@ static const struct of_device_id arm_spe_pmu_of_match[] = {
>>>>    };
>>>>    MODULE_DEVICE_TABLE(of, arm_spe_pmu_of_match);
>>>> -static int arm_spe_pmu_device_dt_probe(struct platform_device *pdev)
>>>> +static const struct platform_device_id arm_spe_match[] = {
>>>> +	{ "arm,spe-v1", 0},
>>>
>>> It would be nice if we could avoid duplicating this string from the ACPI
>>> parsing code.
>>
>> Ok sure, I just need to find a good common place for it.

There doesn't appear to be a good common place for this, so maybe 
arm_pmu.h, which can then be included in the spe driver is the right thing.


>>
>>>
>>>> +	{ }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(platform, arm_spe_match);
>>>> +
>>>> +static int arm_spe_pmu_device_probe(struct platform_device *pdev)
>>>>    {
>>>>    	int ret;
>>>>    	struct arm_spe_pmu *spe_pmu;
>>>> @@ -1236,11 +1242,12 @@ static int arm_spe_pmu_device_remove(struct platform_device *pdev)
>>>>    }
>>>>    static struct platform_driver arm_spe_pmu_driver = {
>>>> +	.id_table = arm_spe_match,
>>>>    	.driver	= {
>>>>    		.name		= DRVNAME,
>>>>    		.of_match_table	= of_match_ptr(arm_spe_pmu_of_match),
>>>
>>> Hmm, so some other drivers don't hook .id_table like you do, but instead
>>> hook .acpi_match_table in the driver structure. Is that not better?
>>
>> This isn't actually an ACPI device, (aka not defined in the namespace), so
>> its missing much of the ACPI functionality. I think that also means its
>> needs to be declared this way.
> 
> Looking at platform_match(), I'd really like to avoid having both an
> .id_table and an .of_match_table field.


> 
> acpi_of_match_device() will actually use the .of_match_table, but it relies
> on ACPI_COMPANION returning a valid acpi_device. If we don't have one of

Right, via the fwnode it can cause an acpi DSDT defined device with a 
_DSD "compatible" property to match an entry in the of_match_table 
compatible string. I don't think this is us...

> those, perhaps we can use the .id_table exclusively and drop the
> .of_match_table instead?

This definitely made me do my homework, the following is AFAIK:

Its possible to match on just a .id_table, but this requires matching 
the OF device name against the id_table name rather than against the OF 
compatible string (*). This doesn't seem like a good idea, despite 
platform_device_id entries being significantly smaller than the 
of_device_id ones. Plus, I think we end up with two duplicate tables 
because we still need the MODULE_TABLE(of,xxx) to assure that userspace 
can associate the modalias with the module.

OTOH, it seems possible to match on module name directly 
('arm_spe_pmu'), but this limits us to only a single device type for all 
ACPI device variations unless we put platform checks in the module 
itself (ick!). I suspect in the future if a spe.v2 were to come out this 
would be a problem unless a separate module were created. Then there is 
the fact this still needs a platform_device_id table, as the modalias 
will read "platform:arm_spe_pmu". Which will cause people to question 
why its not just assigned and matched against the .id_table.


*(interestingly trivia: There doesn't appear to be a single arm64 module 
which matches on a MODULE_TABLE OF name. They only match type or 
compatible. Out of the 3534 modules on my machine only three do any OF 
table type matching, ipmi_si and two drivers for freescale networking 
fsl_pq_mdio and gianfar_driver. In those cases, i'm not even sure its 
actually necessary.)

