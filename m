Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEBFCA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A28A20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXi2QqG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbfKDXAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 18:00:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57890 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730157AbfKDXA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572908416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YIiSAoubbXvaT4WmNUiB9DFZfGZKGspCyVHntnjgB2s=;
        b=JXi2QqG0jwrmAhynrQ5rDO0BXnqOp8iI86pSBmAq1OMj12E8Y4s9VG8XzYDNr/ttTwjUuR
        kJHkGAAMwMt9K5/5mRucDpJ1GOc9Fkd4Ue6+WrOlEuu9RGUUtYdHJg/1N4IZ+H08YkLv2L
        T08KhlDpbbYPnqHqzaOq3mS+iDBGd3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-TCdEQuHvP6G0z6vPq-frXw-1; Mon, 04 Nov 2019 18:00:13 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BA8D6BF;
        Mon,  4 Nov 2019 23:00:12 +0000 (UTC)
Received: from mail (ovpn-121-157.rdu2.redhat.com [10.10.121.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB8EB1001B35;
        Mon,  4 Nov 2019 23:00:02 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 02/13] KVM: monolithic: x86: convert the kvm_x86_ops and kvm_pmu_ops methods to external functions
Date:   Mon,  4 Nov 2019 17:59:50 -0500
Message-Id: <20191104230001.27774-3-aarcange@redhat.com>
In-Reply-To: <20191104230001.27774-1-aarcange@redhat.com>
References: <20191104230001.27774-1-aarcange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: TCdEQuHvP6G0z6vPq-frXw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This replaces all kvm_x86_ops and kvm_pmu_ops pointer to functions
with regular external functions that don't require indirect calls.

In practice this optimization results in a double digit percent
reduction in the vmexit latency with the default retpoline spectre v2
mitigation enabled in the host.

When the host is booted with spectre_v2=3Doff this still results in a
best case measurable improvement up to 2% that varies wildly depending
on the CPU vendor implementation under high frequency timer guest
workloads. Possibly guest userland workloads stressing the BTB might
see an improvement even on CPUs where the vmexit latency isn't reduced
with all mitigations disabled.

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
 arch/x86/include/asm/kvm_host.h | 203 ++++++++-
 arch/x86/kvm/cpuid.c            |  22 +-
 arch/x86/kvm/hyperv.c           |   6 +-
 arch/x86/kvm/kvm_cache_regs.h   |  10 +-
 arch/x86/kvm/lapic.c            |  30 +-
 arch/x86/kvm/mmu.c              |  26 +-
 arch/x86/kvm/mmu.h              |   4 +-
 arch/x86/kvm/pmu.c              |  24 +-
 arch/x86/kvm/pmu.h              |  19 +-
 arch/x86/kvm/pmu_amd.c          |  52 +--
 arch/x86/kvm/svm.c              | 664 ++++++++++++++++------------
 arch/x86/kvm/trace.h            |   4 +-
 arch/x86/kvm/vmx/nested.c       |  84 ++--
 arch/x86/kvm/vmx/pmu_intel.c    |  55 ++-
 arch/x86/kvm/vmx/vmx.c          | 739 ++++++++++++++++++--------------
 arch/x86/kvm/vmx/vmx.h          |  39 +-
 arch/x86/kvm/x86.c              | 308 ++++++-------
 arch/x86/kvm/x86.h              |   2 +-
 18 files changed, 1361 insertions(+), 930 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index 24d6598dea29..b36dd3265036 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -998,6 +998,197 @@ struct kvm_lapic_irq {
 =09bool msi_redir_hint;
 };
=20
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
+extern void kvm_x86_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment =
*var,
+=09=09=09=09int seg);
+extern int kvm_x86_get_cpl(struct kvm_vcpu *vcpu);
+extern void kvm_x86_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment =
*var,
+=09=09=09=09int seg);
+extern void kvm_x86_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *=
l);
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
+extern void kvm_x86_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags=
);
+extern void kvm_x86_tlb_flush(struct kvm_vcpu *vcpu, bool invalidate_gpa);
+extern int kvm_x86_tlb_remote_flush(struct kvm *kvm);
+extern int kvm_x86_tlb_remote_flush_with_range(struct kvm *kvm,
+=09=09=09=09=09       struct kvm_tlb_range *range);
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
+=09=09=09=09    unsigned char *hypercall_addr);
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
+=09=09=09=09=09 int irr);
+extern bool kvm_x86_get_enable_apicv(struct kvm_vcpu *vcpu);
+extern void kvm_x86_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu);
+extern void kvm_x86_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr);
+extern void kvm_x86_hwapic_isr_update(struct kvm_vcpu *vcpu, int isr);
+extern bool kvm_x86_guest_apic_has_interrupt(struct kvm_vcpu *vcpu);
+extern void kvm_x86_load_eoi_exitmap(struct kvm_vcpu *vcpu,
+=09=09=09=09     u64 *eoi_exit_bitmap);
+extern void kvm_x86_set_virtual_apic_mode(struct kvm_vcpu *vcpu);
+extern void kvm_x86_set_apic_access_page_addr(struct kvm_vcpu *vcpu,
+=09=09=09=09=09      hpa_t hpa);
+extern void kvm_x86_deliver_posted_interrupt(struct kvm_vcpu *vcpu,
+=09=09=09=09=09     int vector);
+extern int kvm_x86_sync_pir_to_irr(struct kvm_vcpu *vcpu);
+extern int kvm_x86_set_tss_addr(struct kvm *kvm, unsigned int addr);
+extern int kvm_x86_set_identity_map_addr(struct kvm *kvm, u64 ident_addr);
+extern int kvm_x86_get_tdp_level(struct kvm_vcpu *vcpu);
+extern u64 kvm_x86_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_m=
mio);
+extern int kvm_x86_get_lpage_level(void);
+extern bool kvm_x86_rdtscp_supported(void);
+extern bool kvm_x86_invpcid_supported(void);
+extern void kvm_x86_set_tdp_cr3(struct kvm_vcpu *vcpu, unsigned long cr3);
+extern void kvm_x86_set_supported_cpuid(u32 func,
+=09=09=09=09=09struct kvm_cpuid_entry2 *entry);
+extern bool kvm_x86_has_wbinvd_exit(void);
+extern u64 kvm_x86_read_l1_tsc_offset(struct kvm_vcpu *vcpu);
+/* Returns actual tsc_offset set in active VMCS */
+extern u64 kvm_x86_write_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 offset);
+extern void kvm_x86_get_exit_info(struct kvm_vcpu *vcpu, u64 *info1,
+=09=09=09=09  u64 *info2);
+extern int kvm_x86_check_intercept(struct kvm_vcpu *vcpu,
+=09=09=09=09   struct x86_instruction_info *info,
+=09=09=09=09   enum x86_intercept_stage stage);
+extern void kvm_x86_handle_exit_irqoff(struct kvm_vcpu *vcpu);
+extern bool kvm_x86_mpx_supported(void);
+extern bool kvm_x86_xsaves_supported(void);
+extern bool kvm_x86_umip_emulated(void);
+extern bool kvm_x86_pt_supported(void);
+extern int kvm_x86_check_nested_events(struct kvm_vcpu *vcpu,
+=09=09=09=09       bool external_intr);
+extern void kvm_x86_request_immediate_exit(struct kvm_vcpu *vcpu);
+extern void kvm_x86_sched_in(struct kvm_vcpu *kvm, int cpu);
+/*
+ * Arch-specific dirty logging hooks. These hooks are only supposed to
+ * be valid if the specific arch has hardware-accelerated dirty logging
+ * mechanism. Currently only for PML on VMX.
+ *
+ *  - slot_enable_log_dirty:
+ *=09called when enabling log dirty mode for the slot.
+ *  - slot_disable_log_dirty:
+ *=09called when disabling log dirty mode for the slot.
+ *=09also called when slot is created with log dirty disabled.
+ *  - flush_log_dirty:
+ *=09called before reporting dirty_bitmap to userspace.
+ *  - enable_log_dirty_pt_masked:
+ *=09called when reenabling log dirty for the GFNs in the mask after
+ *=09corresponding bits are cleared in slot->dirty_bitmap.
+ */
+extern void kvm_x86_slot_enable_log_dirty(struct kvm *kvm,
+=09=09=09=09=09  struct kvm_memory_slot *slot);
+extern void kvm_x86_slot_disable_log_dirty(struct kvm *kvm,
+=09=09=09=09=09   struct kvm_memory_slot *slot);
+extern void kvm_x86_flush_log_dirty(struct kvm *kvm);
+extern void kvm_x86_enable_log_dirty_pt_masked(struct kvm *kvm,
+=09=09=09=09=09       struct kvm_memory_slot *slot,
+=09=09=09=09=09       gfn_t offset,
+=09=09=09=09=09       unsigned long mask);
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
+=09=09=09=09  uint32_t guest_irq, bool set);
+extern void kvm_x86_apicv_post_state_restore(struct kvm_vcpu *vcpu);
+extern bool kvm_x86_dy_apicv_has_pending_interrupt(struct kvm_vcpu *vcpu);
+extern int kvm_x86_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_=
tsc,
+=09=09=09=09bool *expired);
+extern void kvm_x86_cancel_hv_timer(struct kvm_vcpu *vcpu);
+extern void kvm_x86_setup_mce(struct kvm_vcpu *vcpu);
+extern int kvm_x86_get_nested_state(struct kvm_vcpu *vcpu,
+=09=09=09=09    struct kvm_nested_state __user *user_kvm_nested_state,
+=09=09=09=09    unsigned user_data_size);
+extern int kvm_x86_set_nested_state(struct kvm_vcpu *vcpu,
+=09=09=09=09    struct kvm_nested_state __user *user_kvm_nested_state,
+=09=09=09=09    struct kvm_nested_state *kvm_state);
+extern bool kvm_x86_get_vmcs12_pages(struct kvm_vcpu *vcpu);
+extern int kvm_x86_smi_allowed(struct kvm_vcpu *vcpu);
+extern int kvm_x86_pre_enter_smm(struct kvm_vcpu *vcpu, char *smstate);
+extern int kvm_x86_pre_leave_smm(struct kvm_vcpu *vcpu, const char *smstat=
e);
+extern int kvm_x86_enable_smi_window(struct kvm_vcpu *vcpu);
+extern int kvm_x86_mem_enc_op(struct kvm *kvm, void __user *argp);
+extern int kvm_x86_mem_enc_reg_region(struct kvm *kvm,
+=09=09=09=09      struct kvm_enc_region *argp);
+extern int kvm_x86_mem_enc_unreg_region(struct kvm *kvm,
+=09=09=09=09=09struct kvm_enc_region *argp);
+extern int kvm_x86_get_msr_feature(struct kvm_msr_entry *entry);
+extern int kvm_x86_nested_enable_evmcs(struct kvm_vcpu *vcpu,
+=09=09=09=09       uint16_t *vmcs_version);
+extern uint16_t kvm_x86_nested_get_evmcs_version(struct kvm_vcpu *vcpu);
+extern bool kvm_x86_need_emulation_on_page_fault(struct kvm_vcpu *vcpu);
+extern bool kvm_x86_apic_init_signal_blocked(struct kvm_vcpu *vcpu);
+extern int kvm_x86_enable_direct_tlbflush(struct kvm_vcpu *vcpu);
+
 struct kvm_x86_ops {
 =09int (*cpu_has_kvm_support)(void);          /* __init */
 =09int (*disabled_by_bios)(void);             /* __init */
@@ -1225,19 +1416,19 @@ extern struct kmem_cache *x86_fpu_cache;
 #define __KVM_HAVE_ARCH_VM_ALLOC
 static inline struct kvm *kvm_arch_alloc_vm(void)
 {
-=09return kvm_x86_ops->vm_alloc();
+=09return kvm_x86_vm_alloc();
 }
=20
 static inline void kvm_arch_free_vm(struct kvm *kvm)
 {
-=09return kvm_x86_ops->vm_free(kvm);
+=09return kvm_x86_vm_free(kvm);
 }
=20
 #define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLB
 static inline int kvm_arch_flush_remote_tlb(struct kvm *kvm)
 {
 =09if (kvm_x86_ops->tlb_remote_flush &&
-=09    !kvm_x86_ops->tlb_remote_flush(kvm))
+=09    !kvm_x86_tlb_remote_flush(kvm))
 =09=09return 0;
 =09else
 =09=09return -ENOTSUPP;
@@ -1322,7 +1513,7 @@ extern u64 kvm_mce_cap_supported;
  *
  * EMULTYPE_SKIP - Set when emulating solely to skip an instruction, i.e. =
to
  *=09=09   decode the instruction length.  For use *only* by
- *=09=09   kvm_x86_ops->skip_emulated_instruction() implementations.
+ *=09=09   kvm_x86_skip_emulated_instruction() implementations.
  *
  * EMULTYPE_ALLOW_RETRY - Set when the emulator should resume the guest to
  *=09=09=09  retry native execution under certain conditions.
@@ -1608,13 +1799,13 @@ static inline bool kvm_irq_is_postable(struct kvm_l=
apic_irq *irq)
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
 {
 =09if (kvm_x86_ops->vcpu_blocking)
-=09=09kvm_x86_ops->vcpu_blocking(vcpu);
+=09=09kvm_x86_vcpu_blocking(vcpu);
 }
=20
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
 =09if (kvm_x86_ops->vcpu_unblocking)
-=09=09kvm_x86_ops->vcpu_unblocking(vcpu);
+=09=09kvm_x86_vcpu_unblocking(vcpu);
 }
=20
 static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index f68c0c753c38..d156d27d83bb 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -48,7 +48,7 @@ static u32 xstate_required_size(u64 xstate_bv, bool compa=
cted)
 bool kvm_mpx_supported(void)
 {
 =09return ((host_xcr0 & (XFEATURE_MASK_BNDREGS | XFEATURE_MASK_BNDCSR))
-=09=09 && kvm_x86_ops->mpx_supported());
+=09=09 && kvm_x86_mpx_supported());
 }
 EXPORT_SYMBOL_GPL(kvm_mpx_supported);
=20
@@ -232,7 +232,7 @@ int kvm_vcpu_ioctl_set_cpuid(struct kvm_vcpu *vcpu,
 =09vcpu->arch.cpuid_nent =3D cpuid->nent;
 =09cpuid_fix_nx_cap(vcpu);
 =09kvm_apic_set_version(vcpu);
-=09kvm_x86_ops->cpuid_update(vcpu);
+=09kvm_x86_cpuid_update(vcpu);
 =09r =3D kvm_update_cpuid(vcpu);
=20
 out:
@@ -255,7 +255,7 @@ int kvm_vcpu_ioctl_set_cpuid2(struct kvm_vcpu *vcpu,
 =09=09goto out;
 =09vcpu->arch.cpuid_nent =3D cpuid->nent;
 =09kvm_apic_set_version(vcpu);
-=09kvm_x86_ops->cpuid_update(vcpu);
+=09kvm_x86_cpuid_update(vcpu);
 =09r =3D kvm_update_cpuid(vcpu);
 out:
 =09return r;
@@ -347,10 +347,10 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_=
entry2 *entry,
=20
 static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry, int ind=
ex)
 {
-=09unsigned f_invpcid =3D kvm_x86_ops->invpcid_supported() ? F(INVPCID) : =
0;
+=09unsigned f_invpcid =3D kvm_x86_invpcid_supported() ? F(INVPCID) : 0;
 =09unsigned f_mpx =3D kvm_mpx_supported() ? F(MPX) : 0;
-=09unsigned f_umip =3D kvm_x86_ops->umip_emulated() ? F(UMIP) : 0;
-=09unsigned f_intel_pt =3D kvm_x86_ops->pt_supported() ? F(INTEL_PT) : 0;
+=09unsigned f_umip =3D kvm_x86_umip_emulated() ? F(UMIP) : 0;
+=09unsigned f_intel_pt =3D kvm_x86_pt_supported() ? F(INTEL_PT) : 0;
 =09unsigned f_la57;
=20
 =09/* cpuid 7.0.ebx */
@@ -432,16 +432,16 @@ static inline int __do_cpuid_func(struct kvm_cpuid_en=
try2 *entry, u32 function,
 =09int r;
 =09unsigned f_nx =3D is_efer_nx() ? F(NX) : 0;
 #ifdef CONFIG_X86_64
-=09unsigned f_gbpages =3D (kvm_x86_ops->get_lpage_level() =3D=3D PT_PDPE_L=
EVEL)
+=09unsigned f_gbpages =3D (kvm_x86_get_lpage_level() =3D=3D PT_PDPE_LEVEL)
 =09=09=09=09? F(GBPAGES) : 0;
 =09unsigned f_lm =3D F(LM);
 #else
 =09unsigned f_gbpages =3D 0;
 =09unsigned f_lm =3D 0;
 #endif
-=09unsigned f_rdtscp =3D kvm_x86_ops->rdtscp_supported() ? F(RDTSCP) : 0;
-=09unsigned f_xsaves =3D kvm_x86_ops->xsaves_supported() ? F(XSAVES) : 0;
-=09unsigned f_intel_pt =3D kvm_x86_ops->pt_supported() ? F(INTEL_PT) : 0;
+=09unsigned f_rdtscp =3D kvm_x86_rdtscp_supported() ? F(RDTSCP) : 0;
+=09unsigned f_xsaves =3D kvm_x86_xsaves_supported() ? F(XSAVES) : 0;
+=09unsigned f_intel_pt =3D kvm_x86_pt_supported() ? F(INTEL_PT) : 0;
=20
 =09/* cpuid 1.edx */
 =09const u32 kvm_cpuid_1_edx_x86_features =3D
@@ -797,7 +797,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entr=
y2 *entry, u32 function,
 =09=09break;
 =09}
=20
-=09kvm_x86_ops->set_supported_cpuid(function, entry);
+=09kvm_x86_set_supported_cpuid(function, entry);
=20
 =09r =3D 0;
=20
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 23ff65504d7e..a345e48a7a24 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1018,7 +1018,7 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u=
32 msr, u64 data,
 =09=09addr =3D gfn_to_hva(kvm, gfn);
 =09=09if (kvm_is_error_hva(addr))
 =09=09=09return 1;
-=09=09kvm_x86_ops->patch_hypercall(vcpu, instructions);
+=09=09kvm_x86_patch_hypercall(vcpu, instructions);
 =09=09((unsigned char *)instructions)[3] =3D 0xc3; /* ret */
 =09=09if (__copy_to_user((void __user *)addr, instructions, 4))
 =09=09=09return 1;
@@ -1603,7 +1603,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 =09 * hypercall generates UD from non zero cpl and real mode
 =09 * per HYPER-V spec
 =09 */
-=09if (kvm_x86_ops->get_cpl(vcpu) !=3D 0 || !is_protmode(vcpu)) {
+=09if (kvm_x86_get_cpl(vcpu) !=3D 0 || !is_protmode(vcpu)) {
 =09=09kvm_queue_exception(vcpu, UD_VECTOR);
 =09=09return 1;
 =09}
@@ -1797,7 +1797,7 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu=
, struct kvm_cpuid2 *cpuid,
 =09int i, nent =3D ARRAY_SIZE(cpuid_entries);
=20
 =09if (kvm_x86_ops->nested_get_evmcs_version)
-=09=09evmcs_ver =3D kvm_x86_ops->nested_get_evmcs_version(vcpu);
+=09=09evmcs_ver =3D kvm_x86_nested_get_evmcs_version(vcpu);
=20
 =09/* Skip NESTED_FEATURES if eVMCS is not supported */
 =09if (!evmcs_ver)
diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 1cc6c47dc77e..5904f4fd1e15 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -41,7 +41,7 @@ static inline unsigned long kvm_register_read(struct kvm_=
vcpu *vcpu,
 =09=09=09=09=09      enum kvm_reg reg)
 {
 =09if (!test_bit(reg, (unsigned long *)&vcpu->arch.regs_avail))
-=09=09kvm_x86_ops->cache_reg(vcpu, reg);
+=09=09kvm_x86_cache_reg(vcpu, reg);
=20
 =09return vcpu->arch.regs[reg];
 }
@@ -81,7 +81,7 @@ static inline u64 kvm_pdptr_read(struct kvm_vcpu *vcpu, i=
nt index)
=20
 =09if (!test_bit(VCPU_EXREG_PDPTR,
 =09=09      (unsigned long *)&vcpu->arch.regs_avail))
-=09=09kvm_x86_ops->cache_reg(vcpu, (enum kvm_reg)VCPU_EXREG_PDPTR);
+=09=09kvm_x86_cache_reg(vcpu, (enum kvm_reg)VCPU_EXREG_PDPTR);
=20
 =09return vcpu->arch.walk_mmu->pdptrs[index];
 }
@@ -90,7 +90,7 @@ static inline ulong kvm_read_cr0_bits(struct kvm_vcpu *vc=
pu, ulong mask)
 {
 =09ulong tmask =3D mask & KVM_POSSIBLE_CR0_GUEST_BITS;
 =09if (tmask & vcpu->arch.cr0_guest_owned_bits)
-=09=09kvm_x86_ops->decache_cr0_guest_bits(vcpu);
+=09=09kvm_x86_decache_cr0_guest_bits(vcpu);
 =09return vcpu->arch.cr0 & mask;
 }
=20
@@ -103,14 +103,14 @@ static inline ulong kvm_read_cr4_bits(struct kvm_vcpu=
 *vcpu, ulong mask)
 {
 =09ulong tmask =3D mask & KVM_POSSIBLE_CR4_GUEST_BITS;
 =09if (tmask & vcpu->arch.cr4_guest_owned_bits)
-=09=09kvm_x86_ops->decache_cr4_guest_bits(vcpu);
+=09=09kvm_x86_decache_cr4_guest_bits(vcpu);
 =09return vcpu->arch.cr4 & mask;
 }
=20
 static inline ulong kvm_read_cr3(struct kvm_vcpu *vcpu)
 {
 =09if (!test_bit(VCPU_EXREG_CR3, (ulong *)&vcpu->arch.regs_avail))
-=09=09kvm_x86_ops->decache_cr3(vcpu);
+=09=09kvm_x86_decache_cr3(vcpu);
 =09return vcpu->arch.cr3;
 }
=20
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index b29d00b661ff..22c1079fadaa 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -451,7 +451,7 @@ static inline void apic_clear_irr(int vec, struct kvm_l=
apic *apic)
 =09if (unlikely(vcpu->arch.apicv_active)) {
 =09=09/* need to update RVI */
 =09=09kvm_lapic_clear_vector(vec, apic->regs + APIC_IRR);
-=09=09kvm_x86_ops->hwapic_irr_update(vcpu,
+=09=09kvm_x86_hwapic_irr_update(vcpu,
 =09=09=09=09apic_find_highest_irr(apic));
 =09} else {
 =09=09apic->irr_pending =3D false;
@@ -476,7 +476,7 @@ static inline void apic_set_isr(int vec, struct kvm_lap=
ic *apic)
 =09 * just set SVI.
 =09 */
 =09if (unlikely(vcpu->arch.apicv_active))
-=09=09kvm_x86_ops->hwapic_isr_update(vcpu, vec);
+=09=09kvm_x86_hwapic_isr_update(vcpu, vec);
 =09else {
 =09=09++apic->isr_count;
 =09=09BUG_ON(apic->isr_count > MAX_APIC_VECTOR);
@@ -524,7 +524,7 @@ static inline void apic_clear_isr(int vec, struct kvm_l=
apic *apic)
 =09 * and must be left alone.
 =09 */
 =09if (unlikely(vcpu->arch.apicv_active))
-=09=09kvm_x86_ops->hwapic_isr_update(vcpu,
+=09=09kvm_x86_hwapic_isr_update(vcpu,
 =09=09=09=09=09       apic_find_highest_isr(apic));
 =09else {
 =09=09--apic->isr_count;
@@ -667,7 +667,7 @@ static int apic_has_interrupt_for_ppr(struct kvm_lapic =
*apic, u32 ppr)
 {
 =09int highest_irr;
 =09if (apic->vcpu->arch.apicv_active)
-=09=09highest_irr =3D kvm_x86_ops->sync_pir_to_irr(apic->vcpu);
+=09=09highest_irr =3D kvm_x86_sync_pir_to_irr(apic->vcpu);
 =09else
 =09=09highest_irr =3D apic_find_highest_irr(apic);
 =09if (highest_irr =3D=3D -1 || (highest_irr & 0xF0) <=3D ppr)
@@ -1057,7 +1057,7 @@ static int __apic_accept_irq(struct kvm_lapic *apic, =
int delivery_mode,
 =09=09}
=20
 =09=09if (vcpu->arch.apicv_active)
-=09=09=09kvm_x86_ops->deliver_posted_interrupt(vcpu, vector);
+=09=09=09kvm_x86_deliver_posted_interrupt(vcpu, vector);
 =09=09else {
 =09=09=09kvm_lapic_set_irr(vector, apic);
=20
@@ -1701,7 +1701,7 @@ static void cancel_hv_timer(struct kvm_lapic *apic)
 {
 =09WARN_ON(preemptible());
 =09WARN_ON(!apic->lapic_timer.hv_timer_in_use);
-=09kvm_x86_ops->cancel_hv_timer(apic->vcpu);
+=09kvm_x86_cancel_hv_timer(apic->vcpu);
 =09apic->lapic_timer.hv_timer_in_use =3D false;
 }
=20
@@ -1718,7 +1718,7 @@ static bool start_hv_timer(struct kvm_lapic *apic)
 =09if (!ktimer->tscdeadline)
 =09=09return false;
=20
-=09if (kvm_x86_ops->set_hv_timer(vcpu, ktimer->tscdeadline, &expired))
+=09if (kvm_x86_set_hv_timer(vcpu, ktimer->tscdeadline, &expired))
 =09=09return false;
=20
 =09ktimer->hv_timer_in_use =3D true;
@@ -2138,7 +2138,7 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 va=
lue)
 =09=09kvm_apic_set_x2apic_id(apic, vcpu->vcpu_id);
=20
 =09if ((old_value ^ value) & (MSR_IA32_APICBASE_ENABLE | X2APIC_ENABLE))
-=09=09kvm_x86_ops->set_virtual_apic_mode(vcpu);
+=09=09kvm_x86_set_virtual_apic_mode(vcpu);
=20
 =09apic->base_address =3D apic->vcpu->arch.apic_base &
 =09=09=09     MSR_IA32_APICBASE_BASE;
@@ -2201,9 +2201,9 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init=
_event)
 =09vcpu->arch.pv_eoi.msr_val =3D 0;
 =09apic_update_ppr(apic);
 =09if (vcpu->arch.apicv_active) {
-=09=09kvm_x86_ops->apicv_post_state_restore(vcpu);
-=09=09kvm_x86_ops->hwapic_irr_update(vcpu, -1);
-=09=09kvm_x86_ops->hwapic_isr_update(vcpu, -1);
+=09=09kvm_x86_apicv_post_state_restore(vcpu);
+=09=09kvm_x86_hwapic_irr_update(vcpu, -1);
+=09=09kvm_x86_hwapic_isr_update(vcpu, -1);
 =09}
=20
 =09vcpu->arch.apic_arb_prio =3D 0;
@@ -2454,10 +2454,10 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struc=
t kvm_lapic_state *s)
 =09=09=09=091 : count_vectors(apic->regs + APIC_ISR);
 =09apic->highest_isr_cache =3D -1;
 =09if (vcpu->arch.apicv_active) {
-=09=09kvm_x86_ops->apicv_post_state_restore(vcpu);
-=09=09kvm_x86_ops->hwapic_irr_update(vcpu,
+=09=09kvm_x86_apicv_post_state_restore(vcpu);
+=09=09kvm_x86_hwapic_irr_update(vcpu,
 =09=09=09=09apic_find_highest_irr(apic));
-=09=09kvm_x86_ops->hwapic_isr_update(vcpu,
+=09=09kvm_x86_hwapic_isr_update(vcpu,
 =09=09=09=09apic_find_highest_isr(apic));
 =09}
 =09kvm_make_request(KVM_REQ_EVENT, vcpu);
@@ -2709,7 +2709,7 @@ void kvm_apic_accept_events(struct kvm_vcpu *vcpu)
 =09 * KVM_MP_STATE_INIT_RECEIVED state), just eat SIPIs
 =09 * and leave the INIT pending.
 =09 */
-=09if (is_smm(vcpu) || kvm_x86_ops->apic_init_signal_blocked(vcpu)) {
+=09if (is_smm(vcpu) || kvm_x86_apic_init_signal_blocked(vcpu)) {
 =09=09WARN_ON_ONCE(vcpu->arch.mp_state =3D=3D KVM_MP_STATE_INIT_RECEIVED);
 =09=09if (test_bit(KVM_APIC_SIPI, &apic->pending_events))
 =09=09=09clear_bit(KVM_APIC_SIPI, &apic->pending_events);
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 24c23c66b226..29d930470db9 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -292,7 +292,7 @@ static void kvm_flush_remote_tlbs_with_range(struct kvm=
 *kvm,
 =09int ret =3D -ENOTSUPP;
=20
 =09if (range && kvm_x86_ops->tlb_remote_flush_with_range)
-=09=09ret =3D kvm_x86_ops->tlb_remote_flush_with_range(kvm, range);
+=09=09ret =3D kvm_x86_tlb_remote_flush_with_range(kvm, range);
=20
 =09if (ret)
 =09=09kvm_flush_remote_tlbs(kvm);
@@ -1289,7 +1289,7 @@ static int mapping_level(struct kvm_vcpu *vcpu, gfn_t=
 large_gfn,
 =09if (host_level =3D=3D PT_PAGE_TABLE_LEVEL)
 =09=09return host_level;
=20
-=09max_level =3D min(kvm_x86_ops->get_lpage_level(), host_level);
+=09max_level =3D min(kvm_x86_get_lpage_level(), host_level);
=20
 =09for (level =3D PT_DIRECTORY_LEVEL; level <=3D max_level; ++level)
 =09=09if (__mmu_gfn_lpage_is_disallowed(large_gfn, level, slot))
@@ -1748,7 +1748,7 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct k=
vm *kvm,
 =09=09=09=09gfn_t gfn_offset, unsigned long mask)
 {
 =09if (kvm_x86_ops->enable_log_dirty_pt_masked)
-=09=09kvm_x86_ops->enable_log_dirty_pt_masked(kvm, slot, gfn_offset,
+=09=09kvm_x86_enable_log_dirty_pt_masked(kvm, slot, gfn_offset,
 =09=09=09=09mask);
 =09else
 =09=09kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset, mask);
@@ -1764,7 +1764,7 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct k=
vm *kvm,
 int kvm_arch_write_log_dirty(struct kvm_vcpu *vcpu)
 {
 =09if (kvm_x86_ops->write_log_dirty)
-=09=09return kvm_x86_ops->write_log_dirty(vcpu);
+=09=09return kvm_x86_write_log_dirty(vcpu);
=20
 =09return 0;
 }
@@ -3024,7 +3024,7 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep=
,
 =09if (level > PT_PAGE_TABLE_LEVEL)
 =09=09spte |=3D PT_PAGE_SIZE_MASK;
 =09if (tdp_enabled)
-=09=09spte |=3D kvm_x86_ops->get_mt_mask(vcpu, gfn,
+=09=09spte |=3D kvm_x86_get_mt_mask(vcpu, gfn,
 =09=09=09kvm_is_mmio_pfn(pfn));
=20
 =09if (host_writable)
@@ -4295,7 +4295,7 @@ static bool fast_cr3_switch(struct kvm_vcpu *vcpu, gp=
a_t new_cr3,
 =09=09=09kvm_make_request(KVM_REQ_LOAD_CR3, vcpu);
 =09=09=09if (!skip_tlb_flush) {
 =09=09=09=09kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
-=09=09=09=09kvm_x86_ops->tlb_flush(vcpu, true);
+=09=09=09=09kvm_x86_tlb_flush(vcpu, true);
 =09=09=09}
=20
 =09=09=09/*
@@ -4890,7 +4890,7 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu=
, bool base_only)
 =09union kvm_mmu_role role =3D kvm_calc_mmu_role_common(vcpu, base_only);
=20
 =09role.base.ad_disabled =3D (shadow_accessed_mask =3D=3D 0);
-=09role.base.level =3D kvm_x86_ops->get_tdp_level(vcpu);
+=09role.base.level =3D kvm_x86_get_tdp_level(vcpu);
 =09role.base.direct =3D true;
 =09role.base.gpte_is_8_bytes =3D true;
=20
@@ -4912,7 +4912,7 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
 =09context->sync_page =3D nonpaging_sync_page;
 =09context->invlpg =3D nonpaging_invlpg;
 =09context->update_pte =3D nonpaging_update_pte;
-=09context->shadow_root_level =3D kvm_x86_ops->get_tdp_level(vcpu);
+=09context->shadow_root_level =3D kvm_x86_get_tdp_level(vcpu);
 =09context->direct_map =3D true;
 =09context->set_cr3 =3D kvm_x86_ops->set_tdp_cr3;
 =09context->get_cr3 =3D get_cr3;
@@ -5169,7 +5169,7 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
 =09if (r)
 =09=09goto out;
 =09kvm_mmu_load_cr3(vcpu);
-=09kvm_x86_ops->tlb_flush(vcpu, true);
+=09kvm_x86_tlb_flush(vcpu, true);
 out:
 =09return r;
 }
@@ -5482,7 +5482,7 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t c=
r2, u64 error_code,
 =09 * guest, with the exception of AMD Erratum 1096 which is unrecoverable=
.
 =09 */
 =09if (unlikely(insn && !insn_len)) {
-=09=09if (!kvm_x86_ops->need_emulation_on_page_fault(vcpu))
+=09=09if (!kvm_x86_need_emulation_on_page_fault(vcpu))
 =09=09=09return 1;
 =09}
=20
@@ -5517,7 +5517,7 @@ void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
 =09=09if (VALID_PAGE(mmu->prev_roots[i].hpa))
 =09=09=09mmu->invlpg(vcpu, gva, mmu->prev_roots[i].hpa);
=20
-=09kvm_x86_ops->tlb_flush_gva(vcpu, gva);
+=09kvm_x86_tlb_flush_gva(vcpu, gva);
 =09++vcpu->stat.invlpg;
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_invlpg);
@@ -5542,7 +5542,7 @@ void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t=
 gva, unsigned long pcid)
 =09}
=20
 =09if (tlb_flush)
-=09=09kvm_x86_ops->tlb_flush_gva(vcpu, gva);
+=09=09kvm_x86_tlb_flush_gva(vcpu, gva);
=20
 =09++vcpu->stat.invlpg;
=20
@@ -5659,7 +5659,7 @@ static int alloc_mmu_pages(struct kvm_vcpu *vcpu, str=
uct kvm_mmu *mmu)
 =09 * SVM's 32-bit NPT support, TDP paging doesn't use PAE paging and can
 =09 * skip allocating the PDP table.
 =09 */
-=09if (tdp_enabled && kvm_x86_ops->get_tdp_level(vcpu) > PT32E_ROOT_LEVEL)
+=09if (tdp_enabled && kvm_x86_get_tdp_level(vcpu) > PT32E_ROOT_LEVEL)
 =09=09return 0;
=20
 =09page =3D alloc_page(GFP_KERNEL_ACCOUNT | __GFP_DMA32);
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 11f8ec89433b..8ac288bc42eb 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -157,8 +157,8 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu=
, struct kvm_mmu *mmu,
 =09=09=09=09  unsigned pte_access, unsigned pte_pkey,
 =09=09=09=09  unsigned pfec)
 {
-=09int cpl =3D kvm_x86_ops->get_cpl(vcpu);
-=09unsigned long rflags =3D kvm_x86_ops->get_rflags(vcpu);
+=09int cpl =3D kvm_x86_get_cpl(vcpu);
+=09unsigned long rflags =3D kvm_x86_get_rflags(vcpu);
=20
 =09/*
 =09 * If CPL < 3, SMAP prevention are disabled if EFLAGS.AC =3D 1.
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 46875bbd0419..144e5d0c25ff 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -183,7 +183,7 @@ void reprogram_gp_counter(struct kvm_pmc *pmc, u64 even=
tsel)
 =09=09=09  ARCH_PERFMON_EVENTSEL_CMASK |
 =09=09=09  HSW_IN_TX |
 =09=09=09  HSW_IN_TX_CHECKPOINTED))) {
-=09=09config =3D kvm_x86_ops->pmu_ops->find_arch_event(pmc_to_pmu(pmc),
+=09=09config =3D kvm_x86_pmu_find_arch_event(pmc_to_pmu(pmc),
 =09=09=09=09=09=09      event_select,
 =09=09=09=09=09=09      unit_mask);
 =09=09if (config !=3D PERF_COUNT_HW_MAX)
@@ -225,7 +225,7 @@ void reprogram_fixed_counter(struct kvm_pmc *pmc, u8 ct=
rl, int idx)
 =09}
=20
 =09pmc_reprogram_counter(pmc, PERF_TYPE_HARDWARE,
-=09=09=09      kvm_x86_ops->pmu_ops->find_fixed_event(idx),
+=09=09=09      kvm_x86_pmu_find_fixed_event(idx),
 =09=09=09      !(en_field & 0x2), /* exclude user */
 =09=09=09      !(en_field & 0x1), /* exclude kernel */
 =09=09=09      pmi, false, false);
@@ -234,7 +234,7 @@ EXPORT_SYMBOL_GPL(reprogram_fixed_counter);
=20
 void reprogram_counter(struct kvm_pmu *pmu, int pmc_idx)
 {
-=09struct kvm_pmc *pmc =3D kvm_x86_ops->pmu_ops->pmc_idx_to_pmc(pmu, pmc_i=
dx);
+=09struct kvm_pmc *pmc =3D kvm_x86_pmu_pmc_idx_to_pmc(pmu, pmc_idx);
=20
 =09if (!pmc)
 =09=09return;
@@ -259,7 +259,7 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 =09bitmask =3D pmu->reprogram_pmi;
=20
 =09for_each_set_bit(bit, (unsigned long *)&bitmask, X86_PMC_IDX_MAX) {
-=09=09struct kvm_pmc *pmc =3D kvm_x86_ops->pmu_ops->pmc_idx_to_pmc(pmu, bi=
t);
+=09=09struct kvm_pmc *pmc =3D kvm_x86_pmu_pmc_idx_to_pmc(pmu, bit);
=20
 =09=09if (unlikely(!pmc || !pmc->perf_event)) {
 =09=09=09clear_bit(bit, (unsigned long *)&pmu->reprogram_pmi);
@@ -273,7 +273,7 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 /* check if idx is a valid index to access PMU */
 int kvm_pmu_is_valid_msr_idx(struct kvm_vcpu *vcpu, unsigned idx)
 {
-=09return kvm_x86_ops->pmu_ops->is_valid_msr_idx(vcpu, idx);
+=09return kvm_x86_pmu_is_valid_msr_idx(vcpu, idx);
 }
=20
 bool is_vmware_backdoor_pmc(u32 pmc_idx)
@@ -323,7 +323,7 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, =
u64 *data)
 =09if (is_vmware_backdoor_pmc(idx))
 =09=09return kvm_pmu_rdpmc_vmware(vcpu, idx, data);
=20
-=09pmc =3D kvm_x86_ops->pmu_ops->msr_idx_to_pmc(vcpu, idx, &mask);
+=09pmc =3D kvm_x86_pmu_msr_idx_to_pmc(vcpu, idx, &mask);
 =09if (!pmc)
 =09=09return 1;
=20
@@ -339,17 +339,17 @@ void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu)
=20
 bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 {
-=09return kvm_x86_ops->pmu_ops->is_valid_msr(vcpu, msr);
+=09return kvm_x86_pmu_is_valid_msr(vcpu, msr);
 }
=20
 int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 {
-=09return kvm_x86_ops->pmu_ops->get_msr(vcpu, msr, data);
+=09return kvm_x86_pmu_get_msr(vcpu, msr, data);
 }
=20
 int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
-=09return kvm_x86_ops->pmu_ops->set_msr(vcpu, msr_info);
+=09return kvm_x86_pmu_set_msr(vcpu, msr_info);
 }
=20
 /* refresh PMU settings. This function generally is called when underlying
@@ -358,7 +358,7 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_d=
ata *msr_info)
  */
 void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 {
-=09kvm_x86_ops->pmu_ops->refresh(vcpu);
+=09kvm_x86_pmu_refresh(vcpu);
 }
=20
 void kvm_pmu_reset(struct kvm_vcpu *vcpu)
@@ -366,7 +366,7 @@ void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 =09struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
=20
 =09irq_work_sync(&pmu->irq_work);
-=09kvm_x86_ops->pmu_ops->reset(vcpu);
+=09kvm_x86_pmu_reset(vcpu);
 }
=20
 void kvm_pmu_init(struct kvm_vcpu *vcpu)
@@ -374,7 +374,7 @@ void kvm_pmu_init(struct kvm_vcpu *vcpu)
 =09struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
=20
 =09memset(pmu, 0, sizeof(*pmu));
-=09kvm_x86_ops->pmu_ops->init(vcpu);
+=09kvm_x86_pmu_init(vcpu);
 =09init_irq_work(&pmu->irq_work, kvm_pmi_trigger_fn);
 =09kvm_pmu_refresh(vcpu);
 }
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 58265f761c3b..82f07e3492df 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -19,6 +19,23 @@ struct kvm_event_hw_type_mapping {
 =09unsigned event_type;
 };
=20
+extern unsigned kvm_x86_pmu_find_arch_event(struct kvm_pmu *pmu,
+=09=09=09=09=09    u8 event_select, u8 unit_mask);
+extern unsigned kvm_x86_pmu_find_fixed_event(int idx);
+extern bool kvm_x86_pmu_pmc_is_enabled(struct kvm_pmc *pmc);
+extern struct kvm_pmc *kvm_x86_pmu_pmc_idx_to_pmc(struct kvm_pmu *pmu,
+=09=09=09=09=09=09  int pmc_idx);
+extern struct kvm_pmc *kvm_x86_pmu_msr_idx_to_pmc(struct kvm_vcpu *vcpu,
+=09=09=09=09=09=09  unsigned idx, u64 *mask);
+extern int kvm_x86_pmu_is_valid_msr_idx(struct kvm_vcpu *vcpu, unsigned id=
x);
+extern bool kvm_x86_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr);
+extern int kvm_x86_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data);
+extern int kvm_x86_pmu_set_msr(struct kvm_vcpu *vcpu,
+=09=09=09       struct msr_data *msr_info);
+extern void kvm_x86_pmu_refresh(struct kvm_vcpu *vcpu);
+extern void kvm_x86_pmu_init(struct kvm_vcpu *vcpu);
+extern void kvm_x86_pmu_reset(struct kvm_vcpu *vcpu);
+
 struct kvm_pmu_ops {
 =09unsigned (*find_arch_event)(struct kvm_pmu *pmu, u8 event_select,
 =09=09=09=09    u8 unit_mask);
@@ -76,7 +93,7 @@ static inline bool pmc_is_fixed(struct kvm_pmc *pmc)
=20
 static inline bool pmc_is_enabled(struct kvm_pmc *pmc)
 {
-=09return kvm_x86_ops->pmu_ops->pmc_is_enabled(pmc);
+=09return kvm_x86_pmu_pmc_is_enabled(pmc);
 }
=20
 /* returns general purpose PMC with the specified MSR. Note that it can be
diff --git a/arch/x86/kvm/pmu_amd.c b/arch/x86/kvm/pmu_amd.c
index c8388389a3b0..7ea588023949 100644
--- a/arch/x86/kvm/pmu_amd.c
+++ b/arch/x86/kvm/pmu_amd.c
@@ -126,9 +126,8 @@ static inline struct kvm_pmc *get_gp_pmc_amd(struct kvm=
_pmu *pmu, u32 msr,
 =09return &pmu->gp_counters[msr_to_index(msr)];
 }
=20
-static unsigned amd_find_arch_event(struct kvm_pmu *pmu,
-=09=09=09=09    u8 event_select,
-=09=09=09=09    u8 unit_mask)
+unsigned kvm_x86_pmu_find_arch_event(struct kvm_pmu *pmu, u8 event_select,
+=09=09=09=09     u8 unit_mask)
 {
 =09int i;
=20
@@ -144,7 +143,7 @@ static unsigned amd_find_arch_event(struct kvm_pmu *pmu=
,
 }
=20
 /* return PERF_COUNT_HW_MAX as AMD doesn't have fixed events */
-static unsigned amd_find_fixed_event(int idx)
+unsigned kvm_x86_pmu_find_fixed_event(int idx)
 {
 =09return PERF_COUNT_HW_MAX;
 }
@@ -152,12 +151,12 @@ static unsigned amd_find_fixed_event(int idx)
 /* check if a PMC is enabled by comparing it against global_ctrl bits. Bec=
ause
  * AMD CPU doesn't have global_ctrl MSR, all PMCs are enabled (return TRUE=
).
  */
-static bool amd_pmc_is_enabled(struct kvm_pmc *pmc)
+bool kvm_x86_pmu_pmc_is_enabled(struct kvm_pmc *pmc)
 {
 =09return true;
 }
=20
-static struct kvm_pmc *amd_pmc_idx_to_pmc(struct kvm_pmu *pmu, int pmc_idx=
)
+struct kvm_pmc *kvm_x86_pmu_pmc_idx_to_pmc(struct kvm_pmu *pmu, int pmc_id=
x)
 {
 =09unsigned int base =3D get_msr_base(pmu, PMU_TYPE_COUNTER);
 =09struct kvm_vcpu *vcpu =3D pmu_to_vcpu(pmu);
@@ -174,7 +173,7 @@ static struct kvm_pmc *amd_pmc_idx_to_pmc(struct kvm_pm=
u *pmu, int pmc_idx)
 }
=20
 /* returns 0 if idx's corresponding MSR exists; otherwise returns 1. */
-static int amd_is_valid_msr_idx(struct kvm_vcpu *vcpu, unsigned idx)
+int kvm_x86_pmu_is_valid_msr_idx(struct kvm_vcpu *vcpu, unsigned idx)
 {
 =09struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
=20
@@ -184,7 +183,8 @@ static int amd_is_valid_msr_idx(struct kvm_vcpu *vcpu, =
unsigned idx)
 }
=20
 /* idx is the ECX register of RDPMC instruction */
-static struct kvm_pmc *amd_msr_idx_to_pmc(struct kvm_vcpu *vcpu, unsigned =
idx, u64 *mask)
+struct kvm_pmc *kvm_x86_pmu_msr_idx_to_pmc(struct kvm_vcpu *vcpu, unsigned=
 idx,
+=09=09=09=09=09   u64 *mask)
 {
 =09struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
 =09struct kvm_pmc *counters;
@@ -197,7 +197,7 @@ static struct kvm_pmc *amd_msr_idx_to_pmc(struct kvm_vc=
pu *vcpu, unsigned idx, u
 =09return &counters[idx];
 }
=20
-static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
+bool kvm_x86_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 {
 =09struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
 =09int ret =3D false;
@@ -208,7 +208,7 @@ static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32=
 msr)
 =09return ret;
 }
=20
-static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
+int kvm_x86_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 {
 =09struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
 =09struct kvm_pmc *pmc;
@@ -229,7 +229,7 @@ static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, u32 m=
sr, u64 *data)
 =09return 1;
 }
=20
-static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_inf=
o)
+int kvm_x86_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 =09struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
 =09struct kvm_pmc *pmc;
@@ -256,7 +256,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struc=
t msr_data *msr_info)
 =09return 1;
 }
=20
-static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
+void kvm_x86_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 =09struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
=20
@@ -274,7 +274,7 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 =09pmu->global_status =3D 0;
 }
=20
-static void amd_pmu_init(struct kvm_vcpu *vcpu)
+void kvm_x86_pmu_init(struct kvm_vcpu *vcpu)
 {
 =09struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
 =09int i;
@@ -288,7 +288,7 @@ static void amd_pmu_init(struct kvm_vcpu *vcpu)
 =09}
 }
