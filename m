Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C32C47E49
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13797214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbfJVRwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 13:52:35 -0400
Received: from [217.140.110.172] ([217.140.110.172]:58834 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1729635AbfJVRwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 13:52:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A342431F;
        Tue, 22 Oct 2019 10:52:14 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81FE23F718;
        Tue, 22 Oct 2019 10:52:12 -0700 (PDT)
Subject: Re: [PATCH v3 0/7] Nvidia Arm SMMUv2 Implementation
To:     Krishna Reddy <vdumpa@nvidia.com>, will@kernel.org
Cc:     joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com, yhsu@nvidia.com,
        snikam@nvidia.com, praithatha@nvidia.com, talho@nvidia.com,
        avanbrunt@nvidia.com, thomasz@nvidia.com, olof@lixom.net,
        jtukkinen@nvidia.com, mperttunen@nvidia.com, nicolinc@nvidia.com
References: <1571441492-21919-1-git-send-email-vdumpa@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6d9e6425-fa69-9b76-b477-1fe50c459ca5@arm.com>
Date:   Tue, 22 Oct 2019 18:52:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1571441492-21919-1-git-send-email-vdumpa@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

On 19/10/2019 00:31, Krishna Reddy wrote:
> Changes in v3:
> Rebased on top of https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/ next.
> Resolved compile error seen with tegra194.dtsi changes after rebase.

Apologies for crossed wires, but I had a series getting rid of 
arm_smmu_flush_ops which was also meant to end up making things a bit 
easier for you:

https://lore.kernel.org/linux-iommu/cover.1568820087.git.robin.murphy@arm.com/

Will, did you have any plans to push out an updates or iommu/devel 
branch for Krishna to base on?

Robin.

> 
> v2 - https://lkml.org/lkml/2019/9/2/980
> v1 - https://lkml.org/lkml/2019/8/29/1588
> 
> Krishna Reddy (7):
>    iommu/arm-smmu: prepare arm_smmu_flush_ops for override
>    iommu/arm-smmu: add NVIDIA implementation for dual ARM MMU-500 usage
>    dt-bindings: arm-smmu: Add binding for Tegra194 SMMU
>    iommu/arm-smmu: Add global/context fault implementation hooks
>    arm64: tegra: Add Memory controller DT node on T194
>    arm64: tegra: Add DT node for T194 SMMU
>    arm64: tegra: enable SMMU for SDHCI and EQOS on T194
> 
>   .../devicetree/bindings/iommu/arm,smmu.txt         |   4 +
>   MAINTAINERS                                        |   2 +
>   arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |   4 +
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  88 +++++++
>   drivers/iommu/Makefile                             |   2 +-
>   drivers/iommu/arm-smmu-impl.c                      |   3 +
>   drivers/iommu/arm-smmu-nvidia.c                    | 287 +++++++++++++++++++++
>   drivers/iommu/arm-smmu.c                           |  27 +-
>   drivers/iommu/arm-smmu.h                           |   8 +-
>   9 files changed, 413 insertions(+), 12 deletions(-)
>   create mode 100644 drivers/iommu/arm-smmu-nvidia.c
> 
