Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA21C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBD221D7B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfJBOmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:42:15 -0400
Received: from foss.arm.com ([217.140.110.172]:45784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbfJBOmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:42:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B394E1650;
        Wed,  2 Oct 2019 07:42:13 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AE413F706;
        Wed,  2 Oct 2019 07:42:12 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com, ard.biesheuvel@linaro.org,
        ndesaulniers@google.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, luto@kernel.org
Subject: [PATCH v4 4/6] arm64: vdso32: Remove jump label config option in Makefile
Date:   Wed,  2 Oct 2019 15:41:54 +0100
Message-Id: <20191002144156.2174-5-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002144156.2174-1-vincenzo.frascino@arm.com>
References: <20191002144156.2174-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jump labels are not used in vdso32 since it is not possible to run
runtime patching on them.

Remove the configuration option from the Makefile.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/vdso32/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 77aa61340374..038357a1e835 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -38,9 +38,6 @@ VDSO_CAFLAGS += $(call cc32-option,-fno-PIE)
 ifdef CONFIG_DEBUG_INFO
 VDSO_CAFLAGS += -g
 endif
-ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(COMPATCC)), y)
-VDSO_CAFLAGS += -DCC_HAVE_ASM_GOTO
-endif
 
 # From arm Makefile
 VDSO_CAFLAGS += $(call cc32-option,-fno-dwarf2-cfi-asm)
-- 
2.23.0

