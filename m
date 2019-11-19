Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709D5C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 03:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA2622316
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 03:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfKSDJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 22:09:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:21052 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfKSDJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 22:09:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 19:09:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="204265404"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga008.fm.intel.com with ESMTP; 18 Nov 2019 19:09:13 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 04/10] iommu/vt-d: Match CPU and IOMMU paging mode
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Auger Eric <eric.auger@redhat.com>
References: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1574106153-45867-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <601ca9c3-9f83-3d95-8d26-d4f46eee82ba@redhat.com>
 <20191118135238.49f5d957@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ad3c3d58-dd1a-4b83-8b30-31e5be9e9c39@linux.intel.com>
Date:   Tue, 19 Nov 2019 11:06:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118135238.49f5d957@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric and Jacob,

On 11/19/19 5:52 AM, Jacob Pan wrote:
> On Mon, 18 Nov 2019 21:55:03 +0100
> Auger Eric <eric.auger@redhat.com> wrote:
> 
>> Hi Jacob,
>>
>> On 11/18/19 8:42 PM, Jacob Pan wrote:
>>> When setting up first level page tables for sharing with CPU, we
>>> need to ensure IOMMU can support no less than the levels supported
>>> by the CPU.
>>> It is not adequate, as in the current code, to set up 5-level paging
>>> in PASID entry First Level Paging Mode(FLPM) solely based on CPU.
>>>
>>> Fixes: 437f35e1cd4c8 ("iommu/vt-d: Add first level page table
>>> interface")
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> ---
>>>   drivers/iommu/intel-pasid.c | 12 ++++++++++--
>>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel-pasid.c
>>> b/drivers/iommu/intel-pasid.c index 040a445be300..e7cb0b8a7332
>>> 100644 --- a/drivers/iommu/intel-pasid.c
>>> +++ b/drivers/iommu/intel-pasid.c
>>> @@ -499,8 +499,16 @@ int intel_pasid_setup_first_level(struct
>>> intel_iommu *iommu, }
>>>   
>>>   #ifdef CONFIG_X86
>>> -	if (cpu_feature_enabled(X86_FEATURE_LA57))
>>> -		pasid_set_flpm(pte, 1);
>>> +	/* Both CPU and IOMMU paging mode need to match */
>>> +	if (cpu_feature_enabled(X86_FEATURE_LA57)) {
>>> +		if (cap_5lp_support(iommu->cap)) {
>>> +			pasid_set_flpm(pte, 1);
>>> +		} else {
>>> +			pr_err("VT-d has no 5-level paging support
>>> for CPU\n");
>>> +			pasid_clear_entry(pte);
>>> +			return -EINVAL;
>> Can it happen? If I am not wrong intel_pasid_setup_first_level() only
>> seems to be called from intel_svm_bind_mm which now checks the
>> SVM_CAPABLE flag.
>>
> You are right, this check is not needed any more. I will drop the patch.
>> Thanks

I'd suggest to keep this. This helper is not only for svm, although
currently svm is the only caller. For first level pasid setup, let's
set an assumption that hardware should never report mismatching paging
modes, this is helpful especially when running vIOMMU in VM guests.

Best regards,
baolu
