Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3CACA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D234E20663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393608AbfJXNbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:31:39 -0400
Received: from foss.arm.com ([217.140.110.172]:51516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388827AbfJXNbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:31:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17A06C8F;
        Thu, 24 Oct 2019 06:31:24 -0700 (PDT)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2C493F71A;
        Thu, 24 Oct 2019 06:31:22 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     catalin.marinas@arm.com, kernel-janitors@vger.kernel.org,
        Mao Wenan <maowenan@huawei.com>, linux-kernel@vger.kernel.org,
        will@kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
        Steven Price <steven.price@arm.com>
Subject: [PATCH v2] KVM: arm64: Select TASK_DELAY_ACCT+TASKSTATS rather than SCHEDSTATS
Date:   Thu, 24 Oct 2019 14:31:11 +0100
Message-Id: <20191024133111.27758-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <3abfc893613caf529b0f6a933e74068d@www.loen.fr>
References: <3abfc893613caf529b0f6a933e74068d@www.loen.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCHEDSTATS requires DEBUG_KERNEL (and PROC_FS) and therefore isn't a
good choice for enabling the scheduling statistics required for stolen
time.

Instead match the x86 configuration and select TASK_DELAY_ACCT and
TASKSTATS. This adds the dependencies of NET && MULTIUSER for arm64 KVM.

Suggested-by: Marc Zyngier <maz@kernel.org>
Fixes: 8564d6372a7d ("KVM: arm64: Support stolen time reporting via shared structure")
Signed-off-by: Steven Price <steven.price@arm.com>
---

Let's try again! Somehow I'd got it into my head that TASK_DELAY_ACCT
selected TASKSTATS not depended on. Even though I'd managed to get it
right in the comment!

 arch/arm64/kvm/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index d8b88e40d223..a475c68cbfec 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -21,6 +21,8 @@ if VIRTUALIZATION
 config KVM
 	bool "Kernel-based Virtual Machine (KVM) support"
 	depends on OF
+	# for TASKSTATS/TASK_DELAY_ACCT:
+	depends on NET && MULTIUSER
 	select MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
@@ -39,7 +41,8 @@ config KVM
 	select IRQ_BYPASS_MANAGER
 	select HAVE_KVM_IRQ_BYPASS
 	select HAVE_KVM_VCPU_RUN_PID_CHANGE
-	select SCHEDSTATS
+	select TASKSTATS
+	select TASK_DELAY_ACCT
 	---help---
 	  Support hosting virtualized guest machines.
 	  We don't support KVM with 16K page tables yet, due to the multiple
-- 
2.20.1

