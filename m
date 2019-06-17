Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571D1C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3648D206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfFQNWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:22:51 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:9413 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfFQNWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:22:51 -0400
Received: from anisse-station.iliad.local (unknown [213.36.7.13])
        by smtp3-g21.free.fr (Postfix) with ESMTPS id 6347313F8DA;
        Mon, 17 Jun 2019 15:22:22 +0200 (CEST)
From:   Anisse Astier <aastier@freebox.fr>
To:     Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Rich Felker <dalias@aerifal.cx>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Ricardo Salveti <ricardo@foundries.io>,
        Sasha Levin <sashal@kernel.org>,
        Anisse Astier <aastier@freebox.fr>
Subject: [PATCH v3 1/2] arm64: ssbd: explicitly depend on <linux/prctl.h>
Date:   Mon, 17 Jun 2019 15:22:21 +0200
Message-Id: <20190617132222.32182-1-aastier@freebox.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190617084545.GA38959@anisse-station>
References: <20190617084545.GA38959@anisse-station>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix ssbd.c which depends implicitly on asm/ptrace.h including
linux/prctl.h (through for example linux/compat.h, then linux/time.h,
linux/seqlock.h, linux/spinlock.h and linux/irqflags.h), and uses
PR_SPEC* defines.

This is an issue since we'll remove the include in the next commit.

Fixes: 9cdc0108baa8 ("arm64: ssbd: Add prctl interface for per-thread mitigation")
Cc: stable@vger.kernel.org
Signed-off-by: Anisse Astier <aastier@freebox.fr>
---
Contrary to what I said in the previous email, I can reproduce the build
error on Linus' master when ARM64_SSBD is enabled.

Changes since v2:
 - fix build when ARM64_SSBD is enabled with additionnal patch
Changes since v1:
 - made a bit more explicit that we copied defined symbols, in commit
   and code.
 - Use Fixes: tag in commit message

Thanks to Dave Martin and Will Deacon for the review, and Sasha Levin
for the auto-build bot.
---
 arch/arm64/kernel/ssbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/ssbd.c b/arch/arm64/kernel/ssbd.c
index 885f13e58708..52cfc6148355 100644
--- a/arch/arm64/kernel/ssbd.c
+++ b/arch/arm64/kernel/ssbd.c
@@ -5,6 +5,7 @@
 
 #include <linux/compat.h>
 #include <linux/errno.h>
+#include <linux/prctl.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/thread_info.h>
-- 
2.19.1

