Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DD5C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 05:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4F42175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 05:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfEJFgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 01:36:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:1335 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfEJFgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 01:36:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 May 2019 22:36:01 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga008.fm.intel.com with ESMTP; 09 May 2019 22:35:59 -0700
Cc:     baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3 1/8] iommu: Add ops entry for supported default domain
 type
To:     Robin Murphy <robin.murphy@arm.com>,
        Tom Murphy <tmurphy@arista.com>
References: <20190429020925.18136-1-baolu.lu@linux.intel.com>
 <20190429020925.18136-2-baolu.lu@linux.intel.com>
 <CAPL0++4Q7p7gWRUF5vG5sazLNCmSR--Px-=OEtj6vm_gEpB_ng@mail.gmail.com>
 <bba1f327-21b7-ed3c-8fd4-217ad97a6a7c@arm.com>
 <3e0da076-4916-1a02-615c-927c1b3528b8@linux.intel.com>
 <56205a21-c72f-a460-77a2-4bb4f46f6e08@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6dbbfc10-3247-744c-ae8d-443a336e0c50@linux.intel.com>
Date:   Fri, 10 May 2019 13:29:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <56205a21-c72f-a460-77a2-4bb4f46f6e08@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 5/10/19 12:11 AM, Robin Murphy wrote:
> On 09/05/2019 03:30, Lu Baolu wrote:
>> Hi Robin,
>>
>> On 5/7/19 6:28 PM, Robin Murphy wrote:
>>> On 06/05/2019 16:32, Tom Murphy via iommu wrote:
>>>> The AMD driver already solves this problem and uses the generic
>>>> iommu_request_dm_for_dev function. It seems like both drivers have the
>>>> same problem and could use the same solution. Is there any reason we
>>>> can't have use the same solution for the intel and amd driver?
>>>>
>>>> Could we just  copy the implementation of the AMD driver? It would be
>>>> nice to have the same behavior across both drivers especially as we
>>>> move to make both drivers use more generic code.
>>>
>>> TBH I don't think the API really needs to be involved at all here. 
>>> Drivers can already not provide the requested default domain type if 
>>> they don't support it, so as long as the driver can ensure that the 
>>> device ends up with IOMMU or direct DMA ops as appropriate, I don't 
>>> see any great problem with drivers just returning a passthrough 
>>> domain when a DMA domain was requested, or vice versa (and logging a 
>>> message that the requested type was overridden). The only type that 
>>> we really do have to honour strictly is non-default (i.e. unmanaged) 
>>> domains.
>>
>> I agree with you that we only have to honor strictly the non-default
>> domains. But domain type saved in iommu_domain is consumed in iommu.c
>> and exposed to user through sysfs. It's not clean if the iommu driver
>> silently replace the default domain.
> 
> Right, I did get a bit ahead of myself there - the implicit step before 
> that is to fix default domain allocation so that the core actually 
> passes the relevant device which it has to hand, such that the IOMMU 
> drivers *can* make the right decision up-front.
> 

Yes, passing the relevant device when allocating the default domain so
that the IOMMU driver could make right decision seems to be a better
solution. Somebody can come up with a patch set to bring this up for
discussion. I won't include this in this patch set since it's not for
that purpose. I will follow the existing mechanism that is using on amd
and other iommu drivers.

Best regards,
Lu Baolu
