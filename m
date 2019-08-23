Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AF1C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AE32133F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfHXGDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:03:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43582 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfHXGC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:02:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so6865122pld.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yQmvpe+T4cj+4Y3PYlBtzIZazSTk3vEicHeRtboqFPE=;
        b=i3RjvQv1p1+ga3QmE1WALQEAcpZq5wEHO7zx+2ZdcSw2wrL3C6HUhz1EV40msOQm7R
         NXEbvL8wXlfdgI1b1N+k91JT8h+fCY5i71jxYVtEz/omQB/tX/6fPhEnbk2QF36SA2KT
         L6UxCsK8aXX5BUZeJlUU5sbf7EG5/dsGLmHiFypv2NFr5kz9uUdvNBA4VP3H2UMtT59m
         mjsB2kwYMNjjDBToT41ewCQ2QIo10gsel6jbL0jYX2ayq3KkUfi6UEav+WyfhoKNoOrT
         OyYk10qS1jfDNOn48YrB1qp8tYa85B2YZV1YswbRTywtE7XAkVEG6saPxrArV0SGzJOz
         qvRw==
X-Gm-Message-State: APjAAAUq9Lv3y9Zs084+WnGhKDvExG934+LnBV2+kC6ZWGcnYtY4JzWb
        pQXyHmnfo6UcQlwKksOUdoo=
X-Google-Smtp-Source: APXvYqzw1snjNVuL3nM1dQtSjBtbLdhm9qVAcSizLuZxmSKdfWljVUQCBqtqrIvsyIjid4IUe3ggYA==
X-Received: by 2002:a17:902:a40d:: with SMTP id p13mr8558501plq.92.1566626574911;
        Fri, 23 Aug 2019 23:02:54 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id i11sm6505645pfk.34.2019.08.23.23.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:02:54 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v4 8/9] x86/mm/tlb: Remove UV special case
Date:   Fri, 23 Aug 2019 15:41:52 -0700
Message-Id: <20190823224153.15223-9-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823224153.15223-1-namit@vmware.com>
References: <20190823224153.15223-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGI UV TLB flushes is outdated and will be replaced with compatible
smp_call_many APIC function in the future. For now, simplify the code by
removing the UV special case.

Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 1393b3cd3697..3dca146edcf1 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -679,31 +679,6 @@ void native_flush_tlb_multi(const struct cpumask *cpumask,
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
-		 * flush instead of calling flush_tlb_func().  This
-		 * means that the percpu tlb_gen variables won't be updated
-		 * and we'll do pointless flushes on future context switches.
-		 *
-		 * Rather than hooking native_flush_tlb_multi() here, I think
-		 * that UV should be updated so that smp_call_function_many(),
-		 * etc, are optimal on UV.
-		 */
-		flush_tlb_func((void *)info);
-
-		cpumask = uv_flush_tlb_others(cpumask, info);
-		if (cpumask)
-			smp_call_function_many(cpumask, flush_tlb_func,
-					       (void *)info, 1);
-		return;
-	}
-
 	/*
 	 * If no page tables were freed, we can skip sending IPIs to
 	 * CPUs in lazy TLB mode. They will flush the CPU themselves
-- 
2.17.1

