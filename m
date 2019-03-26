Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43954C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099B92083D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfCZBFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:05:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:34295 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfCZBFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:05:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 18:00:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,270,1549958400"; 
   d="scan'208";a="134715091"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by fmsmga008.fm.intel.com with ESMTP; 25 Mar 2019 18:00:15 -0700
Subject: Re: [RFC PATCH 2/3] arch/x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR for
 Acrn upcall vector
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Chen, Jason CJ" <jason.cj.chen@intel.com>
References: <1551924251-19466-1-git-send-email-yakui.zhao@intel.com>
 <1551924251-19466-3-git-send-email-yakui.zhao@intel.com>
 <alpine.DEB.2.21.1903221620150.1729@nanos.tec.linutronix.de>
 <01363028D91B0B448414F51B4258CAA574CD3920@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.21.1903250925130.1798@nanos.tec.linutronix.de>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <e2951a1d-83e4-f635-9a2f-b8dbdeea50ec@intel.com>
Date:   Tue, 26 Mar 2019 08:58:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1903250925130.1798@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年03月25日 16:27, Thomas Gleixner wrote:
> On Mon, 25 Mar 2019, Zhao, Yakui wrote:
>>>> +/* SPDX-License-Identifier: GPL-2.0 */ #ifndef _ASM_X86_ACRNHYPER_H
>>>> +#define _ASM_X86_ACRNHYPER_H
>>>> +
>>>> +#include <linux/types.h>
>>>> +#include <asm/io.h>
>>>> +
>>>> +#ifdef CONFIG_ACRN
>>>> +/* ACRN Hypervisor callback */
>>>> +void acrn_hv_callback_vector(void);
>>>
>>> What declares acrn_hv_vector_handler() ?
>>
>> Acrn_hv_callback_vector is defined in arch/x86/entry/entry_64.S, which will be used as
>> the parameter of alloc_intr_gate
>>
>> Acrn_hv_vector_handler is the real ISR handler, which is defined in acrn.c.
> 
> I know how that works and I was not asking where stuff is defined. I was
> asking where it is declared. Global functions need a declaration in a
> header file.

Sure. It will be declared in next version.

> 
>>>> +void acrn_remove_intr_irq(void)
>>>> +{
>>>> +	acrn_intr_handler = NULL;
>>>> +}
>>>> +EXPORT_SYMBOL(acrn_remove_intr_irq);
>>>
>>> Where is the code which uses these exports? We are not adding exports just
>>> because or for consumption by out of tree modules.
>>
>> Understand it.
>> Is it reasonable that the above two functions are added in the driver patch set?
> 
> Yes, because then we see the context.

OK. They will be removed.  And it will be included in driver patch set.

> 
> Thanks,
> 
> 	tglx
> 
