Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD30C4CED1
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 17:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAF220866
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 17:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfI1RX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 13:23:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbfI1RX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 13:23:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2372510DCC83;
        Sat, 28 Sep 2019 17:23:25 +0000 (UTC)
Received: from mail (ovpn-125-159.rdu2.redhat.com [10.10.125.159])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6236D1001281;
        Sat, 28 Sep 2019 17:23:24 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 03/14] KVM: monolithic: x86: convert the kvm_x86_ops and kvm_pmu_ops methods to external functions
Date:   Sat, 28 Sep 2019 13:23:12 -0400
Message-Id: <20190928172323.14663-4-aarcange@redhat.com>
In-Reply-To: <20190928172323.14663-1-aarcange@redhat.com>
References: <20190928172323.14663-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Sat, 28 Sep 2019 17:23:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This replaces all kvm_x86_ops and kvm_pmu_ops pointer to functions
with regular external functions that don't require indirect calls.

In practice this optimization results in a double digit percent
reduction in the vmexit latency with the default retpoline spectre v2
mitigation enabled in the host.

When the host is booted with spectre_v2=off this still results in a
best case measurable improvement up to 2% that varies wildly depending
on the CPU vendor implementation under high frequency timer guest
workloads. Supposedly guest userland workloads making lots of use of
the BTB may benefit too.

To reduce the rejecting parts while tracking upstream, this doesn't
attempt to entirely remove the kvm_x86_ops structure yet, that is
meant for a later cleanup. The pmu ops have been already cleaned up in
this patchset because it was left completely unused right after the
conversion from pointer to functions to external functions.

Further incremental minor optimizations that weren't possible before
are now enabled by the monolithic model. For example it is now
possible to convert some of the small kvm_x86_* external methods to
inline functions. However that will require more Makefile tweaks and
so it is left for later.

This is a list of the most common retpolines executed in KVM on VMX
under a guest workload triggering a high resolution timer SIGALRM
flood before the monolithic KVM patchset is applied.

[..]
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    cancel_hv_timer.isra.46+44
    restart_apic_timer+295
    kvm_set_msr_common+1435
    vmx_set_msr+478
    handle_wrmsr+85
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 65382
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    vcpu_enter_guest+1646
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 66164
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    kvm_read_l1_tsc+41
    __kvm_wait_lapic_expire+60
    vmx_vcpu_run.part.88+1091
    vcpu_enter_guest+423
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 66199
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    vcpu_enter_guest+4958
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 66227
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    restart_apic_timer+99
    kvm_set_msr_common+1435
    vmx_set_msr+478
    handle_wrmsr+85
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 130619
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    kvm_read_l1_tsc+41
    vmx_set_hv_timer+81
    restart_apic_timer+99
    kvm_set_msr_common+1435
    vmx_set_msr+478
    handle_wrmsr+85
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 130665
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    kvm_skip_emulated_instruction+49
    handle_wrmsr+102
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 131020
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    kvm_skip_emulated_instruction+82
    handle_wrmsr+102
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 131025
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    handle_wrmsr+85
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 131043
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    skip_emulated_instruction+48
    kvm_skip_emulated_instruction+82
    handle_wrmsr+102
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 131046
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    vcpu_enter_guest+4009
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 132405
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rcx+33
    vcpu_enter_guest+1689
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 197697
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    vmx_vcpu_run.part.88+358
    vcpu_enter_guest+423
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 198736
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    vcpu_enter_guest+575
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 198771
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    vcpu_enter_guest+423
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 198793
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    vcpu_enter_guest+486
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 198801
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    vcpu_enter_guest+168
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 198848
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 397680

@total: 3816655

Here the same but on SVM:

[..]
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    clockevents_program_event+148
    hrtimer_start_range_ns+528
    start_sw_timer+356
    restart_apic_timer+111
    kvm_set_msr_common+1435
    msr_interception+138
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 36031
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    lapic_next_event+28
    clockevents_program_event+148
    hrtimer_start_range_ns+528
    start_sw_timer+356
    restart_apic_timer+111
    kvm_set_msr_common+1435
    msr_interception+138
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 36063
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    ktime_get+58
    clockevents_program_event+84
    hrtimer_try_to_cancel+168
    hrtimer_cancel+21
    kvm_set_lapic_tscdeadline_msr+43
    kvm_set_msr_common+1435
    msr_interception+138
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 36134
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    lapic_next_event+28
    clockevents_program_event+148
    hrtimer_try_to_cancel+168
    hrtimer_cancel+21
    kvm_set_lapic_tscdeadline_msr+43
    kvm_set_msr_common+1435
    msr_interception+138
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 36146
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    clockevents_program_event+148
    hrtimer_try_to_cancel+168
    hrtimer_cancel+21
    kvm_set_lapic_tscdeadline_msr+43
    kvm_set_msr_common+1435
    msr_interception+138
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 36190
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    ktime_get+58
    clockevents_program_event+84
    hrtimer_start_range_ns+528
    start_sw_timer+356
    restart_apic_timer+111
    kvm_set_msr_common+1435
    msr_interception+138
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 36281
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    vcpu_enter_guest+1646
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 37752
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    kvm_read_l1_tsc+41
    __kvm_wait_lapic_expire+60
    svm_vcpu_run+1276
]: 37886
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    vcpu_enter_guest+4958
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 37957
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    kvm_read_l1_tsc+41
    start_sw_timer+302
    restart_apic_timer+111
    kvm_set_msr_common+1435
    msr_interception+138
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 74358
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    ktime_get+58
    start_sw_timer+279
    restart_apic_timer+111
    kvm_set_msr_common+1435
    msr_interception+138
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 74558
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    kvm_skip_emulated_instruction+82
    msr_interception+356
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 74713
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    kvm_skip_emulated_instruction+49
    msr_interception+356
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 74757
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    msr_interception+138
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 74795
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    kvm_get_rflags+28
    svm_interrupt_allowed+50
    vcpu_enter_guest+4009
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 75647
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    vcpu_enter_guest+4009
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 75812
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rcx+33
    vcpu_enter_guest+1689
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 112579
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    vcpu_enter_guest+575
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 113371
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    vcpu_enter_guest+423
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 113386
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    vcpu_enter_guest+486
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 113414
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    vcpu_enter_guest+168
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 113601
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    vcpu_enter_guest+772
    kvm_arch_vcpu_ioctl_run+263
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 227076

@total: 3829460

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 200 ++++++++-
 arch/x86/kvm/cpuid.c            |  22 +-
 arch/x86/kvm/hyperv.c           |   6 +-
 arch/x86/kvm/kvm_cache_regs.h   |  10 +-
 arch/x86/kvm/lapic.c            |  30 +-
 arch/x86/kvm/mmu.c              |  26 +-
 arch/x86/kvm/mmu.h              |   4 +-
 arch/x86/kvm/pmu.c              |  24 +-
 arch/x86/kvm/pmu.h              |  19 +-
 arch/x86/kvm/pmu_amd.c          |  52 +--
 arch/x86/kvm/svm.c              | 659 ++++++++++++++++------------
 arch/x86/kvm/trace.h            |   4 +-
 arch/x86/kvm/vmx/nested.c       |  84 ++--
 arch/x86/kvm/vmx/pmu_intel.c    |  55 ++-
 arch/x86/kvm/vmx/vmx.c          | 732 ++++++++++++++++++--------------
 arch/x86/kvm/vmx/vmx.h          |  39 +-
 arch/x86/kvm/x86.c              | 308 +++++++-------
 arch/x86/kvm/x86.h              |   2 +-
 18 files changed, 1345 insertions(+), 931 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index a3a3ec73fa2f..47eeb92d4b4a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1002,6 +1002,196 @@ struct kvm_lapic_irq {
 	bool msi_redir_hint;
 };
 
+extern __init int kvm_x86_cpu_has_kvm_support(void);
+extern __init int kvm_x86_disabled_by_bios(void);
+extern int kvm_x86_hardware_enable(void);
+extern void kvm_x86_hardware_disable(void);
+extern __init int kvm_x86_check_processor_compatibility(void);
+extern __init int kvm_x86_hardware_setup(void);
+extern __exit void kvm_x86_hardware_unsetup(void);
+extern bool kvm_x86_cpu_has_accelerated_tpr(void);
+extern bool kvm_x86_has_emulated_msr(int index);
+extern void kvm_x86_cpuid_update(struct kvm_vcpu *vcpu);
+extern struct kvm *kvm_x86_vm_alloc(void);
+extern void kvm_x86_vm_free(struct kvm *kvm);
+extern int kvm_x86_vm_init(struct kvm *kvm);
+extern void kvm_x86_vm_destroy(struct kvm *kvm);
+/* Create, but do not attach this VCPU */
+extern struct kvm_vcpu *kvm_x86_vcpu_create(struct kvm *kvm, unsigned id);
+extern void kvm_x86_vcpu_free(struct kvm_vcpu *vcpu);
+extern void kvm_x86_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
+extern void kvm_x86_prepare_guest_switch(struct kvm_vcpu *vcpu);
+extern void kvm_x86_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
+extern void kvm_x86_vcpu_put(struct kvm_vcpu *vcpu);
+extern void kvm_x86_update_bp_intercept(struct kvm_vcpu *vcpu);
+extern int kvm_x86_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr);
+extern int kvm_x86_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr);
+extern u64 kvm_x86_get_segment_base(struct kvm_vcpu *vcpu, int seg);
+extern void kvm_x86_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var,
+				int seg);
+extern int kvm_x86_get_cpl(struct kvm_vcpu *vcpu);
+extern void kvm_x86_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var,
+				int seg);
+extern void kvm_x86_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l);
+extern void kvm_x86_decache_cr0_guest_bits(struct kvm_vcpu *vcpu);
+extern void kvm_x86_decache_cr3(struct kvm_vcpu *vcpu);
+extern void kvm_x86_decache_cr4_guest_bits(struct kvm_vcpu *vcpu);
+extern void kvm_x86_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
+extern void kvm_x86_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3);
+extern int kvm_x86_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
+extern void kvm_x86_set_efer(struct kvm_vcpu *vcpu, u64 efer);
+extern void kvm_x86_get_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
+extern void kvm_x86_set_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
+extern void kvm_x86_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
+extern void kvm_x86_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
+extern u64 kvm_x86_get_dr6(struct kvm_vcpu *vcpu);
+extern void kvm_x86_set_dr6(struct kvm_vcpu *vcpu, unsigned long value);
+extern void kvm_x86_sync_dirty_debug_regs(struct kvm_vcpu *vcpu);
+extern void kvm_x86_set_dr7(struct kvm_vcpu *vcpu, unsigned long value);
+extern void kvm_x86_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg);
+extern unsigned long kvm_x86_get_rflags(struct kvm_vcpu *vcpu);
+extern void kvm_x86_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
+extern void kvm_x86_tlb_flush(struct kvm_vcpu *vcpu, bool invalidate_gpa);
+extern int kvm_x86_tlb_remote_flush(struct kvm *kvm);
+extern int kvm_x86_tlb_remote_flush_with_range(struct kvm *kvm,
+					       struct kvm_tlb_range *range);
+/*
+ * Flush any TLB entries associated with the given GVA.
+ * Does not need to flush GPA->HPA mappings.
+ * Can potentially get non-canonical addresses through INVLPGs, which
+ * the implementation may choose to ignore if appropriate.
+ */
+extern void kvm_x86_tlb_flush_gva(struct kvm_vcpu *vcpu, gva_t addr);
+extern void kvm_x86_run(struct kvm_vcpu *vcpu);
+extern int kvm_x86_handle_exit(struct kvm_vcpu *vcpu);
+extern int kvm_x86_skip_emulated_instruction(struct kvm_vcpu *vcpu);
+extern void kvm_x86_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask);
+extern u32 kvm_x86_get_interrupt_shadow(struct kvm_vcpu *vcpu);
+extern void kvm_x86_patch_hypercall(struct kvm_vcpu *vcpu,
+				    unsigned char *hypercall_addr);
+extern void kvm_x86_set_irq(struct kvm_vcpu *vcpu);
+extern void kvm_x86_set_nmi(struct kvm_vcpu *vcpu);
+extern void kvm_x86_queue_exception(struct kvm_vcpu *vcpu);
+extern void kvm_x86_cancel_injection(struct kvm_vcpu *vcpu);
+extern int kvm_x86_interrupt_allowed(struct kvm_vcpu *vcpu);
+extern int kvm_x86_nmi_allowed(struct kvm_vcpu *vcpu);
+extern bool kvm_x86_get_nmi_mask(struct kvm_vcpu *vcpu);
+extern void kvm_x86_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked);
+extern void kvm_x86_enable_nmi_window(struct kvm_vcpu *vcpu);
+extern void kvm_x86_enable_irq_window(struct kvm_vcpu *vcpu);
+extern void kvm_x86_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr,
+					 int irr);
+extern bool kvm_x86_get_enable_apicv(struct kvm_vcpu *vcpu);
+extern void kvm_x86_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu);
+extern void kvm_x86_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr);
+extern void kvm_x86_hwapic_isr_update(struct kvm_vcpu *vcpu, int isr);
+extern bool kvm_x86_guest_apic_has_interrupt(struct kvm_vcpu *vcpu);
+extern void kvm_x86_load_eoi_exitmap(struct kvm_vcpu *vcpu,
+				     u64 *eoi_exit_bitmap);
+extern void kvm_x86_set_virtual_apic_mode(struct kvm_vcpu *vcpu);
+extern void kvm_x86_set_apic_access_page_addr(struct kvm_vcpu *vcpu,
+					      hpa_t hpa);
+extern void kvm_x86_deliver_posted_interrupt(struct kvm_vcpu *vcpu,
+					     int vector);
+extern int kvm_x86_sync_pir_to_irr(struct kvm_vcpu *vcpu);
+extern int kvm_x86_set_tss_addr(struct kvm *kvm, unsigned int addr);
+extern int kvm_x86_set_identity_map_addr(struct kvm *kvm, u64 ident_addr);
+extern int kvm_x86_get_tdp_level(struct kvm_vcpu *vcpu);
+extern u64 kvm_x86_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio);
+extern int kvm_x86_get_lpage_level(void);
+extern bool kvm_x86_rdtscp_supported(void);
+extern bool kvm_x86_invpcid_supported(void);
+extern void kvm_x86_set_tdp_cr3(struct kvm_vcpu *vcpu, unsigned long cr3);
+extern void kvm_x86_set_supported_cpuid(u32 func,
+					struct kvm_cpuid_entry2 *entry);
+extern bool kvm_x86_has_wbinvd_exit(void);
+extern u64 kvm_x86_read_l1_tsc_offset(struct kvm_vcpu *vcpu);
+/* Returns actual tsc_offset set in active VMCS */
+extern u64 kvm_x86_write_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 offset);
+extern void kvm_x86_get_exit_info(struct kvm_vcpu *vcpu, u64 *info1,
+				  u64 *info2);
+extern int kvm_x86_check_intercept(struct kvm_vcpu *vcpu,
+				   struct x86_instruction_info *info,
+				   enum x86_intercept_stage stage);
+extern void kvm_x86_handle_exit_irqoff(struct kvm_vcpu *vcpu);
+extern bool kvm_x86_mpx_supported(void);
+extern bool kvm_x86_xsaves_supported(void);
+extern bool kvm_x86_umip_emulated(void);
+extern bool kvm_x86_pt_supported(void);
+extern int kvm_x86_check_nested_events(struct kvm_vcpu *vcpu,
+				       bool external_intr);
+extern void kvm_x86_request_immediate_exit(struct kvm_vcpu *vcpu);
+extern void kvm_x86_sched_in(struct kvm_vcpu *kvm, int cpu);
+/*
+ * Arch-specific dirty logging hooks. These hooks are only supposed to
+ * be valid if the specific arch has hardware-accelerated dirty logging
+ * mechanism. Currently only for PML on VMX.
+ *
+ *  - slot_enable_log_dirty:
+ *	called when enabling log dirty mode for the slot.
+ *  - slot_disable_log_dirty:
+ *	called when disabling log dirty mode for the slot.
+ *	also called when slot is created with log dirty disabled.
+ *  - flush_log_dirty:
+ *	called before reporting dirty_bitmap to userspace.
+ *  - enable_log_dirty_pt_masked:
+ *	called when reenabling log dirty for the GFNs in the mask after
+ *	corresponding bits are cleared in slot->dirty_bitmap.
+ */
+extern void kvm_x86_slot_enable_log_dirty(struct kvm *kvm,
+					  struct kvm_memory_slot *slot);
+extern void kvm_x86_slot_disable_log_dirty(struct kvm *kvm,
+					   struct kvm_memory_slot *slot);
+extern void kvm_x86_flush_log_dirty(struct kvm *kvm);
+extern void kvm_x86_enable_log_dirty_pt_masked(struct kvm *kvm,
+					       struct kvm_memory_slot *slot,
+					       gfn_t offset,
+					       unsigned long mask);
+extern int kvm_x86_write_log_dirty(struct kvm_vcpu *vcpu);
+/*
+ * Architecture specific hooks for vCPU blocking due to
+ * HLT instruction.
+ * Returns for .pre_block():
+ *    - 0 means continue to block the vCPU.
+ *    - 1 means we cannot block the vCPU since some event
+ *        happens during this period, such as, 'ON' bit in
+ *        posted-interrupts descriptor is set.
+ */
+extern int kvm_x86_pre_block(struct kvm_vcpu *vcpu);
+extern void kvm_x86_post_block(struct kvm_vcpu *vcpu);
+extern void kvm_x86_vcpu_blocking(struct kvm_vcpu *vcpu);
+extern void kvm_x86_vcpu_unblocking(struct kvm_vcpu *vcpu);
+extern int kvm_x86_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
+				  uint32_t guest_irq, bool set);
+extern void kvm_x86_apicv_post_state_restore(struct kvm_vcpu *vcpu);
+extern bool kvm_x86_dy_apicv_has_pending_interrupt(struct kvm_vcpu *vcpu);
+extern int kvm_x86_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
+				bool *expired);
+extern void kvm_x86_cancel_hv_timer(struct kvm_vcpu *vcpu);
+extern void kvm_x86_setup_mce(struct kvm_vcpu *vcpu);
+extern int kvm_x86_get_nested_state(struct kvm_vcpu *vcpu,
+				    struct kvm_nested_state __user *user_kvm_nested_state,
+				    unsigned user_data_size);
+extern int kvm_x86_set_nested_state(struct kvm_vcpu *vcpu,
+				    struct kvm_nested_state __user *user_kvm_nested_state,
+				    struct kvm_nested_state *kvm_state);
+extern void kvm_x86_get_vmcs12_pages(struct kvm_vcpu *vcpu);
+extern int kvm_x86_smi_allowed(struct kvm_vcpu *vcpu);
+extern int kvm_x86_pre_enter_smm(struct kvm_vcpu *vcpu, char *smstate);
+extern int kvm_x86_pre_leave_smm(struct kvm_vcpu *vcpu, const char *smstate);
+extern int kvm_x86_enable_smi_window(struct kvm_vcpu *vcpu);
+extern int kvm_x86_mem_enc_op(struct kvm *kvm, void __user *argp);
+extern int kvm_x86_mem_enc_reg_region(struct kvm *kvm,
+				      struct kvm_enc_region *argp);
+extern int kvm_x86_mem_enc_unreg_region(struct kvm *kvm,
+					struct kvm_enc_region *argp);
+extern int kvm_x86_get_msr_feature(struct kvm_msr_entry *entry);
+extern int kvm_x86_nested_enable_evmcs(struct kvm_vcpu *vcpu,
+				       uint16_t *vmcs_version);
+extern uint16_t kvm_x86_nested_get_evmcs_version(struct kvm_vcpu *vcpu);
+extern bool kvm_x86_need_emulation_on_page_fault(struct kvm_vcpu *vcpu);
+extern bool kvm_x86_apic_init_signal_blocked(struct kvm_vcpu *vcpu);
+
 struct kvm_x86_ops {
 	int (*cpu_has_kvm_support)(void);          /* __init */
 	int (*disabled_by_bios)(void);             /* __init */
@@ -1228,19 +1418,19 @@ extern struct kmem_cache *x86_fpu_cache;
 #define __KVM_HAVE_ARCH_VM_ALLOC
 static inline struct kvm *kvm_arch_alloc_vm(void)
 {
-	return kvm_x86_ops->vm_alloc();
+	return kvm_x86_vm_alloc();
 }
 
 static inline void kvm_arch_free_vm(struct kvm *kvm)
 {
-	return kvm_x86_ops->vm_free(kvm);
+	return kvm_x86_vm_free(kvm);
 }
 
 #define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLB
 static inline int kvm_arch_flush_remote_tlb(struct kvm *kvm)
 {
 	if (kvm_x86_ops->tlb_remote_flush &&
-	    !kvm_x86_ops->tlb_remote_flush(kvm))
+	    !kvm_x86_tlb_remote_flush(kvm))
 		return 0;
 	else
 		return -ENOTSUPP;
@@ -1597,13 +1787,13 @@ static inline bool kvm_irq_is_postable(struct kvm_lapic_irq *irq)
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
 {
 	if (kvm_x86_ops->vcpu_blocking)
-		kvm_x86_ops->vcpu_blocking(vcpu);
+		kvm_x86_vcpu_blocking(vcpu);
 }
 
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
 	if (kvm_x86_ops->vcpu_unblocking)
-		kvm_x86_ops->vcpu_unblocking(vcpu);
+		kvm_x86_vcpu_unblocking(vcpu);
 }
 
 static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index dd5985eb61b4..2eacf9cea254 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -48,7 +48,7 @@ static u32 xstate_required_size(u64 xstate_bv, bool compacted)
 bool kvm_mpx_supported(void)
 {
 	return ((host_xcr0 & (XFEATURE_MASK_BNDREGS | XFEATURE_MASK_BNDCSR))
-		 && kvm_x86_ops->mpx_supported());
+		 && kvm_x86_mpx_supported());
 }
 EXPORT_SYMBOL_GPL(kvm_mpx_supported);
 
