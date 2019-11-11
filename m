Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03923C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 01:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FBC206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 01:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfKKBai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 20:30:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:24970 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfKKBai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 20:30:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Nov 2019 17:30:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,290,1569308400"; 
   d="scan'208";a="228786353"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 10 Nov 2019 17:30:36 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
        ashok.raj@intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Add Kconfig option to enable/disable
 scalable mode
To:     Qian Cai <cai@lca.pw>
References: <20191109034039.27964-1-baolu.lu@linux.intel.com>
 <A85B5322-5DED-4E58-B3BC-4DA3783BB8A6@lca.pw>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <519c1126-ab91-1308-bdd0-c8d1be7a1c63@linux.intel.com>
Date:   Mon, 11 Nov 2019 09:27:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <A85B5322-5DED-4E58-B3BC-4DA3783BB8A6@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/9/19 11:59 AM, Qian Cai wrote:
> 
> 
>> On Nov 8, 2019, at 10:40 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> This adds Kconfig option INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
>> to make it easier for distributions to enable or disable the
>> Intel IOMMU scalable mode by default during kernel build.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>> drivers/iommu/Kconfig       | 9 +++++++++
>> drivers/iommu/intel-iommu.c | 7 ++++++-
>> 2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index e3842eabcfdd..fbdf3fd291d9 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -242,6 +242,15 @@ config INTEL_IOMMU_FLOPPY_WA
>> 	  workaround will setup a 1:1 mapping for the first
>> 	  16MiB to make floppy (an ISA device) work.
>>
>> +config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
>> +	prompt "Enable Intel IOMMU scalable mode by default"
>> +	depends on INTEL_IOMMU
>> +	help
>> +	  Selecting this option will enable the scalable mode if
>> +	  hardware presents the capability. If this option is not
>> +	  selected, scalable mode support could also be enabled
>> +	  by passing intel_iommu=sm_on to the kernel.
> 
> 
> Maybe a sentence or two to describe what the scalable mode is in layman's
> terms could be useful, so developers don’t need to search around for the
> Kconfig selection?

How about "pasid based multiple stages DMA translation"?

Best regards,
baolu

> 
>> +
>> config IRQ_REMAP
>> 	bool "Support for Interrupt Remapping"
>> 	depends on X86_64 && X86_IO_APIC && PCI_MSI && ACPI
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 6db6d969e31c..6051fe790c61 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -355,9 +355,14 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
>> int dmar_disabled = 0;
>> #else
>> int dmar_disabled = 1;
>> -#endif /*CONFIG_INTEL_IOMMU_DEFAULT_ON*/
>> +#endif /* CONFIG_INTEL_IOMMU_DEFAULT_ON */
>>
>> +#ifdef INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
>> +int intel_iommu_sm = 1;
>> +#else
>> int intel_iommu_sm;
>> +#endif /* INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON */
>> +
>> int intel_iommu_enabled = 0;
>> EXPORT_SYMBOL_GPL(intel_iommu_enabled);
>>
>> -- 
>> 2.17.1
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
> 
