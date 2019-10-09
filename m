Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64ACECE58E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997AE206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfJIKKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:10:41 -0400
Received: from foss.arm.com ([217.140.110.172]:58866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfJIKKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:10:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56F3F28;
        Wed,  9 Oct 2019 03:10:40 -0700 (PDT)
Received: from [192.168.1.124] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA2923F68E;
        Wed,  9 Oct 2019 03:10:38 -0700 (PDT)
Subject: Re: [PATCH v2] iommu/arm-smmu: fix "hang" when games exit
To:     Rob Clark <robdclark@gmail.com>, iommu@lists.linux-foundation.org
Cc:     freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <418d8426-f299-1269-2b2e-f86677cf22c2@arm.com>
 <20191007204906.19571-1-robdclark@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e3782ea8-7d6b-21ed-84dd-0751c4cf310a@arm.com>
Date:   Wed, 9 Oct 2019 11:10:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191007204906.19571-1-robdclark@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-07 9:49 pm, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> When games, browser, or anything using a lot of GPU buffers exits, there
> can be many hundreds or thousands of buffers to unmap and free.  If the
> GPU is otherwise suspended, this can cause arm-smmu to resume/suspend
> for each buffer, resulting 5-10 seconds worth of reprogramming the
> context bank (arm_smmu_write_context_bank()/arm_smmu_write_s2cr()/etc).
> To the user it would appear that the system just locked up.
> 
> A simple solution is to use pm_runtime_put_autosuspend() instead, so we
> don't immediately suspend the SMMU device.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> v1: original
> v2: unconditionally use autosuspend, rather than deciding based on what
>      consumer does
> 
>   drivers/iommu/arm-smmu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 3f1d55fb43c4..b7b41f5001bc 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -289,7 +289,7 @@ static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
>   static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
>   {
>   	if (pm_runtime_enabled(smmu->dev))
> -		pm_runtime_put(smmu->dev);
> +		pm_runtime_put_autosuspend(smmu->dev);
>   }
>   
>   static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
> @@ -1445,6 +1445,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   	/* Looks ok, so add the device to the domain */
>   	ret = arm_smmu_domain_add_master(smmu_domain, fwspec);
>   
> +	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
> +	pm_runtime_use_autosuspend(smmu->dev);
> +
>   rpm_put:
>   	arm_smmu_rpm_put(smmu);
>   	return ret;
> 