@@ -232,7 +232,7 @@ int kvm_vcpu_ioctl_set_cpuid(struct kvm_vcpu *vcpu,
 	vcpu->arch.cpuid_nent = cpuid->nent;
 	cpuid_fix_nx_cap(vcpu);
 	kvm_apic_set_version(vcpu);
-	kvm_x86_ops->cpuid_update(vcpu);
+	kvm_x86_cpuid_update(vcpu);
 	r = kvm_update_cpuid(vcpu);
 
 out:
@@ -255,7 +255,7 @@ int kvm_vcpu_ioctl_set_cpuid2(struct kvm_vcpu *vcpu,
 		goto out;
 	vcpu->arch.cpuid_nent = cpuid->nent;
 	kvm_apic_set_version(vcpu);
-	kvm_x86_ops->cpuid_update(vcpu);
+	kvm_x86_cpuid_update(vcpu);
 	r = kvm_update_cpuid(vcpu);
 out:
 	return r;
@@ -341,10 +341,10 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_entry2 *entry,
 
 static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry, int index)
 {
-	unsigned f_invpcid = kvm_x86_ops->invpcid_supported() ? F(INVPCID) : 0;
+	unsigned f_invpcid = kvm_x86_invpcid_supported() ? F(INVPCID) : 0;
 	unsigned f_mpx = kvm_mpx_supported() ? F(MPX) : 0;
-	unsigned f_umip = kvm_x86_ops->umip_emulated() ? F(UMIP) : 0;
-	unsigned f_intel_pt = kvm_x86_ops->pt_supported() ? F(INTEL_PT) : 0;
+	unsigned f_umip = kvm_x86_umip_emulated() ? F(UMIP) : 0;
+	unsigned f_intel_pt = kvm_x86_pt_supported() ? F(INTEL_PT) : 0;
 	unsigned f_la57;
 
 	/* cpuid 7.0.ebx */
@@ -426,16 +426,16 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
 	int r;
 	unsigned f_nx = is_efer_nx() ? F(NX) : 0;
 #ifdef CONFIG_X86_64
-	unsigned f_gbpages = (kvm_x86_ops->get_lpage_level() == PT_PDPE_LEVEL)
+	unsigned f_gbpages = (kvm_x86_get_lpage_level() == PT_PDPE_LEVEL)
 				? F(GBPAGES) : 0;
 	unsigned f_lm = F(LM);
 #else
 	unsigned f_gbpages = 0;
 	unsigned f_lm = 0;
 #endif
-	unsigned f_rdtscp = kvm_x86_ops->rdtscp_supported() ? F(RDTSCP) : 0;
-	unsigned f_xsaves = kvm_x86_ops->xsaves_supported() ? F(XSAVES) : 0;
-	unsigned f_intel_pt = kvm_x86_ops->pt_supported() ? F(INTEL_PT) : 0;
+	unsigned f_rdtscp = kvm_x86_rdtscp_supported() ? F(RDTSCP) : 0;
+	unsigned f_xsaves = kvm_x86_xsaves_supported() ? F(XSAVES) : 0;
+	unsigned f_intel_pt = kvm_x86_pt_supported() ? F(INTEL_PT) : 0;
 
 	/* cpuid 1.edx */
 	const u32 kvm_cpuid_1_edx_x86_features =
@@ -786,7 +786,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
 		break;
 	}
 
-	kvm_x86_ops->set_supported_cpuid(function, entry);
+	kvm_x86_set_supported_cpuid(function, entry);
 
 	r = 0;
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index fff790a3f4ee..1621bd0ce00c 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1015,7 +1015,7 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 		addr = gfn_to_hva(kvm, gfn);
 		if (kvm_is_error_hva(addr))
 			return 1;
-		kvm_x86_ops->patch_hypercall(vcpu, instructions);
+		kvm_x86_patch_hypercall(vcpu, instructions);
 		((unsigned char *)instructions)[3] = 0xc3; /* ret */
 		if (__copy_to_user((void __user *)addr, instructions, 4))
 			return 1;
@@ -1600,7 +1600,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 	 * hypercall generates UD from non zero cpl and real mode
 	 * per HYPER-V spec
 	 */
-	if (kvm_x86_ops->get_cpl(vcpu) != 0 || !is_protmode(vcpu)) {
+	if (kvm_x86_get_cpl(vcpu) != 0 || !is_protmode(vcpu)) {
 		kvm_queue_exception(vcpu, UD_VECTOR);
 		return 1;
 	}
@@ -1794,7 +1794,7 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 	int i, nent = ARRAY_SIZE(cpuid_entries);
 
 	if (kvm_x86_ops->nested_get_evmcs_version)
-		evmcs_ver = kvm_x86_ops->nested_get_evmcs_version(vcpu);
+		evmcs_ver = kvm_x86_nested_get_evmcs_version(vcpu);
 
 	/* Skip NESTED_FEATURES if eVMCS is not supported */
 	if (!evmcs_ver)
diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 1cc6c47dc77e..5904f4fd1e15 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -41,7 +41,7 @@ static inline unsigned long kvm_register_read(struct kvm_vcpu *vcpu,
 					      enum kvm_reg reg)
 {
 	if (!test_bit(reg, (unsigned long *)&vcpu->arch.regs_avail))
-		kvm_x86_ops->cache_reg(vcpu, reg);
+		kvm_x86_cache_reg(vcpu, reg);
 
 	return vcpu->arch.regs[reg];
 }
@@ -81,7 +81,7 @@ static inline u64 kvm_pdptr_read(struct kvm_vcpu *vcpu, int index)
 
 	if (!test_bit(VCPU_EXREG_PDPTR,
 		      (unsigned long *)&vcpu->arch.regs_avail))
-		kvm_x86_ops->cache_reg(vcpu, (enum kvm_reg)VCPU_EXREG_PDPTR);
+		kvm_x86_cache_reg(vcpu, (enum kvm_reg)VCPU_EXREG_PDPTR);
 
 	return vcpu->arch.walk_mmu->pdptrs[index];
 }
@@ -90,7 +90,7 @@ static inline ulong kvm_read_cr0_bits(struct kvm_vcpu *vcpu, ulong mask)
 {
 	ulong tmask = mask & KVM_POSSIBLE_CR0_GUEST_BITS;
 	if (tmask & vcpu->arch.cr0_guest_owned_bits)
-		kvm_x86_ops->decache_cr0_guest_bits(vcpu);
+		kvm_x86_decache_cr0_guest_bits(vcpu);
 	return vcpu->arch.cr0 & mask;
 }
 
@@ -103,14 +103,14 @@ static inline ulong kvm_read_cr4_bits(struct kvm_vcpu *vcpu, ulong mask)
 {
 	ulong tmask = mask & KVM_POSSIBLE_CR4_GUEST_BITS;
 	if (tmask & vcpu->arch.cr4_guest_owned_bits)
-		kvm_x86_ops->decache_cr4_guest_bits(vcpu);
+		kvm_x86_decache_cr4_guest_bits(vcpu);
 	return vcpu->arch.cr4 & mask;
 }
 
 static inline ulong kvm_read_cr3(struct kvm_vcpu *vcpu)
 {
 	if (!test_bit(VCPU_EXREG_CR3, (ulong *)&vcpu->arch.regs_avail))
-		kvm_x86_ops->decache_cr3(vcpu);
+		kvm_x86_decache_cr3(vcpu);
 	return vcpu->arch.cr3;
 }
 
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 8675458c2205..a588907f07c6 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -453,7 +453,7 @@ static inline void apic_clear_irr(int vec, struct kvm_lapic *apic)
 	if (unlikely(vcpu->arch.apicv_active)) {
 		/* need to update RVI */
 		kvm_lapic_clear_vector(vec, apic->regs + APIC_IRR);
-		kvm_x86_ops->hwapic_irr_update(vcpu,
+		kvm_x86_hwapic_irr_update(vcpu,
 				apic_find_highest_irr(apic));
 	} else {
 		apic->irr_pending = false;
@@ -478,7 +478,7 @@ static inline void apic_set_isr(int vec, struct kvm_lapic *apic)
 	 * just set SVI.
 	 */
 	if (unlikely(vcpu->arch.apicv_active))
-		kvm_x86_ops->hwapic_isr_update(vcpu, vec);
+		kvm_x86_hwapic_isr_update(vcpu, vec);
 	else {
 		++apic->isr_count;
 		BUG_ON(apic->isr_count > MAX_APIC_VECTOR);
@@ -526,7 +526,7 @@ static inline void apic_clear_isr(int vec, struct kvm_lapic *apic)
 	 * and must be left alone.
 	 */
 	if (unlikely(vcpu->arch.apicv_active))
-		kvm_x86_ops->hwapic_isr_update(vcpu,
+		kvm_x86_hwapic_isr_update(vcpu,
 					       apic_find_highest_isr(apic));
 	else {
 		--apic->isr_count;
@@ -669,7 +669,7 @@ static int apic_has_interrupt_for_ppr(struct kvm_lapic *apic, u32 ppr)
 {
 	int highest_irr;
 	if (apic->vcpu->arch.apicv_active)
-		highest_irr = kvm_x86_ops->sync_pir_to_irr(apic->vcpu);
+		highest_irr = kvm_x86_sync_pir_to_irr(apic->vcpu);
 	else
 		highest_irr = apic_find_highest_irr(apic);
 	if (highest_irr == -1 || (highest_irr & 0xF0) <= ppr)
@@ -1059,7 +1059,7 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
 		}
 
 		if (vcpu->arch.apicv_active)
-			kvm_x86_ops->deliver_posted_interrupt(vcpu, vector);
+			kvm_x86_deliver_posted_interrupt(vcpu, vector);
 		else {
 			kvm_lapic_set_irr(vector, apic);
 
@@ -1704,7 +1704,7 @@ static void cancel_hv_timer(struct kvm_lapic *apic)
 {
 	WARN_ON(preemptible());
 	WARN_ON(!apic->lapic_timer.hv_timer_in_use);
-	kvm_x86_ops->cancel_hv_timer(apic->vcpu);
+	kvm_x86_cancel_hv_timer(apic->vcpu);
 	apic->lapic_timer.hv_timer_in_use = false;
 }
 
@@ -1721,7 +1721,7 @@ static bool start_hv_timer(struct kvm_lapic *apic)
 	if (!ktimer->tscdeadline)
 		return false;
 
-	if (kvm_x86_ops->set_hv_timer(vcpu, ktimer->tscdeadline, &expired))
+	if (kvm_x86_set_hv_timer(vcpu, ktimer->tscdeadline, &expired))
 		return false;
 
 	ktimer->hv_timer_in_use = true;
@@ -2141,7 +2141,7 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value)
 		kvm_apic_set_x2apic_id(apic, vcpu->vcpu_id);
 
 	if ((old_value ^ value) & (MSR_IA32_APICBASE_ENABLE | X2APIC_ENABLE))
-		kvm_x86_ops->set_virtual_apic_mode(vcpu);
+		kvm_x86_set_virtual_apic_mode(vcpu);
 
 	apic->base_address = apic->vcpu->arch.apic_base &
 			     MSR_IA32_APICBASE_BASE;
@@ -2204,9 +2204,9 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 	vcpu->arch.pv_eoi.msr_val = 0;
 	apic_update_ppr(apic);
 	if (vcpu->arch.apicv_active) {
-		kvm_x86_ops->apicv_post_state_restore(vcpu);
-		kvm_x86_ops->hwapic_irr_update(vcpu, -1);
-		kvm_x86_ops->hwapic_isr_update(vcpu, -1);
+		kvm_x86_apicv_post_state_restore(vcpu);
+		kvm_x86_hwapic_irr_update(vcpu, -1);
+		kvm_x86_hwapic_isr_update(vcpu, -1);
 	}
 
 	vcpu->arch.apic_arb_prio = 0;
@@ -2458,10 +2458,10 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 				1 : count_vectors(apic->regs + APIC_ISR);
 	apic->highest_isr_cache = -1;
 	if (vcpu->arch.apicv_active) {
-		kvm_x86_ops->apicv_post_state_restore(vcpu);
-		kvm_x86_ops->hwapic_irr_update(vcpu,
+		kvm_x86_apicv_post_state_restore(vcpu);
+		kvm_x86_hwapic_irr_update(vcpu,
 				apic_find_highest_irr(apic));
-		kvm_x86_ops->hwapic_isr_update(vcpu,
+		kvm_x86_hwapic_isr_update(vcpu,
 				apic_find_highest_isr(apic));
 	}
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
@@ -2713,7 +2713,7 @@ void kvm_apic_accept_events(struct kvm_vcpu *vcpu)
 	 * KVM_MP_STATE_INIT_RECEIVED state), just eat SIPIs
 	 * and leave the INIT pending.
 	 */
-	if (is_smm(vcpu) || kvm_x86_ops->apic_init_signal_blocked(vcpu)) {
+	if (is_smm(vcpu) || kvm_x86_apic_init_signal_blocked(vcpu)) {
 		WARN_ON_ONCE(vcpu->arch.mp_state == KVM_MP_STATE_INIT_RECEIVED);
 		if (test_bit(KVM_APIC_SIPI, &apic->pending_events))
 			clear_bit(KVM_APIC_SIPI, &apic->pending_events);
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index a10af9c87f8a..80124d00c504 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -283,7 +283,7 @@ static void kvm_flush_remote_tlbs_with_range(struct kvm *kvm,
 	int ret = -ENOTSUPP;
 
 	if (range && kvm_x86_ops->tlb_remote_flush_with_range)
-		ret = kvm_x86_ops->tlb_remote_flush_with_range(kvm, range);
+		ret = kvm_x86_tlb_remote_flush_with_range(kvm, range);
 
 	if (ret)
 		kvm_flush_remote_tlbs(kvm);
@@ -1265,7 +1265,7 @@ static int mapping_level(struct kvm_vcpu *vcpu, gfn_t large_gfn,
 	if (host_level == PT_PAGE_TABLE_LEVEL)
 		return host_level;
 
-	max_level = min(kvm_x86_ops->get_lpage_level(), host_level);
+	max_level = min(kvm_x86_get_lpage_level(), host_level);
 
 	for (level = PT_DIRECTORY_LEVEL; level <= max_level; ++level)
 		if (__mmu_gfn_lpage_is_disallowed(large_gfn, level, slot))
@@ -1719,7 +1719,7 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 				gfn_t gfn_offset, unsigned long mask)
 {
 	if (kvm_x86_ops->enable_log_dirty_pt_masked)
-		kvm_x86_ops->enable_log_dirty_pt_masked(kvm, slot, gfn_offset,
+		kvm_x86_enable_log_dirty_pt_masked(kvm, slot, gfn_offset,
 				mask);
 	else
 		kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset, mask);
@@ -1735,7 +1735,7 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 int kvm_arch_write_log_dirty(struct kvm_vcpu *vcpu)
 {
 	if (kvm_x86_ops->write_log_dirty)
-		return kvm_x86_ops->write_log_dirty(vcpu);
+		return kvm_x86_write_log_dirty(vcpu);
 
 	return 0;
 }
@@ -2987,7 +2987,7 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 	if (level > PT_PAGE_TABLE_LEVEL)
 		spte |= PT_PAGE_SIZE_MASK;
 	if (tdp_enabled)
-		spte |= kvm_x86_ops->get_mt_mask(vcpu, gfn,
+		spte |= kvm_x86_get_mt_mask(vcpu, gfn,
 			kvm_is_mmio_pfn(pfn));
 
 	if (host_writable)
@@ -4258,7 +4258,7 @@ static bool fast_cr3_switch(struct kvm_vcpu *vcpu, gpa_t new_cr3,
 			kvm_make_request(KVM_REQ_LOAD_CR3, vcpu);
 			if (!skip_tlb_flush) {
 				kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
-				kvm_x86_ops->tlb_flush(vcpu, true);
+				kvm_x86_tlb_flush(vcpu, true);
 			}
 
 			/*
@@ -4853,7 +4853,7 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu, bool base_only)
 	union kvm_mmu_role role = kvm_calc_mmu_role_common(vcpu, base_only);
 
 	role.base.ad_disabled = (shadow_accessed_mask == 0);
-	role.base.level = kvm_x86_ops->get_tdp_level(vcpu);
+	role.base.level = kvm_x86_get_tdp_level(vcpu);
 	role.base.direct = true;
 	role.base.gpte_is_8_bytes = true;
 
@@ -4875,7 +4875,7 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
 	context->sync_page = nonpaging_sync_page;
 	context->invlpg = nonpaging_invlpg;
 	context->update_pte = nonpaging_update_pte;
-	context->shadow_root_level = kvm_x86_ops->get_tdp_level(vcpu);
+	context->shadow_root_level = kvm_x86_get_tdp_level(vcpu);
 	context->direct_map = true;
 	context->set_cr3 = kvm_x86_ops->set_tdp_cr3;
 	context->get_cr3 = get_cr3;
@@ -5132,7 +5132,7 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
 	if (r)
 		goto out;
 	kvm_mmu_load_cr3(vcpu);
-	kvm_x86_ops->tlb_flush(vcpu, true);
+	kvm_x86_tlb_flush(vcpu, true);
 out:
 	return r;
 }
@@ -5446,7 +5446,7 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t cr2, u64 error_code,
 	 * guest, with the exception of AMD Erratum 1096 which is unrecoverable.
 	 */
 	if (unlikely(insn && !insn_len)) {
-		if (!kvm_x86_ops->need_emulation_on_page_fault(vcpu))
+		if (!kvm_x86_need_emulation_on_page_fault(vcpu))
 			return 1;
 	}
 
@@ -5492,7 +5492,7 @@ void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
 		if (VALID_PAGE(mmu->prev_roots[i].hpa))
 			mmu->invlpg(vcpu, gva, mmu->prev_roots[i].hpa);
 
-	kvm_x86_ops->tlb_flush_gva(vcpu, gva);
+	kvm_x86_tlb_flush_gva(vcpu, gva);
 	++vcpu->stat.invlpg;
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_invlpg);
@@ -5517,7 +5517,7 @@ void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid)
 	}
 
 	if (tlb_flush)
-		kvm_x86_ops->tlb_flush_gva(vcpu, gva);
+		kvm_x86_tlb_flush_gva(vcpu, gva);
 
 	++vcpu->stat.invlpg;
 
@@ -5634,7 +5634,7 @@ static int alloc_mmu_pages(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu)
 	 * SVM's 32-bit NPT support, TDP paging doesn't use PAE paging and can
 	 * skip allocating the PDP table.
 	 */
-	if (tdp_enabled && kvm_x86_ops->get_tdp_level(vcpu) > PT32E_ROOT_LEVEL)
+	if (tdp_enabled && kvm_x86_get_tdp_level(vcpu) > PT32E_ROOT_LEVEL)
 		return 0;
 
 	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_DMA32);
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 11f8ec89433b..8ac288bc42eb 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -157,8 +157,8 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 				  unsigned pte_access, unsigned pte_pkey,
 				  unsigned pfec)
 {
-	int cpl = kvm_x86_ops->get_cpl(vcpu);
-	unsigned long rflags = kvm_x86_ops->get_rflags(vcpu);
+	int cpl = kvm_x86_get_cpl(vcpu);
+	unsigned long rflags = kvm_x86_get_rflags(vcpu);
 
 	/*
 	 * If CPL < 3, SMAP prevention are disabled if EFLAGS.AC = 1.
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 46875bbd0419..144e5d0c25ff 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -183,7 +183,7 @@ void reprogram_gp_counter(struct kvm_pmc *pmc, u64 eventsel)
 			  ARCH_PERFMON_EVENTSEL_CMASK |
 			  HSW_IN_TX |
 			  HSW_IN_TX_CHECKPOINTED))) {
-		config = kvm_x86_ops->pmu_ops->find_arch_event(pmc_to_pmu(pmc),
+		config = kvm_x86_pmu_find_arch_event(pmc_to_pmu(pmc),
 						      event_select,
 						      unit_mask);
 		if (config != PERF_COUNT_HW_MAX)
@@ -225,7 +225,7 @@ void reprogram_fixed_counter(struct kvm_pmc *pmc, u8 ctrl, int idx)
 	}
 
 	pmc_reprogram_counter(pmc, PERF_TYPE_HARDWARE,
-			      kvm_x86_ops->pmu_ops->find_fixed_event(idx),
+			      kvm_x86_pmu_find_fixed_event(idx),
 			      !(en_field & 0x2), /* exclude user */
 			      !(en_field & 0x1), /* exclude kernel */
 			      pmi, false, false);
@@ -234,7 +234,7 @@ EXPORT_SYMBOL_GPL(reprogram_fixed_counter);
 
 void reprogram_counter(struct kvm_pmu *pmu, int pmc_idx)
 {
-	struct kvm_pmc *pmc = kvm_x86_ops->pmu_ops->pmc_idx_to_pmc(pmu, pmc_idx);
+	struct kvm_pmc *pmc = kvm_x86_pmu_pmc_idx_to_pmc(pmu, pmc_idx);
 
 	if (!pmc)
 		return;
@@ -259,7 +259,7 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 	bitmask = pmu->reprogram_pmi;
 
 	for_each_set_bit(bit, (unsigned long *)&bitmask, X86_PMC_IDX_MAX) {
-		struct kvm_pmc *pmc = kvm_x86_ops->pmu_ops->pmc_idx_to_pmc(pmu, bit);
+		struct kvm_pmc *pmc = kvm_x86_pmu_pmc_idx_to_pmc(pmu, bit);
 
 		if (unlikely(!pmc || !pmc->perf_event)) {
 			clear_bit(bit, (unsigned long *)&pmu->reprogram_pmi);
@@ -273,7 +273,7 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 /* check if idx is a valid index to access PMU */
 int kvm_pmu_is_valid_msr_idx(struct kvm_vcpu *vcpu, unsigned idx)
 {
-	return kvm_x86_ops->pmu_ops->is_valid_msr_idx(vcpu, idx);
+	return kvm_x86_pmu_is_valid_msr_idx(vcpu, idx);
 }
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx)
@@ -323,7 +323,7 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 	if (is_vmware_backdoor_pmc(idx))
 		return kvm_pmu_rdpmc_vmware(vcpu, idx, data);
 
-	pmc = kvm_x86_ops->pmu_ops->msr_idx_to_pmc(vcpu, idx, &mask);
+	pmc = kvm_x86_pmu_msr_idx_to_pmc(vcpu, idx, &mask);
 	if (!pmc)
 		return 1;
 
@@ -339,17 +339,17 @@ void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu)
 
 bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 {
-	return kvm_x86_ops->pmu_ops->is_valid_msr(vcpu, msr);
+	return kvm_x86_pmu_is_valid_msr(vcpu, msr);
 }
 
 int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 {
-	return kvm_x86_ops->pmu_ops->get_msr(vcpu, msr, data);
+	return kvm_x86_pmu_get_msr(vcpu, msr, data);
 }
 
 int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
-	return kvm_x86_ops->pmu_ops->set_msr(vcpu, msr_info);
+	return kvm_x86_pmu_set_msr(vcpu, msr_info);
 }
 
 /* refresh PMU settings. This function generally is called when underlying
@@ -358,7 +358,7 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
  */
 void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 {
-	kvm_x86_ops->pmu_ops->refresh(vcpu);
+	kvm_x86_pmu_refresh(vcpu);
 }
 
 void kvm_pmu_reset(struct kvm_vcpu *vcpu)
@@ -366,7 +366,7 @@ void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 
 	irq_work_sync(&pmu->irq_work);
-	kvm_x86_ops->pmu_ops->reset(vcpu);
+	kvm_x86_pmu_reset(vcpu);
 }
 
 void kvm_pmu_init(struct kvm_vcpu *vcpu)
@@ -374,7 +374,7 @@ void kvm_pmu_init(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 
 	memset(pmu, 0, sizeof(*pmu));
-	kvm_x86_ops->pmu_ops->init(vcpu);
+	kvm_x86_pmu_init(vcpu);
 	init_irq_work(&pmu->irq_work, kvm_pmi_trigger_fn);
 	kvm_pmu_refresh(vcpu);
 }
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 58265f761c3b..82f07e3492df 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -19,6 +19,23 @@ struct kvm_event_hw_type_mapping {
 	unsigned event_type;
 };
 
+extern unsigned kvm_x86_pmu_find_arch_event(struct kvm_pmu *pmu,
+					    u8 event_select, u8 unit_mask);
+extern unsigned kvm_x86_pmu_find_fixed_event(int idx);
+extern bool kvm_x86_pmu_pmc_is_enabled(struct kvm_pmc *pmc);
+extern struct kvm_pmc *kvm_x86_pmu_pmc_idx_to_pmc(struct kvm_pmu *pmu,
+						  int pmc_idx);
+extern struct kvm_pmc *kvm_x86_pmu_msr_idx_to_pmc(struct kvm_vcpu *vcpu,
+						  unsigned idx, u64 *mask);
+extern int kvm_x86_pmu_is_valid_msr_idx(struct kvm_vcpu *vcpu, unsigned idx);
+extern bool kvm_x86_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr);
+extern int kvm_x86_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data);
+extern int kvm_x86_pmu_set_msr(struct kvm_vcpu *vcpu,
+			       struct msr_data *msr_info);
+extern void kvm_x86_pmu_refresh(struct kvm_vcpu *vcpu);
+extern void kvm_x86_pmu_init(struct kvm_vcpu *vcpu);
+extern void kvm_x86_pmu_reset(struct kvm_vcpu *vcpu);
+
 struct kvm_pmu_ops {
 	unsigned (*find_arch_event)(struct kvm_pmu *pmu, u8 event_select,
 				    u8 unit_mask);
@@ -76,7 +93,7 @@ static inline bool pmc_is_fixed(struct kvm_pmc *pmc)
 
 static inline bool pmc_is_enabled(struct kvm_pmc *pmc)
 {
-	return kvm_x86_ops->pmu_ops->pmc_is_enabled(pmc);
+	return kvm_x86_pmu_pmc_is_enabled(pmc);
 }
 
 /* returns general purpose PMC with the specified MSR. Note that it can be
diff --git a/arch/x86/kvm/pmu_amd.c b/arch/x86/kvm/pmu_amd.c
index c8388389a3b0..7ea588023949 100644
--- a/arch/x86/kvm/pmu_amd.c
+++ b/arch/x86/kvm/pmu_amd.c
@@ -126,9 +126,8 @@ static inline struct kvm_pmc *get_gp_pmc_amd(struct kvm_pmu *pmu, u32 msr,
 	return &pmu->gp_counters[msr_to_index(msr)];
 }
 
-static unsigned amd_find_arch_event(struct kvm_pmu *pmu,
-				    u8 event_select,
-				    u8 unit_mask)
+unsigned kvm_x86_pmu_find_arch_event(struct kvm_pmu *pmu, u8 event_select,
+				     u8 unit_mask)
 {
 	int i;
 
@@ -144,7 +143,7 @@ static unsigned amd_find_arch_event(struct kvm_pmu *pmu,
 }
 
 /* return PERF_COUNT_HW_MAX as AMD doesn't have fixed events */
-static unsigned amd_find_fixed_event(int idx)
+unsigned kvm_x86_pmu_find_fixed_event(int idx)
 {
 	return PERF_COUNT_HW_MAX;
 }
@@ -152,12 +151,12 @@ static unsigned amd_find_fixed_event(int idx)
 /* check if a PMC is enabled by comparing it against global_ctrl bits. Because
  * AMD CPU doesn't have global_ctrl MSR, all PMCs are enabled (return TRUE).
  */
-static bool amd_pmc_is_enabled(struct kvm_pmc *pmc)
+bool kvm_x86_pmu_pmc_is_enabled(struct kvm_pmc *pmc)
 {
 	return true;
 }
 
-static struct kvm_pmc *amd_pmc_idx_to_pmc(struct kvm_pmu *pmu, int pmc_idx)
+struct kvm_pmc *kvm_x86_pmu_pmc_idx_to_pmc(struct kvm_pmu *pmu, int pmc_idx)
 {
 	unsigned int base = get_msr_base(pmu, PMU_TYPE_COUNTER);
 	struct kvm_vcpu *vcpu = pmu_to_vcpu(pmu);
@@ -174,7 +173,7 @@ static struct kvm_pmc *amd_pmc_idx_to_pmc(struct kvm_pmu *pmu, int pmc_idx)
 }
 
 /* returns 0 if idx's corresponding MSR exists; otherwise returns 1. */
-static int amd_is_valid_msr_idx(struct kvm_vcpu *vcpu, unsigned idx)
+int kvm_x86_pmu_is_valid_msr_idx(struct kvm_vcpu *vcpu, unsigned idx)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 
@@ -184,7 +183,8 @@ static int amd_is_valid_msr_idx(struct kvm_vcpu *vcpu, unsigned idx)
 }
 
 /* idx is the ECX register of RDPMC instruction */
-static struct kvm_pmc *amd_msr_idx_to_pmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *mask)
+struct kvm_pmc *kvm_x86_pmu_msr_idx_to_pmc(struct kvm_vcpu *vcpu, unsigned idx,
+					   u64 *mask)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *counters;
@@ -197,7 +197,7 @@ static struct kvm_pmc *amd_msr_idx_to_pmc(struct kvm_vcpu *vcpu, unsigned idx, u
 	return &counters[idx];
 }
 
-static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
+bool kvm_x86_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	int ret = false;
@@ -208,7 +208,7 @@ static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	return ret;
 }
 
-static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
+int kvm_x86_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
@@ -229,7 +229,7 @@ static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 	return 1;
 }
 
-static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+int kvm_x86_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
@@ -256,7 +256,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 1;
 }
 
-static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
+void kvm_x86_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 
@@ -274,7 +274,7 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->global_status = 0;
 }
 
-static void amd_pmu_init(struct kvm_vcpu *vcpu)
+void kvm_x86_pmu_init(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	int i;
@@ -288,7 +288,7 @@ static void amd_pmu_init(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void amd_pmu_reset(struct kvm_vcpu *vcpu)
+void kvm_x86_pmu_reset(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	int i;
@@ -302,16 +302,16 @@ static void amd_pmu_reset(struct kvm_vcpu *vcpu)
 }
 
 struct kvm_pmu_ops amd_pmu_ops = {
-	.find_arch_event = amd_find_arch_event,
-	.find_fixed_event = amd_find_fixed_event,
-	.pmc_is_enabled = amd_pmc_is_enabled,
-	.pmc_idx_to_pmc = amd_pmc_idx_to_pmc,
-	.msr_idx_to_pmc = amd_msr_idx_to_pmc,
-	.is_valid_msr_idx = amd_is_valid_msr_idx,
-	.is_valid_msr = amd_is_valid_msr,
-	.get_msr = amd_pmu_get_msr,
-	.set_msr = amd_pmu_set_msr,
-	.refresh = amd_pmu_refresh,
-	.init = amd_pmu_init,
-	.reset = amd_pmu_reset,
+	.find_arch_event = kvm_x86_pmu_find_arch_event,
+	.find_fixed_event = kvm_x86_pmu_find_fixed_event,
+	.pmc_is_enabled = kvm_x86_pmu_pmc_is_enabled,
+	.pmc_idx_to_pmc = kvm_x86_pmu_pmc_idx_to_pmc,
+	.msr_idx_to_pmc = kvm_x86_pmu_msr_idx_to_pmc,
+	.is_valid_msr_idx = kvm_x86_pmu_is_valid_msr_idx,
+	.is_valid_msr = kvm_x86_pmu_is_valid_msr,
+	.get_msr = kvm_x86_pmu_get_msr,
+	.set_msr = kvm_x86_pmu_set_msr,
+	.refresh = kvm_x86_pmu_refresh,
+	.init = kvm_x86_pmu_init,
+	.reset = kvm_x86_pmu_reset,
 };
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 04fe21849b6e..aa8c0efdc441 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -383,8 +383,6 @@ module_param(dump_invalid_vmcb, bool, 0644);
 
 static u8 rsm_ins_bytes[] = "\x0f\xaa";
 
-static void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
-static void svm_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gpa);
 static void svm_complete_interrupts(struct vcpu_svm *svm);
 
 static int nested_svm_exit_handled(struct vcpu_svm *svm);
@@ -722,7 +720,7 @@ static inline void invlpga(unsigned long addr, u32 asid)
 	asm volatile (__ex("invlpga %1, %0") : : "c"(asid), "a"(addr));
 }
 
-static int get_npt_level(struct kvm_vcpu *vcpu)
+int kvm_x86_get_tdp_level(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_X86_64
 	return PT64_ROOT_4LEVEL;
@@ -731,7 +729,7 @@ static int get_npt_level(struct kvm_vcpu *vcpu)
 #endif
 }
 
-static void svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
+void kvm_x86_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
 	vcpu->arch.efer = efer;
 	if (!npt_enabled && !(efer & EFER_LMA))
@@ -747,7 +745,7 @@ static int is_external_interrupt(u32 info)
 	return info == (SVM_EVTINJ_VALID | SVM_EVTINJ_TYPE_INTR);
 }
 
-static u32 svm_get_interrupt_shadow(struct kvm_vcpu *vcpu)
+u32 kvm_x86_get_interrupt_shadow(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u32 ret = 0;
@@ -757,7 +755,7 @@ static u32 svm_get_interrupt_shadow(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
-static void svm_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask)
+void kvm_x86_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -768,7 +766,7 @@ static void svm_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask)
 
 }
 
-static int skip_emulated_instruction(struct kvm_vcpu *vcpu)
+int kvm_x86_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -785,12 +783,12 @@ static int skip_emulated_instruction(struct kvm_vcpu *vcpu)
 		       __func__, kvm_rip_read(vcpu), svm->next_rip);
 
 	kvm_rip_write(vcpu, svm->next_rip);
-	svm_set_interrupt_shadow(vcpu, 0);
+	kvm_x86_set_interrupt_shadow(vcpu, 0);
 
 	return EMULATE_DONE;
 }
 
-static void svm_queue_exception(struct kvm_vcpu *vcpu)
+void kvm_x86_queue_exception(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	unsigned nr = vcpu->arch.exception.nr;
@@ -818,7 +816,7 @@ static void svm_queue_exception(struct kvm_vcpu *vcpu)
 		 * raises a fault that is not intercepted. Still better than
 		 * failing in all cases.
 		 */
-		(void)skip_emulated_instruction(&svm->vcpu);
+		(void)kvm_x86_skip_emulated_instruction(&svm->vcpu);
 		rip = kvm_rip_read(&svm->vcpu);
 		svm->int3_rip = rip + svm->vmcb->save.cs.base;
 		svm->int3_injected = rip - old_rip;
@@ -876,7 +874,7 @@ static void svm_init_osvw(struct kvm_vcpu *vcpu)
 		vcpu->arch.osvw.status |= 1;
 }
 
-static int has_svm(void)
+int kvm_x86_cpu_has_kvm_support(void)
 {
 	const char *msg;
 
@@ -888,7 +886,7 @@ static int has_svm(void)
 	return 1;
 }
 
-static void svm_hardware_disable(void)
+void kvm_x86_hardware_disable(void)
 {
 	/* Make sure we clean up behind us */
 	if (static_cpu_has(X86_FEATURE_TSCRATEMSR))
@@ -899,7 +897,7 @@ static void svm_hardware_disable(void)
 	amd_pmu_disable_virt();
 }
 
-static int svm_hardware_enable(void)
+int kvm_x86_hardware_enable(void)
 {
 
 	struct svm_cpu_data *sd;
@@ -911,7 +909,7 @@ static int svm_hardware_enable(void)
 	if (efer & EFER_SVME)
 		return -EBUSY;
 
-	if (!has_svm()) {
+	if (!kvm_x86_cpu_has_kvm_support()) {
 		pr_err("%s: err EOPNOTSUPP on %d\n", __func__, me);
 		return -EINVAL;
 	}
@@ -1291,7 +1289,7 @@ static void shrink_ple_window(struct kvm_vcpu *vcpu)
 	}
 }
 
-static __init int svm_hardware_setup(void)
+__init int kvm_x86_hardware_setup(void)
 {
 	int cpu;
 	struct page *iopm_pages;
@@ -1407,7 +1405,7 @@ static __init int svm_hardware_setup(void)
 	return r;
 }
 
-static __exit void svm_hardware_unsetup(void)
+__exit void kvm_x86_hardware_unsetup(void)
 {
 	int cpu;
 
@@ -1438,7 +1436,7 @@ static void init_sys_seg(struct vmcb_seg *seg, uint32_t type)
 	seg->base = 0;
 }
 
-static u64 svm_read_l1_tsc_offset(struct kvm_vcpu *vcpu)
+u64 kvm_x86_read_l1_tsc_offset(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -1448,7 +1446,7 @@ static u64 svm_read_l1_tsc_offset(struct kvm_vcpu *vcpu)
 	return vcpu->arch.tsc_offset;
 }
 
-static u64 svm_write_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
+u64 kvm_x86_write_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u64 g_tsc_offset = 0;
@@ -1572,17 +1570,17 @@ static void init_vmcb(struct vcpu_svm *svm)
 	init_sys_seg(&save->ldtr, SEG_TYPE_LDT);
 	init_sys_seg(&save->tr, SEG_TYPE_BUSY_TSS16);
 
-	svm_set_efer(&svm->vcpu, 0);
+	kvm_x86_set_efer(&svm->vcpu, 0);
 	save->dr6 = 0xffff0ff0;
 	kvm_set_rflags(&svm->vcpu, 2);
 	save->rip = 0x0000fff0;
 	svm->vcpu.arch.regs[VCPU_REGS_RIP] = save->rip;
 
 	/*
-	 * svm_set_cr0() sets PG and WP and clears NW and CD on save->cr0.
+	 * kvm_x86_set_cr0() sets PG and WP and clears NW and CD on save->cr0.
 	 * It also updates the guest-visible cr0 value.
 	 */
-	svm_set_cr0(&svm->vcpu, X86_CR0_NW | X86_CR0_CD | X86_CR0_ET);
+	kvm_x86_set_cr0(&svm->vcpu, X86_CR0_NW | X86_CR0_CD | X86_CR0_ET);
 	kvm_mmu_reset_context(&svm->vcpu);
 
 	save->cr4 = X86_CR4_PAE;
@@ -1870,7 +1868,7 @@ static void __unregister_enc_region_locked(struct kvm *kvm,
 	kfree(region);
 }
 
-static struct kvm *svm_vm_alloc(void)
+struct kvm *kvm_x86_vm_alloc(void)
 {
 	struct kvm_svm *kvm_svm = __vmalloc(sizeof(struct kvm_svm),
 					    GFP_KERNEL_ACCOUNT | __GFP_ZERO,
@@ -1878,7 +1876,7 @@ static struct kvm *svm_vm_alloc(void)
 	return &kvm_svm->kvm;
 }
 
-static void svm_vm_free(struct kvm *kvm)
+void kvm_x86_vm_free(struct kvm *kvm)
 {
 	vfree(to_kvm_svm(kvm));
 }
@@ -1929,13 +1927,13 @@ static void avic_vm_destroy(struct kvm *kvm)
 	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
 }
 
-static void svm_vm_destroy(struct kvm *kvm)
+void kvm_x86_vm_destroy(struct kvm *kvm)
 {
 	avic_vm_destroy(kvm);
 	sev_vm_destroy(kvm);
 }
 
-static int avic_vm_init(struct kvm *kvm)
+int kvm_x86_vm_init(struct kvm *kvm)
 {
 	unsigned long flags;
 	int err = -ENOMEM;
@@ -2081,7 +2079,7 @@ static void avic_set_running(struct kvm_vcpu *vcpu, bool is_run)
 		avic_vcpu_put(vcpu);
 }
 
-static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
+void kvm_x86_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u32 dummy;
@@ -2124,7 +2122,7 @@ static int avic_init_vcpu(struct vcpu_svm *svm)
 	return ret;
 }
 
-static struct kvm_vcpu *svm_create_vcpu(struct kvm *kvm, unsigned int id)
+struct kvm_vcpu *kvm_x86_vcpu_create(struct kvm *kvm, unsigned int id)
 {
 	struct vcpu_svm *svm;
 	struct page *page;
@@ -2234,13 +2232,13 @@ static void svm_clear_current_vmcb(struct vmcb *vmcb)
 		cmpxchg(&per_cpu(svm_data, i)->current_vmcb, vmcb, NULL);
 }
 
-static void svm_free_vcpu(struct kvm_vcpu *vcpu)
+void kvm_x86_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	/*
 	 * The vmcb page can be recycled, causing a false negative in
-	 * svm_vcpu_load(). So, ensure that no logical CPU has this
+	 * kvm_x86_vcpu_load(). So, ensure that no logical CPU has this
 	 * vmcb page recorded as its current vmcb.
 	 */
 	svm_clear_current_vmcb(svm->vmcb);
@@ -2255,7 +2253,7 @@ static void svm_free_vcpu(struct kvm_vcpu *vcpu)
 	kmem_cache_free(kvm_vcpu_cache, svm);
 }
 
-static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+void kvm_x86_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct svm_cpu_data *sd = per_cpu(svm_data, cpu);
@@ -2294,7 +2292,7 @@ static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	avic_vcpu_load(vcpu, cpu);
 }
 
-static void svm_vcpu_put(struct kvm_vcpu *vcpu)
+void kvm_x86_vcpu_put(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	int i;
@@ -2316,17 +2314,17 @@ static void svm_vcpu_put(struct kvm_vcpu *vcpu)
 		wrmsrl(host_save_user_msrs[i], svm->host_user_msrs[i]);
 }
 
-static void svm_vcpu_blocking(struct kvm_vcpu *vcpu)
+void kvm_x86_vcpu_blocking(struct kvm_vcpu *vcpu)
 {
 	avic_set_running(vcpu, false);
 }
 
-static void svm_vcpu_unblocking(struct kvm_vcpu *vcpu)
+void kvm_x86_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
 	avic_set_running(vcpu, true);
 }
 
-static unsigned long svm_get_rflags(struct kvm_vcpu *vcpu)
+unsigned long kvm_x86_get_rflags(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	unsigned long rflags = svm->vmcb->save.rflags;
@@ -2341,7 +2339,7 @@ static unsigned long svm_get_rflags(struct kvm_vcpu *vcpu)
 	return rflags;
 }
 
-static void svm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
+void kvm_x86_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
 {
 	if (to_svm(vcpu)->nmi_singlestep)
 		rflags |= (X86_EFLAGS_TF | X86_EFLAGS_RF);
@@ -2354,7 +2352,7 @@ static void svm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
 	to_svm(vcpu)->vmcb->save.rflags = rflags;
 }
 
-static void svm_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
+void kvm_x86_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
 {
 	switch (reg) {
 	case VCPU_EXREG_PDPTR:
@@ -2394,15 +2392,15 @@ static struct vmcb_seg *svm_seg(struct kvm_vcpu *vcpu, int seg)
 	return NULL;
 }
 
-static u64 svm_get_segment_base(struct kvm_vcpu *vcpu, int seg)
+u64 kvm_x86_get_segment_base(struct kvm_vcpu *vcpu, int seg)
 {
 	struct vmcb_seg *s = svm_seg(vcpu, seg);
 
 	return s->base;
 }
 
-static void svm_get_segment(struct kvm_vcpu *vcpu,
-			    struct kvm_segment *var, int seg)
+void kvm_x86_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var,
+			 int seg)
 {
 	struct vmcb_seg *s = svm_seg(vcpu, seg);
 
@@ -2464,20 +2462,20 @@ static void svm_get_segment(struct kvm_vcpu *vcpu,
 		 */
 		if (var->unusable)
 			var->db = 0;
-		/* This is symmetric with svm_set_segment() */
+		/* This is symmetric with kvm_x86_set_segment() */
 		var->dpl = to_svm(vcpu)->vmcb->save.cpl;
 		break;
 	}
 }
 
-static int svm_get_cpl(struct kvm_vcpu *vcpu)
+int kvm_x86_get_cpl(struct kvm_vcpu *vcpu)
 {
 	struct vmcb_save_area *save = &to_svm(vcpu)->vmcb->save;
 
 	return save->cpl;
 }
 
-static void svm_get_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void kvm_x86_get_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -2485,7 +2483,7 @@ static void svm_get_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 	dt->address = svm->vmcb->save.idtr.base;
 }
 
-static void svm_set_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void kvm_x86_set_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -2494,7 +2492,7 @@ static void svm_set_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 	mark_dirty(svm->vmcb, VMCB_DT);
 }
 
-static void svm_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void kvm_x86_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -2502,7 +2500,7 @@ static void svm_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 	dt->address = svm->vmcb->save.gdtr.base;
 }
 
-static void svm_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void kvm_x86_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -2511,15 +2509,15 @@ static void svm_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 	mark_dirty(svm->vmcb, VMCB_DT);
 }
 
