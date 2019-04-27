Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4BFC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E9A206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfD0Iiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 04:38:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfD0Iiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 04:38:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95541368B1;
        Sat, 27 Apr 2019 08:38:53 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7863E600CD;
        Sat, 27 Apr 2019 08:38:48 +0000 (UTC)
Subject: Re: [PATCH v2 11/19] iommu/vt-d: Replace Intel specific PASID
 allocator with IOASID
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-12-git-send-email-jacob.jun.pan@linux.intel.com>
 <e542fd95-acbe-05e9-e441-27dff752c21a@redhat.com>
 <20190426140133.6d445315@jacob-builder>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <f06a9675-278f-51db-f385-e1305b3795d6@redhat.com>
Date:   Sat, 27 Apr 2019 10:38:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190426140133.6d445315@jacob-builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sat, 27 Apr 2019 08:38:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/19 11:01 PM, Jacob Pan wrote:
> On Thu, 25 Apr 2019 12:04:01 +0200
> Auger Eric <eric.auger@redhat.com> wrote:
> 
>> Hi Jacob,
>>
>> On 4/24/19 1:31 AM, Jacob Pan wrote:
>>> Make use of generic IOASID code to manage PASID allocation,
>>> free, and lookup.
>>>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> ---
>>>  drivers/iommu/Kconfig       |  1 +
>>>  drivers/iommu/intel-iommu.c |  9 ++++-----
>>>  drivers/iommu/intel-pasid.c | 36
>>> ------------------------------------ drivers/iommu/intel-svm.c   |
>>> 41 ++++++++++++++++++++++++----------------- 4 files changed, 29
>>> insertions(+), 58 deletions(-)
>>>
>>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>> index 6f07f3b..7f92009 100644
>>> --- a/drivers/iommu/Kconfig
>>> +++ b/drivers/iommu/Kconfig
>>> @@ -204,6 +204,7 @@ config INTEL_IOMMU_SVM
>>>  	bool "Support for Shared Virtual Memory with Intel IOMMU"
>>>  	depends on INTEL_IOMMU && X86
>>>  	select PCI_PASID
>>> +	select IOASID
>>>  	select MMU_NOTIFIER
>>>  	help
>>>  	  Shared Virtual Memory (SVM) provides a facility for
>>> devices diff --git a/drivers/iommu/intel-iommu.c
>>> b/drivers/iommu/intel-iommu.c index ec6f22d..785330a 100644
>>> --- a/drivers/iommu/intel-iommu.c
>>> +++ b/drivers/iommu/intel-iommu.c
>>> @@ -5153,7 +5153,7 @@ static void auxiliary_unlink_device(struct
>>> dmar_domain *domain, domain->auxd_refcnt--;
>>>  
>>>  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
>>> -		intel_pasid_free_id(domain->default_pasid);
>>> +		ioasid_free(domain->default_pasid);
>>>  }
>>>  
>>>  static int aux_domain_add_dev(struct dmar_domain *domain,
>>> @@ -5171,9 +5171,8 @@ static int aux_domain_add_dev(struct
>>> dmar_domain *domain, if (domain->default_pasid <= 0) {
>>>  		int pasid;
>>>  
>>> -		pasid = intel_pasid_alloc_id(domain, PASID_MIN,
>>> -
>>> pci_max_pasids(to_pci_dev(dev)),
>>> -					     GFP_KERNEL);
>>> +		pasid = ioasid_alloc(NULL, PASID_MIN,
>>> pci_max_pasids(to_pci_dev(dev)) - 1,
>>> +				domain);
>>>  		if (pasid <= 0) {  
>> ioasid_t is a uint and returns INVALID_IOASID on error. Wouldn't it be
>> simpler to make ioasid_alloc return an int?
> Well, I think we still want the full uint range - 1(INVALID_IOASID).
> Intel uses 20bit but I think SMMUs use 32 bits for streamID? I
> should just check 
> 	if (pasid == INVALID_IOASID) {
Jean-Philippe may correct me but SMMU uses 20b SubstreamId which is a
superset of PASIDs. StreamId is 32b.
> 
>>>  			pr_err("Can't allocate default pasid\n");
>>>  			return -ENODEV;
>>> @@ -5210,7 +5209,7 @@ static int aux_domain_add_dev(struct
>>> dmar_domain *domain, spin_unlock(&iommu->lock);
>>>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>>>  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
>>> -		intel_pasid_free_id(domain->default_pasid);
>>> +		ioasid_free(domain->default_pasid);
>>>  
>>>  	return ret;
>>>  }
>>> diff --git a/drivers/iommu/intel-pasid.c
>>> b/drivers/iommu/intel-pasid.c index 5b1d3be..d339e8f 100644
>>> --- a/drivers/iommu/intel-pasid.c
>>> +++ b/drivers/iommu/intel-pasid.c
>>> @@ -26,42 +26,6 @@
>>>   */
>>>  static DEFINE_SPINLOCK(pasid_lock);
>>>  u32 intel_pasid_max_id = PASID_MAX;
>>> -static DEFINE_IDR(pasid_idr);
>>> -
>>> -int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp)
>>> -{
>>> -	int ret, min, max;
>>> -
>>> -	min = max_t(int, start, PASID_MIN);
>>> -	max = min_t(int, end, intel_pasid_max_id);
>>> -
>>> -	WARN_ON(in_interrupt());
>>> -	idr_preload(gfp);
>>> -	spin_lock(&pasid_lock);
>>> -	ret = idr_alloc(&pasid_idr, ptr, min, max, GFP_ATOMIC);
>>> -	spin_unlock(&pasid_lock);
>>> -	idr_preload_end();
>>> -
>>> -	return ret;
>>> -}
>>> -
>>> -void intel_pasid_free_id(int pasid)
>>> -{
>>> -	spin_lock(&pasid_lock);
>>> -	idr_remove(&pasid_idr, pasid);
>>> -	spin_unlock(&pasid_lock);
>>> -}
>>> -
>>> -void *intel_pasid_lookup_id(int pasid)
>>> -{
>>> -	void *p;
>>> -
>>> -	spin_lock(&pasid_lock);
>>> -	p = idr_find(&pasid_idr, pasid);
>>> -	spin_unlock(&pasid_lock);
>>> -
>>> -	return p;
>>> -}
>>>  
>>>  int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int
>>> *pasid) {
>>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
>>> index 8f87304..8fff212 100644
>>> --- a/drivers/iommu/intel-svm.c
>>> +++ b/drivers/iommu/intel-svm.c
>>> @@ -25,6 +25,7 @@
>>>  #include <linux/dmar.h>
>>>  #include <linux/interrupt.h>
>>>  #include <linux/mm_types.h>
>>> +#include <linux/ioasid.h>
>>>  #include <asm/page.h>
>>>  
>>>  #include "intel-pasid.h"
>>> @@ -211,7 +212,9 @@ static void intel_mm_release(struct
>>> mmu_notifier *mn, struct mm_struct *mm) rcu_read_lock();
>>>  	list_for_each_entry_rcu(sdev, &svm->devs, list) {
>>>  		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
>>> svm->pasid);
>>> -		intel_flush_svm_range_dev(svm, sdev, 0, -1,
>>> 0, !svm->mm)> +		/* for emulated iommu, PASID cache
>>> invalidation implies IOTLB/DTLB */
>>> +		if (!cap_caching_mode(svm->iommu->cap))
>>> +			intel_flush_svm_range_dev(svm, sdev, 0,
>>> -1, 0, !svm->mm);  
>> This change is not documented in the commit message. Isn't it a
>> separate fix?
> right, should be separate.
> 
>>>  	}
>>>  	rcu_read_unlock();
>>>  
>>> @@ -332,16 +335,15 @@ int intel_svm_bind_mm(struct device *dev, int
>>> *pasid, int flags, struct svm_dev_ if (pasid_max >
>>> intel_pasid_max_id) pasid_max = intel_pasid_max_id;
>>>  
>>> -		/* Do not use PASID 0 in caching mode (virtualised
>>> IOMMU) */
>>> -		ret = intel_pasid_alloc_id(svm,
>>> -					   !!cap_caching_mode(iommu->cap),
>>> -					   pasid_max - 1,
>>> GFP_KERNEL);
>>> -		if (ret < 0) {
>>> +		/* Do not use PASID 0, reserved for RID to PASID */
>>> +		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
>>> +					pasid_max - 1, svm);  
>> the fact the max is not decremented compared to intel_pasid_alloc_id
>> looks suspicious to me (exclusive to inclusive move). I guess it is a
>> fix in which case this may be documented in the commit msg?
> Yes, it should be in separate patch.
> 
> VT-d will always support device with full 20bit PASID range only, we
> should fail svm_bind if device pasid_max < 20. It has to be
> included in this series otherwise we could have assigned a device with <
> 20 PASID and our virtual command can only handle full 20bit.
OK

Thanks

Eric
> 
>>> +		if (svm->pasid == INVALID_IOASID) {
>>>  			kfree(svm);
>>>  			kfree(sdev);
>>> +			ret = ENOSPC;  
>> -ENOSPC
>>>  			goto out;
>>>  		}
>>> -		svm->pasid = ret;
>>>  		svm->notifier.ops = &intel_mmuops;
>>>  		svm->mm = mm;
>>>  		svm->flags = flags;
>>> @@ -351,7 +353,7 @@ int intel_svm_bind_mm(struct device *dev, int
>>> *pasid, int flags, struct svm_dev_ if (mm) {
>>>  			ret =
>>> mmu_notifier_register(&svm->notifier, mm); if (ret) {
>>> -				intel_pasid_free_id(svm->pasid);
>>> +				ioasid_free(svm->pasid);
>>>  				kfree(svm);
>>>  				kfree(sdev);
>>>  				goto out;
>>> @@ -367,7 +369,7 @@ int intel_svm_bind_mm(struct device *dev, int
>>> *pasid, int flags, struct svm_dev_ if (ret) {
>>>  			if (mm)
>>>  				mmu_notifier_unregister(&svm->notifier,
>>> mm);
>>> -			intel_pasid_free_id(svm->pasid);
>>> +			ioasid_free(svm->pasid);  
>> the ioasid_free returned value never is tested. Is it useful?
>>>  			kfree(svm);
>>>  			kfree(sdev);
>>>  			goto out;
>>> @@ -400,7 +402,12 @@ int intel_svm_unbind_mm(struct device *dev,
>>> int pasid) if (!iommu)
>>>  		goto out;
>>>  
>>> -	svm = intel_pasid_lookup_id(pasid);
>>> +	svm = ioasid_find(NULL, pasid, NULL);
>>> +	if (IS_ERR(svm)) {
>>> +		ret = PTR_ERR(svm);
>>> +		goto out;
>>> +	}
>>> +
>>>  	if (!svm)
>>>  		goto out;
>>>  
>>> @@ -422,7 +429,7 @@ int intel_svm_unbind_mm(struct device *dev, int
>>> pasid) kfree_rcu(sdev, rcu);
>>>  
>>>  				if (list_empty(&svm->devs)) {
>>> -
>>> intel_pasid_free_id(svm->pasid);
>>> +					ioasid_free(svm->pasid);
>>>  					if (svm->mm)
>>>  						mmu_notifier_unregister(&svm->notifier,
>>> svm->mm); 
>>> @@ -457,10 +464,11 @@ int intel_svm_is_pasid_valid(struct device
>>> *dev, int pasid) if (!iommu)
>>>  		goto out;
>>>  
>>> -	svm = intel_pasid_lookup_id(pasid);
>>> -	if (!svm)
>>> +	svm = ioasid_find(NULL, pasid, NULL);
>>> +	if (IS_ERR(svm)) {
>>> +		ret = PTR_ERR(svm);
>>>  		goto out;
>>> -
>>> +	}
>>>  	/* init_mm is used in this case */
>>>  	if (!svm->mm)
>>>  		ret = 1;
>>> @@ -567,13 +575,12 @@ static irqreturn_t prq_event_thread(int irq,
>>> void *d) 
>>>  		if (!svm || svm->pasid != req->pasid) {
>>>  			rcu_read_lock();
>>> -			svm = intel_pasid_lookup_id(req->pasid);
>>> +			svm = ioasid_find(NULL, req->pasid, NULL);
>>>  			/* It *can't* go away, because the driver
>>> is not permitted
>>>  			 * to unbind the mm while any page faults
>>> are outstanding.
>>>  			 * So we only need RCU to protect the
>>> internal idr code. */ rcu_read_unlock();
>>> -
>>> -			if (!svm) {
>>> +			if (IS_ERR(svm) || !svm) {
>>>  				pr_err("%s: Page request for
>>> invalid PASID %d: %08llx %08llx\n", iommu->name, req->pasid,
>>> ((unsigned long long *)req)[0], ((unsigned long long *)req)[1]);
>>>   
>>
>> Thanks
>>
>> Eric
> 
> [Jacob Pan]
> 
