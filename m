Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BA0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AD22133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfDJKKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:10:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbfDJKKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:10:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF93A308950C;
        Wed, 10 Apr 2019 10:10:41 +0000 (UTC)
Received: from [10.36.112.57] (ovpn-112-57.ams2.redhat.com [10.36.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FE9C6013D;
        Wed, 10 Apr 2019 10:10:23 +0000 (UTC)
Subject: Re: [RFC] selftests: kvm: add a selftest for SMM
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
References: <574cf4f1-28d8-a03f-68f2-df9ef2c725ae@redhat.com>
 <20190410093833.13853-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
 uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <c315341a-aa8f-c52f-e02d-8104ba5c0051@redhat.com>
Date:   Wed, 10 Apr 2019 12:10:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410093833.13853-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 10 Apr 2019 10:10:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/19 11:38, Vitaly Kuznetsov wrote:
> Early RFC, based on state_test.
> 
> Add a simplistic test for SMM. Currently it fails with
> "Unexpected result from KVM_SET_NESTED_STATE" even when a patch fixing
> rsm after VMXON is added. There's likey some other issue in nested
> save/restore when SMM os on.
> 
> The test implements its own sync between the guest and the host as using
> our ucall library seems to be too cumbersome: SMI handler is happening in
> real-address mode.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/include/x86_64/processor.h  |  27 +++
>  tools/testing/selftests/kvm/x86_64/smm_test.c | 159 ++++++++++++++++++
>  3 files changed, 187 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/smm_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 3c1f4bdf9000..257955593cdf 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -17,6 +17,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/state_test
>  TEST_GEN_PROGS_x86_64 += x86_64/evmcs_test
>  TEST_GEN_PROGS_x86_64 += x86_64/hyperv_cpuid
>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_close_while_nested_test
> +TEST_GEN_PROGS_x86_64 += x86_64/smm_test
>  TEST_GEN_PROGS_x86_64 += dirty_log_test
>  TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
>  
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index e2884c2b81ff..6063d5b2f356 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -778,6 +778,33 @@ void vcpu_set_msr(struct kvm_vm *vm, uint32_t vcpuid, uint64_t msr_index,
>  #define MSR_IA32_APICBASE_ENABLE	(1<<11)
>  #define MSR_IA32_APICBASE_BASE		(0xfffff<<12)
>  
> +#define APIC_BASE_MSR	0x800
> +#define X2APIC_ENABLE	(1UL << 10)
> +#define	APIC_ICR	0x300
> +#define		APIC_DEST_SELF		0x40000
> +#define		APIC_DEST_ALLINC	0x80000
> +#define		APIC_DEST_ALLBUT	0xC0000
> +#define		APIC_ICR_RR_MASK	0x30000
> +#define		APIC_ICR_RR_INVALID	0x00000
> +#define		APIC_ICR_RR_INPROG	0x10000
> +#define		APIC_ICR_RR_VALID	0x20000
> +#define		APIC_INT_LEVELTRIG	0x08000
> +#define		APIC_INT_ASSERT		0x04000
> +#define		APIC_ICR_BUSY		0x01000
> +#define		APIC_DEST_LOGICAL	0x00800
> +#define		APIC_DEST_PHYSICAL	0x00000
> +#define		APIC_DM_FIXED		0x00000
> +#define		APIC_DM_FIXED_MASK	0x00700
> +#define		APIC_DM_LOWEST		0x00100
> +#define		APIC_DM_SMI		0x00200
> +#define		APIC_DM_REMRD		0x00300
> +#define		APIC_DM_NMI		0x00400
> +#define		APIC_DM_INIT		0x00500
> +#define		APIC_DM_STARTUP		0x00600
> +#define		APIC_DM_EXTINT		0x00700
> +#define		APIC_VECTOR_MASK	0x000FF
> +#define	APIC_ICR2	0x310
> +
>  #define MSR_IA32_TSCDEADLINE		0x000006e0
>  
>  #define MSR_IA32_UCODE_WRITE		0x00000079
> diff --git a/tools/testing/selftests/kvm/x86_64/smm_test.c b/tools/testing/selftests/kvm/x86_64/smm_test.c
> new file mode 100644
> index 000000000000..3452b592588a
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/smm_test.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018, Red Hat, Inc.
> + *
> + * Tests for SMM.
> + */
> +#define _GNU_SOURCE /* for program_invocation_short_name */
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +
> +#include "test_util.h"
> +
> +#include "kvm_util.h"
> +
> +#include "vmx.h"
> +
> +#define VCPU_ID	      1
> +
> +#define PAGE_SIZE  4096
> +
> +#define SMRAM_SIZE (16 * PAGE_SIZE)
> +#define SMRAM_GPA 0x1000000
> +#define SMRAM_STAGE 0xfe
> +
> +#define STR(x) #x
> +#define XSTR(s) STR(s)
> +
> +#define SYNC_PORT 0xe
> +#define DONE 0xff
> +
> +/*
> + * This is compiled as normal 64-bit code, however, SMI handler is executed
> + * in real-address mode. To stay simple we're limiting ourselves to a mode
> + * independent subset of asm here.
> + * SMI handler always report back fixed stage SMRAM_STAGE.
> + */
> +void smi_handler(void)
> +{
> +	asm volatile("mov $" XSTR(SMRAM_STAGE) ", %al \n"
> +		     "in $" XSTR(SYNC_PORT) ", %al \n"
> +		     "rsm \n");
> +}
> +/* This should change if the code above changes in length */
> +#define SMI_HANDLER_SIZE 6

Here I had similar code but I just wrote hex instead. :)

> +
> +void sync_with_host(uint64_t phase)
> +{
> +	asm volatile("in $" XSTR(SYNC_PORT)", %%al \n"
> +		     : : "a" (phase));
> +}
> +
> +void self_smi(void)
> +{
> +	wrmsr(APIC_BASE_MSR + (APIC_ICR >> 4),
> +	      APIC_DEST_SELF | APIC_INT_ASSERT | APIC_DM_SMI);
> +}
> +
> +void guest_code(struct vmx_pages *vmx_pages)
> +{
> +	uint64_t apicbase = rdmsr(MSR_IA32_APICBASE);
> +
> +	sync_with_host(1);
> +
> +	wrmsr(MSR_IA32_APICBASE, apicbase | X2APIC_ENABLE);
> +
> +	sync_with_host(2);
> +
> +	self_smi();
> +
> +	sync_with_host(4);
> +
> +	if (vmx_pages) {
> +		GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
> +
> +		sync_with_host(5);
> +
> +		self_smi();
> +
> +		sync_with_host(7);
> +	}
> +
> +	sync_with_host(DONE);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct vmx_pages *vmx_pages = NULL;
> +	vm_vaddr_t vmx_pages_gva = 0;
> +
> +	struct kvm_regs regs;
> +	struct kvm_vm *vm;
> +	struct kvm_run *run;
> +	struct kvm_x86_state *state;
> +	int stage, stage_reported;
> +
> +	/* Create VM */
> +	vm = vm_create_default(VCPU_ID, 0, guest_code);
> +
> +	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
> +
> +	run = vcpu_state(vm, VCPU_ID);
> +
> +	vcpu_regs_get(vm, VCPU_ID, &regs);

Unused?

> +
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, SMRAM_GPA,
> +				    1 << 16 | 1, SMRAM_SIZE/PAGE_SIZE, 0);

Better add a vm_phy_pages_alloc here.

I'll debug the remaining failure and post it again.

Paolo

> +	memset(addr_gpa2hva(vm, SMRAM_GPA), 0x0, SMRAM_SIZE);
> +	memcpy(addr_gpa2hva(vm, SMRAM_GPA) + 0x8000, smi_handler,
> +	       SMI_HANDLER_SIZE);
> +
> +	vcpu_set_msr(vm, VCPU_ID, MSR_IA32_SMBASE, SMRAM_GPA);
> +
> +	if (kvm_check_cap(KVM_CAP_NESTED_STATE)) {
> +		vmx_pages = vcpu_alloc_vmx(vm, &vmx_pages_gva);
> +		vcpu_args_set(vm, VCPU_ID, 1, vmx_pages_gva);
> +	} else {
> +		printf("will skip SMM test with VMX enabled\n");
> +		vcpu_args_set(vm, VCPU_ID, 1, 0);
> +	}
> +
> +	for (stage = 1;; stage++) {
> +		_vcpu_run(vm, VCPU_ID);
> +		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
> +			    "Stage %d: unexpected exit reason: %u (%s),\n",
> +			    stage, run->exit_reason,
> +			    exit_reason_str(run->exit_reason));
> +
> +		memset(&regs, 0, sizeof(regs));
> +		vcpu_regs_get(vm, VCPU_ID, &regs);
> +
> +		stage_reported = regs.rax & 0xff;
> +
> +		if (stage_reported == DONE)
> +			goto done;
> +
> +		TEST_ASSERT(stage_reported == stage ||
> +			    stage_reported == SMRAM_STAGE,
> +			    "Unexpected stage: #%x, got %x",
> +			    stage, stage_reported);
> +
> +		/* This piece of code needs sharing with state_test/evmcs_test */
> +		state = vcpu_save_state(vm, VCPU_ID);
> +		kvm_vm_release(vm);
> +		kvm_vm_restart(vm, O_RDWR);
> +		vm_vcpu_add(vm, VCPU_ID, 0, 0);
> +		vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
> +		vcpu_load_state(vm, VCPU_ID, state);
> +		run = vcpu_state(vm, VCPU_ID);
> +		free(state);
> +	}
> +
> +done:
> +	kvm_vm_free(vm);
> +}
> 

