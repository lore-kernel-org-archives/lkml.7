Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65781C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6EB2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xu0rQhd1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iQg3Zp+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfDOMFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:05:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43268 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDOMFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:05:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E080561A37; Mon, 15 Apr 2019 12:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555329935;
        bh=WEkLI02HkMlfLPjkCRB4kQX+Yc8CE5+4/CD8RPw+AQc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Xu0rQhd1OqjN3XFh0orJJb4zQv5MgfIf1k6nEp64ZsKQ3n8RytJf1FaJ03ru+GGrJ
         3PdQUHIhmp6TjzwlXOMABom8kTBE91rbvxu2NLyX7VfvOQ5Mlx+66apzs7nXOEaqRm
         pLm0uDjdQ6BjJGC1Dj6NoG+qRL8rL35xr1emcOA4=
Received: from [10.79.129.68] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 07F0E61793;
        Mon, 15 Apr 2019 12:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555329931;
        bh=WEkLI02HkMlfLPjkCRB4kQX+Yc8CE5+4/CD8RPw+AQc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iQg3Zp+9/4ZOq2F8j4H95sttETImEvHggDy3OJvA9dhTo+yXLicyrrVNgqys+vu7C
         Xupq0TjJ1SrhiP4StLWG5C1yjGfvU4pX/K6lfV8yNmhuYToLc0qeBV5a2ryrUhthus
         s9ClfyFm+iSDNhOwbZydMUySttYaON2ec2JBHuOk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 07F0E61793
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add SID information to context fault
 log
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will.deacon@arm.com, iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
References: <20190415080734.6843-1-vivek.gautam@codeaurora.org>
 <e5945adb-a1a3-1743-e671-39707276fad6@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <4cfc7b3b-bc74-6b37-19f5-40b6394fa762@codeaurora.org>
Date:   Mon, 15 Apr 2019 17:35:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e5945adb-a1a3-1743-e671-39707276fad6@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/15/2019 3:11 PM, Robin Murphy wrote:
> On 15/04/2019 09:07, Vivek Gautam wrote:
>> Extract the SID and add the information to context fault log.
>> This is specially useful in a distributed smmu architecture
>> where multiple masters are connected to smmu. SID information
>> helps to quickly identify the faulting master device.
>
> Hmm, given how it's UNKNOWN for translation faults, which are arguably 
> the most likely context fault, I reckon it probably makes more sense 
> to just dump the raw register value for the user to interpret, as we 
> do for fsr/fsynr.


Thanks Robin. Sure will update it to dump the raw register value.

Regards
Vivek

>
> Robin.
>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>   drivers/iommu/arm-smmu-regs.h |  4 ++++
>>   drivers/iommu/arm-smmu.c      | 14 ++++++++++++--
>>   2 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-regs.h 
>> b/drivers/iommu/arm-smmu-regs.h
>> index a1226e4ab5f8..e5be0344b610 100644
>> --- a/drivers/iommu/arm-smmu-regs.h
>> +++ b/drivers/iommu/arm-smmu-regs.h
>> @@ -147,6 +147,10 @@ enum arm_smmu_s2cr_privcfg {
>>   #define CBAR_IRPTNDX_SHIFT        24
>>   #define CBAR_IRPTNDX_MASK        0xff
>>   +#define ARM_SMMU_GR1_CBFRSYNRA(n)    (0x400 + ((n) << 2))
>> +#define CBFRSYNRA_V2_SID_MASK        0xffff
>> +#define CBFRSYNRA_V1_SID_MASK        0x7fff
>> +
>>   #define ARM_SMMU_GR1_CBA2R(n)        (0x800 + ((n) << 2))
>>   #define CBA2R_RW64_32BIT        (0 << 0)
>>   #define CBA2R_RW64_64BIT        (1 << 0)
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 045d93884164..aa3426dc68d0 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -575,7 +575,10 @@ static irqreturn_t arm_smmu_context_fault(int 
>> irq, void *dev)
>>       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>       struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>>       struct arm_smmu_device *smmu = smmu_domain->smmu;
>> +    void __iomem *gr1_base = ARM_SMMU_GR1(smmu);
>>       void __iomem *cb_base;
>> +    u32 cbfrsynra;
>> +    u16 sid;
>>         cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
>>       fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
>> @@ -586,9 +589,16 @@ static irqreturn_t arm_smmu_context_fault(int 
>> irq, void *dev)
>>       fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
>>       iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
>>   +    cbfrsynra = readl_relaxed(gr1_base +
>> +                  ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
>> +    if (smmu->version > ARM_SMMU_V1)
>> +        sid = cbfrsynra & CBFRSYNRA_V2_SID_MASK;
>> +    else
>> +        sid = cbfrsynra & CBFRSYNRA_V1_SID_MASK;
>> +
>>       dev_err_ratelimited(smmu->dev,
>> -    "Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, 
>> cb=%d\n",
>> -                fsr, iova, fsynr, cfg->cbndx);
>> +    "Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, 
>> cb=%d sid = %u\n",
>> +                fsr, iova, fsynr, cfg->cbndx, sid);
>>         writel(fsr, cb_base + ARM_SMMU_CB_FSR);
>>       return IRQ_HANDLED;
>>
