Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433D4C47E49
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 01:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202DD21D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 01:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388873AbfJYBmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 21:42:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:47093 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbfJYBmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 21:42:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 18:42:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,226,1569308400"; 
   d="scan'208";a="197895969"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga007.fm.intel.com with ESMTP; 24 Oct 2019 18:42:30 -0700
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v6 01/10] iommu/vt-d: Enlightened PASID allocation
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1571788403-42095-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571788403-42095-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20191023004503.GB100970@otc-nc-03>
 <f17d8df6-d77a-32b9-104c-1ae246c7a117@linux.intel.com>
 <20191023105523.75895d76@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <40942499-cb3e-cf8d-3e47-288c57da88da@linux.intel.com>
Date:   Fri, 25 Oct 2019 09:39:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023105523.75895d76@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/24/19 1:55 AM, Jacob Pan wrote:
> On Wed, 23 Oct 2019 09:53:04 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> Hi Ashok,
>>
>> Thanks for reviewing the patch.
>>
>> On 10/23/19 8:45 AM, Raj, Ashok wrote:
>>> On Tue, Oct 22, 2019 at 04:53:14PM -0700, Jacob Pan wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>>
>>>> If Intel IOMMU runs in caching mode, a.k.a. virtual IOMMU, the
>>>> IOMMU driver should rely on the emulation software to allocate
>>>> and free PASID IDs. The Intel vt-d spec revision 3.0 defines a
>>>> register set to support this. This includes a capability register,
>>>> a virtual command register and a virtual response register. Refer
>>>> to section 10.4.42, 10.4.43, 10.4.44 for more information.
>>>
>>> The above paragraph seems a bit confusing, there is no reference
>>> to caching mode for for VCMD... some suggestion below.
>>>
>>> Enabling IOMMU in a guest requires communication with the host
>>> driver for certain aspects. Use of PASID ID to enable Shared Virtual
>>> Addressing (SVA) requires managing PASID's in the host. VT-d 3.0
>>> spec provides a Virtual Command Register (VCMD) to facilitate this.
>>> Writes to this register in the guest are trapped by Qemu and
>>> proxies the call to the host driver....
>>
>> Yours is better. Will use it.
>>
> I will roll that in to v7
>>>
>>>    
>>>>
>>>> This patch adds the enlightened PASID allocation/free interfaces
>>>> via the virtual command register.
>>>>
>>>> Cc: Ashok Raj <ashok.raj@intel.com>
>>>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>>> Cc: Kevin Tian <kevin.tian@intel.com>
>>>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>>> ---
>>>>    drivers/iommu/intel-pasid.c | 83
>>>> +++++++++++++++++++++++++++++++++++++++++++++
>>>> drivers/iommu/intel-pasid.h | 13 ++++++-
>>>> include/linux/intel-iommu.h |  2 ++ 3 files changed, 97
>>>> insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iommu/intel-pasid.c
>>>> b/drivers/iommu/intel-pasid.c index 040a445be300..76bcbb21e112
>>>> 100644 --- a/drivers/iommu/intel-pasid.c
>>>> +++ b/drivers/iommu/intel-pasid.c
>>>> @@ -63,6 +63,89 @@ void *intel_pasid_lookup_id(int pasid)
>>>>    	return p;
>>>>    }
>>>>    
>>>> +static int check_vcmd_pasid(struct intel_iommu *iommu)
>>>> +{
>>>> +	u64 cap;
>>>> +
>>>> +	if (!ecap_vcs(iommu->ecap)) {
>>>> +		pr_warn("IOMMU: %s: Hardware doesn't support
>>>> virtual command\n",
>>>> +			iommu->name);
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	cap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
>>>> +	if (!(cap & DMA_VCS_PAS)) {
>>>> +		pr_warn("IOMMU: %s: Emulation software doesn't
>>>> support PASID allocation\n",
>>>> +			iommu->name);
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int
>>>> *pasid) +{
>>>> +	u64 res;
>>>> +	u8 status_code;
>>>> +	unsigned long flags;
>>>> +	int ret = 0;
>>>> +
>>>> +	ret = check_vcmd_pasid(iommu);
>>>
>>> Do you have to check this everytime? every dmar_readq is going to
>>> trap to the other side ...
>>
>> Yes. We don't need to check it every time. Check once and save the
>> result during boot is enough.
>>
>> How about below incremental change?
>>
> Below is good but I was thinking to include vccap in struct
> intel_iommu{} where cap and ecaps reside. i.e.
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 14b87ae2916a..e2cf25c9c956 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -528,6 +528,7 @@ struct intel_iommu {
>          u64             reg_size; /* size of hw register set */
>          u64             cap;
>          u64             ecap;
> +       u64             vccap;
> 
> Also, we can use a static branch here.

Yeah! Good idea.

Best regards,
baolu
