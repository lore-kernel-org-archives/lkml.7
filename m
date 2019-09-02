Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDACC3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C2521883
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbfIBNkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:40:05 -0400
Received: from foss.arm.com ([217.140.110.172]:54764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731454AbfIBNkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:40:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D16C7337;
        Mon,  2 Sep 2019 06:40:01 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C16B3F59C;
        Mon,  2 Sep 2019 06:39:57 -0700 (PDT)
Subject: Re: [PATCH 1/7] iommu/arm-smmu: add Nvidia SMMUv2 implementation
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
 <1567118827-26358-2-git-send-email-vdumpa@nvidia.com>
 <2ae9e0c4-6916-b005-f4bd-29e06d2056c6@arm.com>
 <BYAPR12MB2710D045303BE89A7D3FF2C1B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3f2cbbe2-f6d7-07e3-3fef-18af518dedef@arm.com>
Date:   Mon, 2 Sep 2019 14:39:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB2710D045303BE89A7D3FF2C1B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2019 19:16, Krishna Reddy wrote:
>>> +ARM_SMMU_MATCH_DATA(nvidia_smmuv2, ARM_SMMU_V2, NVIDIA_SMMUV2);
> 
>>  From the previous discussions, I got the impression that other than the 'novel' way they're integrated, the actual SMMU implementations were unmodified Arm MMU-500s. Is that the case, or have I misread something?
> 
> The ARM MMU-500 implementation is unmodified.  It is the way the are integrated and used together(for interleaved accesses) is different from regular ARM MMU-500.
> I have added it to get the model number and to be able differentiate the SMMU implementation in arm-smmu-impl.c.

In that case, I would rather keep smmu->model representing the MMU-500 
microarchitecture - since you'll still want to pick up errata 
workarounds etc. for that - and detect the Tegra integration via an 
explicit of_device_is_compatible() check in arm_smmu_impl_init(). For 
comparison, under ACPI we'd probably have to detect integration details 
by looking at table headers, separately from the IORT "Model" field, so 
I'd prefer if the DT vs. ACPI handling didn't diverge more than necessary.

Of course, that immediately opens the question of how best to combine 
arm_mmu500_impl with nsmmu_impl, but hey, one step at a time :)

Robin.