=20
-static void amd_pmu_reset(struct kvm_vcpu *vcpu)
+void kvm_x86_pmu_reset(struct kvm_vcpu *vcpu)
 {
 =09struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
 =09int i;
@@ -302,16 +302,16 @@ static void amd_pmu_reset(struct kvm_vcpu *vcpu)
 }
=20
 struct kvm_pmu_ops amd_pmu_ops =3D {
-=09.find_arch_event =3D amd_find_arch_event,
-=09.find_fixed_event =3D amd_find_fixed_event,
-=09.pmc_is_enabled =3D amd_pmc_is_enabled,
-=09.pmc_idx_to_pmc =3D amd_pmc_idx_to_pmc,
-=09.msr_idx_to_pmc =3D amd_msr_idx_to_pmc,
-=09.is_valid_msr_idx =3D amd_is_valid_msr_idx,
-=09.is_valid_msr =3D amd_is_valid_msr,
-=09.get_msr =3D amd_pmu_get_msr,
-=09.set_msr =3D amd_pmu_set_msr,
-=09.refresh =3D amd_pmu_refresh,
-=09.init =3D amd_pmu_init,
-=09.reset =3D amd_pmu_reset,
+=09.find_arch_event =3D kvm_x86_pmu_find_arch_event,
+=09.find_fixed_event =3D kvm_x86_pmu_find_fixed_event,
+=09.pmc_is_enabled =3D kvm_x86_pmu_pmc_is_enabled,
+=09.pmc_idx_to_pmc =3D kvm_x86_pmu_pmc_idx_to_pmc,
+=09.msr_idx_to_pmc =3D kvm_x86_pmu_msr_idx_to_pmc,
+=09.is_valid_msr_idx =3D kvm_x86_pmu_is_valid_msr_idx,
+=09.is_valid_msr =3D kvm_x86_pmu_is_valid_msr,
+=09.get_msr =3D kvm_x86_pmu_get_msr,
+=09.set_msr =3D kvm_x86_pmu_set_msr,
+=09.refresh =3D kvm_x86_pmu_refresh,
+=09.init =3D kvm_x86_pmu_init,
+=09.reset =3D kvm_x86_pmu_reset,
 };
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index c5673bda4b66..1705608246fb 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -383,8 +383,6 @@ module_param(dump_invalid_vmcb, bool, 0644);
=20
 static u8 rsm_ins_bytes[] =3D "\x0f\xaa";
=20
-static void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
-static void svm_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gpa);
 static void svm_complete_interrupts(struct vcpu_svm *svm);
=20
 static int nested_svm_exit_handled(struct vcpu_svm *svm);
@@ -722,7 +720,7 @@ static inline void invlpga(unsigned long addr, u32 asid=
)
 =09asm volatile (__ex("invlpga %1, %0") : : "c"(asid), "a"(addr));
 }
=20
-static int get_npt_level(struct kvm_vcpu *vcpu)
+int kvm_x86_get_tdp_level(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_X86_64
 =09return PT64_ROOT_4LEVEL;
@@ -731,7 +729,7 @@ static int get_npt_level(struct kvm_vcpu *vcpu)
 #endif
 }
=20
-static void svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
+void kvm_x86_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
 =09vcpu->arch.efer =3D efer;
=20
@@ -753,7 +751,7 @@ static int is_external_interrupt(u32 info)
 =09return info =3D=3D (SVM_EVTINJ_VALID | SVM_EVTINJ_TYPE_INTR);
 }
=20
-static u32 svm_get_interrupt_shadow(struct kvm_vcpu *vcpu)
+u32 kvm_x86_get_interrupt_shadow(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
 =09u32 ret =3D 0;
@@ -763,7 +761,7 @@ static u32 svm_get_interrupt_shadow(struct kvm_vcpu *vc=
pu)
 =09return ret;
 }
=20
-static void svm_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask)
+void kvm_x86_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -774,7 +772,7 @@ static void svm_set_interrupt_shadow(struct kvm_vcpu *v=
cpu, int mask)
=20
 }
=20
-static int skip_emulated_instruction(struct kvm_vcpu *vcpu)
+int kvm_x86_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -792,12 +790,12 @@ static int skip_emulated_instruction(struct kvm_vcpu =
*vcpu)
 =09=09=09       __func__, kvm_rip_read(vcpu), svm->next_rip);
 =09=09kvm_rip_write(vcpu, svm->next_rip);
 =09}
-=09svm_set_interrupt_shadow(vcpu, 0);
+=09kvm_x86_set_interrupt_shadow(vcpu, 0);
=20
 =09return 1;
 }
=20
-static void svm_queue_exception(struct kvm_vcpu *vcpu)
+void kvm_x86_queue_exception(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
 =09unsigned nr =3D vcpu->arch.exception.nr;
@@ -825,7 +823,7 @@ static void svm_queue_exception(struct kvm_vcpu *vcpu)
 =09=09 * raises a fault that is not intercepted. Still better than
 =09=09 * failing in all cases.
 =09=09 */
-=09=09(void)skip_emulated_instruction(&svm->vcpu);
+=09=09(void)kvm_x86_skip_emulated_instruction(&svm->vcpu);
 =09=09rip =3D kvm_rip_read(&svm->vcpu);
 =09=09svm->int3_rip =3D rip + svm->vmcb->save.cs.base;
 =09=09svm->int3_injected =3D rip - old_rip;
@@ -883,7 +881,7 @@ static void svm_init_osvw(struct kvm_vcpu *vcpu)
 =09=09vcpu->arch.osvw.status |=3D 1;
 }
=20
-static int has_svm(void)
+int kvm_x86_cpu_has_kvm_support(void)
 {
 =09const char *msg;
=20
@@ -895,7 +893,7 @@ static int has_svm(void)
 =09return 1;
 }
=20
-static void svm_hardware_disable(void)
+void kvm_x86_hardware_disable(void)
 {
 =09/* Make sure we clean up behind us */
 =09if (static_cpu_has(X86_FEATURE_TSCRATEMSR))
@@ -906,7 +904,7 @@ static void svm_hardware_disable(void)
 =09amd_pmu_disable_virt();
 }
=20
-static int svm_hardware_enable(void)
+int kvm_x86_hardware_enable(void)
 {
=20
 =09struct svm_cpu_data *sd;
@@ -918,7 +916,7 @@ static int svm_hardware_enable(void)
 =09if (efer & EFER_SVME)
 =09=09return -EBUSY;
=20
-=09if (!has_svm()) {
+=09if (!kvm_x86_cpu_has_kvm_support()) {
 =09=09pr_err("%s: err EOPNOTSUPP on %d\n", __func__, me);
 =09=09return -EINVAL;
 =09}
@@ -1298,7 +1296,7 @@ static void shrink_ple_window(struct kvm_vcpu *vcpu)
 =09}
 }
=20
-static __init int svm_hardware_setup(void)
+__init int kvm_x86_hardware_setup(void)
 {
 =09int cpu;
 =09struct page *iopm_pages;
@@ -1414,7 +1412,7 @@ static __init int svm_hardware_setup(void)
 =09return r;
 }
=20
-static __exit void svm_hardware_unsetup(void)
+__exit void kvm_x86_hardware_unsetup(void)
 {
 =09int cpu;
=20
@@ -1445,7 +1443,7 @@ static void init_sys_seg(struct vmcb_seg *seg, uint32=
_t type)
 =09seg->base =3D 0;
 }
=20
-static u64 svm_read_l1_tsc_offset(struct kvm_vcpu *vcpu)
+u64 kvm_x86_read_l1_tsc_offset(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -1455,7 +1453,7 @@ static u64 svm_read_l1_tsc_offset(struct kvm_vcpu *vc=
pu)
 =09return vcpu->arch.tsc_offset;
 }
=20
-static u64 svm_write_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
+u64 kvm_x86_write_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
 =09u64 g_tsc_offset =3D 0;
@@ -1580,17 +1578,17 @@ static void init_vmcb(struct vcpu_svm *svm)
 =09init_sys_seg(&save->ldtr, SEG_TYPE_LDT);
 =09init_sys_seg(&save->tr, SEG_TYPE_BUSY_TSS16);
=20
-=09svm_set_efer(&svm->vcpu, 0);
+=09kvm_x86_set_efer(&svm->vcpu, 0);
 =09save->dr6 =3D 0xffff0ff0;
 =09kvm_set_rflags(&svm->vcpu, 2);
 =09save->rip =3D 0x0000fff0;
 =09svm->vcpu.arch.regs[VCPU_REGS_RIP] =3D save->rip;
=20
 =09/*
-=09 * svm_set_cr0() sets PG and WP and clears NW and CD on save->cr0.
+=09 * kvm_x86_set_cr0() sets PG and WP and clears NW and CD on save->cr0.
 =09 * It also updates the guest-visible cr0 value.
 =09 */
-=09svm_set_cr0(&svm->vcpu, X86_CR0_NW | X86_CR0_CD | X86_CR0_ET);
+=09kvm_x86_set_cr0(&svm->vcpu, X86_CR0_NW | X86_CR0_CD | X86_CR0_ET);
 =09kvm_mmu_reset_context(&svm->vcpu);
=20
 =09save->cr4 =3D X86_CR4_PAE;
@@ -1878,7 +1876,7 @@ static void __unregister_enc_region_locked(struct kvm=
 *kvm,
 =09kfree(region);
 }
=20
-static struct kvm *svm_vm_alloc(void)
+struct kvm *kvm_x86_vm_alloc(void)
 {
 =09struct kvm_svm *kvm_svm =3D __vmalloc(sizeof(struct kvm_svm),
 =09=09=09=09=09    GFP_KERNEL_ACCOUNT | __GFP_ZERO,
@@ -1886,7 +1884,7 @@ static struct kvm *svm_vm_alloc(void)
 =09return &kvm_svm->kvm;
 }
=20
-static void svm_vm_free(struct kvm *kvm)
+void kvm_x86_vm_free(struct kvm *kvm)
 {
 =09vfree(to_kvm_svm(kvm));
 }
@@ -1937,13 +1935,13 @@ static void avic_vm_destroy(struct kvm *kvm)
 =09spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
 }
=20
-static void svm_vm_destroy(struct kvm *kvm)
+void kvm_x86_vm_destroy(struct kvm *kvm)
 {
 =09avic_vm_destroy(kvm);
 =09sev_vm_destroy(kvm);
 }
=20
-static int avic_vm_init(struct kvm *kvm)
+int kvm_x86_vm_init(struct kvm *kvm)
 {
 =09unsigned long flags;
 =09int err =3D -ENOMEM;
@@ -2089,7 +2087,7 @@ static void avic_set_running(struct kvm_vcpu *vcpu, b=
ool is_run)
 =09=09avic_vcpu_put(vcpu);
 }
=20
-static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
+void kvm_x86_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
 =09u32 dummy;
@@ -2132,7 +2130,7 @@ static int avic_init_vcpu(struct vcpu_svm *svm)
 =09return ret;
 }
=20
-static struct kvm_vcpu *svm_create_vcpu(struct kvm *kvm, unsigned int id)
+struct kvm_vcpu *kvm_x86_vcpu_create(struct kvm *kvm, unsigned int id)
 {
 =09struct vcpu_svm *svm;
 =09struct page *page;
@@ -2242,13 +2240,13 @@ static void svm_clear_current_vmcb(struct vmcb *vmc=
b)
 =09=09cmpxchg(&per_cpu(svm_data, i)->current_vmcb, vmcb, NULL);
 }
=20
-static void svm_free_vcpu(struct kvm_vcpu *vcpu)
+void kvm_x86_vcpu_free(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
 =09/*
 =09 * The vmcb page can be recycled, causing a false negative in
-=09 * svm_vcpu_load(). So, ensure that no logical CPU has this
+=09 * kvm_x86_vcpu_load(). So, ensure that no logical CPU has this
 =09 * vmcb page recorded as its current vmcb.
 =09 */
 =09svm_clear_current_vmcb(svm->vmcb);
@@ -2263,7 +2261,7 @@ static void svm_free_vcpu(struct kvm_vcpu *vcpu)
 =09kmem_cache_free(kvm_vcpu_cache, svm);
 }
=20
-static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+void kvm_x86_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
 =09struct svm_cpu_data *sd =3D per_cpu(svm_data, cpu);
@@ -2302,7 +2300,7 @@ static void svm_vcpu_load(struct kvm_vcpu *vcpu, int =
cpu)
 =09avic_vcpu_load(vcpu, cpu);
 }
=20
-static void svm_vcpu_put(struct kvm_vcpu *vcpu)
+void kvm_x86_vcpu_put(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
 =09int i;
@@ -2324,17 +2322,17 @@ static void svm_vcpu_put(struct kvm_vcpu *vcpu)
 =09=09wrmsrl(host_save_user_msrs[i], svm->host_user_msrs[i]);
 }
=20
-static void svm_vcpu_blocking(struct kvm_vcpu *vcpu)
+void kvm_x86_vcpu_blocking(struct kvm_vcpu *vcpu)
 {
 =09avic_set_running(vcpu, false);
 }
=20
-static void svm_vcpu_unblocking(struct kvm_vcpu *vcpu)
+void kvm_x86_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
 =09avic_set_running(vcpu, true);
 }
=20
-static unsigned long svm_get_rflags(struct kvm_vcpu *vcpu)
+unsigned long kvm_x86_get_rflags(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
 =09unsigned long rflags =3D svm->vmcb->save.rflags;
@@ -2349,7 +2347,7 @@ static unsigned long svm_get_rflags(struct kvm_vcpu *=
vcpu)
 =09return rflags;
 }
=20
-static void svm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
+void kvm_x86_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
 {
 =09if (to_svm(vcpu)->nmi_singlestep)
 =09=09rflags |=3D (X86_EFLAGS_TF | X86_EFLAGS_RF);
@@ -2362,7 +2360,7 @@ static void svm_set_rflags(struct kvm_vcpu *vcpu, uns=
igned long rflags)
 =09to_svm(vcpu)->vmcb->save.rflags =3D rflags;
 }
=20
-static void svm_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
+void kvm_x86_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
 {
 =09switch (reg) {
 =09case VCPU_EXREG_PDPTR:
@@ -2402,15 +2400,15 @@ static struct vmcb_seg *svm_seg(struct kvm_vcpu *vc=
pu, int seg)
 =09return NULL;
 }
=20
-static u64 svm_get_segment_base(struct kvm_vcpu *vcpu, int seg)
+u64 kvm_x86_get_segment_base(struct kvm_vcpu *vcpu, int seg)
 {
 =09struct vmcb_seg *s =3D svm_seg(vcpu, seg);
=20
 =09return s->base;
 }
=20
-static void svm_get_segment(struct kvm_vcpu *vcpu,
-=09=09=09    struct kvm_segment *var, int seg)
+void kvm_x86_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var,
+=09=09=09 int seg)
 {
 =09struct vmcb_seg *s =3D svm_seg(vcpu, seg);
=20
@@ -2472,20 +2470,20 @@ static void svm_get_segment(struct kvm_vcpu *vcpu,
 =09=09 */
 =09=09if (var->unusable)
 =09=09=09var->db =3D 0;
-=09=09/* This is symmetric with svm_set_segment() */
+=09=09/* This is symmetric with kvm_x86_set_segment() */
 =09=09var->dpl =3D to_svm(vcpu)->vmcb->save.cpl;
 =09=09break;
 =09}
 }
=20
-static int svm_get_cpl(struct kvm_vcpu *vcpu)
+int kvm_x86_get_cpl(struct kvm_vcpu *vcpu)
 {
 =09struct vmcb_save_area *save =3D &to_svm(vcpu)->vmcb->save;
=20
 =09return save->cpl;
 }
=20
-static void svm_get_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void kvm_x86_get_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -2493,7 +2491,7 @@ static void svm_get_idt(struct kvm_vcpu *vcpu, struct=
 desc_ptr *dt)
 =09dt->address =3D svm->vmcb->save.idtr.base;
 }
=20
-static void svm_set_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void kvm_x86_set_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -2502,7 +2500,7 @@ static void svm_set_idt(struct kvm_vcpu *vcpu, struct=
 desc_ptr *dt)
 =09mark_dirty(svm->vmcb, VMCB_DT);
 }
=20
-static void svm_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void kvm_x86_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -2510,7 +2508,7 @@ static void svm_get_gdt(struct kvm_vcpu *vcpu, struct=
 desc_ptr *dt)
 =09dt->address =3D svm->vmcb->save.gdtr.base;
 }
=20
-static void svm_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void kvm_x86_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -2519,15 +2517,15 @@ static void svm_set_gdt(struct kvm_vcpu *vcpu, stru=
ct desc_ptr *dt)
 =09mark_dirty(svm->vmcb, VMCB_DT);
 }
=20
-static void svm_decache_cr0_guest_bits(struct kvm_vcpu *vcpu)
+void kvm_x86_decache_cr0_guest_bits(struct kvm_vcpu *vcpu)
 {
 }
=20
-static void svm_decache_cr3(struct kvm_vcpu *vcpu)
+void kvm_x86_decache_cr3(struct kvm_vcpu *vcpu)
 {
 }
=20
-static void svm_decache_cr4_guest_bits(struct kvm_vcpu *vcpu)
+void kvm_x86_decache_cr4_guest_bits(struct kvm_vcpu *vcpu)
 {
 }
=20
@@ -2550,7 +2548,7 @@ static void update_cr0_intercept(struct vcpu_svm *svm=
)
 =09}
 }
=20
-static void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+void kvm_x86_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -2584,7 +2582,7 @@ static void svm_set_cr0(struct kvm_vcpu *vcpu, unsign=
ed long cr0)
 =09update_cr0_intercept(svm);
 }
=20
-static int svm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
+int kvm_x86_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
 =09unsigned long host_cr4_mce =3D cr4_read_shadow() & X86_CR4_MCE;
 =09unsigned long old_cr4 =3D to_svm(vcpu)->vmcb->save.cr4;
@@ -2593,7 +2591,7 @@ static int svm_set_cr4(struct kvm_vcpu *vcpu, unsigne=
d long cr4)
 =09=09return 1;
=20
 =09if (npt_enabled && ((old_cr4 ^ cr4) & X86_CR4_PGE))
-=09=09svm_flush_tlb(vcpu, true);
+=09=09kvm_x86_tlb_flush(vcpu, true);
=20
 =09vcpu->arch.cr4 =3D cr4;
 =09if (!npt_enabled)
@@ -2604,8 +2602,8 @@ static int svm_set_cr4(struct kvm_vcpu *vcpu, unsigne=
d long cr4)
 =09return 0;
 }
=20
-static void svm_set_segment(struct kvm_vcpu *vcpu,
-=09=09=09    struct kvm_segment *var, int seg)
+void kvm_x86_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var,
+=09=09=09 int seg)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
 =09struct vmcb_seg *s =3D svm_seg(vcpu, seg);
@@ -2629,13 +2627,13 @@ static void svm_set_segment(struct kvm_vcpu *vcpu,
 =09 * would entail passing the CPL to userspace and back.
 =09 */
 =09if (seg =3D=3D VCPU_SREG_SS)
-=09=09/* This is symmetric with svm_get_segment() */
+=09=09/* This is symmetric with kvm_x86_get_segment() */
 =09=09svm->vmcb->save.cpl =3D (var->dpl & 3);
=20
 =09mark_dirty(svm->vmcb, VMCB_SEG);
 }
=20
-static void update_bp_intercept(struct kvm_vcpu *vcpu)
+void kvm_x86_update_bp_intercept(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -2662,12 +2660,12 @@ static void new_asid(struct vcpu_svm *svm, struct s=
vm_cpu_data *sd)
 =09mark_dirty(svm->vmcb, VMCB_ASID);
 }
=20
-static u64 svm_get_dr6(struct kvm_vcpu *vcpu)
+u64 kvm_x86_get_dr6(struct kvm_vcpu *vcpu)
 {
 =09return to_svm(vcpu)->vmcb->save.dr6;
 }
=20
-static void svm_set_dr6(struct kvm_vcpu *vcpu, unsigned long value)
+void kvm_x86_set_dr6(struct kvm_vcpu *vcpu, unsigned long value)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -2675,7 +2673,7 @@ static void svm_set_dr6(struct kvm_vcpu *vcpu, unsign=
ed long value)
 =09mark_dirty(svm->vmcb, VMCB_DR);
 }
=20
-static void svm_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
+void kvm_x86_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -2683,14 +2681,14 @@ static void svm_sync_dirty_debug_regs(struct kvm_vc=
pu *vcpu)
 =09get_debugreg(vcpu->arch.db[1], 1);
 =09get_debugreg(vcpu->arch.db[2], 2);
 =09get_debugreg(vcpu->arch.db[3], 3);
-=09vcpu->arch.dr6 =3D svm_get_dr6(vcpu);
+=09vcpu->arch.dr6 =3D kvm_x86_get_dr6(vcpu);
 =09vcpu->arch.dr7 =3D svm->vmcb->save.dr7;
=20
 =09vcpu->arch.switch_db_regs &=3D ~KVM_DEBUGREG_WONT_EXIT;
 =09set_dr_intercepts(svm);
 }
=20
-static void svm_set_dr7(struct kvm_vcpu *vcpu, unsigned long value)
+void kvm_x86_set_dr7(struct kvm_vcpu *vcpu, unsigned long value)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -2989,7 +2987,7 @@ static void nested_svm_init_mmu_context(struct kvm_vc=
pu *vcpu)
 =09vcpu->arch.mmu->get_cr3           =3D nested_svm_get_tdp_cr3;
 =09vcpu->arch.mmu->get_pdptr         =3D nested_svm_get_tdp_pdptr;
 =09vcpu->arch.mmu->inject_page_fault =3D nested_svm_inject_npf_exit;
-=09vcpu->arch.mmu->shadow_root_level =3D get_npt_level(vcpu);
+=09vcpu->arch.mmu->shadow_root_level =3D kvm_x86_get_tdp_level(vcpu);
 =09reset_shadow_zero_bits_mask(vcpu, vcpu->arch.mmu);
 =09vcpu->arch.walk_mmu              =3D &vcpu->arch.nested_mmu;
 }
@@ -3409,9 +3407,9 @@ static int nested_svm_vmexit(struct vcpu_svm *svm)
 =09svm->vmcb->save.gdtr =3D hsave->save.gdtr;
 =09svm->vmcb->save.idtr =3D hsave->save.idtr;
 =09kvm_set_rflags(&svm->vcpu, hsave->save.rflags);
-=09svm_set_efer(&svm->vcpu, hsave->save.efer);
-=09svm_set_cr0(&svm->vcpu, hsave->save.cr0 | X86_CR0_PE);
-=09svm_set_cr4(&svm->vcpu, hsave->save.cr4);
+=09kvm_x86_set_efer(&svm->vcpu, hsave->save.efer);
+=09kvm_x86_set_cr0(&svm->vcpu, hsave->save.cr0 | X86_CR0_PE);
+=09kvm_x86_set_cr4(&svm->vcpu, hsave->save.cr4);
 =09if (npt_enabled) {
 =09=09svm->vmcb->save.cr3 =3D hsave->save.cr3;
 =09=09svm->vcpu.arch.cr3 =3D hsave->save.cr3;
@@ -3513,9 +3511,9 @@ static void enter_svm_guest_mode(struct vcpu_svm *svm=
, u64 vmcb_gpa,
 =09svm->vmcb->save.gdtr =3D nested_vmcb->save.gdtr;
 =09svm->vmcb->save.idtr =3D nested_vmcb->save.idtr;
 =09kvm_set_rflags(&svm->vcpu, nested_vmcb->save.rflags);
-=09svm_set_efer(&svm->vcpu, nested_vmcb->save.efer);
-=09svm_set_cr0(&svm->vcpu, nested_vmcb->save.cr0);
-=09svm_set_cr4(&svm->vcpu, nested_vmcb->save.cr4);
+=09kvm_x86_set_efer(&svm->vcpu, nested_vmcb->save.efer);
+=09kvm_x86_set_cr0(&svm->vcpu, nested_vmcb->save.cr0);
+=09kvm_x86_set_cr4(&svm->vcpu, nested_vmcb->save.cr4);
 =09if (npt_enabled) {
 =09=09svm->vmcb->save.cr3 =3D nested_vmcb->save.cr3;
 =09=09svm->vcpu.arch.cr3 =3D nested_vmcb->save.cr3;
@@ -3547,7 +3545,7 @@ static void enter_svm_guest_mode(struct vcpu_svm *svm=
, u64 vmcb_gpa,
 =09svm->nested.intercept_exceptions =3D nested_vmcb->control.intercept_exc=
eptions;
 =09svm->nested.intercept            =3D nested_vmcb->control.intercept;
=20
-=09svm_flush_tlb(&svm->vcpu, true);
+=09kvm_x86_tlb_flush(&svm->vcpu, true);
 =09svm->vmcb->control.int_ctl =3D nested_vmcb->control.int_ctl | V_INTR_MA=
SKING_MASK;
 =09if (nested_vmcb->control.int_ctl & V_INTR_MASKING_MASK)
 =09=09svm->vcpu.arch.hflags |=3D HF_VINTR_MASK;
@@ -3898,7 +3896,7 @@ static int task_switch_interception(struct vcpu_svm *=
svm)
 =09    int_type =3D=3D SVM_EXITINTINFO_TYPE_SOFT ||
 =09    (int_type =3D=3D SVM_EXITINTINFO_TYPE_EXEPT &&
 =09     (int_vec =3D=3D OF_VECTOR || int_vec =3D=3D BP_VECTOR))) {
-=09=09if (!skip_emulated_instruction(&svm->vcpu))
+=09=09if (!kvm_x86_skip_emulated_instruction(&svm->vcpu))
 =09=09=09return 0;
 =09}
=20
@@ -4104,7 +4102,7 @@ static int cr8_write_interception(struct vcpu_svm *sv=
m)
 =09return 0;
 }
=20
-static int svm_get_msr_feature(struct kvm_msr_entry *msr)
+int kvm_x86_get_msr_feature(struct kvm_msr_entry *msr)
 {
 =09msr->data =3D 0;
=20
@@ -4120,7 +4118,7 @@ static int svm_get_msr_feature(struct kvm_msr_entry *=
msr)
 =09return 0;
 }
=20
-static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+int kvm_x86_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -4253,7 +4251,7 @@ static int svm_set_vm_cr(struct kvm_vcpu *vcpu, u64 d=
ata)
 =09return 0;
 }
=20
-static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
+int kvm_x86_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -4389,7 +4387,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct =
msr_data *msr)
 =09=09struct kvm_msr_entry msr_entry;
