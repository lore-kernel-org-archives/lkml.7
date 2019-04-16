Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E2AC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E1520656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDPCYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:24:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:52608 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfDPCYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:24:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 19:24:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,355,1549958400"; 
   d="scan'208";a="131706467"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga007.jf.intel.com with ESMTP; 15 Apr 2019 19:24:52 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Expose ISA direct mapping region via
 iommu_get_resv_regions
To:     James Sewart <jamessewart@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
 <F531CABB-FFDA-4E0A-A3D5-095FF338DD5A@arista.com>
 <b6b3dda7-31e3-c1e8-16cb-07feb7d5431d@linux.intel.com>
 <A489539F-4DD4-438A-AD9A-1A2F50404DB9@arista.com>
 <fb1565dc-d991-acf9-e275-c0090f69f47e@linux.intel.com>
 <445F31EA-20F3-481C-B1DF-8B163791FF8C@arista.com>
 <cf43d26b-f1ee-8469-c17a-e5c412dcfeab@linux.intel.com>
 <6C211BF1-B5A0-4821-AB42-092B573DE667@arista.com>
 <8B1FC0C7-9BAC-498D-B1F0-0138EACF75C2@arista.com>
 <ddcaa472-7bff-ddd3-0518-f2ba694b3279@linux.intel.com>
 <9AECB54A-2DA7-4ABD-A9B5-0549E108D1AF@arista.com>
 <abbfecda-8990-315c-ac7a-7f571e86aba2@linux.intel.com>
 <1D51CB31-089A-4D71-A9C1-E54E50A56C46@arista.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1b7d37da-5660-f635-cd2f-619e5573d35a@linux.intel.com>
Date:   Tue, 16 Apr 2019 10:18:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1D51CB31-089A-4D71-A9C1-E54E50A56C46@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 4/15/19 10:16 PM, James Sewart wrote:
> Hey Lu,
> 
>> On 10 Apr 2019, at 06:22, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> Hi James,
>>
>> On 4/6/19 2:02 AM, James Sewart wrote:
>>> Hey Lu,
>>> My bad, did some debugging on my end. The issue was swapping out
>>> find_domain for iommu_get_domain_for_dev. It seems in some situations the
>>> domain is not attached to the group but the device is expected to have the
>>> domain still stored in its archdata.
>>> I’ve attached the final patch with find_domain unremoved which seems to
>>> work in my testing.
>>
>> Just looked into your v3 patch set and some thoughts from my end posted
>> here just for your information.
>>
>> Let me post the problems we want to address.
>>
>> 1. When allocating a new group for a device, how should we determine the
>> type of the default domain?
>>
>> 2. If we need to put a device into an existing group which uses a
>> different type of domain from what the device desires to use, we might
>> break the functionality of the device.
>>
>> My new thought is letting the iommu generic code to determine the
>> default domain type (hence my proposed vendor specific default domain
>> type patches could be dropped).
>>
>> If the default domain type is dynamical mapping, and later in iommu_no_mapping(), we determines that we must use an identity domain,
>> we then call iommu_request_dm_for_dev(dev).
>>
>> If the default domain type is identity mapping, and later in
>> iommu_no_mapping(), we determined that we must use a dynamical domain,
>> we then call iommu_request_dma_domain_for_dev(dev).
>>
>> We already have iommu_request_dm_for_dev() in iommu.c. We only need to
>> implement iommu_request_dma_domain_for_dev().
>>
>> With this done, your patch titled "Create an IOMMU group for devices
>> that require an identity map" could also be dropped.
>>
>> Any thoughts?
> 
> Theres a couple issues I can think of. iommu_request_dm_for_dev changes
> the domain for all devices within the devices group, if we may have
> devices with different domain requirements in the same group then only the
> last initialised device will get the domain it wants. If we want to add
> iommu_request_dma_domain_for_dev then we would still need another IOMMU
> group for identity domain devices.

Current solution (a.k.a. v3) for this is to assign a new group to the
device which requires an identity mapped domain. This will break the
functionality of device direct pass-through (to user level). The iommu
group represents the minimum granularity of iommu isolation and
protection. The requirement of identity mapped domain should not be a
factor for a new group.

Both iomm_request_dma_domain_for_dev() or iommu_request_dm_for_dev()
only support groups with a single device in it.

The users could choose between domains of DMA type or IDENTITY type for
a group. If multiple devices share a single group and both don't work
for them, they have to disable the IOMMU. This isn't a valid
configuration from IOMMU's point of view.

> 
> Both with v3 and the proposed method here, iommu_should_identity_map is
> determining whether the device requires an identity map. In v3 this is
> called once up front by the generic code to determine for the IOMMU group
> which domain type to use. In the proposed method I think this would happen
> after initial domain allocation and would trigger the domain to be
> replaced with a different domain.
> 
> I prefer the solution in v3. What do you think?

The only concern of solution in v3 from my point of view is some kind of
duplication. Even we can ask the Intel IOMMU driver to tell the default
domain type, we might change it after boot up. For example, for 32-bit
pci devices, we don't know whether it's 64-bit or 32-bit capable during
IOMMU initialization, so we might tell iommu.c to use identity mapped
domain. After boot up, we check it again, and find out that it's only
32-bit capable (hence only can access physical memory below 4G) and the
default identity domain doesn't work. And we have to change it to DMA
domain via iommu_request_dma_domain_for_dev().

So to make it simple and straight-forward, we can just let iommu.c to
determine the default domain type and after that the Intel IOMMU driver
could tweak it according to the quirk bits in the driver.

Best regards,
Lu Baolu
