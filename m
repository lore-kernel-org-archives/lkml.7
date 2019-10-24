Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF92CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78932084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438800AbfJXK2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:28:01 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:51073 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390754AbfJXK15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:27:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=shannon.zhao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tg2bjwt_1571912873;
Received: from localhost(mailfrom:shannon.zhao@linux.alibaba.com fp:SMTPD_---0Tg2bjwt_1571912873)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Oct 2019 18:27:54 +0800
From:   Shannon Zhao <shannon.zhao@linux.alibaba.com>
To:     kvmarm@lists.cs.columbia.edu, maz@kernel.org, james.morse@arm.com,
        suzuki.poulose@arm.com, christoffer.dall@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC 6/7] KVM: arm/arm64: Move target table register into register table init function
Date:   Thu, 24 Oct 2019 18:27:49 +0800
Message-Id: <1571912870-18471-7-git-send-email-shannon.zhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571912870-18471-1-git-send-email-shannon.zhao@linux.alibaba.com>
References: <1571912870-18471-1-git-send-email-shannon.zhao@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares for making kvm arm compile as a module.

Signed-off-by: Shannon Zhao <shannon.zhao@linux.alibaba.com>
---
 arch/arm/kvm/coproc.c                | 3 +++
 arch/arm/kvm/coproc.h                | 3 +++
 arch/arm/kvm/coproc_a15.c            | 4 +---
 arch/arm/kvm/coproc_a7.c             | 4 +---
 arch/arm64/kvm/sys_regs.c            | 1 +
 arch/arm64/kvm/sys_regs.h            | 2 ++
 arch/arm64/kvm/sys_regs_generic_v8.c | 5 +----
 7 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 07745ee..58e48b1 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -1404,6 +1404,9 @@ void kvm_coproc_table_init(void)
 {
 	unsigned int i;
 
+	coproc_a7_init();
+	coproc_a15_init();
+
 	/* Make sure tables are unique and in order. */
 	BUG_ON(check_reg_table(cp15_regs, ARRAY_SIZE(cp15_regs)));
 	BUG_ON(check_reg_table(invariant_cp15, ARRAY_SIZE(invariant_cp15)));
diff --git a/arch/arm/kvm/coproc.h b/arch/arm/kvm/coproc.h
index 637065b..592118c 100644
--- a/arch/arm/kvm/coproc.h
+++ b/arch/arm/kvm/coproc.h
@@ -127,4 +127,7 @@ bool access_vm_reg(struct kvm_vcpu *vcpu,
 		   const struct coproc_params *p,
 		   const struct coproc_reg *r);
 
+void coproc_a7_init(void);
+void coproc_a15_init(void);
+
 #endif /* __ARM_KVM_COPROC_LOCAL_H__ */
diff --git a/arch/arm/kvm/coproc_a15.c b/arch/arm/kvm/coproc_a15.c
index 36bf154..ece74b2f 100644
--- a/arch/arm/kvm/coproc_a15.c
+++ b/arch/arm/kvm/coproc_a15.c
@@ -31,9 +31,7 @@
 	.num = ARRAY_SIZE(a15_regs),
 };
 
-static int __init coproc_a15_init(void)
+void coproc_a15_init(void)
 {
 	kvm_register_target_coproc_table(&a15_target_table);
-	return 0;
 }
-late_initcall(coproc_a15_init);
diff --git a/arch/arm/kvm/coproc_a7.c b/arch/arm/kvm/coproc_a7.c
index 40f643e..74616f5 100644
--- a/arch/arm/kvm/coproc_a7.c
+++ b/arch/arm/kvm/coproc_a7.c
@@ -34,9 +34,7 @@
 	.num = ARRAY_SIZE(a7_regs),
 };
 
-static int __init coproc_a7_init(void)
+void coproc_a7_init(void)
 {
 	kvm_register_target_coproc_table(&a7_target_table);
-	return 0;
 }
-late_initcall(coproc_a7_init);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 2071260..9dd164d 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2738,6 +2738,7 @@ void kvm_sys_reg_table_init(void)
 	unsigned int i;
 	struct sys_reg_desc clidr;
 
+	sys_reg_genericv8_init();
 	/* Make sure tables are unique and in order. */
 	BUG_ON(check_sysreg_table(sys_reg_descs, ARRAY_SIZE(sys_reg_descs)));
 	BUG_ON(check_sysreg_table(cp14_regs, ARRAY_SIZE(cp14_regs)));
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index 9bca031..f11cb63 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -140,6 +140,8 @@ const struct sys_reg_desc *find_reg_by_id(u64 id,
 					  const struct sys_reg_desc table[],
 					  unsigned int num);
 
+void sys_reg_genericv8_init(void);
+
 #define Op0(_x) 	.Op0 = _x
 #define Op1(_x) 	.Op1 = _x
 #define CRn(_x)		.CRn = _x
diff --git a/arch/arm64/kvm/sys_regs_generic_v8.c b/arch/arm64/kvm/sys_regs_generic_v8.c
index 2b4a3e2..3e4bacd 100644
--- a/arch/arm64/kvm/sys_regs_generic_v8.c
+++ b/arch/arm64/kvm/sys_regs_generic_v8.c
@@ -61,7 +61,7 @@ static void reset_actlr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 	},
 };
 
-static int __init sys_reg_genericv8_init(void)
+void sys_reg_genericv8_init(void)
 {
 	unsigned int i;
 
@@ -81,7 +81,4 @@ static int __init sys_reg_genericv8_init(void)
 					  &genericv8_target_table);
 	kvm_register_target_sys_reg_table(KVM_ARM_TARGET_GENERIC_V8,
 					  &genericv8_target_table);
-
-	return 0;
 }
-late_initcall(sys_reg_genericv8_init);
-- 
1.8.3.1