=20
 =09=09msr_entry.index =3D msr->index;
-=09=09if (svm_get_msr_feature(&msr_entry))
+=09=09if (kvm_x86_get_msr_feature(&msr_entry))
 =09=09=09return 1;
=20
 =09=09/* Check the supported bits */
@@ -4439,7 +4437,7 @@ static int interrupt_window_interception(struct vcpu_=
svm *svm)
 static int pause_interception(struct vcpu_svm *svm)
 {
 =09struct kvm_vcpu *vcpu =3D &svm->vcpu;
-=09bool in_kernel =3D (svm_get_cpl(vcpu) =3D=3D 0);
+=09bool in_kernel =3D (kvm_x86_get_cpl(vcpu) =3D=3D 0);
=20
 =09if (pause_filter_thresh)
 =09=09grow_ple_window(vcpu);
@@ -4919,7 +4917,7 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 =09       "excp_to:", save->last_excp_to);
 }
=20
-static void svm_get_exit_info(struct kvm_vcpu *vcpu, u64 *info1, u64 *info=
2)
+void kvm_x86_get_exit_info(struct kvm_vcpu *vcpu, u64 *info1, u64 *info2)
 {
 =09struct vmcb_control_area *control =3D &to_svm(vcpu)->vmcb->control;
=20
@@ -4927,7 +4925,7 @@ static void svm_get_exit_info(struct kvm_vcpu *vcpu, =
u64 *info1, u64 *info2)
 =09*info2 =3D control->exit_info_2;
 }
=20
-static int handle_exit(struct kvm_vcpu *vcpu)
+int kvm_x86_handle_exit(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
 =09struct kvm_run *kvm_run =3D vcpu->run;
@@ -5047,7 +5045,7 @@ static void pre_svm_run(struct vcpu_svm *svm)
 =09=09new_asid(svm, sd);
 }
=20
-static void svm_inject_nmi(struct kvm_vcpu *vcpu)
+void kvm_x86_set_nmi(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -5070,7 +5068,7 @@ static inline void svm_inject_irq(struct vcpu_svm *sv=
m, int irq)
 =09mark_dirty(svm->vmcb, VMCB_INTR);
 }
=20
-static void svm_set_irq(struct kvm_vcpu *vcpu)
+void kvm_x86_set_irq(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -5088,7 +5086,7 @@ static inline bool svm_nested_virtualize_tpr(struct k=
vm_vcpu *vcpu)
 =09return is_guest_mode(vcpu) && (vcpu->arch.hflags & HF_VINTR_MASK);
 }
=20
-static void update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
+void kvm_x86_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -5105,26 +5103,26 @@ static void update_cr8_intercept(struct kvm_vcpu *v=
cpu, int tpr, int irr)
 =09=09set_cr_intercept(svm, INTERCEPT_CR8_WRITE);
 }
=20
-static void svm_set_virtual_apic_mode(struct kvm_vcpu *vcpu)
+void kvm_x86_set_virtual_apic_mode(struct kvm_vcpu *vcpu)
 {
 =09return;
 }
=20
-static bool svm_get_enable_apicv(struct kvm_vcpu *vcpu)
+bool kvm_x86_get_enable_apicv(struct kvm_vcpu *vcpu)
 {
 =09return avic && irqchip_split(vcpu->kvm);
 }
=20
-static void svm_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
+void kvm_x86_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
 {
 }
=20
-static void svm_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
+void kvm_x86_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
 {
 }
=20
 /* Note: Currently only used by Hyper-V. */
-static void svm_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
+void kvm_x86_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
 =09struct vmcb *vmcb =3D svm->vmcb;
@@ -5136,12 +5134,12 @@ static void svm_refresh_apicv_exec_ctrl(struct kvm_=
vcpu *vcpu)
 =09mark_dirty(vmcb, VMCB_AVIC);
 }
=20
-static void svm_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitm=
ap)
+void kvm_x86_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 {
 =09return;
 }
=20
-static void svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
+void kvm_x86_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vec)
 {
 =09kvm_lapic_set_irr(vec, vcpu->arch.apic);
 =09smp_mb__after_atomic();
@@ -5156,7 +5154,7 @@ static void svm_deliver_avic_intr(struct kvm_vcpu *vc=
pu, int vec)
 =09=09kvm_vcpu_wake_up(vcpu);
 }
=20
-static bool svm_dy_apicv_has_pending_interrupt(struct kvm_vcpu *vcpu)
+bool kvm_x86_dy_apicv_has_pending_interrupt(struct kvm_vcpu *vcpu)
 {
 =09return false;
 }
@@ -5266,8 +5264,8 @@ get_pi_vcpu_info(struct kvm *kvm, struct kvm_kernel_i=
rq_routing_entry *e,
  * @set: set or unset PI
  * returns 0 on success, < 0 on failure
  */
-static int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
-=09=09=09      uint32_t guest_irq, bool set)
+int kvm_x86_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
+=09=09=09   uint32_t guest_irq, bool set)
 {
 =09struct kvm_kernel_irq_routing_entry *e;
 =09struct kvm_irq_routing_table *irq_rt;
@@ -5366,7 +5364,7 @@ static int svm_update_pi_irte(struct kvm *kvm, unsign=
ed int host_irq,
 =09return ret;
 }
=20
-static int svm_nmi_allowed(struct kvm_vcpu *vcpu)
+int kvm_x86_nmi_allowed(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
 =09struct vmcb *vmcb =3D svm->vmcb;
@@ -5378,14 +5376,14 @@ static int svm_nmi_allowed(struct kvm_vcpu *vcpu)
 =09return ret;
 }
=20
-static bool svm_get_nmi_mask(struct kvm_vcpu *vcpu)
+bool kvm_x86_get_nmi_mask(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
 =09return !!(svm->vcpu.arch.hflags & HF_NMI_MASK);
 }
=20
-static void svm_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
+void kvm_x86_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -5398,7 +5396,7 @@ static void svm_set_nmi_mask(struct kvm_vcpu *vcpu, b=
ool masked)
 =09}
 }
=20
-static int svm_interrupt_allowed(struct kvm_vcpu *vcpu)
+int kvm_x86_interrupt_allowed(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
 =09struct vmcb *vmcb =3D svm->vmcb;
@@ -5416,7 +5414,7 @@ static int svm_interrupt_allowed(struct kvm_vcpu *vcp=
u)
 =09return ret;
 }
=20
-static void enable_irq_window(struct kvm_vcpu *vcpu)
+void kvm_x86_enable_irq_window(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -5437,7 +5435,7 @@ static void enable_irq_window(struct kvm_vcpu *vcpu)
 =09}
 }
=20
-static void enable_nmi_window(struct kvm_vcpu *vcpu)
+void kvm_x86_enable_nmi_window(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -5458,22 +5456,22 @@ static void enable_nmi_window(struct kvm_vcpu *vcpu=
)
 =09 * Something prevents NMI from been injected. Single step over possible
 =09 * problem (IRET or exception injection or interrupt shadow)
 =09 */
-=09svm->nmi_singlestep_guest_rflags =3D svm_get_rflags(vcpu);
+=09svm->nmi_singlestep_guest_rflags =3D kvm_x86_get_rflags(vcpu);
 =09svm->nmi_singlestep =3D true;
 =09svm->vmcb->save.rflags |=3D (X86_EFLAGS_TF | X86_EFLAGS_RF);
 }
=20
-static int svm_set_tss_addr(struct kvm *kvm, unsigned int addr)
+int kvm_x86_set_tss_addr(struct kvm *kvm, unsigned int addr)
 {
 =09return 0;
 }
=20
-static int svm_set_identity_map_addr(struct kvm *kvm, u64 ident_addr)
+int kvm_x86_set_identity_map_addr(struct kvm *kvm, u64 ident_addr)
 {
 =09return 0;
 }
=20
-static void svm_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gpa)
+void kvm_x86_tlb_flush(struct kvm_vcpu *vcpu, bool invalidate_gpa)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -5483,14 +5481,14 @@ static void svm_flush_tlb(struct kvm_vcpu *vcpu, bo=
ol invalidate_gpa)
 =09=09svm->asid_generation--;
 }
=20
-static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
+void kvm_x86_tlb_flush_gva(struct kvm_vcpu *vcpu, gva_t gva)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
 =09invlpga(gva, svm->vmcb->control.asid);
 }
=20
-static void svm_prepare_guest_switch(struct kvm_vcpu *vcpu)
+void kvm_x86_prepare_guest_switch(struct kvm_vcpu *vcpu)
 {
 }
=20
@@ -5585,7 +5583,7 @@ static void svm_complete_interrupts(struct vcpu_svm *=
svm)
 =09}
 }
=20
-static void svm_cancel_injection(struct kvm_vcpu *vcpu)
+void kvm_x86_cancel_injection(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
 =09struct vmcb_control_area *control =3D &svm->vmcb->control;
@@ -5596,7 +5594,7 @@ static void svm_cancel_injection(struct kvm_vcpu *vcp=
u)
 =09svm_complete_interrupts(svm);
 }
=20
-static void svm_vcpu_run(struct kvm_vcpu *vcpu)
+void kvm_x86_run(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -5817,9 +5815,9 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
=20
 =09mark_all_clean(svm->vmcb);
 }
-STACK_FRAME_NON_STANDARD(svm_vcpu_run);
+STACK_FRAME_NON_STANDARD(kvm_x86_run);
=20
-static void svm_set_cr3(struct kvm_vcpu *vcpu, unsigned long root)
+void kvm_x86_set_cr3(struct kvm_vcpu *vcpu, unsigned long root)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -5827,7 +5825,7 @@ static void svm_set_cr3(struct kvm_vcpu *vcpu, unsign=
ed long root)
 =09mark_dirty(svm->vmcb, VMCB_CR);
 }
=20
-static void set_tdp_cr3(struct kvm_vcpu *vcpu, unsigned long root)
+void kvm_x86_set_tdp_cr3(struct kvm_vcpu *vcpu, unsigned long root)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -5839,7 +5837,7 @@ static void set_tdp_cr3(struct kvm_vcpu *vcpu, unsign=
ed long root)
 =09mark_dirty(svm->vmcb, VMCB_CR);
 }
=20
-static int is_disabled(void)
+int kvm_x86_disabled_by_bios(void)
 {
 =09u64 vm_cr;
=20
@@ -5850,8 +5848,7 @@ static int is_disabled(void)
 =09return 0;
 }
=20
-static void
-svm_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hypercall)
+void kvm_x86_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hyperca=
ll)
 {
 =09/*
 =09 * Patch in the VMMCALL instruction:
@@ -5861,17 +5858,17 @@ svm_patch_hypercall(struct kvm_vcpu *vcpu, unsigned=
 char *hypercall)
 =09hypercall[2] =3D 0xd9;
 }
=20
-static int __init svm_check_processor_compat(void)
+__init int kvm_x86_check_processor_compatibility(void)
 {
 =09return 0;
 }
=20
-static bool svm_cpu_has_accelerated_tpr(void)
+bool kvm_x86_cpu_has_accelerated_tpr(void)
 {
 =09return false;
 }
=20
-static bool svm_has_emulated_msr(int index)
+bool kvm_x86_has_emulated_msr(int index)
 {
 =09switch (index) {
 =09case MSR_IA32_MCG_EXT_CTL:
@@ -5884,12 +5881,12 @@ static bool svm_has_emulated_msr(int index)
 =09return true;
 }
=20
-static u64 svm_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
+u64 kvm_x86_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 {
 =09return 0;
 }
=20
-static void svm_cpuid_update(struct kvm_vcpu *vcpu)
+void kvm_x86_cpuid_update(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -5904,7 +5901,7 @@ static void svm_cpuid_update(struct kvm_vcpu *vcpu)
=20
 #define F(x) bit(X86_FEATURE_##x)
=20
-static void svm_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *ent=
ry)
+void kvm_x86_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *entry)
 {
 =09switch (func) {
 =09case 0x1:
@@ -5946,42 +5943,42 @@ static void svm_set_supported_cpuid(u32 func, struc=
t kvm_cpuid_entry2 *entry)
 =09}
 }
=20
-static int svm_get_lpage_level(void)
+int kvm_x86_get_lpage_level(void)
 {
 =09return PT_PDPE_LEVEL;
 }
=20
-static bool svm_rdtscp_supported(void)
+bool kvm_x86_rdtscp_supported(void)
 {
 =09return boot_cpu_has(X86_FEATURE_RDTSCP);
 }
=20
-static bool svm_invpcid_supported(void)
+bool kvm_x86_invpcid_supported(void)
 {
 =09return false;
 }
=20
-static bool svm_mpx_supported(void)
+bool kvm_x86_mpx_supported(void)
 {
 =09return false;
 }
=20
-static bool svm_xsaves_supported(void)
+bool kvm_x86_xsaves_supported(void)
 {
 =09return false;
 }
=20
-static bool svm_umip_emulated(void)
+bool kvm_x86_umip_emulated(void)
 {
 =09return false;
 }
=20
-static bool svm_pt_supported(void)
+bool kvm_x86_pt_supported(void)
 {
 =09return false;
 }
=20
-static bool svm_has_wbinvd_exit(void)
+bool kvm_x86_has_wbinvd_exit(void)
 {
 =09return true;
 }
@@ -6050,9 +6047,9 @@ static const struct __x86_intercept {
 #undef POST_EX
 #undef POST_MEM
=20
-static int svm_check_intercept(struct kvm_vcpu *vcpu,
-=09=09=09       struct x86_instruction_info *info,
-=09=09=09       enum x86_intercept_stage stage)
+int kvm_x86_check_intercept(struct kvm_vcpu *vcpu,
+=09=09=09    struct x86_instruction_info *info,
+=09=09=09    enum x86_intercept_stage stage)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
 =09int vmexit, ret =3D X86EMUL_CONTINUE;
@@ -6171,18 +6168,18 @@ static int svm_check_intercept(struct kvm_vcpu *vcp=
u,
 =09return ret;
 }
=20
-static void svm_handle_exit_irqoff(struct kvm_vcpu *vcpu)
+void kvm_x86_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 {
=20
 }
=20
-static void svm_sched_in(struct kvm_vcpu *vcpu, int cpu)
+void kvm_x86_sched_in(struct kvm_vcpu *vcpu, int cpu)
 {
 =09if (pause_filter_thresh)
 =09=09shrink_ple_window(vcpu);
 }
=20
-static inline void avic_post_state_restore(struct kvm_vcpu *vcpu)
+void kvm_x86_apicv_post_state_restore(struct kvm_vcpu *vcpu)
 {
 =09if (avic_handle_apic_id_update(vcpu) !=3D 0)
 =09=09return;
@@ -6190,13 +6187,13 @@ static inline void avic_post_state_restore(struct k=
vm_vcpu *vcpu)
 =09avic_handle_ldr_update(vcpu);
 }
=20
-static void svm_setup_mce(struct kvm_vcpu *vcpu)
+void kvm_x86_setup_mce(struct kvm_vcpu *vcpu)
 {
 =09/* [63:9] are reserved. */
 =09vcpu->arch.mcg_cap &=3D 0x1ff;
 }
=20
-static int svm_smi_allowed(struct kvm_vcpu *vcpu)
+int kvm_x86_smi_allowed(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -6215,7 +6212,7 @@ static int svm_smi_allowed(struct kvm_vcpu *vcpu)
 =09return 1;
 }
=20
-static int svm_pre_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
+int kvm_x86_pre_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
 =09int ret;
@@ -6237,7 +6234,7 @@ static int svm_pre_enter_smm(struct kvm_vcpu *vcpu, c=
har *smstate)
 =09return 0;
 }
=20
-static int svm_pre_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
+int kvm_x86_pre_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
 =09struct vmcb *nested_vmcb;
@@ -6257,7 +6254,7 @@ static int svm_pre_leave_smm(struct kvm_vcpu *vcpu, c=
onst char *smstate)
 =09return 0;
 }
=20
-static int enable_smi_window(struct kvm_vcpu *vcpu)
+int kvm_x86_enable_smi_window(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -6960,7 +6957,7 @@ static int sev_launch_secret(struct kvm *kvm, struct =
kvm_sev_cmd *argp)
 =09return ret;
 }
=20
-static int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
+int kvm_x86_mem_enc_op(struct kvm *kvm, void __user *argp)
 {
 =09struct kvm_sev_cmd sev_cmd;
 =09int r;
@@ -7014,8 +7011,7 @@ static int svm_mem_enc_op(struct kvm *kvm, void __use=
r *argp)
 =09return r;
 }
=20
-static int svm_register_enc_region(struct kvm *kvm,
-=09=09=09=09   struct kvm_enc_region *range)
+int kvm_x86_mem_enc_reg_region(struct kvm *kvm, struct kvm_enc_region *ran=
ge)
 {
 =09struct kvm_sev_info *sev =3D &to_kvm_svm(kvm)->sev_info;
 =09struct enc_region *region;
@@ -7076,8 +7072,7 @@ find_enc_region(struct kvm *kvm, struct kvm_enc_regio=
n *range)
 }
