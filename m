Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1502C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5882168B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbfIBNAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:00:12 -0400
Received: from foss.arm.com ([217.140.110.172]:53816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730415AbfIBNAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:00:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4399337;
        Mon,  2 Sep 2019 06:00:10 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE5DD3F246;
        Mon,  2 Sep 2019 06:00:08 -0700 (PDT)
Subject: Re: [PATCH 3/7] iommu/arm-smmu: Add tlb_sync implementation hook
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     Sachin Nikam <Snikam@nvidia.com>,
        "Thomas Zeng (SW-TEGRA)" <thomasz@nvidia.com>,
        Juha Tukkinen <jtukkinen@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Pritesh Raithatha <praithatha@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timo Alho <talho@nvidia.com>, Yu-Huan Hsu <YHsu@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Alexander Van Brunt <avanbrunt@nvidia.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
 <1567118827-26358-4-git-send-email-vdumpa@nvidia.com>
 <554f8de1-1638-4eb9-59ae-8e1f0d786c44@arm.com>
 <BYAPR12MB2710AF5DDCB687C7E78362E5B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
 <BYAPR12MB271010C629D8DD7AEC0123D4B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3d734164-51c9-3465-cddd-276093389797@arm.com>
Date:   Mon, 2 Sep 2019 14:00:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB271010C629D8DD7AEC0123D4B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2019 23:49, Krishna Reddy wrote:
>>> +	if (smmu->impl->tlb_sync) {
>>> +		smmu->impl->tlb_sync(smmu, page, sync, status);
> 
>> What I'd hoped is that rather than needing a hook for this, you could just override smmu_domain->tlb_ops from .init_context to wire up the alternate .sync method directly. That would save this extra level of indirection.
> 
> Hi Robin,  overriding tlb_ops->tlb_sync function is not enough here.
> There are direct references to arm_smmu_tlb_sync_context(),  arm_smmu_tlb_sync_global() functions.
> In arm-smmu.c.  we can replace these direct references with tlb_ops->tlb_sync() function except in one function arm_smmu_device_reset().
> When arm_smmu_device_reset() gets called, domains are not initialized and tlb_ops is not available.
> Should we add a new hook for arm_smmu_tlb_sync_global() or make this as a responsibility of impl->reset() hook as it gets
> called at the same place?

Ah, right, I'd forgotten about the TLB maintenance on reset. Looking 
again, though, I think you might need to implement impl->reset anyway 
for the sake of clearing GFSR correctly - since the value read from the 
base instance technically may not match whatever bits might happen to be 
set in the other instances - so I don't see any issue with just calling 
nsmmu_tlb_sync() from there as well.

Robin.
