Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A414CC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 01:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81333206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 01:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfDZBtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 21:49:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:22462 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbfDZBtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 21:49:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 18:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,395,1549958400"; 
   d="scan'208";a="152463897"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Apr 2019 18:49:19 -0700
Subject: Re: [RFC PATCH v5 3/4] x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR for
 ACRN guest upcall vector
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        bp@alien8.de, Jason Chen CJ <jason.cj.chen@intel.com>
References: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
 <1556067260-9128-4-git-send-email-yakui.zhao@intel.com>
 <20190425071700.GB57256@gmail.com>
 <a206d93b-9c9e-3cfd-d34f-b9d373edb09e@intel.com>
 <20190425194527.GA52659@gmail.com>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <12c00f28-a1a8-8642-6912-ec9b706b589e@intel.com>
Date:   Fri, 26 Apr 2019 09:46:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190425194527.GA52659@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年04月26日 03:45, Ingo Molnar wrote:
> 
> * Zhao, Yakui <yakui.zhao@intel.com> wrote:
> 
>>>> +	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR,
>>>> +			acrn_hv_callback_vector);
>>>
>>> Why is this on two lines, not a single line?
>>
>> At first it used the long function name for acrn_hv_callback_vector.
>> As it exceeds 80 columns, it is split into two lines.
> 
> No, it doesn't exceed 80 columns - the last character of that line is on
> column 71.

Thanks for the helps.
It will be fixed.
> 
>>> Does the hypervisor model the APIC EOI command, i.e. does it require the
>>> APIC to be acked? I.e. would not acking the APIC create an IRQ storm?
>>
>> The hypervisor requires that the APIC EOI should be acked. If the EOI APIC
>> is not acked, the APIC ISR bit for the HYPERVISOR_CALLBACK_VECTOR will not
>> be cleared and then it will block the interrupt whose vector is lower than
>> HYPERVISOR_CALLBACK_VECTOR.
> 
> Ok!
> 

I will add some comments for calling entering_ack_irq in 
acrn_hv_callback_handler. Is this ok to you?

> Thanks,
> 
> 	Ingo
> 
