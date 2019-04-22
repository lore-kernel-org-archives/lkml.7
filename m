Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29C2C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 12:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E6B20693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 12:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfDVMdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 08:33:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46188 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfDVMdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 08:33:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id v2so3385355pge.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 05:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vLn+Kof7sEmcVl/KsYpnRdLNgg3fMUQp9bpI2yJlGNQ=;
        b=tvLjXL7ADJJTTkq4fo37IuiKrHzkM02DoZZ4GqayXWe0joovSP0HElapeFdhd7fkvx
         yZ9CRmHbR2ccir/5kij6IwAeITB7RuhTxvFrYsMV/L1baMuMLKxpZ/0Tc29hLL5KWTXU
         qVTLE1q9lBuV+I/VJUVYMaWSImFs+ofb+6RGdf+xKpclBnA3QiekxESEarGFt0i1nn8C
         xH/l3BeQxG5gSGJipJUq5MXwxnTqUNysHxs1MB2iR6r3gNIsIm/3WVnyyrBeg38KROFp
         AKkpPzD+j3L2SKcQAvtogzeRrx8GFeV8Um3ny9TcfRCQbGR2RclG+95dEopCiJMBuT9W
         MINA==
X-Gm-Message-State: APjAAAXB7HlagOc7NOpB1ksUFTOAr81IkhWjnSQ/jH+AkgT8GCO6yq1P
        UdrJnj6BnCifGr2y79UEb8hfow==
X-Google-Smtp-Source: APXvYqyC3kPnDknrObC7+6k/LBZJPREgpC8svVXOr3VN/uHIc9DHS8WFFFLK2nLuTc7u4xqEVTjhnA==
X-Received: by 2002:a62:5582:: with SMTP id j124mr20429931pfb.53.1555936390738;
        Mon, 22 Apr 2019 05:33:10 -0700 (PDT)
Received: from localhost.localdomain ([182.69.198.211])
        by smtp.gmail.com with ESMTPSA id b7sm21973363pfj.67.2019.04.22.05.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 05:33:09 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] iommu/arm-smmu-v3: make sure the kdump kernel can
 work well when smmu is enabled
To:     Will Deacon <will.deacon@arm.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>
References: <20190318131243.20716-1-thunder.leizhen@huawei.com>
 <20190404153031.GE27558@fuggles.cambridge.arm.com>
 <5CAAB293.3080600@huawei.com>
 <20190416091410.GC31579@fuggles.cambridge.arm.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <1846d5b7-bd57-e70e-4808-72c0172ed0ee@redhat.com>
Date:   Mon, 22 Apr 2019 18:03:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190416091410.GC31579@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 04/16/2019 02:44 PM, Will Deacon wrote:
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
>   	/* Clear CR0 and sync (disables SMMU and queue processing) */
>   	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
>   	if (reg & CR0_SMMUEN) {
> -		if (is_kdump_kernel()) {
> -			arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> -			arm_smmu_device_disable(smmu);
> -			return -EBUSY;
> -		}
> -
>   		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
> +		WARN_ON(is_kdump_kernel() && !disable_bypass);
> +		arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
>   	}
>   
>   	ret = arm_smmu_device_disable(smmu);
> @@ -2553,6 +2549,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>   		return ret;
>   	}
>   
> +	if (is_kdump_kernel())
> +		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
>   
>   	/* Enable the SMMU interface, or ensure bypass */
>   	if (!bypass || disable_bypass) {
> 

Thanks for the fix.

I can confirm that after this kdump kernel boots well for me on huawei 
boards, so feel free to add:

Tested-by: Bhupesh Sharma <bhsharma@redhat.com>

Here are the kdump kernel logs without this fix:

[    4.514181] arm-smmu-v3 arm-smmu-v3.1.auto: EVTQ overflow detected -- 
events lost

.. And then repeating messages like the following ..

[    4.521654] arm-smmu-v3 arm-smmu-v3.1.auto: event 0x02 received:
[    4.527654] arm-smmu-v3 arm-smmu-v3.1.auto:  0x00007d0200000002
[    4.533567] arm-smmu-v3 arm-smmu-v3.1.auto:  0x000000010000017e
[    4.539478] arm-smmu-v3 arm-smmu-v3.1.auto:  0x00000000ff6de000
[    4.545390] arm-smmu-v3 arm-smmu-v3.1.auto:  0x000000000eee03e8

And with the fix applied, kdump kernel logs can be seen below:

[ 9136.361094] Starting crashdump kernel...
[ 9136.365007] Bye!
[    0.000000] Booting Linux on physical CPU 0x0000070002 [0x480fd010]
[    0.000000] Linux version 5.1.0-rc6+

<..snip..>

[    3.424103] arm-smmu-v3 arm-smmu-v3.0.auto: option mask 0x0
[    3.429674] arm-smmu-v3 arm-smmu-v3.0.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[    3.437780] arm-smmu-v3 arm-smmu-v3.0.auto: SMMU currently enabled! 
Resetting...
[    3.445431] arm-smmu-v3 arm-smmu-v3.1.auto: option mask 0x0


<..snip..>

Thanks,
Bhupesh
