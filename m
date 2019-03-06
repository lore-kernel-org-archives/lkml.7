Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF81C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A795D20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfCFQIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:08:12 -0500
Received: from foss.arm.com ([217.140.101.70]:35236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfCFQIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:08:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3A6D1596;
        Wed,  6 Mar 2019 08:08:11 -0800 (PST)
Received: from [10.1.197.2] (ostrya.cambridge.arm.com [10.1.197.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4ECFB3F575;
        Wed,  6 Mar 2019 08:08:09 -0800 (PST)
Subject: Re: [PATCH v4 02/22] iommu: introduce device fault data
To:     Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, will.deacon@arm.com, robin.murphy@arm.com
Cc:     marc.zyngier@arm.com, peter.maydell@linaro.org,
        kevin.tian@intel.com, ashok.raj@intel.com, christoffer.dall@arm.com
References: <20190218135504.25048-1-eric.auger@redhat.com>
 <20190218135504.25048-3-eric.auger@redhat.com>
 <c9adfbda-b78a-405a-a691-9f99d7dc2a26@arm.com>
 <742a6ce1-0182-ad56-fccf-65967d9bf280@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <4d9b1f13-4fa4-c209-0645-71c1b4b2f646@arm.com>
Date:   Wed, 6 Mar 2019 16:07:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <742a6ce1-0182-ad56-fccf-65967d9bf280@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2019 14:30, Auger Eric wrote:
>>> +#define IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE	(1 << 1)
>>> +#define IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA	(1 << 2)
>>> +	__u32   flags;
>>> +	__u32	pasid;
>>> +	__u32	grpid;
>>> +	__u32	perm;
>>> +	__u64	addr;
>>
>> Given that we'll be reporting stall faults using this struct, it would
>> be good to have the fetch_addr field and flag here as well.
> As the stall model looks really ARM specific shouldn't we introduce a
> dedicated struct and iommu_fault_type enum value?

There is no reason for the generic page fault handler to differentiate
between stall and PRI, they are page requests. For a stall we write STAG
into grpid and set LAST_PAGE=1. Then the SMMU driver writes the page
response either as a PRI_RESP or a RESUME depending on the device type.

> Also for stall faults don't we need to expose the stall tag (STAG) that,
> as far as I understand is going to be used by the guest we it wants to
> retry or terminate the faulted transaction. In practice doesn't the
> stall fault have the same fields of the unrecoverable fault + STAG? I am
> afraid adding the fetch_addr in the page request struct may "pollute"
> the PRI struct that can be understood by both aarch64 and x86 parties atm.

Let's leave out the fetch_addr field then, I was suggesting it for
completeness but I don't need it immediately, at least not for host SVA.
For dual-stage SVA (where both stage-1 and stage-2 are shared with the
CPU) we'll need the IPA field, but that's still a long way away.

> Also couldn't we envision to put this STALL struct in a new revision of
> the fault ABI.
As said above, generic code doesn't have to know the difference until we
start implementing nested SVA. Also, we need stall support in the fault
handler soon, since there is hardware supporting it.

Thanks,
Jean
