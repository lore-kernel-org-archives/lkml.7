Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F025C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A3E20878
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfKUAKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:10:44 -0500
Received: from mga12.intel.com ([192.55.52.136]:38966 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUAKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:10:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 16:10:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="204986105"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2019 16:10:42 -0800
Subject: Re: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
To:     Borislav Petkov <bp@alien8.de>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Lin, Jing" <jing.lin@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
 <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
 <20191120215338.GN2634@zn.tnic>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <247008b5-6d33-a51b-0caa-7f1991a94dbd@intel.com>
Date:   Wed, 20 Nov 2019 17:10:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120215338.GN2634@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/19 2:53 PM, Borislav Petkov wrote:
> On Wed, Nov 20, 2019 at 02:23:49PM -0700, Dave Jiang wrote:
>> +/**
>> + * iosubmit_cmds512 - copy data to single MMIO location, in 512-bit units
> 
> Where is the alignment check on that data before doing the copying?

I'll add the check on the destination address. The call is modeled after 
__iowrite64_copy() / __iowrite32_copy() in lib/iomap_copy.c. Looks like 
those functions do not check for the alignment requirements either.

> 
>> + * @dst: destination, in MMIO space (must be 512-bit aligned)
>> + * @src: source
>> + * @count: number of 512 bits quantities to submit
> 
> Where's that check on the data?

I don't follow?

> 
>> + *
>> + * Submit data from kernel space to MMIO space, in units of 512 bits at a
>> + * time.  Order of access is not guaranteed, nor is a memory barrier
>> + * performed afterwards.
>> + */
>> +static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
>> +				    size_t count)
> 
> An iosubmit function which returns void and doesn't tell its callers
> whether it succeeded or not? That looks non-optimal to say the least.
> 
> Why isn't there a fallback function which to call when the CPU doesn't
> support movdir64b?
> 
> Because then you can use alternative_call() and have the thing work
> regardless of hardware support for MOVDIR*.

Looks like Tony answered this part.

> 
>> +{
>> +	const u8 *from = src;
>> +	const u8 *end = from + count * 64;
>> +
>> +	if (!cpu_has_write512())
> 
> If anything, that thing needs to go and you should use
> 
>    static_cpu_has(X86_FEATURE_MOVDIR64B)
> 
> as it looks to me like you would care about speed on this fast path?
> Yes, no?
> 

Yes thank you!
