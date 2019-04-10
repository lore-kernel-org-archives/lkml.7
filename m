Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79583C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6CC20818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfDJH7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:59:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:62398 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfDJH7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:59:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 00:59:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="314631231"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by orsmga005.jf.intel.com with ESMTP; 10 Apr 2019 00:59:01 -0700
Subject: Re: [RFC PATCH v3 3/4] x86: Use HYPERVISOR_CALLBACK_VECTOR for
 acrn_guest upcall vector
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        Jason Chen CJ <jason.cj.chen@intel.com>
References: <1554711131-21514-1-git-send-email-yakui.zhao@intel.com>
 <1554711131-21514-4-git-send-email-yakui.zhao@intel.com>
 <20190408150011.GH15689@zn.tnic>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <36ff9827-da90-0736-f0a4-2f38b9c8bf3b@intel.com>
Date:   Wed, 10 Apr 2019 15:57:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190408150011.GH15689@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年04月08日 23:00, Borislav Petkov wrote:
> You can prefix your subject now like this:
> 
> x86/acrn: Use ...

Thanks for suggestion.
It will be updated in next version.

> 
> On Mon, Apr 08, 2019 at 04:12:10PM +0800, Zhao Yakui wrote:
>> Linux kernel uses the HYPERVISOR_CALLBACK_VECTOR for hypervisor upcall
>> vector. And it is already used for Xen and HyperV.
>> After Acrn hypervisor is detected, it will also use this defined vector
>> to notify kernel.
>>
>> Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
>> Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
>> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
>> ---
>> V1->V2: Remove the unused API definition of acrn_setup_intr_handler and
>> acrn_remove_intr_handler.
>>          Adjust the order of header file
>>          Add the declaration of acrn_hv_vector_handler and tracing
>> definition of acrn_hv_callback_vector.
>> ---
>>   arch/x86/Kconfig                 |  1 +
>>   arch/x86/entry/entry_64.S        |  5 +++++
>>   arch/x86/include/asm/acrnhyper.h | 19 +++++++++++++++++++
>>   arch/x86/kernel/cpu/acrn.c       | 22 ++++++++++++++++++++++
>>   4 files changed, 47 insertions(+)
>>   create mode 100644 arch/x86/include/asm/acrnhyper.h
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index d77d215..ae4d38b 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -848,6 +848,7 @@ config JAILHOUSE_GUEST
>>   config ACRN_GUEST
>>   	bool "ACRN Guest support"
>>   	depends on X86_64
>> +	select X86_HV_CALLBACK_VECTOR
>>   	help
>>   	  This option allows to run Linux as guest in ACRN hypervisor. Enabling
>>   	  this will allow the kernel to boot in virtualized environment under
>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>> index 1f0efdb..d1b8ad3 100644
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -1129,6 +1129,11 @@ apicinterrupt3 HYPERV_STIMER0_VECTOR \
>>   	hv_stimer0_callback_vector hv_stimer0_vector_handler
>>   #endif /* CONFIG_HYPERV */
>>   
>> +#if IS_ENABLED(CONFIG_ACRN_GUEST)
>> +apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
>> +	acrn_hv_callback_vector acrn_hv_vector_handler
>> +#endif
>> +
>>   idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
>>   idtentry int3			do_int3			has_error_code=0
>>   idtentry stack_segment		do_stack_segment	has_error_code=1
>> diff --git a/arch/x86/include/asm/acrnhyper.h b/arch/x86/include/asm/acrnhyper.h
>> new file mode 100644
>> index 0000000..9f9c239
>> --- /dev/null
>> +++ b/arch/x86/include/asm/acrnhyper.h
> 
> Simply
> 
> 	.../acrn.h
> 
> I'd say.

OK. The simplifed file name(acrn.h) will be used in next version.

> 
>> @@ -0,0 +1,19 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_X86_ACRNHYPER_H
>> +#define _ASM_X86_ACRNHYPER_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/atomic.h>
>> +#include <linux/nmi.h>
>> +#include <asm/io.h>
>> +
>> +#ifdef CONFIG_ACRN_GUEST
> 
> Why is that ifdef needed?

It is used to avoid that one function declaration has no definition when 
asm/acrnhyper.h is included and ACRN_GUEST is not enabled.

> 
>> +void acrn_hv_callback_vector(void);
>> +#ifdef CONFIG_TRACING
>> +#define trace_acrn_hv_callback_vector acrn_hv_callback_vector
>> +#endif
>> +
>> +void acrn_hv_vector_handler(struct pt_regs *regs);
> 
> end marker:
> 
> #endif /* _ASM_X86_ACRNHYPER_H */

It will be added in next version.

> 
>> diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
>> index 3956567..7a233b5 100644
>> --- a/arch/x86/kernel/cpu/acrn.c
>> +++ b/arch/x86/kernel/cpu/acrn.c
>> @@ -9,7 +9,11 @@
>>    *
>>    */
>>   
>> +#include <linux/interrupt.h>
>>   #include <asm/hypervisor.h>
>> +#include <asm/acrnhyper.h>
>> +#include <asm/desc.h>
>> +#include <asm/irq_regs.h>
> 
> What's the sorting order here? Length or alphabetic? Or none? :)

Sorry that I don't consider the oder.
The required new header file is appended one by one. Of course linux/ 
path and asm / are appended separately.
Do you have any suggestion about the header order?

> 
> linux/ path includes still need to come first, of course.
> 
