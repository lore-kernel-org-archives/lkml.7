Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A069CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C17A20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfCHBOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 20:14:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:36859 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfCHBO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 20:14:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 17:14:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,454,1544515200"; 
   d="scan'208";a="121999690"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2019 17:14:26 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iommu/vt-d: Remove lazy allocation of domains
To:     James Sewart <jamessewart@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
 <F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
 <7F6B5F6A-EC76-4A9F-8EB6-AEAB9994D91A@arista.com>
 <fdd74d83-acd4-23da-6c0c-b52573d999bb@linux.intel.com>
 <4B054B40-0B13-4F1E-87D6-8D2F072B5B9C@arista.com>
 <06aa306a-278a-a22f-7718-200f6f9e5e87@linux.intel.com>
 <A8A495EE-D3EA-4D84-AB92-9B4742E6E500@arista.com>
 <4b3e29ce-1dff-eb7d-9b7e-1cde54a24dec@linux.intel.com>
 <8ED1B579-C6B9-49E0-BD9A-5751474682D1@arista.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7913a6b9-aa46-8085-0b5e-6fd641f285ac@linux.intel.com>
Date:   Fri, 8 Mar 2019 09:09:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8ED1B579-C6B9-49E0-BD9A-5751474682D1@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/7/19 6:21 PM, James Sewart wrote:
> Hey Lu,
> 
>> On 7 Mar 2019, at 06:31, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> Hi James,
>>
>> On 3/7/19 2:08 AM, James Sewart wrote:
>>>>>>> -	/*
>>>>>>> -	 * For each rmrr
>>>>>>> -	 *   for each dev attached to rmrr
>>>>>>> -	 *   do
>>>>>>> -	 *     locate drhd for dev, alloc domain for dev
>>>>>>> -	 *     allocate free domain
>>>>>>> -	 *     allocate page table entries for rmrr
>>>>>>> -	 *     if context not allocated for bus
>>>>>>> -	 *           allocate and init context
>>>>>>> -	 *           set present in root table for this bus
>>>>>>> -	 *     init context with domain, translation etc
>>>>>>> -	 *    endfor
>>>>>>> -	 * endfor
>>>>>>> -	 */
>>>>>>> -	pr_info("Setting RMRR:\n");
>>>>>>> -	for_each_rmrr_units(rmrr) {
>>>>>>> -		/* some BIOS lists non-exist devices in DMAR table. */
>>>>>>> -		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
>>>>>>> -					  i, dev) {
>>>>>>> -			ret = iommu_prepare_rmrr_dev(rmrr, dev);
>>>>>>> -			if (ret)
>>>>>>> -				pr_err("Mapping reserved region failed\n");
>>>>>>> -		}
>>>>>>> -	}
>>>>>>> -
>>>>>>> -	iommu_prepare_isa();
>>>>>> Why do you want to remove this segment of code?
>>>>> This will only work if the lazy allocation of domains exists, these
>>>>> mappings will disappear once a default domain is attached to a device and
>>>>> then remade by iommu_group_create_direct_mappings. This code is redundant
>>>>> and removing it allows us to remove all the lazy allocation logic.
>>>> No exactly.
>>>>
>>>> We need to setup the rmrr mapping before enabling dma remapping,
>>>> otherwise, there will be a window after dma remapping enabling and
>>>> rmrr getting mapped, during which people might see dma faults.
>>> Do you think this patch instead should be a refactoring to simplify this initial domain setup before the default domain takes over? It seems like duplicated effort to have both lazy allocated domains and externally managed domains. We could allocate a domain here for any devices with RMRR and call get_resv_regions to avoid duplicating RMRR loop.
>>
>> Agree. We should replace the lazy allocated domains with default domain
>> in a clean way. Actually, your patches look great to me. But I do think
>> we need further cleanups. The rmrr code is one example, and the identity
>> domain (si_domain) is another.
>>
>> Do you mind if I work on top of your patches for further cleanups and
>> sign off a v2 together with you?
> 
> Sure, sounds good. I’ll fixup patch 3 and have a go at integrating
> iommu_prepare_isa into get_resv_regions. This should make the initial
> domain logic here quite concise.

Very appreciated! Thank you!

Best regards,
Lu Baolu
