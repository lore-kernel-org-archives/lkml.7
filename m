Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8815C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F4524670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sql0AUQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfLFWOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 17:14:00 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:48946 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfLFWN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:13:59 -0500
Received: by mail-pj1-f73.google.com with SMTP id o34so4331131pjb.15
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 14:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y+PZLTAB8cI7c6J3sLNCtDVk2nPLg4lB7Nz2OXbvgbI=;
        b=Sql0AUQx2FX2+C0fZujtdRKnpRimsqUsMS37x70l9M+sOZFbVJ3hWRwdsyDW5ACQD3
         mAFiXZYiLY1AxLu49KVGTXlXxNh1yY51dVbs0fY+4RxUcDmlWjM22YiWJSg/QlijLlR+
         LISSq0wh25qYppp+BCGBB3ASJ1IgdITLPyf57W++PmDhiZDO9WUYAB9cU3+NXaPjqcDE
         w4CLiFmNqW2XUK+Aroyl+dGcmQuxGGKW5WDjVx7vwC4+K9oGr9pTR8aiSWYEsabN9s4Z
         of4oOaIcSsRqcB6G4NGSbYRdfgN3Yi0kLtEC7/W0nA3ypJZva+dNrCITv6RcezBKGZVX
         zaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y+PZLTAB8cI7c6J3sLNCtDVk2nPLg4lB7Nz2OXbvgbI=;
        b=daBNxMDOzU6fxJQstq+yZ5eB4sF2qof5KM9hxVPQzsNBqcBvev0+y93r150I1FLdhG
         DcDfcmr1aGjpKThhzQNBwUt1Oho2GeoR61Pa1gqOzYlZU9rpPnUA6dt9WVE5NdsI7wq5
         Wh7Ek4a1Z9DAwokLjSJrXF14x8t4A+MhIky5nY8Y/RbfGhq+njEh5R+uKXCS5WXGqblM
         MRq3O46pxT3g8gctCn6Z2enYLS9ERrsRWQCxzVX5Y+dwfhjdEU6t73bIsed/zWlO9JKL
         qPypx6ko3xYWtNC10t33ImESkXC7AKiPiOqEEwKiloecCaqSYfPBvvlmZdFaWXvlKPOK
         k+MA==
X-Gm-Message-State: APjAAAVwmtPCTgz8VGnL4sSFgnyCqGFE1Q2UT1HwGQcibM9NEepyLpkc
        5pobnXNDz+LaUmrFd0tHhE09yuoyE8RAhq+WiNE=
X-Google-Smtp-Source: APXvYqywVZLwuqAoGiiDNrG08v6/3uqPLMW0Y7Sv/F1SLZBSFv5TaL7pDBX3rz4+Y7se97Kpozoy9je2n3q8Y+FKxcA=
X-Received: by 2002:a63:de4a:: with SMTP id y10mr5991658pgi.367.1575670438461;
 Fri, 06 Dec 2019 14:13:58 -0800 (PST)
Date:   Fri,  6 Dec 2019 14:13:37 -0800
In-Reply-To: <20191206221351.38241-1-samitolvanen@google.com>
Message-Id: <20191206221351.38241-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191206221351.38241-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v6 01/15] arm64: mm: avoid x18 in idmap_kpti_install_ng_mappings
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idmap_kpti_install_ng_mappings uses x18 as a temporary register, which
will result in a conflict when x18 is reserved. Use x16 and x17 instead
where needed.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/mm/proc.S | 63 ++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index a1e0592d1fbc..fdabf40a83c8 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -250,15 +250,15 @@ ENTRY(idmap_kpti_install_ng_mappings)
 	/* We're the boot CPU. Wait for the others to catch up */
 	sevl
 1:	wfe
-	ldaxr	w18, [flag_ptr]
-	eor	w18, w18, num_cpus
-	cbnz	w18, 1b
+	ldaxr	w17, [flag_ptr]
+	eor	w17, w17, num_cpus
+	cbnz	w17, 1b
 
 	/* We need to walk swapper, so turn off the MMU. */
 	pre_disable_mmu_workaround
-	mrs	x18, sctlr_el1
-	bic	x18, x18, #SCTLR_ELx_M
-	msr	sctlr_el1, x18
+	mrs	x17, sctlr_el1
+	bic	x17, x17, #SCTLR_ELx_M
+	msr	sctlr_el1, x17
 	isb
 
 	/* Everybody is enjoying the idmap, so we can rewrite swapper. */
@@ -281,9 +281,9 @@ skip_pgd:
 	isb
 
 	/* We're done: fire up the MMU again */
-	mrs	x18, sctlr_el1
-	orr	x18, x18, #SCTLR_ELx_M
-	msr	sctlr_el1, x18
+	mrs	x17, sctlr_el1
+	orr	x17, x17, #SCTLR_ELx_M
+	msr	sctlr_el1, x17
 	isb
 
 	/*
@@ -353,46 +353,47 @@ skip_pte:
 	b.ne	do_pte
 	b	next_pmd
 
+	.unreq	cpu
+	.unreq	num_cpus
+	.unreq	swapper_pa
+	.unreq	cur_pgdp
+	.unreq	end_pgdp
+	.unreq	pgd
+	.unreq	cur_pudp
+	.unreq	end_pudp
+	.unreq	pud
+	.unreq	cur_pmdp
+	.unreq	end_pmdp
+	.unreq	pmd
+	.unreq	cur_ptep
+	.unreq	end_ptep
+	.unreq	pte
+
 	/* Secondary CPUs end up here */
 __idmap_kpti_secondary:
 	/* Uninstall swapper before surgery begins */
-	__idmap_cpu_set_reserved_ttbr1 x18, x17
+	__idmap_cpu_set_reserved_ttbr1 x16, x17
 
 	/* Increment the flag to let the boot CPU we're ready */
-1:	ldxr	w18, [flag_ptr]
-	add	w18, w18, #1
-	stxr	w17, w18, [flag_ptr]
+1:	ldxr	w16, [flag_ptr]
+	add	w16, w16, #1
+	stxr	w17, w16, [flag_ptr]
 	cbnz	w17, 1b
 
 	/* Wait for the boot CPU to finish messing around with swapper */
 	sevl
 1:	wfe
-	ldxr	w18, [flag_ptr]
-	cbnz	w18, 1b
+	ldxr	w16, [flag_ptr]
+	cbnz	w16, 1b
 
 	/* All done, act like nothing happened */
-	offset_ttbr1 swapper_ttb, x18
+	offset_ttbr1 swapper_ttb, x16
 	msr	ttbr1_el1, swapper_ttb
 	isb
 	ret
 
-	.unreq	cpu
-	.unreq	num_cpus
-	.unreq	swapper_pa
 	.unreq	swapper_ttb
 	.unreq	flag_ptr
-	.unreq	cur_pgdp
-	.unreq	end_pgdp
-	.unreq	pgd
-	.unreq	cur_pudp
-	.unreq	end_pudp
-	.unreq	pud
-	.unreq	cur_pmdp
-	.unreq	end_pmdp
-	.unreq	pmd
-	.unreq	cur_ptep
-	.unreq	end_ptep
-	.unreq	pte
 ENDPROC(idmap_kpti_install_ng_mappings)
 	.popsection
 #endif
-- 
2.24.0.393.g34dc348eaf-goog

