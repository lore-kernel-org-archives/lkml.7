Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E9EC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F203208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iKYkHq1g";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B8cGsKjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfFUKeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 06:34:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfFUKeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 06:34:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AC7DE61CFC; Fri, 21 Jun 2019 10:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561113239;
        bh=manjW8C5h8K1gbTBvn6fCexwSJjompnXu5lE/tcdFKY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iKYkHq1gwXBlivoLqQsii7tLyDZg4xxxwpTUttdKiNlNQ76JPySFt5jfzyLjLCb0N
         mtUyLBB3vuvlv2qt0juicNtXw+tjC3NCLrT756NIfQBgfDCW/Iy1GFjMFvuklBbRXr
         rukOgR6DqpF173p2MGKFJpud5+zGVnguRkMJRltQ=
Received: from [10.79.136.27] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3EB061CEA;
        Fri, 21 Jun 2019 10:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561113235;
        bh=manjW8C5h8K1gbTBvn6fCexwSJjompnXu5lE/tcdFKY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B8cGsKjFQT3ugVnuB5+GYixr+/lxRDymgmHQ8ZiB++EWTooJeCFs+GV3swYCLzUju
         mnfJ3q5ODzIBlTOZDatJmPuO4p+oBQdwVPtTIszyRFjkXBjFQh12wCxDMt12bYqOeR
         R09JtP7QV0wur6wluJhDk86LLlOvcCaSXpb5tamI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3EB061CEA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv2 1/2] coresight: Do not default to CPU0 for missing CPU
 phandle
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        mathieu.poirier@linaro.org, leo.yan@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, alexander.shishkin@linux.intel.com,
        david.brown@linaro.org, mark.rutland@arm.com
Cc:     rnayak@codeaurora.org, vivek.gautam@codeaurora.org,
        sibis@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <cover.1561054498.git.saiprakash.ranjan@codeaurora.org>
 <92a33fa58c77206b338220427e92dabbd1d197f7.1561054498.git.saiprakash.ranjan@codeaurora.org>
 <4176442c-feb8-5245-2b27-afcdb9a6247c@arm.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <f33c524d-2e13-aa4e-0e13-9d89f6ad87dd@codeaurora.org>
Date:   Fri, 21 Jun 2019 16:03:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <4176442c-feb8-5245-2b27-afcdb9a6247c@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Suzuki,

On 6/21/2019 3:18 PM, Suzuki K Poulose wrote:
> Hi Sai,
> 
> 
> On 06/20/2019 07:31 PM, Sai Prakash Ranjan wrote:
>> Coresight platform support assumes that a missing "cpu" phandle
>> defaults to CPU0. This could be problematic and unnecessarily binds
>> components to CPU0, where they may not be. Let us make the DT binding
>> rules a bit stricter by not defaulting to CPU0 for missing "cpu"
>> affinity information.
>>
>> Also in coresight etm and cpu-debug drivers, abort the probe
>> for such cases.
>>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Please drop this tag for now.
> 

Ok will drop this.

>> ---
>>   Documentation/devicetree/bindings/arm/coresight.txt |  2 +-
>>   drivers/hwtracing/coresight/coresight-cpu-debug.c   |  3 +++
>>   drivers/hwtracing/coresight/coresight-etm3x.c       |  3 +++
>>   drivers/hwtracing/coresight/coresight-etm4x.c       |  3 +++
>>   drivers/hwtracing/coresight/coresight-platform.c    | 10 +++++-----
>>   5 files changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt 
>> b/Documentation/devicetree/bindings/arm/coresight.txt
>> index 8a88ddebc1a2..c4659ba9457d 100644
>> --- a/Documentation/devicetree/bindings/arm/coresight.txt
>> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
>> @@ -88,7 +88,7 @@ its hardware characteristcs.
>>         registers via co-processor 14.
>>       * cpu: the cpu phandle this ETM/PTM is affined to. When omitted the
>> -      source is considered to belong to CPU0.
>> +      affinity is set to invalid.
> 
> Please move this from the "Optional properties". It is not "Optional"
> anymore with this change. Please make sure it is evident that this
> is mandatory. Also please fix the bindings document for cpu-debug.txt.
> 
> 
>>   * Optional property for TMC:
> 
>> diff --git a/drivers/hwtracing/coresight/coresight-platform.c 
>> b/drivers/hwtracing/coresight/coresight-platform.c
>> index 3c5ceda8db24..8b03fa573684 100644
>> --- a/drivers/hwtracing/coresight/coresight-platform.c
>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
>> @@ -159,16 +159,16 @@ static int of_coresight_get_cpu(struct device *dev)
>>       struct device_node *dn;
>>       if (!dev->of_node)
>> -        return 0;
>> +        return -ENODEV;
>> +
>>       dn = of_parse_phandle(dev->of_node, "cpu", 0);
>> -    /* Affinity defaults to CPU0 */
>>       if (!dn)
>> -        return 0;
>> +        return -ENODEV;
>> +
>>       cpu = of_cpu_node_to_id(dn);
>>       of_node_put(dn);
> 
> Please fix the acpi_coresight_get_cpu() for ACPI.
> 

Ok will do it. Thanks again for the review comments.

-Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