=20
=20
-static int svm_unregister_enc_region(struct kvm *kvm,
-=09=09=09=09     struct kvm_enc_region *range)
+int kvm_x86_mem_enc_unreg_region(struct kvm *kvm, struct kvm_enc_region *r=
ange)
 {
 =09struct enc_region *region;
 =09int ret;
@@ -7105,12 +7100,12 @@ static int svm_unregister_enc_region(struct kvm *kv=
m,
 =09return ret;
 }
=20
-static bool svm_need_emulation_on_page_fault(struct kvm_vcpu *vcpu)
+bool kvm_x86_need_emulation_on_page_fault(struct kvm_vcpu *vcpu)
 {
 =09unsigned long cr4 =3D kvm_read_cr4(vcpu);
 =09bool smep =3D cr4 & X86_CR4_SMEP;
 =09bool smap =3D cr4 & X86_CR4_SMAP;
-=09bool is_user =3D svm_get_cpl(vcpu) =3D=3D 3;
+=09bool is_user =3D kvm_x86_get_cpl(vcpu) =3D=3D 3;
=20
 =09/*
 =09 * Detect and workaround Errata 1096 Fam_17h_00_0Fh.
@@ -7163,7 +7158,7 @@ static bool svm_need_emulation_on_page_fault(struct k=
vm_vcpu *vcpu)
 =09return false;
 }
=20
-static bool svm_apic_init_signal_blocked(struct kvm_vcpu *vcpu)
+bool kvm_x86_apic_init_signal_blocked(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -7171,7 +7166,7 @@ static bool svm_apic_init_signal_blocked(struct kvm_v=
cpu *vcpu)
 =09 * TODO: Last condition latch INIT signals on vCPU when
 =09 * vCPU is in guest-mode and vmcb12 defines intercept on INIT.
 =09 * To properly emulate the INIT intercept, SVM should implement
-=09 * kvm_x86_ops->check_nested_events() and call nested_svm_vmexit()
+=09 * kvm_x86_check_nested_events() and call nested_svm_vmexit()
 =09 * there if an INIT signal is pending.
 =09 */
 =09return !gif_set(svm) ||
@@ -7179,143 +7174,143 @@ static bool svm_apic_init_signal_blocked(struct k=
vm_vcpu *vcpu)
 }
=20
 static struct kvm_x86_ops svm_x86_ops __ro_after_init =3D {
-=09.cpu_has_kvm_support =3D has_svm,
-=09.disabled_by_bios =3D is_disabled,
-=09.hardware_setup =3D svm_hardware_setup,
-=09.hardware_unsetup =3D svm_hardware_unsetup,
-=09.check_processor_compatibility =3D svm_check_processor_compat,
-=09.hardware_enable =3D svm_hardware_enable,
-=09.hardware_disable =3D svm_hardware_disable,
-=09.cpu_has_accelerated_tpr =3D svm_cpu_has_accelerated_tpr,
-=09.has_emulated_msr =3D svm_has_emulated_msr,
-
-=09.vcpu_create =3D svm_create_vcpu,
-=09.vcpu_free =3D svm_free_vcpu,
-=09.vcpu_reset =3D svm_vcpu_reset,
-
-=09.vm_alloc =3D svm_vm_alloc,
-=09.vm_free =3D svm_vm_free,
-=09.vm_init =3D avic_vm_init,
-=09.vm_destroy =3D svm_vm_destroy,
-
-=09.prepare_guest_switch =3D svm_prepare_guest_switch,
-=09.vcpu_load =3D svm_vcpu_load,
-=09.vcpu_put =3D svm_vcpu_put,
-=09.vcpu_blocking =3D svm_vcpu_blocking,
-=09.vcpu_unblocking =3D svm_vcpu_unblocking,
-
-=09.update_bp_intercept =3D update_bp_intercept,
-=09.get_msr_feature =3D svm_get_msr_feature,
-=09.get_msr =3D svm_get_msr,
-=09.set_msr =3D svm_set_msr,
-=09.get_segment_base =3D svm_get_segment_base,
-=09.get_segment =3D svm_get_segment,
-=09.set_segment =3D svm_set_segment,
-=09.get_cpl =3D svm_get_cpl,
-=09.get_cs_db_l_bits =3D kvm_get_cs_db_l_bits,
-=09.decache_cr0_guest_bits =3D svm_decache_cr0_guest_bits,
-=09.decache_cr3 =3D svm_decache_cr3,
-=09.decache_cr4_guest_bits =3D svm_decache_cr4_guest_bits,
-=09.set_cr0 =3D svm_set_cr0,
-=09.set_cr3 =3D svm_set_cr3,
-=09.set_cr4 =3D svm_set_cr4,
-=09.set_efer =3D svm_set_efer,
-=09.get_idt =3D svm_get_idt,
-=09.set_idt =3D svm_set_idt,
-=09.get_gdt =3D svm_get_gdt,
-=09.set_gdt =3D svm_set_gdt,
-=09.get_dr6 =3D svm_get_dr6,
-=09.set_dr6 =3D svm_set_dr6,
-=09.set_dr7 =3D svm_set_dr7,
-=09.sync_dirty_debug_regs =3D svm_sync_dirty_debug_regs,
-=09.cache_reg =3D svm_cache_reg,
-=09.get_rflags =3D svm_get_rflags,
-=09.set_rflags =3D svm_set_rflags,
-
-=09.tlb_flush =3D svm_flush_tlb,
-=09.tlb_flush_gva =3D svm_flush_tlb_gva,
-
-=09.run =3D svm_vcpu_run,
-=09.handle_exit =3D handle_exit,
-=09.skip_emulated_instruction =3D skip_emulated_instruction,
-=09.set_interrupt_shadow =3D svm_set_interrupt_shadow,
-=09.get_interrupt_shadow =3D svm_get_interrupt_shadow,
-=09.patch_hypercall =3D svm_patch_hypercall,
-=09.set_irq =3D svm_set_irq,
-=09.set_nmi =3D svm_inject_nmi,
-=09.queue_exception =3D svm_queue_exception,
-=09.cancel_injection =3D svm_cancel_injection,
-=09.interrupt_allowed =3D svm_interrupt_allowed,
-=09.nmi_allowed =3D svm_nmi_allowed,
-=09.get_nmi_mask =3D svm_get_nmi_mask,
-=09.set_nmi_mask =3D svm_set_nmi_mask,
-=09.enable_nmi_window =3D enable_nmi_window,
-=09.enable_irq_window =3D enable_irq_window,
-=09.update_cr8_intercept =3D update_cr8_intercept,
-=09.set_virtual_apic_mode =3D svm_set_virtual_apic_mode,
-=09.get_enable_apicv =3D svm_get_enable_apicv,
-=09.refresh_apicv_exec_ctrl =3D svm_refresh_apicv_exec_ctrl,
-=09.load_eoi_exitmap =3D svm_load_eoi_exitmap,
-=09.hwapic_irr_update =3D svm_hwapic_irr_update,
-=09.hwapic_isr_update =3D svm_hwapic_isr_update,
-=09.sync_pir_to_irr =3D kvm_lapic_find_highest_irr,
-=09.apicv_post_state_restore =3D avic_post_state_restore,
-
-=09.set_tss_addr =3D svm_set_tss_addr,
-=09.set_identity_map_addr =3D svm_set_identity_map_addr,
-=09.get_tdp_level =3D get_npt_level,
-=09.get_mt_mask =3D svm_get_mt_mask,
-
-=09.get_exit_info =3D svm_get_exit_info,
-
-=09.get_lpage_level =3D svm_get_lpage_level,
-
-=09.cpuid_update =3D svm_cpuid_update,
-
-=09.rdtscp_supported =3D svm_rdtscp_supported,
-=09.invpcid_supported =3D svm_invpcid_supported,
-=09.mpx_supported =3D svm_mpx_supported,
-=09.xsaves_supported =3D svm_xsaves_supported,
-=09.umip_emulated =3D svm_umip_emulated,
-=09.pt_supported =3D svm_pt_supported,
-
-=09.set_supported_cpuid =3D svm_set_supported_cpuid,
-
-=09.has_wbinvd_exit =3D svm_has_wbinvd_exit,
-
-=09.read_l1_tsc_offset =3D svm_read_l1_tsc_offset,
-=09.write_l1_tsc_offset =3D svm_write_l1_tsc_offset,
-
-=09.set_tdp_cr3 =3D set_tdp_cr3,
-
-=09.check_intercept =3D svm_check_intercept,
-=09.handle_exit_irqoff =3D svm_handle_exit_irqoff,
-
-=09.request_immediate_exit =3D __kvm_request_immediate_exit,
-
-=09.sched_in =3D svm_sched_in,
+=09.cpu_has_kvm_support =3D kvm_x86_cpu_has_kvm_support,
+=09.disabled_by_bios =3D kvm_x86_disabled_by_bios,
+=09.hardware_setup =3D kvm_x86_hardware_setup,
+=09.hardware_unsetup =3D kvm_x86_hardware_unsetup,
+=09.check_processor_compatibility =3D kvm_x86_check_processor_compatibilit=
y,
+=09.hardware_enable =3D kvm_x86_hardware_enable,
+=09.hardware_disable =3D kvm_x86_hardware_disable,
+=09.cpu_has_accelerated_tpr =3D kvm_x86_cpu_has_accelerated_tpr,
+=09.has_emulated_msr =3D kvm_x86_has_emulated_msr,
+
+=09.vcpu_create =3D kvm_x86_vcpu_create,
+=09.vcpu_free =3D kvm_x86_vcpu_free,
+=09.vcpu_reset =3D kvm_x86_vcpu_reset,
+
+=09.vm_alloc =3D kvm_x86_vm_alloc,
+=09.vm_free =3D kvm_x86_vm_free,
+=09.vm_init =3D kvm_x86_vm_init,
+=09.vm_destroy =3D kvm_x86_vm_destroy,
+
+=09.prepare_guest_switch =3D kvm_x86_prepare_guest_switch,
+=09.vcpu_load =3D kvm_x86_vcpu_load,
+=09.vcpu_put =3D kvm_x86_vcpu_put,
+=09.vcpu_blocking =3D kvm_x86_vcpu_blocking,
+=09.vcpu_unblocking =3D kvm_x86_vcpu_unblocking,
+
+=09.update_bp_intercept =3D kvm_x86_update_bp_intercept,
+=09.get_msr_feature =3D kvm_x86_get_msr_feature,
+=09.get_msr =3D kvm_x86_get_msr,
+=09.set_msr =3D kvm_x86_set_msr,
+=09.get_segment_base =3D kvm_x86_get_segment_base,
+=09.get_segment =3D kvm_x86_get_segment,
+=09.set_segment =3D kvm_x86_set_segment,
+=09.get_cpl =3D kvm_x86_get_cpl,
+=09.get_cs_db_l_bits =3D kvm_x86_get_cs_db_l_bits,
+=09.decache_cr0_guest_bits =3D kvm_x86_decache_cr0_guest_bits,
+=09.decache_cr3 =3D kvm_x86_decache_cr3,
+=09.decache_cr4_guest_bits =3D kvm_x86_decache_cr4_guest_bits,
+=09.set_cr0 =3D kvm_x86_set_cr0,
+=09.set_cr3 =3D kvm_x86_set_cr3,
+=09.set_cr4 =3D kvm_x86_set_cr4,
+=09.set_efer =3D kvm_x86_set_efer,
+=09.get_idt =3D kvm_x86_get_idt,
+=09.set_idt =3D kvm_x86_set_idt,
+=09.get_gdt =3D kvm_x86_get_gdt,
+=09.set_gdt =3D kvm_x86_set_gdt,
+=09.get_dr6 =3D kvm_x86_get_dr6,
+=09.set_dr6 =3D kvm_x86_set_dr6,
+=09.set_dr7 =3D kvm_x86_set_dr7,
+=09.sync_dirty_debug_regs =3D kvm_x86_sync_dirty_debug_regs,
+=09.cache_reg =3D kvm_x86_cache_reg,
+=09.get_rflags =3D kvm_x86_get_rflags,
+=09.set_rflags =3D kvm_x86_set_rflags,
+
+=09.tlb_flush =3D kvm_x86_tlb_flush,
+=09.tlb_flush_gva =3D kvm_x86_tlb_flush_gva,
+
+=09.run =3D kvm_x86_run,
+=09.handle_exit =3D kvm_x86_handle_exit,
+=09.skip_emulated_instruction =3D kvm_x86_skip_emulated_instruction,
+=09.set_interrupt_shadow =3D kvm_x86_set_interrupt_shadow,
+=09.get_interrupt_shadow =3D kvm_x86_get_interrupt_shadow,
+=09.patch_hypercall =3D kvm_x86_patch_hypercall,
+=09.set_irq =3D kvm_x86_set_irq,
+=09.set_nmi =3D kvm_x86_set_nmi,
+=09.queue_exception =3D kvm_x86_queue_exception,
+=09.cancel_injection =3D kvm_x86_cancel_injection,
+=09.interrupt_allowed =3D kvm_x86_interrupt_allowed,
+=09.nmi_allowed =3D kvm_x86_nmi_allowed,
+=09.get_nmi_mask =3D kvm_x86_get_nmi_mask,
+=09.set_nmi_mask =3D kvm_x86_set_nmi_mask,
+=09.enable_nmi_window =3D kvm_x86_enable_nmi_window,
+=09.enable_irq_window =3D kvm_x86_enable_irq_window,
+=09.update_cr8_intercept =3D kvm_x86_update_cr8_intercept,
+=09.set_virtual_apic_mode =3D kvm_x86_set_virtual_apic_mode,
+=09.get_enable_apicv =3D kvm_x86_get_enable_apicv,
+=09.refresh_apicv_exec_ctrl =3D kvm_x86_refresh_apicv_exec_ctrl,
+=09.load_eoi_exitmap =3D kvm_x86_load_eoi_exitmap,
+=09.hwapic_irr_update =3D kvm_x86_hwapic_irr_update,
+=09.hwapic_isr_update =3D kvm_x86_hwapic_isr_update,
+=09.sync_pir_to_irr =3D kvm_x86_sync_pir_to_irr,
+=09.apicv_post_state_restore =3D kvm_x86_apicv_post_state_restore,
+
+=09.set_tss_addr =3D kvm_x86_set_tss_addr,
+=09.set_identity_map_addr =3D kvm_x86_set_identity_map_addr,
+=09.get_tdp_level =3D kvm_x86_get_tdp_level,
+=09.get_mt_mask =3D kvm_x86_get_mt_mask,
+
+=09.get_exit_info =3D kvm_x86_get_exit_info,
+
+=09.get_lpage_level =3D kvm_x86_get_lpage_level,
+
+=09.cpuid_update =3D kvm_x86_cpuid_update,
+
+=09.rdtscp_supported =3D kvm_x86_rdtscp_supported,
+=09.invpcid_supported =3D kvm_x86_invpcid_supported,
+=09.mpx_supported =3D kvm_x86_mpx_supported,
+=09.xsaves_supported =3D kvm_x86_xsaves_supported,
+=09.umip_emulated =3D kvm_x86_umip_emulated,
+=09.pt_supported =3D kvm_x86_pt_supported,
+
+=09.set_supported_cpuid =3D kvm_x86_set_supported_cpuid,
+
+=09.has_wbinvd_exit =3D kvm_x86_has_wbinvd_exit,
+
+=09.read_l1_tsc_offset =3D kvm_x86_read_l1_tsc_offset,
+=09.write_l1_tsc_offset =3D kvm_x86_write_l1_tsc_offset,
+
+=09.set_tdp_cr3 =3D kvm_x86_set_tdp_cr3,
+
+=09.check_intercept =3D kvm_x86_check_intercept,
+=09.handle_exit_irqoff =3D kvm_x86_handle_exit_irqoff,
+
+=09.request_immediate_exit =3D kvm_x86_request_immediate_exit,
+
+=09.sched_in =3D kvm_x86_sched_in,
=20
 =09.pmu_ops =3D &amd_pmu_ops,
-=09.deliver_posted_interrupt =3D svm_deliver_avic_intr,
-=09.dy_apicv_has_pending_interrupt =3D svm_dy_apicv_has_pending_interrupt,
-=09.update_pi_irte =3D svm_update_pi_irte,
-=09.setup_mce =3D svm_setup_mce,
+=09.deliver_posted_interrupt =3D kvm_x86_deliver_posted_interrupt,
+=09.dy_apicv_has_pending_interrupt =3D kvm_x86_dy_apicv_has_pending_interr=
upt,
+=09.update_pi_irte =3D kvm_x86_update_pi_irte,
+=09.setup_mce =3D kvm_x86_setup_mce,
=20
-=09.smi_allowed =3D svm_smi_allowed,
-=09.pre_enter_smm =3D svm_pre_enter_smm,
-=09.pre_leave_smm =3D svm_pre_leave_smm,
-=09.enable_smi_window =3D enable_smi_window,
+=09.smi_allowed =3D kvm_x86_smi_allowed,
+=09.pre_enter_smm =3D kvm_x86_pre_enter_smm,
+=09.pre_leave_smm =3D kvm_x86_pre_leave_smm,
+=09.enable_smi_window =3D kvm_x86_enable_smi_window,
=20
-=09.mem_enc_op =3D svm_mem_enc_op,
-=09.mem_enc_reg_region =3D svm_register_enc_region,
-=09.mem_enc_unreg_region =3D svm_unregister_enc_region,
+=09.mem_enc_op =3D kvm_x86_mem_enc_op,
+=09.mem_enc_reg_region =3D kvm_x86_mem_enc_reg_region,
+=09.mem_enc_unreg_region =3D kvm_x86_mem_enc_unreg_region,
=20
 =09.nested_enable_evmcs =3D NULL,
 =09.nested_get_evmcs_version =3D NULL,
=20
-=09.need_emulation_on_page_fault =3D svm_need_emulation_on_page_fault,
+=09.need_emulation_on_page_fault =3D kvm_x86_need_emulation_on_page_fault,
=20
-=09.apic_init_signal_blocked =3D svm_apic_init_signal_blocked,
+=09.apic_init_signal_blocked =3D kvm_x86_apic_init_signal_blocked,
 };
=20
 static int __init svm_init(void)
@@ -7331,3 +7326,130 @@ static void __exit svm_exit(void)
=20
 module_init(svm_init)
 module_exit(svm_exit)
+
+void kvm_x86_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l)
+{
+=09kvm_get_cs_db_l_bits(vcpu, db, l);
+}
+
+int kvm_x86_tlb_remote_flush(struct kvm *kvm)
+{
+=09return kvm_x86_ops->tlb_remote_flush(kvm);
+}
+
+int kvm_x86_tlb_remote_flush_with_range(struct kvm *kvm,
+=09=09=09=09=09struct kvm_tlb_range *range)
+{
+=09return kvm_x86_ops->tlb_remote_flush_with_range(kvm, range);
+}
+
+bool kvm_x86_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
+{
+=09return kvm_x86_ops->guest_apic_has_interrupt(vcpu);
+}
+
+void kvm_x86_set_apic_access_page_addr(struct kvm_vcpu *vcpu, hpa_t hpa)
+{
+=09kvm_x86_ops->set_apic_access_page_addr(vcpu, hpa);
+}
+
+int kvm_x86_sync_pir_to_irr(struct kvm_vcpu *vcpu)
+{
+=09return kvm_lapic_find_highest_irr(vcpu);
+}
+
+int kvm_x86_check_nested_events(struct kvm_vcpu *vcpu, bool external_intr)
+{
+=09return kvm_x86_ops->check_nested_events(vcpu, external_intr);
+}
+
+void kvm_x86_request_immediate_exit(struct kvm_vcpu *vcpu)
+{
+=09__kvm_request_immediate_exit(vcpu);
+}
+
+void kvm_x86_slot_enable_log_dirty(struct kvm *kvm,
+=09=09=09=09   struct kvm_memory_slot *slot)
+{
+=09kvm_x86_ops->slot_enable_log_dirty(kvm, slot);
+}
+
+void kvm_x86_slot_disable_log_dirty(struct kvm *kvm,
+=09=09=09=09    struct kvm_memory_slot *slot)
+{
+=09kvm_x86_ops->slot_disable_log_dirty(kvm, slot);
+}
+
+void kvm_x86_flush_log_dirty(struct kvm *kvm)
+{
+=09kvm_x86_ops->flush_log_dirty(kvm);
+}
+
+void kvm_x86_enable_log_dirty_pt_masked(struct kvm *kvm,
+=09=09=09=09=09struct kvm_memory_slot *slot,
+=09=09=09=09=09gfn_t offset, unsigned long mask)
+{
+=09kvm_x86_ops->enable_log_dirty_pt_masked(kvm, slot, offset, mask);
+}
+
+int kvm_x86_write_log_dirty(struct kvm_vcpu *vcpu)
+{
+=09return kvm_x86_ops->write_log_dirty(vcpu);
+}
+
+int kvm_x86_pre_block(struct kvm_vcpu *vcpu)
+{
+=09return kvm_x86_ops->pre_block(vcpu);
+}
+
+void kvm_x86_post_block(struct kvm_vcpu *vcpu)
+{
+=09kvm_x86_ops->post_block(vcpu);
+}
+
+int kvm_x86_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
+=09=09=09 bool *expired)
+{
+=09return kvm_x86_ops->set_hv_timer(vcpu, guest_deadline_tsc, expired);
+}
+
+void kvm_x86_cancel_hv_timer(struct kvm_vcpu *vcpu)
+{
+=09kvm_x86_ops->cancel_hv_timer(vcpu);
+}
+
+int kvm_x86_get_nested_state(struct kvm_vcpu *vcpu,
+=09=09=09     struct kvm_nested_state __user *user_kvm_nested_state,
+=09=09=09     unsigned user_data_size)
+{
+=09return kvm_x86_ops->get_nested_state(vcpu, user_kvm_nested_state,
+=09=09=09=09=09     user_data_size);
+}
+
+int kvm_x86_set_nested_state(struct kvm_vcpu *vcpu,
+=09=09=09     struct kvm_nested_state __user *user_kvm_nested_state,
+=09=09=09     struct kvm_nested_state *kvm_state)
+{
+=09return kvm_x86_ops->set_nested_state(vcpu, user_kvm_nested_state,
+=09=09=09=09=09     kvm_state);
+}
+
+bool kvm_x86_get_vmcs12_pages(struct kvm_vcpu *vcpu)
+{
+=09return kvm_x86_ops->get_vmcs12_pages(vcpu);
+}
+
+int kvm_x86_nested_enable_evmcs(struct kvm_vcpu *vcpu, uint16_t *vmcs_vers=
ion)
+{
+=09return kvm_x86_ops->nested_enable_evmcs(vcpu, vmcs_version);
+}
+
+uint16_t kvm_x86_nested_get_evmcs_version(struct kvm_vcpu *vcpu)
+{
+=09return kvm_x86_ops->nested_get_evmcs_version(vcpu);
+}
+
+int kvm_x86_enable_direct_tlbflush(struct kvm_vcpu *vcpu)
+{
+=09return kvm_x86_ops->enable_direct_tlbflush(vcpu);
+}
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 7c741a0c5f80..c52bfb96ce40 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -240,7 +240,7 @@ TRACE_EVENT(kvm_exit,
 =09=09__entry->guest_rip=09=3D kvm_rip_read(vcpu);
 =09=09__entry->isa            =3D isa;
 =09=09__entry->vcpu_id        =3D vcpu->vcpu_id;
-=09=09kvm_x86_ops->get_exit_info(vcpu, &__entry->info1,
+=09=09kvm_x86_get_exit_info(vcpu, &__entry->info1,
 =09=09=09=09=09   &__entry->info2);
 =09),
=20
@@ -744,7 +744,7 @@ TRACE_EVENT(kvm_emulate_insn,
 =09=09),
=20
 =09TP_fast_assign(
-=09=09__entry->csbase =3D kvm_x86_ops->get_segment_base(vcpu, VCPU_SREG_CS=
);
+=09=09__entry->csbase =3D kvm_x86_get_segment_base(vcpu, VCPU_SREG_CS);
 =09=09__entry->len =3D vcpu->arch.emulate_ctxt.fetch.ptr
 =09=09=09       - vcpu->arch.emulate_ctxt.fetch.data;
 =09=09__entry->rip =3D vcpu->arch.emulate_ctxt._eip - __entry->len;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 0e7c9301fe86..bb58d323da16 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -152,7 +152,7 @@ static void init_vmcs_shadow_fields(void)
  */
 static int nested_vmx_succeed(struct kvm_vcpu *vcpu)
 {
-=09vmx_set_rflags(vcpu, vmx_get_rflags(vcpu)
+=09kvm_x86_set_rflags(vcpu, kvm_x86_get_rflags(vcpu)
 =09=09=09& ~(X86_EFLAGS_CF | X86_EFLAGS_PF | X86_EFLAGS_AF |
 =09=09=09    X86_EFLAGS_ZF | X86_EFLAGS_SF | X86_EFLAGS_OF));
 =09return kvm_skip_emulated_instruction(vcpu);
@@ -160,7 +160,7 @@ static int nested_vmx_succeed(struct kvm_vcpu *vcpu)
=20
 static int nested_vmx_failInvalid(struct kvm_vcpu *vcpu)
 {
-=09vmx_set_rflags(vcpu, (vmx_get_rflags(vcpu)
+=09kvm_x86_set_rflags(vcpu, (kvm_x86_get_rflags(vcpu)
 =09=09=09& ~(X86_EFLAGS_PF | X86_EFLAGS_AF | X86_EFLAGS_ZF |
 =09=09=09    X86_EFLAGS_SF | X86_EFLAGS_OF))
 =09=09=09| X86_EFLAGS_CF);
@@ -179,7 +179,7 @@ static int nested_vmx_failValid(struct kvm_vcpu *vcpu,
 =09if (vmx->nested.current_vmptr =3D=3D -1ull && !vmx->nested.hv_evmcs)
 =09=09return nested_vmx_failInvalid(vcpu);
=20
-=09vmx_set_rflags(vcpu, (vmx_get_rflags(vcpu)
+=09kvm_x86_set_rflags(vcpu, (kvm_x86_get_rflags(vcpu)
 =09=09=09& ~(X86_EFLAGS_CF | X86_EFLAGS_PF | X86_EFLAGS_AF |
 =09=09=09    X86_EFLAGS_SF | X86_EFLAGS_OF))
 =09=09=09| X86_EFLAGS_ZF);
@@ -353,7 +353,7 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu=
 *vcpu)
 =09=09=09VMX_EPT_EXECUTE_ONLY_BIT,
 =09=09=09nested_ept_ad_enabled(vcpu),
 =09=09=09nested_ept_get_cr3(vcpu));
-=09vcpu->arch.mmu->set_cr3           =3D vmx_set_cr3;
+=09vcpu->arch.mmu->set_cr3           =3D kvm_x86_set_cr3;
 =09vcpu->arch.mmu->get_cr3           =3D nested_ept_get_cr3;
 =09vcpu->arch.mmu->inject_page_fault =3D nested_ept_inject_page_fault;
 =09vcpu->arch.mmu->get_pdptr         =3D kvm_pdptr_read;
@@ -2125,10 +2125,10 @@ static void prepare_vmcs02_early(struct vcpu_vmx *v=
mx, struct vmcs12 *vmcs12)
 =09=09exec_control &=3D ~SECONDARY_EXEC_SHADOW_VMCS;
=20
 =09=09/*
-=09=09 * Preset *DT exiting when emulating UMIP, so that vmx_set_cr4()
+=09=09 * Preset *DT exiting when emulating UMIP, so that kvm_x86_set_cr4()
 =09=09 * will not have to rewrite the controls just for this bit.
 =09=09 */
-=09=09if (!boot_cpu_has(X86_FEATURE_UMIP) && vmx_umip_emulated() &&
+=09=09if (!boot_cpu_has(X86_FEATURE_UMIP) && kvm_x86_umip_emulated() &&
 =09=09    (vmcs12->guest_cr4 & X86_CR4_UMIP))
 =09=09=09exec_control |=3D SECONDARY_EXEC_DESC;
=20
@@ -2143,9 +2143,9 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx=
, struct vmcs12 *vmcs12)
 =09 * ENTRY CONTROLS
 =09 *
 =09 * vmcs12's VM_{ENTRY,EXIT}_LOAD_IA32_EFER and VM_ENTRY_IA32E_MODE
-=09 * are emulated by vmx_set_efer() in prepare_vmcs02(), but speculate
+=09 * are emulated by kvm_x86_set_efer() in prepare_vmcs02(), but speculat=
e
 =09 * on the related bits (if supported by the CPU) in the hope that
-=09 * we can avoid VMWrites during vmx_set_efer().
+=09 * we can avoid VMWrites during kvm_x86_set_efer().
 =09 */
 =09exec_control =3D (vmcs12->vm_entry_controls | vmx_vmentry_ctrl()) &
 =09=09=09~VM_ENTRY_IA32E_MODE & ~VM_ENTRY_LOAD_IA32_EFER;
@@ -2162,7 +2162,7 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx=
, struct vmcs12 *vmcs12)
 =09 *
 =09 * L2->L1 exit controls are emulated - the hardware exit is to L0 so
 =09 * we should use its exit controls. Note that VM_EXIT_LOAD_IA32_EFER
-=09 * bits may be modified by vmx_set_efer() in prepare_vmcs02().
+=09 * bits may be modified by kvm_x86_set_efer() in prepare_vmcs02().
 =09 */
 =09exec_control =3D vmx_vmexit_ctrl();
 =09if (cpu_has_load_ia32_efer() && guest_efer !=3D host_efer)
@@ -2329,13 +2329,13 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, st=
ruct vmcs12 *vmcs12,
 =09if (kvm_mpx_supported() && (!vmx->nested.nested_run_pending ||
 =09    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
 =09=09vmcs_write64(GUEST_BNDCFGS, vmx->nested.vmcs01_guest_bndcfgs);
-=09vmx_set_rflags(vcpu, vmcs12->guest_rflags);
+=09kvm_x86_set_rflags(vcpu, vmcs12->guest_rflags);
=20
 =09/* EXCEPTION_BITMAP and CR0_GUEST_HOST_MASK should basically be the
 =09 * bitwise-or of what L1 wants to trap for L2, and what we want to
 =09 * trap. Note that CR0.TS also needs updating - we do this later.
 =09 */
-=09update_exception_bitmap(vcpu);
+=09kvm_x86_update_bp_intercept(vcpu);
 =09vcpu->arch.cr0_guest_owned_bits &=3D ~vmcs12->cr0_guest_host_mask;
 =09vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.cr0_guest_owned_bits);
=20
@@ -2383,7 +2383,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, stru=
ct vmcs12 *vmcs12,
 =09=09nested_ept_init_mmu_context(vcpu);
 =09else if (nested_cpu_has2(vmcs12,
 =09=09=09=09 SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES))
-=09=09vmx_flush_tlb(vcpu, true);
+=09=09kvm_x86_tlb_flush(vcpu, true);
=20
 =09/*
 =09 * This sets GUEST_CR0 to vmcs12->guest_cr0, possibly modifying those
@@ -2393,15 +2393,15 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, st=
ruct vmcs12 *vmcs12,
 =09 * vmcs12->cr0_read_shadow because on our cr0_guest_host_mask we we
 =09 * have more bits than L1 expected.
 =09 */
-=09vmx_set_cr0(vcpu, vmcs12->guest_cr0);
+=09kvm_x86_set_cr0(vcpu, vmcs12->guest_cr0);
 =09vmcs_writel(CR0_READ_SHADOW, nested_read_cr0(vmcs12));
=20
-=09vmx_set_cr4(vcpu, vmcs12->guest_cr4);
+=09kvm_x86_set_cr4(vcpu, vmcs12->guest_cr4);
 =09vmcs_writel(CR4_READ_SHADOW, nested_read_cr4(vmcs12));
=20
 =09vcpu->arch.efer =3D nested_vmx_calc_efer(vmx, vmcs12);
 =09/* Note: may modify VM_ENTRY/EXIT_CONTROLS and GUEST/HOST_IA32_EFER */
-=09vmx_set_efer(vcpu, vcpu->arch.efer);
+=09kvm_x86_set_efer(vcpu, vcpu->arch.efer);
=20
 =09/*
 =09 * Guest state is invalid and unrestricted guest is disabled,
@@ -2825,7 +2825,7 @@ static int nested_vmx_check_vmentry_hw(struct kvm_vcp=
u *vcpu)
=20
 =09preempt_disable();
=20
-=09vmx_prepare_switch_to_guest(vcpu);
+=09kvm_x86_prepare_guest_switch(vcpu);
=20
 =09/*
 =09 * Induce a consistency check VMExit by clearing bit 1 in GUEST_RFLAGS,
@@ -3010,7 +3010,7 @@ static int nested_vmx_check_permission(struct kvm_vcp=
u *vcpu)
 =09=09return 0;
 =09}
=20
-=09if (vmx_get_cpl(vcpu)) {
+=09if (kvm_x86_get_cpl(vcpu)) {
 =09=09kvm_inject_gp(vcpu, 0);
 =09=09return 0;
 =09}
@@ -3187,7 +3187,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool=
 launch)
 =09struct vmcs12 *vmcs12;
 =09enum nvmx_vmentry_status status;
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
-=09u32 interrupt_shadow =3D vmx_get_interrupt_shadow(vcpu);
+=09u32 interrupt_shadow =3D kvm_x86_get_interrupt_shadow(vcpu);
=20
 =09if (!nested_vmx_check_permission(vcpu))
 =09=09return 1;
@@ -3443,7 +3443,7 @@ static void nested_vmx_inject_exception_vmexit(struct=
 kvm_vcpu *vcpu,
 =09=09intr_info |=3D INTR_TYPE_HARD_EXCEPTION;
=20
 =09if (!(vmcs12->idt_vectoring_info_field & VECTORING_INFO_VALID_MASK) &&
-=09    vmx_get_nmi_mask(vcpu))
+=09    kvm_x86_get_nmi_mask(vcpu))
 =09=09intr_info |=3D INTR_INFO_UNBLOCK_NMI;
=20
 =09nested_vmx_vmexit(vcpu, EXIT_REASON_EXCEPTION_NMI, intr_info, exit_qual=
);
@@ -3492,7 +3492,7 @@ static int vmx_check_nested_events(struct kvm_vcpu *v=
cpu, bool external_intr)
 =09=09 * clear this one and block further NMIs.
 =09=09 */
 =09=09vcpu->arch.nmi_pending =3D 0;
-=09=09vmx_set_nmi_mask(vcpu, true);
+=09=09kvm_x86_set_nmi_mask(vcpu, true);
 =09=09return 0;
 =09}
=20
@@ -3630,12 +3630,12 @@ static void copy_vmcs02_to_vmcs12_rare(struct kvm_v=
cpu *vcpu,
=20
 =09cpu =3D get_cpu();
 =09vmx->loaded_vmcs =3D &vmx->nested.vmcs02;
-=09vmx_vcpu_load(&vmx->vcpu, cpu);
+=09kvm_x86_vcpu_load(&vmx->vcpu, cpu);
=20
 =09sync_vmcs02_to_vmcs12_rare(vcpu, vmcs12);
=20
 =09vmx->loaded_vmcs =3D &vmx->vmcs01;
-=09vmx_vcpu_load(&vmx->vcpu, cpu);
+=09kvm_x86_vcpu_load(&vmx->vcpu, cpu);
 =09put_cpu();
 }
=20
@@ -3795,12 +3795,12 @@ static void load_vmcs12_host_state(struct kvm_vcpu =
*vcpu,
 =09=09vcpu->arch.efer |=3D (EFER_LMA | EFER_LME);
 =09else
 =09=09vcpu->arch.efer &=3D ~(EFER_LMA | EFER_LME);
-=09vmx_set_efer(vcpu, vcpu->arch.efer);
+=09kvm_x86_set_efer(vcpu, vcpu->arch.efer);
=20
 =09kvm_rsp_write(vcpu, vmcs12->host_rsp);
 =09kvm_rip_write(vcpu, vmcs12->host_rip);
-=09vmx_set_rflags(vcpu, X86_EFLAGS_FIXED);
-=09vmx_set_interrupt_shadow(vcpu, 0);
+=09kvm_x86_set_rflags(vcpu, X86_EFLAGS_FIXED);
+=09kvm_x86_set_interrupt_shadow(vcpu, 0);
=20
 =09/*
 =09 * Note that calling vmx_set_cr0 is important, even if cr0 hasn't
@@ -3810,11 +3810,11 @@ static void load_vmcs12_host_state(struct kvm_vcpu =
*vcpu,
 =09 * (KVM doesn't change it);
 =09 */
 =09vcpu->arch.cr0_guest_owned_bits =3D X86_CR0_TS;
-=09vmx_set_cr0(vcpu, vmcs12->host_cr0);
+=09kvm_x86_set_cr0(vcpu, vmcs12->host_cr0);
=20
 =09/* Same as above - no reason to call set_cr4_guest_host_mask().  */
 =09vcpu->arch.cr4_guest_owned_bits =3D ~vmcs_readl(CR4_GUEST_HOST_MASK);
-=09vmx_set_cr4(vcpu, vmcs12->host_cr4);
+=09kvm_x86_set_cr4(vcpu, vmcs12->host_cr4);
=20
 =09nested_ept_uninit_mmu_context(vcpu);
=20
@@ -3882,7 +3882,7 @@ static void load_vmcs12_host_state(struct kvm_vcpu *v=
cpu,
 =09=09seg.l =3D 1;
 =09else
 =09=09seg.db =3D 1;
-=09vmx_set_segment(vcpu, &seg, VCPU_SREG_CS);
+=09kvm_x86_set_segment(vcpu, &seg, VCPU_SREG_CS);
 =09seg =3D (struct kvm_segment) {
 =09=09.base =3D 0,
 =09=09.limit =3D 0xFFFFFFFF,
@@ -3893,17 +3893,17 @@ static void load_vmcs12_host_state(struct kvm_vcpu =
*vcpu,
 =09=09.g =3D 1
 =09};
 =09seg.selector =3D vmcs12->host_ds_selector;
-=09vmx_set_segment(vcpu, &seg, VCPU_SREG_DS);
+=09kvm_x86_set_segment(vcpu, &seg, VCPU_SREG_DS);
 =09seg.selector =3D vmcs12->host_es_selector;
-=09vmx_set_segment(vcpu, &seg, VCPU_SREG_ES);
+=09kvm_x86_set_segment(vcpu, &seg, VCPU_SREG_ES);
 =09seg.selector =3D vmcs12->host_ss_selector;
-=09vmx_set_segment(vcpu, &seg, VCPU_SREG_SS);
+=09kvm_x86_set_segment(vcpu, &seg, VCPU_SREG_SS);
 =09seg.selector =3D vmcs12->host_fs_selector;
 =09seg.base =3D vmcs12->host_fs_base;
-=09vmx_set_segment(vcpu, &seg, VCPU_SREG_FS);
+=09kvm_x86_set_segment(vcpu, &seg, VCPU_SREG_FS);
 =09seg.selector =3D vmcs12->host_gs_selector;
 =09seg.base =3D vmcs12->host_gs_base;
-=09vmx_set_segment(vcpu, &seg, VCPU_SREG_GS);
+=09kvm_x86_set_segment(vcpu, &seg, VCPU_SREG_GS);
 =09seg =3D (struct kvm_segment) {
 =09=09.base =3D vmcs12->host_tr_base,
 =09=09.limit =3D 0x67,
@@ -3911,7 +3911,7 @@ static void load_vmcs12_host_state(struct kvm_vcpu *v=
cpu,
 =09=09.type =3D 11,
 =09=09.present =3D 1
 =09};
-=09vmx_set_segment(vcpu, &seg, VCPU_SREG_TR);
+=09kvm_x86_set_segment(vcpu, &seg, VCPU_SREG_TR);
=20
 =09kvm_set_dr(vcpu, 7, 0x400);
 =09vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
@@ -3974,13 +3974,13 @@ static void nested_vmx_restore_host_state(struct kv=
m_vcpu *vcpu)
 =09 * Note that calling vmx_set_{efer,cr0,cr4} is important as they
 =09 * handle a variety of side effects to KVM's software model.
 =09 */
-=09vmx_set_efer(vcpu, nested_vmx_get_vmcs01_guest_efer(vmx));
+=09kvm_x86_set_efer(vcpu, nested_vmx_get_vmcs01_guest_efer(vmx));
=20
 =09vcpu->arch.cr0_guest_owned_bits =3D X86_CR0_TS;
-=09vmx_set_cr0(vcpu, vmcs_readl(CR0_READ_SHADOW));
+=09kvm_x86_set_cr0(vcpu, vmcs_readl(CR0_READ_SHADOW));
=20
 =09vcpu->arch.cr4_guest_owned_bits =3D ~vmcs_readl(CR4_GUEST_HOST_MASK);
-=09vmx_set_cr4(vcpu, vmcs_readl(CR4_READ_SHADOW));
+=09kvm_x86_set_cr4(vcpu, vmcs_readl(CR4_READ_SHADOW));
=20
 =09nested_ept_uninit_mmu_context(vcpu);
 =09vcpu->arch.cr3 =3D vmcs_readl(GUEST_CR3);
@@ -4118,11 +4118,11 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 e=
xit_reason,
=20
 =09if (vmx->nested.change_vmcs01_virtual_apic_mode) {
 =09=09vmx->nested.change_vmcs01_virtual_apic_mode =3D false;
-=09=09vmx_set_virtual_apic_mode(vcpu);
+=09=09kvm_x86_set_virtual_apic_mode(vcpu);
 =09} else if (!nested_cpu_has_ept(vmcs12) &&
 =09=09   nested_cpu_has2(vmcs12,
 =09=09=09=09   SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
-=09=09vmx_flush_tlb(vcpu, true);
+=09=09kvm_x86_tlb_flush(vcpu, true);
 =09}
=20
 =09/* Unpin physical memory we referred to in vmcs02 */
@@ -4243,7 +4243,7 @@ int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsign=
ed long exit_qualification,
 =09=09off +=3D kvm_register_read(vcpu, base_reg);
 =09if (index_is_valid)
 =09=09off +=3D kvm_register_read(vcpu, index_reg)<<scaling;
-=09vmx_get_segment(vcpu, &s, seg_reg);
+=09kvm_x86_get_segment(vcpu, &s, seg_reg);
=20
 =09/*
 =09 * The effective address, i.e. @off, of a memory operand is truncated
@@ -4440,7 +4440,7 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 =09/*
 =09 * The Intel VMX Instruction Reference lists a bunch of bits that are
 =09 * prerequisite to running VMXON, most notably cr4.VMXE must be set to
-=09 * 1 (see vmx_set_cr4() for when we allow the guest to set this).
+=09 * 1 (see kvm_x86_set_cr4() for when we allow the guest to set this).
 =09 * Otherwise, we should fail with #UD.  But most faulting conditions
 =09 * have already been checked by hardware, prior to the VM-exit for
 =09 * VMXON.  We do test guest cr4.VMXE because processor CR4 always has
@@ -4452,7 +4452,7 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 =09}
=20
 =09/* CPL=3D0 must be checked manually. */
-=09if (vmx_get_cpl(vcpu)) {
+=09if (kvm_x86_get_cpl(vcpu)) {
 =09=09kvm_inject_gp(vcpu, 0);
 =09=09return 1;
 =09}
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 3e9c059099e9..2fa9ae5acde1 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -64,9 +64,8 @@ static void global_ctrl_changed(struct kvm_pmu *pmu, u64 =
data)
 =09=09reprogram_counter(pmu, bit);
 }
=20
-static unsigned intel_find_arch_event(struct kvm_pmu *pmu,
-=09=09=09=09      u8 event_select,
-=09=09=09=09      u8 unit_mask)
+unsigned kvm_x86_pmu_find_arch_event(struct kvm_pmu *pmu, u8 event_select,
+=09=09=09=09     u8 unit_mask)
 {
 =09int i;
=20
@@ -82,7 +81,7 @@ static unsigned intel_find_arch_event(struct kvm_pmu *pmu=
,
 =09return intel_arch_events[i].event_type;
 }
=20
-static unsigned intel_find_fixed_event(int idx)
+unsigned kvm_x86_pmu_find_fixed_event(int idx)
 {
 =09if (idx >=3D ARRAY_SIZE(fixed_pmc_events))
 =09=09return PERF_COUNT_HW_MAX;
@@ -91,14 +90,14 @@ static unsigned intel_find_fixed_event(int idx)
 }
=20
 /* check if a PMC is enabled by comparing it with globl_ctrl bits. */
-static bool intel_pmc_is_enabled(struct kvm_pmc *pmc)
+bool kvm_x86_pmu_pmc_is_enabled(struct kvm_pmc *pmc)
 {
 =09struct kvm_pmu *pmu =3D pmc_to_pmu(pmc);
=20
 =09return test_bit(pmc->idx, (unsigned long *)&pmu->global_ctrl);
 }
=20
-static struct kvm_pmc *intel_pmc_idx_to_pmc(struct kvm_pmu *pmu, int pmc_i=
dx)
+struct kvm_pmc *kvm_x86_pmu_pmc_idx_to_pmc(struct kvm_pmu *pmu, int pmc_id=
x)
 {
 =09if (pmc_idx < INTEL_PMC_IDX_FIXED)
 =09=09return get_gp_pmc(pmu, MSR_P6_EVNTSEL0 + pmc_idx,
@@ -111,7 +110,7 @@ static struct kvm_pmc *intel_pmc_idx_to_pmc(struct kvm_=
pmu *pmu, int pmc_idx)
 }
=20
 /* returns 0 if idx's corresponding MSR exists; otherwise returns 1. */
-static int intel_is_valid_msr_idx(struct kvm_vcpu *vcpu, unsigned idx)
+int kvm_x86_pmu_is_valid_msr_idx(struct kvm_vcpu *vcpu, unsigned idx)
 {
 =09struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
 =09bool fixed =3D idx & (1u << 30);
@@ -122,8 +121,8 @@ static int intel_is_valid_msr_idx(struct kvm_vcpu *vcpu=
, unsigned idx)
 =09=09(fixed && idx >=3D pmu->nr_arch_fixed_counters);
 }
=20
-static struct kvm_pmc *intel_msr_idx_to_pmc(struct kvm_vcpu *vcpu,
-=09=09=09=09=09    unsigned idx, u64 *mask)
+struct kvm_pmc *kvm_x86_pmu_msr_idx_to_pmc(struct kvm_vcpu *vcpu, unsigned=
 idx,
+=09=09=09=09=09   u64 *mask)
 {
 =09struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
 =09bool fixed =3D idx & (1u << 30);
@@ -140,7 +139,7 @@ static struct kvm_pmc *intel_msr_idx_to_pmc(struct kvm_=
vcpu *vcpu,
 =09return &counters[idx];
 }
=20
-static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
+bool kvm_x86_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 {
 =09struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
 =09int ret;
@@ -162,7 +161,7 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u=
32 msr)
 =09return ret;
 }
=20
-static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
+int kvm_x86_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 {
 =09struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
 =09struct kvm_pmc *pmc;
@@ -198,7 +197,7 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, u32=
 msr, u64 *data)
 =09return 1;
 }
=20
-static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_i=
nfo)
+int kvm_x86_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 =09struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
 =09struct kvm_pmc *pmc;
@@ -259,7 +258,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, str=
uct msr_data *msr_info)
 =09return 1;
 }
=20
-static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
+void kvm_x86_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 =09struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
 =09struct x86_pmu_capability x86_pmu;
@@ -308,7 +307,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 =09pmu->global_ovf_ctrl_mask =3D pmu->global_ctrl_mask
 =09=09=09& ~(MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF |
 =09=09=09    MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD);
-=09if (kvm_x86_ops->pt_supported())
+=09if (kvm_x86_pt_supported())
 =09=09pmu->global_ovf_ctrl_mask &=3D
 =09=09=09=09~MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI;
=20
@@ -319,7 +318,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 =09=09pmu->reserved_bits ^=3D HSW_IN_TX|HSW_IN_TX_CHECKPOINTED;
 }
=20
-static void intel_pmu_init(struct kvm_vcpu *vcpu)
+void kvm_x86_pmu_init(struct kvm_vcpu *vcpu)
 {
 =09int i;
 =09struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
@@ -337,7 +336,7 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
 =09}
 }
=20
-static void intel_pmu_reset(struct kvm_vcpu *vcpu)
+void kvm_x86_pmu_reset(struct kvm_vcpu *vcpu)
 {
 =09struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
 =09struct kvm_pmc *pmc =3D NULL;
@@ -362,16 +361,16 @@ static void intel_pmu_reset(struct kvm_vcpu *vcpu)
 }
=20
 struct kvm_pmu_ops intel_pmu_ops =3D {
-=09.find_arch_event =3D intel_find_arch_event,
-=09.find_fixed_event =3D intel_find_fixed_event,
-=09.pmc_is_enabled =3D intel_pmc_is_enabled,
-=09.pmc_idx_to_pmc =3D intel_pmc_idx_to_pmc,
-=09.msr_idx_to_pmc =3D intel_msr_idx_to_pmc,
-=09.is_valid_msr_idx =3D intel_is_valid_msr_idx,
-=09.is_valid_msr =3D intel_is_valid_msr,
-=09.get_msr =3D intel_pmu_get_msr,
-=09.set_msr =3D intel_pmu_set_msr,
-=09.refresh =3D intel_pmu_refresh,
-=09.init =3D intel_pmu_init,
-=09.reset =3D intel_pmu_reset,
+=09.find_arch_event =3D kvm_x86_pmu_find_arch_event,
+=09.find_fixed_event =3D kvm_x86_pmu_find_fixed_event,
+=09.pmc_is_enabled =3D kvm_x86_pmu_pmc_is_enabled,
+=09.pmc_idx_to_pmc =3D kvm_x86_pmu_pmc_idx_to_pmc,
+=09.msr_idx_to_pmc =3D kvm_x86_pmu_msr_idx_to_pmc,
+=09.is_valid_msr_idx =3D kvm_x86_pmu_is_valid_msr_idx,
+=09.is_valid_msr =3D kvm_x86_pmu_is_valid_msr,
+=09.get_msr =3D kvm_x86_pmu_get_msr,
+=09.set_msr =3D kvm_x86_pmu_set_msr,
+=09.refresh =3D kvm_x86_pmu_refresh,
+=09.init =3D kvm_x86_pmu_init,
+=09.reset =3D kvm_x86_pmu_reset,
 };
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5d21a4ab28cf..bd17ad61f7e3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -613,7 +613,7 @@ static inline bool cpu_need_virtualize_apic_accesses(st=
ruct kvm_vcpu *vcpu)
 =09return flexpriority_enabled && lapic_in_kernel(vcpu);
 }
=20
-static inline bool report_flexpriority(void)
+bool kvm_x86_cpu_has_accelerated_tpr(void)
 {
 =09return flexpriority_enabled;
 }
@@ -771,7 +771,7 @@ static u32 vmx_read_guest_seg_ar(struct vcpu_vmx *vmx, =
unsigned seg)
 =09return *p;
 }
=20
-void update_exception_bitmap(struct kvm_vcpu *vcpu)
+void kvm_x86_update_bp_intercept(struct kvm_vcpu *vcpu)
 {
 =09u32 eb;
=20
@@ -1127,7 +1127,7 @@ void vmx_set_host_fs_gs(struct vmcs_host_state *host,=
 u16 fs_sel, u16 gs_sel,
 =09}
 }
=20
-void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
+void kvm_x86_prepare_guest_switch(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09struct vmcs_host_state *host_state;
@@ -1362,7 +1362,7 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cp=
u)
  * Switches to specified vcpu, until a matching vcpu_put(), but assumes
  * vcpu mutex is already taken.
  */
-void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+void kvm_x86_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
=20
@@ -1388,7 +1388,7 @@ static void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu)
 =09=09pi_set_sn(pi_desc);
 }
=20
-static void vmx_vcpu_put(struct kvm_vcpu *vcpu)
+void kvm_x86_vcpu_put(struct kvm_vcpu *vcpu)
 {
 =09vmx_vcpu_pi_put(vcpu);
=20
@@ -1400,9 +1400,8 @@ static bool emulation_required(struct kvm_vcpu *vcpu)
 =09return emulate_invalid_guest_state && !guest_state_valid(vcpu);
 }
=20
-static void vmx_decache_cr0_guest_bits(struct kvm_vcpu *vcpu);
=20
-unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu)
+unsigned long kvm_x86_get_rflags(struct kvm_vcpu *vcpu)
 {
 =09unsigned long rflags, save_rflags;
=20
@@ -1419,9 +1418,9 @@ unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu)
 =09return to_vmx(vcpu)->rflags;
 }
=20
-void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
+void kvm_x86_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
 {
-=09unsigned long old_rflags =3D vmx_get_rflags(vcpu);
+=09unsigned long old_rflags =3D kvm_x86_get_rflags(vcpu);
=20
 =09__set_bit(VCPU_EXREG_RFLAGS, (ulong *)&vcpu->arch.regs_avail);
 =09to_vmx(vcpu)->rflags =3D rflags;
@@ -1435,7 +1434,7 @@ void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned l=
ong rflags)
 =09=09to_vmx(vcpu)->emulation_required =3D emulation_required(vcpu);
 }
=20
-u32 vmx_get_interrupt_shadow(struct kvm_vcpu *vcpu)
+u32 kvm_x86_get_interrupt_shadow(struct kvm_vcpu *vcpu)
 {
 =09u32 interruptibility =3D vmcs_read32(GUEST_INTERRUPTIBILITY_INFO);
 =09int ret =3D 0;
@@ -1448,7 +1447,7 @@ u32 vmx_get_interrupt_shadow(struct kvm_vcpu *vcpu)
 =09return ret;
 }
=20
-void vmx_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask)
+void kvm_x86_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask)
 {
 =09u32 interruptibility_old =3D vmcs_read32(GUEST_INTERRUPTIBILITY_INFO);
 =09u32 interruptibility =3D interruptibility_old;
@@ -1536,7 +1535,7 @@ static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, =
u64 data)
 =09return 0;
 }
=20
-static int skip_emulated_instruction(struct kvm_vcpu *vcpu)
+int kvm_x86_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
 =09unsigned long rip;
=20
@@ -1559,7 +1558,7 @@ static int skip_emulated_instruction(struct kvm_vcpu =
*vcpu)
 =09}
=20
 =09/* skipping an emulated instruction also counts */
-=09vmx_set_interrupt_shadow(vcpu, 0);
+=09kvm_x86_set_interrupt_shadow(vcpu, 0);
=20
 =09return 1;
 }
@@ -1577,7 +1576,7 @@ static void vmx_clear_hlt(struct kvm_vcpu *vcpu)
 =09=09vmcs_write32(GUEST_ACTIVITY_STATE, GUEST_ACTIVITY_ACTIVE);
 }
=20
-static void vmx_queue_exception(struct kvm_vcpu *vcpu)
+void kvm_x86_queue_exception(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09unsigned nr =3D vcpu->arch.exception.nr;
@@ -1614,12 +1613,12 @@ static void vmx_queue_exception(struct kvm_vcpu *vc=
pu)
 =09vmx_clear_hlt(vcpu);
 }
=20
-static bool vmx_rdtscp_supported(void)
+bool kvm_x86_rdtscp_supported(void)
 {
 =09return cpu_has_vmx_rdtscp();
 }
