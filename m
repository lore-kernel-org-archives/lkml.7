Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02C0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73098206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfDDL1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:27:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58568 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbfDDL1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:27:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22326EBD;
        Thu,  4 Apr 2019 04:27:16 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF6303F557;
        Thu,  4 Apr 2019 04:27:14 -0700 (PDT)
Subject: Re: [PATCH 23/25] coresight: stm: ACPI support for parsing stimulus
 base
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com, rjw@rjwysocki.net
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-24-git-send-email-suzuki.poulose@arm.com>
 <20190328204151.GA7163@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <09baa551-b351-6651-e609-75ed425ae7f4@arm.com>
Date:   Thu, 4 Apr 2019 12:27:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328204151.GA7163@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 28/03/2019 20:41, Mathieu Poirier wrote:
> On Wed, Mar 20, 2019 at 06:49:40PM +0000, Suzuki K Poulose wrote:
>> The stimulus base for STM device must be listed as the second memory
>> resource, followed by the programming base address. Add support for
>> parsing the information for ACPI.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---

>> +#ifdef CONFIG_ACPI
>> +static int acpi_stm_get_stimulus_area(struct device *dev, struct resource *res)
>> +{
>> +	int rc;
>> +	bool found_base = false;
>> +	struct resource_entry *rent;
>> +	LIST_HEAD(res_list);
>> +
>> +	struct acpi_device *adev = ACPI_COMPANION(dev);
>> +
>> +	if (!adev)
>> +		return -ENODEV;
>> +	rc = acpi_dev_get_resources(adev, &res_list, NULL, NULL);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	rc = -ENOENT;
>> +	list_for_each_entry(rent, &res_list, node) {
>> +		if (resource_type(rent->res) != IORESOURCE_MEM)
>> +			continue;
>> +		if (found_base) {
>> +			*res = *rent->res;
>> +			rc = 0;
>> +			break;
>> +		}
>> +
>> +		found_base = true;
> 
> Is the ACPI binding crystal clear on the fact that the second resource region
> has to be for stimulus ports?

Yes. Section 2.3 Resources in ACPI for CoreSightTM 1.0 (DEN0067) :

"Each CoresSight component needs to declare the resources it owns using the _CRS
method. This must include base address and span covering the MMIO interface of
the device. In addition those that can raise interrupts must describe the
interrupts they consume.

For STM two base addresses must be presented, these must be provided in order.
First the configuration base address, and then external stimuli memory region
base address"

>>   static int stm_get_stimulus_area(struct device *dev, struct resource *res)
>>   {
>>   	if (dev->of_node)
> 
> Wouldn't it be better to use is_of_node()?


> 
>>   		return of_stm_get_stimulus_area(dev, res);
>> +	else if (is_acpi_node(dev->fwnode)
> 
> is_acpi_device_node()?
> 

Yes, to both the above.

Cheers
Suzuki

