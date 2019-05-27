Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9B3C282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 02:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E3E2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 02:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfE0CZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 22:25:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:3428 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfE0CZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 22:25:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 May 2019 19:25:03 -0700
X-ExtLoop1: 1
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2019 19:25:02 -0700
Subject: Re: [PATCH v6 3/4] x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR for ACRN
 guest upcall vector
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        Jason Chen CJ <jason.cj.chen@intel.com>
References: <1556595926-17910-1-git-send-email-yakui.zhao@intel.com>
 <1556595926-17910-4-git-send-email-yakui.zhao@intel.com>
 <20190515172356.GL24212@zn.tnic>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <27c20325-61b7-994f-2781-f4bc41badc6f@intel.com>
Date:   Mon, 27 May 2019 10:21:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190515172356.GL24212@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年05月16日 01:23, Borislav Petkov wrote:
> On Tue, Apr 30, 2019 at 11:45:25AM +0800, Zhao Yakui wrote:
>> @@ -30,6 +36,29 @@ static bool acrn_x2apic_available(void)
>>   	return false;
>>   }
>>   
>> +static void (*acrn_intr_handler)(void);
>> +
>> +__visible void __irq_entry acrn_hv_vector_handler(struct pt_regs *regs)
>> +{
>> +	struct pt_regs *old_regs = set_irq_regs(regs);
>> +
>> +	/*
>> +	 * The hypervisor requires that the APIC EOI should be acked.
>> +	 * If the APIC EOI is not acked, the APIC ISR bit for the
>> +	 * HYPERVISOR_CALLBACK_VECTOR will not be cleared and then it
>> +	 * will block the interrupt whose vector is lower than
>> +	 * HYPERVISOR_CALLBACK_VECTOR.
>> +	 */
>> +	entering_ack_irq();

Sorry for the late response.

You are right. The "asm/apic.h" is missing.
It will be added.
Very sorry that this issue is not triggered as the used .config in my 
test doesn't enable the check of "-Werror=implict-function-declaration".

> 
> arch/x86/kernel/cpu/acrn.c: In function ‘acrn_hv_vector_handler’:
> arch/x86/kernel/cpu/acrn.c:52:2: error: implicit declaration of function ‘entering_ack_irq’; did you mean ‘spin_lock_irq’? [-Werror=implicit-function-declaration]
>    entering_ack_irq();
>    ^~~~~~~~~~~~~~~~
>    spin_lock_irq
> arch/x86/kernel/cpu/acrn.c:58:2: error: implicit declaration of function ‘exiting_irq’; did you mean ‘in_irq’? [-Werror=implicit-function-declaration]
>    exiting_irq();
>    ^~~~~~~~~~~
>    in_irq
> cc1: some warnings being treated as errors
> make[3]: *** [scripts/Makefile.build:278: arch/x86/kernel/cpu/acrn.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.build:489: arch/x86/kernel/cpu] Error 2
> make[1]: *** [scripts/Makefile.build:489: arch/x86/kernel] Error 2
> make: *** [Makefile:1073: arch/x86] Error 2
> make: *** Waiting for unfinished jobs....
> 
> Looks like it needs
> 
> +#include <asm/apic.h>
> 
> config attached.
> 
