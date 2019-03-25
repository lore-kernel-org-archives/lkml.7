Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBD5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CEF20811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfCYD5w convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:57:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:51828 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729233AbfCYD5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:57:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2019 20:57:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="134431224"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga008.fm.intel.com with ESMTP; 24 Mar 2019 20:57:51 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 24 Mar 2019 20:57:51 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.158]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.223]) with mapi id 14.03.0415.000;
 Mon, 25 Mar 2019 11:57:48 +0800
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Chen, Jason CJ" <jason.cj.chen@intel.com>
Subject: RE: [RFC PATCH 2/3] arch/x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR
 for Acrn upcall vector
Thread-Topic: [RFC PATCH 2/3] arch/x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR
 for Acrn upcall vector
Thread-Index: AQHU1IozQnkKuHxZv0y0N2CuhOKXu6YXXR6AgARu/WA=
Date:   Mon, 25 Mar 2019 03:57:48 +0000
Message-ID: <01363028D91B0B448414F51B4258CAA574CD3920@SHSMSX101.ccr.corp.intel.com>
References: <1551924251-19466-1-git-send-email-yakui.zhao@intel.com>
 <1551924251-19466-3-git-send-email-yakui.zhao@intel.com>
 <alpine.DEB.2.21.1903221620150.1729@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903221620150.1729@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDgzNGM4YzItYzEzMC00MjQxLThiNmUtNjJkMzZlMWVhOTQxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRURkNEVuTzAyUEJkaHdaMHpcL1JrSkZKWk5vbklUQ2pvenRMeWp4VFpoNlwvRHJhREFtNnhzVURnZDF6Nm84UHpBIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Thomas Gleixner [mailto:tglx@linutronix.de]
>Sent: Friday, March 22, 2019 11:45 PM
>To: Zhao, Yakui <yakui.zhao@intel.com>
>Cc: linux-kernel@vger.kernel.org; x86@kernel.org; Chen, Jason CJ
><jason.cj.chen@intel.com>
>Subject: Re: [RFC PATCH 2/3] arch/x86/acrn: Use
>HYPERVISOR_CALLBACK_VECTOR for Acrn upcall vector
>
>On Thu, 7 Mar 2019, Zhao Yakui wrote:
>
>> WHen it works in hypervisor guest mode, Linux kernel uses the
>> HYPERVISOR_CALLBACK_VECTOR for hypervisor upcall vector. And it is
>> already used for Xen and HyperV. After Acrn hypervisor is detected, it
>> will also use this defined vector as notify vector to kernel.
>> And two APIs are added so that the other module can add/remove the
>> hypervisor callback irq handler.
>
>Which other module?
>

This work is divided into two steps. The first is to add the support of acrn-guest under arch/x86.
The second is to add one driver that allows the acrn-guest to communicate with the acrn-hypervisor.
As the second part has the dependency on the first part,  we hope that the acrn-guest is added firstly and the
required API is also added.

>> Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
>> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
>
>Same SOB issue.

Sure. It will be updated.

>
>> +#if IS_ENABLED(CONFIG_ACRN)
>> +apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
>> +	acrn_hv_callback_vector acrn_hv_vector_handler #endif
>> +
>>  idtentry debug			do_debug
>	has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
>>  idtentry int3			do_int3			has_error_code=0
>>  idtentry stack_segment		do_stack_segment
>	has_error_code=1
>> diff --git a/arch/x86/include/asm/acrnhyper.h
>> b/arch/x86/include/asm/acrnhyper.h
>> new file mode 100644
>> index 0000000..2562a82
>> --- /dev/null
>> +++ b/arch/x86/include/asm/acrnhyper.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */ #ifndef _ASM_X86_ACRNHYPER_H
>> +#define _ASM_X86_ACRNHYPER_H
>> +
>> +#include <linux/types.h>
>> +#include <asm/io.h>
>> +
>> +#ifdef CONFIG_ACRN
>> +/* ACRN Hypervisor callback */
>> +void acrn_hv_callback_vector(void);
>
>What declares acrn_hv_vector_handler() ?

Acrn_hv_callback_vector is defined in arch/x86/entry/entry_64.S, which will be used as
the parameter of alloc_intr_gate

Acrn_hv_vector_handler is the real ISR handler, which is defined in acrn.c.

>
>>  #include <asm/hypervisor.h>
>> +#include <asm/acrnhyper.h>
>> +#include <asm/irq_vectors.h>
>> +#include <asm/irq_regs.h>
>> +#include <asm/desc.h>
>> +#include <linux/interrupt.h>
>
>First of all the include order is always:
>
> #include <linux/...>
> #include <linux/...>
>
> #include <asm/...>
>
>Aside of that including 'linux/irq.h' should include everything you need. No
>need for gazillion of includes.

OK. The include order will be updated in next version.

>
>>  static bool acrn_x2apic_available(void) @@ -26,6 +33,37 @@ static
>> bool acrn_x2apic_available(void)
>>  	return false;
>>  }
>>
>> +
>
>Stray newline
>

Sure. The extra newline will be removed.

>> +static void (*acrn_intr_handler)(void);
>> +/*
>
>Which should have been above this comment. Glueing stuff together makes it
>unreadable.
>
>> + * Handler for ACRN_HV_CALLBACK.
>
>Err? This handles the HYPERVISOR_CALLBACK_VECTOR
>

I will remove the confusing comment.
In fact this acrn_intr_handle is similar to the vmbus_handler in arch/x86/kernel/cpu/mshyperv.c

>> + */
>> +__visible void __irq_entry acrn_hv_vector_handler(struct pt_regs
>> +*regs) {
>> +	struct pt_regs *old_regs = set_irq_regs(regs);
>> +
>> +	entering_ack_irq();
>> +	inc_irq_stat(irq_hv_callback_count);
>> +
>> +	if (acrn_intr_handler)
>> +		acrn_intr_handler();
>> +
>> +	exiting_irq();
>> +	set_irq_regs(old_regs);
>> +}
>> +
>> +void acrn_setup_intr_irq(void (*handler)(void)) {
>> +	acrn_intr_handler = handler;
>> +}
>> +EXPORT_SYMBOL(acrn_setup_intr_irq);
>> +
>> +void acrn_remove_intr_irq(void)
>> +{
>> +	acrn_intr_handler = NULL;
>> +}
>> +EXPORT_SYMBOL(acrn_remove_intr_irq);
>
>Where is the code which uses these exports? We are not adding exports just
>because or for consumption by out of tree modules.

Understand it.
Is it reasonable that the above two functions are added in the driver patch set?


>
>Thanks,
>
>	tglx