-static void svm_decache_cr0_guest_bits(struct kvm_vcpu *vcpu)
+void kvm_x86_decache_cr0_guest_bits(struct kvm_vcpu *vcpu)
 {
 }
 
-static void svm_decache_cr3(struct kvm_vcpu *vcpu)
+void kvm_x86_decache_cr3(struct kvm_vcpu *vcpu)
 {
 }
 
-static void svm_decache_cr4_guest_bits(struct kvm_vcpu *vcpu)
+void kvm_x86_decache_cr4_guest_bits(struct kvm_vcpu *vcpu)
 {
 }
 
@@ -2542,7 +2540,7 @@ static void update_cr0_intercept(struct vcpu_svm *svm)
 	}
 }
 
-static void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+void kvm_x86_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -2576,7 +2574,7 @@ static void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	update_cr0_intercept(svm);
 }
 
-static int svm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
+int kvm_x86_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
 	unsigned long host_cr4_mce = cr4_read_shadow() & X86_CR4_MCE;
 	unsigned long old_cr4 = to_svm(vcpu)->vmcb->save.cr4;
@@ -2585,7 +2583,7 @@ static int svm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 		return 1;
 
 	if (npt_enabled && ((old_cr4 ^ cr4) & X86_CR4_PGE))
-		svm_flush_tlb(vcpu, true);
+		kvm_x86_tlb_flush(vcpu, true);
 
 	vcpu->arch.cr4 = cr4;
 	if (!npt_enabled)
@@ -2596,8 +2594,8 @@ static int svm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 	return 0;
 }
 
-static void svm_set_segment(struct kvm_vcpu *vcpu,
-			    struct kvm_segment *var, int seg)
+void kvm_x86_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var,
+			 int seg)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb_seg *s = svm_seg(vcpu, seg);
@@ -2621,13 +2619,13 @@ static void svm_set_segment(struct kvm_vcpu *vcpu,
 	 * would entail passing the CPL to userspace and back.
 	 */
 	if (seg == VCPU_SREG_SS)
-		/* This is symmetric with svm_get_segment() */
+		/* This is symmetric with kvm_x86_get_segment() */
 		svm->vmcb->save.cpl = (var->dpl & 3);
 
 	mark_dirty(svm->vmcb, VMCB_SEG);
 }
 
-static void update_bp_intercept(struct kvm_vcpu *vcpu)
+void kvm_x86_update_bp_intercept(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -2654,12 +2652,12 @@ static void new_asid(struct vcpu_svm *svm, struct svm_cpu_data *sd)
 	mark_dirty(svm->vmcb, VMCB_ASID);
 }
 
-static u64 svm_get_dr6(struct kvm_vcpu *vcpu)
+u64 kvm_x86_get_dr6(struct kvm_vcpu *vcpu)
 {
 	return to_svm(vcpu)->vmcb->save.dr6;
 }
 
-static void svm_set_dr6(struct kvm_vcpu *vcpu, unsigned long value)
+void kvm_x86_set_dr6(struct kvm_vcpu *vcpu, unsigned long value)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -2667,7 +2665,7 @@ static void svm_set_dr6(struct kvm_vcpu *vcpu, unsigned long value)
 	mark_dirty(svm->vmcb, VMCB_DR);
 }
 
-static void svm_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
+void kvm_x86_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -2675,14 +2673,14 @@ static void svm_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 	get_debugreg(vcpu->arch.db[1], 1);
 	get_debugreg(vcpu->arch.db[2], 2);
 	get_debugreg(vcpu->arch.db[3], 3);
-	vcpu->arch.dr6 = svm_get_dr6(vcpu);
+	vcpu->arch.dr6 = kvm_x86_get_dr6(vcpu);
 	vcpu->arch.dr7 = svm->vmcb->save.dr7;
 
 	vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_WONT_EXIT;
 	set_dr_intercepts(svm);
 }
 
-static void svm_set_dr7(struct kvm_vcpu *vcpu, unsigned long value)
+void kvm_x86_set_dr7(struct kvm_vcpu *vcpu, unsigned long value)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -2980,7 +2978,7 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu->get_cr3           = nested_svm_get_tdp_cr3;
 	vcpu->arch.mmu->get_pdptr         = nested_svm_get_tdp_pdptr;
 	vcpu->arch.mmu->inject_page_fault = nested_svm_inject_npf_exit;
-	vcpu->arch.mmu->shadow_root_level = get_npt_level(vcpu);
+	vcpu->arch.mmu->shadow_root_level = kvm_x86_get_tdp_level(vcpu);
 	reset_shadow_zero_bits_mask(vcpu, vcpu->arch.mmu);
 	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
 }
@@ -3400,9 +3398,9 @@ static int nested_svm_vmexit(struct vcpu_svm *svm)
 	svm->vmcb->save.gdtr = hsave->save.gdtr;
 	svm->vmcb->save.idtr = hsave->save.idtr;
 	kvm_set_rflags(&svm->vcpu, hsave->save.rflags);
-	svm_set_efer(&svm->vcpu, hsave->save.efer);
-	svm_set_cr0(&svm->vcpu, hsave->save.cr0 | X86_CR0_PE);
-	svm_set_cr4(&svm->vcpu, hsave->save.cr4);
+	kvm_x86_set_efer(&svm->vcpu, hsave->save.efer);
+	kvm_x86_set_cr0(&svm->vcpu, hsave->save.cr0 | X86_CR0_PE);
+	kvm_x86_set_cr4(&svm->vcpu, hsave->save.cr4);
 	if (npt_enabled) {
 		svm->vmcb->save.cr3 = hsave->save.cr3;
 		svm->vcpu.arch.cr3 = hsave->save.cr3;
@@ -3504,9 +3502,9 @@ static void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 	svm->vmcb->save.gdtr = nested_vmcb->save.gdtr;
 	svm->vmcb->save.idtr = nested_vmcb->save.idtr;
 	kvm_set_rflags(&svm->vcpu, nested_vmcb->save.rflags);
-	svm_set_efer(&svm->vcpu, nested_vmcb->save.efer);
-	svm_set_cr0(&svm->vcpu, nested_vmcb->save.cr0);
-	svm_set_cr4(&svm->vcpu, nested_vmcb->save.cr4);
+	kvm_x86_set_efer(&svm->vcpu, nested_vmcb->save.efer);
+	kvm_x86_set_cr0(&svm->vcpu, nested_vmcb->save.cr0);
+	kvm_x86_set_cr4(&svm->vcpu, nested_vmcb->save.cr4);
 	if (npt_enabled) {
 		svm->vmcb->save.cr3 = nested_vmcb->save.cr3;
 		svm->vcpu.arch.cr3 = nested_vmcb->save.cr3;
@@ -3538,7 +3536,7 @@ static void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 	svm->nested.intercept_exceptions = nested_vmcb->control.intercept_exceptions;
 	svm->nested.intercept            = nested_vmcb->control.intercept;
 
-	svm_flush_tlb(&svm->vcpu, true);
+	kvm_x86_tlb_flush(&svm->vcpu, true);
 	svm->vmcb->control.int_ctl = nested_vmcb->control.int_ctl | V_INTR_MASKING_MASK;
 	if (nested_vmcb->control.int_ctl & V_INTR_MASKING_MASK)
 		svm->vcpu.arch.hflags |= HF_VINTR_MASK;
@@ -3883,7 +3881,7 @@ static int task_switch_interception(struct vcpu_svm *svm)
 	    int_type == SVM_EXITINTINFO_TYPE_SOFT ||
 	    (int_type == SVM_EXITINTINFO_TYPE_EXEPT &&
 	     (int_vec == OF_VECTOR || int_vec == BP_VECTOR))) {
-		if (skip_emulated_instruction(&svm->vcpu) != EMULATE_DONE)
+		if (kvm_x86_skip_emulated_instruction(&svm->vcpu) != EMULATE_DONE)
 			goto fail;
 	}
 
@@ -4099,7 +4097,7 @@ static int cr8_write_interception(struct vcpu_svm *svm)
 	return 0;
 }
 
-static int svm_get_msr_feature(struct kvm_msr_entry *msr)
+int kvm_x86_get_msr_feature(struct kvm_msr_entry *msr)
 {
 	msr->data = 0;
 
@@ -4115,7 +4113,7 @@ static int svm_get_msr_feature(struct kvm_msr_entry *msr)
 	return 0;
 }
 
-static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+int kvm_x86_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -4248,7 +4246,7 @@ static int svm_set_vm_cr(struct kvm_vcpu *vcpu, u64 data)
 	return 0;
 }
 
-static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
+int kvm_x86_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -4384,7 +4382,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		struct kvm_msr_entry msr_entry;
 
 		msr_entry.index = msr->index;
-		if (svm_get_msr_feature(&msr_entry))
+		if (kvm_x86_get_msr_feature(&msr_entry))
 			return 1;
 
 		/* Check the supported bits */
@@ -4434,7 +4432,7 @@ static int interrupt_window_interception(struct vcpu_svm *svm)
 static int pause_interception(struct vcpu_svm *svm)
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
-	bool in_kernel = (svm_get_cpl(vcpu) == 0);
+	bool in_kernel = (kvm_x86_get_cpl(vcpu) == 0);
 
 	if (pause_filter_thresh)
 		grow_ple_window(vcpu);
@@ -4913,7 +4911,7 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 	       "excp_to:", save->last_excp_to);
 }
 
-static void svm_get_exit_info(struct kvm_vcpu *vcpu, u64 *info1, u64 *info2)
+void kvm_x86_get_exit_info(struct kvm_vcpu *vcpu, u64 *info1, u64 *info2)
 {
 	struct vmcb_control_area *control = &to_svm(vcpu)->vmcb->control;
 
@@ -4921,7 +4919,7 @@ static void svm_get_exit_info(struct kvm_vcpu *vcpu, u64 *info1, u64 *info2)
 	*info2 = control->exit_info_2;
 }
 
-static int handle_exit(struct kvm_vcpu *vcpu)
+int kvm_x86_handle_exit(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_run *kvm_run = vcpu->run;
@@ -5041,7 +5039,7 @@ static void pre_svm_run(struct vcpu_svm *svm)
 		new_asid(svm, sd);
 }
 
-static void svm_inject_nmi(struct kvm_vcpu *vcpu)
+void kvm_x86_set_nmi(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -5064,7 +5062,7 @@ static inline void svm_inject_irq(struct vcpu_svm *svm, int irq)
 	mark_dirty(svm->vmcb, VMCB_INTR);
 }
 
-static void svm_set_irq(struct kvm_vcpu *vcpu)
+void kvm_x86_set_irq(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -5082,7 +5080,7 @@ static inline bool svm_nested_virtualize_tpr(struct kvm_vcpu *vcpu)
 	return is_guest_mode(vcpu) && (vcpu->arch.hflags & HF_VINTR_MASK);
 }
 
-static void update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
+void kvm_x86_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -5099,26 +5097,26 @@ static void update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
 		set_cr_intercept(svm, INTERCEPT_CR8_WRITE);
 }
 
-static void svm_set_virtual_apic_mode(struct kvm_vcpu *vcpu)
+void kvm_x86_set_virtual_apic_mode(struct kvm_vcpu *vcpu)
 {
 	return;
 }
 
-static bool svm_get_enable_apicv(struct kvm_vcpu *vcpu)
+bool kvm_x86_get_enable_apicv(struct kvm_vcpu *vcpu)
 {
 	return avic && irqchip_split(vcpu->kvm);
 }
 
-static void svm_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
+void kvm_x86_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
 {
 }
 
-static void svm_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
+void kvm_x86_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
 {
 }
 
 /* Note: Currently only used by Hyper-V. */
-static void svm_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
+void kvm_x86_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb = svm->vmcb;
@@ -5130,12 +5128,12 @@ static void svm_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 	mark_dirty(vmcb, VMCB_AVIC);
 }
 
-static void svm_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
+void kvm_x86_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 {
 	return;
 }
 
-static void svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
+void kvm_x86_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vec)
 {
 	kvm_lapic_set_irr(vec, vcpu->arch.apic);
 	smp_mb__after_atomic();
@@ -5150,7 +5148,7 @@ static void svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
 		kvm_vcpu_wake_up(vcpu);
 }
 
-static bool svm_dy_apicv_has_pending_interrupt(struct kvm_vcpu *vcpu)
+bool kvm_x86_dy_apicv_has_pending_interrupt(struct kvm_vcpu *vcpu)
 {
 	return false;
 }
@@ -5260,8 +5258,8 @@ get_pi_vcpu_info(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e,
  * @set: set or unset PI
  * returns 0 on success, < 0 on failure
  */
-static int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
-			      uint32_t guest_irq, bool set)
+int kvm_x86_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
+			   uint32_t guest_irq, bool set)
 {
 	struct kvm_kernel_irq_routing_entry *e;
 	struct kvm_irq_routing_table *irq_rt;
@@ -5360,7 +5358,7 @@ static int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
 	return ret;
 }
 
-static int svm_nmi_allowed(struct kvm_vcpu *vcpu)
+int kvm_x86_nmi_allowed(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb = svm->vmcb;
@@ -5372,14 +5370,14 @@ static int svm_nmi_allowed(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
-static bool svm_get_nmi_mask(struct kvm_vcpu *vcpu)
+bool kvm_x86_get_nmi_mask(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	return !!(svm->vcpu.arch.hflags & HF_NMI_MASK);
 }
 
-static void svm_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
+void kvm_x86_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -5392,7 +5390,7 @@ static void svm_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
 	}
 }
 
-static int svm_interrupt_allowed(struct kvm_vcpu *vcpu)
+int kvm_x86_interrupt_allowed(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb = svm->vmcb;
@@ -5410,7 +5408,7 @@ static int svm_interrupt_allowed(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
-static void enable_irq_window(struct kvm_vcpu *vcpu)
+void kvm_x86_enable_irq_window(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -5431,7 +5429,7 @@ static void enable_irq_window(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void enable_nmi_window(struct kvm_vcpu *vcpu)
+void kvm_x86_enable_nmi_window(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -5452,22 +5450,22 @@ static void enable_nmi_window(struct kvm_vcpu *vcpu)
 	 * Something prevents NMI from been injected. Single step over possible
 	 * problem (IRET or exception injection or interrupt shadow)
 	 */
-	svm->nmi_singlestep_guest_rflags = svm_get_rflags(vcpu);
+	svm->nmi_singlestep_guest_rflags = kvm_x86_get_rflags(vcpu);
 	svm->nmi_singlestep = true;
 	svm->vmcb->save.rflags |= (X86_EFLAGS_TF | X86_EFLAGS_RF);
 }
 
-static int svm_set_tss_addr(struct kvm *kvm, unsigned int addr)
+int kvm_x86_set_tss_addr(struct kvm *kvm, unsigned int addr)
 {
 	return 0;
 }
 
-static int svm_set_identity_map_addr(struct kvm *kvm, u64 ident_addr)
+int kvm_x86_set_identity_map_addr(struct kvm *kvm, u64 ident_addr)
 {
 	return 0;
 }
 
-static void svm_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gpa)
+void kvm_x86_tlb_flush(struct kvm_vcpu *vcpu, bool invalidate_gpa)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -5477,14 +5475,14 @@ static void svm_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gpa)
 		svm->asid_generation--;
 }
 
-static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
+void kvm_x86_tlb_flush_gva(struct kvm_vcpu *vcpu, gva_t gva)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	invlpga(gva, svm->vmcb->control.asid);
 }
 
-static void svm_prepare_guest_switch(struct kvm_vcpu *vcpu)
+void kvm_x86_prepare_guest_switch(struct kvm_vcpu *vcpu)
 {
 }
 
@@ -5579,7 +5577,7 @@ static void svm_complete_interrupts(struct vcpu_svm *svm)
 	}
 }
 
-static void svm_cancel_injection(struct kvm_vcpu *vcpu)
+void kvm_x86_cancel_injection(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb_control_area *control = &svm->vmcb->control;
@@ -5590,7 +5588,7 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
 	svm_complete_interrupts(svm);
 }
 
-static void svm_vcpu_run(struct kvm_vcpu *vcpu)
+void kvm_x86_run(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -5811,9 +5809,9 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	mark_all_clean(svm->vmcb);
 }
-STACK_FRAME_NON_STANDARD(svm_vcpu_run);
+STACK_FRAME_NON_STANDARD(kvm_x86_run);
 
-static void svm_set_cr3(struct kvm_vcpu *vcpu, unsigned long root)
+void kvm_x86_set_cr3(struct kvm_vcpu *vcpu, unsigned long root)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -5821,7 +5819,7 @@ static void svm_set_cr3(struct kvm_vcpu *vcpu, unsigned long root)
 	mark_dirty(svm->vmcb, VMCB_CR);
 }
 
-static void set_tdp_cr3(struct kvm_vcpu *vcpu, unsigned long root)
+void kvm_x86_set_tdp_cr3(struct kvm_vcpu *vcpu, unsigned long root)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -5833,7 +5831,7 @@ static void set_tdp_cr3(struct kvm_vcpu *vcpu, unsigned long root)
 	mark_dirty(svm->vmcb, VMCB_CR);
 }
 
-static int is_disabled(void)
+int kvm_x86_disabled_by_bios(void)
 {
 	u64 vm_cr;
 
@@ -5844,8 +5842,7 @@ static int is_disabled(void)
 	return 0;
 }
 
-static void
-svm_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hypercall)
+void kvm_x86_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hypercall)
 {
 	/*
 	 * Patch in the VMMCALL instruction:
@@ -5855,17 +5852,17 @@ svm_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hypercall)
 	hypercall[2] = 0xd9;
 }
 
-static int __init svm_check_processor_compat(void)
+__init int kvm_x86_check_processor_compatibility(void)
 {
 	return 0;
 }
 
-static bool svm_cpu_has_accelerated_tpr(void)
+bool kvm_x86_cpu_has_accelerated_tpr(void)
 {
 	return false;
 }
 
-static bool svm_has_emulated_msr(int index)
+bool kvm_x86_has_emulated_msr(int index)
 {
 	switch (index) {
 	case MSR_IA32_MCG_EXT_CTL:
@@ -5878,12 +5875,12 @@ static bool svm_has_emulated_msr(int index)
 	return true;
 }
 
-static u64 svm_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
+u64 kvm_x86_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 {
 	return 0;
 }
 
-static void svm_cpuid_update(struct kvm_vcpu *vcpu)
+void kvm_x86_cpuid_update(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -5898,7 +5895,7 @@ static void svm_cpuid_update(struct kvm_vcpu *vcpu)
 
 #define F(x) bit(X86_FEATURE_##x)
 
-static void svm_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *entry)
+void kvm_x86_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *entry)
 {
 	switch (func) {
 	case 0x1:
@@ -5940,42 +5937,42 @@ static void svm_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *entry)
 	}
 }
 
-static int svm_get_lpage_level(void)
+int kvm_x86_get_lpage_level(void)
 {
 	return PT_PDPE_LEVEL;
 }
 
-static bool svm_rdtscp_supported(void)
+bool kvm_x86_rdtscp_supported(void)
 {
 	return boot_cpu_has(X86_FEATURE_RDTSCP);
 }
 
-static bool svm_invpcid_supported(void)
+bool kvm_x86_invpcid_supported(void)
 {
 	return false;
 }
 
-static bool svm_mpx_supported(void)
+bool kvm_x86_mpx_supported(void)
 {
 	return false;
 }
 
-static bool svm_xsaves_supported(void)
+bool kvm_x86_xsaves_supported(void)
 {
 	return false;
 }
 
-static bool svm_umip_emulated(void)
+bool kvm_x86_umip_emulated(void)
 {
 	return false;
 }
 
-static bool svm_pt_supported(void)
+bool kvm_x86_pt_supported(void)
 {
 	return false;
 }
 
-static bool svm_has_wbinvd_exit(void)
+bool kvm_x86_has_wbinvd_exit(void)
 {
 	return true;
 }
@@ -6044,9 +6041,9 @@ static const struct __x86_intercept {
 #undef POST_EX
 #undef POST_MEM
 
-static int svm_check_intercept(struct kvm_vcpu *vcpu,
-			       struct x86_instruction_info *info,
-			       enum x86_intercept_stage stage)
+int kvm_x86_check_intercept(struct kvm_vcpu *vcpu,
+			    struct x86_instruction_info *info,
+			    enum x86_intercept_stage stage)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	int vmexit, ret = X86EMUL_CONTINUE;
@@ -6165,18 +6162,18 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 	return ret;
 }
 
-static void svm_handle_exit_irqoff(struct kvm_vcpu *vcpu)
+void kvm_x86_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 {
 
 }
 
-static void svm_sched_in(struct kvm_vcpu *vcpu, int cpu)
+void kvm_x86_sched_in(struct kvm_vcpu *vcpu, int cpu)
 {
 	if (pause_filter_thresh)
 		shrink_ple_window(vcpu);
 }
 
-static inline void avic_post_state_restore(struct kvm_vcpu *vcpu)
+void kvm_x86_apicv_post_state_restore(struct kvm_vcpu *vcpu)
 {
 	if (avic_handle_apic_id_update(vcpu) != 0)
 		return;
@@ -6184,13 +6181,13 @@ static inline void avic_post_state_restore(struct kvm_vcpu *vcpu)
 	avic_handle_ldr_update(vcpu);
 }
 
-static void svm_setup_mce(struct kvm_vcpu *vcpu)
+void kvm_x86_setup_mce(struct kvm_vcpu *vcpu)
 {
 	/* [63:9] are reserved. */
 	vcpu->arch.mcg_cap &= 0x1ff;
 }
 
-static int svm_smi_allowed(struct kvm_vcpu *vcpu)
+int kvm_x86_smi_allowed(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -6209,7 +6206,7 @@ static int svm_smi_allowed(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static int svm_pre_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
+int kvm_x86_pre_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	int ret;
@@ -6231,7 +6228,7 @@ static int svm_pre_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
 	return 0;
 }
 
-static int svm_pre_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
+int kvm_x86_pre_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *nested_vmcb;
@@ -6251,7 +6248,7 @@ static int svm_pre_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
 	return 0;
 }
 
-static int enable_smi_window(struct kvm_vcpu *vcpu)
+int kvm_x86_enable_smi_window(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -6954,7 +6951,7 @@ static int sev_launch_secret(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return ret;
 }
 
-static int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
+int kvm_x86_mem_enc_op(struct kvm *kvm, void __user *argp)
 {
 	struct kvm_sev_cmd sev_cmd;
 	int r;
@@ -7008,8 +7005,7 @@ static int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 	return r;
 }
 
-static int svm_register_enc_region(struct kvm *kvm,
-				   struct kvm_enc_region *range)
+int kvm_x86_mem_enc_reg_region(struct kvm *kvm, struct kvm_enc_region *range)
 {
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
 	struct enc_region *region;
@@ -7070,8 +7066,7 @@ find_enc_region(struct kvm *kvm, struct kvm_enc_region *range)
 }
 
 
-static int svm_unregister_enc_region(struct kvm *kvm,
-				     struct kvm_enc_region *range)
+int kvm_x86_mem_enc_unreg_region(struct kvm *kvm, struct kvm_enc_region *range)
 {
 	struct enc_region *region;
 	int ret;
@@ -7099,19 +7094,18 @@ static int svm_unregister_enc_region(struct kvm *kvm,
 	return ret;
 }
 
-static int nested_enable_evmcs(struct kvm_vcpu *vcpu,
-				   uint16_t *vmcs_version)
+int kvm_x86_nested_enable_evmcs(struct kvm_vcpu *vcpu, uint16_t *vmcs_version)
 {
 	/* Intel-only feature */
 	return -ENODEV;
 }
 
-static bool svm_need_emulation_on_page_fault(struct kvm_vcpu *vcpu)
+bool kvm_x86_need_emulation_on_page_fault(struct kvm_vcpu *vcpu)
 {
 	unsigned long cr4 = kvm_read_cr4(vcpu);
 	bool smep = cr4 & X86_CR4_SMEP;
 	bool smap = cr4 & X86_CR4_SMAP;
-	bool is_user = svm_get_cpl(vcpu) == 3;
+	bool is_user = kvm_x86_get_cpl(vcpu) == 3;
 
 	/*
 	 * Detect and workaround Errata 1096 Fam_17h_00_0Fh.
@@ -7164,7 +7158,7 @@ static bool svm_need_emulation_on_page_fault(struct kvm_vcpu *vcpu)
 	return false;
 }
 
-static bool svm_apic_init_signal_blocked(struct kvm_vcpu *vcpu)
+bool kvm_x86_apic_init_signal_blocked(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -7172,151 +7166,166 @@ static bool svm_apic_init_signal_blocked(struct kvm_vcpu *vcpu)
 	 * TODO: Last condition latch INIT signals on vCPU when
 	 * vCPU is in guest-mode and vmcb12 defines intercept on INIT.
 	 * To properly emulate the INIT intercept, SVM should implement
-	 * kvm_x86_ops->check_nested_events() and call nested_svm_vmexit()
+	 * kvm_x86_check_nested_events() and call nested_svm_vmexit()
 	 * there if an INIT signal is pending.
 	 */
 	return !gif_set(svm) ||
 		   (svm->vmcb->control.intercept & (1ULL << INTERCEPT_INIT));
 }
 
+void kvm_x86_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l)
+{
+	kvm_get_cs_db_l_bits(vcpu, db, l);
+}
+
+int kvm_x86_sync_pir_to_irr(struct kvm_vcpu *vcpu)
+{
+	return kvm_lapic_find_highest_irr(vcpu);
+}
+
+void kvm_x86_request_immediate_exit(struct kvm_vcpu *vcpu)
+{
+	__kvm_request_immediate_exit(vcpu);
+}
+
 static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
-	.cpu_has_kvm_support = has_svm,
-	.disabled_by_bios = is_disabled,
-	.hardware_setup = svm_hardware_setup,
-	.hardware_unsetup = svm_hardware_unsetup,
-	.check_processor_compatibility = svm_check_processor_compat,
-	.hardware_enable = svm_hardware_enable,
-	.hardware_disable = svm_hardware_disable,
-	.cpu_has_accelerated_tpr = svm_cpu_has_accelerated_tpr,
-	.has_emulated_msr = svm_has_emulated_msr,
-
-	.vcpu_create = svm_create_vcpu,
-	.vcpu_free = svm_free_vcpu,
-	.vcpu_reset = svm_vcpu_reset,
-
-	.vm_alloc = svm_vm_alloc,
-	.vm_free = svm_vm_free,
-	.vm_init = avic_vm_init,
-	.vm_destroy = svm_vm_destroy,
-
-	.prepare_guest_switch = svm_prepare_guest_switch,
-	.vcpu_load = svm_vcpu_load,
-	.vcpu_put = svm_vcpu_put,
-	.vcpu_blocking = svm_vcpu_blocking,
-	.vcpu_unblocking = svm_vcpu_unblocking,
-
-	.update_bp_intercept = update_bp_intercept,
-	.get_msr_feature = svm_get_msr_feature,
-	.get_msr = svm_get_msr,
-	.set_msr = svm_set_msr,
-	.get_segment_base = svm_get_segment_base,
-	.get_segment = svm_get_segment,
-	.set_segment = svm_set_segment,
-	.get_cpl = svm_get_cpl,
-	.get_cs_db_l_bits = kvm_get_cs_db_l_bits,
-	.decache_cr0_guest_bits = svm_decache_cr0_guest_bits,
-	.decache_cr3 = svm_decache_cr3,
-	.decache_cr4_guest_bits = svm_decache_cr4_guest_bits,
-	.set_cr0 = svm_set_cr0,
-	.set_cr3 = svm_set_cr3,
-	.set_cr4 = svm_set_cr4,
-	.set_efer = svm_set_efer,
-	.get_idt = svm_get_idt,
-	.set_idt = svm_set_idt,
-	.get_gdt = svm_get_gdt,
-	.set_gdt = svm_set_gdt,
-	.get_dr6 = svm_get_dr6,
-	.set_dr6 = svm_set_dr6,
-	.set_dr7 = svm_set_dr7,
-	.sync_dirty_debug_regs = svm_sync_dirty_debug_regs,
-	.cache_reg = svm_cache_reg,
-	.get_rflags = svm_get_rflags,
-	.set_rflags = svm_set_rflags,
-
-	.tlb_flush = svm_flush_tlb,
-	.tlb_flush_gva = svm_flush_tlb_gva,
-
-	.run = svm_vcpu_run,
-	.handle_exit = handle_exit,
-	.skip_emulated_instruction = skip_emulated_instruction,
-	.set_interrupt_shadow = svm_set_interrupt_shadow,
-	.get_interrupt_shadow = svm_get_interrupt_shadow,
-	.patch_hypercall = svm_patch_hypercall,
-	.set_irq = svm_set_irq,
-	.set_nmi = svm_inject_nmi,
-	.queue_exception = svm_queue_exception,
-	.cancel_injection = svm_cancel_injection,
-	.interrupt_allowed = svm_interrupt_allowed,
-	.nmi_allowed = svm_nmi_allowed,
-	.get_nmi_mask = svm_get_nmi_mask,
-	.set_nmi_mask = svm_set_nmi_mask,
-	.enable_nmi_window = enable_nmi_window,
-	.enable_irq_window = enable_irq_window,
-	.update_cr8_intercept = update_cr8_intercept,
-	.set_virtual_apic_mode = svm_set_virtual_apic_mode,
-	.get_enable_apicv = svm_get_enable_apicv,
-	.refresh_apicv_exec_ctrl = svm_refresh_apicv_exec_ctrl,
-	.load_eoi_exitmap = svm_load_eoi_exitmap,
-	.hwapic_irr_update = svm_hwapic_irr_update,
-	.hwapic_isr_update = svm_hwapic_isr_update,
-	.sync_pir_to_irr = kvm_lapic_find_highest_irr,
-	.apicv_post_state_restore = avic_post_state_restore,
-
-	.set_tss_addr = svm_set_tss_addr,
-	.set_identity_map_addr = svm_set_identity_map_addr,
-	.get_tdp_level = get_npt_level,
-	.get_mt_mask = svm_get_mt_mask,
-
-	.get_exit_info = svm_get_exit_info,
-
-	.get_lpage_level = svm_get_lpage_level,
-
-	.cpuid_update = svm_cpuid_update,
-
-	.rdtscp_supported = svm_rdtscp_supported,
-	.invpcid_supported = svm_invpcid_supported,
-	.mpx_supported = svm_mpx_supported,
-	.xsaves_supported = svm_xsaves_supported,
-	.umip_emulated = svm_umip_emulated,
-	.pt_supported = svm_pt_supported,
-
-	.set_supported_cpuid = svm_set_supported_cpuid,
-
-	.has_wbinvd_exit = svm_has_wbinvd_exit,
-
-	.read_l1_tsc_offset = svm_read_l1_tsc_offset,
-	.write_l1_tsc_offset = svm_write_l1_tsc_offset,
-
-	.set_tdp_cr3 = set_tdp_cr3,
-
-	.check_intercept = svm_check_intercept,
-	.handle_exit_irqoff = svm_handle_exit_irqoff,
-
-	.request_immediate_exit = __kvm_request_immediate_exit,
-
-	.sched_in = svm_sched_in,
+	.cpu_has_kvm_support = kvm_x86_cpu_has_kvm_support,
+	.disabled_by_bios = kvm_x86_disabled_by_bios,
+	.hardware_setup = kvm_x86_hardware_setup,
+	.hardware_unsetup = kvm_x86_hardware_unsetup,
+	.check_processor_compatibility = kvm_x86_check_processor_compatibility,
+	.hardware_enable = kvm_x86_hardware_enable,
+	.hardware_disable = kvm_x86_hardware_disable,
+	.cpu_has_accelerated_tpr = kvm_x86_cpu_has_accelerated_tpr,
+	.has_emulated_msr = kvm_x86_has_emulated_msr,
+
+	.vcpu_create = kvm_x86_vcpu_create,
+	.vcpu_free = kvm_x86_vcpu_free,
+	.vcpu_reset = kvm_x86_vcpu_reset,
+
+	.vm_alloc = kvm_x86_vm_alloc,
+	.vm_free = kvm_x86_vm_free,
+	.vm_init = kvm_x86_vm_init,
+	.vm_destroy = kvm_x86_vm_destroy,
+
+	.prepare_guest_switch = kvm_x86_prepare_guest_switch,
+	.vcpu_load = kvm_x86_vcpu_load,
+	.vcpu_put = kvm_x86_vcpu_put,
+	.vcpu_blocking = kvm_x86_vcpu_blocking,
+	.vcpu_unblocking = kvm_x86_vcpu_unblocking,
+
+	.update_bp_intercept = kvm_x86_update_bp_intercept,
+	.get_msr_feature = kvm_x86_get_msr_feature,
+	.get_msr = kvm_x86_get_msr,
+	.set_msr = kvm_x86_set_msr,
+	.get_segment_base = kvm_x86_get_segment_base,
+	.get_segment = kvm_x86_get_segment,
+	.set_segment = kvm_x86_set_segment,
+	.get_cpl = kvm_x86_get_cpl,
+	.get_cs_db_l_bits = kvm_x86_get_cs_db_l_bits,
+	.decache_cr0_guest_bits = kvm_x86_decache_cr0_guest_bits,
+	.decache_cr3 = kvm_x86_decache_cr3,
+	.decache_cr4_guest_bits = kvm_x86_decache_cr4_guest_bits,
+	.set_cr0 = kvm_x86_set_cr0,
+	.set_cr3 = kvm_x86_set_cr3,
+	.set_cr4 = kvm_x86_set_cr4,
+	.set_efer = kvm_x86_set_efer,
+	.get_idt = kvm_x86_get_idt,
+	.set_idt = kvm_x86_set_idt,
+	.get_gdt = kvm_x86_get_gdt,
+	.set_gdt = kvm_x86_set_gdt,
+	.get_dr6 = kvm_x86_get_dr6,
+	.set_dr6 = kvm_x86_set_dr6,
+	.set_dr7 = kvm_x86_set_dr7,
+	.sync_dirty_debug_regs = kvm_x86_sync_dirty_debug_regs,
+	.cache_reg = kvm_x86_cache_reg,
+	.get_rflags = kvm_x86_get_rflags,
+	.set_rflags = kvm_x86_set_rflags,
+
+	.tlb_flush = kvm_x86_tlb_flush,
+	.tlb_flush_gva = kvm_x86_tlb_flush_gva,
+
+	.run = kvm_x86_run,
+	.handle_exit = kvm_x86_handle_exit,
+	.skip_emulated_instruction = kvm_x86_skip_emulated_instruction,
+	.set_interrupt_shadow = kvm_x86_set_interrupt_shadow,
+	.get_interrupt_shadow = kvm_x86_get_interrupt_shadow,
+	.patch_hypercall = kvm_x86_patch_hypercall,
+	.set_irq = kvm_x86_set_irq,
+	.set_nmi = kvm_x86_set_nmi,
+	.queue_exception = kvm_x86_queue_exception,
+	.cancel_injection = kvm_x86_cancel_injection,
+	.interrupt_allowed = kvm_x86_interrupt_allowed,
+	.nmi_allowed = kvm_x86_nmi_allowed,
+	.get_nmi_mask = kvm_x86_get_nmi_mask,
+	.set_nmi_mask = kvm_x86_set_nmi_mask,
+	.enable_nmi_window = kvm_x86_enable_nmi_window,
+	.enable_irq_window = kvm_x86_enable_irq_window,
+	.update_cr8_intercept = kvm_x86_update_cr8_intercept,
+	.set_virtual_apic_mode = kvm_x86_set_virtual_apic_mode,
+	.get_enable_apicv = kvm_x86_get_enable_apicv,
+	.refresh_apicv_exec_ctrl = kvm_x86_refresh_apicv_exec_ctrl,
+	.load_eoi_exitmap = kvm_x86_load_eoi_exitmap,
+	.hwapic_irr_update = kvm_x86_hwapic_irr_update,
+	.hwapic_isr_update = kvm_x86_hwapic_isr_update,
+	.sync_pir_to_irr = kvm_x86_sync_pir_to_irr,
+	.apicv_post_state_restore = kvm_x86_apicv_post_state_restore,
+
+	.set_tss_addr = kvm_x86_set_tss_addr,
+	.set_identity_map_addr = kvm_x86_set_identity_map_addr,
+	.get_tdp_level = kvm_x86_get_tdp_level,
+	.get_mt_mask = kvm_x86_get_mt_mask,
+
+	.get_exit_info = kvm_x86_get_exit_info,
+
+	.get_lpage_level = kvm_x86_get_lpage_level,
+
+	.cpuid_update = kvm_x86_cpuid_update,
+
+	.rdtscp_supported = kvm_x86_rdtscp_supported,
+	.invpcid_supported = kvm_x86_invpcid_supported,
+	.mpx_supported = kvm_x86_mpx_supported,
+	.xsaves_supported = kvm_x86_xsaves_supported,
+	.umip_emulated = kvm_x86_umip_emulated,
+	.pt_supported = kvm_x86_pt_supported,
+
+	.set_supported_cpuid = kvm_x86_set_supported_cpuid,
+
+	.has_wbinvd_exit = kvm_x86_has_wbinvd_exit,
+
+	.read_l1_tsc_offset = kvm_x86_read_l1_tsc_offset,
+	.write_l1_tsc_offset = kvm_x86_write_l1_tsc_offset,
+
+	.set_tdp_cr3 = kvm_x86_set_tdp_cr3,
+
+	.check_intercept = kvm_x86_check_intercept,
+	.handle_exit_irqoff = kvm_x86_handle_exit_irqoff,
+
+	.request_immediate_exit = kvm_x86_request_immediate_exit,
+
+	.sched_in = kvm_x86_sched_in,
 
 	.pmu_ops = &amd_pmu_ops,
-	.deliver_posted_interrupt = svm_deliver_avic_intr,
-	.dy_apicv_has_pending_interrupt = svm_dy_apicv_has_pending_interrupt,
-	.update_pi_irte = svm_update_pi_irte,
-	.setup_mce = svm_setup_mce,
+	.deliver_posted_interrupt = kvm_x86_deliver_posted_interrupt,
+	.dy_apicv_has_pending_interrupt = kvm_x86_dy_apicv_has_pending_interrupt,
+	.update_pi_irte = kvm_x86_update_pi_irte,
+	.setup_mce = kvm_x86_setup_mce,
 
-	.smi_allowed = svm_smi_allowed,
-	.pre_enter_smm = svm_pre_enter_smm,
-	.pre_leave_smm = svm_pre_leave_smm,
-	.enable_smi_window = enable_smi_window,
+	.smi_allowed = kvm_x86_smi_allowed,
+	.pre_enter_smm = kvm_x86_pre_enter_smm,
+	.pre_leave_smm = kvm_x86_pre_leave_smm,
+	.enable_smi_window = kvm_x86_enable_smi_window,
 
-	.mem_enc_op = svm_mem_enc_op,
-	.mem_enc_reg_region = svm_register_enc_region,
-	.mem_enc_unreg_region = svm_unregister_enc_region,
+	.mem_enc_op = kvm_x86_mem_enc_op,
+	.mem_enc_reg_region = kvm_x86_mem_enc_reg_region,
+	.mem_enc_unreg_region = kvm_x86_mem_enc_unreg_region,
 
-	.nested_enable_evmcs = nested_enable_evmcs,
+	.nested_enable_evmcs = kvm_x86_nested_enable_evmcs,
 	.nested_get_evmcs_version = NULL,
 
-	.need_emulation_on_page_fault = svm_need_emulation_on_page_fault,
+	.need_emulation_on_page_fault = kvm_x86_need_emulation_on_page_fault,
 
-	.apic_init_signal_blocked = svm_apic_init_signal_blocked,
+	.apic_init_signal_blocked = kvm_x86_apic_init_signal_blocked,
 };
 
 static int __init svm_init(void)
