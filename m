Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0DAC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592F82077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfDZLsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:48:09 -0400
Received: from foss.arm.com ([217.140.101.70]:39388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfDZLsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:48:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C30680D;
        Fri, 26 Apr 2019 04:48:08 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BDE13F5AF;
        Fri, 26 Apr 2019 04:48:01 -0700 (PDT)
Subject: Re: [PATCH v2 06/19] drivers core: Add I/O ASID allocator
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-7-git-send-email-jacob.jun.pan@linux.intel.com>
 <20190424061903.GB30717@infradead.org>
 <20190425111912.0e15eb7d@jacob-builder>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <856b0457-bd2f-c2af-fdeb-45fe0bd3136b@arm.com>
Date:   Fri, 26 Apr 2019 12:47:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425111912.0e15eb7d@jacob-builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2019 19:19, Jacob Pan wrote:
> Hi Christoph,
> 
> On Tue, 23 Apr 2019 23:19:03 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
>> On Tue, Apr 23, 2019 at 04:31:06PM -0700, Jacob Pan wrote:
>>> The allocator doesn't really belong in drivers/iommu because some
>>> drivers would like to allocate PASIDs for devices that aren't
>>> managed by an IOMMU, using the same ID space as IOMMU. It doesn't
>>> really belong in drivers/pci either since platform device also
>>> support PASID. Add the allocator in drivers/base.  
>>
>> I'd still add it to drivers/iommu, just selectable separately from the
>> core iommu code..
> Perhaps I misunderstood. If a driver wants to use IOASIDs w/o iommu
> subsystem even turned on, how could selecting from the core iommu code
> help? Could you elaborate on "selectable"?

How about doing the same as CONFIG_IOMMU_IOVA? The code is in
drivers/iommu but can be selected by non-IOMMU_API users, independently
of CONFIG_IOMMU_SUPPORT. It's true that this allocator will mostly be
used by IOMMU drivers.

> From VT-d's perspective, PASIDs are only used with IOMMU on. Jean
> knows other use cases.

I know of one: the AMD GPU driver may use IOASID for context IDs, even
if IOMMU is disabled. As I understand it, if IOMMU is enabled they need
to use the same allocator as IOMMU since it's the same ID space. And I
think it's more convenient to use the same allocation code in the GPU
driver regardless of CONFIG_IOMMU_SUPPORT.

See the previous discussion at
https://www.spinics.net/lists/iommu/msg31200.html

Thanks,
Jean