=20
-static bool vmx_invpcid_supported(void)
+bool kvm_x86_invpcid_supported(void)
 {
 =09return cpu_has_vmx_invpcid();
 }
@@ -1677,7 +1676,7 @@ static void setup_msrs(struct vcpu_vmx *vmx)
 =09=09vmx_update_msr_bitmap(&vmx->vcpu);
 }
=20
-static u64 vmx_read_l1_tsc_offset(struct kvm_vcpu *vcpu)
+u64 kvm_x86_read_l1_tsc_offset(struct kvm_vcpu *vcpu)
 {
 =09struct vmcs12 *vmcs12 =3D get_vmcs12(vcpu);
=20
@@ -1688,7 +1687,7 @@ static u64 vmx_read_l1_tsc_offset(struct kvm_vcpu *vc=
pu)
 =09return vcpu->arch.tsc_offset;
 }
=20
-static u64 vmx_write_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
+u64 kvm_x86_write_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 {
 =09struct vmcs12 *vmcs12 =3D get_vmcs12(vcpu);
 =09u64 g_tsc_offset =3D 0;
@@ -1729,7 +1728,7 @@ static inline bool vmx_feature_control_msr_valid(stru=
ct kvm_vcpu *vcpu,
 =09return !(val & ~valid_bits);
 }
=20
-static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
+int kvm_x86_get_msr_feature(struct kvm_msr_entry *msr)
 {
 =09switch (msr->index) {
 =09case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
@@ -1748,7 +1747,7 @@ static int vmx_get_msr_feature(struct kvm_msr_entry *=
msr)
  * Returns 0 on success, non-0 otherwise.
  * Assumes vcpu_load() was already called.
  */
-static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+int kvm_x86_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09struct shared_msr_entry *msr;
@@ -1813,7 +1812,7 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct =
msr_data *msr_info)
 =09=09return vmx_get_vmx_msr(&vmx->nested.msrs, msr_info->index,
 =09=09=09=09       &msr_info->data);
 =09case MSR_IA32_XSS:
-=09=09if (!vmx_xsaves_supported() ||
+=09=09if (!kvm_x86_xsaves_supported() ||
 =09=09    (!msr_info->host_initiated &&
 =09=09     !(guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
 =09=09       guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))))
@@ -1888,7 +1887,7 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct =
msr_data *msr_info)
  * Returns 0 on success, non-0 otherwise.
  * Assumes vcpu_load() was already called.
  */
-static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+int kvm_x86_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09struct shared_msr_entry *msr;
@@ -2056,7 +2055,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct =
msr_data *msr_info)
 =09=09=09return 1;
 =09=09return vmx_set_vmx_msr(vcpu, msr_index, data);
 =09case MSR_IA32_XSS:
-=09=09if (!vmx_xsaves_supported() ||
+=09=09if (!kvm_x86_xsaves_supported() ||
 =09=09    (!msr_info->host_initiated &&
 =09=09     !(guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
 =09=09       guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))))
@@ -2160,7 +2159,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct =
msr_data *msr_info)
 =09return ret;
 }
=20
-static void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
+void kvm_x86_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
 {
 =09__set_bit(reg, (unsigned long *)&vcpu->arch.regs_avail);
 =09switch (reg) {
@@ -2179,12 +2178,12 @@ static void vmx_cache_reg(struct kvm_vcpu *vcpu, en=
um kvm_reg reg)
 =09}
 }
=20
-static __init int cpu_has_kvm_support(void)
+__init int kvm_x86_cpu_has_kvm_support(void)
 {
 =09return cpu_has_vmx();
 }
=20
-static __init int vmx_disabled_by_bios(void)
+__init int kvm_x86_disabled_by_bios(void)
 {
 =09u64 msr;
=20
@@ -2219,7 +2218,7 @@ static void kvm_cpu_vmxon(u64 addr)
 =09asm volatile ("vmxon %0" : : "m"(addr));
 }
=20
-static int hardware_enable(void)
+int kvm_x86_hardware_enable(void)
 {
 =09int cpu =3D raw_smp_processor_id();
 =09u64 phys_addr =3D __pa(per_cpu(vmxarea, cpu));
@@ -2291,7 +2290,7 @@ static void kvm_cpu_vmxoff(void)
 =09cr4_clear_bits(X86_CR4_VMXE);
 }
=20
-static void hardware_disable(void)
+void kvm_x86_hardware_disable(void)
 {
 =09vmclear_local_loaded_vmcss();
 =09kvm_cpu_vmxoff();
@@ -2651,7 +2650,7 @@ static void fix_pmode_seg(struct kvm_vcpu *vcpu, int =
seg,
 =09=09save->dpl =3D save->selector & SEGMENT_RPL_MASK;
 =09=09save->s =3D 1;
 =09}
-=09vmx_set_segment(vcpu, save, seg);
+=09kvm_x86_set_segment(vcpu, save, seg);
 }
=20
 static void enter_pmode(struct kvm_vcpu *vcpu)
@@ -2663,18 +2662,18 @@ static void enter_pmode(struct kvm_vcpu *vcpu)
 =09 * Update real mode segment cache. It may be not up-to-date if sement
 =09 * register was written while vcpu was in a guest mode.
 =09 */
-=09vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_ES], VCPU_SREG_ES);
-=09vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_DS], VCPU_SREG_DS);
-=09vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_FS], VCPU_SREG_FS);
-=09vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_GS], VCPU_SREG_GS);
-=09vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_SS], VCPU_SREG_SS);
-=09vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_CS], VCPU_SREG_CS);
+=09kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_ES], VCPU_SREG_ES)=
;
+=09kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_DS], VCPU_SREG_DS)=
;
+=09kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_FS], VCPU_SREG_FS)=
;
+=09kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_GS], VCPU_SREG_GS)=
;
+=09kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_SS], VCPU_SREG_SS)=
;
+=09kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_CS], VCPU_SREG_CS)=
;
=20
 =09vmx->rmode.vm86_active =3D 0;
=20
 =09vmx_segment_cache_clear(vmx);
=20
-=09vmx_set_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_TR], VCPU_SREG_TR);
+=09kvm_x86_set_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_TR], VCPU_SREG_TR)=
;
=20
 =09flags =3D vmcs_readl(GUEST_RFLAGS);
 =09flags &=3D RMODE_GUEST_OWNED_EFLAGS_BITS;
@@ -2684,7 +2683,7 @@ static void enter_pmode(struct kvm_vcpu *vcpu)
 =09vmcs_writel(GUEST_CR4, (vmcs_readl(GUEST_CR4) & ~X86_CR4_VME) |
 =09=09=09(vmcs_readl(CR4_READ_SHADOW) & X86_CR4_VME));
=20
-=09update_exception_bitmap(vcpu);
+=09kvm_x86_update_bp_intercept(vcpu);
=20
 =09fix_pmode_seg(vcpu, VCPU_SREG_CS, &vmx->rmode.segs[VCPU_SREG_CS]);
 =09fix_pmode_seg(vcpu, VCPU_SREG_SS, &vmx->rmode.segs[VCPU_SREG_SS]);
@@ -2733,13 +2732,13 @@ static void enter_rmode(struct kvm_vcpu *vcpu)
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09struct kvm_vmx *kvm_vmx =3D to_kvm_vmx(vcpu->kvm);
=20
-=09vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_TR], VCPU_SREG_TR);
-=09vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_ES], VCPU_SREG_ES);
-=09vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_DS], VCPU_SREG_DS);
-=09vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_FS], VCPU_SREG_FS);
-=09vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_GS], VCPU_SREG_GS);
-=09vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_SS], VCPU_SREG_SS);
-=09vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_CS], VCPU_SREG_CS);
+=09kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_TR], VCPU_SREG_TR)=
;
+=09kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_ES], VCPU_SREG_ES)=
;
+=09kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_DS], VCPU_SREG_DS)=
;
+=09kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_FS], VCPU_SREG_FS)=
;
+=09kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_GS], VCPU_SREG_GS)=
;
+=09kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_SS], VCPU_SREG_SS)=
;
+=09kvm_x86_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_CS], VCPU_SREG_CS)=
;
=20
 =09vmx->rmode.vm86_active =3D 1;
=20
@@ -2764,7 +2763,7 @@ static void enter_rmode(struct kvm_vcpu *vcpu)
=20
 =09vmcs_writel(GUEST_RFLAGS, flags);
 =09vmcs_writel(GUEST_CR4, vmcs_readl(GUEST_CR4) | X86_CR4_VME);
-=09update_exception_bitmap(vcpu);
+=09kvm_x86_update_bp_intercept(vcpu);
=20
 =09fix_rmode_seg(VCPU_SREG_SS, &vmx->rmode.segs[VCPU_SREG_SS]);
 =09fix_rmode_seg(VCPU_SREG_CS, &vmx->rmode.segs[VCPU_SREG_CS]);
@@ -2776,7 +2775,7 @@ static void enter_rmode(struct kvm_vcpu *vcpu)
 =09kvm_mmu_reset_context(vcpu);
 }
=20
-void vmx_set_efer(struct kvm_vcpu *vcpu, u64 efer)
+void kvm_x86_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09struct shared_msr_entry *msr =3D find_msr_entry(vmx, MSR_EFER);
@@ -2812,18 +2811,18 @@ static void enter_lmode(struct kvm_vcpu *vcpu)
 =09=09=09     (guest_tr_ar & ~VMX_AR_TYPE_MASK)
 =09=09=09     | VMX_AR_TYPE_BUSY_64_TSS);
 =09}
-=09vmx_set_efer(vcpu, vcpu->arch.efer | EFER_LMA);
+=09kvm_x86_set_efer(vcpu, vcpu->arch.efer | EFER_LMA);
 }
=20
 static void exit_lmode(struct kvm_vcpu *vcpu)
 {
 =09vm_entry_controls_clearbit(to_vmx(vcpu), VM_ENTRY_IA32E_MODE);
-=09vmx_set_efer(vcpu, vcpu->arch.efer & ~EFER_LMA);
+=09kvm_x86_set_efer(vcpu, vcpu->arch.efer & ~EFER_LMA);
 }
=20
 #endif
=20
-static void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
+void kvm_x86_tlb_flush_gva(struct kvm_vcpu *vcpu, gva_t addr)
 {
 =09int vpid =3D to_vmx(vcpu)->vpid;
=20
@@ -2837,7 +2836,7 @@ static void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, =
gva_t addr)
 =09 */
 }
=20
-static void vmx_decache_cr0_guest_bits(struct kvm_vcpu *vcpu)
+void kvm_x86_decache_cr0_guest_bits(struct kvm_vcpu *vcpu)
 {
 =09ulong cr0_guest_owned_bits =3D vcpu->arch.cr0_guest_owned_bits;
=20
@@ -2845,14 +2844,14 @@ static void vmx_decache_cr0_guest_bits(struct kvm_v=
cpu *vcpu)
 =09vcpu->arch.cr0 |=3D vmcs_readl(GUEST_CR0) & cr0_guest_owned_bits;
 }
=20
-static void vmx_decache_cr3(struct kvm_vcpu *vcpu)
+void kvm_x86_decache_cr3(struct kvm_vcpu *vcpu)
 {
 =09if (enable_unrestricted_guest || (enable_ept && is_paging(vcpu)))
 =09=09vcpu->arch.cr3 =3D vmcs_readl(GUEST_CR3);
 =09__set_bit(VCPU_EXREG_CR3, (ulong *)&vcpu->arch.regs_avail);
 }
=20
-static void vmx_decache_cr4_guest_bits(struct kvm_vcpu *vcpu)
+void kvm_x86_decache_cr4_guest_bits(struct kvm_vcpu *vcpu)
 {
 =09ulong cr4_guest_owned_bits =3D vcpu->arch.cr4_guest_owned_bits;
=20
@@ -2900,26 +2899,26 @@ static void ept_update_paging_mode_cr0(unsigned lon=
g *hw_cr0,
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
=20
 =09if (!test_bit(VCPU_EXREG_CR3, (ulong *)&vcpu->arch.regs_avail))
-=09=09vmx_decache_cr3(vcpu);
+=09=09kvm_x86_decache_cr3(vcpu);
 =09if (!(cr0 & X86_CR0_PG)) {
 =09=09/* From paging/starting to nonpaging */
 =09=09exec_controls_setbit(vmx, CPU_BASED_CR3_LOAD_EXITING |
 =09=09=09=09=09  CPU_BASED_CR3_STORE_EXITING);
 =09=09vcpu->arch.cr0 =3D cr0;
-=09=09vmx_set_cr4(vcpu, kvm_read_cr4(vcpu));
+=09=09kvm_x86_set_cr4(vcpu, kvm_read_cr4(vcpu));
 =09} else if (!is_paging(vcpu)) {
 =09=09/* From nonpaging to paging */
 =09=09exec_controls_clearbit(vmx, CPU_BASED_CR3_LOAD_EXITING |
 =09=09=09=09=09    CPU_BASED_CR3_STORE_EXITING);
 =09=09vcpu->arch.cr0 =3D cr0;
-=09=09vmx_set_cr4(vcpu, kvm_read_cr4(vcpu));
+=09=09kvm_x86_set_cr4(vcpu, kvm_read_cr4(vcpu));
 =09}
=20
 =09if (!(cr0 & X86_CR0_WP))
 =09=09*hw_cr0 &=3D ~X86_CR0_WP;
 }
=20
-void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+void kvm_x86_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09unsigned long hw_cr0;
@@ -2957,7 +2956,7 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long=
 cr0)
 =09vmx->emulation_required =3D emulation_required(vcpu);
 }
=20
-static int get_ept_level(struct kvm_vcpu *vcpu)
+int kvm_x86_get_tdp_level(struct kvm_vcpu *vcpu)
 {
 =09if (cpu_has_vmx_ept_5levels() && (cpuid_maxphyaddr(vcpu) > 48))
 =09=09return 5;
@@ -2968,7 +2967,7 @@ u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned lo=
ng root_hpa)
 {
 =09u64 eptp =3D VMX_EPTP_MT_WB;
=20
-=09eptp |=3D (get_ept_level(vcpu) =3D=3D 5) ? VMX_EPTP_PWL_5 : VMX_EPTP_PW=
L_4;
+=09eptp |=3D (kvm_x86_get_tdp_level(vcpu) =3D=3D 5) ? VMX_EPTP_PWL_5 : VMX=
_EPTP_PWL_4;
=20
 =09if (enable_ept_ad_bits &&
 =09    (!is_guest_mode(vcpu) || nested_ept_ad_enabled(vcpu)))
@@ -2978,7 +2977,7 @@ u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned lo=
ng root_hpa)
 =09return eptp;
 }
=20
-void vmx_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
+void kvm_x86_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 {
 =09struct kvm *kvm =3D vcpu->kvm;
 =09unsigned long guest_cr3;
@@ -3008,7 +3007,7 @@ void vmx_set_cr3(struct kvm_vcpu *vcpu, unsigned long=
 cr3)
 =09vmcs_writel(GUEST_CR3, guest_cr3);
 }
=20
-int vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
+int kvm_x86_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09/*
@@ -3026,7 +3025,7 @@ int vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long =
cr4)
 =09else
 =09=09hw_cr4 |=3D KVM_PMODE_VM_CR4_ALWAYS_ON;
=20
-=09if (!boot_cpu_has(X86_FEATURE_UMIP) && vmx_umip_emulated()) {
+=09if (!boot_cpu_has(X86_FEATURE_UMIP) && kvm_x86_umip_emulated()) {
 =09=09if (cr4 & X86_CR4_UMIP) {
 =09=09=09secondary_exec_controls_setbit(vmx, SECONDARY_EXEC_DESC);
 =09=09=09hw_cr4 &=3D ~X86_CR4_UMIP;
@@ -3083,7 +3082,8 @@ int vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long =
cr4)
 =09return 0;
 }
=20
-void vmx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int s=
eg)
+void kvm_x86_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var,
+=09=09=09 int seg)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09u32 ar;
@@ -3119,18 +3119,18 @@ void vmx_get_segment(struct kvm_vcpu *vcpu, struct =
kvm_segment *var, int seg)
 =09var->g =3D (ar >> 15) & 1;
 }
=20
-static u64 vmx_get_segment_base(struct kvm_vcpu *vcpu, int seg)
+u64 kvm_x86_get_segment_base(struct kvm_vcpu *vcpu, int seg)
 {
 =09struct kvm_segment s;
=20
 =09if (to_vmx(vcpu)->rmode.vm86_active) {
-=09=09vmx_get_segment(vcpu, &s, seg);
+=09=09kvm_x86_get_segment(vcpu, &s, seg);
 =09=09return s.base;
 =09}
 =09return vmx_read_guest_seg_base(to_vmx(vcpu), seg);
 }
=20
-int vmx_get_cpl(struct kvm_vcpu *vcpu)
+int kvm_x86_get_cpl(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
=20
@@ -3162,7 +3162,8 @@ static u32 vmx_segment_access_rights(struct kvm_segme=
nt *var)
 =09return ar;
 }
=20
-void vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int s=
eg)
+void kvm_x86_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var,
+=09=09=09 int seg)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09const struct kvm_vmx_segment_field *sf =3D &kvm_vmx_segment_fields[seg]=
;
@@ -3202,7 +3203,7 @@ void vmx_set_segment(struct kvm_vcpu *vcpu, struct kv=
m_segment *var, int seg)
 =09vmx->emulation_required =3D emulation_required(vcpu);
 }
=20
-static void vmx_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l)
+void kvm_x86_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l)
 {
 =09u32 ar =3D vmx_read_guest_seg_ar(to_vmx(vcpu), VCPU_SREG_CS);
=20
@@ -3210,25 +3211,25 @@ static void vmx_get_cs_db_l_bits(struct kvm_vcpu *v=
cpu, int *db, int *l)
 =09*l =3D (ar >> 13) & 1;
 }
=20
-static void vmx_get_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void kvm_x86_get_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 =09dt->size =3D vmcs_read32(GUEST_IDTR_LIMIT);
 =09dt->address =3D vmcs_readl(GUEST_IDTR_BASE);
 }
=20
-static void vmx_set_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void kvm_x86_set_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 =09vmcs_write32(GUEST_IDTR_LIMIT, dt->size);
 =09vmcs_writel(GUEST_IDTR_BASE, dt->address);
 }
=20
-static void vmx_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void kvm_x86_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 =09dt->size =3D vmcs_read32(GUEST_GDTR_LIMIT);
 =09dt->address =3D vmcs_readl(GUEST_GDTR_BASE);
 }
=20
-static void vmx_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void kvm_x86_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 =09vmcs_write32(GUEST_GDTR_LIMIT, dt->size);
 =09vmcs_writel(GUEST_GDTR_BASE, dt->address);
@@ -3239,7 +3240,7 @@ static bool rmode_segment_valid(struct kvm_vcpu *vcpu=
, int seg)
 =09struct kvm_segment var;
 =09u32 ar;
=20
-=09vmx_get_segment(vcpu, &var, seg);
+=09kvm_x86_get_segment(vcpu, &var, seg);
 =09var.dpl =3D 0x3;
 =09if (seg =3D=3D VCPU_SREG_CS)
 =09=09var.type =3D 0x3;
@@ -3260,7 +3261,7 @@ static bool code_segment_valid(struct kvm_vcpu *vcpu)
 =09struct kvm_segment cs;
 =09unsigned int cs_rpl;
=20
-=09vmx_get_segment(vcpu, &cs, VCPU_SREG_CS);
+=09kvm_x86_get_segment(vcpu, &cs, VCPU_SREG_CS);
 =09cs_rpl =3D cs.selector & SEGMENT_RPL_MASK;
=20
 =09if (cs.unusable)
@@ -3288,7 +3289,7 @@ static bool stack_segment_valid(struct kvm_vcpu *vcpu=
)
 =09struct kvm_segment ss;
 =09unsigned int ss_rpl;
=20
-=09vmx_get_segment(vcpu, &ss, VCPU_SREG_SS);
+=09kvm_x86_get_segment(vcpu, &ss, VCPU_SREG_SS);
 =09ss_rpl =3D ss.selector & SEGMENT_RPL_MASK;
=20
 =09if (ss.unusable)
@@ -3310,7 +3311,7 @@ static bool data_segment_valid(struct kvm_vcpu *vcpu,=
 int seg)
 =09struct kvm_segment var;
 =09unsigned int rpl;
=20
-=09vmx_get_segment(vcpu, &var, seg);
+=09kvm_x86_get_segment(vcpu, &var, seg);
 =09rpl =3D var.selector & SEGMENT_RPL_MASK;
=20
 =09if (var.unusable)
@@ -3334,7 +3335,7 @@ static bool tr_valid(struct kvm_vcpu *vcpu)
 {
 =09struct kvm_segment tr;
=20
-=09vmx_get_segment(vcpu, &tr, VCPU_SREG_TR);
+=09kvm_x86_get_segment(vcpu, &tr, VCPU_SREG_TR);
=20
 =09if (tr.unusable)
 =09=09return false;
@@ -3352,7 +3353,7 @@ static bool ldtr_valid(struct kvm_vcpu *vcpu)
 {
 =09struct kvm_segment ldtr;
=20
-=09vmx_get_segment(vcpu, &ldtr, VCPU_SREG_LDTR);
+=09kvm_x86_get_segment(vcpu, &ldtr, VCPU_SREG_LDTR);
=20
 =09if (ldtr.unusable)
 =09=09return true;
@@ -3370,8 +3371,8 @@ static bool cs_ss_rpl_check(struct kvm_vcpu *vcpu)
 {
 =09struct kvm_segment cs, ss;
=20
-=09vmx_get_segment(vcpu, &cs, VCPU_SREG_CS);
-=09vmx_get_segment(vcpu, &ss, VCPU_SREG_SS);
+=09kvm_x86_get_segment(vcpu, &cs, VCPU_SREG_CS);
+=09kvm_x86_get_segment(vcpu, &ss, VCPU_SREG_SS);
=20
 =09return ((cs.selector & SEGMENT_RPL_MASK) =3D=3D
 =09=09 (ss.selector & SEGMENT_RPL_MASK));
@@ -3388,7 +3389,7 @@ static bool guest_state_valid(struct kvm_vcpu *vcpu)
 =09=09return true;
=20
 =09/* real mode guest state checks */
-=09if (!is_protmode(vcpu) || (vmx_get_rflags(vcpu) & X86_EFLAGS_VM)) {
+=09if (!is_protmode(vcpu) || (kvm_x86_get_rflags(vcpu) & X86_EFLAGS_VM)) {
 =09=09if (!rmode_segment_valid(vcpu, VCPU_SREG_CS))
 =09=09=09return false;
 =09=09if (!rmode_segment_valid(vcpu, VCPU_SREG_SS))
@@ -3739,12 +3740,12 @@ void pt_update_intercept_for_msr(struct vcpu_vmx *v=
mx)
 =09}
 }
=20
-static bool vmx_get_enable_apicv(struct kvm_vcpu *vcpu)
+bool kvm_x86_get_enable_apicv(struct kvm_vcpu *vcpu)
 {
 =09return enable_apicv;
 }
=20
-static bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
+bool kvm_x86_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09void *vapic_page;
@@ -3830,7 +3831,7 @@ static int vmx_deliver_nested_posted_interrupt(struct=
 kvm_vcpu *vcpu,
  * 2. If target vcpu isn't running(root mode), kick it to pick up the
  * interrupt from PIR in next vmentry.
  */
-static void vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector=
)
+void kvm_x86_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09int r;
@@ -3854,7 +3855,7 @@ static void vmx_deliver_posted_interrupt(struct kvm_v=
cpu *vcpu, int vector)
  * Set up the vmcs's constant host-state fields, i.e., host-state fields t=
hat
  * will not change in the lifetime of the guest.
  * Note that host-state that does change is set elsewhere. E.g., host-stat=
e
- * that is set differently for each CPU is set in vmx_vcpu_load(), not her=
e.
+ * that is set differently for each CPU is set in kvm_x86_vcpu_load(), not=
 here.
  */
 void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
 {
@@ -3940,7 +3941,7 @@ u32 vmx_pin_based_exec_ctrl(struct vcpu_vmx *vmx)
 =09return pin_based_exec_ctrl;
 }
=20
-static void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
+void kvm_x86_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
=20
@@ -4026,7 +4027,7 @@ static void vmx_compute_secondary_exec_control(struct=
 vcpu_vmx *vmx)
 =09if (!enable_pml)
 =09=09exec_control &=3D ~SECONDARY_EXEC_ENABLE_PML;
=20
-=09if (vmx_xsaves_supported()) {
+=09if (kvm_x86_xsaves_supported()) {
 =09=09/* Exposing XSAVES only when XSAVE is exposed */
 =09=09bool xsaves_enabled =3D
 =09=09=09guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
@@ -4045,7 +4046,7 @@ static void vmx_compute_secondary_exec_control(struct=
 vcpu_vmx *vmx)
 =09=09}
 =09}
=20
-=09if (vmx_rdtscp_supported()) {
+=09if (kvm_x86_rdtscp_supported()) {
 =09=09bool rdtscp_enabled =3D guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP);
 =09=09if (!rdtscp_enabled)
 =09=09=09exec_control &=3D ~SECONDARY_EXEC_RDTSCP;
@@ -4060,7 +4061,7 @@ static void vmx_compute_secondary_exec_control(struct=
 vcpu_vmx *vmx)
 =09=09}
 =09}
=20
-=09if (vmx_invpcid_supported()) {
+=09if (kvm_x86_invpcid_supported()) {
 =09=09/* Exposing INVPCID only when PCID is exposed */
 =09=09bool invpcid_enabled =3D
 =09=09=09guest_cpuid_has(vcpu, X86_FEATURE_INVPCID) &&
@@ -4234,7 +4235,7 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
=20
 =09set_cr4_guest_host_mask(vmx);
=20
-=09if (vmx_xsaves_supported())
+=09if (kvm_x86_xsaves_supported())
 =09=09vmcs_write64(XSS_EXIT_BITMAP, VMX_XSS_EXIT_BITMAP);
=20
 =09if (enable_pml) {
@@ -4253,7 +4254,7 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
 =09}
 }
=20
-static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
+void kvm_x86_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09struct msr_data apic_base_msr;
@@ -4341,34 +4342,34 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, b=
ool init_event)
=20
 =09cr0 =3D X86_CR0_NW | X86_CR0_CD | X86_CR0_ET;
 =09vmx->vcpu.arch.cr0 =3D cr0;
-=09vmx_set_cr0(vcpu, cr0); /* enter rmode */
-=09vmx_set_cr4(vcpu, 0);
-=09vmx_set_efer(vcpu, 0);
+=09kvm_x86_set_cr0(vcpu, cr0); /* enter rmode */
+=09kvm_x86_set_cr4(vcpu, 0);
+=09kvm_x86_set_efer(vcpu, 0);
=20
-=09update_exception_bitmap(vcpu);
+=09kvm_x86_update_bp_intercept(vcpu);
=20
 =09vpid_sync_context(vmx->vpid);
 =09if (init_event)
 =09=09vmx_clear_hlt(vcpu);
 }
=20
-static void enable_irq_window(struct kvm_vcpu *vcpu)
+void kvm_x86_enable_irq_window(struct kvm_vcpu *vcpu)
 {
 =09exec_controls_setbit(to_vmx(vcpu), CPU_BASED_VIRTUAL_INTR_PENDING);
 }
=20
-static void enable_nmi_window(struct kvm_vcpu *vcpu)
+void kvm_x86_enable_nmi_window(struct kvm_vcpu *vcpu)
 {
 =09if (!enable_vnmi ||
 =09    vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) & GUEST_INTR_STATE_STI) {
-=09=09enable_irq_window(vcpu);
+=09=09kvm_x86_enable_irq_window(vcpu);
 =09=09return;
 =09}
=20
 =09exec_controls_setbit(to_vmx(vcpu), CPU_BASED_VIRTUAL_NMI_PENDING);
 }
=20
-static void vmx_inject_irq(struct kvm_vcpu *vcpu)
+void kvm_x86_set_irq(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09uint32_t intr;
@@ -4396,7 +4397,7 @@ static void vmx_inject_irq(struct kvm_vcpu *vcpu)
 =09vmx_clear_hlt(vcpu);
 }
=20
-static void vmx_inject_nmi(struct kvm_vcpu *vcpu)
+void kvm_x86_set_nmi(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
=20
@@ -4427,7 +4428,7 @@ static void vmx_inject_nmi(struct kvm_vcpu *vcpu)
 =09vmx_clear_hlt(vcpu);
 }
=20
-bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu)
+bool kvm_x86_get_nmi_mask(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09bool masked;
@@ -4441,7 +4442,7 @@ bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu)
 =09return masked;
 }
=20
-void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
+void kvm_x86_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
=20
@@ -4461,7 +4462,7 @@ void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool mas=
ked)
 =09}
 }
=20
-static int vmx_nmi_allowed(struct kvm_vcpu *vcpu)
+int kvm_x86_nmi_allowed(struct kvm_vcpu *vcpu)
 {
 =09if (to_vmx(vcpu)->nested.nested_run_pending)
 =09=09return 0;
@@ -4475,7 +4476,7 @@ static int vmx_nmi_allowed(struct kvm_vcpu *vcpu)
 =09=09   | GUEST_INTR_STATE_NMI));
 }
=20
-static int vmx_interrupt_allowed(struct kvm_vcpu *vcpu)
+int kvm_x86_interrupt_allowed(struct kvm_vcpu *vcpu)
 {
 =09return (!to_vmx(vcpu)->nested.nested_run_pending &&
 =09=09vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_IF) &&
@@ -4483,7 +4484,7 @@ static int vmx_interrupt_allowed(struct kvm_vcpu *vcp=
u)
 =09=09=09(GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS));
 }
=20
-static int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
+int kvm_x86_set_tss_addr(struct kvm *kvm, unsigned int addr)
 {
 =09int ret;
=20
@@ -4498,7 +4499,7 @@ static int vmx_set_tss_addr(struct kvm *kvm, unsigned=
 int addr)
 =09return init_rmode_tss(kvm);
 }
=20
-static int vmx_set_identity_map_addr(struct kvm *kvm, u64 ident_addr)
+int kvm_x86_set_identity_map_addr(struct kvm *kvm, u64 ident_addr)
 {
 =09to_kvm_vmx(kvm)->ept_identity_map_addr =3D ident_addr;
 =09return 0;
@@ -4584,7 +4585,7 @@ static void kvm_machine_check(void)
=20
 static int handle_machine_check(struct kvm_vcpu *vcpu)
 {
-=09/* handled by vmx_vcpu_run() */
+=09/* handled by kvm_x86_run() */
 =09return 1;
 }
=20
@@ -4663,7 +4664,7 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu=
)
 =09=09=09vcpu->arch.dr6 &=3D ~DR_TRAP_BITS;
 =09=09=09vcpu->arch.dr6 |=3D dr6 | DR6_RTM;
 =09=09=09if (is_icebp(intr_info))
-=09=09=09=09WARN_ON(!skip_emulated_instruction(vcpu));
+=09=09=09=09WARN_ON(!kvm_x86_skip_emulated_instruction(vcpu));
=20
 =09=09=09kvm_queue_exception(vcpu, DB_VECTOR);
 =09=09=09return 1;
@@ -4727,8 +4728,7 @@ static int handle_io(struct kvm_vcpu *vcpu)
 =09return kvm_fast_pio(vcpu, size, port, in);
 }
=20
-static void
-vmx_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hypercall)
+void kvm_x86_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hyperca=
ll)
 {
 =09/*
 =09 * Patch in the VMCALL instruction:
@@ -4842,7 +4842,7 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 =09=09break;
 =09case 2: /* clts */
 =09=09WARN_ONCE(1, "Guest should always own CR0.TS");
-=09=09vmx_set_cr0(vcpu, kvm_read_cr0_bits(vcpu, ~X86_CR0_TS));
+=09=09kvm_x86_set_cr0(vcpu, kvm_read_cr0_bits(vcpu, ~X86_CR0_TS));
 =09=09trace_kvm_cr_write(0, kvm_read_cr0(vcpu));
 =09=09return kvm_skip_emulated_instruction(vcpu);
 =09case 1: /*mov from cr*/
@@ -4938,16 +4938,16 @@ static int handle_dr(struct kvm_vcpu *vcpu)
 =09return kvm_skip_emulated_instruction(vcpu);
 }
=20
-static u64 vmx_get_dr6(struct kvm_vcpu *vcpu)
+u64 kvm_x86_get_dr6(struct kvm_vcpu *vcpu)
 {
 =09return vcpu->arch.dr6;
 }
=20
-static void vmx_set_dr6(struct kvm_vcpu *vcpu, unsigned long val)
+void kvm_x86_set_dr6(struct kvm_vcpu *vcpu, unsigned long val)
 {
 }
=20
-static void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
+void kvm_x86_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 {
 =09get_debugreg(vcpu->arch.db[0], 0);
 =09get_debugreg(vcpu->arch.db[1], 1);
@@ -4960,7 +4960,7 @@ static void vmx_sync_dirty_debug_regs(struct kvm_vcpu=
 *vcpu)
 =09exec_controls_setbit(to_vmx(vcpu), CPU_BASED_MOV_DR_EXITING);
 }
=20
-static void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
+void kvm_x86_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
 {
 =09vmcs_writel(GUEST_DR7, val);
 }
@@ -5104,7 +5104,7 @@ static int handle_task_switch(struct kvm_vcpu *vcpu)
 =09=09switch (type) {
 =09=09case INTR_TYPE_NMI_INTR:
 =09=09=09vcpu->arch.nmi_injected =3D false;
-=09=09=09vmx_set_nmi_mask(vcpu, true);
+=09=09=09kvm_x86_set_nmi_mask(vcpu, true);
 =09=09=09break;
 =09=09case INTR_TYPE_EXT_INTR:
 =09=09case INTR_TYPE_SOFT_INTR:
@@ -5130,7 +5130,7 @@ static int handle_task_switch(struct kvm_vcpu *vcpu)
 =09if (!idt_v || (type !=3D INTR_TYPE_HARD_EXCEPTION &&
 =09=09       type !=3D INTR_TYPE_EXT_INTR &&
 =09=09       type !=3D INTR_TYPE_NMI_INTR))
-=09=09WARN_ON(!skip_emulated_instruction(vcpu));
+=09=09WARN_ON(!kvm_x86_skip_emulated_instruction(vcpu));
=20
 =09/*
 =09 * TODO: What about debug traps on tss switch?
@@ -5230,7 +5230,7 @@ static int handle_invalid_guest_state(struct kvm_vcpu=
 *vcpu)
 =09=09=09=09CPU_BASED_VIRTUAL_INTR_PENDING;
=20
 =09while (vmx->emulation_required && count-- !=3D 0) {
-=09=09if (intr_window_requested && vmx_interrupt_allowed(vcpu))
+=09=09if (intr_window_requested && kvm_x86_interrupt_allowed(vcpu))
 =09=09=09return handle_interrupt_window(&vmx->vcpu);
=20
 =09=09if (kvm_test_request(KVM_REQ_EVENT, vcpu))
@@ -5596,7 +5596,7 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu=
 *vcpu) =3D {
 static const int kvm_vmx_max_exit_handlers =3D
 =09ARRAY_SIZE(kvm_vmx_exit_handlers);
=20
-static void vmx_get_exit_info(struct kvm_vcpu *vcpu, u64 *info1, u64 *info=
2)
+void kvm_x86_get_exit_info(struct kvm_vcpu *vcpu, u64 *info1, u64 *info2)
 {
 =09*info1 =3D vmcs_readl(EXIT_QUALIFICATION);
 =09*info2 =3D vmcs_read32(VM_EXIT_INTR_INFO);
@@ -5838,7 +5838,7 @@ void dump_vmcs(void)
  * The guest has exited.  See if we can fix it or if we need userspace
  * assistance.
  */
-static int vmx_handle_exit(struct kvm_vcpu *vcpu)
+int kvm_x86_handle_exit(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09u32 exit_reason =3D vmx->exit_reason;
@@ -5907,7 +5907,7 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu)
=20
 =09if (unlikely(!enable_vnmi &&
 =09=09     vmx->loaded_vmcs->soft_vnmi_blocked)) {
-=09=09if (vmx_interrupt_allowed(vcpu)) {
+=09=09if (kvm_x86_interrupt_allowed(vcpu)) {
 =09=09=09vmx->loaded_vmcs->soft_vnmi_blocked =3D 0;
 =09=09} else if (vmx->loaded_vmcs->vnmi_blocked_time > 1000000000LL &&
 =09=09=09   vcpu->arch.nmi_pending) {
@@ -6010,7 +6010,7 @@ static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 =09=09: "eax", "ebx", "ecx", "edx");
 }
=20
-static void update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
+void kvm_x86_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
 {
 =09struct vmcs12 *vmcs12 =3D get_vmcs12(vcpu);
=20
@@ -6026,7 +6026,7 @@ static void update_cr8_intercept(struct kvm_vcpu *vcp=
u, int tpr, int irr)
 =09vmcs_write32(TPR_THRESHOLD, irr);
 }
=20
-void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu)
+void kvm_x86_set_virtual_apic_mode(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09u32 sec_exec_control;
@@ -6057,7 +6057,7 @@ void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu)
 =09=09if (flexpriority_enabled) {
 =09=09=09sec_exec_control |=3D
 =09=09=09=09SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;
-=09=09=09vmx_flush_tlb(vcpu, true);
+=09=09=09kvm_x86_tlb_flush(vcpu, true);
 =09=09}
 =09=09break;
 =09case LAPIC_MODE_X2APIC:
@@ -6071,15 +6071,15 @@ void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcp=
u)
 =09vmx_update_msr_bitmap(vcpu);
 }
