Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0701C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C91521670
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfHXGH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:07:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40936 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHXGH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:07:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so7058057pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t47Mh91KC8PBAKfYW2hdqr0XWZpHrpalT0CD9eTLxPY=;
        b=lWnyggLIHYiiYuAXIGzARW8+4Ru6iw8ApMrhvPMciVBrvy/X0g0HVRJYUoWmI+Ts95
         vcD54XJAIdrPwVMHNuS4SiEbB0hIqPTfgpQxKASrkTBb0rSenYQmJT+pKhEgxS2wi1QL
         +zJmi3jyYPESdXCc163PPL72niqCS1mjkiz1mC3DX+OfmBiwM56rHBdV6Ybsfsrl8PJh
         zukd04AaQbqzNTOlODkygfTerCiVvSmayUCkqba2PHhxYFeJZaRsc93m/E0rRYluuaoh
         pM9e1evSbrN7XerbUZKuPugKN+0MaXf/UfK98pSV54x8+hAEqOWxD/57cNX4xWCVgx+H
         50Pw==
X-Gm-Message-State: APjAAAU6tLodeRsNDInPTQ5zxXdNBJz+1zBvpEU66V0naLCePnKSGXaS
        10ReuLJ2ecqePRQxPNLD3ME=
X-Google-Smtp-Source: APXvYqyh2bcLbqRQZQ61yZE+nZGcSC8Zr6J3eJnTwc5AWQ6FGxu98SozEn4rO7g2H7diG4GDdF7Ziw==
X-Received: by 2002:a62:f245:: with SMTP id y5mr9347037pfl.156.1566626845668;
        Fri, 23 Aug 2019 23:07:25 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d12sm4951187pfn.11.2019.08.23.23.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:07:24 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [RFC PATCH 3/3] x86/mm/tlb: Use lockdep irq assertions
Date:   Fri, 23 Aug 2019 15:46:35 -0700
Message-Id: <20190823224635.15387-4-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823224635.15387-1-namit@vmware.com>
References: <20190823224635.15387-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assertions that check whether IRQs are disabled depend currently on
different debug features. Use instead lockdep_assert_irqs_disabled(),
which is standard, enabled by the same debug feature,  and provides more
information upon failures.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index ba50430275d4..6f4ce02e2c5b 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -293,8 +293,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 */
 
 	/* We don't want flush_tlb_func() to run concurrently with us. */
-	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
-		WARN_ON_ONCE(!irqs_disabled());
+	lockdep_assert_irqs_disabled();
 
 	/*
 	 * Verify that CR3 is what we think it is.  This will catch
@@ -643,7 +642,7 @@ static void flush_tlb_func(void *info)
 	unsigned long nr_invalidate = 0;
 
 	/* This code cannot presently handle being reentered. */
-	VM_WARN_ON(!irqs_disabled());
+	lockdep_assert_irqs_disabled();
 
 	if (!local) {
 		inc_irq_stat(irq_tlb_count);
-- 
2.17.1

