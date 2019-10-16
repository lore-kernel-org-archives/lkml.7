Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3974FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81ADC2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389523AbfJPRag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 13:30:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:44105 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbfJPRaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 13:30:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 10:21:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200"; 
   d="scan'208";a="395964943"
Received: from chenyian-desk1.amr.corp.intel.com (HELO [10.3.52.63]) ([10.3.52.63])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2019 10:21:24 -0700
Subject: Re: [PATCH] iommu/vt-d: Check VT-d RMRR region in BIOS is reported as
 reserved
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
References: <20191015164932.18185-1-yian.chen@intel.com>
 <20191016075120.GB32232@8bytes.org>
From:   "Chen, Yian" <yian.chen@intel.com>
Message-ID: <b1ebbf77-ced7-be22-d8d8-a7d4e19ad261@intel.com>
Date:   Wed, 16 Oct 2019 10:21:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191016075120.GB32232@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/2019 12:51 AM, Joerg Roedel wrote:
> Hi,
>
> On Tue, Oct 15, 2019 at 09:49:32AM -0700, Yian Chen wrote:
>> VT-d RMRR (Reserved Memory Region Reporting) regions are reserved
>> for device use only and should not be part of allocable memory pool of OS.
>>
>> BIOS e820_table reports complete memory map to OS, including OS usable
>> memory ranges and BIOS reserved memory ranges etc.
>>
>> x86 BIOS may not be trusted to include RMRR regions as reserved type
>> of memory in its e820 memory map, hence validate every RMRR entry
>> with the e820 memory map to make sure the RMRR regions will not be
>> used by OS for any other purposes.
> Are there real systems in the wild where this is a problem?
Firmware reports e820 and RMRR in separate structure. The system will 
not work stably
if RMRR is not in the e820 table as reserved type mem and can be used 
for other purposes.
In system engineering phase, I practiced with some kind bugs from BIOS, 
but not yet exactly same as
the one here. Please consider this is a generic patch to avoid 
subsequent failure at runtime.
>> +static inline int __init
>> +arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
>> +{
>> +	u64 start = rmrr->base_address;
>> +	u64 end = rmrr->end_address + 1;
>> +
>> +	if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
>> +		return 0;
>> +
>> +	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
>> +	       start, end - 1);
>> +	return -EFAULT;
>> +}
> Why -EFAULT, there is no fault involved? Usibg -EINVAL seems to be a better choice.
-EFAULT could be used for address related errors.
For this case, I agree, -EINVAL seems better while
consider it as an input problem from firmware. I will make change.