=20
-static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu, hpa_t hpa=
)
+void kvm_x86_set_apic_access_page_addr(struct kvm_vcpu *vcpu, hpa_t hpa)
 {
 =09if (!is_guest_mode(vcpu)) {
 =09=09vmcs_write64(APIC_ACCESS_ADDR, hpa);
-=09=09vmx_flush_tlb(vcpu, true);
+=09=09kvm_x86_tlb_flush(vcpu, true);
 =09}
 }
=20
-static void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
+void kvm_x86_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
 {
 =09u16 status;
 =09u8 old;
@@ -6113,7 +6113,7 @@ static void vmx_set_rvi(int vector)
 =09}
 }
=20
-static void vmx_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
+void kvm_x86_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
 {
 =09/*
 =09 * When running L2, updating RVI is only relevant when
@@ -6127,7 +6127,7 @@ static void vmx_hwapic_irr_update(struct kvm_vcpu *vc=
pu, int max_irr)
 =09=09vmx_set_rvi(max_irr);
 }
=20
-static int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
+int kvm_x86_sync_pir_to_irr(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09int max_irr;
@@ -6161,16 +6161,16 @@ static int vmx_sync_pir_to_irr(struct kvm_vcpu *vcp=
u)
 =09} else {
 =09=09max_irr =3D kvm_lapic_find_highest_irr(vcpu);
 =09}
-=09vmx_hwapic_irr_update(vcpu, max_irr);
+=09kvm_x86_hwapic_irr_update(vcpu, max_irr);
 =09return max_irr;
 }
=20
-static bool vmx_dy_apicv_has_pending_interrupt(struct kvm_vcpu *vcpu)
+bool kvm_x86_dy_apicv_has_pending_interrupt(struct kvm_vcpu *vcpu)
 {
 =09return pi_test_on(vcpu_to_pi_desc(vcpu));
 }
=20
-static void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitm=
ap)
+void kvm_x86_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 {
 =09if (!kvm_vcpu_apicv_active(vcpu))
 =09=09return;
@@ -6181,7 +6181,7 @@ static void vmx_load_eoi_exitmap(struct kvm_vcpu *vcp=
u, u64 *eoi_exit_bitmap)
 =09vmcs_write64(EOI_EXIT_BITMAP3, eoi_exit_bitmap[3]);
 }
=20
-static void vmx_apicv_post_state_restore(struct kvm_vcpu *vcpu)
+void kvm_x86_apicv_post_state_restore(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
=20
@@ -6255,7 +6255,7 @@ static void handle_external_interrupt_irqoff(struct k=
vm_vcpu *vcpu)
 }
 STACK_FRAME_NON_STANDARD(handle_external_interrupt_irqoff);
=20
-static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu)
+void kvm_x86_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
=20
@@ -6265,7 +6265,7 @@ static void vmx_handle_exit_irqoff(struct kvm_vcpu *v=
cpu)
 =09=09handle_exception_nmi_irqoff(vmx);
 }
=20
-static bool vmx_has_emulated_msr(int index)
+bool kvm_x86_has_emulated_msr(int index)
 {
 =09switch (index) {
 =09case MSR_IA32_SMBASE:
@@ -6284,7 +6284,7 @@ static bool vmx_has_emulated_msr(int index)
 =09}
 }
=20
-static bool vmx_pt_supported(void)
+bool kvm_x86_pt_supported(void)
 {
 =09return pt_mode =3D=3D PT_MODE_HOST_GUEST;
 }
@@ -6363,7 +6363,7 @@ static void __vmx_complete_interrupts(struct kvm_vcpu=
 *vcpu,
 =09=09 * Clear bit "block by NMI" before VM entry if a NMI
 =09=09 * delivery faulted.
 =09=09 */
-=09=09vmx_set_nmi_mask(vcpu, false);
+=09=09kvm_x86_set_nmi_mask(vcpu, false);
 =09=09break;
 =09case INTR_TYPE_SOFT_EXCEPTION:
 =09=09vcpu->arch.event_exit_inst_len =3D vmcs_read32(instr_len_field);
@@ -6393,7 +6393,7 @@ static void vmx_complete_interrupts(struct vcpu_vmx *=
vmx)
 =09=09=09=09  IDT_VECTORING_ERROR_CODE);
 }
=20
-static void vmx_cancel_injection(struct kvm_vcpu *vcpu)
+void kvm_x86_cancel_injection(struct kvm_vcpu *vcpu)
 {
 =09__vmx_complete_interrupts(vcpu,
 =09=09=09=09  vmcs_read32(VM_ENTRY_INTR_INFO_FIELD),
@@ -6474,7 +6474,7 @@ void vmx_update_host_rsp(struct vcpu_vmx *vmx, unsign=
ed long host_rsp)
=20
 bool __vmx_vcpu_run(struct vcpu_vmx *vmx, unsigned long *regs, bool launch=
ed);
=20
-static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
+void kvm_x86_run(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09unsigned long cr3, cr4;
@@ -6520,7 +6520,7 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
 =09 * exceptions being set, but that's not correct for the guest debugging
 =09 * case. */
 =09if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)
-=09=09vmx_set_interrupt_shadow(vcpu, 0);
+=09=09kvm_x86_set_interrupt_shadow(vcpu, 0);
=20
 =09kvm_load_guest_xcr0(vcpu);
=20
@@ -6648,7 +6648,7 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
 =09vmx_complete_interrupts(vmx);
 }
=20
-static struct kvm *vmx_vm_alloc(void)
+struct kvm *kvm_x86_vm_alloc(void)
 {
 =09struct kvm_vmx *kvm_vmx =3D __vmalloc(sizeof(struct kvm_vmx),
 =09=09=09=09=09    GFP_KERNEL_ACCOUNT | __GFP_ZERO,
@@ -6656,13 +6656,13 @@ static struct kvm *vmx_vm_alloc(void)
 =09return &kvm_vmx->kvm;
 }
=20
-static void vmx_vm_free(struct kvm *kvm)
+void kvm_x86_vm_free(struct kvm *kvm)
 {
 =09kfree(kvm->arch.hyperv.hv_pa_pg);
 =09vfree(to_kvm_vmx(kvm));
 }
=20
-static void vmx_free_vcpu(struct kvm_vcpu *vcpu)
+void kvm_x86_vcpu_free(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
=20
@@ -6678,7 +6678,7 @@ static void vmx_free_vcpu(struct kvm_vcpu *vcpu)
 =09kmem_cache_free(kvm_vcpu_cache, vmx);
 }
=20
-static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
+struct kvm_vcpu *kvm_x86_vcpu_create(struct kvm *kvm, unsigned int id)
 {
 =09int err;
 =09struct vcpu_vmx *vmx;
@@ -6757,10 +6757,10 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm =
*kvm, unsigned int id)
=20
 =09vmx->loaded_vmcs =3D &vmx->vmcs01;
 =09cpu =3D get_cpu();
-=09vmx_vcpu_load(&vmx->vcpu, cpu);
+=09kvm_x86_vcpu_load(&vmx->vcpu, cpu);
 =09vmx->vcpu.cpu =3D cpu;
 =09vmx_vcpu_setup(vmx);
-=09vmx_vcpu_put(&vmx->vcpu);
+=09kvm_x86_vcpu_put(&vmx->vcpu);
 =09put_cpu();
 =09if (cpu_need_virtualize_apic_accesses(&vmx->vcpu)) {
 =09=09err =3D alloc_apic_access_page(kvm);
@@ -6818,7 +6818,7 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *k=
vm, unsigned int id)
 #define L1TF_MSG_SMT "L1TF CPU bug present and SMT on, data leak possible.=
 See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/h=
w-vuln/l1tf.html for details.\n"
 #define L1TF_MSG_L1D "L1TF CPU bug present and virtualization mitigation d=
isabled, data leak possible. See CVE-2018-3646 and https://www.kernel.org/d=
oc/html/latest/admin-guide/hw-vuln/l1tf.html for details.\n"
=20
-static int vmx_vm_init(struct kvm *kvm)
+int kvm_x86_vm_init(struct kvm *kvm)
 {
 =09spin_lock_init(&to_kvm_vmx(kvm)->ept_pointer_lock);
=20
@@ -6851,7 +6851,7 @@ static int vmx_vm_init(struct kvm *kvm)
 =09return 0;
 }
=20
-static int __init vmx_check_processor_compat(void)
+__init int kvm_x86_check_processor_compatibility(void)
 {
 =09struct vmcs_config vmcs_conf;
 =09struct vmx_capability vmx_cap;
@@ -6869,7 +6869,7 @@ static int __init vmx_check_processor_compat(void)
 =09return 0;
 }
=20
-static u64 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
+u64 kvm_x86_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 {
 =09u8 cache;
 =09u64 ipat =3D 0;
@@ -6911,7 +6911,7 @@ static u64 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn=
_t gfn, bool is_mmio)
 =09return (cache << VMX_EPT_MT_EPTE_SHIFT) | ipat;
 }
=20
-static int vmx_get_lpage_level(void)
+int kvm_x86_get_lpage_level(void)
 {
 =09if (enable_ept && !cpu_has_vmx_ept_1g_page())
 =09=09return PT_DIRECTORY_LEVEL;
@@ -7069,7 +7069,7 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu=
)
 =09=09vmx->pt_desc.ctl_bitmask &=3D ~(0xfULL << (32 + i * 4));
 }
=20
-static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
+void kvm_x86_cpuid_update(struct kvm_vcpu *vcpu)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
=20
@@ -7095,20 +7095,20 @@ static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
 =09=09update_intel_pt_cfg(vcpu);
 }
=20
-static void vmx_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *ent=
ry)
+void kvm_x86_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *entry)
 {
 =09if (func =3D=3D 1 && nested)
 =09=09entry->ecx |=3D bit(X86_FEATURE_VMX);
 }
=20
-static void vmx_request_immediate_exit(struct kvm_vcpu *vcpu)
+void kvm_x86_request_immediate_exit(struct kvm_vcpu *vcpu)
 {
 =09to_vmx(vcpu)->req_immediate_exit =3D true;
 }
=20
-static int vmx_check_intercept(struct kvm_vcpu *vcpu,
-=09=09=09       struct x86_instruction_info *info,
-=09=09=09       enum x86_intercept_stage stage)
+int kvm_x86_check_intercept(struct kvm_vcpu *vcpu,
+=09=09=09    struct x86_instruction_info *info,
+=09=09=09    enum x86_intercept_stage stage)
 {
 =09struct vmcs12 *vmcs12 =3D get_vmcs12(vcpu);
 =09struct x86_emulate_ctxt *ctxt =3D &vcpu->arch.emulate_ctxt;
@@ -7147,8 +7147,8 @@ static inline int u64_shl_div_u64(u64 a, unsigned int=
 shift,
 =09return 0;
 }
=20
-static int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
-=09=09=09    bool *expired)
+int kvm_x86_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
+=09=09=09 bool *expired)
 {
 =09struct vcpu_vmx *vmx;
 =09u64 tscl, guest_tscl, delta_tsc, lapic_timer_advance_cycles;
@@ -7191,37 +7191,37 @@ static int vmx_set_hv_timer(struct kvm_vcpu *vcpu, =
u64 guest_deadline_tsc,
 =09return 0;
 }
=20
-static void vmx_cancel_hv_timer(struct kvm_vcpu *vcpu)
+void kvm_x86_cancel_hv_timer(struct kvm_vcpu *vcpu)
 {
 =09to_vmx(vcpu)->hv_deadline_tsc =3D -1;
 }
 #endif
=20
-static void vmx_sched_in(struct kvm_vcpu *vcpu, int cpu)
+void kvm_x86_sched_in(struct kvm_vcpu *vcpu, int cpu)
 {
 =09if (!kvm_pause_in_guest(vcpu->kvm))
 =09=09shrink_ple_window(vcpu);
 }
=20
-static void vmx_slot_enable_log_dirty(struct kvm *kvm,
-=09=09=09=09     struct kvm_memory_slot *slot)
+void kvm_x86_slot_enable_log_dirty(struct kvm *kvm,
+=09=09=09=09   struct kvm_memory_slot *slot)
 {
 =09kvm_mmu_slot_leaf_clear_dirty(kvm, slot);
 =09kvm_mmu_slot_largepage_remove_write_access(kvm, slot);
 }
=20
-static void vmx_slot_disable_log_dirty(struct kvm *kvm,
-=09=09=09=09       struct kvm_memory_slot *slot)
+void kvm_x86_slot_disable_log_dirty(struct kvm *kvm,
+=09=09=09=09    struct kvm_memory_slot *slot)
 {
 =09kvm_mmu_slot_set_dirty(kvm, slot);
 }
=20
-static void vmx_flush_log_dirty(struct kvm *kvm)
+void kvm_x86_flush_log_dirty(struct kvm *kvm)
 {
 =09kvm_flush_pml_buffers(kvm);
 }
=20
-static int vmx_write_pml_buffer(struct kvm_vcpu *vcpu)
+int kvm_x86_write_log_dirty(struct kvm_vcpu *vcpu)
 {
 =09struct vmcs12 *vmcs12;
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
@@ -7257,9 +7257,9 @@ static int vmx_write_pml_buffer(struct kvm_vcpu *vcpu=
)
 =09return 0;
 }
=20
-static void vmx_enable_log_dirty_pt_masked(struct kvm *kvm,
-=09=09=09=09=09   struct kvm_memory_slot *memslot,
-=09=09=09=09=09   gfn_t offset, unsigned long mask)
+void kvm_x86_enable_log_dirty_pt_masked(struct kvm *kvm,
+=09=09=09=09=09struct kvm_memory_slot *memslot,
+=09=09=09=09=09gfn_t offset, unsigned long mask)
 {
 =09kvm_mmu_clear_dirty_pt_masked(kvm, memslot, offset, mask);
 }
@@ -7365,7 +7365,7 @@ static int pi_pre_block(struct kvm_vcpu *vcpu)
 =09return (vcpu->pre_pcpu =3D=3D -1);
 }
=20
-static int vmx_pre_block(struct kvm_vcpu *vcpu)
+int kvm_x86_pre_block(struct kvm_vcpu *vcpu)
 {
 =09if (pi_pre_block(vcpu))
 =09=09return 1;
@@ -7387,7 +7387,7 @@ static void pi_post_block(struct kvm_vcpu *vcpu)
 =09local_irq_enable();
 }
=20
-static void vmx_post_block(struct kvm_vcpu *vcpu)
+void kvm_x86_post_block(struct kvm_vcpu *vcpu)
 {
 =09if (kvm_x86_ops->set_hv_timer)
 =09=09kvm_lapic_switch_to_hv_timer(vcpu);
@@ -7404,8 +7404,8 @@ static void vmx_post_block(struct kvm_vcpu *vcpu)
  * @set: set or unset PI
  * returns 0 on success, < 0 on failure
  */
-static int vmx_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
-=09=09=09      uint32_t guest_irq, bool set)
+int kvm_x86_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
+=09=09=09   uint32_t guest_irq, bool set)
 {
 =09struct kvm_kernel_irq_routing_entry *e;
 =09struct kvm_irq_routing_table *irq_rt;
@@ -7489,7 +7489,7 @@ static int vmx_update_pi_irte(struct kvm *kvm, unsign=
ed int host_irq,
 =09return ret;
 }
=20
-static void vmx_setup_mce(struct kvm_vcpu *vcpu)
+void kvm_x86_setup_mce(struct kvm_vcpu *vcpu)
 {
 =09if (vcpu->arch.mcg_cap & MCG_LMCE_P)
 =09=09to_vmx(vcpu)->msr_ia32_feature_control_valid_bits |=3D
@@ -7499,7 +7499,7 @@ static void vmx_setup_mce(struct kvm_vcpu *vcpu)
 =09=09=09~FEATURE_CONTROL_LMCE;
 }
=20
-static int vmx_smi_allowed(struct kvm_vcpu *vcpu)
+int kvm_x86_smi_allowed(struct kvm_vcpu *vcpu)
 {
 =09/* we need a nested vmexit to enter SMM, postpone if run is pending */
 =09if (to_vmx(vcpu)->nested.nested_run_pending)
@@ -7507,7 +7507,7 @@ static int vmx_smi_allowed(struct kvm_vcpu *vcpu)
 =09return 1;
 }
=20
-static int vmx_pre_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
+int kvm_x86_pre_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
=20
@@ -7521,7 +7521,7 @@ static int vmx_pre_enter_smm(struct kvm_vcpu *vcpu, c=
har *smstate)
 =09return 0;
 }
=20
-static int vmx_pre_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
+int kvm_x86_pre_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
 {
 =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 =09int ret;
@@ -7541,22 +7541,22 @@ static int vmx_pre_leave_smm(struct kvm_vcpu *vcpu,=
 const char *smstate)
 =09return 0;
 }
=20
-static int enable_smi_window(struct kvm_vcpu *vcpu)
+int kvm_x86_enable_smi_window(struct kvm_vcpu *vcpu)
 {
 =09return 0;
 }
=20
-static bool vmx_need_emulation_on_page_fault(struct kvm_vcpu *vcpu)
+bool kvm_x86_need_emulation_on_page_fault(struct kvm_vcpu *vcpu)
 {
 =09return false;
 }
=20
-static bool vmx_apic_init_signal_blocked(struct kvm_vcpu *vcpu)
+bool kvm_x86_apic_init_signal_blocked(struct kvm_vcpu *vcpu)
 {
 =09return to_vmx(vcpu)->nested.vmxon;
 }
=20
-static __init int hardware_setup(void)
+__init int kvm_x86_hardware_setup(void)
 {
 =09unsigned long host_bndcfgs;
 =09struct desc_ptr dt;
@@ -7723,7 +7723,7 @@ static __init int hardware_setup(void)
 =09return r;
 }
=20
-static __exit void hardware_unsetup(void)
+__exit void kvm_x86_hardware_unsetup(void)
 {
 =09if (nested)
 =09=09nested_vmx_hardware_unsetup();
@@ -7731,148 +7731,173 @@ static __exit void hardware_unsetup(void)
 =09free_kvm_area();
 }
=20
+void kvm_x86_tlb_flush(struct kvm_vcpu *vcpu, bool invalidate_gpa)
+{
+=09__vmx_flush_tlb(vcpu, to_vmx(vcpu)->vpid, invalidate_gpa);
+}
+
+bool kvm_x86_has_wbinvd_exit(void)
+{
+=09return cpu_has_vmx_wbinvd_exit();
+}
+
+bool kvm_x86_mpx_supported(void)
+{
+=09return vmx_mpx_supported();
+}
+
+bool kvm_x86_xsaves_supported(void)
+{
+=09return vmx_xsaves_supported();
+}
+
+bool kvm_x86_umip_emulated(void)
+{
+=09return vmx_umip_emulated();
+}
+
 static struct kvm_x86_ops vmx_x86_ops __ro_after_init =3D {
-=09.cpu_has_kvm_support =3D cpu_has_kvm_support,
-=09.disabled_by_bios =3D vmx_disabled_by_bios,
-=09.hardware_setup =3D hardware_setup,
-=09.hardware_unsetup =3D hardware_unsetup,
-=09.check_processor_compatibility =3D vmx_check_processor_compat,
-=09.hardware_enable =3D hardware_enable,
-=09.hardware_disable =3D hardware_disable,
-=09.cpu_has_accelerated_tpr =3D report_flexpriority,
-=09.has_emulated_msr =3D vmx_has_emulated_msr,
-
-=09.vm_init =3D vmx_vm_init,
-=09.vm_alloc =3D vmx_vm_alloc,
-=09.vm_free =3D vmx_vm_free,
-
-=09.vcpu_create =3D vmx_create_vcpu,
-=09.vcpu_free =3D vmx_free_vcpu,
-=09.vcpu_reset =3D vmx_vcpu_reset,
-
-=09.prepare_guest_switch =3D vmx_prepare_switch_to_guest,
-=09.vcpu_load =3D vmx_vcpu_load,
-=09.vcpu_put =3D vmx_vcpu_put,
-
-=09.update_bp_intercept =3D update_exception_bitmap,
-=09.get_msr_feature =3D vmx_get_msr_feature,
-=09.get_msr =3D vmx_get_msr,
-=09.set_msr =3D vmx_set_msr,
-=09.get_segment_base =3D vmx_get_segment_base,
-=09.get_segment =3D vmx_get_segment,
-=09.set_segment =3D vmx_set_segment,
-=09.get_cpl =3D vmx_get_cpl,
-=09.get_cs_db_l_bits =3D vmx_get_cs_db_l_bits,
-=09.decache_cr0_guest_bits =3D vmx_decache_cr0_guest_bits,
-=09.decache_cr3 =3D vmx_decache_cr3,
-=09.decache_cr4_guest_bits =3D vmx_decache_cr4_guest_bits,
-=09.set_cr0 =3D vmx_set_cr0,
-=09.set_cr3 =3D vmx_set_cr3,
-=09.set_cr4 =3D vmx_set_cr4,
-=09.set_efer =3D vmx_set_efer,
-=09.get_idt =3D vmx_get_idt,
-=09.set_idt =3D vmx_set_idt,
-=09.get_gdt =3D vmx_get_gdt,
-=09.set_gdt =3D vmx_set_gdt,
-=09.get_dr6 =3D vmx_get_dr6,
-=09.set_dr6 =3D vmx_set_dr6,
-=09.set_dr7 =3D vmx_set_dr7,
-=09.sync_dirty_debug_regs =3D vmx_sync_dirty_debug_regs,
-=09.cache_reg =3D vmx_cache_reg,
-=09.get_rflags =3D vmx_get_rflags,
-=09.set_rflags =3D vmx_set_rflags,
-
-=09.tlb_flush =3D vmx_flush_tlb,
-=09.tlb_flush_gva =3D vmx_flush_tlb_gva,
-
-=09.run =3D vmx_vcpu_run,
-=09.handle_exit =3D vmx_handle_exit,
-=09.skip_emulated_instruction =3D skip_emulated_instruction,
-=09.set_interrupt_shadow =3D vmx_set_interrupt_shadow,
-=09.get_interrupt_shadow =3D vmx_get_interrupt_shadow,
-=09.patch_hypercall =3D vmx_patch_hypercall,
-=09.set_irq =3D vmx_inject_irq,
-=09.set_nmi =3D vmx_inject_nmi,
-=09.queue_exception =3D vmx_queue_exception,
-=09.cancel_injection =3D vmx_cancel_injection,
-=09.interrupt_allowed =3D vmx_interrupt_allowed,
-=09.nmi_allowed =3D vmx_nmi_allowed,
-=09.get_nmi_mask =3D vmx_get_nmi_mask,
-=09.set_nmi_mask =3D vmx_set_nmi_mask,
-=09.enable_nmi_window =3D enable_nmi_window,
-=09.enable_irq_window =3D enable_irq_window,
-=09.update_cr8_intercept =3D update_cr8_intercept,
-=09.set_virtual_apic_mode =3D vmx_set_virtual_apic_mode,
-=09.set_apic_access_page_addr =3D vmx_set_apic_access_page_addr,
-=09.get_enable_apicv =3D vmx_get_enable_apicv,
-=09.refresh_apicv_exec_ctrl =3D vmx_refresh_apicv_exec_ctrl,
-=09.load_eoi_exitmap =3D vmx_load_eoi_exitmap,
-=09.apicv_post_state_restore =3D vmx_apicv_post_state_restore,
-=09.hwapic_irr_update =3D vmx_hwapic_irr_update,
-=09.hwapic_isr_update =3D vmx_hwapic_isr_update,
-=09.guest_apic_has_interrupt =3D vmx_guest_apic_has_interrupt,
-=09.sync_pir_to_irr =3D vmx_sync_pir_to_irr,
-=09.deliver_posted_interrupt =3D vmx_deliver_posted_interrupt,
-=09.dy_apicv_has_pending_interrupt =3D vmx_dy_apicv_has_pending_interrupt,
-
-=09.set_tss_addr =3D vmx_set_tss_addr,
-=09.set_identity_map_addr =3D vmx_set_identity_map_addr,
-=09.get_tdp_level =3D get_ept_level,
-=09.get_mt_mask =3D vmx_get_mt_mask,
-
-=09.get_exit_info =3D vmx_get_exit_info,
-
-=09.get_lpage_level =3D vmx_get_lpage_level,
-
-=09.cpuid_update =3D vmx_cpuid_update,
-
-=09.rdtscp_supported =3D vmx_rdtscp_supported,
-=09.invpcid_supported =3D vmx_invpcid_supported,
-
-=09.set_supported_cpuid =3D vmx_set_supported_cpuid,
-
-=09.has_wbinvd_exit =3D cpu_has_vmx_wbinvd_exit,
-
-=09.read_l1_tsc_offset =3D vmx_read_l1_tsc_offset,
-=09.write_l1_tsc_offset =3D vmx_write_l1_tsc_offset,
-
-=09.set_tdp_cr3 =3D vmx_set_cr3,
-
-=09.check_intercept =3D vmx_check_intercept,
-=09.handle_exit_irqoff =3D vmx_handle_exit_irqoff,
-=09.mpx_supported =3D vmx_mpx_supported,
-=09.xsaves_supported =3D vmx_xsaves_supported,
-=09.umip_emulated =3D vmx_umip_emulated,
-=09.pt_supported =3D vmx_pt_supported,
-
-=09.request_immediate_exit =3D vmx_request_immediate_exit,
-
-=09.sched_in =3D vmx_sched_in,
-
-=09.slot_enable_log_dirty =3D vmx_slot_enable_log_dirty,
-=09.slot_disable_log_dirty =3D vmx_slot_disable_log_dirty,
-=09.flush_log_dirty =3D vmx_flush_log_dirty,
-=09.enable_log_dirty_pt_masked =3D vmx_enable_log_dirty_pt_masked,
-=09.write_log_dirty =3D vmx_write_pml_buffer,
-
-=09.pre_block =3D vmx_pre_block,
-=09.post_block =3D vmx_post_block,
+=09.cpu_has_kvm_support =3D kvm_x86_cpu_has_kvm_support,
+=09.disabled_by_bios =3D kvm_x86_disabled_by_bios,
+=09.hardware_setup =3D kvm_x86_hardware_setup,
+=09.hardware_unsetup =3D kvm_x86_hardware_unsetup,
+=09.check_processor_compatibility =3D kvm_x86_check_processor_compatibilit=
y,
+=09.hardware_enable =3D kvm_x86_hardware_enable,
+=09.hardware_disable =3D kvm_x86_hardware_disable,
+=09.cpu_has_accelerated_tpr =3D kvm_x86_cpu_has_accelerated_tpr,
+=09.has_emulated_msr =3D kvm_x86_has_emulated_msr,
+
+=09.vm_init =3D kvm_x86_vm_init,
+=09.vm_alloc =3D kvm_x86_vm_alloc,
+=09.vm_free =3D kvm_x86_vm_free,
+
+=09.vcpu_create =3D kvm_x86_vcpu_create,
+=09.vcpu_free =3D kvm_x86_vcpu_free,
+=09.vcpu_reset =3D kvm_x86_vcpu_reset,
+
+=09.prepare_guest_switch =3D kvm_x86_prepare_guest_switch,
+=09.vcpu_load =3D kvm_x86_vcpu_load,
+=09.vcpu_put =3D kvm_x86_vcpu_put,
+
+=09.update_bp_intercept =3D kvm_x86_update_bp_intercept,
+=09.get_msr_feature =3D kvm_x86_get_msr_feature,
+=09.get_msr =3D kvm_x86_get_msr,
+=09.set_msr =3D kvm_x86_set_msr,
+=09.get_segment_base =3D kvm_x86_get_segment_base,
+=09.get_segment =3D kvm_x86_get_segment,
+=09.set_segment =3D kvm_x86_set_segment,
+=09.get_cpl =3D kvm_x86_get_cpl,
+=09.get_cs_db_l_bits =3D kvm_x86_get_cs_db_l_bits,
+=09.decache_cr0_guest_bits =3D kvm_x86_decache_cr0_guest_bits,
+=09.decache_cr3 =3D kvm_x86_decache_cr3,
+=09.decache_cr4_guest_bits =3D kvm_x86_decache_cr4_guest_bits,
+=09.set_cr0 =3D kvm_x86_set_cr0,
+=09.set_cr3 =3D kvm_x86_set_cr3,
+=09.set_cr4 =3D kvm_x86_set_cr4,
+=09.set_efer =3D kvm_x86_set_efer,
+=09.get_idt =3D kvm_x86_get_idt,
+=09.set_idt =3D kvm_x86_set_idt,
+=09.get_gdt =3D kvm_x86_get_gdt,
+=09.set_gdt =3D kvm_x86_set_gdt,
+=09.get_dr6 =3D kvm_x86_get_dr6,
+=09.set_dr6 =3D kvm_x86_set_dr6,
+=09.set_dr7 =3D kvm_x86_set_dr7,
+=09.sync_dirty_debug_regs =3D kvm_x86_sync_dirty_debug_regs,
+=09.cache_reg =3D kvm_x86_cache_reg,
+=09.get_rflags =3D kvm_x86_get_rflags,
+=09.set_rflags =3D kvm_x86_set_rflags,
+
+=09.tlb_flush =3D kvm_x86_tlb_flush,
+=09.tlb_flush_gva =3D kvm_x86_tlb_flush_gva,
+
+=09.run =3D kvm_x86_run,
+=09.handle_exit =3D kvm_x86_handle_exit,
+=09.skip_emulated_instruction =3D kvm_x86_skip_emulated_instruction,
+=09.set_interrupt_shadow =3D kvm_x86_set_interrupt_shadow,
+=09.get_interrupt_shadow =3D kvm_x86_get_interrupt_shadow,
+=09.patch_hypercall =3D kvm_x86_patch_hypercall,
+=09.set_irq =3D kvm_x86_set_irq,
+=09.set_nmi =3D kvm_x86_set_nmi,
+=09.queue_exception =3D kvm_x86_queue_exception,
+=09.cancel_injection =3D kvm_x86_cancel_injection,
+=09.interrupt_allowed =3D kvm_x86_interrupt_allowed,
+=09.nmi_allowed =3D kvm_x86_nmi_allowed,
+=09.get_nmi_mask =3D kvm_x86_get_nmi_mask,
+=09.set_nmi_mask =3D kvm_x86_set_nmi_mask,
+=09.enable_nmi_window =3D kvm_x86_enable_nmi_window,
+=09.enable_irq_window =3D kvm_x86_enable_irq_window,
+=09.update_cr8_intercept =3D kvm_x86_update_cr8_intercept,
+=09.set_virtual_apic_mode =3D kvm_x86_set_virtual_apic_mode,
+=09.set_apic_access_page_addr =3D kvm_x86_set_apic_access_page_addr,
+=09.get_enable_apicv =3D kvm_x86_get_enable_apicv,
+=09.refresh_apicv_exec_ctrl =3D kvm_x86_refresh_apicv_exec_ctrl,
+=09.load_eoi_exitmap =3D kvm_x86_load_eoi_exitmap,
+=09.apicv_post_state_restore =3D kvm_x86_apicv_post_state_restore,
+=09.hwapic_irr_update =3D kvm_x86_hwapic_irr_update,
+=09.hwapic_isr_update =3D kvm_x86_hwapic_isr_update,
+=09.guest_apic_has_interrupt =3D kvm_x86_guest_apic_has_interrupt,
+=09.sync_pir_to_irr =3D kvm_x86_sync_pir_to_irr,
+=09.deliver_posted_interrupt =3D kvm_x86_deliver_posted_interrupt,
+=09.dy_apicv_has_pending_interrupt =3D kvm_x86_dy_apicv_has_pending_interr=
upt,
+
+=09.set_tss_addr =3D kvm_x86_set_tss_addr,
+=09.set_identity_map_addr =3D kvm_x86_set_identity_map_addr,
+=09.get_tdp_level =3D kvm_x86_get_tdp_level,
+=09.get_mt_mask =3D kvm_x86_get_mt_mask,
+
+=09.get_exit_info =3D kvm_x86_get_exit_info,
+
+=09.get_lpage_level =3D kvm_x86_get_lpage_level,
+
+=09.cpuid_update =3D kvm_x86_cpuid_update,
+
+=09.rdtscp_supported =3D kvm_x86_rdtscp_supported,
+=09.invpcid_supported =3D kvm_x86_invpcid_supported,
+
+=09.set_supported_cpuid =3D kvm_x86_set_supported_cpuid,
+
+=09.has_wbinvd_exit =3D kvm_x86_has_wbinvd_exit,
+
+=09.read_l1_tsc_offset =3D kvm_x86_read_l1_tsc_offset,
+=09.write_l1_tsc_offset =3D kvm_x86_write_l1_tsc_offset,
+
+=09.set_tdp_cr3 =3D kvm_x86_set_cr3,
+
+=09.check_intercept =3D kvm_x86_check_intercept,
+=09.handle_exit_irqoff =3D kvm_x86_handle_exit_irqoff,
+=09.mpx_supported =3D kvm_x86_mpx_supported,
+=09.xsaves_supported =3D kvm_x86_xsaves_supported,
+=09.umip_emulated =3D kvm_x86_umip_emulated,
+=09.pt_supported =3D kvm_x86_pt_supported,
+
+=09.request_immediate_exit =3D kvm_x86_request_immediate_exit,
+
+=09.sched_in =3D kvm_x86_sched_in,
+
+=09.slot_enable_log_dirty =3D kvm_x86_slot_enable_log_dirty,
+=09.slot_disable_log_dirty =3D kvm_x86_slot_disable_log_dirty,
+=09.flush_log_dirty =3D kvm_x86_flush_log_dirty,
+=09.enable_log_dirty_pt_masked =3D kvm_x86_enable_log_dirty_pt_masked,
+=09.write_log_dirty =3D kvm_x86_write_log_dirty,
+
+=09.pre_block =3D kvm_x86_pre_block,
+=09.post_block =3D kvm_x86_post_block,
=20
 =09.pmu_ops =3D &intel_pmu_ops,
=20
-=09.update_pi_irte =3D vmx_update_pi_irte,
+=09.update_pi_irte =3D kvm_x86_update_pi_irte,
=20
 #ifdef CONFIG_X86_64
-=09.set_hv_timer =3D vmx_set_hv_timer,
-=09.cancel_hv_timer =3D vmx_cancel_hv_timer,
+=09.set_hv_timer =3D kvm_x86_set_hv_timer,
+=09.cancel_hv_timer =3D kvm_x86_cancel_hv_timer,
 #endif
=20
-=09.setup_mce =3D vmx_setup_mce,
+=09.setup_mce =3D kvm_x86_setup_mce,
=20
-=09.smi_allowed =3D vmx_smi_allowed,
-=09.pre_enter_smm =3D vmx_pre_enter_smm,
-=09.pre_leave_smm =3D vmx_pre_leave_smm,
-=09.enable_smi_window =3D enable_smi_window,
+=09.smi_allowed =3D kvm_x86_smi_allowed,
+=09.pre_enter_smm =3D kvm_x86_pre_enter_smm,
+=09.pre_leave_smm =3D kvm_x86_pre_leave_smm,
+=09.enable_smi_window =3D kvm_x86_enable_smi_window,
=20
 =09.check_nested_events =3D NULL,
 =09.get_nested_state =3D NULL,
@@ -7880,8 +7905,8 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init=
 =3D {
 =09.get_vmcs12_pages =3D NULL,
 =09.nested_enable_evmcs =3D NULL,
 =09.nested_get_evmcs_version =3D NULL,
-=09.need_emulation_on_page_fault =3D vmx_need_emulation_on_page_fault,
-=09.apic_init_signal_blocked =3D vmx_apic_init_signal_blocked,
+=09.need_emulation_on_page_fault =3D kvm_x86_need_emulation_on_page_fault,
+=09.apic_init_signal_blocked =3D kvm_x86_apic_init_signal_blocked,
 };
=20
 static void vmx_cleanup_l1d_flush(void)
@@ -7995,3 +8020,85 @@ static int __init vmx_init(void)
 =09return 0;
 }
 module_init(vmx_init);
