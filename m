Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7AAC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF803208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfFQPyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:54:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:5029 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfFQPyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:54:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 08:54:46 -0700
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.249.171.113]) ([10.249.171.113])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 17 Jun 2019 08:54:43 -0700
Subject: Re: [PATCH RESEND v3 2/3] KVM: vmx: Emulate MSR IA32_UMWAIT_CONTROL
To:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Tao Xu <tao3.xu@intel.com>, pbonzini@redhat.com, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sean.j.christopherson@intel.com, fenghua.yu@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jingqi.liu@intel.com
References: <20190616095555.20978-1-tao3.xu@intel.com>
 <20190616095555.20978-3-tao3.xu@intel.com>
 <d99b2ae1-38fc-0b71-2613-8131decc923a@intel.com>
 <ea1fc40b-8f80-d5f0-6c97-adb245599e07@linux.intel.com>
 <20190617155038.GA13955@flask>
From:   Xiaoyao Li <xiaoyao.li@linux.intel.com>
Message-ID: <5f34bd4b-b3d1-1950-e4d5-8e65c3809ab1@linux.intel.com>
Date:   Mon, 17 Jun 2019 23:54:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617155038.GA13955@flask>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/2019 11:50 PM, Radim Krčmář wrote:
> 2019-06-17 14:31+0800, Xiaoyao Li:
>> On 6/17/2019 11:32 AM, Xiaoyao Li wrote:
>>> On 6/16/2019 5:55 PM, Tao Xu wrote:
>>>> +    if (vmx->msr_ia32_umwait_control != host_umwait_control)
>>>> +        add_atomic_switch_msr(vmx, MSR_IA32_UMWAIT_CONTROL,
>>>> +                      vmx->msr_ia32_umwait_control,
>>>> +                      host_umwait_control, false);
>>>
>>> The bit 1 is reserved, at least, we need to do below to ensure not
>>> modifying the reserved bit:
>>>
>>>       guest_val = (vmx->msr_ia32_umwait_control & ~BIT_ULL(1)) |
>>>               (host_val & BIT_ULL(1))
>>>
>>
>> I find a better solution to ensure reserved bit 1 not being modified in
>> vmx_set_msr() as below:
>>
>> 	if((data ^ umwait_control_cached) & BIT_ULL(1))
>> 		return 1;
> 
> We could just be checking
> 
> 	if (data & BIT_ULL(1))
> 
> because the guest cannot change its visible reserved value and KVM
> currently initializes the value to 0.
> 
> The arch/x86/kernel/cpu/umwait.c series assumes that the reserved bit
> is 0 (hopefully deliberately) and I would do the same in KVM as it
> simplifies the logic.  (We don't have to even think about migrations
> between machines with a different reserved value and making it play
> nicely with possible future implementations of that bit.)
> 

Got it, thanks.

> Thanks.
> 
