Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B33AECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A6A218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfJJRPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 13:15:39 -0400
Received: from foss.arm.com ([217.140.110.172]:36356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfJJRPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:15:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC89C1570;
        Thu, 10 Oct 2019 10:15:36 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AA6B13F71A;
        Thu, 10 Oct 2019 10:15:35 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, dave.martin@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 2/3] arm64: nofpsmid: Clear TIF_FOREIGN_FPSTATE flag for early tasks
Date:   Thu, 10 Oct 2019 18:15:16 +0100
Message-Id: <20191010171517.28782-3-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010171517.28782-1-suzuki.poulose@arm.com>
References: <20191010171517.28782-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We detect the absence of FP/SIMD after we boot the SMP CPUs, and by then
we have kernel threads running already with TIF_FOREIGN_FPSTATE set which
could be inherited by early userspace applications (e.g, modprobe triggered
from initramfs). This could end up in the applications stuck in
do_nofity_resume() as we never clear the TIF flag, once we now know that
we don't support FP.

Fix this by making sure that we clear the TIF_FOREIGN_FPSTATE flag
for tasks which may have them set, as we would have done in the normal
case, but avoiding touching the hardware state (since we don't support any).

Fixes: 82e0191a1aa11abf ("arm64: Support systems without FP/ASIMD")
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 37d3912cfe06..dfcdd077aeca 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1128,12 +1128,19 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
  */
 void fpsimd_restore_current_state(void)
 {
-	if (!system_supports_fpsimd())
-		return;
-
 	get_cpu_fpsimd_context();
-
-	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
+	/*
+	 * For the tasks that were created before we detected the absence of
+	 * FP/SIMD, the TIF_FOREIGN_FPSTATE could be set via fpsimd_thread_switch()
+	 * and/or could be inherited from the parent(init_task has this set). Even
+	 * though userspace has not run yet, this could be inherited by the
+	 * processes forked from one of those tasks (e.g, modprobe from initramfs).
+	 * If the system doesn't support FP/SIMD, we must clear the flag for the
+	 * tasks mentioned above, to indicate that the FPSTATE is clean (as we
+	 * can't have one) to avoid looping for ever to clear the flag.
+	 */
+	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE) &&
+	    system_supports_fpsimd()) {
 		task_fpsimd_load();
 		fpsimd_bind_task_to_cpu();
 	}
@@ -1148,17 +1155,16 @@ void fpsimd_restore_current_state(void)
  */
 void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 {
-	if (!system_supports_fpsimd())
-		return;
-
 	get_cpu_fpsimd_context();
 
 	current->thread.uw.fpsimd_state = *state;
 	if (system_supports_sve() && test_thread_flag(TIF_SVE))
 		fpsimd_to_sve(current);
 
-	task_fpsimd_load();
-	fpsimd_bind_task_to_cpu();
+	if (system_supports_fpsimd()) {
+		task_fpsimd_load();
+		fpsimd_bind_task_to_cpu();
+	}
 
 	clear_thread_flag(TIF_FOREIGN_FPSTATE);
 
-- 
2.21.0

