Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A70C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E17F2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfDJJRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:17:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:55030 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbfDJJRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:17:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 02:17:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="314651496"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by orsmga005.jf.intel.com with ESMTP; 10 Apr 2019 02:17:41 -0700
Subject: Re: [RFC PATCH v3 2/4] x86: Add the support of ACRN guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        Jason Chen CJ <jason.cj.chen@intel.com>
References: <1554711131-21514-1-git-send-email-yakui.zhao@intel.com>
 <1554711131-21514-3-git-send-email-yakui.zhao@intel.com>
 <20190408143952.GF15689@zn.tnic>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <ab54d5a4-4f4c-9401-2e98-f0ac09d023b1@intel.com>
Date:   Wed, 10 Apr 2019 17:15:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190408143952.GF15689@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年04月08日 22:39, Borislav Petkov wrote:
> On Mon, Apr 08, 2019 at 04:12:09PM +0800, Zhao Yakui wrote:
>> ACRN is an open-source hypervisor maintained by Linuxfoundation.
> 
> I think tglx wanted to say "by the Linux Foundation" here.

Sure. It will be fixed.
> 
>> This is to add the Linux guest support on acrn-hypervisor.
> 
> I think you were told already:
> 
> "Please do not use 'This is to add' or 'This adds'. Just say:
> 
> Add ...."
> 
> So please take your time, work in *all* review feedback instead of
> hurrying the next version out without addressing all review comments.
> 
>> Add x86_hyper_acrn into supported hypervisors array, which enables
>> Linux ACRN guest running on ACRN hypervisor. It is restricted to X86_64.
> 
> So this all talks about *what* the patch does. But that is visible from
> the diff below and doesn't belong in the commit message.
> 
> Rather, your commit message should talk about *why* a change is being
> done.

I will refine the commit log and only talk about "why" a changed is added.

> 
>> Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
>> Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
>> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
>> ---
>> v1->v2: Change the CONFIG_ACRN to CONFIG_ACRN_GUEST, which makes it easy to
>> understand.
>>          Remove the export of x86_hyper_acrn.
>>
>> v2->v3: Remove the unnecessary dependency of PARAVIRT
>> ---
>>   arch/x86/Kconfig                  |  8 ++++++++
>>   arch/x86/include/asm/hypervisor.h |  1 +
>>   arch/x86/kernel/cpu/Makefile      |  1 +
>>   arch/x86/kernel/cpu/acrn.c        | 35 +++++++++++++++++++++++++++++++++++
>>   arch/x86/kernel/cpu/hypervisor.c  |  4 ++++
>>   5 files changed, 49 insertions(+)
>>   create mode 100644 arch/x86/kernel/cpu/acrn.c
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 54d1fbc..d77d215 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -845,6 +845,14 @@ config JAILHOUSE_GUEST
>>   	  cell. You can leave this option disabled if you only want to start
>>   	  Jailhouse and run Linux afterwards in the root cell.
>>   
>> +config ACRN_GUEST
>> +	bool "ACRN Guest support"
>> +	depends on X86_64
>> +	help
>> +	  This option allows to run Linux as guest in ACRN hypervisor. Enabling
>> +	  this will allow the kernel to boot in virtualized environment under
>> +	  the ACRN hypervisor.
> 
> WARNING: please write a paragraph that describes the config symbol fully
> #47: FILE: arch/x86/Kconfig:848:
> +config ACRN_GUEST
> 
> That help text above could use some of the explanation what ACRN is from
> your 0/4 message.
> 

Make sense. I will add some description in patch 0 for the Kconfig 
description.

>> +
>>   endif #HYPERVISOR_GUEST
>>   
>>   source "arch/x86/Kconfig.cpu"
>> diff --git a/arch/x86/include/asm/hypervisor.h b/arch/x86/include/asm/hypervisor.h
>> index 8c5aaba..50a30f6 100644
>> --- a/arch/x86/include/asm/hypervisor.h
>> +++ b/arch/x86/include/asm/hypervisor.h
>> @@ -29,6 +29,7 @@ enum x86_hypervisor_type {
>>   	X86_HYPER_XEN_HVM,
>>   	X86_HYPER_KVM,
>>   	X86_HYPER_JAILHOUSE,
>> +	X86_HYPER_ACRN,
>>   };
>>   
>>   #ifdef CONFIG_HYPERVISOR_GUEST
>> diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
>> index cfd24f9..17a7cdf 100644
>> --- a/arch/x86/kernel/cpu/Makefile
>> +++ b/arch/x86/kernel/cpu/Makefile
>> @@ -44,6 +44,7 @@ obj-$(CONFIG_X86_CPU_RESCTRL)		+= resctrl/
>>   obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
>>   
>>   obj-$(CONFIG_HYPERVISOR_GUEST)		+= vmware.o hypervisor.o mshyperv.o
>> +obj-$(CONFIG_ACRN_GUEST)		+= acrn.o
>>   
>>   ifdef CONFIG_X86_FEATURE_NAMES
>>   quiet_cmd_mkcapflags = MKCAP   $@
>> diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
>> new file mode 100644
>> index 0000000..3956567
>> --- /dev/null
>> +++ b/arch/x86/kernel/cpu/acrn.c
>> @@ -0,0 +1,35 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * ACRN detection support
>> + *
>> + * Copyright (C) 2019 Intel Corporation. All rights reserved.
>> + *
>> + * Jason Chen CJ <jason.cj.chen@intel.com>
>> + * Zhao Yakui <yakui.zhao@intel.com>
>> + *
>> + */
>> +
>> +#include <asm/hypervisor.h>
>> +
>> +static uint32_t __init acrn_detect(void)
>> +{
>> +	return hypervisor_cpuid_base("ACRNACRNACRN\0\0", 0);
>> +}
>> +
>> +static void __init acrn_init_platform(void)
>> +{
>> +}
>> +
>> +static bool acrn_x2apic_available(void)
>> +{
>> +	/* do not support x2apic */
> 
> Why?
> 
> This comment could explain why that choice has been made.
>

Currently the x2apic is not enabled in the first step.
Next step it needs to check the cpu info reported by ACRN hypervisor to 
determine whether the x2apic should be supported.
How about using the below comments?
" x2apic is not supported now. Later it will check the cpu info to 
determine whether the x2apic can be supported or not."

Thanks

