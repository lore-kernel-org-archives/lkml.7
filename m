Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C16C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B8E2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403911AbfFKFu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 01:50:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:38117 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403879AbfFKFux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:50:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 22:50:51 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga004.jf.intel.com with ESMTP; 10 Jun 2019 22:50:49 -0700
Cc:     baolu.lu@linux.intel.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, "cai@lca.pw" <cai@lca.pw>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 5/6] iommu/vt-d: Cleanup after delegating DMA domain to
 generic iommu
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
References: <20190609023803.23832-1-baolu.lu@linux.intel.com>
 <20190609023803.23832-6-baolu.lu@linux.intel.com>
 <1560192412.27481.12.camel@intel.com>
 <dbd8a4dcc9de6e7b3232c6c90597939a794860b9.camel@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e7e4af38-97ab-9f15-4072-654f704c9f31@linux.intel.com>
Date:   Tue, 11 Jun 2019 13:43:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <dbd8a4dcc9de6e7b3232c6c90597939a794860b9.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/11/19 3:25 AM, Sai Praneeth Prakhya wrote:
> On Mon, 2019-06-10 at 11:45 -0700, Mehta, Sohil wrote:
>> On Sun, 2019-06-09 at 10:38 +0800, Lu Baolu wrote:
>>>   static int __init si_domain_init(int hw)
>>> @@ -3306,14 +3252,13 @@ static int __init init_dmars(void)
>>>                  if (pasid_supported(iommu))
>>>                          intel_svm_init(iommu);
>>>   #endif
>>> -       }
>>>   
>>> -       /*
>>> -        * Now that qi is enabled on all iommus, set the root entry
>>> and flush
>>> -        * caches. This is required on some Intel X58 chipsets,
>>> otherwise the
>>> -        * flush_context function will loop forever and the boot
>>> hangs.
>>> -        */
>>> -       for_each_active_iommu(iommu, drhd) {
>>> +               /*
>>> +                * Now that qi is enabled on all iommus, set the root
>>> entry and
>>> +                * flush caches. This is required on some Intel X58
>>> chipsets,
>>> +                * otherwise the flush_context function will loop
>>> forever and
>>> +                * the boot hangs.
>>> +                */
>>>                  iommu_flush_write_buffer(iommu);
>>>                  iommu_set_root_entry(iommu);
>>>                  iommu->flush.flush_context(iommu, 0, 0, 0,
>>> DMA_CCMD_GLOBAL_INVL);
>>
>> This changes the intent of the original code. As the comment says
>> enable QI on all IOMMUs, then flush the caches and set the root entry.
>> The order of setting the root entries has changed now.
>>
>> Refer:
>> Commit a4c34ff1c029 ('iommu/vt-d: Enable QI on all IOMMUs before
>> setting root entry')
> 
> Thanks Sohil! for catching the bug.
> Will send a V2 to Lu Baolu fixing this.

Okay, I will submit a v2 of this series later.

> 
> Regards,
> Sai

Best regards,
Baolu
