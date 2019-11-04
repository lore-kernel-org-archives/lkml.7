Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50657CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18038204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wi284Abx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbfKDXAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 18:00:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47204 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730116AbfKDXAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572908415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QUBIS7QxeVDPQkZsLW4ldNHlRlXWU+10ut3aF+gVsT0=;
        b=Wi284AbxZM4ZrT6HWWkliY5NIeAtv00wxlQdTm0llUEwbMEGxTubdxH6LxGndbmVcZXotS
        Dh61S7Y8mukHx755h2IgFjrmC2G55enYWGwEheW8WhyMr9fDZ54L1KQ7lat2uYCpm7XH8a
        JF5cAZjYpD/mBwUbZX/+qEcv2GirNKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-0GGD95rDN8itk3bzmTvb3w-1; Mon, 04 Nov 2019 18:00:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76FB61800DFF;
        Mon,  4 Nov 2019 23:00:09 +0000 (UTC)
Received: from mail (ovpn-121-157.rdu2.redhat.com [10.10.121.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3785F5D6D2;
        Mon,  4 Nov 2019 23:00:09 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 12/13] KVM: retpolines: x86: eliminate retpoline from svm.c exit handlers
Date:   Mon,  4 Nov 2019 18:00:00 -0500
Message-Id: <20191104230001.27774-13-aarcange@redhat.com>
In-Reply-To: <20191104230001.27774-1-aarcange@redhat.com>
References: <20191104230001.27774-1-aarcange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 0GGD95rDN8itk3bzmTvb3w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's enough to check the exit value and issue a direct call to avoid
the retpoline for all the common vmexit reasons.

After this commit is applied, here the most common retpolines executed
under a high resolution timer workload in the guest on a SVM host:

[..]
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    ktime_get_update_offsets_now+70
    hrtimer_interrupt+131
    smp_apic_timer_interrupt+106
    apic_timer_interrupt+15
    start_sw_timer+359
    restart_apic_timer+85
    kvm_set_msr_common+1497
    msr_interception+142
    vcpu_enter_guest+684
    kvm_arch_vcpu_ioctl_run+261
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 1940
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_r12+33
    force_qs_rnp+217
    rcu_gp_kthread+1270
    kthread+268
    ret_from_fork+34
]: 4644
@[]: 25095
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    lapic_next_event+28
    clockevents_program_event+148
    hrtimer_start_range_ns+528
    start_sw_timer+356
    restart_apic_timer+85
    kvm_set_msr_common+1497
    msr_interception+142
    vcpu_enter_guest+684
    kvm_arch_vcpu_ioctl_run+261
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 41474
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    clockevents_program_event+148
    hrtimer_start_range_ns+528
    start_sw_timer+356
    restart_apic_timer+85
    kvm_set_msr_common+1497
    msr_interception+142
    vcpu_enter_guest+684
    kvm_arch_vcpu_ioctl_run+261
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 41474
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    ktime_get+58
    clockevents_program_event+84
    hrtimer_start_range_ns+528
    start_sw_timer+356
    restart_apic_timer+85
    kvm_set_msr_common+1497
    msr_interception+142
    vcpu_enter_guest+684
    kvm_arch_vcpu_ioctl_run+261
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 41887
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    lapic_next_event+28
    clockevents_program_event+148
    hrtimer_try_to_cancel+168
    hrtimer_cancel+21
    kvm_set_lapic_tscdeadline_msr+43
    kvm_set_msr_common+1497
    msr_interception+142
    vcpu_enter_guest+684
    kvm_arch_vcpu_ioctl_run+261
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 42723
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    clockevents_program_event+148
    hrtimer_try_to_cancel+168
    hrtimer_cancel+21
    kvm_set_lapic_tscdeadline_msr+43
    kvm_set_msr_common+1497
    msr_interception+142
    vcpu_enter_guest+684
    kvm_arch_vcpu_ioctl_run+261
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 42766
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    ktime_get+58
    clockevents_program_event+84
    hrtimer_try_to_cancel+168
    hrtimer_cancel+21
    kvm_set_lapic_tscdeadline_msr+43
    kvm_set_msr_common+1497
    msr_interception+142
    vcpu_enter_guest+684
    kvm_arch_vcpu_ioctl_run+261
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 42848
@[
    trace_retpoline+1
    __trace_retpoline+30
    __x86_indirect_thunk_rax+33
    ktime_get+58
    start_sw_timer+279
    restart_apic_timer+85
    kvm_set_msr_common+1497
    msr_interception+142
    vcpu_enter_guest+684
    kvm_arch_vcpu_ioctl_run+261
    kvm_vcpu_ioctl+559
    do_vfs_ioctl+164
    ksys_ioctl+96
    __x64_sys_ioctl+22
    do_syscall_64+89
    entry_SYSCALL_64_after_hwframe+68
]: 499845

@total: 1780243

SVM has no TSC based programmable preemption timer so it is invoking
ktime_get() frequently.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 arch/x86/kvm/svm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 0021e11fd1fb..3942bca46740 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4995,6 +4995,18 @@ int kvm_x86_handle_exit(struct kvm_vcpu *vcpu)
 =09=09return 0;
 =09}
=20
+#ifdef CONFIG_RETPOLINE
+=09if (exit_code =3D=3D SVM_EXIT_MSR)
+=09=09return msr_interception(svm);
+=09else if (exit_code =3D=3D SVM_EXIT_VINTR)
+=09=09return interrupt_window_interception(svm);
+=09else if (exit_code =3D=3D SVM_EXIT_INTR)
+=09=09return intr_interception(svm);
+=09else if (exit_code =3D=3D SVM_EXIT_HLT)
+=09=09return halt_interception(svm);
+=09else if (exit_code =3D=3D SVM_EXIT_NPF)
+=09=09return npf_interception(svm);
+#endif
 =09return svm_exit_handlers[exit_code](svm);
 }
=20

