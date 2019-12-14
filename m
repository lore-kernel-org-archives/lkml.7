Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940BBC43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 01:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8367B214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 01:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLNBxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 20:53:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:46750 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfLNBxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 20:53:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 17:53:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,311,1571727600"; 
   d="scan'208";a="226462850"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 13 Dec 2019 17:53:38 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iommu/vt-d bad RMRR workarounds
To:     Barret Rhoden <brho@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Yian Chen <yian.chen@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
References: <20191211194606.87940-1-brho@google.com>
 <35f49464-0ce5-9998-12a0-624d9683ea18@linux.intel.com>
 <8a530d5c-22e1-3c2f-98df-45028cc6c771@google.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <02d69d9a-9c45-d9e7-4c1a-cb5e50590c47@linux.intel.com>
Date:   Sat, 14 Dec 2019 09:52:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <8a530d5c-22e1-3c2f-98df-45028cc6c771@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/13/19 10:31 PM, Barret Rhoden wrote:
> On 12/11/19 9:43 PM, Lu Baolu wrote:
>> The VT-d spec defines the BIOS considerations about RMRR in section 8.4:
>>
>> "
>> BIOS must report the RMRR reported memory addresses as reserved (or as
>> EFI runtime) in the system memory map returned through methods such as
>> INT15, EFI GetMemoryMap etc.
>> "
>>
>> So we should treat it as firmware bug if the RMRR range is not mapped as
>> RESERVED in the system memory map table.
>>
>> As for how should the driver handle this case, ignoring buggy RMRR with
>> a warning message might be a possible choice.
> 
> Agreed, firmware should not be doing this.  My first patch just skips 
> those entries, instead of aborting DMAR processing, and keeps the warning.
>

Hi Yian,

Does this work for you?

Best regards,
baolu


> So long as the machine still boots in a safe manner, I'm reasonably happy.
> 
> Thanks,
> 
> Barret
> 
> 
