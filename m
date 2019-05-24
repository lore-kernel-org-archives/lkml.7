Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880B4C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2C920675
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390514AbfEXQO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 12:14:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46150 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389588AbfEXQO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 12:14:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D24F180D;
        Fri, 24 May 2019 09:14:56 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A3733F575;
        Fri, 24 May 2019 09:14:55 -0700 (PDT)
Subject: Re: [PATCH 2/4] iommu: Introduce device fault data
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     yi.l.liu@linux.intel.com, ashok.raj@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com
References: <20190523180613.55049-1-jean-philippe.brucker@arm.com>
 <20190523180613.55049-3-jean-philippe.brucker@arm.com>
 <791fe9b1-5d85-fd2d-7cfb-c2fb3428deb6@arm.com>
 <20190524064924.0cc92ae3@jacob-builder>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <3f512c57-de7c-dc3b-049c-2c4745757636@arm.com>
Date:   Fri, 24 May 2019 17:14:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524064924.0cc92ae3@jacob-builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2019 14:49, Jacob Pan wrote:
> On Thu, 23 May 2019 19:43:46 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
>>> +/**
>>> + * struct iommu_fault_event - Generic fault event
>>> + *
>>> + * Can represent recoverable faults such as a page requests or
>>> + * unrecoverable faults such as DMA or IRQ remapping faults.
>>> + *
>>> + * @fault: fault descriptor
>>> + * @iommu_private: used by the IOMMU driver for storing
>>> fault-specific
>>> + *                 data. Users should not modify this field before
>>> + *                 sending the fault response.  
>>
>> Sorry if I'm a bit late to the party, but given that description, if 
>> users aren't allowed to touch this then why expose it to them at all? 
>> I.e. why not have iommu_report_device_fault() pass just the fault
>> itself to the fault handler:
>>
>> 	ret = fparam->handler(&evt->fault, fparam->data);
>>
>> and let the IOMMU core/drivers decapsulate it again later if need be. 
>> AFAICS drivers could also just embed the entire generic event in
>> their own private structure anyway, just as we do for domains.
>>
> I can't remember all the discussion history but I think iommu_private
> is used similarly to the page request private data (device private).

Hm yes, we already have iommu_fault_page_request::private_data for that.
I think I used to stash flags in iommu_private (is_stall and
needs_pasid), so that the SMMUv3 driver doesn't need to go fetch them
from the device structure, but I removed them. If VT-d doesn't need
iommu_private either, maybe we can remove it entirely?

In any case I agree that device drivers should only need to know about
evt->fault.

> We
> need to inject the data to the guest and the guest will send the
> unmodified data back along with response.

By the way, does private_data need to go back through the
iommu_page_response() path? The current series doesn't do that.

> The private data can be used
> to tag internal device/iommu context.

> I think we can do the way you said by keeping them within iommu core
> and recover it based on the response but that would require tracking
> each fault report, right?

That's already the case: we decided in thread [1] to track recoverable
faults in the IOMMU core, in order to check that the response is sane
and to set a quota and/or timeout. (I didn't include your timeout
patches here because I think they need a little more work. They are on
my sva/api branch.)

I already dropped iommu_private from the iommu_page_response structure.
In patch 4 iommu_page_response() retrieves the fault event and pass the
corresponding iommu_private back to the IOMMU driver.

[1] https://lore.kernel.org/lkml/20171206112521.1edf8e9b@jacob-builder/

Thanks,
Jean

> 
> If we pass on the private data, we only need to check if the response
> belong to the device but not exact match of a specific fault since the
> damage is contained in the assigned device. In case of injection
> fault into the guest, the response will come asynchronously after the
> handler completes.