@@ -7332,3 +7341,105 @@ static void __exit svm_exit(void)
 
 module_init(svm_init)
 module_exit(svm_exit)
+
+int kvm_x86_tlb_remote_flush(struct kvm *kvm)
+{
+	return kvm_x86_ops->tlb_remote_flush(kvm);
+}
+
+int kvm_x86_tlb_remote_flush_with_range(struct kvm *kvm,
+					struct kvm_tlb_range *range)
+{
+	return kvm_x86_ops->tlb_remote_flush_with_range(kvm, range);
+}
+
+bool kvm_x86_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
+{
+	return kvm_x86_ops->guest_apic_has_interrupt(vcpu);
+}
+
+void kvm_x86_set_apic_access_page_addr(struct kvm_vcpu *vcpu, hpa_t hpa)
+{
+	kvm_x86_ops->set_apic_access_page_addr(vcpu, hpa);
+}
+
+int kvm_x86_check_nested_events(struct kvm_vcpu *vcpu, bool external_intr)
+{
+	return kvm_x86_ops->check_nested_events(vcpu, external_intr);
+}
+
+void kvm_x86_slot_enable_log_dirty(struct kvm *kvm,
+				   struct kvm_memory_slot *slot)
+{
+	kvm_x86_ops->slot_enable_log_dirty(kvm, slot);
+}
+
+void kvm_x86_slot_disable_log_dirty(struct kvm *kvm,
+				    struct kvm_memory_slot *slot)
+{
+	kvm_x86_ops->slot_disable_log_dirty(kvm, slot);
+}
+
+void kvm_x86_flush_log_dirty(struct kvm *kvm)
+{
+	kvm_x86_ops->flush_log_dirty(kvm);
+}
+
+void kvm_x86_enable_log_dirty_pt_masked(struct kvm *kvm,
+					struct kvm_memory_slot *slot,
+					gfn_t offset, unsigned long mask)
+{
+	kvm_x86_ops->enable_log_dirty_pt_masked(kvm, slot, offset, mask);
+}
+
+int kvm_x86_write_log_dirty(struct kvm_vcpu *vcpu)
+{
+	return kvm_x86_ops->write_log_dirty(vcpu);
+}
+
+int kvm_x86_pre_block(struct kvm_vcpu *vcpu)
+{
+	return kvm_x86_ops->pre_block(vcpu);
+}
+
+void kvm_x86_post_block(struct kvm_vcpu *vcpu)
+{
+	kvm_x86_ops->post_block(vcpu);
+}
+
+int kvm_x86_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
+			 bool *expired)
+{
+	return kvm_x86_ops->set_hv_timer(vcpu, guest_deadline_tsc, expired);
+}
+
+void kvm_x86_cancel_hv_timer(struct kvm_vcpu *vcpu)
+{
+	kvm_x86_ops->cancel_hv_timer(vcpu);
+}
+
+int kvm_x86_get_nested_state(struct kvm_vcpu *vcpu,
+			     struct kvm_nested_state __user *user_kvm_nested_state,
+			     unsigned user_data_size)
+{
+	return kvm_x86_ops->get_nested_state(vcpu, user_kvm_nested_state,
+					     user_data_size);
+}
+
+int kvm_x86_set_nested_state(struct kvm_vcpu *vcpu,
+			     struct kvm_nested_state __user *user_kvm_nested_state,
+			     struct kvm_nested_state *kvm_state)
+{
+	return kvm_x86_ops->set_nested_state(vcpu, user_kvm_nested_state,
+					     kvm_state);
+}
+
+void kvm_x86_get_vmcs12_pages(struct kvm_vcpu *vcpu)
+{
+	kvm_x86_ops->get_vmcs12_pages(vcpu);
+}
+
+uint16_t kvm_x86_nested_get_evmcs_version(struct kvm_vcpu *vcpu)
+{
+	return kvm_x86_ops->nested_get_evmcs_version(vcpu);
+}
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 7c741a0c5f80..c52bfb96ce40 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -240,7 +240,7 @@ TRACE_EVENT(kvm_exit,
 		__entry->guest_rip	= kvm_rip_read(vcpu);
 		__entry->isa            = isa;
 		__entry->vcpu_id        = vcpu->vcpu_id;
-		kvm_x86_ops->get_exit_info(vcpu, &__entry->info1,
+		kvm_x86_get_exit_info(vcpu, &__entry->info1,
 					   &__entry->info2);
 	),
 
@@ -744,7 +744,7 @@ TRACE_EVENT(kvm_emulate_insn,
 		),
 
 	TP_fast_assign(
-		__entry->csbase = kvm_x86_ops->get_segment_base(vcpu, VCPU_SREG_CS);
+		__entry->csbase = kvm_x86_get_segment_base(vcpu, VCPU_SREG_CS);
 		__entry->len = vcpu->arch.emulate_ctxt.fetch.ptr
 			       - vcpu->arch.emulate_ctxt.fetch.data;
 		__entry->rip = vcpu->arch.emulate_ctxt._eip - __entry->len;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1a10cd351940..3877362fe810 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -152,7 +152,7 @@ static void init_vmcs_shadow_fields(void)
  */
 static int nested_vmx_succeed(struct kvm_vcpu *vcpu)
 {
-	vmx_set_rflags(vcpu, vmx_get_rflags(vcpu)
+	kvm_x86_set_rflags(vcpu, kvm_x86_get_rflags(vcpu)
 			& ~(X86_EFLAGS_CF | X86_EFLAGS_PF | X86_EFLAGS_AF |
 			    X86_EFLAGS_ZF | X86_EFLAGS_SF | X86_EFLAGS_OF));
 	return kvm_skip_emulated_instruction(vcpu);
@@ -160,7 +160,7 @@ static int nested_vmx_succeed(struct kvm_vcpu *vcpu)
 
 static int nested_vmx_failInvalid(struct kvm_vcpu *vcpu)
 {
-	vmx_set_rflags(vcpu, (vmx_get_rflags(vcpu)
+	kvm_x86_set_rflags(vcpu, (kvm_x86_get_rflags(vcpu)
 			& ~(X86_EFLAGS_PF | X86_EFLAGS_AF | X86_EFLAGS_ZF |
 			    X86_EFLAGS_SF | X86_EFLAGS_OF))
 			| X86_EFLAGS_CF);
@@ -179,7 +179,7 @@ static int nested_vmx_failValid(struct kvm_vcpu *vcpu,
 	if (vmx->nested.current_vmptr == -1ull && !vmx->nested.hv_evmcs)
 		return nested_vmx_failInvalid(vcpu);
 
-	vmx_set_rflags(vcpu, (vmx_get_rflags(vcpu)
+	kvm_x86_set_rflags(vcpu, (kvm_x86_get_rflags(vcpu)
 			& ~(X86_EFLAGS_CF | X86_EFLAGS_PF | X86_EFLAGS_AF |
 			    X86_EFLAGS_SF | X86_EFLAGS_OF))
 			| X86_EFLAGS_ZF);
@@ -343,7 +343,7 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 			VMX_EPT_EXECUTE_ONLY_BIT,
 			nested_ept_ad_enabled(vcpu),
 			nested_ept_get_cr3(vcpu));
-	vcpu->arch.mmu->set_cr3           = vmx_set_cr3;
+	vcpu->arch.mmu->set_cr3           = kvm_x86_set_cr3;
 	vcpu->arch.mmu->get_cr3           = nested_ept_get_cr3;
 	vcpu->arch.mmu->inject_page_fault = nested_ept_inject_page_fault;
 	vcpu->arch.mmu->get_pdptr         = kvm_pdptr_read;
@@ -2103,10 +2103,10 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 		exec_control &= ~SECONDARY_EXEC_SHADOW_VMCS;
 
 		/*
-		 * Preset *DT exiting when emulating UMIP, so that vmx_set_cr4()
+		 * Preset *DT exiting when emulating UMIP, so that kvm_x86_set_cr4()
 		 * will not have to rewrite the controls just for this bit.
 		 */
-		if (!boot_cpu_has(X86_FEATURE_UMIP) && vmx_umip_emulated() &&
+		if (!boot_cpu_has(X86_FEATURE_UMIP) && kvm_x86_umip_emulated() &&
 		    (vmcs12->guest_cr4 & X86_CR4_UMIP))
 			exec_control |= SECONDARY_EXEC_DESC;
 
@@ -2121,9 +2121,9 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 	 * ENTRY CONTROLS
 	 *
 	 * vmcs12's VM_{ENTRY,EXIT}_LOAD_IA32_EFER and VM_ENTRY_IA32E_MODE
-	 * are emulated by vmx_set_efer() in prepare_vmcs02(), but speculate
+	 * are emulated by kvm_x86_set_efer() in prepare_vmcs02(), but speculate
 	 * on the related bits (if supported by the CPU) in the hope that
-	 * we can avoid VMWrites during vmx_set_efer().
+	 * we can avoid VMWrites during kvm_x86_set_efer().
 	 */
 	exec_control = (vmcs12->vm_entry_controls | vmx_vmentry_ctrl()) &
 			~VM_ENTRY_IA32E_MODE & ~VM_ENTRY_LOAD_IA32_EFER;
@@ -2140,7 +2140,7 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 	 *
 	 * L2->L1 exit controls are emulated - the hardware exit is to L0 so
 	 * we should use its exit controls. Note that VM_EXIT_LOAD_IA32_EFER
-	 * bits may be modified by vmx_set_efer() in prepare_vmcs02().
+	 * bits may be modified by kvm_x86_set_efer() in prepare_vmcs02().
 	 */
 	exec_control = vmx_vmexit_ctrl();
 	if (cpu_has_load_ia32_efer() && guest_efer != host_efer)
@@ -2307,13 +2307,13 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	if (kvm_mpx_supported() && (!vmx->nested.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
 		vmcs_write64(GUEST_BNDCFGS, vmx->nested.vmcs01_guest_bndcfgs);
-	vmx_set_rflags(vcpu, vmcs12->guest_rflags);
+	kvm_x86_set_rflags(vcpu, vmcs12->guest_rflags);
 
 	/* EXCEPTION_BITMAP and CR0_GUEST_HOST_MASK should basically be the
 	 * bitwise-or of what L1 wants to trap for L2, and what we want to
 	 * trap. Note that CR0.TS also needs updating - we do this later.
 	 */
-	update_exception_bitmap(vcpu);
+	kvm_x86_update_bp_intercept(vcpu);
 	vcpu->arch.cr0_guest_owned_bits &= ~vmcs12->cr0_guest_host_mask;
 	vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.cr0_guest_owned_bits);
 
@@ -2361,7 +2361,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 		nested_ept_init_mmu_context(vcpu);
 	else if (nested_cpu_has2(vmcs12,
 				 SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES))
-		vmx_flush_tlb(vcpu, true);
+		kvm_x86_tlb_flush(vcpu, true);
 
 	/*
 	 * This sets GUEST_CR0 to vmcs12->guest_cr0, possibly modifying those
@@ -2371,15 +2371,15 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	 * vmcs12->cr0_read_shadow because on our cr0_guest_host_mask we we
 	 * have more bits than L1 expected.
 	 */
-	vmx_set_cr0(vcpu, vmcs12->guest_cr0);
+	kvm_x86_set_cr0(vcpu, vmcs12->guest_cr0);
 	vmcs_writel(CR0_READ_SHADOW, nested_read_cr0(vmcs12));
 
-	vmx_set_cr4(vcpu, vmcs12->guest_cr4);
+	kvm_x86_set_cr4(vcpu, vmcs12->guest_cr4);
 	vmcs_writel(CR4_READ_SHADOW, nested_read_cr4(vmcs12));
 
 	vcpu->arch.efer = nested_vmx_calc_efer(vmx, vmcs12);
 	/* Note: may modify VM_ENTRY/EXIT_CONTROLS and GUEST/HOST_IA32_EFER */
-	vmx_set_efer(vcpu, vcpu->arch.efer);
+	kvm_x86_set_efer(vcpu, vcpu->arch.efer);
 
 	/*
 	 * Guest state is invalid and unrestricted guest is disabled,
@@ -2787,7 +2787,7 @@ static int nested_vmx_check_vmentry_hw(struct kvm_vcpu *vcpu)
 
 	preempt_disable();
 
-	vmx_prepare_switch_to_guest(vcpu);
+	kvm_x86_prepare_guest_switch(vcpu);
 
 	/*
 	 * Induce a consistency check VMExit by clearing bit 1 in GUEST_RFLAGS,
@@ -2972,7 +2972,7 @@ static int nested_vmx_check_permission(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
-	if (vmx_get_cpl(vcpu)) {
+	if (kvm_x86_get_cpl(vcpu)) {
 		kvm_inject_gp(vcpu, 0);
 		return 0;
 	}
@@ -3145,7 +3145,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 {
 	struct vmcs12 *vmcs12;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	u32 interrupt_shadow = vmx_get_interrupt_shadow(vcpu);
+	u32 interrupt_shadow = kvm_x86_get_interrupt_shadow(vcpu);
 	int ret;
 
 	if (!nested_vmx_check_permission(vcpu))
@@ -3397,7 +3397,7 @@ static void nested_vmx_inject_exception_vmexit(struct kvm_vcpu *vcpu,
 		intr_info |= INTR_TYPE_HARD_EXCEPTION;
 
 	if (!(vmcs12->idt_vectoring_info_field & VECTORING_INFO_VALID_MASK) &&
-	    vmx_get_nmi_mask(vcpu))
+	    kvm_x86_get_nmi_mask(vcpu))
 		intr_info |= INTR_INFO_UNBLOCK_NMI;
 
 	nested_vmx_vmexit(vcpu, EXIT_REASON_EXCEPTION_NMI, intr_info, exit_qual);
@@ -3446,7 +3446,7 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu, bool external_intr)
 		 * clear this one and block further NMIs.
 		 */
 		vcpu->arch.nmi_pending = 0;
-		vmx_set_nmi_mask(vcpu, true);
+		kvm_x86_set_nmi_mask(vcpu, true);
 		return 0;
 	}
 
@@ -3584,12 +3584,12 @@ static void copy_vmcs02_to_vmcs12_rare(struct kvm_vcpu *vcpu,
 
 	cpu = get_cpu();
 	vmx->loaded_vmcs = &vmx->nested.vmcs02;
-	vmx_vcpu_load(&vmx->vcpu, cpu);
+	kvm_x86_vcpu_load(&vmx->vcpu, cpu);
 
 	sync_vmcs02_to_vmcs12_rare(vcpu, vmcs12);
 
 	vmx->loaded_vmcs = &vmx->vmcs01;
-	vmx_vcpu_load(&vmx->vcpu, cpu);
+	kvm_x86_vcpu_load(&vmx->vcpu, cpu);
 	put_cpu();
 }
 
@@ -3749,12 +3749,12 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 		vcpu->arch.efer |= (EFER_LMA | EFER_LME);
 	else
 		vcpu->arch.efer &= ~(EFER_LMA | EFER_LME);
-	vmx_set_efer(vcpu, vcpu->arch.efer);
+	kvm_x86_set_efer(vcpu, vcpu->arch.efer);
 
 	kvm_rsp_write(vcpu, vmcs12->host_rsp);
 	kvm_rip_write(vcpu, vmcs12->host_rip);
-	vmx_set_rflags(vcpu, X86_EFLAGS_FIXED);
-	vmx_set_interrupt_shadow(vcpu, 0);
+	kvm_x86_set_rflags(vcpu, X86_EFLAGS_FIXED);
+	kvm_x86_set_interrupt_shadow(vcpu, 0);
 
 	/*
 	 * Note that calling vmx_set_cr0 is important, even if cr0 hasn't
@@ -3764,11 +3764,11 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 	 * (KVM doesn't change it);
 	 */
 	vcpu->arch.cr0_guest_owned_bits = X86_CR0_TS;
-	vmx_set_cr0(vcpu, vmcs12->host_cr0);
+	kvm_x86_set_cr0(vcpu, vmcs12->host_cr0);
 
 	/* Same as above - no reason to call set_cr4_guest_host_mask().  */
 	vcpu->arch.cr4_guest_owned_bits = ~vmcs_readl(CR4_GUEST_HOST_MASK);
-	vmx_set_cr4(vcpu, vmcs12->host_cr4);
+	kvm_x86_set_cr4(vcpu, vmcs12->host_cr4);
 
 	nested_ept_uninit_mmu_context(vcpu);
 
@@ -3836,7 +3836,7 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 		seg.l = 1;
 	else
 		seg.db = 1;
-	vmx_set_segment(vcpu, &seg, VCPU_SREG_CS);
+	kvm_x86_set_segment(vcpu, &seg, VCPU_SREG_CS);
 	seg = (struct kvm_segment) {
 		.base = 0,
 		.limit = 0xFFFFFFFF,
@@ -3847,17 +3847,17 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 		.g = 1
 	};
 	seg.selector = vmcs12->host_ds_selector;
-	vmx_set_segment(vcpu, &seg, VCPU_SREG_DS);
+	kvm_x86_set_segment(vcpu, &seg, VCPU_SREG_DS);
 	seg.selector = vmcs12->host_es_selector;
-	vmx_set_segment(vcpu, &seg, VCPU_SREG_ES);
+	kvm_x86_set_segment(vcpu, &seg, VCPU_SREG_ES);
 	seg.selector = vmcs12->host_ss_selector;
-	vmx_set_segment(vcpu, &seg, VCPU_SREG_SS);
+	kvm_x86_set_segment(vcpu, &seg, VCPU_SREG_SS);
 	seg.selector = vmcs12->host_fs_selector;
 	seg.base = vmcs12->host_fs_base;
-	vmx_set_segment(vcpu, &seg, VCPU_SREG_FS);
+	kvm_x86_set_segment(vcpu, &seg, VCPU_SREG_FS);
 	seg.selector = vmcs12->host_gs_selector;
 	seg.base = vmcs12->host_gs_base;
-	vmx_set_segment(vcpu, &seg, VCPU_SREG_GS);
+	kvm_x86_set_segment(vcpu, &seg, VCPU_SREG_GS);
 	seg = (struct kvm_segment) {
 		.base = vmcs12->host_tr_base,
 		.limit = 0x67,
@@ -3865,7 +3865,7 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 		.type = 11,
 		.present = 1
 	};
-	vmx_set_segment(vcpu, &seg, VCPU_SREG_TR);
+	kvm_x86_set_segment(vcpu, &seg, VCPU_SREG_TR);
 
 	kvm_set_dr(vcpu, 7, 0x400);
 	vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
@@ -3928,13 +3928,13 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
 	 * Note that calling vmx_set_{efer,cr0,cr4} is important as they
 	 * handle a variety of side effects to KVM's software model.
 	 */
-	vmx_set_efer(vcpu, nested_vmx_get_vmcs01_guest_efer(vmx));
+	kvm_x86_set_efer(vcpu, nested_vmx_get_vmcs01_guest_efer(vmx));
 
 	vcpu->arch.cr0_guest_owned_bits = X86_CR0_TS;
-	vmx_set_cr0(vcpu, vmcs_readl(CR0_READ_SHADOW));
+	kvm_x86_set_cr0(vcpu, vmcs_readl(CR0_READ_SHADOW));
 
 	vcpu->arch.cr4_guest_owned_bits = ~vmcs_readl(CR4_GUEST_HOST_MASK);
-	vmx_set_cr4(vcpu, vmcs_readl(CR4_READ_SHADOW));
+	kvm_x86_set_cr4(vcpu, vmcs_readl(CR4_READ_SHADOW));
 
 	nested_ept_uninit_mmu_context(vcpu);
 	vcpu->arch.cr3 = vmcs_readl(GUEST_CR3);
@@ -4072,11 +4072,11 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 
 	if (vmx->nested.change_vmcs01_virtual_apic_mode) {
 		vmx->nested.change_vmcs01_virtual_apic_mode = false;
-		vmx_set_virtual_apic_mode(vcpu);
+		kvm_x86_set_virtual_apic_mode(vcpu);
 	} else if (!nested_cpu_has_ept(vmcs12) &&
 		   nested_cpu_has2(vmcs12,
 				   SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
-		vmx_flush_tlb(vcpu, true);
+		kvm_x86_tlb_flush(vcpu, true);
 	}
 
 	/* Unpin physical memory we referred to in vmcs02 */
@@ -4197,7 +4197,7 @@ int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
 		off += kvm_register_read(vcpu, base_reg);
 	if (index_is_valid)
 		off += kvm_register_read(vcpu, index_reg)<<scaling;
-	vmx_get_segment(vcpu, &s, seg_reg);
+	kvm_x86_get_segment(vcpu, &s, seg_reg);
 
 	/*
 	 * The effective address, i.e. @off, of a memory operand is truncated
@@ -4394,7 +4394,7 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 	/*
 	 * The Intel VMX Instruction Reference lists a bunch of bits that are
 	 * prerequisite to running VMXON, most notably cr4.VMXE must be set to
-	 * 1 (see vmx_set_cr4() for when we allow the guest to set this).
+	 * 1 (see kvm_x86_set_cr4() for when we allow the guest to set this).
 	 * Otherwise, we should fail with #UD.  But most faulting conditions
 	 * have already been checked by hardware, prior to the VM-exit for
 	 * VMXON.  We do test guest cr4.VMXE because processor CR4 always has
@@ -4406,7 +4406,7 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 	}
 
 	/* CPL=0 must be checked manually. */
-	if (vmx_get_cpl(vcpu)) {
+	if (kvm_x86_get_cpl(vcpu)) {
 		kvm_inject_gp(vcpu, 0);
 		return 1;
 	}
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 4dea0e0e7e39..758d6dbdbed2 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -64,9 +64,8 @@ static void global_ctrl_changed(struct kvm_pmu *pmu, u64 data)
 		reprogram_counter(pmu, bit);
 }
 
-static unsigned intel_find_arch_event(struct kvm_pmu *pmu,
-				      u8 event_select,
-				      u8 unit_mask)
+unsigned kvm_x86_pmu_find_arch_event(struct kvm_pmu *pmu, u8 event_select,
+				     u8 unit_mask)
 {
 	int i;
 
@@ -82,7 +81,7 @@ static unsigned intel_find_arch_event(struct kvm_pmu *pmu,
 	return intel_arch_events[i].event_type;
 }
 
-static unsigned intel_find_fixed_event(int idx)
+unsigned kvm_x86_pmu_find_fixed_event(int idx)
 {
 	if (idx >= ARRAY_SIZE(fixed_pmc_events))
 		return PERF_COUNT_HW_MAX;
@@ -91,14 +90,14 @@ static unsigned intel_find_fixed_event(int idx)
 }
 
 /* check if a PMC is enabled by comparing it with globl_ctrl bits. */
-static bool intel_pmc_is_enabled(struct kvm_pmc *pmc)
+bool kvm_x86_pmu_pmc_is_enabled(struct kvm_pmc *pmc)
 {
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
 
 	return test_bit(pmc->idx, (unsigned long *)&pmu->global_ctrl);
 }
 
-static struct kvm_pmc *intel_pmc_idx_to_pmc(struct kvm_pmu *pmu, int pmc_idx)
+struct kvm_pmc *kvm_x86_pmu_pmc_idx_to_pmc(struct kvm_pmu *pmu, int pmc_idx)
 {
 	if (pmc_idx < INTEL_PMC_IDX_FIXED)
 		return get_gp_pmc(pmu, MSR_P6_EVNTSEL0 + pmc_idx,
@@ -111,7 +110,7 @@ static struct kvm_pmc *intel_pmc_idx_to_pmc(struct kvm_pmu *pmu, int pmc_idx)
 }
 
 /* returns 0 if idx's corresponding MSR exists; otherwise returns 1. */
-static int intel_is_valid_msr_idx(struct kvm_vcpu *vcpu, unsigned idx)
+int kvm_x86_pmu_is_valid_msr_idx(struct kvm_vcpu *vcpu, unsigned idx)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	bool fixed = idx & (1u << 30);
@@ -122,8 +121,8 @@ static int intel_is_valid_msr_idx(struct kvm_vcpu *vcpu, unsigned idx)
 		(fixed && idx >= pmu->nr_arch_fixed_counters);
 }
 
-static struct kvm_pmc *intel_msr_idx_to_pmc(struct kvm_vcpu *vcpu,
-					    unsigned idx, u64 *mask)
+struct kvm_pmc *kvm_x86_pmu_msr_idx_to_pmc(struct kvm_vcpu *vcpu, unsigned idx,
+					   u64 *mask)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	bool fixed = idx & (1u << 30);
@@ -140,7 +139,7 @@ static struct kvm_pmc *intel_msr_idx_to_pmc(struct kvm_vcpu *vcpu,
 	return &counters[idx];
 }
 
-static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
+bool kvm_x86_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	int ret;
@@ -162,7 +161,7 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	return ret;
 }
 
-static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
+int kvm_x86_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
@@ -198,7 +197,7 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 	return 1;
 }
 
-static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+int kvm_x86_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
@@ -259,7 +258,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 1;
 }
 
-static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
+void kvm_x86_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_cpuid_entry2 *entry;
@@ -305,7 +304,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->global_ovf_ctrl_mask = pmu->global_ctrl_mask
 			& ~(MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF |
 			    MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD);
-	if (kvm_x86_ops->pt_supported())
+	if (kvm_x86_pt_supported())
 		pmu->global_ovf_ctrl_mask &=
 				~MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI;
 
@@ -316,7 +315,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 		pmu->reserved_bits ^= HSW_IN_TX|HSW_IN_TX_CHECKPOINTED;
 }
 
-static void intel_pmu_init(struct kvm_vcpu *vcpu)
+void kvm_x86_pmu_init(struct kvm_vcpu *vcpu)
 {
 	int i;
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -334,7 +333,7 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void intel_pmu_reset(struct kvm_vcpu *vcpu)
+void kvm_x86_pmu_reset(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc = NULL;
@@ -359,16 +358,16 @@ static void intel_pmu_reset(struct kvm_vcpu *vcpu)
 }
 
 struct kvm_pmu_ops intel_pmu_ops = {
-	.find_arch_event = intel_find_arch_event,
-	.find_fixed_event = intel_find_fixed_event,
-	.pmc_is_enabled = intel_pmc_is_enabled,
-	.pmc_idx_to_pmc = intel_pmc_idx_to_pmc,
-	.msr_idx_to_pmc = intel_msr_idx_to_pmc,
-	.is_valid_msr_idx = intel_is_valid_msr_idx,
-	.is_valid_msr = intel_is_valid_msr,
-	.get_msr = intel_pmu_get_msr,
-	.set_msr = intel_pmu_set_msr,
-	.refresh = intel_pmu_refresh,
-	.init = intel_pmu_init,
-	.reset = intel_pmu_reset,
+	.find_arch_event = kvm_x86_pmu_find_arch_event,
+	.find_fixed_event = kvm_x86_pmu_find_fixed_event,
+	.pmc_is_enabled = kvm_x86_pmu_pmc_is_enabled,
+	.pmc_idx_to_pmc = kvm_x86_pmu_pmc_idx_to_pmc,
+	.msr_idx_to_pmc = kvm_x86_pmu_msr_idx_to_pmc,
+	.is_valid_msr_idx = kvm_x86_pmu_is_valid_msr_idx,
+	.is_valid_msr = kvm_x86_pmu_is_valid_msr,
+	.get_msr = kvm_x86_pmu_get_msr,
+	.set_msr = kvm_x86_pmu_set_msr,
+	.refresh = kvm_x86_pmu_refresh,
+	.init = kvm_x86_pmu_init,
+	.reset = kvm_x86_pmu_reset,
 };
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4a99be1fae4e..bb122ab4b96c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -541,7 +541,7 @@ static inline bool cpu_need_virtualize_apic_accesses(struct kvm_vcpu *vcpu)
 	return flexpriority_enabled && lapic_in_kernel(vcpu);
 }
 
-static inline bool report_flexpriority(void)
+bool kvm_x86_cpu_has_accelerated_tpr(void)
 {
 	return flexpriority_enabled;
 }
@@ -699,7 +699,7 @@ static u32 vmx_read_guest_seg_ar(struct vcpu_vmx *vmx, unsigned seg)
 	return *p;
 }
 
-void update_exception_bitmap(struct kvm_vcpu *vcpu)
+void kvm_x86_update_bp_intercept(struct kvm_vcpu *vcpu)
 {
 	u32 eb;
 
@@ -1063,7 +1063,7 @@ void vmx_set_host_fs_gs(struct vmcs_host_state *host, u16 fs_sel, u16 gs_sel,
 	}
 }
 
-void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
+void kvm_x86_prepare_guest_switch(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmcs_host_state *host_state;
@@ -1298,7 +1298,7 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu)
  * Switches to specified vcpu, until a matching vcpu_put(), but assumes
  * vcpu mutex is already taken.
  */
-void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+void kvm_x86_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -1324,7 +1324,7 @@ static void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu)
 		pi_set_sn(pi_desc);
 }
 
-static void vmx_vcpu_put(struct kvm_vcpu *vcpu)
+void kvm_x86_vcpu_put(struct kvm_vcpu *vcpu)
 {
 	vmx_vcpu_pi_put(vcpu);
 
@@ -1336,9 +1336,8 @@ static bool emulation_required(struct kvm_vcpu *vcpu)
 	return emulate_invalid_guest_state && !guest_state_valid(vcpu);
 }
 
-static void vmx_decache_cr0_guest_bits(struct kvm_vcpu *vcpu);
 
-unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu)
+unsigned long kvm_x86_get_rflags(struct kvm_vcpu *vcpu)
 {
 	unsigned long rflags, save_rflags;
 
@@ -1355,9 +1354,9 @@ unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu)
 	return to_vmx(vcpu)->rflags;
 }
 
-void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
+void kvm_x86_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
 {
-	unsigned long old_rflags = vmx_get_rflags(vcpu);
+	unsigned long old_rflags = kvm_x86_get_rflags(vcpu);
 
 	__set_bit(VCPU_EXREG_RFLAGS, (ulong *)&vcpu->arch.regs_avail);
 	to_vmx(vcpu)->rflags = rflags;
@@ -1371,7 +1370,7 @@ void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
 		to_vmx(vcpu)->emulation_required = emulation_required(vcpu);
 }
 
-u32 vmx_get_interrupt_shadow(struct kvm_vcpu *vcpu)
+u32 kvm_x86_get_interrupt_shadow(struct kvm_vcpu *vcpu)
 {
 	u32 interruptibility = vmcs_read32(GUEST_INTERRUPTIBILITY_INFO);
 	int ret = 0;
@@ -1384,7 +1383,7 @@ u32 vmx_get_interrupt_shadow(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
-void vmx_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask)
+void kvm_x86_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask)
 {
 	u32 interruptibility_old = vmcs_read32(GUEST_INTERRUPTIBILITY_INFO);
 	u32 interruptibility = interruptibility_old;
@@ -1476,7 +1475,7 @@ static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
  * Returns an int to be compatible with SVM implementation (which can fail).
  * Do not use directly, use skip_emulated_instruction() instead.
  */
-static int __skip_emulated_instruction(struct kvm_vcpu *vcpu)
+int kvm_x86_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
 	unsigned long rip;
 
@@ -1485,14 +1484,14 @@ static int __skip_emulated_instruction(struct kvm_vcpu *vcpu)
 	kvm_rip_write(vcpu, rip);
 
 	/* skipping an emulated instruction also counts */
-	vmx_set_interrupt_shadow(vcpu, 0);
+	kvm_x86_set_interrupt_shadow(vcpu, 0);
 
 	return EMULATE_DONE;
 }
 
 static inline void skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
-	(void)__skip_emulated_instruction(vcpu);
+	(void)kvm_x86_skip_emulated_instruction(vcpu);
 }
 
 static void vmx_clear_hlt(struct kvm_vcpu *vcpu)
@@ -1508,7 +1507,7 @@ static void vmx_clear_hlt(struct kvm_vcpu *vcpu)
 		vmcs_write32(GUEST_ACTIVITY_STATE, GUEST_ACTIVITY_ACTIVE);
 }
 
-static void vmx_queue_exception(struct kvm_vcpu *vcpu)
+void kvm_x86_queue_exception(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned nr = vcpu->arch.exception.nr;
@@ -1546,12 +1545,12 @@ static void vmx_queue_exception(struct kvm_vcpu *vcpu)
 	vmx_clear_hlt(vcpu);
 }
 
-static bool vmx_rdtscp_supported(void)
+bool kvm_x86_rdtscp_supported(void)
 {
 	return cpu_has_vmx_rdtscp();
 }
 
-static bool vmx_invpcid_supported(void)
+bool kvm_x86_invpcid_supported(void)
 {
 	return cpu_has_vmx_invpcid();
 }
@@ -1609,7 +1608,7 @@ static void setup_msrs(struct vcpu_vmx *vmx)
 		vmx_update_msr_bitmap(&vmx->vcpu);
 }
 
