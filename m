Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1833BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40352133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbfDJKcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:32:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37813 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbfDJKcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:32:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so1998980wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 03:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/BNROZrm6PZ5befuy2aIvA2u9RjxCk2yKpMYJ0B9w1Y=;
        b=hYt7Dt41JLf5xPI1sh9NCy3/XqJaFQfFSfwAuWT47JRfZaBy2dCmD7not2YhcZU0Hf
         8EBkM1dtiF1MOpuw7ZpcY8HWV95EFMzWKIgK4lUedv+7RqhmsqRDWsxQm1iYqNOjkDUS
         UZjFziPILOO5nVhao9IlH+q7lZX+5HWX+9p0Tc1Q6svxJu+jZh0+TvG9Kk0+28ljUFl3
         CPRzXgTaifMklfJ9vTUFrmEcbwWlthLh8bHfEYWR6Dzhh8nwkp9ngrQOobdwcu0wYL82
         dNY/elGjSLf3In4/oz2ZZl+Iz4Z6f0If8OqI6eS/VsOZHIc4IRKI5Z6lFb2i2W0ueyFN
         TPEA==
X-Gm-Message-State: APjAAAXSQhxHU8xmunnzET2cS15CHIWbtui75norr0yAZHfA992kvbMF
        wYzaI4tNfsiujbf9aBbvB8/uWXlsuR0=
X-Google-Smtp-Source: APXvYqy2ZJgXpCcG6Yj/wrzTYBWrg0p8FmxWkr3YZLt7ROGXQjsRSqGnXbxyeQs/iEOoLfZIHze2LA==
X-Received: by 2002:a1c:2d45:: with SMTP id t66mr2345579wmt.106.1554892370675;
        Wed, 10 Apr 2019 03:32:50 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 61sm118578760wre.50.2019.04.10.03.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 03:32:50 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] selftests: kvm: add a selftest for SMM
