Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DDAC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2237B20717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfLPTLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:11:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:59458 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbfLPTLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 14:11:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 11:11:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="212129807"
Received: from chenyian-desk1.amr.corp.intel.com (HELO [10.3.52.63]) ([10.3.52.63])
  by fmsmga007.fm.intel.com with ESMTP; 16 Dec 2019 11:11:37 -0800
Subject: Re: [PATCH 0/3] iommu/vt-d bad RMRR workarounds
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Barret Rhoden <brho@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Sohil Mehta <sohil.mehta@intel.com>
Cc:     iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20191211194606.87940-1-brho@google.com>
 <35f49464-0ce5-9998-12a0-624d9683ea18@linux.intel.com>
 <8a530d5c-22e1-3c2f-98df-45028cc6c771@google.com>
 <02d69d9a-9c45-d9e7-4c1a-cb5e50590c47@linux.intel.com>
From:   "Chen, Yian" <yian.chen@intel.com>
Message-ID: <c9e97080-eae3-efbd-0ba8-c4794f442c6b@intel.com>
Date:   Mon, 16 Dec 2019 11:11:37 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <02d69d9a-9c45-d9e7-4c1a-cb5e50590c47@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/2019 5:52 PM, Lu Baolu wrote:
>
> On 12/13/19 10:31 PM, Barret Rhoden wrote:
>> On 12/11/19 9:43 PM, Lu Baolu wrote:
>>> The VT-d spec defines the BIOS considerations about RMRR in section 
>>> 8.4:
>>>
>>> "
>>> BIOS must report the RMRR reported memory addresses as reserved (or as
>>> EFI runtime) in the system memory map returned through methods such as
>>> INT15, EFI GetMemoryMap etc.
>>> "
>>>
>>> So we should treat it as firmware bug if the RMRR range is not 
>>> mapped as
>>> RESERVED in the system memory map table.
>>>
>>> As for how should the driver handle this case, ignoring buggy RMRR with
>>> a warning message might be a possible choice.
>>
>> Agreed, firmware should not be doing this.  My first patch just skips 
>> those entries, instead of aborting DMAR processing, and keeps the 
>> warning.
>>
>
> Hi Yian,
>
> Does this work for you?
>
> Best regards,
> baolu
>
>
I made a comment in the the patch email "[PATCH 1/3] iommu/vt-d: skip 
RMRR entries that fail the sanity check "
thanks,
Yian

>> So long as the machine still boots in a safe manner, I'm reasonably 
>> happy.
>>
>> Thanks,
>>
>> Barret
>>
>>