-static u64 vmx_read_l1_tsc_offset(struct kvm_vcpu *vcpu)
+u64 kvm_x86_read_l1_tsc_offset(struct kvm_vcpu *vcpu)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 
@@ -1620,7 +1619,7 @@ static u64 vmx_read_l1_tsc_offset(struct kvm_vcpu *vcpu)
 	return vcpu->arch.tsc_offset;
 }
 
-static u64 vmx_write_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
+u64 kvm_x86_write_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	u64 g_tsc_offset = 0;
@@ -1661,7 +1660,7 @@ static inline bool vmx_feature_control_msr_valid(struct kvm_vcpu *vcpu,
 	return !(val & ~valid_bits);
 }
 
-static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
+int kvm_x86_get_msr_feature(struct kvm_msr_entry *msr)
 {
 	switch (msr->index) {
 	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
@@ -1680,7 +1679,7 @@ static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
  * Returns 0 on success, non-0 otherwise.
  * Assumes vcpu_load() was already called.
  */
-static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+int kvm_x86_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct shared_msr_entry *msr;
@@ -1739,7 +1738,7 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		return vmx_get_vmx_msr(&vmx->nested.msrs, msr_info->index,
 				       &msr_info->data);
 	case MSR_IA32_XSS:
-		if (!vmx_xsaves_supported() ||
+		if (!kvm_x86_xsaves_supported() ||
 		    (!msr_info->host_initiated &&
 		     !(guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
 		       guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))))
@@ -1814,7 +1813,7 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
  * Returns 0 on success, non-0 otherwise.
  * Assumes vcpu_load() was already called.
  */
-static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+int kvm_x86_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct shared_msr_entry *msr;
@@ -1972,7 +1971,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		return vmx_set_vmx_msr(vcpu, msr_index, data);
 	case MSR_IA32_XSS:
-		if (!vmx_xsaves_supported() ||
+		if (!kvm_x86_xsaves_supported() ||
 		    (!msr_info->host_initiated &&
 		     !(guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
 		       guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))))
@@ -2076,7 +2075,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return ret;
 }
 
-static void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
+void kvm_x86_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
 {
 	__set_bit(reg, (unsigned long *)&vcpu->arch.regs_avail);
 	switch (reg) {
@@ -2095,12 +2094,12 @@ static void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
 	}
 }
 
-static __init int cpu_has_kvm_support(void)
+__init int kvm_x86_cpu_has_kvm_support(void)
 {
 	return cpu_has_vmx();
 }
 
-static __init int vmx_disabled_by_bios(void)
+__init int kvm_x86_disabled_by_bios(void)
 {
 	u64 msr;
 
@@ -2135,7 +2134,7 @@ static void kvm_cpu_vmxon(u64 addr)
 	asm volatile ("vmxon %0" : : "m"(addr));
 }
 
-static int hardware_enable(void)
+int kvm_x86_hardware_enable(void)
 {
 	int cpu = raw_smp_processor_id();
 	u64 phys_addr = __pa(per_cpu(vmxarea, cpu));
@@ -2207,7 +2206,7 @@ static void kvm_cpu_vmxoff(void)
 	cr4_clear_bits(X86_CR4_VMXE);
 }
 
-static void hardware_disable(void)
+void kvm_x86_hardware_disable(void)
 {
 	vmclear_local_loaded_vmcss();
 	kvm_cpu_vmxoff();
@@ -2566,7 +2565,7 @@ static void fix_pmode_seg(struct kvm_vcpu *vcpu, int seg,
 		save->dpl = save->selector & SEGMENT_RPL_MASK;
 		save->s = 1;
 	}
-	vmx_set_segment(vcpu, save, seg);
+	kvm_x86_set_segment(vcpu, save, seg);
 }
 
 static void enter_pmode(struct kvm_vcpu *vcpu)
@@ -2578,18 +2577,18 @@ static void enter_pmode(struct kvm_vcpu *vcpu)
 	 * Update real mode segment cache. It may be not up-to-date if sement
 	 * register was written while vcpu was in a guest mode.
 	 */
-	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_ES], VCPU_SREG_ES);
-	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_DS], VCPU_SREG_DS);
-	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_FS], VCPU_SREG_FS);
-	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_GS], VCPU_SREG_GS);
-	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_SS], VCPU_SREG_SS);
-	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_CS], VCPU_SREG_CS);
+	kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_ES], VCPU_SREG_ES);
+	kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_DS], VCPU_SREG_DS);
+	kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_FS], VCPU_SREG_FS);
+	kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_GS], VCPU_SREG_GS);
+	kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_SS], VCPU_SREG_SS);
+	kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_CS], VCPU_SREG_CS);
 
 	vmx->rmode.vm86_active = 0;
 
 	vmx_segment_cache_clear(vmx);
 
-	vmx_set_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_TR], VCPU_SREG_TR);
+	kvm_x86_set_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_TR], VCPU_SREG_TR);
 
 	flags = vmcs_readl(GUEST_RFLAGS);
 	flags &= RMODE_GUEST_OWNED_EFLAGS_BITS;
@@ -2599,7 +2598,7 @@ static void enter_pmode(struct kvm_vcpu *vcpu)
 	vmcs_writel(GUEST_CR4, (vmcs_readl(GUEST_CR4) & ~X86_CR4_VME) |
 			(vmcs_readl(CR4_READ_SHADOW) & X86_CR4_VME));
 
-	update_exception_bitmap(vcpu);
+	kvm_x86_update_bp_intercept(vcpu);
 
 	fix_pmode_seg(vcpu, VCPU_SREG_CS, &vmx->rmode.segs[VCPU_SREG_CS]);
 	fix_pmode_seg(vcpu, VCPU_SREG_SS, &vmx->rmode.segs[VCPU_SREG_SS]);
@@ -2648,13 +2647,13 @@ static void enter_rmode(struct kvm_vcpu *vcpu)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct kvm_vmx *kvm_vmx = to_kvm_vmx(vcpu->kvm);
 
-	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_TR], VCPU_SREG_TR);
-	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_ES], VCPU_SREG_ES);
-	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_DS], VCPU_SREG_DS);
-	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_FS], VCPU_SREG_FS);
-	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_GS], VCPU_SREG_GS);
-	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_SS], VCPU_SREG_SS);
-	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_CS], VCPU_SREG_CS);
+	kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_TR], VCPU_SREG_TR);
+	kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_ES], VCPU_SREG_ES);
+	kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_DS], VCPU_SREG_DS);
+	kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_FS], VCPU_SREG_FS);
+	kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_GS], VCPU_SREG_GS);
+	kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_SS], VCPU_SREG_SS);
+	kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_CS], VCPU_SREG_CS);
 
 	vmx->rmode.vm86_active = 1;
 
@@ -2679,7 +2678,7 @@ static void enter_rmode(struct kvm_vcpu *vcpu)
 
 	vmcs_writel(GUEST_RFLAGS, flags);
 	vmcs_writel(GUEST_CR4, vmcs_readl(GUEST_CR4) | X86_CR4_VME);
-	update_exception_bitmap(vcpu);
+	kvm_x86_update_bp_intercept(vcpu);
 
 	fix_rmode_seg(VCPU_SREG_SS, &vmx->rmode.segs[VCPU_SREG_SS]);
 	fix_rmode_seg(VCPU_SREG_CS, &vmx->rmode.segs[VCPU_SREG_CS]);
@@ -2691,7 +2690,7 @@ static void enter_rmode(struct kvm_vcpu *vcpu)
 	kvm_mmu_reset_context(vcpu);
 }
 
-void vmx_set_efer(struct kvm_vcpu *vcpu, u64 efer)
+void kvm_x86_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct shared_msr_entry *msr = find_msr_entry(vmx, MSR_EFER);
@@ -2727,18 +2726,18 @@ static void enter_lmode(struct kvm_vcpu *vcpu)
 			     (guest_tr_ar & ~VMX_AR_TYPE_MASK)
 			     | VMX_AR_TYPE_BUSY_64_TSS);
 	}
-	vmx_set_efer(vcpu, vcpu->arch.efer | EFER_LMA);
+	kvm_x86_set_efer(vcpu, vcpu->arch.efer | EFER_LMA);
 }
 
 static void exit_lmode(struct kvm_vcpu *vcpu)
 {
 	vm_entry_controls_clearbit(to_vmx(vcpu), VM_ENTRY_IA32E_MODE);
-	vmx_set_efer(vcpu, vcpu->arch.efer & ~EFER_LMA);
+	kvm_x86_set_efer(vcpu, vcpu->arch.efer & ~EFER_LMA);
 }
 
 #endif
 
-static void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
+void kvm_x86_tlb_flush_gva(struct kvm_vcpu *vcpu, gva_t addr)
 {
 	int vpid = to_vmx(vcpu)->vpid;
 
@@ -2752,7 +2751,7 @@ static void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
 	 */
 }
 
-static void vmx_decache_cr0_guest_bits(struct kvm_vcpu *vcpu)
+void kvm_x86_decache_cr0_guest_bits(struct kvm_vcpu *vcpu)
 {
 	ulong cr0_guest_owned_bits = vcpu->arch.cr0_guest_owned_bits;
 
@@ -2760,14 +2759,14 @@ static void vmx_decache_cr0_guest_bits(struct kvm_vcpu *vcpu)
 	vcpu->arch.cr0 |= vmcs_readl(GUEST_CR0) & cr0_guest_owned_bits;
 }
 
-static void vmx_decache_cr3(struct kvm_vcpu *vcpu)
+void kvm_x86_decache_cr3(struct kvm_vcpu *vcpu)
 {
 	if (enable_unrestricted_guest || (enable_ept && is_paging(vcpu)))
 		vcpu->arch.cr3 = vmcs_readl(GUEST_CR3);
 	__set_bit(VCPU_EXREG_CR3, (ulong *)&vcpu->arch.regs_avail);
 }
 
-static void vmx_decache_cr4_guest_bits(struct kvm_vcpu *vcpu)
+void kvm_x86_decache_cr4_guest_bits(struct kvm_vcpu *vcpu)
 {
 	ulong cr4_guest_owned_bits = vcpu->arch.cr4_guest_owned_bits;
 
@@ -2815,26 +2814,26 @@ static void ept_update_paging_mode_cr0(unsigned long *hw_cr0,
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
 	if (!test_bit(VCPU_EXREG_CR3, (ulong *)&vcpu->arch.regs_avail))
-		vmx_decache_cr3(vcpu);
+		kvm_x86_decache_cr3(vcpu);
 	if (!(cr0 & X86_CR0_PG)) {
 		/* From paging/starting to nonpaging */
 		exec_controls_setbit(vmx, CPU_BASED_CR3_LOAD_EXITING |
 					  CPU_BASED_CR3_STORE_EXITING);
 		vcpu->arch.cr0 = cr0;
-		vmx_set_cr4(vcpu, kvm_read_cr4(vcpu));
+		kvm_x86_set_cr4(vcpu, kvm_read_cr4(vcpu));
 	} else if (!is_paging(vcpu)) {
 		/* From nonpaging to paging */
 		exec_controls_clearbit(vmx, CPU_BASED_CR3_LOAD_EXITING |
 					    CPU_BASED_CR3_STORE_EXITING);
 		vcpu->arch.cr0 = cr0;
-		vmx_set_cr4(vcpu, kvm_read_cr4(vcpu));
+		kvm_x86_set_cr4(vcpu, kvm_read_cr4(vcpu));
 	}
 
 	if (!(cr0 & X86_CR0_WP))
 		*hw_cr0 &= ~X86_CR0_WP;
 }
 
-void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+void kvm_x86_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long hw_cr0;
@@ -2872,7 +2871,7 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	vmx->emulation_required = emulation_required(vcpu);
 }
 
-static int get_ept_level(struct kvm_vcpu *vcpu)
+int kvm_x86_get_tdp_level(struct kvm_vcpu *vcpu)
 {
 	if (cpu_has_vmx_ept_5levels() && (cpuid_maxphyaddr(vcpu) > 48))
 		return 5;
@@ -2883,7 +2882,7 @@ u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned long root_hpa)
 {
 	u64 eptp = VMX_EPTP_MT_WB;
 
-	eptp |= (get_ept_level(vcpu) == 5) ? VMX_EPTP_PWL_5 : VMX_EPTP_PWL_4;
+	eptp |= (kvm_x86_get_tdp_level(vcpu) == 5) ? VMX_EPTP_PWL_5 : VMX_EPTP_PWL_4;
 
 	if (enable_ept_ad_bits &&
 	    (!is_guest_mode(vcpu) || nested_ept_ad_enabled(vcpu)))
@@ -2893,7 +2892,7 @@ u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned long root_hpa)
 	return eptp;
 }
 
-void vmx_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
+void kvm_x86_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 {
 	struct kvm *kvm = vcpu->kvm;
 	unsigned long guest_cr3;
@@ -2923,7 +2922,7 @@ void vmx_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 	vmcs_writel(GUEST_CR3, guest_cr3);
 }
 
-int vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
+int kvm_x86_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	/*
@@ -2941,7 +2940,7 @@ int vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 	else
 		hw_cr4 |= KVM_PMODE_VM_CR4_ALWAYS_ON;
 
-	if (!boot_cpu_has(X86_FEATURE_UMIP) && vmx_umip_emulated()) {
+	if (!boot_cpu_has(X86_FEATURE_UMIP) && kvm_x86_umip_emulated()) {
 		if (cr4 & X86_CR4_UMIP) {
 			secondary_exec_controls_setbit(vmx, SECONDARY_EXEC_DESC);
 			hw_cr4 &= ~X86_CR4_UMIP;
@@ -2998,7 +2997,8 @@ int vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 	return 0;
 }
 
-void vmx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg)
+void kvm_x86_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var,
+			 int seg)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u32 ar;
@@ -3034,18 +3034,18 @@ void vmx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg)
 	var->g = (ar >> 15) & 1;
 }
 
-static u64 vmx_get_segment_base(struct kvm_vcpu *vcpu, int seg)
+u64 kvm_x86_get_segment_base(struct kvm_vcpu *vcpu, int seg)
 {
 	struct kvm_segment s;
 
 	if (to_vmx(vcpu)->rmode.vm86_active) {
-		vmx_get_segment(vcpu, &s, seg);
+		kvm_x86_get_segment(vcpu, &s, seg);
 		return s.base;
 	}
 	return vmx_read_guest_seg_base(to_vmx(vcpu), seg);
 }
 
-int vmx_get_cpl(struct kvm_vcpu *vcpu)
+int kvm_x86_get_cpl(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -3077,7 +3077,8 @@ static u32 vmx_segment_access_rights(struct kvm_segment *var)
 	return ar;
 }
 
-void vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg)
+void kvm_x86_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var,
+			 int seg)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	const struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
@@ -3117,7 +3118,7 @@ void vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg)
 	vmx->emulation_required = emulation_required(vcpu);
 }
 
-static void vmx_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l)
+void kvm_x86_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l)
 {
 	u32 ar = vmx_read_guest_seg_ar(to_vmx(vcpu), VCPU_SREG_CS);
 
@@ -3125,25 +3126,25 @@ static void vmx_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l)
 	*l = (ar >> 13) & 1;
 }
 
-static void vmx_get_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void kvm_x86_get_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 	dt->size = vmcs_read32(GUEST_IDTR_LIMIT);
 	dt->address = vmcs_readl(GUEST_IDTR_BASE);
 }
 
-static void vmx_set_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void kvm_x86_set_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 	vmcs_write32(GUEST_IDTR_LIMIT, dt->size);
 	vmcs_writel(GUEST_IDTR_BASE, dt->address);
 }
 
-static void vmx_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void kvm_x86_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 	dt->size = vmcs_read32(GUEST_GDTR_LIMIT);
 	dt->address = vmcs_readl(GUEST_GDTR_BASE);
 }
 
-static void vmx_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void kvm_x86_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 	vmcs_write32(GUEST_GDTR_LIMIT, dt->size);
 	vmcs_writel(GUEST_GDTR_BASE, dt->address);
@@ -3154,7 +3155,7 @@ static bool rmode_segment_valid(struct kvm_vcpu *vcpu, int seg)
 	struct kvm_segment var;
 	u32 ar;
 
-	vmx_get_segment(vcpu, &var, seg);
+	kvm_x86_get_segment(vcpu, &var, seg);
 	var.dpl = 0x3;
 	if (seg == VCPU_SREG_CS)
 		var.type = 0x3;
@@ -3175,7 +3176,7 @@ static bool code_segment_valid(struct kvm_vcpu *vcpu)
 	struct kvm_segment cs;
 	unsigned int cs_rpl;
 
-	vmx_get_segment(vcpu, &cs, VCPU_SREG_CS);
+	kvm_x86_get_segment(vcpu, &cs, VCPU_SREG_CS);
 	cs_rpl = cs.selector & SEGMENT_RPL_MASK;
 
 	if (cs.unusable)
@@ -3203,7 +3204,7 @@ static bool stack_segment_valid(struct kvm_vcpu *vcpu)
 	struct kvm_segment ss;
 	unsigned int ss_rpl;
 
-	vmx_get_segment(vcpu, &ss, VCPU_SREG_SS);
+	kvm_x86_get_segment(vcpu, &ss, VCPU_SREG_SS);
 	ss_rpl = ss.selector & SEGMENT_RPL_MASK;
 
 	if (ss.unusable)
@@ -3225,7 +3226,7 @@ static bool data_segment_valid(struct kvm_vcpu *vcpu, int seg)
 	struct kvm_segment var;
 	unsigned int rpl;
 
-	vmx_get_segment(vcpu, &var, seg);
+	kvm_x86_get_segment(vcpu, &var, seg);
 	rpl = var.selector & SEGMENT_RPL_MASK;
 
 	if (var.unusable)
@@ -3249,7 +3250,7 @@ static bool tr_valid(struct kvm_vcpu *vcpu)
 {
 	struct kvm_segment tr;
 
-	vmx_get_segment(vcpu, &tr, VCPU_SREG_TR);
+	kvm_x86_get_segment(vcpu, &tr, VCPU_SREG_TR);
 
 	if (tr.unusable)
 		return false;
@@ -3267,7 +3268,7 @@ static bool ldtr_valid(struct kvm_vcpu *vcpu)
 {
 	struct kvm_segment ldtr;
 
-	vmx_get_segment(vcpu, &ldtr, VCPU_SREG_LDTR);
+	kvm_x86_get_segment(vcpu, &ldtr, VCPU_SREG_LDTR);
 
 	if (ldtr.unusable)
 		return true;
@@ -3285,8 +3286,8 @@ static bool cs_ss_rpl_check(struct kvm_vcpu *vcpu)
 {
 	struct kvm_segment cs, ss;
 
-	vmx_get_segment(vcpu, &cs, VCPU_SREG_CS);
-	vmx_get_segment(vcpu, &ss, VCPU_SREG_SS);
+	kvm_x86_get_segment(vcpu, &cs, VCPU_SREG_CS);
+	kvm_x86_get_segment(vcpu, &ss, VCPU_SREG_SS);
 
 	return ((cs.selector & SEGMENT_RPL_MASK) ==
 		 (ss.selector & SEGMENT_RPL_MASK));
@@ -3303,7 +3304,7 @@ static bool guest_state_valid(struct kvm_vcpu *vcpu)
 		return true;
 
 	/* real mode guest state checks */
-	if (!is_protmode(vcpu) || (vmx_get_rflags(vcpu) & X86_EFLAGS_VM)) {
+	if (!is_protmode(vcpu) || (kvm_x86_get_rflags(vcpu) & X86_EFLAGS_VM)) {
 		if (!rmode_segment_valid(vcpu, VCPU_SREG_CS))
 			return false;
 		if (!rmode_segment_valid(vcpu, VCPU_SREG_SS))
@@ -3654,12 +3655,12 @@ void pt_update_intercept_for_msr(struct vcpu_vmx *vmx)
 	}
 }
 
-static bool vmx_get_enable_apicv(struct kvm_vcpu *vcpu)
+bool kvm_x86_get_enable_apicv(struct kvm_vcpu *vcpu)
 {
 	return enable_apicv;
 }
 
-static bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
+bool kvm_x86_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	void *vapic_page;
@@ -3745,7 +3746,7 @@ static int vmx_deliver_nested_posted_interrupt(struct kvm_vcpu *vcpu,
  * 2. If target vcpu isn't running(root mode), kick it to pick up the
  * interrupt from PIR in next vmentry.
  */
-static void vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
+void kvm_x86_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int r;
@@ -3769,7 +3770,7 @@ static void vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
  * Set up the vmcs's constant host-state fields, i.e., host-state fields that
  * will not change in the lifetime of the guest.
  * Note that host-state that does change is set elsewhere. E.g., host-state
- * that is set differently for each CPU is set in vmx_vcpu_load(), not here.
+ * that is set differently for each CPU is set in kvm_x86_vcpu_load(), not here.
  */
 void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
 {
@@ -3855,7 +3856,7 @@ u32 vmx_pin_based_exec_ctrl(struct vcpu_vmx *vmx)
 	return pin_based_exec_ctrl;
 }
 
-static void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
+void kvm_x86_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -3941,7 +3942,7 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
 	if (!enable_pml)
 		exec_control &= ~SECONDARY_EXEC_ENABLE_PML;
 
-	if (vmx_xsaves_supported()) {
+	if (kvm_x86_xsaves_supported()) {
 		/* Exposing XSAVES only when XSAVE is exposed */
 		bool xsaves_enabled =
 			guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
@@ -3960,7 +3961,7 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
 		}
 	}
 
-	if (vmx_rdtscp_supported()) {
+	if (kvm_x86_rdtscp_supported()) {
 		bool rdtscp_enabled = guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP);
 		if (!rdtscp_enabled)
 			exec_control &= ~SECONDARY_EXEC_RDTSCP;
@@ -3975,7 +3976,7 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
 		}
 	}
 
-	if (vmx_invpcid_supported()) {
+	if (kvm_x86_invpcid_supported()) {
 		/* Exposing INVPCID only when PCID is exposed */
 		bool invpcid_enabled =
 			guest_cpuid_has(vcpu, X86_FEATURE_INVPCID) &&
@@ -4132,7 +4133,7 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
 
 	set_cr4_guest_host_mask(vmx);
 
-	if (vmx_xsaves_supported())
+	if (kvm_x86_xsaves_supported())
 		vmcs_write64(XSS_EXIT_BITMAP, VMX_XSS_EXIT_BITMAP);
 
 	if (enable_pml) {
@@ -4151,7 +4152,7 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
 	}
 }
 
-static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
+void kvm_x86_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct msr_data apic_base_msr;
@@ -4237,34 +4238,34 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 
 	cr0 = X86_CR0_NW | X86_CR0_CD | X86_CR0_ET;
 	vmx->vcpu.arch.cr0 = cr0;
-	vmx_set_cr0(vcpu, cr0); /* enter rmode */
-	vmx_set_cr4(vcpu, 0);
-	vmx_set_efer(vcpu, 0);
+	kvm_x86_set_cr0(vcpu, cr0); /* enter rmode */
+	kvm_x86_set_cr4(vcpu, 0);
+	kvm_x86_set_efer(vcpu, 0);
 
-	update_exception_bitmap(vcpu);
+	kvm_x86_update_bp_intercept(vcpu);
 
 	vpid_sync_context(vmx->vpid);
 	if (init_event)
 		vmx_clear_hlt(vcpu);
 }
 
-static void enable_irq_window(struct kvm_vcpu *vcpu)
+void kvm_x86_enable_irq_window(struct kvm_vcpu *vcpu)
 {
 	exec_controls_setbit(to_vmx(vcpu), CPU_BASED_VIRTUAL_INTR_PENDING);
 }
 
-static void enable_nmi_window(struct kvm_vcpu *vcpu)
+void kvm_x86_enable_nmi_window(struct kvm_vcpu *vcpu)
 {
 	if (!enable_vnmi ||
 	    vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) & GUEST_INTR_STATE_STI) {
-		enable_irq_window(vcpu);
+		kvm_x86_enable_irq_window(vcpu);
 		return;
 	}
 
 	exec_controls_setbit(to_vmx(vcpu), CPU_BASED_VIRTUAL_NMI_PENDING);
 }
 
-static void vmx_inject_irq(struct kvm_vcpu *vcpu)
+void kvm_x86_set_irq(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	uint32_t intr;
@@ -4293,7 +4294,7 @@ static void vmx_inject_irq(struct kvm_vcpu *vcpu)
 	vmx_clear_hlt(vcpu);
 }
 
-static void vmx_inject_nmi(struct kvm_vcpu *vcpu)
+void kvm_x86_set_nmi(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -4325,7 +4326,7 @@ static void vmx_inject_nmi(struct kvm_vcpu *vcpu)
 	vmx_clear_hlt(vcpu);
 }
 
-bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu)
+bool kvm_x86_get_nmi_mask(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	bool masked;
@@ -4339,7 +4340,7 @@ bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu)
 	return masked;
 }
 
-void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
+void kvm_x86_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -4359,7 +4360,7 @@ void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
 	}
 }
 
-static int vmx_nmi_allowed(struct kvm_vcpu *vcpu)
+int kvm_x86_nmi_allowed(struct kvm_vcpu *vcpu)
 {
 	if (to_vmx(vcpu)->nested.nested_run_pending)
 		return 0;
@@ -4373,7 +4374,7 @@ static int vmx_nmi_allowed(struct kvm_vcpu *vcpu)
 		   | GUEST_INTR_STATE_NMI));
 }
 
-static int vmx_interrupt_allowed(struct kvm_vcpu *vcpu)
+int kvm_x86_interrupt_allowed(struct kvm_vcpu *vcpu)
 {
 	return (!to_vmx(vcpu)->nested.nested_run_pending &&
 		vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_IF) &&
@@ -4381,7 +4382,7 @@ static int vmx_interrupt_allowed(struct kvm_vcpu *vcpu)
 			(GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS));
 }
 
-static int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
+int kvm_x86_set_tss_addr(struct kvm *kvm, unsigned int addr)
 {
 	int ret;
 
@@ -4396,7 +4397,7 @@ static int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
 	return init_rmode_tss(kvm);
 }
 
-static int vmx_set_identity_map_addr(struct kvm *kvm, u64 ident_addr)
+int kvm_x86_set_identity_map_addr(struct kvm *kvm, u64 ident_addr)
 {
 	to_kvm_vmx(kvm)->ept_identity_map_addr = ident_addr;
 	return 0;
@@ -4482,7 +4483,7 @@ static void kvm_machine_check(void)
 
 static int handle_machine_check(struct kvm_vcpu *vcpu)
 {
-	/* handled by vmx_vcpu_run() */
+	/* handled by kvm_x86_run() */
 	return 1;
 }
 
@@ -4622,8 +4623,7 @@ static int handle_io(struct kvm_vcpu *vcpu)
 	return kvm_fast_pio(vcpu, size, port, in);
 }
 
-static void
-vmx_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hypercall)
+void kvm_x86_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hypercall)
 {
 	/*
 	 * Patch in the VMCALL instruction:
@@ -4737,7 +4737,7 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 		break;
 	case 2: /* clts */
 		WARN_ONCE(1, "Guest should always own CR0.TS");
-		vmx_set_cr0(vcpu, kvm_read_cr0_bits(vcpu, ~X86_CR0_TS));
+		kvm_x86_set_cr0(vcpu, kvm_read_cr0_bits(vcpu, ~X86_CR0_TS));
 		trace_kvm_cr_write(0, kvm_read_cr0(vcpu));
 		return kvm_skip_emulated_instruction(vcpu);
 	case 1: /*mov from cr*/
@@ -4833,16 +4833,16 @@ static int handle_dr(struct kvm_vcpu *vcpu)
 	return kvm_skip_emulated_instruction(vcpu);
 }
 
