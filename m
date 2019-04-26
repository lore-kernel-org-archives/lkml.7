Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CE6C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F6F2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdYahecr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfD0GnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:43:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33820 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfD0GnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:43:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id d5so1988647plr.1;
        Fri, 26 Apr 2019 23:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wqvLZPneRcLgxY6Wjfk6EEQBPauaGcOxn9fq0yjJ9xE=;
        b=vdYahecrwl2Sp5UawSR3og0bnv/oKfDwV/Dqodp6SG75rtt3oI1BxkHqScjMRc/B0U
         ndpm0CSM99X5DI5nXyZ0qilWlZ5y+YmffvE0rzTsPOh9Lg0wVC5gzIbXO3T2rI/43jKw
         dSv/fQEMrgklgF9DfRp0UTkxOOmbTA2q76DVrniyNWh8V594RE3EBRYYfPR9C72DIbVe
         QvUfF6WjCix52aEKKarcvG6J8JGMJ6kiAHPNxAecwgyTiM6P6ST8UlxjffLYXWC/UN5g
         Hhv9thRtl94b6Emad3qIhmqwC571N8N4kkx/zbp3oEc24WAmffQk4ZXiiSSJrBGsI7VY
         gu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wqvLZPneRcLgxY6Wjfk6EEQBPauaGcOxn9fq0yjJ9xE=;
        b=sBGy4iBLh+YH3Vxoc5sewmFwb6rcbAnc/LfYQ+mQ2MNO8Y4II2Cz6J2gZEyc2s1wEU
         4fgP8YiMkq9MdEkZDEAQzeh65SK9/cCPBdwV60HOvlaKkgM5wB4bMl+/TpLLfYve2Fm4
         5cdTiHY74Z6eGInaz3bQPwkomNOe5HsIGjUclYn6SfZbb7Zhu4iuu+GDXllRl+ckqhhD
         D8nTbg7x55e3eUEgy6a4DG2XINGIfLFmrBqumCK51LzsdKv5lsBZgOAlvwHVVzBn+dkG
         du37msilFuHAZDe4AXrVZkLQALtuE35lbLSbP+hJSOyIwnMAVh6c6lsHgMNjAqU1JN+R
         t9GQ==
X-Gm-Message-State: APjAAAWvfm7NzmDxx0yJ1YgvNqsw4OPVTp3mpWQNySQwrQ/Ev/XVN30K
        yib+jqHHG3sT4M9DdreZHKA=
X-Google-Smtp-Source: APXvYqyiprnnWU4rXtsHhhC4I5UqVMx78ccNfm1X35wazpAaZSJma1EHcKW1CFUxAhCYo5lEBNcLEA==
X-Received: by 2002:a17:902:aa83:: with SMTP id d3mr8074837plr.108.1556347388411;
        Fri, 26 Apr 2019 23:43:08 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j22sm36460145pfn.129.2019.04.26.23.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 23:43:07 -0700 (PDT)
From:   nadav.amit@gmail.com
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v6 04/24] x86/mm: Save debug registers when loading a temporary mm
Date:   Fri, 26 Apr 2019 16:22:43 -0700
Message-Id: <20190426232303.28381-5-nadav.amit@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426232303.28381-1-nadav.amit@gmail.com>
References: <20190426232303.28381-1-nadav.amit@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Prevent user watchpoints from mistakenly firing while the temporary mm
is being used. As the addresses of the temporary mm might overlap those
of the user-process, this is necessary to prevent wrong signals or worse
things from happening.

Cc: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/mmu_context.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 24dc3b810970..93dff1963337 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -13,6 +13,7 @@
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/mpx.h>
+#include <asm/debugreg.h>
 
 extern atomic64_t last_mm_ctx_id;
 
@@ -380,6 +381,21 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
 	lockdep_assert_irqs_disabled();
 	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	switch_mm_irqs_off(NULL, mm, current);
+
+	/*
+	 * If breakpoints are enabled, disable them while the temporary mm is
+	 * used. Userspace might set up watchpoints on addresses that are used
+	 * in the temporary mm, which would lead to wrong signals being sent or
+	 * crashes.
+	 *
+	 * Note that breakpoints are not disabled selectively, which also causes
+	 * kernel breakpoints (e.g., perf's) to be disabled. This might be
+	 * undesirable, but still seems reasonable as the code that runs in the
+	 * temporary mm should be short.
+	 */
+	if (hw_breakpoint_active())
+		hw_breakpoint_disable();
+
 	return temp_state;
 }
 
@@ -387,6 +403,13 @@ static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
 {
 	lockdep_assert_irqs_disabled();
 	switch_mm_irqs_off(NULL, prev_state.mm, current);
+
+	/*
+	 * Restore the breakpoints if they were disabled before the temporary mm
+	 * was loaded.
+	 */
+	if (hw_breakpoint_active())
+		hw_breakpoint_restore();
 }
 
 #endif /* _ASM_X86_MMU_CONTEXT_H */
-- 
2.17.1

