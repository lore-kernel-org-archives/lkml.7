Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A75ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 01:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25D021D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 01:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389449AbfJYBqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 21:46:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:47340 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389252AbfJYBqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 21:46:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 18:46:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,226,1569308400"; 
   d="scan'208";a="197896687"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga007.fm.intel.com with ESMTP; 24 Oct 2019 18:46:35 -0700
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
Subject: Re: [PATCH v6 02/10] iommu/vt-d: Add custom allocator for IOASID
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1571788403-42095-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571788403-42095-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <20191023005129.GC100970@otc-nc-03>
 <0a0f33b8-e3d8-3d29-ca71-552f1875bc62@linux.intel.com>
 <20191023160152.07305918@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <85d806c3-0378-5f09-85fe-5c8f83c87c5f@linux.intel.com>
Date:   Fri, 25 Oct 2019 09:44:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023160152.07305918@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/24/19 7:01 AM, Jacob Pan wrote:
> On Wed, 23 Oct 2019 10:21:51 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>>>> +#ifdef CONFIG_INTEL_IOMMU_SVM
>>>
>>> Maybe move them to intel-svm.c instead? that's where the bulk
>>> of the svm support is?
>>
>> I think this is a generic PASID allocator for guest IOMMU although
>> vSVA is currently the only consumer. Instead of making it SVM
>> specific, I'd like to suggest moving it to intel-pasid.c and replace
>> the @svm parameter with a void * one in intel_ioasid_free().
> 
> make sense to use void*, no need to tie that to svm bind data type.
> 
> In terms of location, perhaps we can move if we have more consumers of
> custom allocator?
> 

Make sense to me.

Best regards,
baolu