-static u64 vmx_get_dr6(struct kvm_vcpu *vcpu)
+u64 kvm_x86_get_dr6(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.dr6;
 }
 
-static void vmx_set_dr6(struct kvm_vcpu *vcpu, unsigned long val)
+void kvm_x86_set_dr6(struct kvm_vcpu *vcpu, unsigned long val)
 {
 }
 
-static void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
+void kvm_x86_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 {
 	get_debugreg(vcpu->arch.db[0], 0);
 	get_debugreg(vcpu->arch.db[1], 1);
@@ -4855,7 +4855,7 @@ static void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 	exec_controls_setbit(to_vmx(vcpu), CPU_BASED_MOV_DR_EXITING);
 }
 
-static void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
+void kvm_x86_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
 {
 	vmcs_writel(GUEST_DR7, val);
 }
@@ -5013,7 +5013,7 @@ static int handle_task_switch(struct kvm_vcpu *vcpu)
 		switch (type) {
 		case INTR_TYPE_NMI_INTR:
 			vcpu->arch.nmi_injected = false;
-			vmx_set_nmi_mask(vcpu, true);
+			kvm_x86_set_nmi_mask(vcpu, true);
 			break;
 		case INTR_TYPE_EXT_INTR:
 		case INTR_TYPE_SOFT_INTR:
@@ -5163,7 +5163,7 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 				CPU_BASED_VIRTUAL_INTR_PENDING;
 
 	while (vmx->emulation_required && count-- != 0) {
-		if (intr_window_requested && vmx_interrupt_allowed(vcpu))
+		if (intr_window_requested && kvm_x86_interrupt_allowed(vcpu))
 			return handle_interrupt_window(&vmx->vcpu);
 
 		if (kvm_test_request(KVM_REQ_EVENT, vcpu))
@@ -5537,7 +5537,7 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 static const int kvm_vmx_max_exit_handlers =
 	ARRAY_SIZE(kvm_vmx_exit_handlers);
 
-static void vmx_get_exit_info(struct kvm_vcpu *vcpu, u64 *info1, u64 *info2)
+void kvm_x86_get_exit_info(struct kvm_vcpu *vcpu, u64 *info1, u64 *info2)
 {
 	*info1 = vmcs_readl(EXIT_QUALIFICATION);
 	*info2 = vmcs_read32(VM_EXIT_INTR_INFO);
@@ -5779,7 +5779,7 @@ void dump_vmcs(void)
  * The guest has exited.  See if we can fix it or if we need userspace
  * assistance.
  */
-static int vmx_handle_exit(struct kvm_vcpu *vcpu)
+int kvm_x86_handle_exit(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u32 exit_reason = vmx->exit_reason;
@@ -5848,7 +5848,7 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu)
 
 	if (unlikely(!enable_vnmi &&
 		     vmx->loaded_vmcs->soft_vnmi_blocked)) {
-		if (vmx_interrupt_allowed(vcpu)) {
+		if (kvm_x86_interrupt_allowed(vcpu)) {
 			vmx->loaded_vmcs->soft_vnmi_blocked = 0;
 		} else if (vmx->loaded_vmcs->vnmi_blocked_time > 1000000000LL &&
 			   vcpu->arch.nmi_pending) {
@@ -5951,7 +5951,7 @@ static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 		: "eax", "ebx", "ecx", "edx");
 }
 
-static void update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
+void kvm_x86_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 
@@ -5967,7 +5967,7 @@ static void update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
 	vmcs_write32(TPR_THRESHOLD, irr);
 }
 
-void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu)
+void kvm_x86_set_virtual_apic_mode(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u32 sec_exec_control;
@@ -5998,7 +5998,7 @@ void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu)
 		if (flexpriority_enabled) {
 			sec_exec_control |=
 				SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;
-			vmx_flush_tlb(vcpu, true);
+			kvm_x86_tlb_flush(vcpu, true);
 		}
 		break;
 	case LAPIC_MODE_X2APIC:
@@ -6012,15 +6012,15 @@ void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu)
 	vmx_update_msr_bitmap(vcpu);
 }
 
-static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu, hpa_t hpa)
+void kvm_x86_set_apic_access_page_addr(struct kvm_vcpu *vcpu, hpa_t hpa)
 {
 	if (!is_guest_mode(vcpu)) {
 		vmcs_write64(APIC_ACCESS_ADDR, hpa);
-		vmx_flush_tlb(vcpu, true);
+		kvm_x86_tlb_flush(vcpu, true);
 	}
 }
 
-static void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
+void kvm_x86_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
 {
 	u16 status;
 	u8 old;
@@ -6054,7 +6054,7 @@ static void vmx_set_rvi(int vector)
 	}
 }
 
-static void vmx_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
+void kvm_x86_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
 {
 	/*
 	 * When running L2, updating RVI is only relevant when
@@ -6068,7 +6068,7 @@ static void vmx_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
 		vmx_set_rvi(max_irr);
 }
 
-static int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
+int kvm_x86_sync_pir_to_irr(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int max_irr;
@@ -6102,16 +6102,16 @@ static int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
 	} else {
 		max_irr = kvm_lapic_find_highest_irr(vcpu);
 	}
-	vmx_hwapic_irr_update(vcpu, max_irr);
+	kvm_x86_hwapic_irr_update(vcpu, max_irr);
 	return max_irr;
 }
 
-static bool vmx_dy_apicv_has_pending_interrupt(struct kvm_vcpu *vcpu)
+bool kvm_x86_dy_apicv_has_pending_interrupt(struct kvm_vcpu *vcpu)
 {
 	return pi_test_on(vcpu_to_pi_desc(vcpu));
 }
 
-static void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
+void kvm_x86_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 {
 	if (!kvm_vcpu_apicv_active(vcpu))
 		return;
@@ -6122,7 +6122,7 @@ static void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 	vmcs_write64(EOI_EXIT_BITMAP3, eoi_exit_bitmap[3]);
 }
 
-static void vmx_apicv_post_state_restore(struct kvm_vcpu *vcpu)
+void kvm_x86_apicv_post_state_restore(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -6196,7 +6196,7 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu)
 }
 STACK_FRAME_NON_STANDARD(handle_external_interrupt_irqoff);
 
-static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu)
+void kvm_x86_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -6206,7 +6206,7 @@ static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 		handle_exception_nmi_irqoff(vmx);
 }
 
-static bool vmx_has_emulated_msr(int index)
+bool kvm_x86_has_emulated_msr(int index)
 {
 	switch (index) {
 	case MSR_IA32_SMBASE:
@@ -6225,7 +6225,7 @@ static bool vmx_has_emulated_msr(int index)
 	}
 }
 
-static bool vmx_pt_supported(void)
+bool kvm_x86_pt_supported(void)
 {
 	return pt_mode == PT_MODE_HOST_GUEST;
 }
@@ -6304,7 +6304,7 @@ static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
 		 * Clear bit "block by NMI" before VM entry if a NMI
 		 * delivery faulted.
 		 */
-		vmx_set_nmi_mask(vcpu, false);
+		kvm_x86_set_nmi_mask(vcpu, false);
 		break;
 	case INTR_TYPE_SOFT_EXCEPTION:
 		vcpu->arch.event_exit_inst_len = vmcs_read32(instr_len_field);
@@ -6334,7 +6334,7 @@ static void vmx_complete_interrupts(struct vcpu_vmx *vmx)
 				  IDT_VECTORING_ERROR_CODE);
 }
 
-static void vmx_cancel_injection(struct kvm_vcpu *vcpu)
+void kvm_x86_cancel_injection(struct kvm_vcpu *vcpu)
 {
 	__vmx_complete_interrupts(vcpu,
 				  vmcs_read32(VM_ENTRY_INTR_INFO_FIELD),
@@ -6398,7 +6398,7 @@ void vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp)
 
 bool __vmx_vcpu_run(struct vcpu_vmx *vmx, unsigned long *regs, bool launched);
 
-static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
+void kvm_x86_run(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long cr3, cr4;
@@ -6444,7 +6444,7 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	 * exceptions being set, but that's not correct for the guest debugging
 	 * case. */
 	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)
-		vmx_set_interrupt_shadow(vcpu, 0);
+		kvm_x86_set_interrupt_shadow(vcpu, 0);
 
 	kvm_load_guest_xcr0(vcpu);
 
@@ -6568,7 +6568,7 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	vmx_complete_interrupts(vmx);
 }
 
-static struct kvm *vmx_vm_alloc(void)
+struct kvm *kvm_x86_vm_alloc(void)
 {
 	struct kvm_vmx *kvm_vmx = __vmalloc(sizeof(struct kvm_vmx),
 					    GFP_KERNEL_ACCOUNT | __GFP_ZERO,
@@ -6576,12 +6576,12 @@ static struct kvm *vmx_vm_alloc(void)
 	return &kvm_vmx->kvm;
 }
 
-static void vmx_vm_free(struct kvm *kvm)
+void kvm_x86_vm_free(struct kvm *kvm)
 {
 	vfree(to_kvm_vmx(kvm));
 }
 
-static void vmx_free_vcpu(struct kvm_vcpu *vcpu)
+void kvm_x86_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -6597,7 +6597,7 @@ static void vmx_free_vcpu(struct kvm_vcpu *vcpu)
 	kmem_cache_free(kvm_vcpu_cache, vmx);
 }
 
-static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
+struct kvm_vcpu *kvm_x86_vcpu_create(struct kvm *kvm, unsigned int id)
 {
 	int err;
 	struct vcpu_vmx *vmx;
@@ -6676,10 +6676,10 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 
 	vmx->loaded_vmcs = &vmx->vmcs01;
 	cpu = get_cpu();
-	vmx_vcpu_load(&vmx->vcpu, cpu);
+	kvm_x86_vcpu_load(&vmx->vcpu, cpu);
 	vmx->vcpu.cpu = cpu;
 	vmx_vcpu_setup(vmx);
-	vmx_vcpu_put(&vmx->vcpu);
+	kvm_x86_vcpu_put(&vmx->vcpu);
 	put_cpu();
 	if (cpu_need_virtualize_apic_accesses(&vmx->vcpu)) {
 		err = alloc_apic_access_page(kvm);
@@ -6737,7 +6737,7 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 #define L1TF_MSG_SMT "L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.\n"
 #define L1TF_MSG_L1D "L1TF CPU bug present and virtualization mitigation disabled, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.\n"
 
-static int vmx_vm_init(struct kvm *kvm)
+int kvm_x86_vm_init(struct kvm *kvm)
 {
 	spin_lock_init(&to_kvm_vmx(kvm)->ept_pointer_lock);
 
@@ -6770,7 +6770,7 @@ static int vmx_vm_init(struct kvm *kvm)
 	return 0;
 }
 
-static int __init vmx_check_processor_compat(void)
+__init int kvm_x86_check_processor_compatibility(void)
 {
 	struct vmcs_config vmcs_conf;
 	struct vmx_capability vmx_cap;
@@ -6788,7 +6788,7 @@ static int __init vmx_check_processor_compat(void)
 	return 0;
 }
 
-static u64 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
+u64 kvm_x86_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 {
 	u8 cache;
 	u64 ipat = 0;
@@ -6830,7 +6830,7 @@ static u64 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 	return (cache << VMX_EPT_MT_EPTE_SHIFT) | ipat;
 }
 
-static int vmx_get_lpage_level(void)
+int kvm_x86_get_lpage_level(void)
 {
 	if (enable_ept && !cpu_has_vmx_ept_1g_page())
 		return PT_DIRECTORY_LEVEL;
@@ -6988,7 +6988,7 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
 		vmx->pt_desc.ctl_bitmask &= ~(0xfULL << (32 + i * 4));
 }
 
-static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
+void kvm_x86_cpuid_update(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -7014,20 +7014,20 @@ static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
 		update_intel_pt_cfg(vcpu);
 }
 
-static void vmx_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *entry)
+void kvm_x86_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *entry)
 {
 	if (func == 1 && nested)
 		entry->ecx |= bit(X86_FEATURE_VMX);
 }
 
-static void vmx_request_immediate_exit(struct kvm_vcpu *vcpu)
+void kvm_x86_request_immediate_exit(struct kvm_vcpu *vcpu)
 {
 	to_vmx(vcpu)->req_immediate_exit = true;
 }
 
-static int vmx_check_intercept(struct kvm_vcpu *vcpu,
-			       struct x86_instruction_info *info,
-			       enum x86_intercept_stage stage)
+int kvm_x86_check_intercept(struct kvm_vcpu *vcpu,
+			    struct x86_instruction_info *info,
+			    enum x86_intercept_stage stage)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct x86_emulate_ctxt *ctxt = &vcpu->arch.emulate_ctxt;
@@ -7066,8 +7066,8 @@ static inline int u64_shl_div_u64(u64 a, unsigned int shift,
 	return 0;
 }
 
-static int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
-			    bool *expired)
+int kvm_x86_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
+			 bool *expired)
 {
 	struct vcpu_vmx *vmx;
 	u64 tscl, guest_tscl, delta_tsc, lapic_timer_advance_cycles;
@@ -7110,37 +7110,37 @@ static int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
 	return 0;
 }
 
-static void vmx_cancel_hv_timer(struct kvm_vcpu *vcpu)
+void kvm_x86_cancel_hv_timer(struct kvm_vcpu *vcpu)
 {
 	to_vmx(vcpu)->hv_deadline_tsc = -1;
 }
 #endif
 
-static void vmx_sched_in(struct kvm_vcpu *vcpu, int cpu)
+void kvm_x86_sched_in(struct kvm_vcpu *vcpu, int cpu)
 {
 	if (!kvm_pause_in_guest(vcpu->kvm))
 		shrink_ple_window(vcpu);
 }
 
-static void vmx_slot_enable_log_dirty(struct kvm *kvm,
-				     struct kvm_memory_slot *slot)
+void kvm_x86_slot_enable_log_dirty(struct kvm *kvm,
+				   struct kvm_memory_slot *slot)
 {
 	kvm_mmu_slot_leaf_clear_dirty(kvm, slot);
 	kvm_mmu_slot_largepage_remove_write_access(kvm, slot);
 }
 
-static void vmx_slot_disable_log_dirty(struct kvm *kvm,
-				       struct kvm_memory_slot *slot)
+void kvm_x86_slot_disable_log_dirty(struct kvm *kvm,
+				    struct kvm_memory_slot *slot)
 {
 	kvm_mmu_slot_set_dirty(kvm, slot);
 }
 
-static void vmx_flush_log_dirty(struct kvm *kvm)
+void kvm_x86_flush_log_dirty(struct kvm *kvm)
 {
 	kvm_flush_pml_buffers(kvm);
 }
 
-static int vmx_write_pml_buffer(struct kvm_vcpu *vcpu)
+int kvm_x86_write_log_dirty(struct kvm_vcpu *vcpu)
 {
 	struct vmcs12 *vmcs12;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -7176,9 +7176,9 @@ static int vmx_write_pml_buffer(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static void vmx_enable_log_dirty_pt_masked(struct kvm *kvm,
-					   struct kvm_memory_slot *memslot,
-					   gfn_t offset, unsigned long mask)
+void kvm_x86_enable_log_dirty_pt_masked(struct kvm *kvm,
+					struct kvm_memory_slot *memslot,
+					gfn_t offset, unsigned long mask)
 {
 	kvm_mmu_clear_dirty_pt_masked(kvm, memslot, offset, mask);
 }
@@ -7284,7 +7284,7 @@ static int pi_pre_block(struct kvm_vcpu *vcpu)
 	return (vcpu->pre_pcpu == -1);
 }
 
-static int vmx_pre_block(struct kvm_vcpu *vcpu)
+int kvm_x86_pre_block(struct kvm_vcpu *vcpu)
 {
 	if (pi_pre_block(vcpu))
 		return 1;
@@ -7306,7 +7306,7 @@ static void pi_post_block(struct kvm_vcpu *vcpu)
 	local_irq_enable();
 }
 
-static void vmx_post_block(struct kvm_vcpu *vcpu)
+void kvm_x86_post_block(struct kvm_vcpu *vcpu)
 {
 	if (kvm_x86_ops->set_hv_timer)
 		kvm_lapic_switch_to_hv_timer(vcpu);
@@ -7323,8 +7323,8 @@ static void vmx_post_block(struct kvm_vcpu *vcpu)
  * @set: set or unset PI
  * returns 0 on success, < 0 on failure
  */
-static int vmx_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
-			      uint32_t guest_irq, bool set)
+int kvm_x86_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
+			   uint32_t guest_irq, bool set)
 {
 	struct kvm_kernel_irq_routing_entry *e;
 	struct kvm_irq_routing_table *irq_rt;
@@ -7408,7 +7408,7 @@ static int vmx_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
 	return ret;
 }
 
-static void vmx_setup_mce(struct kvm_vcpu *vcpu)
+void kvm_x86_setup_mce(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.mcg_cap & MCG_LMCE_P)
 		to_vmx(vcpu)->msr_ia32_feature_control_valid_bits |=
@@ -7418,7 +7418,7 @@ static void vmx_setup_mce(struct kvm_vcpu *vcpu)
 			~FEATURE_CONTROL_LMCE;
 }
 
-static int vmx_smi_allowed(struct kvm_vcpu *vcpu)
+int kvm_x86_smi_allowed(struct kvm_vcpu *vcpu)
 {
 	/* we need a nested vmexit to enter SMM, postpone if run is pending */
 	if (to_vmx(vcpu)->nested.nested_run_pending)
@@ -7426,7 +7426,7 @@ static int vmx_smi_allowed(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static int vmx_pre_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
+int kvm_x86_pre_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -7440,7 +7440,7 @@ static int vmx_pre_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
 	return 0;
 }
 
-static int vmx_pre_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
+int kvm_x86_pre_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int ret;
@@ -7460,22 +7460,22 @@ static int vmx_pre_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
 	return 0;
 }
 
-static int enable_smi_window(struct kvm_vcpu *vcpu)
+int kvm_x86_enable_smi_window(struct kvm_vcpu *vcpu)
 {
 	return 0;
 }
 
-static bool vmx_need_emulation_on_page_fault(struct kvm_vcpu *vcpu)
+bool kvm_x86_need_emulation_on_page_fault(struct kvm_vcpu *vcpu)
 {
 	return false;
 }
 
-static bool vmx_apic_init_signal_blocked(struct kvm_vcpu *vcpu)
+bool kvm_x86_apic_init_signal_blocked(struct kvm_vcpu *vcpu)
 {
 	return to_vmx(vcpu)->nested.vmxon;
 }
 
-static __init int hardware_setup(void)
+__init int kvm_x86_hardware_setup(void)
 {
 	unsigned long host_bndcfgs;
 	struct desc_ptr dt;
@@ -7642,7 +7642,7 @@ static __init int hardware_setup(void)
 	return r;
 }
 
-static __exit void hardware_unsetup(void)
+__exit void kvm_x86_hardware_unsetup(void)
 {
 	if (nested)
 		nested_vmx_hardware_unsetup();
@@ -7650,148 +7650,173 @@ static __exit void hardware_unsetup(void)
 	free_kvm_area();
 }
 
+void kvm_x86_tlb_flush(struct kvm_vcpu *vcpu, bool invalidate_gpa)
+{
+	__vmx_flush_tlb(vcpu, to_vmx(vcpu)->vpid, invalidate_gpa);
+}
+
+bool kvm_x86_has_wbinvd_exit(void)
+{
+	return cpu_has_vmx_wbinvd_exit();
+}
+
+bool kvm_x86_mpx_supported(void)
+{
+	return vmx_mpx_supported();
+}
+
+bool kvm_x86_xsaves_supported(void)
+{
+	return vmx_xsaves_supported();
+}
+
+bool kvm_x86_umip_emulated(void)
+{
+	return vmx_umip_emulated();
+}
+
 static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
-	.cpu_has_kvm_support = cpu_has_kvm_support,
-	.disabled_by_bios = vmx_disabled_by_bios,
-	.hardware_setup = hardware_setup,
-	.hardware_unsetup = hardware_unsetup,
-	.check_processor_compatibility = vmx_check_processor_compat,
-	.hardware_enable = hardware_enable,
-	.hardware_disable = hardware_disable,
-	.cpu_has_accelerated_tpr = report_flexpriority,
-	.has_emulated_msr = vmx_has_emulated_msr,
-
-	.vm_init = vmx_vm_init,
-	.vm_alloc = vmx_vm_alloc,
-	.vm_free = vmx_vm_free,
-
-	.vcpu_create = vmx_create_vcpu,
-	.vcpu_free = vmx_free_vcpu,
-	.vcpu_reset = vmx_vcpu_reset,
-
-	.prepare_guest_switch = vmx_prepare_switch_to_guest,
-	.vcpu_load = vmx_vcpu_load,
-	.vcpu_put = vmx_vcpu_put,
-
-	.update_bp_intercept = update_exception_bitmap,
-	.get_msr_feature = vmx_get_msr_feature,
-	.get_msr = vmx_get_msr,
-	.set_msr = vmx_set_msr,
-	.get_segment_base = vmx_get_segment_base,
-	.get_segment = vmx_get_segment,
-	.set_segment = vmx_set_segment,
-	.get_cpl = vmx_get_cpl,
-	.get_cs_db_l_bits = vmx_get_cs_db_l_bits,
-	.decache_cr0_guest_bits = vmx_decache_cr0_guest_bits,
-	.decache_cr3 = vmx_decache_cr3,
-	.decache_cr4_guest_bits = vmx_decache_cr4_guest_bits,
-	.set_cr0 = vmx_set_cr0,
-	.set_cr3 = vmx_set_cr3,
-	.set_cr4 = vmx_set_cr4,
-	.set_efer = vmx_set_efer,
-	.get_idt = vmx_get_idt,
-	.set_idt = vmx_set_idt,
-	.get_gdt = vmx_get_gdt,
-	.set_gdt = vmx_set_gdt,
-	.get_dr6 = vmx_get_dr6,
-	.set_dr6 = vmx_set_dr6,
-	.set_dr7 = vmx_set_dr7,
-	.sync_dirty_debug_regs = vmx_sync_dirty_debug_regs,
-	.cache_reg = vmx_cache_reg,
-	.get_rflags = vmx_get_rflags,
-	.set_rflags = vmx_set_rflags,
-
-	.tlb_flush = vmx_flush_tlb,
-	.tlb_flush_gva = vmx_flush_tlb_gva,
-
-	.run = vmx_vcpu_run,
-	.handle_exit = vmx_handle_exit,
-	.skip_emulated_instruction = __skip_emulated_instruction,
-	.set_interrupt_shadow = vmx_set_interrupt_shadow,
-	.get_interrupt_shadow = vmx_get_interrupt_shadow,
-	.patch_hypercall = vmx_patch_hypercall,
-	.set_irq = vmx_inject_irq,
-	.set_nmi = vmx_inject_nmi,
-	.queue_exception = vmx_queue_exception,
-	.cancel_injection = vmx_cancel_injection,
-	.interrupt_allowed = vmx_interrupt_allowed,
-	.nmi_allowed = vmx_nmi_allowed,
-	.get_nmi_mask = vmx_get_nmi_mask,
-	.set_nmi_mask = vmx_set_nmi_mask,
-	.enable_nmi_window = enable_nmi_window,
-	.enable_irq_window = enable_irq_window,
-	.update_cr8_intercept = update_cr8_intercept,
-	.set_virtual_apic_mode = vmx_set_virtual_apic_mode,
-	.set_apic_access_page_addr = vmx_set_apic_access_page_addr,
-	.get_enable_apicv = vmx_get_enable_apicv,
-	.refresh_apicv_exec_ctrl = vmx_refresh_apicv_exec_ctrl,
-	.load_eoi_exitmap = vmx_load_eoi_exitmap,
-	.apicv_post_state_restore = vmx_apicv_post_state_restore,
-	.hwapic_irr_update = vmx_hwapic_irr_update,
-	.hwapic_isr_update = vmx_hwapic_isr_update,
-	.guest_apic_has_interrupt = vmx_guest_apic_has_interrupt,
-	.sync_pir_to_irr = vmx_sync_pir_to_irr,
-	.deliver_posted_interrupt = vmx_deliver_posted_interrupt,
-	.dy_apicv_has_pending_interrupt = vmx_dy_apicv_has_pending_interrupt,
-
-	.set_tss_addr = vmx_set_tss_addr,
-	.set_identity_map_addr = vmx_set_identity_map_addr,
-	.get_tdp_level = get_ept_level,
-	.get_mt_mask = vmx_get_mt_mask,
-
-	.get_exit_info = vmx_get_exit_info,
-
-	.get_lpage_level = vmx_get_lpage_level,
-
-	.cpuid_update = vmx_cpuid_update,
-
-	.rdtscp_supported = vmx_rdtscp_supported,
-	.invpcid_supported = vmx_invpcid_supported,
-
-	.set_supported_cpuid = vmx_set_supported_cpuid,
-
-	.has_wbinvd_exit = cpu_has_vmx_wbinvd_exit,
-
-	.read_l1_tsc_offset = vmx_read_l1_tsc_offset,
-	.write_l1_tsc_offset = vmx_write_l1_tsc_offset,
-
-	.set_tdp_cr3 = vmx_set_cr3,
-
-	.check_intercept = vmx_check_intercept,
-	.handle_exit_irqoff = vmx_handle_exit_irqoff,
-	.mpx_supported = vmx_mpx_supported,
-	.xsaves_supported = vmx_xsaves_supported,
-	.umip_emulated = vmx_umip_emulated,
-	.pt_supported = vmx_pt_supported,
-
-	.request_immediate_exit = vmx_request_immediate_exit,
-
-	.sched_in = vmx_sched_in,
-
-	.slot_enable_log_dirty = vmx_slot_enable_log_dirty,
-	.slot_disable_log_dirty = vmx_slot_disable_log_dirty,
-	.flush_log_dirty = vmx_flush_log_dirty,
-	.enable_log_dirty_pt_masked = vmx_enable_log_dirty_pt_masked,
-	.write_log_dirty = vmx_write_pml_buffer,
-
-	.pre_block = vmx_pre_block,
-	.post_block = vmx_post_block,
+	.cpu_has_kvm_support = kvm_x86_cpu_has_kvm_support,
+	.disabled_by_bios = kvm_x86_disabled_by_bios,
+	.hardware_setup = kvm_x86_hardware_setup,
+	.hardware_unsetup = kvm_x86_hardware_unsetup,
+	.check_processor_compatibility = kvm_x86_check_processor_compatibility,
+	.hardware_enable = kvm_x86_hardware_enable,
+	.hardware_disable = kvm_x86_hardware_disable,
+	.cpu_has_accelerated_tpr = kvm_x86_cpu_has_accelerated_tpr,
+	.has_emulated_msr = kvm_x86_has_emulated_msr,
+
+	.vm_init = kvm_x86_vm_init,
+	.vm_alloc = kvm_x86_vm_alloc,
+	.vm_free = kvm_x86_vm_free,
+
+	.vcpu_create = kvm_x86_vcpu_create,
+	.vcpu_free = kvm_x86_vcpu_free,
+	.vcpu_reset = kvm_x86_vcpu_reset,
+
+	.prepare_guest_switch = kvm_x86_prepare_guest_switch,
+	.vcpu_load = kvm_x86_vcpu_load,
+	.vcpu_put = kvm_x86_vcpu_put,
+
+	.update_bp_intercept = kvm_x86_update_bp_intercept,
+	.get_msr_feature = kvm_x86_get_msr_feature,
+	.get_msr = kvm_x86_get_msr,
+	.set_msr = kvm_x86_set_msr,
+	.get_segment_base = kvm_x86_get_segment_base,
+	.get_segment = kvm_x86_get_segment,
+	.set_segment = kvm_x86_set_segment,
+	.get_cpl = kvm_x86_get_cpl,
+	.get_cs_db_l_bits = kvm_x86_get_cs_db_l_bits,
+	.decache_cr0_guest_bits = kvm_x86_decache_cr0_guest_bits,
+	.decache_cr3 = kvm_x86_decache_cr3,
+	.decache_cr4_guest_bits = kvm_x86_decache_cr4_guest_bits,
+	.set_cr0 = kvm_x86_set_cr0,
+	.set_cr3 = kvm_x86_set_cr3,
+	.set_cr4 = kvm_x86_set_cr4,
+	.set_efer = kvm_x86_set_efer,
+	.get_idt = kvm_x86_get_idt,
+	.set_idt = kvm_x86_set_idt,
+	.get_gdt = kvm_x86_get_gdt,
+	.set_gdt = kvm_x86_set_gdt,
+	.get_dr6 = kvm_x86_get_dr6,
+	.set_dr6 = kvm_x86_set_dr6,
+	.set_dr7 = kvm_x86_set_dr7,
+	.sync_dirty_debug_regs = kvm_x86_sync_dirty_debug_regs,
+	.cache_reg = kvm_x86_cache_reg,
+	.get_rflags = kvm_x86_get_rflags,
+	.set_rflags = kvm_x86_set_rflags,
+
+	.tlb_flush = kvm_x86_tlb_flush,
+	.tlb_flush_gva = kvm_x86_tlb_flush_gva,
+
+	.run = kvm_x86_run,
+	.handle_exit = kvm_x86_handle_exit,
+	.skip_emulated_instruction = kvm_x86_skip_emulated_instruction,
+	.set_interrupt_shadow = kvm_x86_set_interrupt_shadow,
+	.get_interrupt_shadow = kvm_x86_get_interrupt_shadow,
+	.patch_hypercall = kvm_x86_patch_hypercall,
+	.set_irq = kvm_x86_set_irq,
+	.set_nmi = kvm_x86_set_nmi,
+	.queue_exception = kvm_x86_queue_exception,
+	.cancel_injection = kvm_x86_cancel_injection,
+	.interrupt_allowed = kvm_x86_interrupt_allowed,
+	.nmi_allowed = kvm_x86_nmi_allowed,
+	.get_nmi_mask = kvm_x86_get_nmi_mask,
+	.set_nmi_mask = kvm_x86_set_nmi_mask,
+	.enable_nmi_window = kvm_x86_enable_nmi_window,
+	.enable_irq_window = kvm_x86_enable_irq_window,
+	.update_cr8_intercept = kvm_x86_update_cr8_intercept,
+	.set_virtual_apic_mode = kvm_x86_set_virtual_apic_mode,
+	.set_apic_access_page_addr = kvm_x86_set_apic_access_page_addr,
+	.get_enable_apicv = kvm_x86_get_enable_apicv,
+	.refresh_apicv_exec_ctrl = kvm_x86_refresh_apicv_exec_ctrl,
+	.load_eoi_exitmap = kvm_x86_load_eoi_exitmap,
+	.apicv_post_state_restore = kvm_x86_apicv_post_state_restore,
+	.hwapic_irr_update = kvm_x86_hwapic_irr_update,
+	.hwapic_isr_update = kvm_x86_hwapic_isr_update,
+	.guest_apic_has_interrupt = kvm_x86_guest_apic_has_interrupt,
+	.sync_pir_to_irr = kvm_x86_sync_pir_to_irr,
+	.deliver_posted_interrupt = kvm_x86_deliver_posted_interrupt,
+	.dy_apicv_has_pending_interrupt = kvm_x86_dy_apicv_has_pending_interrupt,
+
+	.set_tss_addr = kvm_x86_set_tss_addr,
+	.set_identity_map_addr = kvm_x86_set_identity_map_addr,
+	.get_tdp_level = kvm_x86_get_tdp_level,
+	.get_mt_mask = kvm_x86_get_mt_mask,
+
+	.get_exit_info = kvm_x86_get_exit_info,
+
+	.get_lpage_level = kvm_x86_get_lpage_level,
+
+	.cpuid_update = kvm_x86_cpuid_update,
+
+	.rdtscp_supported = kvm_x86_rdtscp_supported,
+	.invpcid_supported = kvm_x86_invpcid_supported,
+
+	.set_supported_cpuid = kvm_x86_set_supported_cpuid,
+
+	.has_wbinvd_exit = kvm_x86_has_wbinvd_exit,
+
+	.read_l1_tsc_offset = kvm_x86_read_l1_tsc_offset,
+	.write_l1_tsc_offset = kvm_x86_write_l1_tsc_offset,
+
+	.set_tdp_cr3 = kvm_x86_set_cr3,
+
+	.check_intercept = kvm_x86_check_intercept,
+	.handle_exit_irqoff = kvm_x86_handle_exit_irqoff,
+	.mpx_supported = kvm_x86_mpx_supported,
+	.xsaves_supported = kvm_x86_xsaves_supported,
+	.umip_emulated = kvm_x86_umip_emulated,
+	.pt_supported = kvm_x86_pt_supported,
+
+	.request_immediate_exit = kvm_x86_request_immediate_exit,
+
+	.sched_in = kvm_x86_sched_in,
+
+	.slot_enable_log_dirty = kvm_x86_slot_enable_log_dirty,
+	.slot_disable_log_dirty = kvm_x86_slot_disable_log_dirty,
+	.flush_log_dirty = kvm_x86_flush_log_dirty,
+	.enable_log_dirty_pt_masked = kvm_x86_enable_log_dirty_pt_masked,
+	.write_log_dirty = kvm_x86_write_log_dirty,
+
+	.pre_block = kvm_x86_pre_block,
+	.post_block = kvm_x86_post_block,
 
 	.pmu_ops = &intel_pmu_ops,
 
