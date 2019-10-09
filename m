Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E310CECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3B72133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbfJIKmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:42:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbfJIKmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:42:05 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AF177EBAE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 10:42:04 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id k2so920206wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 03:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=J8hSvrVM0n390UEyk1W8JHtorTgdd/DsWaNeJyfqLMw=;
        b=WXbe4o4AnMSUcbB7Qw6gZ92+m7sKsBEKCZLOaqYwDP/s6uGuB1a6FnOgfIQ/Gbpi5b
         EZhp2PztSx9i4Pr5zwqPW6DoGAn4QQzTjB45MpbsGx/bGW4GpAqjpkVVFMJyElxjQHyW
         WPg877Ns9gZ42FTfZ3fzp8iLMpVfVMJ1eDDBrMJ63c3xq22j8F93VS+LPApBEi1XP3Zz
         j776w6zZi8P3UlHAAIn0D4AHMGkiUw4QBPDLfkkaKjSvVzhQB9GubxEPsuJvUAmmFV/C
         iZsVg5KRZVXsO+gkJsh9VfWbLOw6u8w0kGj/UsqGkAnUhqgkLdx/sNHBk+INrK2DbxXa
         EomA==
X-Gm-Message-State: APjAAAVRxiTyyf7VoTHIVBs9H9s6p3FaD/dcTWDtCdEgJY7z+cdZaYyi
        qXC7nAV9FE4dshh893AARmzvM5c4g7METiimnNVYKHX4oXzP/9iXMcWD/VaolwqxyiV+5QOG3M/
        9AYgUbl1ZFCRShH/zt2A8XlZ3
X-Received: by 2002:adf:910d:: with SMTP id j13mr2335541wrj.128.1570617722372;
        Wed, 09 Oct 2019 03:42:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzwmwVD31cDLK8BjOCmTyIAFDGFk9Cn8qZooiVBtZuUy2HwZA2nWc9whzpr9tFtVykpjpOVaA==
X-Received: by 2002:adf:910d:: with SMTP id j13mr2335514wrj.128.1570617722044;
        Wed, 09 Oct 2019 03:42:02 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w9sm3591809wrt.62.2019.10.09.03.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 03:42:01 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH] selftests: kvm: fix sync_regs_test with newer gccs
In-Reply-To: <b7d20806-4e88-91af-31c1-8cbb0a8a330b@redhat.com>
References: <20191008180808.14181-1-vkuznets@redhat.com> <20191008183634.GF14020@linux.intel.com> <b7d20806-4e88-91af-31c1-8cbb0a8a330b@redhat.com>
Date:   Wed, 09 Oct 2019 12:42:00 +0200
Message-ID: <87d0f6yzd3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 08/10/19 20:36, Sean Christopherson wrote:
>> On Tue, Oct 08, 2019 at 08:08:08PM +0200, Vitaly Kuznetsov wrote:
>>> Commit 204c91eff798a ("KVM: selftests: do not blindly clobber registers in
>>>  guest asm") was intended to make test more gcc-proof, however, the result
>>> is exactly the opposite: on newer gccs (e.g. 8.2.1) the test breaks with
>>>
>>> ==== Test Assertion Failure ====
>>>   x86_64/sync_regs_test.c:168: run->s.regs.regs.rbx == 0xBAD1DEA + 1
>>>   pid=14170 tid=14170 - Invalid argument
>>>      1	0x00000000004015b3: main at sync_regs_test.c:166 (discriminator 6)
>>>      2	0x00007f413fb66412: ?? ??:0
>>>      3	0x000000000040191d: _start at ??:?
>>>   rbx sync regs value incorrect 0x1.
>>>
>>> Apparently, compile is still free to play games with registers even
>>> when they have variables attaches.
>>>
>>> Re-write guest code with 'asm volatile' by embedding ucall there and
>>> making sure rbx is preserved.
>>>
>>> Fixes: 204c91eff798a ("KVM: selftests: do not blindly clobber registers in guest asm")
>>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>>> ---
>>>  .../selftests/kvm/x86_64/sync_regs_test.c     | 21 ++++++++++---------
>>>  1 file changed, 11 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
>>> index 11c2a70a7b87..5c8224256294 100644
>>> --- a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
>>> +++ b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
>>> @@ -22,18 +22,19 @@
>>>  
>>>  #define VCPU_ID 5
>>>  
>>> +#define UCALL_PIO_PORT ((uint16_t)0x1000)
>>> +
>>> +/*
>>> + * ucall is embedded here to protect against compiler reshuffling registers
>>> + * before calling a function. In this test we only need to get KVM_EXIT_IO
>>> + * vmexit and preserve RBX, no additional information is needed.
>>> + */
>>>  void guest_code(void)
>>>  {
>>> -	/*
>>> -	 * use a callee-save register, otherwise the compiler
>>> -	 * saves it around the call to GUEST_SYNC.
>>> -	 */
>>> -	register u32 stage asm("rbx");
>>> -	for (;;) {
>>> -		GUEST_SYNC(0);
>>> -		stage++;
>>> -		asm volatile ("" : : "r" (stage));
>>> -	}
>>> +	asm volatile("1: in %[port], %%al\n"
>>> +		     "add $0x1, %%rbx\n"
>>> +		     "jmp 1b"
>>> +		     : : [port] "d" (UCALL_PIO_PORT) : "rax", "rbx");
>>>  }
>> 
>> To make the code truly bulletproof, is it possible to rename guest_code()
>> to guest_code_wrapper() and then export 1: as guest_code?  VM-Enter will
>> jump directly to the relevant code and gcc can't touch rbx.  E.g.:
>> 
>> 	asm volatile("1: ..."
>> 		     ".global guest_code"
>> 		     "guest_code: " _ASM_PTR " 1b");
>> 
>> Not sure if that works with how the selftests are compiled.  It may also
>> be possible to simply replace '1' with 'guest_code'.
>
> There is no practical difference with Vitaly's patch.  The first
> _vcpu_run has no pre-/post-conditions on the value of %rbx:
>

I think what Sean was suggesting is to prevent GCC from inserting
anything (and thus clobbering RBX) between the call to guest_call() and
the beginning of 'asm volatile' block by calling *inside* 'asm volatile'
block instead.

>
>         run->kvm_valid_regs = TEST_SYNC_FIELDS;
>         rv = _vcpu_run(vm, VCPU_ID);
>         TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
>                     "Unexpected exit reason: %u (%s),\n",
>                     run->exit_reason,
>                     exit_reason_str(run->exit_reason));
>
> 	/*
> 	 * Then it goes on comparing regs/sregs/events, but does not
> 	 * check for specific values.
> 	 */
>
> As soon as that first _vcpu_run succeeds, you're stuck in the in/add/jmp
> loop and the compiler can't trick you anymore.
>
> So, I'm queuing the patch.
>

Thanks!

-- 
Vitaly