In-Reply-To: <c315341a-aa8f-c52f-e02d-8104ba5c0051@redhat.com>
References: <574cf4f1-28d8-a03f-68f2-df9ef2c725ae@redhat.com> <20190410093833.13853-1-vkuznets@redhat.com> <c315341a-aa8f-c52f-e02d-8104ba5c0051@redhat.com>
Date:   Wed, 10 Apr 2019 12:32:49 +0200
Message-ID: <87mukygnfy.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 10/04/19 11:38, Vitaly Kuznetsov wrote:
>> Early RFC, based on state_test.
>> 
>> Add a simplistic test for SMM. Currently it fails with
>> "Unexpected result from KVM_SET_NESTED_STATE" even when a patch fixing
>> rsm after VMXON is added. There's likey some other issue in nested
>> save/restore when SMM os on.
>> 
>> The test implements its own sync between the guest and the host as using
>> our ucall library seems to be too cumbersome: SMI handler is happening in
>> real-address mode.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  tools/testing/selftests/kvm/Makefile          |   1 +
>>  .../selftests/kvm/include/x86_64/processor.h  |  27 +++
>>  tools/testing/selftests/kvm/x86_64/smm_test.c | 159 ++++++++++++++++++
>>  3 files changed, 187 insertions(+)
>>  create mode 100644 tools/testing/selftests/kvm/x86_64/smm_test.c
>> 
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index 3c1f4bdf9000..257955593cdf 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -17,6 +17,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/state_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/evmcs_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/hyperv_cpuid
>>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_close_while_nested_test
>> +TEST_GEN_PROGS_x86_64 += x86_64/smm_test
>>  TEST_GEN_PROGS_x86_64 += dirty_log_test
>>  TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
>>  
>> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
>> index e2884c2b81ff..6063d5b2f356 100644
>> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
>> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
>> @@ -778,6 +778,33 @@ void vcpu_set_msr(struct kvm_vm *vm, uint32_t vcpuid, uint64_t msr_index,
>>  #define MSR_IA32_APICBASE_ENABLE	(1<<11)
>>  #define MSR_IA32_APICBASE_BASE		(0xfffff<<12)
>>  
>> +#define APIC_BASE_MSR	0x800
>> +#define X2APIC_ENABLE	(1UL << 10)
>> +#define	APIC_ICR	0x300
>> +#define		APIC_DEST_SELF		0x40000
>> +#define		APIC_DEST_ALLINC	0x80000
>> +#define		APIC_DEST_ALLBUT	0xC0000
>> +#define		APIC_ICR_RR_MASK	0x30000
>> +#define		APIC_ICR_RR_INVALID	0x00000
>> +#define		APIC_ICR_RR_INPROG	0x10000
>> +#define		APIC_ICR_RR_VALID	0x20000
>> +#define		APIC_INT_LEVELTRIG	0x08000
>> +#define		APIC_INT_ASSERT		0x04000
>> +#define		APIC_ICR_BUSY		0x01000
>> +#define		APIC_DEST_LOGICAL	0x00800
>> +#define		APIC_DEST_PHYSICAL	0x00000
>> +#define		APIC_DM_FIXED		0x00000
>> +#define		APIC_DM_FIXED_MASK	0x00700
>> +#define		APIC_DM_LOWEST		0x00100
>> +#define		APIC_DM_SMI		0x00200
>> +#define		APIC_DM_REMRD		0x00300
>> +#define		APIC_DM_NMI		0x00400
>> +#define		APIC_DM_INIT		0x00500
>> +#define		APIC_DM_STARTUP		0x00600
>> +#define		APIC_DM_EXTINT		0x00700
>> +#define		APIC_VECTOR_MASK	0x000FF
>> +#define	APIC_ICR2	0x310
>> +
>>  #define MSR_IA32_TSCDEADLINE		0x000006e0
>>  
>>  #define MSR_IA32_UCODE_WRITE		0x00000079
>> diff --git a/tools/testing/selftests/kvm/x86_64/smm_test.c b/tools/testing/selftests/kvm/x86_64/smm_test.c
>> new file mode 100644
>> index 000000000000..3452b592588a
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/x86_64/smm_test.c
>> @@ -0,0 +1,159 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2018, Red Hat, Inc.
>> + *
>> + * Tests for SMM.
>> + */
>> +#define _GNU_SOURCE /* for program_invocation_short_name */
>> +#include <fcntl.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <stdint.h>
>> +#include <string.h>
>> +#include <sys/ioctl.h>
>> +
>> +#include "test_util.h"
>> +
>> +#include "kvm_util.h"
>> +
>> +#include "vmx.h"
>> +
>> +#define VCPU_ID	      1
>> +
>> +#define PAGE_SIZE  4096
>> +
>> +#define SMRAM_SIZE (16 * PAGE_SIZE)
>> +#define SMRAM_GPA 0x1000000
>> +#define SMRAM_STAGE 0xfe
>> +
>> +#define STR(x) #x
>> +#define XSTR(s) STR(s)
>> +
>> +#define SYNC_PORT 0xe
>> +#define DONE 0xff
>> +
>> +/*
>> + * This is compiled as normal 64-bit code, however, SMI handler is executed
>> + * in real-address mode. To stay simple we're limiting ourselves to a mode
>> + * independent subset of asm here.
>> + * SMI handler always report back fixed stage SMRAM_STAGE.
>> + */
>> +void smi_handler(void)
>> +{
>> +	asm volatile("mov $" XSTR(SMRAM_STAGE) ", %al \n"
>> +		     "in $" XSTR(SYNC_PORT) ", %al \n"
>> +		     "rsm \n");
>> +}
>> +/* This should change if the code above changes in length */
>> +#define SMI_HANDLER_SIZE 6
>
> Here I had similar code but I just wrote hex instead. :)
>

I enjoyed playing the game "find the right instruction" so we don't need
to have a separate .s file. It seems we're good with the 3-instruction
stub.