-	.update_pi_irte = vmx_update_pi_irte,
+	.update_pi_irte = kvm_x86_update_pi_irte,
 
 #ifdef CONFIG_X86_64
-	.set_hv_timer = vmx_set_hv_timer,
-	.cancel_hv_timer = vmx_cancel_hv_timer,
+	.set_hv_timer = kvm_x86_set_hv_timer,
+	.cancel_hv_timer = kvm_x86_cancel_hv_timer,
 #endif
 
-	.setup_mce = vmx_setup_mce,
+	.setup_mce = kvm_x86_setup_mce,
 
-	.smi_allowed = vmx_smi_allowed,
-	.pre_enter_smm = vmx_pre_enter_smm,
-	.pre_leave_smm = vmx_pre_leave_smm,
-	.enable_smi_window = enable_smi_window,
+	.smi_allowed = kvm_x86_smi_allowed,
+	.pre_enter_smm = kvm_x86_pre_enter_smm,
+	.pre_leave_smm = kvm_x86_pre_leave_smm,
+	.enable_smi_window = kvm_x86_enable_smi_window,
 
 	.check_nested_events = NULL,
 	.get_nested_state = NULL,
@@ -7799,8 +7824,8 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.get_vmcs12_pages = NULL,
 	.nested_enable_evmcs = NULL,
 	.nested_get_evmcs_version = NULL,
-	.need_emulation_on_page_fault = vmx_need_emulation_on_page_fault,
-	.apic_init_signal_blocked = vmx_apic_init_signal_blocked,
+	.need_emulation_on_page_fault = kvm_x86_need_emulation_on_page_fault,
+	.apic_init_signal_blocked = kvm_x86_apic_init_signal_blocked,
 };
 
 static void vmx_cleanup_l1d_flush(void)
@@ -7910,3 +7935,80 @@ static int __init vmx_init(void)
 	return 0;
 }
 module_init(vmx_init);
+
+void kvm_x86_vm_destroy(struct kvm *kvm)
+{
+	kvm_x86_ops->vm_destroy(kvm);
+}
+
+int kvm_x86_tlb_remote_flush(struct kvm *kvm)
+{
+	return kvm_x86_ops->tlb_remote_flush(kvm);
+}
+
+int kvm_x86_tlb_remote_flush_with_range(struct kvm *kvm,
+					struct kvm_tlb_range *range)
+{
+	return kvm_x86_ops->tlb_remote_flush_with_range(kvm, range);
+}
+
+int kvm_x86_check_nested_events(struct kvm_vcpu *vcpu, bool external_intr)
+{
+	return kvm_x86_ops->check_nested_events(vcpu, external_intr);
+}
+
+void kvm_x86_vcpu_blocking(struct kvm_vcpu *vcpu)
+{
+	kvm_x86_ops->vcpu_blocking(vcpu);
+}
+
+void kvm_x86_vcpu_unblocking(struct kvm_vcpu *vcpu)
+{
+	kvm_x86_ops->vcpu_unblocking(vcpu);
+}
+
+int kvm_x86_get_nested_state(struct kvm_vcpu *vcpu,
+			     struct kvm_nested_state __user *user_kvm_nested_state,
+			     unsigned user_data_size)
+{
+	return kvm_x86_ops->get_nested_state(vcpu, user_kvm_nested_state,
+					     user_data_size);
+}
+
+int kvm_x86_set_nested_state(struct kvm_vcpu *vcpu,
+			     struct kvm_nested_state __user *user_kvm_nested_state,
+			     struct kvm_nested_state *kvm_state)
+{
+	return kvm_x86_ops->set_nested_state(vcpu, user_kvm_nested_state,
+					     kvm_state);
+}
+
+void kvm_x86_get_vmcs12_pages(struct kvm_vcpu *vcpu)
+{
+	kvm_x86_ops->get_vmcs12_pages(vcpu);
+}
+
+int kvm_x86_mem_enc_op(struct kvm *kvm, void __user *argp)
+{
+	return kvm_x86_ops->mem_enc_op(kvm, argp);
+}
+
+int kvm_x86_mem_enc_reg_region(struct kvm *kvm, struct kvm_enc_region *argp)
+{
+	return kvm_x86_ops->mem_enc_reg_region(kvm, argp);
+}
+
+int kvm_x86_mem_enc_unreg_region(struct kvm *kvm, struct kvm_enc_region *argp)
+{
+	return kvm_x86_ops->mem_enc_unreg_region(kvm, argp);
+}
+
+int kvm_x86_nested_enable_evmcs(struct kvm_vcpu *vcpu, uint16_t *vmcs_version)
+{
+	return kvm_x86_ops->nested_enable_evmcs(vcpu, vmcs_version);
+}
+
+uint16_t kvm_x86_nested_get_evmcs_version(struct kvm_vcpu *vcpu)
+{
+	return kvm_x86_ops->nested_get_evmcs_version(vcpu);
+}
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 64d5a4890aa9..21d87cd18c1c 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -302,32 +302,32 @@ struct kvm_vmx {
 
 bool nested_vmx_allowed(struct kvm_vcpu *vcpu);
 void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu);
-void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
+void kvm_x86_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 int allocate_vpid(void);
 void free_vpid(int vpid);
 void vmx_set_constant_host_state(struct vcpu_vmx *vmx);
-void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu);
+void kvm_x86_prepare_guest_switch(struct kvm_vcpu *vcpu);
 void vmx_set_host_fs_gs(struct vmcs_host_state *host, u16 fs_sel, u16 gs_sel,
 			unsigned long fs_base, unsigned long gs_base);
-int vmx_get_cpl(struct kvm_vcpu *vcpu);
-unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu);
-void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
-u32 vmx_get_interrupt_shadow(struct kvm_vcpu *vcpu);
-void vmx_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask);
-void vmx_set_efer(struct kvm_vcpu *vcpu, u64 efer);
-void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
-void vmx_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3);
-int vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
+int kvm_x86_get_cpl(struct kvm_vcpu *vcpu);
+unsigned long kvm_x86_get_rflags(struct kvm_vcpu *vcpu);
+void kvm_x86_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
+u32 kvm_x86_get_interrupt_shadow(struct kvm_vcpu *vcpu);
+void kvm_x86_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask);
+void kvm_x86_set_efer(struct kvm_vcpu *vcpu, u64 efer);
+void kvm_x86_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
+void kvm_x86_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3);
+int kvm_x86_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
 void set_cr4_guest_host_mask(struct vcpu_vmx *vmx);
 void ept_save_pdptrs(struct kvm_vcpu *vcpu);
-void vmx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
-void vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
+void kvm_x86_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
+void kvm_x86_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
 u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned long root_hpa);
-void update_exception_bitmap(struct kvm_vcpu *vcpu);
+void kvm_x86_update_bp_intercept(struct kvm_vcpu *vcpu);
 void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
-bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu);
-void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked);
-void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu);
+bool kvm_x86_get_nmi_mask(struct kvm_vcpu *vcpu);
+void kvm_x86_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked);
+void kvm_x86_set_virtual_apic_mode(struct kvm_vcpu *vcpu);
 struct shared_msr_entry *find_msr_entry(struct vcpu_vmx *vmx, u32 msr);
 void pt_update_intercept_for_msr(struct vcpu_vmx *vmx);
 void vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp);
@@ -486,11 +486,6 @@ static inline void __vmx_flush_tlb(struct kvm_vcpu *vcpu, int vpid,
 	}
 }
 
