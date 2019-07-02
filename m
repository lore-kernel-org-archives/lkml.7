Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946F8C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDF22187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfGCHOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:14:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36203 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfGCHOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:14:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id c13so734578pgg.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 00:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NXoq/g9SNXesQbIqYah0Z5HeiVpSvum5leZGJ+NoGTU=;
        b=ayDsHCadQRDFJ+Xwoqr3oDIx5TB9gGM3LmWjqvwcjHpVo0Dp4AhAwsVQ1zQhZtvvk2
         VkxJAJBZ2+0T5N8GAIbp2fcYSMarh+r97Y9uP0lOx3LtSejkuPle0syGIq1vqoH/3qPq
         XoGrEcYwINUxb6vnW9+ARPgb1UQNtXUr6X3LR8gTaHaCbtcBvPXPRLn9PyLjPg7hMn30
         BHFgAMbpvsQdRDpvn83OswfaTnzpufJFO9DAJUBhlsaoDQ8UV81K/zHXCEQA8lSyesnF
         bNCucuhwh4O9mDluGWWyl1t3rgE149t6UR8X75yBkUbLR4yB1DYtyzno6SPAdtpsNagx
         4jnQ==
X-Gm-Message-State: APjAAAXeLS+b9AaDMz3Eg2BPDk/0KOJB0sdR2pGgQezJWRl5fugzSKKm
        rQRbP33hxnuuAFfNunpTY18=
X-Google-Smtp-Source: APXvYqyu/rXjrAEcSuy3mkKjHme8r9lNmmxNh+LlOg3ylgLG8G3IL4s8KpAxSq42L2sDXGhXaG8UBg==
X-Received: by 2002:a63:d4c:: with SMTP id 12mr36330199pgn.30.1562138053471;
        Wed, 03 Jul 2019 00:14:13 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j21sm1256593pfh.86.2019.07.03.00.14.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 00:14:12 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v2 8/9] x86/mm/tlb: Remove UV special case
Date:   Tue,  2 Jul 2019 16:51:50 -0700
Message-Id: <20190702235151.4377-9-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702235151.4377-1-namit@vmware.com>
References: <20190702235151.4377-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGI UV support is outdated and not maintained, and it is not clear how
it performs relatively to non-UV. Remove the code to simplify the code.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index b47a71820f35..64afe1215495 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -689,31 +689,6 @@ void native_flush_tlb_multi(const struct cpumask *cpumask,
 		trace_tlb_flush(TLB_REMOTE_SEND_IPI,
 				(info->end - info->start) >> PAGE_SHIFT);
 
-	if (is_uv_system()) {
-		/*
-		 * This whole special case is confused.  UV has a "Broadcast
-		 * Assist Unit", which seems to be a fancy way to send IPIs.
-		 * Back when x86 used an explicit TLB flush IPI, UV was
-		 * optimized to use its own mechanism.  These days, x86 uses
-		 * smp_call_function_many(), but UV still uses a manual IPI,
-		 * and that IPI's action is out of date -- it does a manual
-		 * flush instead of calling flush_tlb_func_remote().  This
-		 * means that the percpu tlb_gen variables won't be updated
-		 * and we'll do pointless flushes on future context switches.
-		 *
-		 * Rather than hooking native_flush_tlb_multi() here, I think
-		 * that UV should be updated so that smp_call_function_many(),
-		 * etc, are optimal on UV.
-		 */
-		flush_tlb_func_local(info);
-
-		cpumask = uv_flush_tlb_others(cpumask, info);
-		if (cpumask)
-			smp_call_function_many(cpumask, flush_tlb_func_remote,
-					       (void *)info, 1);
-		return;
-	}
-
 	/*
 	 * If no page tables were freed, we can skip sending IPIs to
 	 * CPUs in lazy TLB mode. They will flush the CPU themselves
-- 
2.17.1

