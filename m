Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61DCC282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B770205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbfDYMou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:44:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:35426 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387943AbfDYMor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:44:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 05:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; 
   d="scan'208";a="340714255"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by fmsmga006.fm.intel.com with ESMTP; 25 Apr 2019 05:44:46 -0700
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Subject: Re: [RFC PATCH v5 3/4] x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR for
 ACRN guest upcall vector
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        bp@alien8.de, Jason Chen CJ <jason.cj.chen@intel.com>
References: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
 <1556067260-9128-4-git-send-email-yakui.zhao@intel.com>
 <20190425071700.GB57256@gmail.com>
Message-ID: <a206d93b-9c9e-3cfd-d34f-b9d373edb09e@intel.com>
Date:   Thu, 25 Apr 2019 20:42:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190425071700.GB57256@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年04月25日 15:17, Ingo Molnar wrote:
> 
> * Zhao Yakui <yakui.zhao@intel.com> wrote:
> 
>> Linux kernel uses the HYPERVISOR_CALLBACK_VECTOR for hypervisor upcall
>> vector. And it is already used for Xen and HyperV.
> 
> English sentences should not be started with 'and'.

OK. I will remove it.

> 
>> After ACRN hypervisor is detected, it will also use this defined vector
>> to notify ACRN guest.
> 
> Missing 'the', twice.

OK. It will be added.

> 
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_X86_ACRN_H
>> +#define _ASM_X86_ACRN_H
>> +
>> +void acrn_hv_callback_vector(void);
> 
> Please mark these with 'extern', as customary in x86 headers.

OK. The "extern" will be added.

> 
>>   
>> +#include <linux/interrupt.h>
>> +#include <asm/acrn.h>
>> +#include <asm/desc.h>
>>   #include <asm/hypervisor.h>
>> +#include <asm/irq_regs.h>
>>   
>>   static uint32_t __init acrn_detect(void)
>>   {
>> @@ -18,6 +22,8 @@ static uint32_t __init acrn_detect(void)
>>   
>>   static void __init acrn_init_platform(void)
>>   {
>> +	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR,
>> +			acrn_hv_callback_vector);
> 
> Why is this on two lines, not a single line?

At first it used the long function name for acrn_hv_callback_vector.
As it exceeds 80 columns, it is split into two lines.
I will check it and see whether it can be fit into one single line.
If it is ok, it will be in one single line.

> 
>> +static void (*acrn_intr_handler)(void);
>> +
>> +__visible void __irq_entry acrn_hv_vector_handler(struct pt_regs *regs)
>> +{
>> +	struct pt_regs *old_regs = set_irq_regs(regs);
>> +
>> +	entering_ack_irq();
> 
> Does the hypervisor model the APIC EOI command, i.e. does it require the
> APIC to be acked? I.e. would not acking the APIC create an IRQ storm?

The hypervisor requires that the APIC EOI should be acked. If the EOI 
APIC is not acked, the APIC ISR bit for the HYPERVISOR_CALLBACK_VECTOR 
will not be cleared and then it will block the interrupt whose vector is 
lower than HYPERVISOR_CALLBACK_VECTOR.

> 
>> +	inc_irq_stat(irq_hv_callback_count);
>> +
>> +	if (acrn_intr_handler)
>> +		acrn_intr_handler();
> 
> Nothing appears to be setting acrn_intr_handler, so this will never
> execute anything? Is more code relying on this?

Nothing will be done in this patch.
Later the driver part code will be added and it needs to add/remove the 
corresponding driver handler. It is similar to vmbus_handler in 
hyperv_vector_handler.

> 
> Thanks,
> 
> 	Ingo
> 
