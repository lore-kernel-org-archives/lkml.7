Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4842ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B31F20673
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfJIJmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:42:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbfJIJmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:42:20 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CAC48859FE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 09:42:19 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id q9so783455wmj.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 02:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2SfK+bwB/cF2Z8hlX+aReQdgBCXk+L/5n2wFayhP4Gk=;
        b=mZamM1iFC/4hrzJrxiH/ahvXukLcx8ml93xgLAjCxpPzaCF7gNsQVBSnIWzJQVv7l5
         3siJDfMbIyq0Loq5wtHg9EY6d6ZTzIA6gS1I7A7KcMyrTmHdMVUnXyKfCE+vY8cKjJAm
         dV+TevoIqCdI/ieBxGi6EMewqCH6aIA0KmdZiyu1OWgNL0PVf7vU73JRKC6zc3C4bPS0
         hwGfr/AxBIUDMY1LaSejhpOBAGz67giioBUjVe1fO9arhR5IEN2uahuagVjTm09bmHdy
         qCUpYLgggWpPlrX975QQq6EOqiSNPQdj8ZKxi9cL4VynZicT736DNuhtfupi+f63QJnu
         oM4Q==
X-Gm-Message-State: APjAAAWgw3A6aKWekGExFaFk0F8Vtaogf75eY8xElO1WpGJlHf+hZIFA
        jzAT1opgHKCOcx4Las6OtqyKQuQTgePfb3HRfvL2USYH5o7+4RtLZsxk7YmF+obb3hSZbfdoGrB
        eOgiLkI/QTzS0ZiVwxArwbzk/
X-Received: by 2002:a1c:a8c9:: with SMTP id r192mr1857215wme.152.1570614138036;
        Wed, 09 Oct 2019 02:42:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyKjouqMbMNxTFuGL86nTyCiQqhfx17sz5oE1whEuLV7eS6sbY4ojO1la5n7F9GzBChRhx60g==
X-Received: by 2002:a1c:a8c9:: with SMTP id r192mr1857192wme.152.1570614137681;
        Wed, 09 Oct 2019 02:42:17 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id c9sm1607213wrt.7.2019.10.09.02.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 02:42:17 -0700 (PDT)
Subject: Re: [PATCH] selftests: kvm: fix sync_regs_test with newer gccs
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>
References: <20191008180808.14181-1-vkuznets@redhat.com>
 <20191008183634.GF14020@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b7d20806-4e88-91af-31c1-8cbb0a8a330b@redhat.com>
Date:   Wed, 9 Oct 2019 11:42:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008183634.GF14020@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/19 20:36, Sean Christopherson wrote:
> On Tue, Oct 08, 2019 at 08:08:08PM +0200, Vitaly Kuznetsov wrote:
>> Commit 204c91eff798a ("KVM: selftests: do not blindly clobber registers in
>>  guest asm") was intended to make test more gcc-proof, however, the result
>> is exactly the opposite: on newer gccs (e.g. 8.2.1) the test breaks with
>>
>> ==== Test Assertion Failure ====
>>   x86_64/sync_regs_test.c:168: run->s.regs.regs.rbx == 0xBAD1DEA + 1
>>   pid=14170 tid=14170 - Invalid argument
>>      1	0x00000000004015b3: main at sync_regs_test.c:166 (discriminator 6)
>>      2	0x00007f413fb66412: ?? ??:0
>>      3	0x000000000040191d: _start at ??:?
>>   rbx sync regs value incorrect 0x1.
>>
>> Apparently, compile is still free to play games with registers even
>> when they have variables attaches.
>>
>> Re-write guest code with 'asm volatile' by embedding ucall there and
>> making sure rbx is preserved.
>>
>> Fixes: 204c91eff798a ("KVM: selftests: do not blindly clobber registers in guest asm")
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  .../selftests/kvm/x86_64/sync_regs_test.c     | 21 ++++++++++---------
>>  1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
>> index 11c2a70a7b87..5c8224256294 100644
>> --- a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
>> +++ b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
>> @@ -22,18 +22,19 @@
>>  
>>  #define VCPU_ID 5
>>  
>> +#define UCALL_PIO_PORT ((uint16_t)0x1000)
>> +
>> +/*
>> + * ucall is embedded here to protect against compiler reshuffling registers
>> + * before calling a function. In this test we only need to get KVM_EXIT_IO
>> + * vmexit and preserve RBX, no additional information is needed.
>> + */
>>  void guest_code(void)
>>  {
>> -	/*
>> -	 * use a callee-save register, otherwise the compiler
>> -	 * saves it around the call to GUEST_SYNC.
>> -	 */
>> -	register u32 stage asm("rbx");
>> -	for (;;) {
>> -		GUEST_SYNC(0);
>> -		stage++;
>> -		asm volatile ("" : : "r" (stage));
>> -	}
>> +	asm volatile("1: in %[port], %%al\n"
>> +		     "add $0x1, %%rbx\n"
>> +		     "jmp 1b"
>> +		     : : [port] "d" (UCALL_PIO_PORT) : "rax", "rbx");
>>  }
> 
> To make the code truly bulletproof, is it possible to rename guest_code()
> to guest_code_wrapper() and then export 1: as guest_code?  VM-Enter will
> jump directly to the relevant code and gcc can't touch rbx.  E.g.:
> 
> 	asm volatile("1: ..."
> 		     ".global guest_code"
> 		     "guest_code: " _ASM_PTR " 1b");
> 
> Not sure if that works with how the selftests are compiled.  It may also
> be possible to simply replace '1' with 'guest_code'.

There is no practical difference with Vitaly's patch.  The first
_vcpu_run has no pre-/post-conditions on the value of %rbx:


        run->kvm_valid_regs = TEST_SYNC_FIELDS;
        rv = _vcpu_run(vm, VCPU_ID);
        TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
                    "Unexpected exit reason: %u (%s),\n",
                    run->exit_reason,
                    exit_reason_str(run->exit_reason));

	/*
	 * Then it goes on comparing regs/sregs/events, but does not
	 * check for specific values.
	 */

As soon as that first _vcpu_run succeeds, you're stuck in the in/add/jmp
loop and the compiler can't trick you anymore.

So, I'm queuing the patch.

Paolo