+
+void kvm_x86_vm_destroy(struct kvm *kvm)
+{
+=09kvm_x86_ops->vm_destroy(kvm);
+}
+
+int kvm_x86_tlb_remote_flush(struct kvm *kvm)
+{
+=09return kvm_x86_ops->tlb_remote_flush(kvm);
+}
+
+int kvm_x86_tlb_remote_flush_with_range(struct kvm *kvm,
+=09=09=09=09=09struct kvm_tlb_range *range)
+{
+=09return kvm_x86_ops->tlb_remote_flush_with_range(kvm, range);
+}
+
+int kvm_x86_check_nested_events(struct kvm_vcpu *vcpu, bool external_intr)
+{
+=09return kvm_x86_ops->check_nested_events(vcpu, external_intr);
+}
+
+void kvm_x86_vcpu_blocking(struct kvm_vcpu *vcpu)
+{
+=09kvm_x86_ops->vcpu_blocking(vcpu);
+}
+
+void kvm_x86_vcpu_unblocking(struct kvm_vcpu *vcpu)
+{
+=09kvm_x86_ops->vcpu_unblocking(vcpu);
+}
+
+int kvm_x86_get_nested_state(struct kvm_vcpu *vcpu,
+=09=09=09     struct kvm_nested_state __user *user_kvm_nested_state,
+=09=09=09     unsigned user_data_size)
+{
+=09return kvm_x86_ops->get_nested_state(vcpu, user_kvm_nested_state,
+=09=09=09=09=09     user_data_size);
+}
+
+int kvm_x86_set_nested_state(struct kvm_vcpu *vcpu,
+=09=09=09     struct kvm_nested_state __user *user_kvm_nested_state,
+=09=09=09     struct kvm_nested_state *kvm_state)
+{
+=09return kvm_x86_ops->set_nested_state(vcpu, user_kvm_nested_state,
+=09=09=09=09=09     kvm_state);
+}
+
+bool kvm_x86_get_vmcs12_pages(struct kvm_vcpu *vcpu)
+{
+=09return kvm_x86_ops->get_vmcs12_pages(vcpu);
+}
+
+int kvm_x86_mem_enc_op(struct kvm *kvm, void __user *argp)
+{
+=09return kvm_x86_ops->mem_enc_op(kvm, argp);
+}
+
+int kvm_x86_mem_enc_reg_region(struct kvm *kvm, struct kvm_enc_region *arg=
p)
+{
+=09return kvm_x86_ops->mem_enc_reg_region(kvm, argp);
+}
+
+int kvm_x86_mem_enc_unreg_region(struct kvm *kvm, struct kvm_enc_region *a=
rgp)
+{
+=09return kvm_x86_ops->mem_enc_unreg_region(kvm, argp);
+}
+
+int kvm_x86_nested_enable_evmcs(struct kvm_vcpu *vcpu, uint16_t *vmcs_vers=
ion)
+{
+=09return kvm_x86_ops->nested_enable_evmcs(vcpu, vmcs_version);
+}
+
+uint16_t kvm_x86_nested_get_evmcs_version(struct kvm_vcpu *vcpu)
+{
+=09return kvm_x86_ops->nested_get_evmcs_version(vcpu);
+}
+
+int kvm_x86_enable_direct_tlbflush(struct kvm_vcpu *vcpu)
+{
+=09return kvm_x86_ops->enable_direct_tlbflush(vcpu);
+}
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index bee16687dc0b..4e5dca97dec4 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -305,32 +305,32 @@ struct kvm_vmx {
=20
 bool nested_vmx_allowed(struct kvm_vcpu *vcpu);
 void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu);
-void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
+void kvm_x86_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 int allocate_vpid(void);
 void free_vpid(int vpid);
 void vmx_set_constant_host_state(struct vcpu_vmx *vmx);
-void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu);
+void kvm_x86_prepare_guest_switch(struct kvm_vcpu *vcpu);
 void vmx_set_host_fs_gs(struct vmcs_host_state *host, u16 fs_sel, u16 gs_s=
el,
 =09=09=09unsigned long fs_base, unsigned long gs_base);
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
-void vmx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int s=
eg);
-void vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int s=
eg);
+void kvm_x86_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, i=
nt seg);
+void kvm_x86_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, i=
nt seg);
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
@@ -489,11 +489,6 @@ static inline void __vmx_flush_tlb(struct kvm_vcpu *vc=
pu, int vpid,
 =09}
 }
=20
-static inline void vmx_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gp=
a)
-{
-=09__vmx_flush_tlb(vcpu, to_vmx(vcpu)->vpid, invalidate_gpa);
-}
-
 static inline void decache_tsc_multiplier(struct vcpu_vmx *vmx)
 {
 =09vmx->current_tsc_ratio =3D vmx->vcpu.arch.tsc_scaling_ratio;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ff395f812719..fb963e6b2e54 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -626,7 +626,7 @@ EXPORT_SYMBOL_GPL(kvm_requeue_exception_e);
  */
 bool kvm_require_cpl(struct kvm_vcpu *vcpu, int required_cpl)
 {
-=09if (kvm_x86_ops->get_cpl(vcpu) <=3D required_cpl)
+=09if (kvm_x86_get_cpl(vcpu) <=3D required_cpl)
 =09=09return true;
 =09kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
 =09return false;
@@ -773,7 +773,7 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr=
0)
=20
 =09=09=09if (!is_pae(vcpu))
 =09=09=09=09return 1;
-=09=09=09kvm_x86_ops->get_cs_db_l_bits(vcpu, &cs_db, &cs_l);
+=09=09=09kvm_x86_get_cs_db_l_bits(vcpu, &cs_db, &cs_l);
 =09=09=09if (cs_l)
 =09=09=09=09return 1;
 =09=09} else
@@ -786,7 +786,7 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr=
0)
 =09if (!(cr0 & X86_CR0_PG) && kvm_read_cr4_bits(vcpu, X86_CR4_PCIDE))
 =09=09return 1;
=20
-=09kvm_x86_ops->set_cr0(vcpu, cr0);
+=09kvm_x86_set_cr0(vcpu, cr0);
=20
 =09if ((cr0 ^ old_cr0) & X86_CR0_PG) {
 =09=09kvm_clear_async_pf_completion_queue(vcpu);
@@ -875,7 +875,7 @@ static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 ind=
ex, u64 xcr)
=20
 int kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
 {
-=09if (kvm_x86_ops->get_cpl(vcpu) !=3D 0 ||
+=09if (kvm_x86_get_cpl(vcpu) !=3D 0 ||
 =09    __kvm_set_xcr(vcpu, index, xcr)) {
 =09=09kvm_inject_gp(vcpu, 0);
 =09=09return 1;
@@ -940,7 +940,7 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr=
4)
 =09=09=09return 1;
 =09}
=20
-=09if (kvm_x86_ops->set_cr4(vcpu, cr4))
+=09if (kvm_x86_set_cr4(vcpu, cr4))
 =09=09return 1;
=20
 =09if (((cr4 ^ old_cr4) & pdptr_bits) ||
@@ -1024,7 +1024,7 @@ static void kvm_update_dr0123(struct kvm_vcpu *vcpu)
 static void kvm_update_dr6(struct kvm_vcpu *vcpu)
 {
 =09if (!(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP))
-=09=09kvm_x86_ops->set_dr6(vcpu, vcpu->arch.dr6);
+=09=09kvm_x86_set_dr6(vcpu, vcpu->arch.dr6);
 }
=20
 static void kvm_update_dr7(struct kvm_vcpu *vcpu)
@@ -1035,7 +1035,7 @@ static void kvm_update_dr7(struct kvm_vcpu *vcpu)
 =09=09dr7 =3D vcpu->arch.guest_debug_dr7;
 =09else
 =09=09dr7 =3D vcpu->arch.dr7;
-=09kvm_x86_ops->set_dr7(vcpu, dr7);
+=09kvm_x86_set_dr7(vcpu, dr7);
 =09vcpu->arch.switch_db_regs &=3D ~KVM_DEBUGREG_BP_ENABLED;
 =09if (dr7 & DR7_BP_EN_MASK)
 =09=09vcpu->arch.switch_db_regs |=3D KVM_DEBUGREG_BP_ENABLED;
@@ -1101,7 +1101,7 @@ int kvm_get_dr(struct kvm_vcpu *vcpu, int dr, unsigne=
d long *val)
 =09=09if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP)
 =09=09=09*val =3D vcpu->arch.dr6;
 =09=09else
-=09=09=09*val =3D kvm_x86_ops->get_dr6(vcpu);
+=09=09=09*val =3D kvm_x86_get_dr6(vcpu);
 =09=09break;
 =09case 5:
 =09=09/* fall through */
@@ -1311,7 +1311,7 @@ static int kvm_get_msr_feature(struct kvm_msr_entry *=
msr)
 =09=09rdmsrl_safe(msr->index, &msr->data);
 =09=09break;
 =09default:
-=09=09if (kvm_x86_ops->get_msr_feature(msr))
+=09=09if (kvm_x86_get_msr_feature(msr))
 =09=09=09return 1;
 =09}
 =09return 0;
@@ -1379,7 +1379,7 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr=
_data *msr_info)
 =09efer &=3D ~EFER_LMA;
 =09efer |=3D vcpu->arch.efer & EFER_LMA;
=20
-=09kvm_x86_ops->set_efer(vcpu, efer);
+=09kvm_x86_set_efer(vcpu, efer);
=20
 =09/* Update reserved bits */
 =09if ((efer ^ old_efer) & EFER_NX)
@@ -1435,7 +1435,7 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 i=
ndex, u64 data,
 =09msr.index =3D index;
 =09msr.host_initiated =3D host_initiated;
=20
-=09return kvm_x86_ops->set_msr(vcpu, &msr);
+=09return kvm_x86_set_msr(vcpu, &msr);
 }
=20
 /*
@@ -1453,7 +1453,7 @@ static int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 i=
ndex, u64 *data,
 =09msr.index =3D index;
 =09msr.host_initiated =3D host_initiated;
=20
-=09ret =3D kvm_x86_ops->get_msr(vcpu, &msr);
+=09ret =3D kvm_x86_get_msr(vcpu, &msr);
 =09if (!ret)
 =09=09*data =3D msr.data;
 =09return ret;
@@ -1774,7 +1774,7 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *v=
cpu)
=20
 static void update_ia32_tsc_adjust_msr(struct kvm_vcpu *vcpu, s64 offset)
 {
-=09u64 curr_offset =3D kvm_x86_ops->read_l1_tsc_offset(vcpu);
+=09u64 curr_offset =3D kvm_x86_read_l1_tsc_offset(vcpu);
 =09vcpu->arch.ia32_tsc_adjust_msr +=3D offset - curr_offset;
 }
=20
@@ -1816,7 +1816,7 @@ static u64 kvm_compute_tsc_offset(struct kvm_vcpu *vc=
pu, u64 target_tsc)
=20
 u64 kvm_read_l1_tsc(struct kvm_vcpu *vcpu, u64 host_tsc)
 {
-=09u64 tsc_offset =3D kvm_x86_ops->read_l1_tsc_offset(vcpu);
+=09u64 tsc_offset =3D kvm_x86_read_l1_tsc_offset(vcpu);
=20
 =09return tsc_offset + kvm_scale_tsc(vcpu, host_tsc);
 }
@@ -1824,7 +1824,7 @@ EXPORT_SYMBOL_GPL(kvm_read_l1_tsc);
=20
 static void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 {
-=09vcpu->arch.tsc_offset =3D kvm_x86_ops->write_l1_tsc_offset(vcpu, offset=
);
+=09vcpu->arch.tsc_offset =3D kvm_x86_write_l1_tsc_offset(vcpu, offset);
 }
=20
 static inline bool kvm_check_tsc_unstable(void)
@@ -1948,7 +1948,7 @@ EXPORT_SYMBOL_GPL(kvm_write_tsc);
 static inline void adjust_tsc_offset_guest(struct kvm_vcpu *vcpu,
 =09=09=09=09=09   s64 adjustment)
 {
-=09u64 tsc_offset =3D kvm_x86_ops->read_l1_tsc_offset(vcpu);
+=09u64 tsc_offset =3D kvm_x86_read_l1_tsc_offset(vcpu);
 =09kvm_vcpu_write_tsc_offset(vcpu, tsc_offset + adjustment);
 }
=20
@@ -2542,7 +2542,7 @@ static void kvmclock_reset(struct kvm_vcpu *vcpu)
 static void kvm_vcpu_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gpa)
 {
 =09++vcpu->stat.tlb_flush;
-=09kvm_x86_ops->tlb_flush(vcpu, invalidate_gpa);
+=09kvm_x86_tlb_flush(vcpu, invalidate_gpa);
 }
=20
 static void record_steal_time(struct kvm_vcpu *vcpu)
@@ -3242,10 +3242,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
 =09=09 * fringe case that is not enabled except via specific settings
 =09=09 * of the module parameters.
 =09=09 */
-=09=09r =3D kvm_x86_ops->has_emulated_msr(MSR_IA32_SMBASE);
+=09=09r =3D kvm_x86_has_emulated_msr(MSR_IA32_SMBASE);
 =09=09break;
 =09case KVM_CAP_VAPIC:
-=09=09r =3D !kvm_x86_ops->cpu_has_accelerated_tpr();
+=09=09r =3D !kvm_x86_cpu_has_accelerated_tpr();
 =09=09break;
 =09case KVM_CAP_NR_VCPUS:
 =09=09r =3D KVM_SOFT_MAX_VCPUS;
@@ -3273,7 +3273,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
 =09=09break;
 =09case KVM_CAP_NESTED_STATE:
 =09=09r =3D kvm_x86_ops->get_nested_state ?
-=09=09=09kvm_x86_ops->get_nested_state(NULL, NULL, 0) : 0;
+=09=09=09kvm_x86_get_nested_state(NULL, NULL, 0) : 0;
 =09=09break;
 =09case KVM_CAP_HYPERV_DIRECT_TLBFLUSH:
 =09=09r =3D kvm_x86_ops->enable_direct_tlbflush !=3D NULL;
