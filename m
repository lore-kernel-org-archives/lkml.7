Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904C1C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC95218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLQTT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:19:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:14376 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbfLQTT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:19:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 11:19:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="212478542"
Received: from chenyian-desk1.amr.corp.intel.com (HELO [10.3.52.63]) ([10.3.52.63])
  by fmsmga007.fm.intel.com with ESMTP; 17 Dec 2019 11:19:28 -0800
Subject: Re: [PATCH 1/3] iommu/vt-d: skip RMRR entries that fail the sanity
 check
To:     Barret Rhoden <brho@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Sohil Mehta <sohil.mehta@intel.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        x86@kernel.org
References: <20191211194606.87940-1-brho@google.com>
 <20191211194606.87940-2-brho@google.com>
 <99a294a0-444e-81f9-19a2-216aef03f356@intel.com>
 <93820c21-8a37-d8f0-dacb-29cee694a91d@google.com>
From:   "Chen, Yian" <yian.chen@intel.com>
Message-ID: <4c24f2d2-03fd-a6cb-f950-391f3f7837cb@intel.com>
Date:   Tue, 17 Dec 2019 11:19:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <93820c21-8a37-d8f0-dacb-29cee694a91d@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/2019 11:35 AM, Barret Rhoden wrote:
> On 12/16/19 2:07 PM, Chen, Yian wrote:
>>
>>
>> On 12/11/2019 11:46 AM, Barret Rhoden wrote:
>>> RMRR entries describe memory regions that are DMA targets for devices
>>> outside the kernel's control.
>>>
>>> RMRR entries that fail the sanity check are pointing to regions of
>>> memory that the firmware did not tell the kernel are reserved or
>>> otherwise should not be used.
>>>
>>> Instead of aborting DMAR processing, this commit skips these RMRR
>>> entries.  They will not be mapped into the IOMMU, but the IOMMU can
>>> still be utilized.  If anything, when the IOMMU is on, those devices
>>> will not be able to clobber RAM that the kernel has allocated from 
>>> those
>>> regions.
>>>
>>> Signed-off-by: Barret Rhoden <brho@google.com>
>>> ---
>>>   drivers/iommu/intel-iommu.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>>> index f168cd8ee570..f7e09244c9e4 100644
>>> --- a/drivers/iommu/intel-iommu.c
>>> +++ b/drivers/iommu/intel-iommu.c
>>> @@ -4316,7 +4316,7 @@ int __init dmar_parse_one_rmrr(struct 
>>> acpi_dmar_header *header, void *arg)
>>>       rmrr = (struct acpi_dmar_reserved_memory *)header;
>>>       ret = arch_rmrr_sanity_check(rmrr);
>>>       if (ret)
>>> -        return ret;
>>> +        return 0;
>>>       rmrru = kzalloc(sizeof(*rmrru), GFP_KERNEL);
>>>       if (!rmrru)
>> Parsing rmrr function should report the error to caller. The behavior 
>> to response the error can be
>> chose  by the caller in the calling stack, for example, 
>> dmar_walk_remapping_entries().
>> A concern is that ignoring a detected firmware bug might have a 
>> potential side impact though
>> it seemed safe for your case.
>
> That's a little difficult given the current code.  Once we are in
> dmar_walk_remapping_entries(), the specific function (parse_one_rmrr) 
> is called via callback:
>
>     ret = cb->cb[iter->type](iter, cb->arg[iter->type]);
>     if (ret)
>         return ret;
>
> If there's an error of any sort, it aborts the walk.  Handling the 
> specific errors here is difficult, since we don't know what the errors 
> mean to the specific callback.  Is there some errno we can use that 
> means "there was a problem, but it's not so bad that you have to 
> abort, but I figured you ought to know"?  Not that I think that's a 
> good idea.
>
> The knowledge of whether or not a specific error is worth aborting all 
> DMAR functionality is best known inside the specific callback.  The 
> only handling to do is print a warning and either skip it or abort.
>
> I think skipping the entry for a bad RMRR is better than aborting 
> completely, though I understand if people don't like that.  It's 
> debatable.  By aborting, we lose the ability to use the IOMMU at all, 
> but we are still in a situation where the devices using the RMRR 
> regions might be clobbering kernel memory, right?  Using the IOMMU 
> (with no mappings for the bad RMRRs) would stop those devices from 
> clobbering memory.
>
> Regardless, I have two other patches in this series that could resolve 
> the problem for me and probably other people.  I'd just like at least 
> one of the three patches to get merged so that my machine boots when 
> the original commit f036c7fa0ab6 ("iommu/vt-d: Check VT-d RMRR region 
> in BIOS is reported as reserved") gets released.
>
when a firmware bug appears, the potential problem may beyond the scope 
of its visible impacts so that introducing a workaround in official 
implementation should be considered very carefully.

If the workaround is really needed at this point, I would recommend 
adding a WARN_TAINT with TAINT_FIRMWARE_WORKAROUND, to tell the 
workaround is in the place.

Thanks
Yian

> Thanks,
>
> Barret
>

