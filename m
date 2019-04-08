Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CC1C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 03:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975FC20879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 03:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDHDdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 23:33:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:10553 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfDHDdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 23:33:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Apr 2019 20:33:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,323,1549958400"; 
   d="scan'208";a="147375202"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Apr 2019 20:33:35 -0700
Subject: Re: [RFC PATCH v2 3/3] arch/x86/acrn: add hypercall for acrn_guest
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Jason Chen CJ <jason.cj.chen@intel.com>
References: <1553576023-6434-1-git-send-email-yakui.zhao@intel.com>
 <1553576023-6434-4-git-send-email-yakui.zhao@intel.com>
 <alpine.DEB.2.21.1904052110370.1802@nanos.tec.linutronix.de>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <efe1ffd8-4ab9-9204-f411-5e9caa6e88a1@intel.com>
Date:   Mon, 8 Apr 2019 11:31:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904052110370.1802@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年04月06日 03:19, Thomas Gleixner wrote:
> On Tue, 26 Mar 2019, Zhao Yakui wrote:
> 
>> When acrn_hypervisor is detected, the hypercall is needed so that the
>> acrn guest can query/config some settings. For example: it can be used
>> to query the resources in hypervisor and manage the CPU/memory/device/
>> interrupt for Guest system.
>>
>> So the hypercall is added so that the kernel can communicate with the
>> low-level acrn-hypervisor. On x86 it is implemented by using vmacll when
> 
> is implemented with the VMCALL instruction
> 
>> the acrn hypervisor is enabled.
>>
>> +++ b/arch/x86/include/asm/acrn_hypercall.h
>> @@ -0,0 +1,84 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * acrn_hypercall.h : acrn hypervisor call API
> 
> No file names in headers please. They are pointless and get out of sync
> when files are renamed.

Sure. It will be removed in next vesion.

> 
>> + */
>> +
>> +#ifndef __ACRN_HYPERCALL_H__
>> +#define __ACRN_HYPERCALL_H__
> 
> asm headers start with
> 
>      __ASM_X86_....
> 
This will be fixed.

>> +
>> +#include <linux/errno.h>
>> +
>> +#ifdef CONFIG_ACRN_GUEST
>> +
>> +/*
>> + * Hypercalls for ACRN Guest
>> + *
>> + * Hypercall number is passed in r8 register.
>> + * Return value will be placed in rax.
>> + * Up to 2 arguments are passed in rdi, rsi.
>> + */
>> +
>> +static inline long acrn_hypercall0(unsigned long hcall_id)
>> +{
>> +
> 
> Remove the empty new line please.
> 
>> +	register long result asm("rax");
>> +	register unsigned long r8 asm("r8") = hcall_id;
> 
> Please order them the other way around, like a reverse christmas tree:
> 
> 	register unsigned long r8 asm("r8") = hcall_id;
> 	register long result asm("rax");
> 
> That's way simpler to read.

This will be fixed.

> 
>> +	asm volatile(".byte 0x0F,0x01,0xC1\n"
>> +			: "=r"(result)
>> +			:  "r"(r8));
> 
> Please mention in the changelog why this is implemented with bytes and not
> with the proper mnemonic. I assume it depends on binutils, so please
> document which version of binutils supports the mnemonic.

I check the binutils version mentioned in Document/changes.
(binutils, 2.20)
It seems that the "vmcall" is already supported.
So the "vmcall" mnemonic will be used to make it readable.

> 
> And in the first function, i.e. hypercall0, add a comment above the asm
> volatile() to that effect as well.

Sure.


> 
> Thanks,
> 
> 	tglx
> 
