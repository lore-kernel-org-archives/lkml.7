Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07BCC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3EE208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbfDXQW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:22:58 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:33337 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfDXQW5 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 24 Apr 2019 12:22:57 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 24 Apr 2019 18:22:55 +0200
Received: from ziggy.stardust (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Wed, 24 Apr 2019 17:22:31 +0100
Subject: Re: [PATCH v2 0/2] iommu/arm-smmu-v3: make sure the kdump kernel can
 work well when smmu is enabled
To:     Will Deacon <will.deacon@arm.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20190318131243.20716-1-thunder.leizhen@huawei.com>
 <20190404153031.GE27558@fuggles.cambridge.arm.com>
 <5CAAB293.3080600@huawei.com>
 <20190416091410.GC31579@fuggles.cambridge.arm.com>
From:   Matthias Brugger <mbrugger@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mbrugger@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8302e13d-2a9d-ab28-8883-1748848c36d9@suse.com>
Date:   Wed, 24 Apr 2019 18:22:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416091410.GC31579@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/04/2019 11:14, Will Deacon wrote:
> On Mon, Apr 08, 2019 at 10:31:47AM +0800, Leizhen (ThunderTown) wrote:
>> On 2019/4/4 23:30, Will Deacon wrote:
>>> On Mon, Mar 18, 2019 at 09:12:41PM +0800, Zhen Lei wrote:
>>>> v1 --> v2:
>>>> 1. Drop part2. Now, we only use the SMMUv3 hardware feature STE.config=0b000
>>>> (Report abort to device, no event recorded) to suppress the event messages
>>>> caused by the unexpected devices.
>>>> 2. rewrite the patch description.
>>>
>>> This issue came up a while back:
>>>
>>> https://lore.kernel.org/linux-pci/20180302103032.GB19323@arm.com/
>>>
>>> and I'd still prefer to solve it using the disable_bypass logic which we
>>> already have. Something along the lines of the diff below?
>>
>> Yes, my patches also use disable_bypass=1(set ste.config=0b000). If
>> SMMU_IDR0.ST_LEVEL=0(Linear Stream table supported), then all STE entries
>> are allocated and initialized(set ste.config=0b000). But if SMMU_IDR0.ST_LEVEL=1
>> (2-level Stream Table), we only allocated and initialized the first level tables,
>> but leave level 2 tables dynamic allocated. That means, C_BAD_STREAMID(eventid=0x2)
>> will be reported, if an unexpeted device access memory without reinitialized in
>> kdump kernel.
> 
> So is your problem just that the C_BAD_STREAMID events are noisy? If so,
> perhaps we should be disabling fault reporting entirely in the kdump kernel.
> 
> How about the update diff below? I'm keen to have this as simple as
> possible, so we don't end up introducing rarely tested, complex code on
> the crash path.
> 
> Will
> 
> --->8
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index d3880010c6cf..d8b73da6447d 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2454,13 +2454,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  	/* Clear CR0 and sync (disables SMMU and queue processing) */
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
>  	if (reg & CR0_SMMUEN) {
> -		if (is_kdump_kernel()) {
> -			arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> -			arm_smmu_device_disable(smmu);
> -			return -EBUSY;
> -		}
> -
>  		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
> +		WARN_ON(is_kdump_kernel() && !disable_bypass);
> +		arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
>  	}
>  
>  	ret = arm_smmu_device_disable(smmu);
> @@ -2553,6 +2549,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  		return ret;
>  	}
>  
> +	if (is_kdump_kernel())
> +		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
>  
>  	/* Enable the SMMU interface, or ensure bypass */
>  	if (!bypass || disable_bypass) {
> 

Same here I tested the patch and it works for me.

Feel free to add:
Tested-by: Matthias Brugger <mbrugger@suse.com>

Regards,
Matthias