-static inline void vmx_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gpa)
-{
-	__vmx_flush_tlb(vcpu, to_vmx(vcpu)->vpid, invalidate_gpa);
-}
-
 static inline void decache_tsc_multiplier(struct vcpu_vmx *vmx)
 {
 	vmx->current_tsc_ratio = vmx->vcpu.arch.tsc_scaling_ratio;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index dfd641243568..8e593d28ff95 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -626,7 +626,7 @@ EXPORT_SYMBOL_GPL(kvm_requeue_exception_e);
  */
 bool kvm_require_cpl(struct kvm_vcpu *vcpu, int required_cpl)
 {
-	if (kvm_x86_ops->get_cpl(vcpu) <= required_cpl)
+	if (kvm_x86_get_cpl(vcpu) <= required_cpl)
 		return true;
 	kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
 	return false;
@@ -773,7 +773,7 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 
 			if (!is_pae(vcpu))
 				return 1;
-			kvm_x86_ops->get_cs_db_l_bits(vcpu, &cs_db, &cs_l);
+			kvm_x86_get_cs_db_l_bits(vcpu, &cs_db, &cs_l);
 			if (cs_l)
 				return 1;
 		} else
@@ -786,7 +786,7 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	if (!(cr0 & X86_CR0_PG) && kvm_read_cr4_bits(vcpu, X86_CR4_PCIDE))
 		return 1;
 
-	kvm_x86_ops->set_cr0(vcpu, cr0);
+	kvm_x86_set_cr0(vcpu, cr0);
 
 	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
 		kvm_clear_async_pf_completion_queue(vcpu);
@@ -875,7 +875,7 @@ static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
 
 int kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
 {
-	if (kvm_x86_ops->get_cpl(vcpu) != 0 ||
+	if (kvm_x86_get_cpl(vcpu) != 0 ||
 	    __kvm_set_xcr(vcpu, index, xcr)) {
 		kvm_inject_gp(vcpu, 0);
 		return 1;
@@ -932,7 +932,7 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 			return 1;
 	}
 
-	if (kvm_x86_ops->set_cr4(vcpu, cr4))
+	if (kvm_x86_set_cr4(vcpu, cr4))
 		return 1;
 
 	if (((cr4 ^ old_cr4) & pdptr_bits) ||
@@ -1016,7 +1016,7 @@ static void kvm_update_dr0123(struct kvm_vcpu *vcpu)
 static void kvm_update_dr6(struct kvm_vcpu *vcpu)
 {
 	if (!(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP))
-		kvm_x86_ops->set_dr6(vcpu, vcpu->arch.dr6);
+		kvm_x86_set_dr6(vcpu, vcpu->arch.dr6);
 }
 
 static void kvm_update_dr7(struct kvm_vcpu *vcpu)
@@ -1027,7 +1027,7 @@ static void kvm_update_dr7(struct kvm_vcpu *vcpu)
 		dr7 = vcpu->arch.guest_debug_dr7;
 	else
 		dr7 = vcpu->arch.dr7;
-	kvm_x86_ops->set_dr7(vcpu, dr7);
+	kvm_x86_set_dr7(vcpu, dr7);
 	vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_BP_ENABLED;
 	if (dr7 & DR7_BP_EN_MASK)
 		vcpu->arch.switch_db_regs |= KVM_DEBUGREG_BP_ENABLED;
@@ -1093,7 +1093,7 @@ int kvm_get_dr(struct kvm_vcpu *vcpu, int dr, unsigned long *val)
 		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP)
 			*val = vcpu->arch.dr6;
 		else
-			*val = kvm_x86_ops->get_dr6(vcpu);
+			*val = kvm_x86_get_dr6(vcpu);
 		break;
 	case 5:
 		/* fall through */
@@ -1279,7 +1279,7 @@ static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
 		rdmsrl_safe(msr->index, &msr->data);
 		break;
 	default:
-		if (kvm_x86_ops->get_msr_feature(msr))
+		if (kvm_x86_get_msr_feature(msr))
 			return 1;
 	}
 	return 0;
@@ -1347,7 +1347,7 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	efer &= ~EFER_LMA;
 	efer |= vcpu->arch.efer & EFER_LMA;
 
-	kvm_x86_ops->set_efer(vcpu, efer);
+	kvm_x86_set_efer(vcpu, efer);
 
 	/* Update reserved bits */
 	if ((efer ^ old_efer) & EFER_NX)
@@ -1403,7 +1403,7 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
 	msr.index = index;
 	msr.host_initiated = host_initiated;
 
-	return kvm_x86_ops->set_msr(vcpu, &msr);
+	return kvm_x86_set_msr(vcpu, &msr);
 }
 
 /*
@@ -1421,7 +1421,7 @@ static int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
 	msr.index = index;
 	msr.host_initiated = host_initiated;
 
-	ret = kvm_x86_ops->get_msr(vcpu, &msr);
+	ret = kvm_x86_get_msr(vcpu, &msr);
 	if (!ret)
 		*data = msr.data;
 	return ret;
@@ -1742,7 +1742,7 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu)
 
 static void update_ia32_tsc_adjust_msr(struct kvm_vcpu *vcpu, s64 offset)
 {
-	u64 curr_offset = kvm_x86_ops->read_l1_tsc_offset(vcpu);
+	u64 curr_offset = kvm_x86_read_l1_tsc_offset(vcpu);
 	vcpu->arch.ia32_tsc_adjust_msr += offset - curr_offset;
 }
 
@@ -1784,7 +1784,7 @@ static u64 kvm_compute_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc)
 
 u64 kvm_read_l1_tsc(struct kvm_vcpu *vcpu, u64 host_tsc)
 {
-	u64 tsc_offset = kvm_x86_ops->read_l1_tsc_offset(vcpu);
+	u64 tsc_offset = kvm_x86_read_l1_tsc_offset(vcpu);
 
 	return tsc_offset + kvm_scale_tsc(vcpu, host_tsc);
 }
@@ -1792,7 +1792,7 @@ EXPORT_SYMBOL_GPL(kvm_read_l1_tsc);
 
 static void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 {
-	vcpu->arch.tsc_offset = kvm_x86_ops->write_l1_tsc_offset(vcpu, offset);
+	vcpu->arch.tsc_offset = kvm_x86_write_l1_tsc_offset(vcpu, offset);
 }
 
 static inline bool kvm_check_tsc_unstable(void)
@@ -1916,7 +1916,7 @@ EXPORT_SYMBOL_GPL(kvm_write_tsc);
 static inline void adjust_tsc_offset_guest(struct kvm_vcpu *vcpu,
 					   s64 adjustment)
 {
-	u64 tsc_offset = kvm_x86_ops->read_l1_tsc_offset(vcpu);
+	u64 tsc_offset = kvm_x86_read_l1_tsc_offset(vcpu);
 	kvm_vcpu_write_tsc_offset(vcpu, tsc_offset + adjustment);
 }
 
@@ -2509,7 +2509,7 @@ static void kvmclock_reset(struct kvm_vcpu *vcpu)
 static void kvm_vcpu_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gpa)
 {
 	++vcpu->stat.tlb_flush;
-	kvm_x86_ops->tlb_flush(vcpu, invalidate_gpa);
+	kvm_x86_tlb_flush(vcpu, invalidate_gpa);
 }
 
 static void record_steal_time(struct kvm_vcpu *vcpu)
@@ -3213,10 +3213,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		 * fringe case that is not enabled except via specific settings
 		 * of the module parameters.
 		 */
-		r = kvm_x86_ops->has_emulated_msr(MSR_IA32_SMBASE);
+		r = kvm_x86_has_emulated_msr(MSR_IA32_SMBASE);
 		break;
 	case KVM_CAP_VAPIC:
-		r = !kvm_x86_ops->cpu_has_accelerated_tpr();
+		r = !kvm_x86_cpu_has_accelerated_tpr();
 		break;
 	case KVM_CAP_NR_VCPUS:
 		r = KVM_SOFT_MAX_VCPUS;
@@ -3244,7 +3244,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 	case KVM_CAP_NESTED_STATE:
 		r = kvm_x86_ops->get_nested_state ?
-			kvm_x86_ops->get_nested_state(NULL, NULL, 0) : 0;
+			kvm_x86_get_nested_state(NULL, NULL, 0) : 0;
 		break;
 	default:
 		break;
@@ -3360,14 +3360,14 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	/* Address WBINVD may be executed by guest */
 	if (need_emulate_wbinvd(vcpu)) {
-		if (kvm_x86_ops->has_wbinvd_exit())
+		if (kvm_x86_has_wbinvd_exit())
 			cpumask_set_cpu(cpu, vcpu->arch.wbinvd_dirty_mask);
 		else if (vcpu->cpu != -1 && vcpu->cpu != cpu)
 			smp_call_function_single(vcpu->cpu,
 					wbinvd_ipi, NULL, 1);
 	}
 
-	kvm_x86_ops->vcpu_load(vcpu, cpu);
+	kvm_x86_vcpu_load(vcpu, cpu);
 
 	fpregs_assert_state_consistent();
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
@@ -3428,7 +3428,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	int idx;
 
 	if (vcpu->preempted)
-		vcpu->arch.preempted_in_kernel = !kvm_x86_ops->get_cpl(vcpu);
+		vcpu->arch.preempted_in_kernel = !kvm_x86_get_cpl(vcpu);
 
 	/*
 	 * Disable page faults because we're in atomic context here.
@@ -3447,7 +3447,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	kvm_steal_time_set_preempted(vcpu);
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 	pagefault_enable();
-	kvm_x86_ops->vcpu_put(vcpu);
+	kvm_x86_vcpu_put(vcpu);
 	vcpu->arch.last_host_tsc = rdtsc();
 	/*
 	 * If userspace has set any breakpoints or watchpoints, dr6 is restored
@@ -3461,7 +3461,7 @@ static int kvm_vcpu_ioctl_get_lapic(struct kvm_vcpu *vcpu,
 				    struct kvm_lapic_state *s)
 {
 	if (vcpu->arch.apicv_active)
-		kvm_x86_ops->sync_pir_to_irr(vcpu);
+		kvm_x86_sync_pir_to_irr(vcpu);
 
 	return kvm_apic_get_state(vcpu, s);
 }
@@ -3569,7 +3569,7 @@ static int kvm_vcpu_ioctl_x86_setup_mce(struct kvm_vcpu *vcpu,
 	for (bank = 0; bank < bank_num; bank++)
 		vcpu->arch.mce_banks[bank*4] = ~(u64)0;
 
-	kvm_x86_ops->setup_mce(vcpu);
+	kvm_x86_setup_mce(vcpu);
 out:
 	return r;
 }
@@ -3658,11 +3658,11 @@ static void kvm_vcpu_ioctl_x86_get_vcpu_events(struct kvm_vcpu *vcpu,
 		vcpu->arch.interrupt.injected && !vcpu->arch.interrupt.soft;
 	events->interrupt.nr = vcpu->arch.interrupt.nr;
 	events->interrupt.soft = 0;
-	events->interrupt.shadow = kvm_x86_ops->get_interrupt_shadow(vcpu);
+	events->interrupt.shadow = kvm_x86_get_interrupt_shadow(vcpu);
 
 	events->nmi.injected = vcpu->arch.nmi_injected;
 	events->nmi.pending = vcpu->arch.nmi_pending != 0;
-	events->nmi.masked = kvm_x86_ops->get_nmi_mask(vcpu);
+	events->nmi.masked = kvm_x86_get_nmi_mask(vcpu);
 	events->nmi.pad = 0;
 
 	events->sipi_vector = 0; /* never valid when reporting to user space */
@@ -3729,13 +3729,13 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 	vcpu->arch.interrupt.nr = events->interrupt.nr;
 	vcpu->arch.interrupt.soft = events->interrupt.soft;
 	if (events->flags & KVM_VCPUEVENT_VALID_SHADOW)
-		kvm_x86_ops->set_interrupt_shadow(vcpu,
+		kvm_x86_set_interrupt_shadow(vcpu,
 						  events->interrupt.shadow);
 
 	vcpu->arch.nmi_injected = events->nmi.injected;
 	if (events->flags & KVM_VCPUEVENT_VALID_NMI_PENDING)
 		vcpu->arch.nmi_pending = events->nmi.pending;
-	kvm_x86_ops->set_nmi_mask(vcpu, events->nmi.masked);
+	kvm_x86_set_nmi_mask(vcpu, events->nmi.masked);
 
 	if (events->flags & KVM_VCPUEVENT_VALID_SIPI_VECTOR &&
 	    lapic_in_kernel(vcpu))
@@ -4011,7 +4011,7 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
 		if (!kvm_x86_ops->nested_enable_evmcs)
 			return -ENOTTY;
-		r = kvm_x86_ops->nested_enable_evmcs(vcpu, &vmcs_version);
+		r = kvm_x86_nested_enable_evmcs(vcpu, &vmcs_version);
 		if (!r) {
 			user_ptr = (void __user *)(uintptr_t)cap->args[0];
 			if (copy_to_user(user_ptr, &vmcs_version,
@@ -4329,7 +4329,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (get_user(user_data_size, &user_kvm_nested_state->size))
 			break;
 
-		r = kvm_x86_ops->get_nested_state(vcpu, user_kvm_nested_state,
+		r = kvm_x86_get_nested_state(vcpu, user_kvm_nested_state,
 						  user_data_size);
 		if (r < 0)
 			break;
@@ -4371,7 +4371,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		    && !(kvm_state.flags & KVM_STATE_NESTED_GUEST_MODE))
 			break;
 
-		r = kvm_x86_ops->set_nested_state(vcpu, user_kvm_nested_state, &kvm_state);
+		r = kvm_x86_set_nested_state(vcpu, user_kvm_nested_state, &kvm_state);
 		break;
 	}
 	case KVM_GET_SUPPORTED_HV_CPUID: {
@@ -4414,14 +4414,14 @@ static int kvm_vm_ioctl_set_tss_addr(struct kvm *kvm, unsigned long addr)
 
 	if (addr > (unsigned int)(-3 * PAGE_SIZE))
 		return -EINVAL;
-	ret = kvm_x86_ops->set_tss_addr(kvm, addr);
+	ret = kvm_x86_set_tss_addr(kvm, addr);
 	return ret;
 }
 
 static int kvm_vm_ioctl_set_identity_map_addr(struct kvm *kvm,
 					      u64 ident_addr)
 {
-	return kvm_x86_ops->set_identity_map_addr(kvm, ident_addr);
+	return kvm_x86_set_identity_map_addr(kvm, ident_addr);
 }
 
 static int kvm_vm_ioctl_set_nr_mmu_pages(struct kvm *kvm,
@@ -4606,7 +4606,7 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 	 * Flush potentially hardware-cached dirty pages to dirty_bitmap.
 	 */
 	if (kvm_x86_ops->flush_log_dirty)
-		kvm_x86_ops->flush_log_dirty(kvm);
+		kvm_x86_flush_log_dirty(kvm);
 
 	r = kvm_get_dirty_log_protect(kvm, log, &flush);
 
@@ -4633,7 +4633,7 @@ int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm, struct kvm_clear_dirty_log *lo
 	 * Flush potentially hardware-cached dirty pages to dirty_bitmap.
 	 */
 	if (kvm_x86_ops->flush_log_dirty)
-		kvm_x86_ops->flush_log_dirty(kvm);
+		kvm_x86_flush_log_dirty(kvm);
 
 	r = kvm_clear_dirty_log_protect(kvm, log, &flush);
 
@@ -5000,7 +5000,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	case KVM_MEMORY_ENCRYPT_OP: {
 		r = -ENOTTY;
 		if (kvm_x86_ops->mem_enc_op)
-			r = kvm_x86_ops->mem_enc_op(kvm, argp);
+			r = kvm_x86_mem_enc_op(kvm, argp);
 		break;
 	}
 	case KVM_MEMORY_ENCRYPT_REG_REGION: {
@@ -5012,7 +5012,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 
 		r = -ENOTTY;
 		if (kvm_x86_ops->mem_enc_reg_region)
-			r = kvm_x86_ops->mem_enc_reg_region(kvm, &region);
+			r = kvm_x86_mem_enc_reg_region(kvm, &region);
 		break;
 	}
 	case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
@@ -5024,7 +5024,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 
 		r = -ENOTTY;
 		if (kvm_x86_ops->mem_enc_unreg_region)
-			r = kvm_x86_ops->mem_enc_unreg_region(kvm, &region);
+			r = kvm_x86_mem_enc_unreg_region(kvm, &region);
 		break;
 	}
 	case KVM_HYPERV_EVENTFD: {
@@ -5065,28 +5065,28 @@ static void kvm_init_msr_list(void)
 				continue;
 			break;
 		case MSR_TSC_AUX:
-			if (!kvm_x86_ops->rdtscp_supported())
+			if (!kvm_x86_rdtscp_supported())
 				continue;
 			break;
 		case MSR_IA32_RTIT_CTL:
 		case MSR_IA32_RTIT_STATUS:
-			if (!kvm_x86_ops->pt_supported())
+			if (!kvm_x86_pt_supported())
 				continue;
 			break;
 		case MSR_IA32_RTIT_CR3_MATCH:
-			if (!kvm_x86_ops->pt_supported() ||
+			if (!kvm_x86_pt_supported() ||
 			    !intel_pt_validate_hw_cap(PT_CAP_cr3_filtering))
 				continue;
 			break;
 		case MSR_IA32_RTIT_OUTPUT_BASE:
 		case MSR_IA32_RTIT_OUTPUT_MASK:
-			if (!kvm_x86_ops->pt_supported() ||
+			if (!kvm_x86_pt_supported() ||
 				(!intel_pt_validate_hw_cap(PT_CAP_topa_output) &&
 				 !intel_pt_validate_hw_cap(PT_CAP_single_range_output)))
 				continue;
 			break;
 		case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B: {
-			if (!kvm_x86_ops->pt_supported() ||
+			if (!kvm_x86_pt_supported() ||
 				msrs_to_save[i] - MSR_IA32_RTIT_ADDR0_A >=
 				intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) * 2)
 				continue;
@@ -5103,7 +5103,7 @@ static void kvm_init_msr_list(void)
 	num_msrs_to_save = j;
 
 	for (i = j = 0; i < ARRAY_SIZE(emulated_msrs); i++) {
-		if (!kvm_x86_ops->has_emulated_msr(emulated_msrs[i]))
+		if (!kvm_x86_has_emulated_msr(emulated_msrs[i]))
 			continue;
 
 		if (j < i)
@@ -5172,13 +5172,13 @@ static int vcpu_mmio_read(struct kvm_vcpu *vcpu, gpa_t addr, int len, void *v)
 static void kvm_set_segment(struct kvm_vcpu *vcpu,
 			struct kvm_segment *var, int seg)
 {
-	kvm_x86_ops->set_segment(vcpu, var, seg);
+	kvm_x86_set_segment(vcpu, var, seg);
 }
 
 void kvm_get_segment(struct kvm_vcpu *vcpu,
 		     struct kvm_segment *var, int seg)
 {
-	kvm_x86_ops->get_segment(vcpu, var, seg);
+	kvm_x86_get_segment(vcpu, var, seg);
 }
 
 gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u32 access,
@@ -5198,14 +5198,14 @@ gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u32 access,
 gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
 			      struct x86_exception *exception)
 {
-	u32 access = (kvm_x86_ops->get_cpl(vcpu) == 3) ? PFERR_USER_MASK : 0;
+	u32 access = (kvm_x86_get_cpl(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	return vcpu->arch.walk_mmu->gva_to_gpa(vcpu, gva, access, exception);
 }
 
  gpa_t kvm_mmu_gva_to_gpa_fetch(struct kvm_vcpu *vcpu, gva_t gva,
 				struct x86_exception *exception)
 {
-	u32 access = (kvm_x86_ops->get_cpl(vcpu) == 3) ? PFERR_USER_MASK : 0;
+	u32 access = (kvm_x86_get_cpl(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	access |= PFERR_FETCH_MASK;
 	return vcpu->arch.walk_mmu->gva_to_gpa(vcpu, gva, access, exception);
 }
@@ -5213,7 +5213,7 @@ gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
 gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
 			       struct x86_exception *exception)
 {
-	u32 access = (kvm_x86_ops->get_cpl(vcpu) == 3) ? PFERR_USER_MASK : 0;
+	u32 access = (kvm_x86_get_cpl(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	access |= PFERR_WRITE_MASK;
 	return vcpu->arch.walk_mmu->gva_to_gpa(vcpu, gva, access, exception);
 }
@@ -5262,7 +5262,7 @@ static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
 				struct x86_exception *exception)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
-	u32 access = (kvm_x86_ops->get_cpl(vcpu) == 3) ? PFERR_USER_MASK : 0;
+	u32 access = (kvm_x86_get_cpl(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	unsigned offset;
 	int ret;
 
@@ -5287,7 +5287,7 @@ int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
 			       gva_t addr, void *val, unsigned int bytes,
 			       struct x86_exception *exception)
 {
-	u32 access = (kvm_x86_ops->get_cpl(vcpu) == 3) ? PFERR_USER_MASK : 0;
+	u32 access = (kvm_x86_get_cpl(vcpu) == 3) ? PFERR_USER_MASK : 0;
 
 	/*
 	 * FIXME: this should call handle_emulation_failure if X86EMUL_IO_NEEDED
@@ -5308,7 +5308,7 @@ static int emulator_read_std(struct x86_emulate_ctxt *ctxt,
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	u32 access = 0;
 
-	if (!system && kvm_x86_ops->get_cpl(vcpu) == 3)
+	if (!system && kvm_x86_get_cpl(vcpu) == 3)
 		access |= PFERR_USER_MASK;
 
 	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access, exception);
@@ -5361,7 +5361,7 @@ static int emulator_write_std(struct x86_emulate_ctxt *ctxt, gva_t addr, void *v
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	u32 access = PFERR_WRITE_MASK;
 
-	if (!system && kvm_x86_ops->get_cpl(vcpu) == 3)
+	if (!system && kvm_x86_get_cpl(vcpu) == 3)
 		access |= PFERR_USER_MASK;
 
 	return kvm_write_guest_virt_helper(addr, val, bytes, vcpu,
@@ -5429,7 +5429,7 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 				gpa_t *gpa, struct x86_exception *exception,
 				bool write)
 {
-	u32 access = ((kvm_x86_ops->get_cpl(vcpu) == 3) ? PFERR_USER_MASK : 0)
+	u32 access = ((kvm_x86_get_cpl(vcpu) == 3) ? PFERR_USER_MASK : 0)
 		| (write ? PFERR_WRITE_MASK : 0);
 
 	/*
@@ -5817,7 +5817,7 @@ static int emulator_pio_out_emulated(struct x86_emulate_ctxt *ctxt,
 
 static unsigned long get_segment_base(struct kvm_vcpu *vcpu, int seg)
 {
-	return kvm_x86_ops->get_segment_base(vcpu, seg);
+	return kvm_x86_get_segment_base(vcpu, seg);
 }
 
 static void emulator_invlpg(struct x86_emulate_ctxt *ctxt, ulong address)
@@ -5830,7 +5830,7 @@ static int kvm_emulate_wbinvd_noskip(struct kvm_vcpu *vcpu)
 	if (!need_emulate_wbinvd(vcpu))
 		return X86EMUL_CONTINUE;
 
-	if (kvm_x86_ops->has_wbinvd_exit()) {
+	if (kvm_x86_has_wbinvd_exit()) {
 		int cpu = get_cpu();
 
 		cpumask_set_cpu(cpu, vcpu->arch.wbinvd_dirty_mask);
@@ -5935,27 +5935,27 @@ static int emulator_set_cr(struct x86_emulate_ctxt *ctxt, int cr, ulong val)
 
 static int emulator_get_cpl(struct x86_emulate_ctxt *ctxt)
 {
-	return kvm_x86_ops->get_cpl(emul_to_vcpu(ctxt));
+	return kvm_x86_get_cpl(emul_to_vcpu(ctxt));
 }
 
 static void emulator_get_gdt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 {
-	kvm_x86_ops->get_gdt(emul_to_vcpu(ctxt), dt);
+	kvm_x86_get_gdt(emul_to_vcpu(ctxt), dt);
 }
 
 static void emulator_get_idt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 {
-	kvm_x86_ops->get_idt(emul_to_vcpu(ctxt), dt);
+	kvm_x86_get_idt(emul_to_vcpu(ctxt), dt);
 }
 
 static void emulator_set_gdt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 {
-	kvm_x86_ops->set_gdt(emul_to_vcpu(ctxt), dt);
+	kvm_x86_set_gdt(emul_to_vcpu(ctxt), dt);
 }
 
 static void emulator_set_idt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 {
-	kvm_x86_ops->set_idt(emul_to_vcpu(ctxt), dt);
+	kvm_x86_set_idt(emul_to_vcpu(ctxt), dt);
 }
 
 static unsigned long emulator_get_cached_segment_base(
@@ -6077,7 +6077,7 @@ static int emulator_intercept(struct x86_emulate_ctxt *ctxt,
 			      struct x86_instruction_info *info,
 			      enum x86_intercept_stage stage)
 {
-	return kvm_x86_ops->check_intercept(emul_to_vcpu(ctxt), info, stage);
+	return kvm_x86_check_intercept(emul_to_vcpu(ctxt), info, stage);
 }
 
 static bool emulator_get_cpuid(struct x86_emulate_ctxt *ctxt,
@@ -6098,7 +6098,7 @@ static void emulator_write_gpr(struct x86_emulate_ctxt *ctxt, unsigned reg, ulon
 
 static void emulator_set_nmi_mask(struct x86_emulate_ctxt *ctxt, bool masked)
 {
-	kvm_x86_ops->set_nmi_mask(emul_to_vcpu(ctxt), masked);
+	kvm_x86_set_nmi_mask(emul_to_vcpu(ctxt), masked);
 }
 
 static unsigned emulator_get_hflags(struct x86_emulate_ctxt *ctxt)
@@ -6114,7 +6114,7 @@ static void emulator_set_hflags(struct x86_emulate_ctxt *ctxt, unsigned emul_fla
 static int emulator_pre_leave_smm(struct x86_emulate_ctxt *ctxt,
 				  const char *smstate)
 {
-	return kvm_x86_ops->pre_leave_smm(emul_to_vcpu(ctxt), smstate);
+	return kvm_x86_pre_leave_smm(emul_to_vcpu(ctxt), smstate);
 }
 
 static void emulator_post_leave_smm(struct x86_emulate_ctxt *ctxt)
@@ -6173,7 +6173,7 @@ static const struct x86_emulate_ops emulate_ops = {
 
 static void toggle_interruptibility(struct kvm_vcpu *vcpu, u32 mask)
 {
-	u32 int_shadow = kvm_x86_ops->get_interrupt_shadow(vcpu);
+	u32 int_shadow = kvm_x86_get_interrupt_shadow(vcpu);
 	/*
 	 * an sti; sti; sequence only disable interrupts for the first
 	 * instruction. So, if the last instruction, be it emulated or
@@ -6184,7 +6184,7 @@ static void toggle_interruptibility(struct kvm_vcpu *vcpu, u32 mask)
 	if (int_shadow & mask)
 		mask = 0;
 	if (unlikely(int_shadow || mask)) {
-		kvm_x86_ops->set_interrupt_shadow(vcpu, mask);
+		kvm_x86_set_interrupt_shadow(vcpu, mask);
 		if (!mask)
 			kvm_make_request(KVM_REQ_EVENT, vcpu);
 	}
@@ -6209,7 +6209,7 @@ static void init_emulate_ctxt(struct kvm_vcpu *vcpu)
 	struct x86_emulate_ctxt *ctxt = &vcpu->arch.emulate_ctxt;
 	int cs_db, cs_l;
 
-	kvm_x86_ops->get_cs_db_l_bits(vcpu, &cs_db, &cs_l);
+	kvm_x86_get_cs_db_l_bits(vcpu, &cs_db, &cs_l);
 
 	ctxt->eflags = kvm_get_rflags(vcpu);
 	ctxt->tf = (ctxt->eflags & X86_EFLAGS_TF) != 0;
@@ -6261,7 +6261,7 @@ static int handle_emulation_failure(struct kvm_vcpu *vcpu, int emulation_type)
 	if (emulation_type & EMULTYPE_NO_UD_ON_FAIL)
 		return EMULATE_FAIL;
 
-	if (!is_guest_mode(vcpu) && kvm_x86_ops->get_cpl(vcpu) == 0) {
+	if (!is_guest_mode(vcpu) && kvm_x86_get_cpl(vcpu) == 0) {
 		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
 		vcpu->run->internal.ndata = 0;
@@ -6442,10 +6442,10 @@ static void kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu, int *r)
 
 int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
-	unsigned long rflags = kvm_x86_ops->get_rflags(vcpu);
+	unsigned long rflags = kvm_x86_get_rflags(vcpu);
 	int r;
 
-	r = kvm_x86_ops->skip_emulated_instruction(vcpu);
+	r = kvm_x86_skip_emulated_instruction(vcpu);
 	if (unlikely(r != EMULATE_DONE))
 		return 0;
 
@@ -6607,7 +6607,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
 		kvm_rip_write(vcpu, ctxt->_eip);
 		if (ctxt->eflags & X86_EFLAGS_RF)
 			kvm_set_rflags(vcpu, ctxt->eflags & ~X86_EFLAGS_RF);
-		kvm_x86_ops->set_interrupt_shadow(vcpu, 0);
+		kvm_x86_set_interrupt_shadow(vcpu, 0);
 		return EMULATE_DONE;
 	}
 
@@ -6662,7 +6662,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
 		r = EMULATE_DONE;
 
 	if (writeback) {
-		unsigned long rflags = kvm_x86_ops->get_rflags(vcpu);
+		unsigned long rflags = kvm_x86_get_rflags(vcpu);
 		toggle_interruptibility(vcpu, ctxt->interruptibility);
 		vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
 		if (!ctxt->have_exception ||
@@ -6998,7 +6998,7 @@ static int kvm_is_user_mode(void)
 	int user_mode = 3;
 
 	if (__this_cpu_read(current_vcpu))
-		user_mode = kvm_x86_ops->get_cpl(__this_cpu_read(current_vcpu));
+		user_mode = kvm_x86_get_cpl(__this_cpu_read(current_vcpu));
 
 	return user_mode != 0;
 }
@@ -7262,7 +7262,7 @@ void kvm_vcpu_deactivate_apicv(struct kvm_vcpu *vcpu)
 		return;
 
 	vcpu->arch.apicv_active = false;
-	kvm_x86_ops->refresh_apicv_exec_ctrl(vcpu);
+	kvm_x86_refresh_apicv_exec_ctrl(vcpu);
 }
 
 static void kvm_sched_yield(struct kvm *kvm, unsigned long dest_id)
@@ -7307,7 +7307,7 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 		a3 &= 0xFFFFFFFF;
 	}
 
-	if (kvm_x86_ops->get_cpl(vcpu) != 0) {
+	if (kvm_x86_get_cpl(vcpu) != 0) {
 		ret = -KVM_EPERM;
 		goto out;
 	}
@@ -7353,7 +7353,7 @@ static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt)
 	char instruction[3];
 	unsigned long rip = kvm_rip_read(vcpu);
 
-	kvm_x86_ops->patch_hypercall(vcpu, instruction);
+	kvm_x86_patch_hypercall(vcpu, instruction);
 
 	return emulator_write_emulated(ctxt, rip, instruction, 3,
 		&ctxt->exception);
@@ -7401,7 +7401,7 @@ static void update_cr8_intercept(struct kvm_vcpu *vcpu)
 
 	tpr = kvm_lapic_get_cr8(vcpu);
 
-	kvm_x86_ops->update_cr8_intercept(vcpu, tpr, max_irr);
+	kvm_x86_update_cr8_intercept(vcpu, tpr, max_irr);
 }
 
 static int inject_pending_event(struct kvm_vcpu *vcpu, bool req_int_win)
@@ -7411,7 +7411,7 @@ static int inject_pending_event(struct kvm_vcpu *vcpu, bool req_int_win)
 	/* try to reinject previous events if any */
 
 	if (vcpu->arch.exception.injected)
-		kvm_x86_ops->queue_exception(vcpu);
+		kvm_x86_queue_exception(vcpu);
 	/*
 	 * Do not inject an NMI or interrupt if there is a pending
 	 * exception.  Exceptions and interrupts are recognized at
@@ -7428,9 +7428,9 @@ static int inject_pending_event(struct kvm_vcpu *vcpu, bool req_int_win)
 	 */
 	else if (!vcpu->arch.exception.pending) {
 		if (vcpu->arch.nmi_injected)
-			kvm_x86_ops->set_nmi(vcpu);
+			kvm_x86_set_nmi(vcpu);
 		else if (vcpu->arch.interrupt.injected)
-			kvm_x86_ops->set_irq(vcpu);
+			kvm_x86_set_irq(vcpu);
 	}
 
 	/*
@@ -7440,7 +7440,7 @@ static int inject_pending_event(struct kvm_vcpu *vcpu, bool req_int_win)
 	 * from L2 to L1.
 	 */
 	if (is_guest_mode(vcpu) && kvm_x86_ops->check_nested_events) {
-		r = kvm_x86_ops->check_nested_events(vcpu, req_int_win);
+		r = kvm_x86_check_nested_events(vcpu, req_int_win);
 		if (r != 0)
 			return r;
 	}
@@ -7477,7 +7477,7 @@ static int inject_pending_event(struct kvm_vcpu *vcpu, bool req_int_win)
 			}
 		}
 
-		kvm_x86_ops->queue_exception(vcpu);
+		kvm_x86_queue_exception(vcpu);
 	}
 
 	/* Don't consider new event if we re-injected an event */
@@ -7485,14 +7485,14 @@ static int inject_pending_event(struct kvm_vcpu *vcpu, bool req_int_win)
 		return 0;
 
 	if (vcpu->arch.smi_pending && !is_smm(vcpu) &&
-	    kvm_x86_ops->smi_allowed(vcpu)) {
+	    kvm_x86_smi_allowed(vcpu)) {
 		vcpu->arch.smi_pending = false;
 		++vcpu->arch.smi_count;
 		enter_smm(vcpu);
-	} else if (vcpu->arch.nmi_pending && kvm_x86_ops->nmi_allowed(vcpu)) {
+	} else if (vcpu->arch.nmi_pending && kvm_x86_nmi_allowed(vcpu)) {
 		--vcpu->arch.nmi_pending;
 		vcpu->arch.nmi_injected = true;
-		kvm_x86_ops->set_nmi(vcpu);
+		kvm_x86_set_nmi(vcpu);
 	} else if (kvm_cpu_has_injectable_intr(vcpu)) {
 		/*
 		 * Because interrupts can be injected asynchronously, we are
@@ -7502,14 +7502,14 @@ static int inject_pending_event(struct kvm_vcpu *vcpu, bool req_int_win)
 		 * KVM_REQ_EVENT only on certain events and not unconditionally?
 		 */
 		if (is_guest_mode(vcpu) && kvm_x86_ops->check_nested_events) {
-			r = kvm_x86_ops->check_nested_events(vcpu, req_int_win);
+			r = kvm_x86_check_nested_events(vcpu, req_int_win);
 			if (r != 0)
 				return r;
 		}
-		if (kvm_x86_ops->interrupt_allowed(vcpu)) {
+		if (kvm_x86_interrupt_allowed(vcpu)) {
 			kvm_queue_interrupt(vcpu, kvm_cpu_get_interrupt(vcpu),
 					    false);
-			kvm_x86_ops->set_irq(vcpu);
+			kvm_x86_set_irq(vcpu);
 		}
 	}
 
@@ -7525,7 +7525,7 @@ static void process_nmi(struct kvm_vcpu *vcpu)
 	 * If an NMI is already in progress, limit further NMIs to just one.
 	 * Otherwise, allow two (and we'll inject the first one immediately).
 	 */
-	if (kvm_x86_ops->get_nmi_mask(vcpu) || vcpu->arch.nmi_injected)
+	if (kvm_x86_get_nmi_mask(vcpu) || vcpu->arch.nmi_injected)
 		limit = 1;
 
 	vcpu->arch.nmi_pending += atomic_xchg(&vcpu->arch.nmi_queued, 0);
@@ -7615,11 +7615,11 @@ static void enter_smm_save_state_32(struct kvm_vcpu *vcpu, char *buf)
 	put_smstate(u32, buf, 0x7f7c, seg.limit);
 	put_smstate(u32, buf, 0x7f78, enter_smm_get_segment_flags(&seg));
 
-	kvm_x86_ops->get_gdt(vcpu, &dt);
+	kvm_x86_get_gdt(vcpu, &dt);
 	put_smstate(u32, buf, 0x7f74, dt.address);
 	put_smstate(u32, buf, 0x7f70, dt.size);
 
-	kvm_x86_ops->get_idt(vcpu, &dt);
+	kvm_x86_get_idt(vcpu, &dt);
 	put_smstate(u32, buf, 0x7f58, dt.address);
 	put_smstate(u32, buf, 0x7f54, dt.size);
 
@@ -7669,7 +7669,7 @@ static void enter_smm_save_state_64(struct kvm_vcpu *vcpu, char *buf)
 	put_smstate(u32, buf, 0x7e94, seg.limit);
 	put_smstate(u64, buf, 0x7e98, seg.base);
 
-	kvm_x86_ops->get_idt(vcpu, &dt);
+	kvm_x86_get_idt(vcpu, &dt);
 	put_smstate(u32, buf, 0x7e84, dt.size);
 	put_smstate(u64, buf, 0x7e88, dt.address);
 
@@ -7679,7 +7679,7 @@ static void enter_smm_save_state_64(struct kvm_vcpu *vcpu, char *buf)
 	put_smstate(u32, buf, 0x7e74, seg.limit);
 	put_smstate(u64, buf, 0x7e78, seg.base);
 
-	kvm_x86_ops->get_gdt(vcpu, &dt);
+	kvm_x86_get_gdt(vcpu, &dt);
 	put_smstate(u32, buf, 0x7e64, dt.size);
 	put_smstate(u64, buf, 0x7e68, dt.address);
 
@@ -7709,28 +7709,28 @@ static void enter_smm(struct kvm_vcpu *vcpu)
 	 * vCPU state (e.g. leave guest mode) after we've saved the state into
 	 * the SMM state-save area.
 	 */
-	kvm_x86_ops->pre_enter_smm(vcpu, buf);
+	kvm_x86_pre_enter_smm(vcpu, buf);
 
 	vcpu->arch.hflags |= HF_SMM_MASK;
 	kvm_vcpu_write_guest(vcpu, vcpu->arch.smbase + 0xfe00, buf, sizeof(buf));
 
-	if (kvm_x86_ops->get_nmi_mask(vcpu))
+	if (kvm_x86_get_nmi_mask(vcpu))
 		vcpu->arch.hflags |= HF_SMM_INSIDE_NMI_MASK;
 	else
-		kvm_x86_ops->set_nmi_mask(vcpu, true);
+		kvm_x86_set_nmi_mask(vcpu, true);
 
 	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
 	kvm_rip_write(vcpu, 0x8000);
 
 	cr0 = vcpu->arch.cr0 & ~(X86_CR0_PE | X86_CR0_EM | X86_CR0_TS | X86_CR0_PG);
-	kvm_x86_ops->set_cr0(vcpu, cr0);
+	kvm_x86_set_cr0(vcpu, cr0);
 	vcpu->arch.cr0 = cr0;
 
-	kvm_x86_ops->set_cr4(vcpu, 0);
+	kvm_x86_set_cr4(vcpu, 0);
 
 	/* Undocumented: IDT limit is set to zero on entry to SMM.  */
 	dt.address = dt.size = 0;
-	kvm_x86_ops->set_idt(vcpu, &dt);
+	kvm_x86_set_idt(vcpu, &dt);
 
 	__kvm_set_dr(vcpu, 7, DR7_FIXED_1);
 
@@ -7761,7 +7761,7 @@ static void enter_smm(struct kvm_vcpu *vcpu)
 
 #ifdef CONFIG_X86_64
 	if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
-		kvm_x86_ops->set_efer(vcpu, 0);
+		kvm_x86_set_efer(vcpu, 0);
 #endif
 
 	kvm_update_cpuid(vcpu);
@@ -7790,7 +7790,7 @@ static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 		kvm_scan_ioapic_routes(vcpu, vcpu->arch.ioapic_handled_vectors);
 	else {
 		if (vcpu->arch.apicv_active)
-			kvm_x86_ops->sync_pir_to_irr(vcpu);
+			kvm_x86_sync_pir_to_irr(vcpu);
 		if (ioapic_in_kernel(vcpu->kvm))
 			kvm_ioapic_scan_entry(vcpu, vcpu->arch.ioapic_handled_vectors);
 	}
@@ -7810,7 +7810,7 @@ static void vcpu_load_eoi_exitmap(struct kvm_vcpu *vcpu)
 
 	bitmap_or((ulong *)eoi_exit_bitmap, vcpu->arch.ioapic_handled_vectors,
 		  vcpu_to_synic(vcpu)->vec_bitmap, 256);
-	kvm_x86_ops->load_eoi_exitmap(vcpu, eoi_exit_bitmap);
+	kvm_x86_load_eoi_exitmap(vcpu, eoi_exit_bitmap);
 }
 
 int kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
@@ -7843,7 +7843,7 @@ void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
 	page = gfn_to_page(vcpu->kvm, APIC_DEFAULT_PHYS_BASE >> PAGE_SHIFT);
 	if (is_error_page(page))
 		return;
-	kvm_x86_ops->set_apic_access_page_addr(vcpu, page_to_phys(page));
+	kvm_x86_set_apic_access_page_addr(vcpu, page_to_phys(page));
 
 	/*
 	 * Do not pin apic access page in memory, the MMU notifier
@@ -7875,7 +7875,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	if (kvm_request_pending(vcpu)) {
 		if (kvm_check_request(KVM_REQ_GET_VMCS12_PAGES, vcpu))
-			kvm_x86_ops->get_vmcs12_pages(vcpu);
+			kvm_x86_get_vmcs12_pages(vcpu);
 		if (kvm_check_request(KVM_REQ_MMU_RELOAD, vcpu))
 			kvm_mmu_unload(vcpu);
 		if (kvm_check_request(KVM_REQ_MIGRATE_TIMER, vcpu))
@@ -7993,12 +7993,12 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			 *    SMI.
 			 */
 			if (vcpu->arch.smi_pending && !is_smm(vcpu))
-				if (!kvm_x86_ops->enable_smi_window(vcpu))
+				if (!kvm_x86_enable_smi_window(vcpu))
 					req_immediate_exit = true;
 			if (vcpu->arch.nmi_pending)
-				kvm_x86_ops->enable_nmi_window(vcpu);
+				kvm_x86_enable_nmi_window(vcpu);
 			if (kvm_cpu_has_injectable_intr(vcpu) || req_int_win)
-				kvm_x86_ops->enable_irq_window(vcpu);
+				kvm_x86_enable_irq_window(vcpu);
 			WARN_ON(vcpu->arch.exception.pending);
 		}
 
@@ -8015,7 +8015,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	preempt_disable();
 
-	kvm_x86_ops->prepare_guest_switch(vcpu);
+	kvm_x86_prepare_guest_switch(vcpu);
 
 	/*
 	 * Disable IRQs before setting IN_GUEST_MODE.  Posted interrupt
@@ -8046,7 +8046,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 * notified with kvm_vcpu_kick.
 	 */
 	if (kvm_lapic_enabled(vcpu) && vcpu->arch.apicv_active)
-		kvm_x86_ops->sync_pir_to_irr(vcpu);
+		kvm_x86_sync_pir_to_irr(vcpu);
 
 	if (vcpu->mode == EXITING_GUEST_MODE || kvm_request_pending(vcpu)
 	    || need_resched() || signal_pending(current)) {
@@ -8061,7 +8061,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	if (req_immediate_exit) {
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
-		kvm_x86_ops->request_immediate_exit(vcpu);
+		kvm_x86_request_immediate_exit(vcpu);
 	}
 
 	trace_kvm_entry(vcpu->vcpu_id);
@@ -8080,7 +8080,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_RELOAD;
 	}
 
-	kvm_x86_ops->run(vcpu);
+	kvm_x86_run(vcpu);
 
 	/*
 	 * Do this here before restoring debug registers on the host.  And
@@ -8090,7 +8090,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 */
 	if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT)) {
 		WARN_ON(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP);
-		kvm_x86_ops->sync_dirty_debug_regs(vcpu);
+		kvm_x86_sync_dirty_debug_regs(vcpu);
 		kvm_update_dr0123(vcpu);
 		kvm_update_dr6(vcpu);
 		kvm_update_dr7(vcpu);
@@ -8112,7 +8112,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	vcpu->mode = OUTSIDE_GUEST_MODE;
 	smp_wmb();
 
-	kvm_x86_ops->handle_exit_irqoff(vcpu);
+	kvm_x86_handle_exit_irqoff(vcpu);
 
 	/*
 	 * Consume any pending interrupts, including the possible source of
@@ -8156,11 +8156,11 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		kvm_lapic_sync_from_vapic(vcpu);
 
 	vcpu->arch.gpa_available = false;
-	r = kvm_x86_ops->handle_exit(vcpu);
+	r = kvm_x86_handle_exit(vcpu);
 	return r;
 
 cancel_injection:
-	kvm_x86_ops->cancel_injection(vcpu);
+	kvm_x86_cancel_injection(vcpu);
 	if (unlikely(vcpu->arch.apic_attention))
 		kvm_lapic_sync_from_vapic(vcpu);
 out:
@@ -8170,13 +8170,13 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 static inline int vcpu_block(struct kvm *kvm, struct kvm_vcpu *vcpu)
 {
 	if (!kvm_arch_vcpu_runnable(vcpu) &&
-	    (!kvm_x86_ops->pre_block || kvm_x86_ops->pre_block(vcpu) == 0)) {
+	    (!kvm_x86_ops->pre_block || kvm_x86_pre_block(vcpu) == 0)) {
 		srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
 		kvm_vcpu_block(vcpu);
 		vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
 
 		if (kvm_x86_ops->post_block)
-			kvm_x86_ops->post_block(vcpu);
+			kvm_x86_post_block(vcpu);
 
 		if (!kvm_check_request(KVM_REQ_UNHALT, vcpu))
 			return 1;
@@ -8204,7 +8204,7 @@ static inline int vcpu_block(struct kvm *kvm, struct kvm_vcpu *vcpu)
 static inline bool kvm_vcpu_running(struct kvm_vcpu *vcpu)
 {
 	if (is_guest_mode(vcpu) && kvm_x86_ops->check_nested_events)
-		kvm_x86_ops->check_nested_events(vcpu, false);
+		kvm_x86_check_nested_events(vcpu, false);
 
 	return (vcpu->arch.mp_state == KVM_MP_STATE_RUNNABLE &&
 		!vcpu->arch.apf.halted);
@@ -8549,10 +8549,10 @@ static void __get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	kvm_get_segment(vcpu, &sregs->tr, VCPU_SREG_TR);
 	kvm_get_segment(vcpu, &sregs->ldt, VCPU_SREG_LDTR);
 
-	kvm_x86_ops->get_idt(vcpu, &dt);
+	kvm_x86_get_idt(vcpu, &dt);
 	sregs->idt.limit = dt.size;
 	sregs->idt.base = dt.address;
-	kvm_x86_ops->get_gdt(vcpu, &dt);
+	kvm_x86_get_gdt(vcpu, &dt);
 	sregs->gdt.limit = dt.size;
 	sregs->gdt.base = dt.address;
 
@@ -8693,10 +8693,10 @@ static int __set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 
 	dt.size = sregs->idt.limit;
 	dt.address = sregs->idt.base;
-	kvm_x86_ops->set_idt(vcpu, &dt);
+	kvm_x86_set_idt(vcpu, &dt);
 	dt.size = sregs->gdt.limit;
 	dt.address = sregs->gdt.base;
-	kvm_x86_ops->set_gdt(vcpu, &dt);
+	kvm_x86_set_gdt(vcpu, &dt);
 
 	vcpu->arch.cr2 = sregs->cr2;
 	mmu_reset_needed |= kvm_read_cr3(vcpu) != sregs->cr3;
@@ -8706,16 +8706,16 @@ static int __set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	kvm_set_cr8(vcpu, sregs->cr8);
 
 	mmu_reset_needed |= vcpu->arch.efer != sregs->efer;
-	kvm_x86_ops->set_efer(vcpu, sregs->efer);
+	kvm_x86_set_efer(vcpu, sregs->efer);
 
 	mmu_reset_needed |= kvm_read_cr0(vcpu) != sregs->cr0;
-	kvm_x86_ops->set_cr0(vcpu, sregs->cr0);
+	kvm_x86_set_cr0(vcpu, sregs->cr0);
 	vcpu->arch.cr0 = sregs->cr0;
 
 	mmu_reset_needed |= kvm_read_cr4(vcpu) != sregs->cr4;
 	cpuid_update_needed |= ((kvm_read_cr4(vcpu) ^ sregs->cr4) &
 				(X86_CR4_OSXSAVE | X86_CR4_PKE));
-	kvm_x86_ops->set_cr4(vcpu, sregs->cr4);
+	kvm_x86_set_cr4(vcpu, sregs->cr4);
 	if (cpuid_update_needed)
 		kvm_update_cpuid(vcpu);
 
@@ -8821,7 +8821,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	 */
 	kvm_set_rflags(vcpu, rflags);
 
-	kvm_x86_ops->update_bp_intercept(vcpu);
+	kvm_x86_update_bp_intercept(vcpu);
 
 	r = 0;
 
@@ -8955,7 +8955,7 @@ void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 
 	kvmclock_reset(vcpu);
 
-	kvm_x86_ops->vcpu_free(vcpu);
+	kvm_x86_vcpu_free(vcpu);
 	free_cpumask_var(wbinvd_dirty_mask);
 }
 
@@ -8969,7 +8969,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 		"kvm: SMP vm created on host with unstable TSC; "
 		"guest TSC will not be reliable\n");
 
-	vcpu = kvm_x86_ops->vcpu_create(kvm, id);
+	vcpu = kvm_x86_vcpu_create(kvm, id);
 
 	return vcpu;
 }
@@ -9022,7 +9022,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kvm_mmu_unload(vcpu);
 	vcpu_put(vcpu);
 
-	kvm_x86_ops->vcpu_free(vcpu);
+	kvm_x86_vcpu_free(vcpu);
 }
 
 void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
@@ -9095,7 +9095,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 
 	vcpu->arch.ia32_xss = 0;
 
-	kvm_x86_ops->vcpu_reset(vcpu, init_event);
+	kvm_x86_vcpu_reset(vcpu, init_event);
 }
 
 void kvm_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
@@ -9120,7 +9120,7 @@ int kvm_arch_hardware_enable(void)
 	bool stable, backwards_tsc = false;
 
 	kvm_shared_msr_cpu_online();
-	ret = kvm_x86_ops->hardware_enable();
+	ret = kvm_x86_hardware_enable();
 	if (ret != 0)
 		return ret;
 
@@ -9202,7 +9202,7 @@ int kvm_arch_hardware_enable(void)
 
 void kvm_arch_hardware_disable(void)
 {
-	kvm_x86_ops->hardware_disable();
+	kvm_x86_hardware_disable();
 	drop_user_return_notifiers();
 }
 
@@ -9210,7 +9210,7 @@ int kvm_arch_hardware_setup(void)
 {
 	int r;
 
-	r = kvm_x86_ops->hardware_setup();
+	r = kvm_x86_hardware_setup();
 	if (r != 0)
 		return r;
 
@@ -9234,12 +9234,12 @@ int kvm_arch_hardware_setup(void)
 
 void kvm_arch_hardware_unsetup(void)
 {
-	kvm_x86_ops->hardware_unsetup();
+	kvm_x86_hardware_unsetup();
 }
 
 int kvm_arch_check_processor_compat(void)
 {
-	return kvm_x86_ops->check_processor_compatibility();
+	return kvm_x86_check_processor_compatibility();
 }
 
 bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu)
@@ -9281,7 +9281,7 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 		goto fail_free_pio_data;
 
 	if (irqchip_in_kernel(vcpu->kvm)) {
-		vcpu->arch.apicv_active = kvm_x86_ops->get_enable_apicv(vcpu);
+		vcpu->arch.apicv_active = kvm_x86_get_enable_apicv(vcpu);
 		r = kvm_create_lapic(vcpu, lapic_timer_advance_ns);
 		if (r < 0)
 			goto fail_mmu_destroy;
@@ -9351,7 +9351,7 @@ void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
 void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu)
 {
 	vcpu->arch.l1tf_flush_l1d = true;
-	kvm_x86_ops->sched_in(vcpu, cpu);
+	kvm_x86_sched_in(vcpu, cpu);
 }
 
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
@@ -9386,7 +9386,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm_page_track_init(kvm);
 	kvm_mmu_init_vm(kvm);
 
-	return kvm_x86_ops->vm_init(kvm);
+	return kvm_x86_vm_init(kvm);
 }
 
 static void kvm_unload_vcpu_mmu(struct kvm_vcpu *vcpu)
@@ -9503,7 +9503,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 		x86_set_memory_region(kvm, TSS_PRIVATE_MEMSLOT, 0, 0);
 	}
 	if (kvm_x86_ops->vm_destroy)
-		kvm_x86_ops->vm_destroy(kvm);
+		kvm_x86_vm_destroy(kvm);
 	kvm_pic_destroy(kvm);
 	kvm_ioapic_destroy(kvm);
 	kvm_free_vcpus(kvm);
@@ -9660,12 +9660,12 @@ static void kvm_mmu_slot_apply_flags(struct kvm *kvm,
 	 */
 	if (new->flags & KVM_MEM_LOG_DIRTY_PAGES) {
 		if (kvm_x86_ops->slot_enable_log_dirty)
-			kvm_x86_ops->slot_enable_log_dirty(kvm, new);
+			kvm_x86_slot_enable_log_dirty(kvm, new);
 		else
 			kvm_mmu_slot_remove_write_access(kvm, new);
 	} else {
 		if (kvm_x86_ops->slot_disable_log_dirty)
-			kvm_x86_ops->slot_disable_log_dirty(kvm, new);
+			kvm_x86_slot_disable_log_dirty(kvm, new);
 	}
 }
 
@@ -9725,7 +9725,7 @@ static inline bool kvm_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
 {
 	return (is_guest_mode(vcpu) &&
 			kvm_x86_ops->guest_apic_has_interrupt &&
-			kvm_x86_ops->guest_apic_has_interrupt(vcpu));
+			kvm_x86_guest_apic_has_interrupt(vcpu));
 }
 
 static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
@@ -9744,7 +9744,7 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 
 	if (kvm_test_request(KVM_REQ_NMI, vcpu) ||
 	    (vcpu->arch.nmi_pending &&
-	     kvm_x86_ops->nmi_allowed(vcpu)))
+	     kvm_x86_nmi_allowed(vcpu)))
 		return true;
 
 	if (kvm_test_request(KVM_REQ_SMI, vcpu) ||
@@ -9777,7 +9777,7 @@ bool kvm_arch_dy_runnable(struct kvm_vcpu *vcpu)
 		 kvm_test_request(KVM_REQ_EVENT, vcpu))
 		return true;
 
-	if (vcpu->arch.apicv_active && kvm_x86_ops->dy_apicv_has_pending_interrupt(vcpu))
+	if (vcpu->arch.apicv_active && kvm_x86_dy_apicv_has_pending_interrupt(vcpu))
 		return true;
 
 	return false;
@@ -9795,7 +9795,7 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 
 int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu)
 {
-	return kvm_x86_ops->interrupt_allowed(vcpu);
+	return kvm_x86_interrupt_allowed(vcpu);
 }
 
 unsigned long kvm_get_linear_rip(struct kvm_vcpu *vcpu)
@@ -9817,7 +9817,7 @@ unsigned long kvm_get_rflags(struct kvm_vcpu *vcpu)
 {
 	unsigned long rflags;
 
-	rflags = kvm_x86_ops->get_rflags(vcpu);
+	rflags = kvm_x86_get_rflags(vcpu);
 	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)
 		rflags &= ~X86_EFLAGS_TF;
 	return rflags;
@@ -9829,7 +9829,7 @@ static void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
 	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP &&
 	    kvm_is_linear_rip(vcpu, vcpu->arch.singlestep_rip))
 		rflags |= X86_EFLAGS_TF;
-	kvm_x86_ops->set_rflags(vcpu, rflags);
+	kvm_x86_set_rflags(vcpu, rflags);
 }
 
 void kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
@@ -9940,7 +9940,7 @@ static bool kvm_can_deliver_async_pf(struct kvm_vcpu *vcpu)
 
 	if (!(vcpu->arch.apf.msr_val & KVM_ASYNC_PF_ENABLED) ||
 	    (vcpu->arch.apf.send_user_only &&
-	     kvm_x86_ops->get_cpl(vcpu) == 0))
+	     kvm_x86_get_cpl(vcpu) == 0))
 		return false;
 
 	return true;
@@ -9960,7 +9960,7 @@ bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu)
 	 * If interrupts are off we cannot even use an artificial
 	 * halt state.
 	 */
-	return kvm_x86_ops->interrupt_allowed(vcpu);
+	return kvm_x86_interrupt_allowed(vcpu);
 }
 
 void kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
@@ -10089,7 +10089,7 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
 
 	irqfd->producer = prod;
 
-	return kvm_x86_ops->update_pi_irte(irqfd->kvm,
+	return kvm_x86_update_pi_irte(irqfd->kvm,
 					   prod->irq, irqfd->gsi, 1);
 }
 
@@ -10109,7 +10109,7 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	 * when the irq is masked/disabled or the consumer side (KVM
 	 * int this case doesn't want to receive the interrupts.
 	*/
-	ret = kvm_x86_ops->update_pi_irte(irqfd->kvm, prod->irq, irqfd->gsi, 0);
+	ret = kvm_x86_update_pi_irte(irqfd->kvm, prod->irq, irqfd->gsi, 0);
 	if (ret)
 		printk(KERN_INFO "irq bypass consumer (token %p) unregistration"
 		       " fails: %d\n", irqfd->consumer.token, ret);
@@ -10118,7 +10118,7 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 int kvm_arch_update_irqfd_routing(struct kvm *kvm, unsigned int host_irq,
 				   uint32_t guest_irq, bool set)
 {
-	return kvm_x86_ops->update_pi_irte(kvm, host_irq, guest_irq, set);
+	return kvm_x86_update_pi_irte(kvm, host_irq, guest_irq, set);
 }
 
 bool kvm_vector_hashing_enabled(void)
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index b5274e2a53cf..a7cd551cd982 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -96,7 +96,7 @@ static inline bool is_64_bit_mode(struct kvm_vcpu *vcpu)
 
 	if (!is_long_mode(vcpu))
 		return false;
-	kvm_x86_ops->get_cs_db_l_bits(vcpu, &cs_db, &cs_l);
+	kvm_x86_get_cs_db_l_bits(vcpu, &cs_db, &cs_l);
 	return cs_l;
 }
 
