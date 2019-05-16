Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE08C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D223F20815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfEPMq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 08:46:27 -0400
Received: from foss.arm.com ([217.140.101.70]:44600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfEPMq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 08:46:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC0BD1715;
        Thu, 16 May 2019 05:46:26 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B63423F703;
        Thu, 16 May 2019 05:46:24 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] iommu: Introduce IOMMU_RESV_DIRECT_RELAXABLE
 reserved memory regions
To:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        lorenzo.pieralisi@arm.com, will.deacon@arm.com,
        hanjun.guo@linaro.org, sudeep.holla@arm.com
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com
References: <20190516100817.12076-1-eric.auger@redhat.com>
 <20190516100817.12076-7-eric.auger@redhat.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ad8a99fa-b98a-14d3-12be-74df0e6eb8f8@arm.com>
Date:   Thu, 16 May 2019 13:46:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516100817.12076-7-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2019 11:08, Eric Auger wrote:
> Introduce a new type for reserved region. This corresponds
> to directly mapped regions which are known to be relaxable
> in some specific conditions, such as device assignment use
> case. Well known examples are those used by USB controllers
> providing PS/2 keyboard emulation for pre-boot BIOS and
> early BOOT or RMRRs associated to IGD working in legacy mode.
> 
> Since commit c875d2c1b808 ("iommu/vt-d: Exclude devices using RMRRs
> from IOMMU API domains") and commit 18436afdc11a ("iommu/vt-d: Allow
> RMRR on graphics devices too"), those regions are currently
> considered "safe" with respect to device assignment use case
> which requires a non direct mapping at IOMMU physical level
> (RAM GPA -> HPA mapping).
> 
> Those RMRRs currently exist and sometimes the device is
> attempting to access it but this has not been considered
> an issue until now.
> 
> However at the moment, iommu_get_group_resv_regions() is
> not able to make any difference between directly mapped
> regions: those which must be absolutely enforced and those
> like above ones which are known as relaxable.
> 
> This is a blocker for reporting severe conflicts between
> non relaxable RMRRs (like MSI doorbells) and guest GPA space.
> 
> With this new reserved region type we will be able to use
> iommu_get_group_resv_regions() to enumerate the IOVA space
> that is usable through the IOMMU API without introducing
> regressions with respect to existing device assignment
> use cases (USB and IGD).
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> Note: At the moment the sysfs ABI is not changed. However I wonder
> whether it wouldn't be preferable to report the direct region as
> "direct_relaxed" there. At the moment, in case the same direct
> region is used by 2 devices, one USB/GFX and another not belonging
> to the previous categories, the direct region will be output twice
> with "direct" type.

Hmm, that sounds a bit off - if we have overlapping regions within the 
same domain, then we need to do some additional pre-processing to adjust 
them anyway, since any part of a relaxable region which overlaps a 
non-relaxable region cannot actually be relaxed, and so really should 
never be described as such.

> This would unblock Shameer's series:
> [PATCH v6 0/7] vfio/type1: Add support for valid iova list management
> https://patchwork.kernel.org/patch/10425309/
> 
> which failed to get pulled for 4.18 merge window due to IGD
> device assignment regression.
> 
> v2 -> v3:
> - fix direct type check
> ---
>   drivers/iommu/iommu.c | 12 +++++++-----
>   include/linux/iommu.h |  6 ++++++
>   2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index ae4ea5c0e6f9..28c3d6351832 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -73,10 +73,11 @@ struct iommu_group_attribute {
>   };
>   
>   static const char * const iommu_group_resv_type_string[] = {
> -	[IOMMU_RESV_DIRECT]	= "direct",
> -	[IOMMU_RESV_RESERVED]	= "reserved",
> -	[IOMMU_RESV_MSI]	= "msi",
> -	[IOMMU_RESV_SW_MSI]	= "msi",
> +	[IOMMU_RESV_DIRECT]			= "direct",
> +	[IOMMU_RESV_DIRECT_RELAXABLE]		= "direct",

Wasn't part of the idea that we might not need to expose these to 
userspace at all if they're only relevant to default domains, and not to 
VFIO domains or anything else userspace can get involved with?

> +	[IOMMU_RESV_RESERVED]			= "reserved",
> +	[IOMMU_RESV_MSI]			= "msi",
> +	[IOMMU_RESV_SW_MSI]			= "msi",
>   };
>   
>   #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
> @@ -573,7 +574,8 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
>   		start = ALIGN(entry->start, pg_size);
>   		end   = ALIGN(entry->start + entry->length, pg_size);
>   
> -		if (entry->type != IOMMU_RESV_DIRECT)
> +		if (entry->type != IOMMU_RESV_DIRECT &&
> +		    entry->type != IOMMU_RESV_DIRECT_RELAXABLE)
>   			continue;
>   
>   		for (addr = start; addr < end; addr += pg_size) {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ba91666998fb..14a521f85f14 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -135,6 +135,12 @@ enum iommu_attr {
>   enum iommu_resv_type {
>   	/* Memory regions which must be mapped 1:1 at all times */
>   	IOMMU_RESV_DIRECT,
> +	/*
> +	 * Memory regions which are advertised to be 1:1 but are
> +	 * commonly considered relaxable in some conditions,
> +	 * for instance in device assignment use case (USB, Graphics)
> +	 */
> +	IOMMU_RESV_DIRECT_RELAXABLE,

What do you think of s/RELAXABLE/BOOT/ ? My understanding is that these 
regions are only considered relevant until Linux has taken full control 
of the endpoint, and having a slightly more well-defined scope than 
"some conditions" might be nice.

There's an open question of how to handle things like simple-fb and EFI 
framebuffer handover on Arm and other platforms, so I'd really like to 
be able to slot that right into this case as well (how we describe the 
relevant connections in DT/ACPI is another matter, but hey, one step at 
a time...)

Otherwise though, I too am pleased to see this, thanks! I did start 
having a go myself after talking to Alex at KVM Forum, but I got bogged 
down in the intel-iommu parts and inevitably distracted - patch #7 looks 
beautifully simpler than I'd convinced myself was possible :D

Robin.

>   	/* Arbitrary "never map this or give it to a device" address ranges */
>   	IOMMU_RESV_RESERVED,
>   	/* Hardware MSI region (untranslated) */
> 
