Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A56CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD212204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389335AbfKDWWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:22:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388531AbfKDV5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:57:07 -0500
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7777186659
        for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2019 21:57:07 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id a1so14485847pfn.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 13:57:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VEjZbpLdVwy3arAkz9SYmqq7myiGlsbhXTCJx2Y0Xq4=;
        b=flwacDJwILsiVjVfbNa4GrUgSjWgCaI+iFhtmgP7LEuhKCDsPVxrdZbEBChBvZM1yp
         V1eYja9193UP0vpcWtJWG8QMiFjviwX0TW9kqMHT/ZytQ3gOICRJB3AstEExpNGkht4u
         oyWavc1YIGCrQZwqvz8ZzhWOVio0ydQAkrIIOEr8F6Yn3jX79rd4cqUsx6d4cWAHs9Eg
         j3KuzoykVi13WGCCYkIz4mV+Bup+1dG2Urb3kYayueTp8y1PJ2YiqU/xFOP57q2rUIor
         kiOerYi+crHfjqP8zGvhWSW4ydAwNLrKFk1i/kvi59I5rfRCtmeuZ1vo05CaE4T0MO0H
         6YWg==
X-Gm-Message-State: APjAAAU237koCKvKv5imapxr6wLk+0Xk0UlUoPu10pURakImsSiHl5D8
        XXZizGJiG9kazHv8sq0t8u5vsVPbBdWw6y0P1N8jDdgT+j+gRdHnV1k/ujVCcSUNdylT+uq9OsC
        rVsMzpBYv14E47VKUfeTfb0p2
X-Received: by 2002:a17:90a:b90b:: with SMTP id p11mr1792615pjr.73.1572904626742;
        Mon, 04 Nov 2019 13:57:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqxek4cnLo2j7JE5LY3Fdlz8cmjGPUDJiJmdDcXnAJbnRW3R15BMc9ytXLGrz8UQlHX/du+CWQ==
X-Received: by 2002:a17:90a:b90b:: with SMTP id p11mr1792574pjr.73.1572904626420;
        Mon, 04 Nov 2019 13:57:06 -0800 (PST)
Received: from localhost ([182.69.200.119])
        by smtp.gmail.com with ESMTPSA id r8sm4661118pgr.59.2019.11.04.13.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 13:57:05 -0800 (PST)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: [PATCH] arm64: mm: Remove MAX_USER_VA_BITS definition
Date:   Tue,  5 Nov 2019 03:26:46 +0530
Message-Id: <1572904606-27961-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 9b31cf493ffa ("arm64: mm: Introduce MAX_USER_VA_BITS definition")
introduced the MAX_USER_VA_BITS definition, which was used to support
the arm64 mm use-cases where the user-space could use 52-bit virtual
addresses whereas the kernel-space would still could a maximum of 48-bit
virtual addressing.

But, now with commit b6d00d47e81a ("arm64: mm: Introduce 52-bit Kernel
VAs"), we removed the 52-bit user/48-bit kernel kconfig option and hence
there is no longer any scenario where user VA != kernel VA size
(even with CONFIG_ARM64_FORCE_52BIT enabled, the same is true).

Hence we can do away with the MAX_USER_VA_BITS macro as it is equal to
VA_BITS (maximum VA space size) in all possible use-cases. Note that
even though the 'vabits_actual' value would be 48 for arm64 hardware
which don't support LVA-8.2 extension (even when CONFIG_ARM64_VA_BITS_52
is enabled), VA_BITS would still be set to a value 52. Hence this change
would be safe in all possible VA address space combinations.

Cc: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64/include/asm/memory.h        | 6 ------
 arch/arm64/include/asm/pgtable-hwdef.h | 2 +-
 arch/arm64/include/asm/processor.h     | 2 +-
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index c23c47360664..a4f9ca5479b0 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -69,12 +69,6 @@
 #define KERNEL_START		_text
 #define KERNEL_END		_end
 
-#ifdef CONFIG_ARM64_VA_BITS_52
-#define MAX_USER_VA_BITS	52
-#else
-#define MAX_USER_VA_BITS	VA_BITS
-#endif
-
 /*
  * Generic and tag-based KASAN require 1/8th and 1/16th of the kernel virtual
  * address space for the shadow region respectively. They can bloat the stack
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 3df60f97da1f..d9fbd433cc17 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -69,7 +69,7 @@
 #define PGDIR_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - CONFIG_PGTABLE_LEVELS)
 #define PGDIR_SIZE		(_AC(1, UL) << PGDIR_SHIFT)
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
-#define PTRS_PER_PGD		(1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))
+#define PTRS_PER_PGD		(1 << (VA_BITS - PGDIR_SHIFT))
 
 /*
  * Section address mask and size definitions.
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 5623685c7d13..586fcd4b1965 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -9,7 +9,7 @@
 #define __ASM_PROCESSOR_H
 
 #define KERNEL_DS		UL(-1)
-#define USER_DS			((UL(1) << MAX_USER_VA_BITS) - 1)
+#define USER_DS			((UL(1) << VA_BITS) - 1)
 
 /*
  * On arm64 systems, unaligned accesses by the CPU are cheap, and so there is
-- 
2.7.4