@@ -3395,14 +3395,14 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int =
cpu)
 {
 =09/* Address WBINVD may be executed by guest */
 =09if (need_emulate_wbinvd(vcpu)) {
-=09=09if (kvm_x86_ops->has_wbinvd_exit())
+=09=09if (kvm_x86_has_wbinvd_exit())
 =09=09=09cpumask_set_cpu(cpu, vcpu->arch.wbinvd_dirty_mask);
 =09=09else if (vcpu->cpu !=3D -1 && vcpu->cpu !=3D cpu)
 =09=09=09smp_call_function_single(vcpu->cpu,
 =09=09=09=09=09wbinvd_ipi, NULL, 1);
 =09}
=20
-=09kvm_x86_ops->vcpu_load(vcpu, cpu);
+=09kvm_x86_vcpu_load(vcpu, cpu);
=20
 =09fpregs_assert_state_consistent();
 =09if (test_thread_flag(TIF_NEED_FPU_LOAD))
@@ -3463,7 +3463,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 =09int idx;
=20
 =09if (vcpu->preempted)
-=09=09vcpu->arch.preempted_in_kernel =3D !kvm_x86_ops->get_cpl(vcpu);
+=09=09vcpu->arch.preempted_in_kernel =3D !kvm_x86_get_cpl(vcpu);
=20
 =09/*
 =09 * Disable page faults because we're in atomic context here.
@@ -3482,7 +3482,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 =09kvm_steal_time_set_preempted(vcpu);
 =09srcu_read_unlock(&vcpu->kvm->srcu, idx);
 =09pagefault_enable();
-=09kvm_x86_ops->vcpu_put(vcpu);
+=09kvm_x86_vcpu_put(vcpu);
 =09vcpu->arch.last_host_tsc =3D rdtsc();
 =09/*
 =09 * If userspace has set any breakpoints or watchpoints, dr6 is restored
@@ -3496,7 +3496,7 @@ static int kvm_vcpu_ioctl_get_lapic(struct kvm_vcpu *=
vcpu,
 =09=09=09=09    struct kvm_lapic_state *s)
 {
 =09if (vcpu->arch.apicv_active)
-=09=09kvm_x86_ops->sync_pir_to_irr(vcpu);
+=09=09kvm_x86_sync_pir_to_irr(vcpu);
=20
 =09return kvm_apic_get_state(vcpu, s);
 }
@@ -3604,7 +3604,7 @@ static int kvm_vcpu_ioctl_x86_setup_mce(struct kvm_vc=
pu *vcpu,
 =09for (bank =3D 0; bank < bank_num; bank++)
 =09=09vcpu->arch.mce_banks[bank*4] =3D ~(u64)0;
=20
-=09kvm_x86_ops->setup_mce(vcpu);
+=09kvm_x86_setup_mce(vcpu);
 out:
 =09return r;
 }
@@ -3693,11 +3693,11 @@ static void kvm_vcpu_ioctl_x86_get_vcpu_events(stru=
ct kvm_vcpu *vcpu,
 =09=09vcpu->arch.interrupt.injected && !vcpu->arch.interrupt.soft;
 =09events->interrupt.nr =3D vcpu->arch.interrupt.nr;
 =09events->interrupt.soft =3D 0;
-=09events->interrupt.shadow =3D kvm_x86_ops->get_interrupt_shadow(vcpu);
+=09events->interrupt.shadow =3D kvm_x86_get_interrupt_shadow(vcpu);
=20
 =09events->nmi.injected =3D vcpu->arch.nmi_injected;
 =09events->nmi.pending =3D vcpu->arch.nmi_pending !=3D 0;
-=09events->nmi.masked =3D kvm_x86_ops->get_nmi_mask(vcpu);
+=09events->nmi.masked =3D kvm_x86_get_nmi_mask(vcpu);
 =09events->nmi.pad =3D 0;
=20
 =09events->sipi_vector =3D 0; /* never valid when reporting to user space =
*/
@@ -3764,13 +3764,13 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struc=
t kvm_vcpu *vcpu,
 =09vcpu->arch.interrupt.nr =3D events->interrupt.nr;
 =09vcpu->arch.interrupt.soft =3D events->interrupt.soft;
 =09if (events->flags & KVM_VCPUEVENT_VALID_SHADOW)
-=09=09kvm_x86_ops->set_interrupt_shadow(vcpu,
+=09=09kvm_x86_set_interrupt_shadow(vcpu,
 =09=09=09=09=09=09  events->interrupt.shadow);
=20
 =09vcpu->arch.nmi_injected =3D events->nmi.injected;
 =09if (events->flags & KVM_VCPUEVENT_VALID_NMI_PENDING)
 =09=09vcpu->arch.nmi_pending =3D events->nmi.pending;
-=09kvm_x86_ops->set_nmi_mask(vcpu, events->nmi.masked);
+=09kvm_x86_set_nmi_mask(vcpu, events->nmi.masked);
=20
 =09if (events->flags & KVM_VCPUEVENT_VALID_SIPI_VECTOR &&
 =09    lapic_in_kernel(vcpu))
@@ -4046,7 +4046,7 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu =
*vcpu,
 =09case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
 =09=09if (!kvm_x86_ops->nested_enable_evmcs)
 =09=09=09return -ENOTTY;
-=09=09r =3D kvm_x86_ops->nested_enable_evmcs(vcpu, &vmcs_version);
+=09=09r =3D kvm_x86_nested_enable_evmcs(vcpu, &vmcs_version);
 =09=09if (!r) {
 =09=09=09user_ptr =3D (void __user *)(uintptr_t)cap->args[0];
 =09=09=09if (copy_to_user(user_ptr, &vmcs_version,
@@ -4058,7 +4058,7 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu =
*vcpu,
 =09=09if (!kvm_x86_ops->enable_direct_tlbflush)
 =09=09=09return -ENOTTY;
=20
-=09=09return kvm_x86_ops->enable_direct_tlbflush(vcpu);
+=09=09return kvm_x86_enable_direct_tlbflush(vcpu);
=20
 =09default:
 =09=09return -EINVAL;
@@ -4369,7 +4369,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 =09=09if (get_user(user_data_size, &user_kvm_nested_state->size))
 =09=09=09break;
=20
-=09=09r =3D kvm_x86_ops->get_nested_state(vcpu, user_kvm_nested_state,
+=09=09r =3D kvm_x86_get_nested_state(vcpu, user_kvm_nested_state,
 =09=09=09=09=09=09  user_data_size);
 =09=09if (r < 0)
 =09=09=09break;
@@ -4411,7 +4411,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 =09=09    && !(kvm_state.flags & KVM_STATE_NESTED_GUEST_MODE))
 =09=09=09break;
=20
-=09=09r =3D kvm_x86_ops->set_nested_state(vcpu, user_kvm_nested_state, &kv=
m_state);
+=09=09r =3D kvm_x86_set_nested_state(vcpu, user_kvm_nested_state, &kvm_sta=
te);
 =09=09break;
 =09}
 =09case KVM_GET_SUPPORTED_HV_CPUID: {
@@ -4454,14 +4454,14 @@ static int kvm_vm_ioctl_set_tss_addr(struct kvm *kv=
m, unsigned long addr)
=20
 =09if (addr > (unsigned int)(-3 * PAGE_SIZE))
 =09=09return -EINVAL;
-=09ret =3D kvm_x86_ops->set_tss_addr(kvm, addr);
+=09ret =3D kvm_x86_set_tss_addr(kvm, addr);
 =09return ret;
 }
=20
 static int kvm_vm_ioctl_set_identity_map_addr(struct kvm *kvm,
 =09=09=09=09=09      u64 ident_addr)
 {
-=09return kvm_x86_ops->set_identity_map_addr(kvm, ident_addr);
+=09return kvm_x86_set_identity_map_addr(kvm, ident_addr);
 }
=20
 static int kvm_vm_ioctl_set_nr_mmu_pages(struct kvm *kvm,
@@ -4646,7 +4646,7 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struc=
t kvm_dirty_log *log)
 =09 * Flush potentially hardware-cached dirty pages to dirty_bitmap.
 =09 */
 =09if (kvm_x86_ops->flush_log_dirty)
-=09=09kvm_x86_ops->flush_log_dirty(kvm);
+=09=09kvm_x86_flush_log_dirty(kvm);
=20
 =09r =3D kvm_get_dirty_log_protect(kvm, log, &flush);
=20
@@ -4673,7 +4673,7 @@ int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm, str=
uct kvm_clear_dirty_log *lo
 =09 * Flush potentially hardware-cached dirty pages to dirty_bitmap.
 =09 */
 =09if (kvm_x86_ops->flush_log_dirty)
-=09=09kvm_x86_ops->flush_log_dirty(kvm);
+=09=09kvm_x86_flush_log_dirty(kvm);
=20
 =09r =3D kvm_clear_dirty_log_protect(kvm, log, &flush);
=20
@@ -5040,7 +5040,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 =09case KVM_MEMORY_ENCRYPT_OP: {
 =09=09r =3D -ENOTTY;
 =09=09if (kvm_x86_ops->mem_enc_op)
-=09=09=09r =3D kvm_x86_ops->mem_enc_op(kvm, argp);
+=09=09=09r =3D kvm_x86_mem_enc_op(kvm, argp);
 =09=09break;
 =09}
 =09case KVM_MEMORY_ENCRYPT_REG_REGION: {
@@ -5052,7 +5052,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
=20
 =09=09r =3D -ENOTTY;
 =09=09if (kvm_x86_ops->mem_enc_reg_region)
-=09=09=09r =3D kvm_x86_ops->mem_enc_reg_region(kvm, &region);
+=09=09=09r =3D kvm_x86_mem_enc_reg_region(kvm, &region);
 =09=09break;
 =09}
 =09case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
@@ -5064,7 +5064,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
=20
 =09=09r =3D -ENOTTY;
 =09=09if (kvm_x86_ops->mem_enc_unreg_region)
-=09=09=09r =3D kvm_x86_ops->mem_enc_unreg_region(kvm, &region);
+=09=09=09r =3D kvm_x86_mem_enc_unreg_region(kvm, &region);
 =09=09break;
 =09}
 =09case KVM_HYPERV_EVENTFD: {
@@ -5111,28 +5111,28 @@ static void kvm_init_msr_list(void)
 =09=09=09=09continue;
 =09=09=09break;
 =09=09case MSR_TSC_AUX:
-=09=09=09if (!kvm_x86_ops->rdtscp_supported())
+=09=09=09if (!kvm_x86_rdtscp_supported())
 =09=09=09=09continue;
 =09=09=09break;
 =09=09case MSR_IA32_RTIT_CTL:
 =09=09case MSR_IA32_RTIT_STATUS:
-=09=09=09if (!kvm_x86_ops->pt_supported())
+=09=09=09if (!kvm_x86_pt_supported())
 =09=09=09=09continue;
 =09=09=09break;
 =09=09case MSR_IA32_RTIT_CR3_MATCH:
-=09=09=09if (!kvm_x86_ops->pt_supported() ||
+=09=09=09if (!kvm_x86_pt_supported() ||
 =09=09=09    !intel_pt_validate_hw_cap(PT_CAP_cr3_filtering))
 =09=09=09=09continue;
 =09=09=09break;
 =09=09case MSR_IA32_RTIT_OUTPUT_BASE:
 =09=09case MSR_IA32_RTIT_OUTPUT_MASK:
-=09=09=09if (!kvm_x86_ops->pt_supported() ||
+=09=09=09if (!kvm_x86_pt_supported() ||
 =09=09=09=09(!intel_pt_validate_hw_cap(PT_CAP_topa_output) &&
 =09=09=09=09 !intel_pt_validate_hw_cap(PT_CAP_single_range_output)))
 =09=09=09=09continue;
 =09=09=09break;
 =09=09case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B: {
-=09=09=09if (!kvm_x86_ops->pt_supported() ||
+=09=09=09if (!kvm_x86_pt_supported() ||
 =09=09=09=09msrs_to_save[i] - MSR_IA32_RTIT_ADDR0_A >=3D
 =09=09=09=09intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) * 2)
 =09=09=09=09continue;
@@ -5158,7 +5158,7 @@ static void kvm_init_msr_list(void)
 =09num_msrs_to_save =3D j;
=20
 =09for (i =3D j =3D 0; i < ARRAY_SIZE(emulated_msrs); i++) {
-=09=09if (!kvm_x86_ops->has_emulated_msr(emulated_msrs[i]))
+=09=09if (!kvm_x86_has_emulated_msr(emulated_msrs[i]))
 =09=09=09continue;
=20
 =09=09if (j < i)
@@ -5227,13 +5227,13 @@ static int vcpu_mmio_read(struct kvm_vcpu *vcpu, gp=
a_t addr, int len, void *v)
 static void kvm_set_segment(struct kvm_vcpu *vcpu,
 =09=09=09struct kvm_segment *var, int seg)
 {
-=09kvm_x86_ops->set_segment(vcpu, var, seg);
+=09kvm_x86_set_segment(vcpu, var, seg);
 }
=20
 void kvm_get_segment(struct kvm_vcpu *vcpu,
 =09=09     struct kvm_segment *var, int seg)
 {
-=09kvm_x86_ops->get_segment(vcpu, var, seg);
+=09kvm_x86_get_segment(vcpu, var, seg);
 }
=20
 gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u32 access,
@@ -5253,14 +5253,14 @@ gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, g=
pa_t gpa, u32 access,
 gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
 =09=09=09      struct x86_exception *exception)
 {
-=09u32 access =3D (kvm_x86_ops->get_cpl(vcpu) =3D=3D 3) ? PFERR_USER_MASK =
: 0;
+=09u32 access =3D (kvm_x86_get_cpl(vcpu) =3D=3D 3) ? PFERR_USER_MASK : 0;
 =09return vcpu->arch.walk_mmu->gva_to_gpa(vcpu, gva, access, exception);
 }
=20
  gpa_t kvm_mmu_gva_to_gpa_fetch(struct kvm_vcpu *vcpu, gva_t gva,
 =09=09=09=09struct x86_exception *exception)
 {
-=09u32 access =3D (kvm_x86_ops->get_cpl(vcpu) =3D=3D 3) ? PFERR_USER_MASK =
: 0;
+=09u32 access =3D (kvm_x86_get_cpl(vcpu) =3D=3D 3) ? PFERR_USER_MASK : 0;
 =09access |=3D PFERR_FETCH_MASK;
 =09return vcpu->arch.walk_mmu->gva_to_gpa(vcpu, gva, access, exception);
 }
@@ -5268,7 +5268,7 @@ gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, =
gva_t gva,
 gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
 =09=09=09       struct x86_exception *exception)
 {
-=09u32 access =3D (kvm_x86_ops->get_cpl(vcpu) =3D=3D 3) ? PFERR_USER_MASK =
: 0;
+=09u32 access =3D (kvm_x86_get_cpl(vcpu) =3D=3D 3) ? PFERR_USER_MASK : 0;
 =09access |=3D PFERR_WRITE_MASK;
 =09return vcpu->arch.walk_mmu->gva_to_gpa(vcpu, gva, access, exception);
 }
@@ -5317,7 +5317,7 @@ static int kvm_fetch_guest_virt(struct x86_emulate_ct=
xt *ctxt,
 =09=09=09=09struct x86_exception *exception)
 {
 =09struct kvm_vcpu *vcpu =3D emul_to_vcpu(ctxt);
-=09u32 access =3D (kvm_x86_ops->get_cpl(vcpu) =3D=3D 3) ? PFERR_USER_MASK =
: 0;
+=09u32 access =3D (kvm_x86_get_cpl(vcpu) =3D=3D 3) ? PFERR_USER_MASK : 0;
 =09unsigned offset;
 =09int ret;
=20
@@ -5342,7 +5342,7 @@ int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
 =09=09=09       gva_t addr, void *val, unsigned int bytes,
 =09=09=09       struct x86_exception *exception)
 {
-=09u32 access =3D (kvm_x86_ops->get_cpl(vcpu) =3D=3D 3) ? PFERR_USER_MASK =
: 0;
+=09u32 access =3D (kvm_x86_get_cpl(vcpu) =3D=3D 3) ? PFERR_USER_MASK : 0;
=20
 =09/*
 =09 * FIXME: this should call handle_emulation_failure if X86EMUL_IO_NEEDE=
D
@@ -5363,7 +5363,7 @@ static int emulator_read_std(struct x86_emulate_ctxt =
*ctxt,
 =09struct kvm_vcpu *vcpu =3D emul_to_vcpu(ctxt);
 =09u32 access =3D 0;
=20
-=09if (!system && kvm_x86_ops->get_cpl(vcpu) =3D=3D 3)
+=09if (!system && kvm_x86_get_cpl(vcpu) =3D=3D 3)
 =09=09access |=3D PFERR_USER_MASK;
=20
 =09return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access, excep=
tion);
@@ -5416,7 +5416,7 @@ static int emulator_write_std(struct x86_emulate_ctxt=
 *ctxt, gva_t addr, void *v
 =09struct kvm_vcpu *vcpu =3D emul_to_vcpu(ctxt);
 =09u32 access =3D PFERR_WRITE_MASK;
=20
-=09if (!system && kvm_x86_ops->get_cpl(vcpu) =3D=3D 3)
+=09if (!system && kvm_x86_get_cpl(vcpu) =3D=3D 3)
 =09=09access |=3D PFERR_USER_MASK;
=20
 =09return kvm_write_guest_virt_helper(addr, val, bytes, vcpu,
@@ -5478,7 +5478,7 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu=
, unsigned long gva,
 =09=09=09=09gpa_t *gpa, struct x86_exception *exception,
 =09=09=09=09bool write)
 {
-=09u32 access =3D ((kvm_x86_ops->get_cpl(vcpu) =3D=3D 3) ? PFERR_USER_MASK=
 : 0)
+=09u32 access =3D ((kvm_x86_get_cpl(vcpu) =3D=3D 3) ? PFERR_USER_MASK : 0)
 =09=09| (write ? PFERR_WRITE_MASK : 0);
=20
 =09/*
@@ -5866,7 +5866,7 @@ static int emulator_pio_out_emulated(struct x86_emula=
te_ctxt *ctxt,
=20
 static unsigned long get_segment_base(struct kvm_vcpu *vcpu, int seg)
 {
-=09return kvm_x86_ops->get_segment_base(vcpu, seg);
+=09return kvm_x86_get_segment_base(vcpu, seg);
 }
=20
 static void emulator_invlpg(struct x86_emulate_ctxt *ctxt, ulong address)
@@ -5879,7 +5879,7 @@ static int kvm_emulate_wbinvd_noskip(struct kvm_vcpu =
*vcpu)
 =09if (!need_emulate_wbinvd(vcpu))
 =09=09return X86EMUL_CONTINUE;
=20
-=09if (kvm_x86_ops->has_wbinvd_exit()) {
+=09if (kvm_x86_has_wbinvd_exit()) {
 =09=09int cpu =3D get_cpu();
=20
 =09=09cpumask_set_cpu(cpu, vcpu->arch.wbinvd_dirty_mask);
@@ -5984,27 +5984,27 @@ static int emulator_set_cr(struct x86_emulate_ctxt =
*ctxt, int cr, ulong val)
=20
 static int emulator_get_cpl(struct x86_emulate_ctxt *ctxt)
 {
-=09return kvm_x86_ops->get_cpl(emul_to_vcpu(ctxt));
+=09return kvm_x86_get_cpl(emul_to_vcpu(ctxt));
 }
=20
 static void emulator_get_gdt(struct x86_emulate_ctxt *ctxt, struct desc_pt=
r *dt)
 {
-=09kvm_x86_ops->get_gdt(emul_to_vcpu(ctxt), dt);
+=09kvm_x86_get_gdt(emul_to_vcpu(ctxt), dt);
 }
=20
 static void emulator_get_idt(struct x86_emulate_ctxt *ctxt, struct desc_pt=
r *dt)
 {
-=09kvm_x86_ops->get_idt(emul_to_vcpu(ctxt), dt);
+=09kvm_x86_get_idt(emul_to_vcpu(ctxt), dt);
 }
=20
 static void emulator_set_gdt(struct x86_emulate_ctxt *ctxt, struct desc_pt=
r *dt)
 {
-=09kvm_x86_ops->set_gdt(emul_to_vcpu(ctxt), dt);
+=09kvm_x86_set_gdt(emul_to_vcpu(ctxt), dt);
 }
=20
 static void emulator_set_idt(struct x86_emulate_ctxt *ctxt, struct desc_pt=
r *dt)
 {
-=09kvm_x86_ops->set_idt(emul_to_vcpu(ctxt), dt);
+=09kvm_x86_set_idt(emul_to_vcpu(ctxt), dt);
 }
=20
 static unsigned long emulator_get_cached_segment_base(
@@ -6126,7 +6126,7 @@ static int emulator_intercept(struct x86_emulate_ctxt=
 *ctxt,
 =09=09=09      struct x86_instruction_info *info,
 =09=09=09      enum x86_intercept_stage stage)
 {
-=09return kvm_x86_ops->check_intercept(emul_to_vcpu(ctxt), info, stage);
+=09return kvm_x86_check_intercept(emul_to_vcpu(ctxt), info, stage);
 }
=20
 static bool emulator_get_cpuid(struct x86_emulate_ctxt *ctxt,
@@ -6147,7 +6147,7 @@ static void emulator_write_gpr(struct x86_emulate_ctx=
t *ctxt, unsigned reg, ulon
=20
 static void emulator_set_nmi_mask(struct x86_emulate_ctxt *ctxt, bool mask=
ed)
 {
-=09kvm_x86_ops->set_nmi_mask(emul_to_vcpu(ctxt), masked);
+=09kvm_x86_set_nmi_mask(emul_to_vcpu(ctxt), masked);
 }
=20
 static unsigned emulator_get_hflags(struct x86_emulate_ctxt *ctxt)
@@ -6163,7 +6163,7 @@ static void emulator_set_hflags(struct x86_emulate_ct=
xt *ctxt, unsigned emul_fla
 static int emulator_pre_leave_smm(struct x86_emulate_ctxt *ctxt,
 =09=09=09=09  const char *smstate)
 {
-=09return kvm_x86_ops->pre_leave_smm(emul_to_vcpu(ctxt), smstate);
+=09return kvm_x86_pre_leave_smm(emul_to_vcpu(ctxt), smstate);
 }
=20
 static void emulator_post_leave_smm(struct x86_emulate_ctxt *ctxt)
@@ -6222,7 +6222,7 @@ static const struct x86_emulate_ops emulate_ops =3D {
=20
 static void toggle_interruptibility(struct kvm_vcpu *vcpu, u32 mask)
 {
-=09u32 int_shadow =3D kvm_x86_ops->get_interrupt_shadow(vcpu);
+=09u32 int_shadow =3D kvm_x86_get_interrupt_shadow(vcpu);
 =09/*
 =09 * an sti; sti; sequence only disable interrupts for the first
 =09 * instruction. So, if the last instruction, be it emulated or
@@ -6233,7 +6233,7 @@ static void toggle_interruptibility(struct kvm_vcpu *=
vcpu, u32 mask)
 =09if (int_shadow & mask)
 =09=09mask =3D 0;
 =09if (unlikely(int_shadow || mask)) {
-=09=09kvm_x86_ops->set_interrupt_shadow(vcpu, mask);
+=09=09kvm_x86_set_interrupt_shadow(vcpu, mask);
 =09=09if (!mask)
 =09=09=09kvm_make_request(KVM_REQ_EVENT, vcpu);
 =09}
@@ -6258,7 +6258,7 @@ static void init_emulate_ctxt(struct kvm_vcpu *vcpu)
 =09struct x86_emulate_ctxt *ctxt =3D &vcpu->arch.emulate_ctxt;
 =09int cs_db, cs_l;
=20
-=09kvm_x86_ops->get_cs_db_l_bits(vcpu, &cs_db, &cs_l);
+=09kvm_x86_get_cs_db_l_bits(vcpu, &cs_db, &cs_l);
=20
 =09ctxt->eflags =3D kvm_get_rflags(vcpu);
 =09ctxt->tf =3D (ctxt->eflags & X86_EFLAGS_TF) !=3D 0;
@@ -6318,7 +6318,7 @@ static int handle_emulation_failure(struct kvm_vcpu *=
vcpu, int emulation_type)
=20
 =09kvm_queue_exception(vcpu, UD_VECTOR);
=20
-=09if (!is_guest_mode(vcpu) && kvm_x86_ops->get_cpl(vcpu) =3D=3D 0) {
+=09if (!is_guest_mode(vcpu) && kvm_x86_get_cpl(vcpu) =3D=3D 0) {
 =09=09vcpu->run->exit_reason =3D KVM_EXIT_INTERNAL_ERROR;
 =09=09vcpu->run->internal.suberror =3D KVM_INTERNAL_ERROR_EMULATION;
 =09=09vcpu->run->internal.ndata =3D 0;
@@ -6497,10 +6497,10 @@ static int kvm_vcpu_do_singlestep(struct kvm_vcpu *=
vcpu)
=20
 int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
-=09unsigned long rflags =3D kvm_x86_ops->get_rflags(vcpu);
+=09unsigned long rflags =3D kvm_x86_get_rflags(vcpu);
 =09int r;
=20
-=09r =3D kvm_x86_ops->skip_emulated_instruction(vcpu);
+=09r =3D kvm_x86_skip_emulated_instruction(vcpu);
 =09if (unlikely(!r))
 =09=09return 0;
=20
@@ -6726,7 +6726,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
 =09=09r =3D 1;
=20
 =09if (writeback) {
-=09=09unsigned long rflags =3D kvm_x86_ops->get_rflags(vcpu);
+=09=09unsigned long rflags =3D kvm_x86_get_rflags(vcpu);
 =09=09toggle_interruptibility(vcpu, ctxt->interruptibility);
 =09=09vcpu->arch.emulate_regs_need_sync_to_vcpu =3D false;
 =09=09if (!ctxt->have_exception ||
@@ -7062,7 +7062,7 @@ static int kvm_is_user_mode(void)
 =09int user_mode =3D 3;
=20
 =09if (__this_cpu_read(current_vcpu))
-=09=09user_mode =3D kvm_x86_ops->get_cpl(__this_cpu_read(current_vcpu));
+=09=09user_mode =3D kvm_x86_get_cpl(__this_cpu_read(current_vcpu));
=20
 =09return user_mode !=3D 0;
 }
@@ -7326,7 +7326,7 @@ void kvm_vcpu_deactivate_apicv(struct kvm_vcpu *vcpu)
 =09=09return;
=20
 =09vcpu->arch.apicv_active =3D false;
-=09kvm_x86_ops->refresh_apicv_exec_ctrl(vcpu);
+=09kvm_x86_refresh_apicv_exec_ctrl(vcpu);
 }
=20
 static void kvm_sched_yield(struct kvm *kvm, unsigned long dest_id)
@@ -7371,7 +7371,7 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 =09=09a3 &=3D 0xFFFFFFFF;
 =09}
=20
-=09if (kvm_x86_ops->get_cpl(vcpu) !=3D 0) {
+=09if (kvm_x86_get_cpl(vcpu) !=3D 0) {
 =09=09ret =3D -KVM_EPERM;
 =09=09goto out;
 =09}
@@ -7417,7 +7417,7 @@ static int emulator_fix_hypercall(struct x86_emulate_=
ctxt *ctxt)
 =09char instruction[3];
 =09unsigned long rip =3D kvm_rip_read(vcpu);
=20
-=09kvm_x86_ops->patch_hypercall(vcpu, instruction);
+=09kvm_x86_patch_hypercall(vcpu, instruction);
=20
 =09return emulator_write_emulated(ctxt, rip, instruction, 3,
 =09=09&ctxt->exception);
@@ -7465,7 +7465,7 @@ static void update_cr8_intercept(struct kvm_vcpu *vcp=
u)
=20
 =09tpr =3D kvm_lapic_get_cr8(vcpu);
=20
-=09kvm_x86_ops->update_cr8_intercept(vcpu, tpr, max_irr);
+=09kvm_x86_update_cr8_intercept(vcpu, tpr, max_irr);
 }
=20
 static int inject_pending_event(struct kvm_vcpu *vcpu, bool req_int_win)
@@ -7475,7 +7475,7 @@ static int inject_pending_event(struct kvm_vcpu *vcpu=
, bool req_int_win)
 =09/* try to reinject previous events if any */
=20
 =09if (vcpu->arch.exception.injected)
-=09=09kvm_x86_ops->queue_exception(vcpu);
+=09=09kvm_x86_queue_exception(vcpu);
 =09/*
 =09 * Do not inject an NMI or interrupt if there is a pending
 =09 * exception.  Exceptions and interrupts are recognized at
@@ -7492,9 +7492,9 @@ static int inject_pending_event(struct kvm_vcpu *vcpu=
, bool req_int_win)
 =09 */
 =09else if (!vcpu->arch.exception.pending) {
 =09=09if (vcpu->arch.nmi_injected)
-=09=09=09kvm_x86_ops->set_nmi(vcpu);
+=09=09=09kvm_x86_set_nmi(vcpu);
 =09=09else if (vcpu->arch.interrupt.injected)
-=09=09=09kvm_x86_ops->set_irq(vcpu);
+=09=09=09kvm_x86_set_irq(vcpu);
 =09}
=20
 =09/*
@@ -7504,7 +7504,7 @@ static int inject_pending_event(struct kvm_vcpu *vcpu=
, bool req_int_win)
 =09 * from L2 to L1.
 =09 */
 =09if (is_guest_mode(vcpu) && kvm_x86_ops->check_nested_events) {
-=09=09r =3D kvm_x86_ops->check_nested_events(vcpu, req_int_win);
+=09=09r =3D kvm_x86_check_nested_events(vcpu, req_int_win);
 =09=09if (r !=3D 0)
 =09=09=09return r;
 =09}
@@ -7541,7 +7541,7 @@ static int inject_pending_event(struct kvm_vcpu *vcpu=
, bool req_int_win)
 =09=09=09}
 =09=09}
=20
-=09=09kvm_x86_ops->queue_exception(vcpu);
+=09=09kvm_x86_queue_exception(vcpu);
 =09}
=20
 =09/* Don't consider new event if we re-injected an event */
@@ -7549,14 +7549,14 @@ static int inject_pending_event(struct kvm_vcpu *vc=
pu, bool req_int_win)
 =09=09return 0;
=20
 =09if (vcpu->arch.smi_pending && !is_smm(vcpu) &&
-=09    kvm_x86_ops->smi_allowed(vcpu)) {
+=09    kvm_x86_smi_allowed(vcpu)) {
 =09=09vcpu->arch.smi_pending =3D false;
 =09=09++vcpu->arch.smi_count;
 =09=09enter_smm(vcpu);
-=09} else if (vcpu->arch.nmi_pending && kvm_x86_ops->nmi_allowed(vcpu)) {
+=09} else if (vcpu->arch.nmi_pending && kvm_x86_nmi_allowed(vcpu)) {
 =09=09--vcpu->arch.nmi_pending;
 =09=09vcpu->arch.nmi_injected =3D true;
-=09=09kvm_x86_ops->set_nmi(vcpu);
+=09=09kvm_x86_set_nmi(vcpu);
 =09} else if (kvm_cpu_has_injectable_intr(vcpu)) {
 =09=09/*
 =09=09 * Because interrupts can be injected asynchronously, we are
@@ -7566,14 +7566,14 @@ static int inject_pending_event(struct kvm_vcpu *vc=
pu, bool req_int_win)
 =09=09 * KVM_REQ_EVENT only on certain events and not unconditionally?
 =09=09 */
 =09=09if (is_guest_mode(vcpu) && kvm_x86_ops->check_nested_events) {
-=09=09=09r =3D kvm_x86_ops->check_nested_events(vcpu, req_int_win);
+=09=09=09r =3D kvm_x86_check_nested_events(vcpu, req_int_win);
 =09=09=09if (r !=3D 0)
 =09=09=09=09return r;
 =09=09}
-=09=09if (kvm_x86_ops->interrupt_allowed(vcpu)) {
+=09=09if (kvm_x86_interrupt_allowed(vcpu)) {
 =09=09=09kvm_queue_interrupt(vcpu, kvm_cpu_get_interrupt(vcpu),
 =09=09=09=09=09    false);
-=09=09=09kvm_x86_ops->set_irq(vcpu);
+=09=09=09kvm_x86_set_irq(vcpu);
 =09=09}
 =09}
=20
@@ -7589,7 +7589,7 @@ static void process_nmi(struct kvm_vcpu *vcpu)
 =09 * If an NMI is already in progress, limit further NMIs to just one.
 =09 * Otherwise, allow two (and we'll inject the first one immediately).
 =09 */
-=09if (kvm_x86_ops->get_nmi_mask(vcpu) || vcpu->arch.nmi_injected)
+=09if (kvm_x86_get_nmi_mask(vcpu) || vcpu->arch.nmi_injected)
 =09=09limit =3D 1;
=20
 =09vcpu->arch.nmi_pending +=3D atomic_xchg(&vcpu->arch.nmi_queued, 0);
@@ -7679,11 +7679,11 @@ static void enter_smm_save_state_32(struct kvm_vcpu=
 *vcpu, char *buf)
 =09put_smstate(u32, buf, 0x7f7c, seg.limit);
 =09put_smstate(u32, buf, 0x7f78, enter_smm_get_segment_flags(&seg));
=20
-=09kvm_x86_ops->get_gdt(vcpu, &dt);
+=09kvm_x86_get_gdt(vcpu, &dt);
 =09put_smstate(u32, buf, 0x7f74, dt.address);
 =09put_smstate(u32, buf, 0x7f70, dt.size);
=20
-=09kvm_x86_ops->get_idt(vcpu, &dt);
+=09kvm_x86_get_idt(vcpu, &dt);
 =09put_smstate(u32, buf, 0x7f58, dt.address);
 =09put_smstate(u32, buf, 0x7f54, dt.size);
=20
@@ -7733,7 +7733,7 @@ static void enter_smm_save_state_64(struct kvm_vcpu *=
vcpu, char *buf)
 =09put_smstate(u32, buf, 0x7e94, seg.limit);
 =09put_smstate(u64, buf, 0x7e98, seg.base);
=20
-=09kvm_x86_ops->get_idt(vcpu, &dt);
+=09kvm_x86_get_idt(vcpu, &dt);
 =09put_smstate(u32, buf, 0x7e84, dt.size);
 =09put_smstate(u64, buf, 0x7e88, dt.address);
=20
@@ -7743,7 +7743,7 @@ static void enter_smm_save_state_64(struct kvm_vcpu *=
vcpu, char *buf)
 =09put_smstate(u32, buf, 0x7e74, seg.limit);
 =09put_smstate(u64, buf, 0x7e78, seg.base);
=20
-=09kvm_x86_ops->get_gdt(vcpu, &dt);
+=09kvm_x86_get_gdt(vcpu, &dt);
 =09put_smstate(u32, buf, 0x7e64, dt.size);
 =09put_smstate(u64, buf, 0x7e68, dt.address);
=20
@@ -7773,28 +7773,28 @@ static void enter_smm(struct kvm_vcpu *vcpu)
 =09 * vCPU state (e.g. leave guest mode) after we've saved the state into
 =09 * the SMM state-save area.
 =09 */
-=09kvm_x86_ops->pre_enter_smm(vcpu, buf);
+=09kvm_x86_pre_enter_smm(vcpu, buf);
=20
 =09vcpu->arch.hflags |=3D HF_SMM_MASK;
 =09kvm_vcpu_write_guest(vcpu, vcpu->arch.smbase + 0xfe00, buf, sizeof(buf)=
);
=20
-=09if (kvm_x86_ops->get_nmi_mask(vcpu))
+=09if (kvm_x86_get_nmi_mask(vcpu))
 =09=09vcpu->arch.hflags |=3D HF_SMM_INSIDE_NMI_MASK;
 =09else
-=09=09kvm_x86_ops->set_nmi_mask(vcpu, true);
+=09=09kvm_x86_set_nmi_mask(vcpu, true);
=20
 =09kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
 =09kvm_rip_write(vcpu, 0x8000);
=20
 =09cr0 =3D vcpu->arch.cr0 & ~(X86_CR0_PE | X86_CR0_EM | X86_CR0_TS | X86_C=
R0_PG);
-=09kvm_x86_ops->set_cr0(vcpu, cr0);
+=09kvm_x86_set_cr0(vcpu, cr0);
 =09vcpu->arch.cr0 =3D cr0;
=20
-=09kvm_x86_ops->set_cr4(vcpu, 0);
+=09kvm_x86_set_cr4(vcpu, 0);
=20
 =09/* Undocumented: IDT limit is set to zero on entry to SMM.  */
 =09dt.address =3D dt.size =3D 0;
-=09kvm_x86_ops->set_idt(vcpu, &dt);
+=09kvm_x86_set_idt(vcpu, &dt);
=20
 =09__kvm_set_dr(vcpu, 7, DR7_FIXED_1);
=20
@@ -7825,7 +7825,7 @@ static void enter_smm(struct kvm_vcpu *vcpu)
=20
 #ifdef CONFIG_X86_64
 =09if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
-=09=09kvm_x86_ops->set_efer(vcpu, 0);
+=09=09kvm_x86_set_efer(vcpu, 0);
 #endif
=20
 =09kvm_update_cpuid(vcpu);
@@ -7854,7 +7854,7 @@ static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 =09=09kvm_scan_ioapic_routes(vcpu, vcpu->arch.ioapic_handled_vectors);
 =09else {
 =09=09if (vcpu->arch.apicv_active)
-=09=09=09kvm_x86_ops->sync_pir_to_irr(vcpu);
+=09=09=09kvm_x86_sync_pir_to_irr(vcpu);
 =09=09if (ioapic_in_kernel(vcpu->kvm))
 =09=09=09kvm_ioapic_scan_entry(vcpu, vcpu->arch.ioapic_handled_vectors);
 =09}
@@ -7874,7 +7874,7 @@ static void vcpu_load_eoi_exitmap(struct kvm_vcpu *vc=
pu)
=20
 =09bitmap_or((ulong *)eoi_exit_bitmap, vcpu->arch.ioapic_handled_vectors,
 =09=09  vcpu_to_synic(vcpu)->vec_bitmap, 256);
-=09kvm_x86_ops->load_eoi_exitmap(vcpu, eoi_exit_bitmap);
+=09kvm_x86_load_eoi_exitmap(vcpu, eoi_exit_bitmap);
 }
=20
 int kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
@@ -7907,7 +7907,7 @@ void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu=
 *vcpu)
 =09page =3D gfn_to_page(vcpu->kvm, APIC_DEFAULT_PHYS_BASE >> PAGE_SHIFT);
 =09if (is_error_page(page))
 =09=09return;
-=09kvm_x86_ops->set_apic_access_page_addr(vcpu, page_to_phys(page));
+=09kvm_x86_set_apic_access_page_addr(vcpu, page_to_phys(page));
=20
 =09/*
 =09 * Do not pin apic access page in memory, the MMU notifier
@@ -7939,7 +7939,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
=20
 =09if (kvm_request_pending(vcpu)) {
 =09=09if (kvm_check_request(KVM_REQ_GET_VMCS12_PAGES, vcpu)) {
-=09=09=09if (unlikely(!kvm_x86_ops->get_vmcs12_pages(vcpu))) {
+=09=09=09if (unlikely(!kvm_x86_get_vmcs12_pages(vcpu))) {
 =09=09=09=09r =3D 0;
 =09=09=09=09goto out;
 =09=09=09}
@@ -8061,12 +8061,12 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 =09=09=09 *    SMI.
 =09=09=09 */
 =09=09=09if (vcpu->arch.smi_pending && !is_smm(vcpu))
-=09=09=09=09if (!kvm_x86_ops->enable_smi_window(vcpu))
+=09=09=09=09if (!kvm_x86_enable_smi_window(vcpu))
 =09=09=09=09=09req_immediate_exit =3D true;
 =09=09=09if (vcpu->arch.nmi_pending)
-=09=09=09=09kvm_x86_ops->enable_nmi_window(vcpu);
+=09=09=09=09kvm_x86_enable_nmi_window(vcpu);
 =09=09=09if (kvm_cpu_has_injectable_intr(vcpu) || req_int_win)
-=09=09=09=09kvm_x86_ops->enable_irq_window(vcpu);
+=09=09=09=09kvm_x86_enable_irq_window(vcpu);
 =09=09=09WARN_ON(vcpu->arch.exception.pending);
 =09=09}
=20
@@ -8083,7 +8083,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
=20
 =09preempt_disable();
=20
-=09kvm_x86_ops->prepare_guest_switch(vcpu);
+=09kvm_x86_prepare_guest_switch(vcpu);
=20
 =09/*
 =09 * Disable IRQs before setting IN_GUEST_MODE.  Posted interrupt
@@ -8114,7 +8114,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 =09 * notified with kvm_vcpu_kick.
 =09 */
 =09if (kvm_lapic_enabled(vcpu) && vcpu->arch.apicv_active)
-=09=09kvm_x86_ops->sync_pir_to_irr(vcpu);
+=09=09kvm_x86_sync_pir_to_irr(vcpu);
=20
 =09if (vcpu->mode =3D=3D EXITING_GUEST_MODE || kvm_request_pending(vcpu)
 =09    || need_resched() || signal_pending(current)) {
@@ -8129,7 +8129,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
=20
 =09if (req_immediate_exit) {
 =09=09kvm_make_request(KVM_REQ_EVENT, vcpu);
-=09=09kvm_x86_ops->request_immediate_exit(vcpu);
+=09=09kvm_x86_request_immediate_exit(vcpu);
 =09}
=20
 =09trace_kvm_entry(vcpu->vcpu_id);
@@ -8148,7 +8148,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 =09=09vcpu->arch.switch_db_regs &=3D ~KVM_DEBUGREG_RELOAD;
 =09}
=20
-=09kvm_x86_ops->run(vcpu);
+=09kvm_x86_run(vcpu);
=20
 =09/*
 =09 * Do this here before restoring debug registers on the host.  And
@@ -8158,7 +8158,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 =09 */
 =09if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT)) {
 =09=09WARN_ON(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP);
-=09=09kvm_x86_ops->sync_dirty_debug_regs(vcpu);
+=09=09kvm_x86_sync_dirty_debug_regs(vcpu);
 =09=09kvm_update_dr0123(vcpu);
 =09=09kvm_update_dr6(vcpu);
 =09=09kvm_update_dr7(vcpu);
@@ -8180,7 +8180,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 =09vcpu->mode =3D OUTSIDE_GUEST_MODE;
 =09smp_wmb();
=20
-=09kvm_x86_ops->handle_exit_irqoff(vcpu);
+=09kvm_x86_handle_exit_irqoff(vcpu);
=20
 =09/*
 =09 * Consume any pending interrupts, including the possible source of
@@ -8224,11 +8224,11 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 =09=09kvm_lapic_sync_from_vapic(vcpu);
=20
 =09vcpu->arch.gpa_available =3D false;
-=09r =3D kvm_x86_ops->handle_exit(vcpu);
+=09r =3D kvm_x86_handle_exit(vcpu);
 =09return r;
=20
 cancel_injection:
-=09kvm_x86_ops->cancel_injection(vcpu);
+=09kvm_x86_cancel_injection(vcpu);
 =09if (unlikely(vcpu->arch.apic_attention))
 =09=09kvm_lapic_sync_from_vapic(vcpu);
 out:
@@ -8238,13 +8238,13 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 static inline int vcpu_block(struct kvm *kvm, struct kvm_vcpu *vcpu)
 {
 =09if (!kvm_arch_vcpu_runnable(vcpu) &&
-=09    (!kvm_x86_ops->pre_block || kvm_x86_ops->pre_block(vcpu) =3D=3D 0))=
 {
+=09    (!kvm_x86_ops->pre_block || kvm_x86_pre_block(vcpu) =3D=3D 0)) {
 =09=09srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
 =09=09kvm_vcpu_block(vcpu);
 =09=09vcpu->srcu_idx =3D srcu_read_lock(&kvm->srcu);
=20
 =09=09if (kvm_x86_ops->post_block)
-=09=09=09kvm_x86_ops->post_block(vcpu);
+=09=09=09kvm_x86_post_block(vcpu);
=20
 =09=09if (!kvm_check_request(KVM_REQ_UNHALT, vcpu))
 =09=09=09return 1;
@@ -8272,7 +8272,7 @@ static inline int vcpu_block(struct kvm *kvm, struct =
kvm_vcpu *vcpu)
 static inline bool kvm_vcpu_running(struct kvm_vcpu *vcpu)
 {
 =09if (is_guest_mode(vcpu) && kvm_x86_ops->check_nested_events)
-=09=09kvm_x86_ops->check_nested_events(vcpu, false);
+=09=09kvm_x86_check_nested_events(vcpu, false);
=20
 =09return (vcpu->arch.mp_state =3D=3D KVM_MP_STATE_RUNNABLE &&
 =09=09!vcpu->arch.apf.halted);
@@ -8616,10 +8616,10 @@ static void __get_sregs(struct kvm_vcpu *vcpu, stru=
ct kvm_sregs *sregs)
 =09kvm_get_segment(vcpu, &sregs->tr, VCPU_SREG_TR);
 =09kvm_get_segment(vcpu, &sregs->ldt, VCPU_SREG_LDTR);
=20
-=09kvm_x86_ops->get_idt(vcpu, &dt);
+=09kvm_x86_get_idt(vcpu, &dt);
 =09sregs->idt.limit =3D dt.size;
 =09sregs->idt.base =3D dt.address;
-=09kvm_x86_ops->get_gdt(vcpu, &dt);
+=09kvm_x86_get_gdt(vcpu, &dt);
 =09sregs->gdt.limit =3D dt.size;
 =09sregs->gdt.base =3D dt.address;
=20
@@ -8759,10 +8759,10 @@ static int __set_sregs(struct kvm_vcpu *vcpu, struc=
t kvm_sregs *sregs)
=20
 =09dt.size =3D sregs->idt.limit;
 =09dt.address =3D sregs->idt.base;
-=09kvm_x86_ops->set_idt(vcpu, &dt);
+=09kvm_x86_set_idt(vcpu, &dt);
 =09dt.size =3D sregs->gdt.limit;
 =09dt.address =3D sregs->gdt.base;
-=09kvm_x86_ops->set_gdt(vcpu, &dt);
+=09kvm_x86_set_gdt(vcpu, &dt);
=20
 =09vcpu->arch.cr2 =3D sregs->cr2;
 =09mmu_reset_needed |=3D kvm_read_cr3(vcpu) !=3D sregs->cr3;
@@ -8772,16 +8772,16 @@ static int __set_sregs(struct kvm_vcpu *vcpu, struc=
t kvm_sregs *sregs)
 =09kvm_set_cr8(vcpu, sregs->cr8);
=20
 =09mmu_reset_needed |=3D vcpu->arch.efer !=3D sregs->efer;
-=09kvm_x86_ops->set_efer(vcpu, sregs->efer);
+=09kvm_x86_set_efer(vcpu, sregs->efer);
=20
 =09mmu_reset_needed |=3D kvm_read_cr0(vcpu) !=3D sregs->cr0;
-=09kvm_x86_ops->set_cr0(vcpu, sregs->cr0);
+=09kvm_x86_set_cr0(vcpu, sregs->cr0);
 =09vcpu->arch.cr0 =3D sregs->cr0;
=20
 =09mmu_reset_needed |=3D kvm_read_cr4(vcpu) !=3D sregs->cr4;
 =09cpuid_update_needed |=3D ((kvm_read_cr4(vcpu) ^ sregs->cr4) &
 =09=09=09=09(X86_CR4_OSXSAVE | X86_CR4_PKE));
-=09kvm_x86_ops->set_cr4(vcpu, sregs->cr4);
+=09kvm_x86_set_cr4(vcpu, sregs->cr4);
 =09if (cpuid_update_needed)
 =09=09kvm_update_cpuid(vcpu);
=20
@@ -8887,7 +8887,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vc=
pu *vcpu,
 =09 */
 =09kvm_set_rflags(vcpu, rflags);
=20
-=09kvm_x86_ops->update_bp_intercept(vcpu);
+=09kvm_x86_update_bp_intercept(vcpu);
=20
 =09r =3D 0;
=20
@@ -9021,7 +9021,7 @@ void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
=20
 =09kvmclock_reset(vcpu);
=20
-=09kvm_x86_ops->vcpu_free(vcpu);
+=09kvm_x86_vcpu_free(vcpu);
 =09free_cpumask_var(wbinvd_dirty_mask);
 }
=20
@@ -9035,7 +9035,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm=
,
 =09=09"kvm: SMP vm created on host with unstable TSC; "
 =09=09"guest TSC will not be reliable\n");
=20
-=09vcpu =3D kvm_x86_ops->vcpu_create(kvm, id);
+=09vcpu =3D kvm_x86_vcpu_create(kvm, id);
=20
 =09return vcpu;
 }
@@ -9088,7 +9088,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 =09kvm_mmu_unload(vcpu);
 =09vcpu_put(vcpu);
=20
-=09kvm_x86_ops->vcpu_free(vcpu);
+=09kvm_x86_vcpu_free(vcpu);
 }
=20
 void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
@@ -9161,7 +9161,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_=
event)
=20
 =09vcpu->arch.ia32_xss =3D 0;
=20
-=09kvm_x86_ops->vcpu_reset(vcpu, init_event);
+=09kvm_x86_vcpu_reset(vcpu, init_event);
 }
=20
 void kvm_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
@@ -9186,7 +9186,7 @@ int kvm_arch_hardware_enable(void)
 =09bool stable, backwards_tsc =3D false;
=20
 =09kvm_shared_msr_cpu_online();
-=09ret =3D kvm_x86_ops->hardware_enable();
+=09ret =3D kvm_x86_hardware_enable();
 =09if (ret !=3D 0)
 =09=09return ret;
=20
@@ -9268,7 +9268,7 @@ int kvm_arch_hardware_enable(void)
=20
 void kvm_arch_hardware_disable(void)
 {
-=09kvm_x86_ops->hardware_disable();
+=09kvm_x86_hardware_disable();
 =09drop_user_return_notifiers();
 }
=20
@@ -9276,7 +9276,7 @@ int kvm_arch_hardware_setup(void)
 {
 =09int r;
=20
-=09r =3D kvm_x86_ops->hardware_setup();
+=09r =3D kvm_x86_hardware_setup();
 =09if (r !=3D 0)
 =09=09return r;
=20
@@ -9300,12 +9300,12 @@ int kvm_arch_hardware_setup(void)
=20
 void kvm_arch_hardware_unsetup(void)
 {
-=09kvm_x86_ops->hardware_unsetup();
+=09kvm_x86_hardware_unsetup();
 }
=20
 int kvm_arch_check_processor_compat(void)
 {
-=09return kvm_x86_ops->check_processor_compatibility();
+=09return kvm_x86_check_processor_compatibility();
 }
=20
 bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu)
@@ -9347,7 +9347,7 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 =09=09goto fail_free_pio_data;
=20
 =09if (irqchip_in_kernel(vcpu->kvm)) {
-=09=09vcpu->arch.apicv_active =3D kvm_x86_ops->get_enable_apicv(vcpu);
+=09=09vcpu->arch.apicv_active =3D kvm_x86_get_enable_apicv(vcpu);
 =09=09r =3D kvm_create_lapic(vcpu, lapic_timer_advance_ns);
 =09=09if (r < 0)
 =09=09=09goto fail_mmu_destroy;
@@ -9417,7 +9417,7 @@ void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
 void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu)
 {
 =09vcpu->arch.l1tf_flush_l1d =3D true;
-=09kvm_x86_ops->sched_in(vcpu, cpu);
+=09kvm_x86_sched_in(vcpu, cpu);
 }
=20
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
@@ -9453,7 +9453,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long t=
ype)
 =09kvm_page_track_init(kvm);
 =09kvm_mmu_init_vm(kvm);
=20
-=09return kvm_x86_ops->vm_init(kvm);
+=09return kvm_x86_vm_init(kvm);
 }
=20
 static void kvm_unload_vcpu_mmu(struct kvm_vcpu *vcpu)
@@ -9570,7 +9570,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 =09=09x86_set_memory_region(kvm, TSS_PRIVATE_MEMSLOT, 0, 0);
 =09}
 =09if (kvm_x86_ops->vm_destroy)
-=09=09kvm_x86_ops->vm_destroy(kvm);
+=09=09kvm_x86_vm_destroy(kvm);
 =09kvm_pic_destroy(kvm);
 =09kvm_ioapic_destroy(kvm);
 =09kvm_free_vcpus(kvm);
@@ -9727,12 +9727,12 @@ static void kvm_mmu_slot_apply_flags(struct kvm *kv=
m,
 =09 */
 =09if (new->flags & KVM_MEM_LOG_DIRTY_PAGES) {
 =09=09if (kvm_x86_ops->slot_enable_log_dirty)
-=09=09=09kvm_x86_ops->slot_enable_log_dirty(kvm, new);
+=09=09=09kvm_x86_slot_enable_log_dirty(kvm, new);
 =09=09else
 =09=09=09kvm_mmu_slot_remove_write_access(kvm, new);
 =09} else {
 =09=09if (kvm_x86_ops->slot_disable_log_dirty)
-=09=09=09kvm_x86_ops->slot_disable_log_dirty(kvm, new);
+=09=09=09kvm_x86_slot_disable_log_dirty(kvm, new);
 =09}
 }
=20
@@ -9797,7 +9797,7 @@ static inline bool kvm_guest_apic_has_interrupt(struc=
t kvm_vcpu *vcpu)
 {
 =09return (is_guest_mode(vcpu) &&
 =09=09=09kvm_x86_ops->guest_apic_has_interrupt &&
-=09=09=09kvm_x86_ops->guest_apic_has_interrupt(vcpu));
+=09=09=09kvm_x86_guest_apic_has_interrupt(vcpu));
 }
=20
 static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
@@ -9816,7 +9816,7 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcp=
u *vcpu)
=20
 =09if (kvm_test_request(KVM_REQ_NMI, vcpu) ||
 =09    (vcpu->arch.nmi_pending &&
-=09     kvm_x86_ops->nmi_allowed(vcpu)))
+=09     kvm_x86_nmi_allowed(vcpu)))
 =09=09return true;
=20
 =09if (kvm_test_request(KVM_REQ_SMI, vcpu) ||
@@ -9849,7 +9849,7 @@ bool kvm_arch_dy_runnable(struct kvm_vcpu *vcpu)
 =09=09 kvm_test_request(KVM_REQ_EVENT, vcpu))
 =09=09return true;
=20
-=09if (vcpu->arch.apicv_active && kvm_x86_ops->dy_apicv_has_pending_interr=
upt(vcpu))
+=09if (vcpu->arch.apicv_active && kvm_x86_dy_apicv_has_pending_interrupt(v=
cpu))
 =09=09return true;
=20
 =09return false;
@@ -9867,7 +9867,7 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
=20
 int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu)
 {
-=09return kvm_x86_ops->interrupt_allowed(vcpu);
+=09return kvm_x86_interrupt_allowed(vcpu);
 }
=20
 unsigned long kvm_get_linear_rip(struct kvm_vcpu *vcpu)
@@ -9889,7 +9889,7 @@ unsigned long kvm_get_rflags(struct kvm_vcpu *vcpu)
 {
 =09unsigned long rflags;
=20
-=09rflags =3D kvm_x86_ops->get_rflags(vcpu);
+=09rflags =3D kvm_x86_get_rflags(vcpu);
 =09if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)
 =09=09rflags &=3D ~X86_EFLAGS_TF;
 =09return rflags;
@@ -9901,7 +9901,7 @@ static void __kvm_set_rflags(struct kvm_vcpu *vcpu, u=
nsigned long rflags)
 =09if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP &&
 =09    kvm_is_linear_rip(vcpu, vcpu->arch.singlestep_rip))
 =09=09rflags |=3D X86_EFLAGS_TF;
-=09kvm_x86_ops->set_rflags(vcpu, rflags);
+=09kvm_x86_set_rflags(vcpu, rflags);
 }
=20
 void kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
@@ -10012,7 +10012,7 @@ static bool kvm_can_deliver_async_pf(struct kvm_vcp=
u *vcpu)
=20
 =09if (!(vcpu->arch.apf.msr_val & KVM_ASYNC_PF_ENABLED) ||
 =09    (vcpu->arch.apf.send_user_only &&
-=09     kvm_x86_ops->get_cpl(vcpu) =3D=3D 0))
+=09     kvm_x86_get_cpl(vcpu) =3D=3D 0))
 =09=09return false;
=20
 =09return true;
@@ -10032,7 +10032,7 @@ bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu)
 =09 * If interrupts are off we cannot even use an artificial
 =09 * halt state.
 =09 */
-=09return kvm_x86_ops->interrupt_allowed(vcpu);
+=09return kvm_x86_interrupt_allowed(vcpu);
 }
=20
 void kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
@@ -10161,7 +10161,7 @@ int kvm_arch_irq_bypass_add_producer(struct irq_byp=
ass_consumer *cons,
=20
 =09irqfd->producer =3D prod;
=20
-=09return kvm_x86_ops->update_pi_irte(irqfd->kvm,
+=09return kvm_x86_update_pi_irte(irqfd->kvm,
 =09=09=09=09=09   prod->irq, irqfd->gsi, 1);
 }
=20
@@ -10181,7 +10181,7 @@ void kvm_arch_irq_bypass_del_producer(struct irq_by=
pass_consumer *cons,
 =09 * when the irq is masked/disabled or the consumer side (KVM
 =09 * int this case doesn't want to receive the interrupts.
 =09*/
-=09ret =3D kvm_x86_ops->update_pi_irte(irqfd->kvm, prod->irq, irqfd->gsi, =
0);
+=09ret =3D kvm_x86_update_pi_irte(irqfd->kvm, prod->irq, irqfd->gsi, 0);
 =09if (ret)
 =09=09printk(KERN_INFO "irq bypass consumer (token %p) unregistration"
 =09=09       " fails: %d\n", irqfd->consumer.token, ret);
@@ -10190,7 +10190,7 @@ void kvm_arch_irq_bypass_del_producer(struct irq_by=
pass_consumer *cons,
 int kvm_arch_update_irqfd_routing(struct kvm *kvm, unsigned int host_irq,
 =09=09=09=09   uint32_t guest_irq, bool set)
 {
-=09return kvm_x86_ops->update_pi_irte(kvm, host_irq, guest_irq, set);
+=09return kvm_x86_update_pi_irte(kvm, host_irq, guest_irq, set);
 }
=20
 bool kvm_vector_hashing_enabled(void)
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index dbf7442a822b..7c5bd68443a3 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -96,7 +96,7 @@ static inline bool is_64_bit_mode(struct kvm_vcpu *vcpu)
=20
 =09if (!is_long_mode(vcpu))
 =09=09return false;
-=09kvm_x86_ops->get_cs_db_l_bits(vcpu, &cs_db, &cs_l);
+=09kvm_x86_get_cs_db_l_bits(vcpu, &cs_db, &cs_l);
 =09return cs_l;
 }
=20

