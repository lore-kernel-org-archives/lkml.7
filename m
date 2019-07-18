Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2D1C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26ABA2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389169AbfGRHrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 03:47:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfGRHrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 03:47:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 129253082145;
        Thu, 18 Jul 2019 07:47:12 +0000 (UTC)
Received: from [10.36.116.38] (ovpn-116-38.ams2.redhat.com [10.36.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0252810021B2;
        Thu, 18 Jul 2019 07:47:04 +0000 (UTC)
Subject: Re: [PATCH v4 20/22] iommu/vt-d: Add bind guest PASID support
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yi L <yi.l.liu@linux.intel.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1560087862-57608-21-git-send-email-jacob.jun.pan@linux.intel.com>
 <2c5a7686-aef7-f98f-cb1c-8e0eb31b2bfa@redhat.com>
 <20190716170453.GA54873@otc-nc-03>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <2e1aebd1-6fcd-3fa4-acce-04e79746e38a@redhat.com>
Date:   Thu, 18 Jul 2019 09:47:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190716170453.GA54873@otc-nc-03>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 18 Jul 2019 07:47:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ashok,

On 7/16/19 7:04 PM, Raj, Ashok wrote:
> Hi Eric
> 
> Jacob is on sabbatical, so i'll give it my best shot :-)
> 
> Yi/Kevin can jump in...
> 
> On Tue, Jul 16, 2019 at 06:45:51PM +0200, Auger Eric wrote:
>> Hi Jacob,
>>
>> On 6/9/19 3:44 PM, Jacob Pan wrote:
>>> When supporting guest SVA with emulated IOMMU, the guest PASID
>>> table is shadowed in VMM. Updates to guest vIOMMU PASID table
>>> will result in PASID cache flush which will be passed down to
>>> the host as bind guest PASID calls.
>>>
>>> For the SL page tables, it will be harvested from device's
>>> default domain (request w/o PASID), or aux domain in case of
>>> mediated device.
>>>
>>>     .-------------.  .---------------------------.
>>>     |   vIOMMU    |  | Guest process CR3, FL only|
>>>     |             |  '---------------------------'
>>>     .----------------/
>>>     | PASID Entry |--- PASID cache flush -
>>>     '-------------'                       |
>>>     |             |                       V
>>>     |             |                CR3 in GPA
>>>     '-------------'
>>> Guest
>>> ------| Shadow |--------------------------|--------
>>>       v        v                          v
>>> Host
>>>     .-------------.  .----------------------.
>>>     |   pIOMMU    |  | Bind FL for GVA-GPA  |
>>>     |             |  '----------------------'
>>>     .----------------/  |
>>>     | PASID Entry |     V (Nested xlate)
>>>     '----------------\.------------------------------.
>>>     |             |   |SL for GPA-HPA, default domain|
>>>     |             |   '------------------------------'
>>>     '-------------'
>>> Where:
>>>  - FL = First level/stage one page tables
>>>  - SL = Second level/stage two page tables
>>>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
>>> ---
>>>  drivers/iommu/intel-iommu.c |   4 +
>>>  drivers/iommu/intel-svm.c   | 187 ++++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/intel-iommu.h |  13 ++-
>>>  include/linux/intel-svm.h   |  17 ++++
>>>  4 files changed, 219 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>>> index 7cfa0eb..3b4d712 100644
>>> --- a/drivers/iommu/intel-iommu.c
>>> +++ b/drivers/iommu/intel-iommu.c
>>> @@ -5782,6 +5782,10 @@ const struct iommu_ops intel_iommu_ops = {
>>>  	.dev_enable_feat	= intel_iommu_dev_enable_feat,
>>>  	.dev_disable_feat	= intel_iommu_dev_disable_feat,
>>>  	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
>>> +#ifdef CONFIG_INTEL_IOMMU_SVM
>>> +	.sva_bind_gpasid	= intel_svm_bind_gpasid,
>>> +	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
>>> +#endif
>>>  };
>>>  
>>>  static void quirk_iommu_g4x_gfx(struct pci_dev *dev)
>>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
>>> index 66d98e1..f06a82f 100644
>>> --- a/drivers/iommu/intel-svm.c
>>> +++ b/drivers/iommu/intel-svm.c
>>> @@ -229,6 +229,193 @@ static LIST_HEAD(global_svm_list);
>>>  	list_for_each_entry(sdev, &svm->devs, list)	\
>>>  	if (dev == sdev->dev)				\
>>>  
>>> +int intel_svm_bind_gpasid(struct iommu_domain *domain,
>>> +			struct device *dev,
>>> +			struct gpasid_bind_data *data)
>>> +{
>>> +	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
>>> +	struct intel_svm_dev *sdev;
>>> +	struct intel_svm *svm = NULL;
>> not requested
>>> +	struct dmar_domain *ddomain;
>>> +	int ret = 0;
>>> +
>>> +	if (WARN_ON(!iommu) || !data)
>>> +		return -EINVAL;
>>> +
>>> +	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
>>> +		data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
>>> +		return -EINVAL;
>>> +
>>> +	if (dev_is_pci(dev)) {
>>> +		/* VT-d supports devices with full 20 bit PASIDs only */
>>> +		if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
>>> +			return -EINVAL;
>>> +	}
>>> +
>>> +	/*
>>> +	 * We only check host PASID range, we have no knowledge to check
>>> +	 * guest PASID range nor do we use the guest PASID.
>> guest pasid is set below in svm->gpasid.
>> So I am confused, do you handle gpasid or not? If you don't use gpasid
>> at the moment, then you may return -EINVAL if data->flags &
>> IOMMU_SVA_GPASID_VAL.
>>
>> I confess I don't really understand gpasid as I thought you use
>> enlightened PASID allocation to use a system wide PASID allocator on
>> host so in which case guest and host PASID do differ?
> 
> Correct, from within the guest, we only use the enlightned allocator.
> 
> Guest PASID can be managed via Qemu, and it will also associate
> guest pasid's with appropriate host pasids. Sort of how guest bdf
> and host bdf are managed for page-request etc.

OK I will look at the QEMU side then.

Thanks

Eric
> 
