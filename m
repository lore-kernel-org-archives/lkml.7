Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EA2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B41820657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505560;
	bh=lH/KJvRdKDVmD7fjmZ4I34B5gbAzCxueLe9SBimE8eA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ysaSut2dRSf/9KdoU+AzbaAvs8zaaVHGSsK6c12A6Cp/dH0V4YLC/avrQbs8e7sAo
	 CcgzkHKH2/EFNftx6KhDm5DVWrX2AwvKkT/PoU6bUY+cbQcPtDJT00HYEYfUBeYH55
	 7RoD6+BXpVPVPYb058dpZTEbvy7OLelof4hAUFX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfCMTcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbfCMTLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:11:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2A652183F;
        Wed, 13 Mar 2019 19:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504266;
        bh=lH/KJvRdKDVmD7fjmZ4I34B5gbAzCxueLe9SBimE8eA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lj6mwk2VKq7z0fZWhHbAir/3c3duX3Go5IWoGij5aIC6RMgOu/Y5MeTtxaWIZM22i
         CkLG9gC92f5B2f8f4EmwtNLJOgEVFh6wdqXPDE5sB/RruxBxEHJuHL5xeKZdiJ1PIA
         aGAA71kCFMswT6R357s9gSblsI9sXIohvcTdG5m8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 21/60] arm64: fix SSBS sanitization
Date:   Wed, 13 Mar 2019 15:09:42 -0400
Message-Id: <20190313191021.158171-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit f54dada8274643e3ff4436df0ea124aeedc43cae ]

In valid_user_regs() we treat SSBS as a RES0 bit, and consequently it is
unexpectedly cleared when we restore a sigframe or fiddle with GPRs via
ptrace.

This patch fixes valid_user_regs() to account for this, updating the
function to refer to the latest ARM ARM (ARM DDI 0487D.a). For AArch32
tasks, SSBS appears in bit 23 of SPSR_EL1, matching its position in the
AArch32-native PSR format, and we don't need to translate it as we have
to for DIT.

There are no other bit assignments that we need to account for today.
As the recent documentation describes the DIT bit, we can drop our
comment regarding DIT.

While removing SSBS from the RES0 masks, existing inconsistent
whitespace is corrected.

Fixes: d71be2b6c0e19180 ("arm64: cpufeature: Detect SSBS and advertise to userspace")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/ptrace.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 1710a2d01669..8b3c419dc087 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1664,19 +1664,20 @@ void syscall_trace_exit(struct pt_regs *regs)
 }
 
 /*
- * SPSR_ELx bits which are always architecturally RES0 per ARM DDI 0487C.a
- * We also take into account DIT (bit 24), which is not yet documented, and
- * treat PAN and UAO as RES0 bits, as they are meaningless at EL0, and may be
- * allocated an EL0 meaning in future.
+ * SPSR_ELx bits which are always architecturally RES0 per ARM DDI 0487D.a.
+ * We permit userspace to set SSBS (AArch64 bit 12, AArch32 bit 23) which is
+ * not described in ARM DDI 0487D.a.
+ * We treat PAN and UAO as RES0 bits, as they are meaningless at EL0, and may
+ * be allocated an EL0 meaning in future.
  * Userspace cannot use these until they have an architectural meaning.
  * Note that this follows the SPSR_ELx format, not the AArch32 PSR format.
  * We also reserve IL for the kernel; SS is handled dynamically.
  */
 #define SPSR_EL1_AARCH64_RES0_BITS \
-	(GENMASK_ULL(63,32) | GENMASK_ULL(27, 25) | GENMASK_ULL(23, 22) | \
-	 GENMASK_ULL(20, 10) | GENMASK_ULL(5, 5))
+	(GENMASK_ULL(63, 32) | GENMASK_ULL(27, 25) | GENMASK_ULL(23, 22) | \
+	 GENMASK_ULL(20, 13) | GENMASK_ULL(11, 10) | GENMASK_ULL(5, 5))
 #define SPSR_EL1_AARCH32_RES0_BITS \
-	(GENMASK_ULL(63,32) | GENMASK_ULL(23, 22) | GENMASK_ULL(20,20))
+	(GENMASK_ULL(63, 32) | GENMASK_ULL(22, 22) | GENMASK_ULL(20, 20))
 
 static int valid_compat_regs(struct user_pt_regs *regs)
 {
-- 
2.19.1

