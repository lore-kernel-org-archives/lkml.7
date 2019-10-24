Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93700CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CA920684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409094AbfJXK16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:27:58 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:52626 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409083AbfJXK14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:27:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=shannon.zhao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tg2twD8_1571912871;
Received: from localhost(mailfrom:shannon.zhao@linux.alibaba.com fp:SMTPD_---0Tg2twD8_1571912871)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Oct 2019 18:27:52 +0800
From:   Shannon Zhao <shannon.zhao@linux.alibaba.com>
To:     kvmarm@lists.cs.columbia.edu, maz@kernel.org, james.morse@arm.com,
        suzuki.poulose@arm.com, christoffer.dall@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC 5/7] KVM: arch_timer: Add hyp uninitialize function
Date:   Thu, 24 Oct 2019 18:27:48 +0800
Message-Id: <1571912870-18471-6-git-send-email-shannon.zhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571912870-18471-1-git-send-email-shannon.zhao@linux.alibaba.com>
References: <1571912870-18471-1-git-send-email-shannon.zhao@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When KVM ARM exits, it needs to cleanup arch_timer setup by kvm_timer_hyp_init.

Signed-off-by: Shannon Zhao <shannon.zhao@linux.alibaba.com>
---
 include/kvm/arm_arch_timer.h |  1 +
 virt/kvm/arm/arch_timer.c    | 13 +++++++++++++
 virt/kvm/arm/arm.c           |  1 +
 3 files changed, 15 insertions(+)

diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index d120e6c..3cb3a01 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -68,6 +68,7 @@ struct arch_timer_cpu {
 };
 
 int kvm_timer_hyp_init(bool);
+void kvm_timer_hyp_uninit(void);
 int kvm_timer_enable(struct kvm_vcpu *vcpu);
 int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu);
 void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index f5a5d51..7dafa97 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -991,6 +991,19 @@ int kvm_timer_hyp_init(bool has_gic)
 	return err;
 }
 
+void kvm_timer_hyp_uninit(void)
+{
+	struct arch_timer_kvm_info *info = arch_timer_get_kvm_info();
+
+	cpuhp_remove_state(CPUHP_AP_KVM_ARM_TIMER_STARTING);
+	if (info->physical_irq > 0) {
+		on_each_cpu(disable_percpu_irq, (void *)host_ptimer_irq, 1);
+		free_percpu_irq(host_ptimer_irq, kvm_get_running_vcpus());
+	}
+	on_each_cpu(disable_percpu_irq, (void *)host_vtimer_irq, 1);
+	free_percpu_irq(host_vtimer_irq, kvm_get_running_vcpus());
+}
+
 void kvm_timer_vcpu_terminate(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 0c60074..feb6649 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1724,6 +1724,7 @@ int kvm_arch_init(void *opaque)
 void kvm_arch_exit(void)
 {
 	kvm_perf_teardown();
+	kvm_timer_hyp_uninit();
 	kvm_vgic_hyp_uninit();
 	hyp_cpu_pm_exit();
 }
-- 
1.8.3.1

