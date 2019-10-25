Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7199CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EB221D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440482AbfJYOmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:42:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:59444 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440461AbfJYOmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:42:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 07:41:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,229,1569308400"; 
   d="scan'208";a="223939301"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2019 07:41:57 -0700
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v7 03/11] iommu/vt-d: Add custom allocator for IOASID
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571946904-86776-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <ae437be4-e633-e670-0e1f-d07b4364f651@linux.intel.com>
 <20191024214311.43d76a5c@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D5CDC60@SHSMSX104.ccr.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e950cde8-8cd9-6089-c833-23d2ffb539d1@linux.intel.com>
Date:   Fri, 25 Oct 2019 22:39:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D5CDC60@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/25/19 2:40 PM, Tian, Kevin wrote:
>>>> ioasid_register_allocator(&iommu->pasid_allocator);
>>>> +			if (ret) {
>>>> +				pr_warn("Custom PASID allocator
>>>> registeration failed\n");
>>>> +				/*
>>>> +				 * Disable scalable mode on this
>>>> IOMMU if there
>>>> +				 * is no custom allocator. Mixing
>>>> SM capable vIOMMU
>>>> +				 * and non-SM vIOMMU are not
>>>> supported.
>>>> +				 */
>>>> +				intel_iommu_sm = 0;
>>> It's insufficient to disable scalable mode by only clearing
>>> intel_iommu_sm. The DMA_RTADDR_SMT bit in root entry has already
>> been
>>> set. Probably, you need to
>>>
>>> for each iommu
>>> 	clear DMA_RTADDR_SMT in root entry
>>>
>>> Alternatively, since vSVA is the only customer of this custom PASID
>>> allocator, is it possible to only disable SVA here?
>>>
>> Yeah, I think disable SVA is better. We can still do gIOVA in SM. I
>> guess we need to introduce a flag for sva_enabled.
> I'm not sure whether tying above logic to SVA is the right approach.
> If vcmd interface doesn't work, the whole SM mode doesn't make
> sense which is based on PASID-granular protection (SVA is only one
> usage atop). If the only remaining usage of SM is to map gIOVA using
> reserved PASID#0, then why not disabling SM and just fallback to
> legacy mode?
> 
> Based on that I prefer to disabling the SM mode completely (better
> through an interface), and move the logic out of CONFIG_INTEL_
> IOMMU_SVM
> 

Unfortunately, it is dangerous to disable SM after boot. SM uses
different root/device contexts and pasid table formats. Disabling SM
after boot requires changing above from SM format into legacy format.

Since ioasid registration failure is a rare case. How about moving this
part of code up to the early stage of intel_iommu_init() and returning
error if hardware present vcmd capability but software fails to register
a custom ioasid allocator?

Best regards,
baolu
