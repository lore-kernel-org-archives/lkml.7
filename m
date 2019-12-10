Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C33C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 01:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983B4207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 01:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfLJBOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 20:14:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:54998 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbfLJBOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 20:14:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 17:14:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,297,1571727600"; 
   d="scan'208";a="224979988"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 09 Dec 2019 17:14:50 -0800
Cc:     baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v5 0/8] VT-d Native Shared virtual memory cleanup and
 fixes
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1575316709-54903-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <20191209091415.0a733af6@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8a437e65-f380-d5c8-6615-a4d9d3ef1c56@linux.intel.com>
Date:   Tue, 10 Dec 2019 09:14:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209091415.0a733af6@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

This has been queued for internal test. I will forward it to Joerg if
everything goes well (probably around rc4).

Best regards,
-baolu

On 12/10/19 1:14 AM, Jacob Pan wrote:
> Hi Joerg and Baolu,
> 
> Any more comments on this series? I rebased it on v5.5-rc1 without
> changes.
> 
> 
> Thanks,
> 
> Jacob
> 
> On Mon,  2 Dec 2019 11:58:21 -0800
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
>> Mostly extracted from nested SVA/SVM series based on review comments
>> of v7. https://lkml.org/lkml/2019/10/24/852
>>
>> This series also adds a few important fixes for native use of SVA.
>> Nested SVA new code will be submitted separately as a smaller set.
>> Based on the core branch of IOMMU tree staged for v5.5, where common
>> APIs for vSVA were applied.
>> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git core
>>
>> Changelog:
>> v5	- Regrouped patch 6 and 8, added comments suggested by Joe
>> Perches v4	- Commit message fix
>>
>> V3
>> 	- Squashed 1/10 & 2/10
>> 	- Deleted "8/10 Fix PASID cache flush" from this series
>> 	- Addressed reviews from Eric Auger and Baolu
>> V2
>> 	- Coding style fixes based on Baolu's input, no functional
>> change
>> 	- Added Acked-by tags.
>>
>> Thanks,
>>
>> Jacob
>>
>>
>> *** BLURB HERE ***
>>
>> Jacob Pan (8):
>>    iommu/vt-d: Fix CPU and IOMMU SVM feature matching checks
>>    iommu/vt-d: Match CPU and IOMMU paging mode
>>    iommu/vt-d: Reject SVM bind for failed capability check
>>    iommu/vt-d: Avoid duplicated code for PASID setup
>>    iommu/vt-d: Fix off-by-one in PASID allocation
>>    iommu/vt-d: Replace Intel specific PASID allocator with IOASID
>>    iommu/vt-d: Avoid sending invalid page response
>>    iommu/vt-d: Misc macro clean up for SVM
>>
>>   drivers/iommu/Kconfig       |   1 +
>>   drivers/iommu/intel-iommu.c |  23 +++----
>>   drivers/iommu/intel-pasid.c |  96 ++++++++------------------
>>   drivers/iommu/intel-svm.c   | 163
>> +++++++++++++++++++++++++-------------------
>> include/linux/intel-iommu.h |   5 +- 5 files changed, 135
>> insertions(+), 153 deletions(-)
>>
> 
> [Jacob Pan]
> 
