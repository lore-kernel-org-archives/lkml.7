Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AD9C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDFC2173B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfEIQLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:11:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45454 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbfEIQLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:11:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47635374;
        Thu,  9 May 2019 09:11:46 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC37C3F6C4;
        Thu,  9 May 2019 09:11:44 -0700 (PDT)
Subject: Re: [PATCH v3 1/8] iommu: Add ops entry for supported default domain
 type
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <tmurphy@arista.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
        David Woodhouse <dwmw2@infradead.org>
References: <20190429020925.18136-1-baolu.lu@linux.intel.com>
 <20190429020925.18136-2-baolu.lu@linux.intel.com>
 <CAPL0++4Q7p7gWRUF5vG5sazLNCmSR--Px-=OEtj6vm_gEpB_ng@mail.gmail.com>
 <bba1f327-21b7-ed3c-8fd4-217ad97a6a7c@arm.com>
 <3e0da076-4916-1a02-615c-927c1b3528b8@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <56205a21-c72f-a460-77a2-4bb4f46f6e08@arm.com>
Date:   Thu, 9 May 2019 17:11:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3e0da076-4916-1a02-615c-927c1b3528b8@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2019 03:30, Lu Baolu wrote:
> Hi Robin,
> 
> On 5/7/19 6:28 PM, Robin Murphy wrote:
>> On 06/05/2019 16:32, Tom Murphy via iommu wrote:
>>> The AMD driver already solves this problem and uses the generic
>>> iommu_request_dm_for_dev function. It seems like both drivers have the
>>> same problem and could use the same solution. Is there any reason we
>>> can't have use the same solution for the intel and amd driver?
>>>
>>> Could we just  copy the implementation of the AMD driver? It would be
>>> nice to have the same behavior across both drivers especially as we
>>> move to make both drivers use more generic code.
>>
>> TBH I don't think the API really needs to be involved at all here. 
>> Drivers can already not provide the requested default domain type if 
>> they don't support it, so as long as the driver can ensure that the 
>> device ends up with IOMMU or direct DMA ops as appropriate, I don't 
>> see any great problem with drivers just returning a passthrough domain 
>> when a DMA domain was requested, or vice versa (and logging a message 
>> that the requested type was overridden). The only type that we really 
>> do have to honour strictly is non-default (i.e. unmanaged) domains.
> 
> I agree with you that we only have to honor strictly the non-default
> domains. But domain type saved in iommu_domain is consumed in iommu.c
> and exposed to user through sysfs. It's not clean if the iommu driver
> silently replace the default domain.

Right, I did get a bit ahead of myself there - the implicit step before 
that is to fix default domain allocation so that the core actually 
passes the relevant device which it has to hand, such that the IOMMU 
drivers *can* make the right decision up-front.

Robin.
