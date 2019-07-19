Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFE9C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B512184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfGSA7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:59:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46764 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfGSA7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:59:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so14712297plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 17:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q4iIYpK+S82JSeYdaEcEAwDaH95Awzo4IK/xQp46zGM=;
        b=QXbQnE+WWYJ3RFGvsdp3qVfMoJsyRTtN6L7CxeLWjz0Ku2KBj89L80FDhfZBxP5xjl
         oIoyA8kpCc0lYAM95uYFCxcSKjijwVyV7DkSAQgTdYTVCrwacOBS9K4JyIV/xNCxR4Rq
         Edb3KRwR+rkSFc3viEoyepXzB6rrCxRdFMrzzm4cJV0BVM0lDVqu3PXytswqjNux8zBF
         TNaw3a97qXvNm9fjCNiS/v0VsrTCbH0seAsjCeEPMaOzlfMG+0ZzMXszXoDgHG2YYs5Z
         Xue9+KwD2KvLrrC6bNor7VClCVQiLy7FFQubhpmAhotIEVoh/lw2u7vln/Evo0KIYf0U
         N9TQ==
X-Gm-Message-State: APjAAAXkQ1Izx3zAYhyDvSThP3C+zDClv5T3B+7GxC9EuAz0e+rLPEMU
        oRF+8CIKTlVmVcoWmNTkKeQ=
X-Google-Smtp-Source: APXvYqx9bioOcesYK4TqBUmuB5QCAnPDMfSkh0IcOUOHN+zDAU0j0d0bJ2H22La6zJygvFAqoa+xMg==
X-Received: by 2002:a17:902:fe14:: with SMTP id g20mr50616582plj.54.1563497949334;
        Thu, 18 Jul 2019 17:59:09 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j128sm14025166pfg.28.2019.07.18.17.59.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 17:59:08 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Travis <mike.travis@hpe.com>
Subject: [PATCH v3 8/9] x86/mm/tlb: Remove UV special case
Date:   Thu, 18 Jul 2019 17:58:36 -0700
Message-Id: <20190719005837.4150-9-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719005837.4150-1-namit@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGI UV support is outdated and not maintained, and it is not clear how
it performs relatively to non-UV. Remove the code to simplify the code.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Acked-by: Mike Travis <mike.travis@hpe.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 89f83ad19507..40daad52ec7d 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -684,31 +684,6 @@ void native_flush_tlb_multi(const struct cpumask *cpumask,
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
-		flush_tlb_func_local((void *)info);
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
2.20.1

