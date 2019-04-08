Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FDEC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B71C20857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfDHCbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 22:31:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42008 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726510AbfDHCbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 22:31:51 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 92ACEB5C83C009E88F9C;
        Mon,  8 Apr 2019 10:31:49 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Mon, 8 Apr 2019
 10:31:48 +0800
Subject: Re: [PATCH v2 0/2] iommu/arm-smmu-v3: make sure the kdump kernel can
 work well when smmu is enabled
To:     Will Deacon <will.deacon@arm.com>
References: <20190318131243.20716-1-thunder.leizhen@huawei.com>
 <20190404153031.GE27558@fuggles.cambridge.arm.com>
CC:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5CAAB293.3080600@huawei.com>
Date:   Mon, 8 Apr 2019 10:31:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190404153031.GE27558@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2019/4/4 23:30, Will Deacon wrote:
> Hi Zhen Lei,
> 
> On Mon, Mar 18, 2019 at 09:12:41PM +0800, Zhen Lei wrote:
>> v1 --> v2:
>> 1. Drop part2. Now, we only use the SMMUv3 hardware feature STE.config=0b000
>> (Report abort to device, no event recorded) to suppress the event messages
>> caused by the unexpected devices.
>> 2. rewrite the patch description.
> 
> This issue came up a while back:
> 
> https://lore.kernel.org/linux-pci/20180302103032.GB19323@arm.com/
> 
> and I'd still prefer to solve it using the disable_bypass logic which we
> already have. Something along the lines of the diff below?

Yes, my patches also use disable_bypass=1(set ste.config=0b000). If
SMMU_IDR0.ST_LEVEL=0(Linear Stream table supported), then all STE entries
are allocated and initialized(set ste.config=0b000). But if SMMU_IDR0.ST_LEVEL=1
(2-level Stream Table), we only allocated and initialized the first level tables,
but leave level 2 tables dynamic allocated. That means, C_BAD_STREAMID(eventid=0x2)
will be reported, if an unexpeted device access memory without reinitialized in
kdump kernel. So my patches allocated a dummy level 2 table(STE table), and make
all level 1 table entries pointer to it in advance. That means abort all unexpected
devices memory access base this dummy STE table. When an expected device(need to be
used in kdump kernel) attached, we will allocate a new level 2 table(STE table)
accordingly, but keep others still pointer to the dummy STE table.


> 
> We're relying on the DMA API not subsequently requesting a passthrough
> domain, but it should only do that if you've configured your crashkernel
> to do so.
> 
> Will
> 
> --->8
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index d3880010c6cf..91b8f3b2ee25 100644
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
> 
> .
> 

-- 
Thanks!
BestRegards

