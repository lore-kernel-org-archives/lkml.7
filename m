Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44158C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2148F20717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfFEL0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:26:39 -0400
Received: from foss.arm.com ([217.140.101.70]:57890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbfFEL0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:26:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BE41374;
        Wed,  5 Jun 2019 04:26:38 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D9553F5AF;
        Wed,  5 Jun 2019 04:26:36 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 0/4] iommu: Add device fault reporting API
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Robin Murphy <Robin.Murphy@arm.com>
References: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
 <20190603145951.729600e6@jacob-builder>
Message-ID: <3d3bc50f-beb3-dda8-dfaa-ecb4dcffd560@arm.com>
Date:   Wed, 5 Jun 2019 12:26:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603145951.729600e6@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2019 22:59, Jacob Pan wrote:
> On Mon,  3 Jun 2019 15:57:45 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> Allow device drivers and VFIO to get notified on IOMMU translation
>> fault, and handle recoverable faults (PCI PRI). Several series require
>> this API (Intel VT-d and Arm SMMUv3 nested support, as well as the
>> generic host SVA implementation).
>>
>> Changes since v1 [1]:
>> * Allocate iommu_param earlier, in iommu_probe_device().
>> * Pass struct iommu_fault to fault handlers, instead of the
>>   iommu_fault_event wrapper.
>> * Removed unused iommu_fault_event::iommu_private.
>> * Removed unnecessary iommu_page_response::addr.
>> * Added iommu_page_response::version, which would allow to introduce a
>>   new incompatible iommu_page_response structure (as opposed to just
>>   adding a flag + field).
>>
>> [1] [PATCH 0/4] iommu: Add device fault reporting API
>>     https://lore.kernel.org/lkml/20190523180613.55049-1-jean-philippe.brucker@arm.com/
>>
>> Jacob Pan (3):
>>   driver core: Add per device iommu param
>>   iommu: Introduce device fault data
>>   iommu: Introduce device fault report API
>>
>> Jean-Philippe Brucker (1):
>>   iommu: Add recoverable fault reporting
>>
> This interface meet the need for vt-d, just one more comment on 2/4. Do
> you want to add Co-developed-by you for the three patches from me?

I'm fine without it, I don't think it adds much to the Signed-off-by,
which is required

Thanks,
Jean
