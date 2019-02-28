Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2CA214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbfB1MTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:19:45 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46776 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfB1MTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:19:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BC7580D;
        Thu, 28 Feb 2019 04:19:44 -0800 (PST)
Received: from [10.1.197.2] (ostrya.cambridge.arm.com [10.1.197.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 957A53F575;
        Thu, 28 Feb 2019 04:19:42 -0800 (PST)
Subject: Re: [PATCH 1/1] iommu: Bind process address spaces to devices
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
References: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
 <20190220142759.33308-2-jean-philippe.brucker@arm.com>
 <20190226111743.GK20740@8bytes.org> <20190227134129.51ad42ac@jacob-builder>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <d25643d4-efb8-271a-2a58-3914c2124bbb@arm.com>
Date:   Thu, 28 Feb 2019 12:19:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190227134129.51ad42ac@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2019 21:41, Jacob Pan wrote:
> On Tue, 26 Feb 2019 12:17:43 +0100
> Joerg Roedel <joro@8bytes.org> wrote:
> 
>> Hi Jean-Philippe,
>>
>> Thanks for the patch! I think this is getting close to be applied
>> after the next merge window.
>>
>> On Wed, Feb 20, 2019 at 02:27:59PM +0000, Jean-Philippe Brucker wrote:
>>> +int iommu_sva_bind_device(struct device *dev, struct mm_struct
>>> *mm, int *pasid,
>>> +			  iommu_mm_exit_handler_t mm_exit, void
>>> *drvdata)  
>>
>> I think we are better of with introducing a sva-bind handle which can
>> be used to extend and further configure the binding done with this
>> function.
>>
>> How about a 'struct iommu_sva' with an iommu-private definition that
>> is returned by this function:
>>
>> 	struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>> 						struct mm_struct *mm);
>>
> Just trying to understand how to use this API.
> So if we bind the same mm to two different devices, we should get two
> different iommu_sva handle, right?

Yes, the iommu_sva handle is the bond between one mm and one device, so
you will get two different handles.

> I think intel-svm still needs a flag argument for supervisor pasid etc.
> Other than that, I think both interface should work for vt-d.

Is supervisor PASID still needed now that we have auxiliary domains, and
now that VT-d supports nested IOVA? You could have private kernel
address spaces through auxiliary domains, or simply use DMA API as usual
with PASID#0. I've been reluctant to make that feature common because it
looks risky - gives full access to the kernel address space to devices
and no notification on mapping change.

> Another question is that for nested SVA, we will need to bind guest mm.
> Do you think we should try to reuse this or have it separate? I am
> working on a separate API for now.

I also think it should be separate. That bind() operation is performed
on an auxiliary domain, I guess?

>> and the corresponding unbind function:
>>
>> 	int iommu_sva_unbind_device(struct iommu_sva* *handle);
>>
>> (Btw, does this need to return and int? Can unbinding fail?).
>>
>> With that in place we can implement and extentable API base on the
>> handle:
>>
>> 	int iommu_sva_get_pasid(struct iommu_sva *handle);
> If multiple bind to the same mm gets multiple handles, this API should
> retrieve the same pasid for different handle?

Yes

> Just curious why making
> the handle private instead of returning the pasid value in the handle?

I don't have a strong objection against that. One reason to have an
accessor is that the PASID is freed on mm_exit, so until the device
driver calls unbind(), the PASID contained in the handle is stale (and
the accessor returns PASID_INVALID). But that's a bit pedantic, the
device driver should know that the handle is stale since it got notified
of it. Having an accessor might also help tracking uses of the handle in
the kernel, and make future API modifications easier.

Thanks,
Jean

>> 	void iommu_sva_set_exit_handler(struct iommu_sva *handle,
>> 					iommu_mm_exit_handler_t
>> mm_exit);
>>
>> I think at least the AMD IOMMU driver needs more call-backs like a
>> handler that is invoked when a fault can not be resolved. And there
>> might be others in the future, putting them all in the parameter list
>> of the bind function doesn't scale well.
>>
> 
>> Regards,
>>
>> 	Joerg
> 
> 

