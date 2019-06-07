Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323DFC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115342089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfFGMru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:47:50 -0400
Received: from foss.arm.com ([217.140.110.172]:39526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbfFGMru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:47:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 226E53EF;
        Fri,  7 Jun 2019 05:47:49 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E0D640151;
        Fri,  7 Jun 2019 05:47:47 -0700 (PDT)
Subject: Re: [PATCH v8 25/29] vfio-pci: Add a new VFIO_REGION_TYPE_NESTED
 region type
To:     Auger Eric <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
        Vincent Stehle <Vincent.Stehle@arm.com>
References: <20190526161004.25232-1-eric.auger@redhat.com>
 <20190526161004.25232-26-eric.auger@redhat.com>
 <20190603163159.31e7ae23@x1.home>
 <9c1ea2db-5ba0-3cf5-3b38-2c4a125460e6@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <6a640710-bb9d-8923-cfef-e57786ed699f@arm.com>
Date:   Fri, 7 Jun 2019 13:47:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9c1ea2db-5ba0-3cf5-3b38-2c4a125460e6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2019 09:28, Auger Eric wrote:
>>> +static const struct vfio_pci_fault_abi fault_abi_versions[] = {
>>> +	[0] = {
>>> +		.entry_size = sizeof(struct iommu_fault),
>>> +	},
>>> +};
>>> +
>>> +#define NR_FAULT_ABIS ARRAY_SIZE(fault_abi_versions)
>>
>> This looks like it's leading to some dangerous complicated code to
>> support multiple user selected ABIs.  How many ABIs do we plan to
>> support?  The region capability also exposes a type, sub-type, and
>> version.  How much of this could be exposed that way?  ie. if we need
>> to support multiple versions, expose multiple regions.
> 
> This is something that was discussed earlier and suggested by
> Jean-Philippe that we may need to support several versions of the ABI
> (typicallu when adding PRI support).
> Exposing multiple region is an interesting idea and I will explore that
> direction.

At the moment the ABI support errors and PRI. We're considering setting
the fault report structure to 64 or 128 bytes (see "[PATCH v2 2/4]
iommu: Introduce device fault data"). 64-byte allows for 2 additional
fields before we have to introduce a new ABI version, while 128 byte
should last us a while.

But that's for adding new fields to existing fault types. It's probably
a good idea to have different region types in VFIO for different fault
types, since userspace isn't necessarily prepared to deal with them. For
example right now userspace doesn't have a method to complete
recoverable faults, so we can't add them to the queue.

Thanks,
Jean
