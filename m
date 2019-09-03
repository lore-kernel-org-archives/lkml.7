Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA60C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150A5215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567528119;
	bh=FkGpRU1yy9aEz6Lo31CjpS1AI9j+y3Elk0LzZ2y+ofY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MFqwyWKKsFd+zl22UnyMMkS/lC/T4JRIkWi9JHJQlKGa7G6o1KbazQ2MLdKSu/JwS
	 gbsLL+COqzVMhsf9A0tMTmz3SzqwkyEhmvBHctb5eTWJy37XaVVBM262N3oEpPdCYg
	 BToSv2j/DylygSX/AksT5EOKp/UBNEpboC1MZL4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfICQ2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:28:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfICQ2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:28:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3129215EA;
        Tue,  3 Sep 2019 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567528111;
        bh=FkGpRU1yy9aEz6Lo31CjpS1AI9j+y3Elk0LzZ2y+ofY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=amPuOO3ARIp3oBp2Rjhy7U0gnQcX7TpkPYBoYJBu2+9WaNSSoNw92sOhUTXZM41S0
         3hWBwE8f3gv2Oy2GPL1ci3/xLtbZubmvSGkNtkTYYYp8rlNgEX2pB+igEyYHxdaQef
         FH2twAkeoDVXjmiBvoUGVJrI251GbfxLVoZGV+zQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 115/167] kvm: Check irqchip mode before assign irqfd
Date:   Tue,  3 Sep 2019 12:24:27 -0400
Message-Id: <20190903162519.7136-115-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

[ Upstream commit 654f1f13ea56b92bacade8ce2725aea0457f91c0 ]

When assigning kvm irqfd we didn't check the irqchip mode but we allow
KVM_IRQFD to succeed with all the irqchip modes.  However it does not
make much sense to create irqfd even without the kernel chips.  Let's
provide a arch-dependent helper to check whether a specific irqfd is
allowed by the arch.  At least for x86, it should make sense to check:

- when irqchip mode is NONE, all irqfds should be disallowed, and,

- when irqchip mode is SPLIT, irqfds that are with resamplefd should
  be disallowed.

For either of the case, previously we'll silently ignore the irq or
the irq ack event if the irqchip mode is incorrect.  However that can
cause misterious guest behaviors and it can be hard to triage.  Let's
fail KVM_IRQFD even earlier to detect these incorrect configurations.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Radim Krčmář <rkrcmar@redhat.com>
CC: Alex Williamson <alex.williamson@redhat.com>
CC: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/irq.c | 7 +++++++
 arch/x86/kvm/irq.h | 1 +
 virt/kvm/eventfd.c | 9 +++++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index faa264822cee3..007bc654f928a 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -172,3 +172,10 @@ void __kvm_migrate_timers(struct kvm_vcpu *vcpu)
 	__kvm_migrate_apic_timer(vcpu);
 	__kvm_migrate_pit_timer(vcpu);
 }
+
+bool kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args)
+{
+	bool resample = args->flags & KVM_IRQFD_FLAG_RESAMPLE;
+
+	return resample ? irqchip_kernel(kvm) : irqchip_in_kernel(kvm);
+}
diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
index d5005cc265217..fd210cdd49839 100644
--- a/arch/x86/kvm/irq.h
+++ b/arch/x86/kvm/irq.h
@@ -114,6 +114,7 @@ static inline int irqchip_in_kernel(struct kvm *kvm)
 	return mode != KVM_IRQCHIP_NONE;
 }
 
+bool kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args);
 void kvm_inject_pending_timer_irqs(struct kvm_vcpu *vcpu);
 void kvm_inject_apic_timer_irqs(struct kvm_vcpu *vcpu);
 void kvm_apic_nmi_wd_deliver(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index b20b751286fc6..757a17f5ebdeb 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -44,6 +44,12 @@
 
 static struct workqueue_struct *irqfd_cleanup_wq;
 
+bool __attribute__((weak))
+kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args)
+{
+	return true;
+}
+
 static void
 irqfd_inject(struct work_struct *work)
 {
@@ -297,6 +303,9 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	if (!kvm_arch_intc_initialized(kvm))
 		return -EAGAIN;
 
+	if (!kvm_arch_irqfd_allowed(kvm, args))
+		return -EINVAL;
+
 	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
 	if (!irqfd)
 		return -ENOMEM;
-- 
2.20.1

