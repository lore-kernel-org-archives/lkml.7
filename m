Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67838CA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 01:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F5C21928
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 01:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389372AbfJYBpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 21:45:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:50609 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389344AbfJYBpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 21:45:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 18:45:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,226,1569308400"; 
   d="scan'208";a="197896429"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga007.fm.intel.com with ESMTP; 24 Oct 2019 18:45:16 -0700
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
 <20191023141126.38bc1644@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d5f68e37-adba-0804-904b-660e8e812ece@linux.intel.com>
Date:   Fri, 25 Oct 2019 09:42:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023141126.38bc1644@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/24/19 5:11 AM, Jacob Pan wrote:
> On Wed, 23 Oct 2019 10:55:23 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
>>>> Do you have to check this everytime? every dmar_readq is going to
>>>> trap to the other side ...
>>>
>>> Yes. We don't need to check it every time. Check once and save the
>>> result during boot is enough.
>>>
>>> How about below incremental change?
>>>    
>> Below is good but I was thinking to include vccap in struct
>> intel_iommu{} where cap and ecaps reside. i.e.
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index 14b87ae2916a..e2cf25c9c956 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -528,6 +528,7 @@ struct intel_iommu {
>>          u64             reg_size; /* size of hw register set */
>>          u64             cap;
>>          u64             ecap;
>> +       u64             vccap;
>>
>> Also, we can use a static branch here.
>>
> On a second thought, we cannot use static(branch) here in that we
> cannot assume there is only one vIOMMU all the time. Have to cache the
> vccap per iommu.

intel_iommu is a per iommu structure, right? Or I missed anything?

> 
>>> diff --git a/drivers/iommu/intel-pasid.c
>>> b/drivers/iommu/intel-pasid.c index ff7e877b7a4d..c15d9d7e1e73
>>> 100644 --- a/drivers/iommu/intel-pasid.c
>>> +++ b/drivers/iommu/intel-pasid.c
>>> @@ -29,22 +29,29 @@ u32 intel_pasid_max_id = PASID_MAX;
>>>
> [Jacob Pan]
> 

Best regards,
baolu