>> +
>> +void sync_with_host(uint64_t phase)
>> +{
>> +	asm volatile("in $" XSTR(SYNC_PORT)", %%al \n"
>> +		     : : "a" (phase));
>> +}
>> +
>> +void self_smi(void)
>> +{
>> +	wrmsr(APIC_BASE_MSR + (APIC_ICR >> 4),
>> +	      APIC_DEST_SELF | APIC_INT_ASSERT | APIC_DM_SMI);
>> +}
>> +
>> +void guest_code(struct vmx_pages *vmx_pages)
>> +{
>> +	uint64_t apicbase = rdmsr(MSR_IA32_APICBASE);
>> +
>> +	sync_with_host(1);
>> +
>> +	wrmsr(MSR_IA32_APICBASE, apicbase | X2APIC_ENABLE);
>> +
>> +	sync_with_host(2);
>> +
>> +	self_smi();
>> +
>> +	sync_with_host(4);
>> +
>> +	if (vmx_pages) {
>> +		GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
>> +
>> +		sync_with_host(5);
>> +
>> +		self_smi();
>> +
>> +		sync_with_host(7);
>> +	}
>> +
>> +	sync_with_host(DONE);
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	struct vmx_pages *vmx_pages = NULL;
>> +	vm_vaddr_t vmx_pages_gva = 0;
>> +
>> +	struct kvm_regs regs;
>> +	struct kvm_vm *vm;
>> +	struct kvm_run *run;
>> +	struct kvm_x86_state *state;
>> +	int stage, stage_reported;
>> +
>> +	/* Create VM */
>> +	vm = vm_create_default(VCPU_ID, 0, guest_code);
>> +
>> +	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
>> +
>> +	run = vcpu_state(vm, VCPU_ID);
>> +
>> +	vcpu_regs_get(vm, VCPU_ID, &regs);
>
> Unused?
>

Yes, probably a leftover from state_test

>> +
>> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, SMRAM_GPA,
>> +				    1 << 16 | 1, SMRAM_SIZE/PAGE_SIZE, 0);
>
> Better add a vm_phy_pages_alloc here.
>
> I'll debug the remaining failure and post it again.

Thanks!

>
> Paolo
>
>> +	memset(addr_gpa2hva(vm, SMRAM_GPA), 0x0, SMRAM_SIZE);
>> +	memcpy(addr_gpa2hva(vm, SMRAM_GPA) + 0x8000, smi_handler,
>> +	       SMI_HANDLER_SIZE);
>> +
>> +	vcpu_set_msr(vm, VCPU_ID, MSR_IA32_SMBASE, SMRAM_GPA);
>> +
>> +	if (kvm_check_cap(KVM_CAP_NESTED_STATE)) {
>> +		vmx_pages = vcpu_alloc_vmx(vm, &vmx_pages_gva);
>> +		vcpu_args_set(vm, VCPU_ID, 1, vmx_pages_gva);
>> +	} else {
>> +		printf("will skip SMM test with VMX enabled\n");
>> +		vcpu_args_set(vm, VCPU_ID, 1, 0);
>> +	}
>> +
>> +	for (stage = 1;; stage++) {
>> +		_vcpu_run(vm, VCPU_ID);
>> +		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
>> +			    "Stage %d: unexpected exit reason: %u (%s),\n",
>> +			    stage, run->exit_reason,
>> +			    exit_reason_str(run->exit_reason));
>> +
>> +		memset(&regs, 0, sizeof(regs));
>> +		vcpu_regs_get(vm, VCPU_ID, &regs);
>> +
>> +		stage_reported = regs.rax & 0xff;
>> +
>> +		if (stage_reported == DONE)
>> +			goto done;
>> +
>> +		TEST_ASSERT(stage_reported == stage ||
>> +			    stage_reported == SMRAM_STAGE,
>> +			    "Unexpected stage: #%x, got %x",
>> +			    stage, stage_reported);
>> +
>> +		/* This piece of code needs sharing with state_test/evmcs_test */
>> +		state = vcpu_save_state(vm, VCPU_ID);
>> +		kvm_vm_release(vm);
>> +		kvm_vm_restart(vm, O_RDWR);
>> +		vm_vcpu_add(vm, VCPU_ID, 0, 0);
>> +		vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
>> +		vcpu_load_state(vm, VCPU_ID, state);
>> +		run = vcpu_state(vm, VCPU_ID);
>> +		free(state);
>> +	}
>> +
>> +done:
>> +	kvm_vm_free(vm);
>> +}
>> 
>

-- 
Vitaly
