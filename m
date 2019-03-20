Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E20C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EC12175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfCTF61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:58:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:14491 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfCTF61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:58:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 22:58:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,247,1549958400"; 
   d="scan'208";a="128502849"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga006.jf.intel.com with ESMTP; 19 Mar 2019 22:58:23 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, xin.zeng@intel.com,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v7 9/9] vfio/type1: Handle different mdev isolation type
To:     Neo Jia <cjia@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20190222021927.13132-1-baolu.lu@linux.intel.com>
 <20190222021927.13132-10-baolu.lu@linux.intel.com>
 <20190307084453.GA9288@nvidia.com> <20190307165623.1834cc93@w520.home>
 <20190308180317.GA30821@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <939783f6-95e5-1413-8a2a-0e17c71110ef@linux.intel.com>
Date:   Wed, 20 Mar 2019 13:52:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190308180317.GA30821@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neo,

On 3/9/19 2:03 AM, Neo Jia wrote:
> On Thu, Mar 07, 2019 at 04:56:23PM -0700, Alex Williamson wrote:
>> On Thu, 7 Mar 2019 00:44:54 -0800
>> Neo Jia <cjia@nvidia.com> wrote:
>>
>>> On Fri, Feb 22, 2019 at 10:19:27AM +0800, Lu Baolu wrote:
>>>> This adds the support to determine the isolation type
>>>> of a mediated device group by checking whether it has
>>>> an iommu device. If an iommu device exists, an iommu
>>>> domain will be allocated and then attached to the iommu
>>>> device. Otherwise, keep the same behavior as it is.
>>>>
>>>> Cc: Ashok Raj <ashok.raj@intel.com>
>>>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>>> Cc: Kevin Tian <kevin.tian@intel.com>
>>>> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
>>>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>>>> ---
>>>>   drivers/vfio/vfio_iommu_type1.c | 48 ++++++++++++++++++++++++++++-----
>>>>   1 file changed, 41 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>>>> index ccc4165474aa..f1392c582a3c 100644
>>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>>> @@ -1368,13 +1368,40 @@ static void vfio_iommu_detach_group(struct vfio_domain *domain,
>>>>   		iommu_detach_group(domain->domain, group->iommu_group);
>>>>   }
>>>>     
>>>
>>> Hi Baolu,
>>>
>>> To allow IOMMU-awared mdev, I think you need to modify the
>>> vfio_iommu_type1_pin_pages and vfio_iommu_type1_unpin_pages to remove the
>>> iommu->external_domain check.
>>>
>>> Could you please include that in your patch? If not, I can send out a separate
>>> patch to address that issue.
>>
>> I figured it was intentional that an IOMMU backed mdev would not use
>> the pin/unpin interface and therefore the exiting -EINVAL returns would
>> be correct.  Can you elaborate on the use case for still requiring the
>> mdev pin/unpin interface for these devices?  Thanks,
> 
> Sure. We are using this api to fetch a pfn of a guest physical address so we can
> access it for PV.

Okay, I will remove these two checks in the next version.

Best regards,
Lu Baolu
