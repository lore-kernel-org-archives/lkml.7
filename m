Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B406C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE17214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfDYKSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:18:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:43043 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfDYKSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:18:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 03:18:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; 
   d="scan'208";a="340680960"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by fmsmga006.fm.intel.com with ESMTP; 25 Apr 2019 03:18:31 -0700
Subject: Re: [RFC PATCH v5 4/4] x86/acrn: Add hypercall for ACRN guest
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Chen, Jason CJ" <jason.cj.chen@intel.com>
References: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
 <1556067260-9128-5-git-send-email-yakui.zhao@intel.com>
 <20190425070712.GA57256@gmail.com>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <6dd021a9-e2c0-ee84-55fd-3e6dfb4bd944@intel.com>
Date:   Thu, 25 Apr 2019 18:16:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190425070712.GA57256@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年04月25日 15:07, Ingo Molnar wrote:

Thanks for the review.
> 
> * Zhao Yakui <yakui.zhao@intel.com> wrote:
> 
>> When ACRN hypervisor is detected, the hypercall is needed so that the
>> ACRN guest can query/config some settings. For example: it can be used
>> to query the resources in hypervisor and manage the CPU/memory/device/
>> interrupt for the guest operating system.
>>
>> So add the hypercall so that ACRN guest can communicate with the
>> low-level ACRN hypervisor. It is implemented with the VMCALL instruction.
>>
>> Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
>> Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
>> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
>> ---
>> V1->V2: Refine the comments for the function of acrn_hypercall0/1/2
>> v2->v3: Use the "vmcall" mnemonic to replace hard-code byte definition
>> v4->v5: Use _ASM_X86_ACRN_HYPERCALL_H instead of _ASM_X86_ACRNHYPERCALL_H to
>> align the header file of acrn_hypercall.h
>>          Use the "VMCALL" mnemonic in comment/commit log.
>>          Uppercase r8/rdi/rsi/rax for hypercall parameter registers in comment.
>> ---
>>   arch/x86/include/asm/acrn_hypercall.h | 82 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 82 insertions(+)
>>   create mode 100644 arch/x86/include/asm/acrn_hypercall.h
>>
>> diff --git a/arch/x86/include/asm/acrn_hypercall.h b/arch/x86/include/asm/acrn_hypercall.h
>> new file mode 100644
>> index 0000000..3594436
>> --- /dev/null
>> +++ b/arch/x86/include/asm/acrn_hypercall.h
>> @@ -0,0 +1,82 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef _ASM_X86_ACRN_HYPERCALL_H
>> +#define _ASM_X86_ACRN_HYPERCALL_H
> 
> 
>> +
>> +#include <linux/errno.h>
>> +
>> +#ifdef CONFIG_ACRN_GUEST
>> +
>> +/*
>> + * Hypercalls for ACRN guest
>> + *
>> + * Hypercall number is passed in R8 register.
>> + * Up to 2 arguments are passed in RDI, RSI.
>> + * Return value will be placed in RAX.
>> + */
>> +
>> +static inline long acrn_hypercall0(unsigned long hcall_id)
>> +{
>> +	register unsigned long r8 asm("r8") = hcall_id;
>> +	register long result asm("rax");
>> +
>> +	/* the hypercall is implemented with the VMCALL instruction.
>> +	 * asm indicates that inline assembler instruction is used.
>> +	 * volatile qualifier is added to avoid that it is dropped
>> +	 * because of compiler optimization.
>> +	 */
> 
> Non-standard comment style.
> 
> asm statements are volatile by default I believe.

For the basic asm:  it is volatile by default.
For the extend asm:  The volatile is needed to disable the certain 
optimization.
The below info is copied from: 
https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Extended-Asm

The typical use of extended asm statements is to manipulate input values 
to produce output values. However, your asm statements may also produce 
side effects. If so, you may need to use the volatile qualifier to 
disable certain optimizations. See Volatile.


> 
> I.e. the second and third sentences are partly obvious, superfluous and
> bogus.
> 
>> +	asm volatile("vmcall"
>> +			: "=r"(result)
>> +			: "r"(r8));
>> +
>> +	return result;
>> +}
>> +
>> +static inline long acrn_hypercall1(unsigned long hcall_id,
>> +				   unsigned long param1)
>> +{
>> +	register unsigned long r8 asm("r8") = hcall_id;
>> +	register long result asm("rax");
>> +
>> +	asm volatile("vmcall"
>> +			: "=r"(result)
>> +			: "D"(param1), "r"(r8));
> 
> Why are register variables used? Doesn't GCC figure it out correctly by
> default?

The parameter register for the VMCALL is predefined in ACRN hypervisor. 
Now the R8 is used to pass the hcall_id.
It seems that there is no special constraint for R8~R15.
So the explicit register variable is used so that the R8 can be passed.

> 
>> +static inline long acrn_hypercall2(unsigned long hcall_id,
>> +				   unsigned long param1,
>> +				   unsigned long param2)
>> +{
>> +	register unsigned long r8 asm("r8") = hcall_id;
>> +	register long result asm("rax");
>> +
>> +	asm volatile("vmcall"
>> +			: "=r"(result)
>> +			: "D"(param1), "S"(param2), "r"(r8));
> 
> Ditto.
> 
> Thanks,
> 
> 	Ingo
> 
