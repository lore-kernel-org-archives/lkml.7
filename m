Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC10CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803E22089E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494057;
	bh=3L+IQwvQDdqWZRQVsDruL1DOw6e+QLjGDZNG9Teckc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CEfjdF2ksc8rCsvelmxh07FUSNwNrM0se119Mutz7ROJS4S9FthBvx0L+Y612wk8E
	 MNEm4lHo3VFkRE67/YdseYKBc2CoIU/3LmLJKI5Fq7UHjRkawhz7MAC4NlhmRaQ8ri
	 WJ2QpTyZo8wvykutE2NIVKoIvyKMQt+D5w+vFzm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391060AbfHVROP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390567AbfHVRIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:08:54 -0400
Received: from sasha-vm.mshome.net (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76E382342A;
        Thu, 22 Aug 2019 17:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493733;
        bh=3L+IQwvQDdqWZRQVsDruL1DOw6e+QLjGDZNG9Teckc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fWENqGdHQXjPmz3XzVwz9P5cdd7Ucz5G6j/b8sBYxVDnW9+xH1z/jZgHRrGr6Pq82
         5YGBCjRwhCuMYSpDdbhlc5/0HSh2LJL5IOievbvwXp4GuKqgNda2jRcImszE+4ct+G
         BEyQedZd/Ppr5l6IuS5w3s0HbhPzVxPQJdOthSWg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julien Thierry <julien.thierry.kdev@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 072/135] arm64: Lower priority mask for GIC_PRIO_IRQON
Date:   Thu, 22 Aug 2019 13:07:08 -0400
Message-Id: <20190822170811.13303-73-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822170811.13303-1-sashal@kernel.org>
References: <20190822170811.13303-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.2.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.2.10-rc1
X-KernelTest-Deadline: 2019-08-24T17:07+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry.kdev@gmail.com>

[ Upstream commit 677379bc9139ac24b310a281fcb21a2f04288353 ]

On a system with two security states, if SCR_EL3.FIQ is cleared,
non-secure IRQ priorities get shifted to fit the secure view but
priority masks aren't.

On such system, it turns out that GIC_PRIO_IRQON masks the priority of
normal interrupts, which obviously ends up in a hang.

Increase GIC_PRIO_IRQON value (i.e. lower priority) to make sure
interrupts are not blocked by it.

Cc: Oleg Nesterov <oleg@redhat.com>
Fixes: bd82d4bd21880b7c ("arm64: Fix incorrect irqflag restore for priority masking")
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Julien Thierry <julien.thierry.kdev@gmail.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[will: fixed Fixes: tag]
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/arch_gicv3.h | 6 ++++++
 arch/arm64/include/asm/ptrace.h     | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 79155a8cfe7c0..89e4c8b793490 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -155,6 +155,12 @@ static inline void gic_pmr_mask_irqs(void)
 	BUILD_BUG_ON(GICD_INT_DEF_PRI < (GIC_PRIO_IRQOFF |
 					 GIC_PRIO_PSR_I_SET));
 	BUILD_BUG_ON(GICD_INT_DEF_PRI >= GIC_PRIO_IRQON);
+	/*
+	 * Need to make sure IRQON allows IRQs when SCR_EL3.FIQ is cleared
+	 * and non-secure PMR accesses are not subject to the shifts that
+	 * are applied to IRQ priorities
+	 */
+	BUILD_BUG_ON((0x80 | (GICD_INT_DEF_PRI >> 1)) >= GIC_PRIO_IRQON);
 	gic_write_pmr(GIC_PRIO_IRQOFF);
 }
 
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 81693244f58d6..701eaa7381876 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -30,7 +30,7 @@
  * in the  the priority mask, it indicates that PSR.I should be set and
  * interrupt disabling temporarily does not rely on IRQ priorities.
  */
-#define GIC_PRIO_IRQON			0xc0
+#define GIC_PRIO_IRQON			0xe0
 #define GIC_PRIO_IRQOFF			(GIC_PRIO_IRQON & ~0x80)
 #define GIC_PRIO_PSR_I_SET		(1 << 4)
 
-- 
2.20.1

