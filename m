Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C27CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DEE2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393217AbfJXK1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:27:48 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:46202 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390754AbfJXK1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:27:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=shannon.zhao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tg2wxnK_1571912847;
Received: from localhost(mailfrom:shannon.zhao@linux.alibaba.com fp:SMTPD_---0Tg2wxnK_1571912847)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Oct 2019 18:27:44 +0800
From:   Shannon Zhao <shannon.zhao@linux.alibaba.com>
To:     kvmarm@lists.cs.columbia.edu, maz@kernel.org, james.morse@arm.com,
        suzuki.poulose@arm.com, christoffer.dall@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC 1/7] KVM: ARM: call hyp_cpu_pm_exit on correct fail and exit path
Date:   Thu, 24 Oct 2019 18:27:44 +0800
Message-Id: <1571912870-18471-2-git-send-email-shannon.zhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571912870-18471-1-git-send-email-shannon.zhao@linux.alibaba.com>
References: <1571912870-18471-1-git-send-email-shannon.zhao@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Shannon Zhao <shannon.zhao@linux.alibaba.com>
---
 virt/kvm/arm/arm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 86c6aa1..da32c9b 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1488,6 +1488,7 @@ static int init_subsystems(void)
 	kvm_coproc_table_init();
 
 out:
+	hyp_cpu_pm_exit();
 	on_each_cpu(_kvm_arch_hardware_disable, NULL, 1);
 
 	return err;
@@ -1500,7 +1501,6 @@ static void teardown_hyp_mode(void)
 	free_hyp_pgds();
 	for_each_possible_cpu(cpu)
 		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
-	hyp_cpu_pm_exit();
 }
 
 /**
@@ -1724,6 +1724,7 @@ int kvm_arch_init(void *opaque)
 void kvm_arch_exit(void)
 {
 	kvm_perf_teardown();
+	hyp_cpu_pm_exit();
 }
 
 static int arm_init(void)
-- 
1.8.3.1

