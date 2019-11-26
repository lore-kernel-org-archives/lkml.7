Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72C2C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E83420678
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfKZJNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 04:13:24 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2113 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727028AbfKZJNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 04:13:23 -0500
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 35295FC91DF0DEC22361;
        Tue, 26 Nov 2019 09:13:22 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 26 Nov 2019 09:13:21 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 26 Nov
 2019 09:13:21 +0000
Subject: Re: [PATCH v3 09/14] iommu/arm-smmu: Prevent forced unbinding of Arm
 SMMU drivers
To:     Will Deacon <will@kernel.org>, <iommu@lists.linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Saravana Kannan" <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20191121114918.2293-1-will@kernel.org>
 <20191121114918.2293-10-will@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5c91d467-5e59-482b-8f4f-e0cfa3db9028@huawei.com>
Date:   Tue, 26 Nov 2019 09:13:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191121114918.2293-10-will@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2019 11:49, Will Deacon wrote:
> Forcefully unbinding the Arm SMMU drivers is a pretty dangerous operation,
> since it will likely lead to catastrophic failure for any DMA devices
> mastering through the SMMU being unbound. When the driver then attempts
> to "handle" the fatal faults, it's very easy to trip over dead data
> structures, leading to use-after-free.
> 
> On John's machine, he reports that the machine was "unusable" due to
> loss of the storage controller following a forced unbind of the SMMUv3
> driver:
> 
>    | # cd ./bus/platform/drivers/arm-smmu-v3
>    | # echo arm-smmu-v3.0.auto > unbind
>    | hisi_sas_v2_hw HISI0162:01: CQE_AXI_W_ERR (0x800) found!
>    | platform arm-smmu-v3.0.auto: CMD_SYNC timeout at 0x00000146
>    | [hwprod 0x00000146, hwcons 0x00000000]
> 
> Prevent this forced unbinding of the drivers by setting "suppress_bind_attrs"
> to true.

This seems a reasonable approach for now.

BTW, I'll give this series a spin this week, which again looks to be 
your iommu/module branch, excluding the new IORT patch.

Cheers,
John

> 
> Link: https://lore.kernel.org/lkml/06dfd385-1af0-3106-4cc5-6a5b8e864759@huawei.com
> Reported-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   drivers/iommu/arm-smmu-v3.c | 5 +++--
>   drivers/iommu/arm-smmu.c    | 7 ++++---
>   2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 2ad8e2ca0583..3fd75abce3bb 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -3700,8 +3700,9 @@ MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>   
>   static struct platform_driver arm_smmu_driver = {
>   	.driver	= {
> -		.name		= "arm-smmu-v3",
> -		.of_match_table	= of_match_ptr(arm_smmu_of_match),
> +		.name			= "arm-smmu-v3",
> +		.of_match_table		= of_match_ptr(arm_smmu_of_match),
> +		.suppress_bind_attrs	= true,
>   	},
>   	.probe	= arm_smmu_device_probe,
>   	.remove	= arm_smmu_device_remove,
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 53bbe0663b9e..d6c83bd69555 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2237,9 +2237,10 @@ static const struct dev_pm_ops arm_smmu_pm_ops = {
>   
>   static struct platform_driver arm_smmu_driver = {
>   	.driver	= {
> -		.name		= "arm-smmu",
> -		.of_match_table	= of_match_ptr(arm_smmu_of_match),
> -		.pm		= &arm_smmu_pm_ops,
> +		.name			= "arm-smmu",
> +		.of_match_table		= of_match_ptr(arm_smmu_of_match),
> +		.pm			= &arm_smmu_pm_ops,
> +		.suppress_bind_attrs    = true,
>   	},
>   	.probe	= arm_smmu_device_probe,
>   	.remove	= arm_smmu_device_remove,
> 

