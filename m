Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F026CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 05:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCD5208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 05:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbfHOFDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 01:03:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:34458 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbfHOFDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 01:03:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 22:03:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,388,1559545200"; 
   d="scan'208";a="171012988"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2019 22:02:59 -0700
Cc:     baolu.lu@linux.intel.com, corbet@lwn.net, tony.luck@intel.com,
        fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Thomas.Lendacky@amd.com, Suravee.Suthikulpanit@amd.com,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 06/10] iommu: Remember when default domain type was set on
 kernel command line
To:     Joerg Roedel <joro@8bytes.org>
References: <20190814133841.7095-1-joro@8bytes.org>
 <20190814133841.7095-7-joro@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <754a526e-a6d4-8a3f-0b35-9dd3def5d24b@linux.intel.com>
Date:   Thu, 15 Aug 2019 13:01:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814133841.7095-7-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/14/19 9:38 PM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Introduce an extensible concept to remember when certain
> configuration settings for the IOMMU code have been set on
> the kernel command line.
> 
> This will be used later to prevent overwriting these
> settings with other defaults.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/iommu.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f187e85a074b..e1feb4061b8b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -32,6 +32,7 @@ static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
>   static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>   #endif
>   static bool iommu_dma_strict __read_mostly = true;
> +static u32 iommu_cmd_line __read_mostly;
>   
>   struct iommu_group {
>   	struct kobject kobj;
> @@ -68,6 +69,18 @@ static const char * const iommu_group_resv_type_string[] = {
>   	[IOMMU_RESV_SW_MSI]			= "msi",
>   };
>   
> +#define IOMMU_CMD_LINE_DMA_API		(1 << 0)

Prefer BIT() micro?

> +
> +static void iommu_set_cmd_line_dma_api(void)
> +{
> +	iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
> +}
> +
> +static bool __maybe_unused iommu_cmd_line_dma_api(void)
> +{
> +	return !!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API);
> +}
> +
>   #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
>   struct iommu_group_attribute iommu_group_attr_##_name =		\
>   	__ATTR(_name, _mode, _show, _store)
> @@ -165,6 +178,8 @@ static int __init iommu_set_def_domain_type(char *str)
>   	if (ret)
>   		return ret;
>   
> +	iommu_set_cmd_line_dma_api();

IOMMU command line is also set in other places, for example,
iommu_setup() (arch/x86/kernel/pci-dma.c). Need to call this there as
well?

Best regards,
Lu Baolu

> +
>   	iommu_def_domain_type = pt ? IOMMU_DOMAIN_IDENTITY : IOMMU_DOMAIN_DMA;
>   	return 0;
>   }
> 
