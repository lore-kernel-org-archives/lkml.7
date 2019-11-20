Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA3EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 23:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33BE20715
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 23:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfKTXq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 18:46:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:19050 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfKTXqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 18:46:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 15:46:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="204980377"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2019 15:46:53 -0800
Subject: Re: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
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
        "bp@alien8.de" <bp@alien8.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
 <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
 <8f860476-24e4-6e03-752b-10a59aed8901@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <7d3ba8bb-fbb6-097c-fa5a-6b3ec21f72e3@intel.com>
Date:   Wed, 20 Nov 2019 16:46:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <8f860476-24e4-6e03-752b-10a59aed8901@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/19 2:50 PM, Hansen, Dave wrote:
> On 11/20/19 1:23 PM, Dave Jiang wrote:
>> +static inline void __iowrite512(void __iomem *__dst, const void *src)
>> +{
>> +	volatile struct { char _[64]; } *dst = __dst;
> 
> This _looks_ like gibberish.  I know it's not, but it is subtle enough
> that it really needs specific comments.

I'll add comments explaining.

> 
>> +static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
>> +				    size_t count)
>> +{
>> +	const u8 *from = src;
>> +	const u8 *end = from + count * 64;
>> +
>> +	if (!cpu_has_write512())
>> +		return;
>> +
>> +	while (from < end) {
>> +		__iowrite512(dst, from);
>> +		from += 64;
>> +	}
>> +}
> 
> Won't this silently just drop things if the CPU doesn't have movdir64b
> support?
> 
> It seems like this shouldn't be called at all if
> !cpu_has_write512(), but wouldn't something like this be mroe appropriate?
> 
> 	if (!cpu_has_write512()) {
> 		WARN_ON_ONCE(1);
> 		return;
> 	}
> 
> Is the caller just supposed to infer that "dst" was never overwritten?
> 

Thanks. I'll add the WARN().
