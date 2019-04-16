Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15E8C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBE120872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfDPNjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:39:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37369 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfDPNjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:39:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 040333199376;
        Tue, 16 Apr 2019 13:39:21 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF35E5D9CA;
        Tue, 16 Apr 2019 13:39:19 +0000 (UTC)
Date:   Tue, 16 Apr 2019 15:39:17 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 1/3] selftests: kvm/evmcs_test: complete I/O before
 migrating guest state
Message-ID: <20190416133917.olhol6kz7pmge6nl@kamzik.brq.redhat.com>
References: <1555001308-36016-1-git-send-email-pbonzini@redhat.com>
 <1555001308-36016-2-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555001308-36016-2-git-send-email-pbonzini@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 16 Apr 2019 13:39:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 06:48:26PM +0200, Paolo Bonzini wrote:
> Starting state migration after an IO exit without first completing IO
> may result in test failures.  We already have two tests that need this
> (this patch in fact fixes evmcs_test, similar to what was fixed for
> state_test in commit 0f73bbc851ed, "KVM: selftests: complete IO before
> migrating guest state", 2019-03-13) and a third is coming.  So, move the
> code to vcpu_save_state, and while at it do not access register state
> until after I/O is complete.
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c         |  5 +++++
>  tools/testing/selftests/kvm/lib/x86_64/processor.c |  8 ++++++++
>  tools/testing/selftests/kvm/x86_64/evmcs_test.c    |  5 +++--
>  tools/testing/selftests/kvm/x86_64/state_test.c    | 15 +--------------
>  4 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index efa0aad8b3c6..4ca96b228e46 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -91,6 +91,11 @@ static void vm_open(struct kvm_vm *vm, int perm, unsigned long type)
>  	if (vm->kvm_fd < 0)
>  		exit(KSFT_SKIP);
>  
> +	if (!kvm_check_cap(KVM_CAP_IMMEDIATE_EXIT)) {
> +		fprintf(stderr, "immediate_exit not available, skipping test\n");
> +		exit(KSFT_SKIP);
> +	}
> +
>  	vm->fd = ioctl(vm->kvm_fd, KVM_CREATE_VM, type);
>  	TEST_ASSERT(vm->fd >= 0, "KVM_CREATE_VM ioctl failed, "
>  		"rc: %i errno: %i", vm->fd, errno);
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index f28127f4a3af..b363c9611bd6 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -1030,6 +1030,14 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid)
>  			    nested_size, sizeof(state->nested_));
>  	}
>  
> +	/*
> +	 * When KVM exits to userspace with KVM_EXIT_IO, KVM guarantees
> +	 * guest state is consistent only after userspace re-enters the
> +	 * kernel with KVM_RUN.  Complete IO prior to migrating state
> +	 * to a new VM.
> +	 */
> +	vcpu_run_complete_io(vm, vcpuid);
> +

Since the need for IO completion also affects MMIO exits and there's no
reason to believe that vcpu_save_state() will always be called after
an IO exit, then shouldn't we instead put this in get_ucall()?

diff --git a/tools/testing/selftests/kvm/lib/ucall.c b/tools/testing/selftests/kvm/lib/ucall.c
index a2ab38be2f47..e8c6f2741ce7 100644
--- a/tools/testing/selftests/kvm/lib/ucall.c
+++ b/tools/testing/selftests/kvm/lib/ucall.c
@@ -132,6 +132,7 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
        if (ucall_type == UCALL_PIO && run->exit_reason == KVM_EXIT_IO &&
            run->io.port == UCALL_PIO_PORT) {
                struct kvm_regs regs;
+               vcpu_run_complete_io(vm, vcpu_id);
                vcpu_regs_get(vm, vcpu_id, &regs);
                memcpy(uc, addr_gva2hva(vm, (vm_vaddr_t)regs.rdi), sizeof(*uc));
                return uc->cmd;
@@ -144,6 +145,7 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
                            "Unexpected ucall exit mmio address access");
                gva = *(vm_vaddr_t *)run->mmio.data;
                memcpy(uc, addr_gva2hva(vm, gva), sizeof(*uc));
+               vcpu_run_complete_io(vm, vcpu_id);
        }
 
        return uc->cmd;



>  	nmsrs = kvm_get_num_msrs(vm);
>  	list = malloc(sizeof(*list) + nmsrs * sizeof(list->indices[0]));
>  	list->nmsrs = nmsrs;
> diff --git a/tools/testing/selftests/kvm/x86_64/evmcs_test.c b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
> index c49c2a28b0eb..36669684eca5 100644
> --- a/tools/testing/selftests/kvm/x86_64/evmcs_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
> @@ -123,8 +123,6 @@ int main(int argc, char *argv[])
>  			    stage, run->exit_reason,
>  			    exit_reason_str(run->exit_reason));
>  
> -		memset(&regs1, 0, sizeof(regs1));
> -		vcpu_regs_get(vm, VCPU_ID, &regs1);
>  		switch (get_ucall(vm, VCPU_ID, &uc)) {
>  		case UCALL_ABORT:
>  			TEST_ASSERT(false, "%s at %s:%d", (const char *)uc.args[0],
> @@ -144,6 +142,9 @@ int main(int argc, char *argv[])
>  			    stage, (ulong)uc.args[1]);
>  
>  		state = vcpu_save_state(vm, VCPU_ID);
> +		memset(&regs1, 0, sizeof(regs1));
> +		vcpu_regs_get(vm, VCPU_ID, &regs1);
> +

We would still need this change to get the vcpu_regs_get() below the
get_ucall().

>  		kvm_vm_release(vm);
>  
>  		/* Restore state in a new VM.  */
> diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
> index 30f75856cf39..e0a3c0204b7c 100644
> --- a/tools/testing/selftests/kvm/x86_64/state_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/state_test.c
> @@ -134,11 +134,6 @@ int main(int argc, char *argv[])
>  
>  	struct kvm_cpuid_entry2 *entry = kvm_get_supported_cpuid_entry(1);
>  
> -	if (!kvm_check_cap(KVM_CAP_IMMEDIATE_EXIT)) {
> -		fprintf(stderr, "immediate_exit not available, skipping test\n");
> -		exit(KSFT_SKIP);
> -	}
> -
>  	/* Create VM */
>  	vm = vm_create_default(VCPU_ID, 0, guest_code);
>  	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
> @@ -179,18 +174,10 @@ int main(int argc, char *argv[])
>  			    uc.args[1] == stage, "Unexpected register values vmexit #%lx, got %lx",
>  			    stage, (ulong)uc.args[1]);
>  
> -		/*
> -		 * When KVM exits to userspace with KVM_EXIT_IO, KVM guarantees
> -		 * guest state is consistent only after userspace re-enters the
> -		 * kernel with KVM_RUN.  Complete IO prior to migrating state
> -		 * to a new VM.
> -		 */
> -		vcpu_run_complete_io(vm, VCPU_ID);
> -
> +		state = vcpu_save_state(vm, VCPU_ID);
>  		memset(&regs1, 0, sizeof(regs1));
>  		vcpu_regs_get(vm, VCPU_ID, &regs1);
>  
> -		state = vcpu_save_state(vm, VCPU_ID);
>  		kvm_vm_release(vm);
>  
>  		/* Restore state in a new VM.  */
> -- 
> 1.8.3.1
> 
>

Thanks,
drew 
