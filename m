Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B6AECE58E
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC2A21927
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384514;
	bh=pu4n2wMCvRAxmv9xH0RGN0RBKEN0pLLcS8ZHQdFAPxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QswCfeqWHaFtpXh8Gvz8neFr69HXyD9nUDJhXR3COqQKeabgRzsBm1oi+0q7+Toll
	 7ykmuJ96C7bFuCLwW4ISbsCFFM0Hk/YeqfhQYKt1xs+Byll5tEuG2depNXb2kVGSyv
	 9oFSokLGxUAl3kqzzYdefyvNAAGMCYyWtxK2NKy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfJFRzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbfJFRy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:54:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2D182246E;
        Sun,  6 Oct 2019 17:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383976;
        bh=pu4n2wMCvRAxmv9xH0RGN0RBKEN0pLLcS8ZHQdFAPxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MV+xG/QLjuSIX9VSeFwy9VhoQNxOw6z8U1PmidNPfhRcnJX1ULEU41XxoBmZcx4pm
         hLXeMukHhTpnQyMNq+nfZC9MDo+WS1HCueSKTbtaPY9vnLaYCDZJYEwj4xb9FDxC4n
         f3r/PILSF0sjwU+MZnG/0QD1hnQ/O4SwgDFhOZrU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+dff25ee91f0c7d5c1695@syzkaller.appspotmail.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 5.3 164/166] KVM: hyperv: Fix Direct Synthetic timers assert an interrupt w/o lapic_in_kernel
Date:   Sun,  6 Oct 2019 19:22:10 +0200
Message-Id: <20191006171226.670549155@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

commit a073d7e3ad687a7ef32b65affe80faa7ce89bf92 upstream.

Reported by syzkaller:

	kasan: GPF could be caused by NULL-ptr deref or user memory access
	general protection fault: 0000 [#1] PREEMPT SMP KASAN
	RIP: 0010:__apic_accept_irq+0x46/0x740 arch/x86/kvm/lapic.c:1029
	Call Trace:
	kvm_apic_set_irq+0xb4/0x140 arch/x86/kvm/lapic.c:558
	stimer_notify_direct arch/x86/kvm/hyperv.c:648 [inline]
	stimer_expiration arch/x86/kvm/hyperv.c:659 [inline]
	kvm_hv_process_stimers+0x594/0x1650 arch/x86/kvm/hyperv.c:686
	vcpu_enter_guest+0x2b2a/0x54b0 arch/x86/kvm/x86.c:7896
	vcpu_run+0x393/0xd40 arch/x86/kvm/x86.c:8152
	kvm_arch_vcpu_ioctl_run+0x636/0x900 arch/x86/kvm/x86.c:8360
	kvm_vcpu_ioctl+0x6cf/0xaf0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2765

The testcase programs HV_X64_MSR_STIMERn_CONFIG/HV_X64_MSR_STIMERn_COUNT,
in addition, there is no lapic in the kernel, the counters value are small
enough in order that kvm_hv_process_stimers() inject this already-expired
timer interrupt into the guest through lapic in the kernel which triggers
the NULL deferencing. This patch fixes it by don't advertise direct mode
synthetic timers and discarding the inject when lapic is not in kernel.

syzkaller source: https://syzkaller.appspot.com/x/repro.c?x=1752fe0a600000

Reported-by: syzbot+dff25ee91f0c7d5c1695@syzkaller.appspotmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/hyperv.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -645,7 +645,9 @@ static int stimer_notify_direct(struct k
 		.vector = stimer->config.apic_vector
 	};
 
-	return !kvm_apic_set_irq(vcpu, &irq, NULL);
+	if (lapic_in_kernel(vcpu))
+		return !kvm_apic_set_irq(vcpu, &irq, NULL);
+	return 0;
 }
 
 static void stimer_expiration(struct kvm_vcpu_hv_stimer *stimer)
@@ -1852,7 +1854,13 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct k
 
 			ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
 			ent->edx |= HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
-			ent->edx |= HV_STIMER_DIRECT_MODE_AVAILABLE;
+
+			/*
+			 * Direct Synthetic timers only make sense with in-kernel
+			 * LAPIC
+			 */
+			if (lapic_in_kernel(vcpu))
+				ent->edx |= HV_STIMER_DIRECT_MODE_AVAILABLE;
 
 			break;
 


