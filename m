Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC570C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D1D233A2
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfHXGN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:13:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34288 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHXGN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:13:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id b24so8079628pfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MU+s43l9YNfmfiKrGOK95V+wQEIYwVtSRsLtoFkiecI=;
        b=krgFoU/KEeQM+RQpmxwtAL2tnkSOwCihg42Ws/XlQ/BwrsQeK1x8SttNxv8Oeou1IQ
         Aa1CiPl1VwGp0VmIT5pTkWiorpaj1k0fGDoSPcTLUsLZitcdE1GbVgmr+nNEAM6zThhJ
         nHVe+XGEWlQdN1qROQ1bEpCe/TpE6IHPDevQLWxqjetVF5pCTFPdq4JLBt+5bYqZtNTc
         zxURLfVH8jll3gIXypvPMPmaN6IV1Jerk1cobX85csNB/lulS5H67LnEYrVLsHOzETDn
         FeeYOR5oVdiZQaBec++2E6J8s4EJpn8xmFG5kTeH+ULdpSgEHeO31zuBRpw6nd5Oi/3n
         i+yQ==
X-Gm-Message-State: APjAAAWjyULKi+aw49806uVgwZEuqUJgixRdSESo43ksgYFjkzQI5Q6/
        Gu/mnoj8YEhQUgGV+/k4JkM=
X-Google-Smtp-Source: APXvYqxNyO+7QU4OZHJPGDlXOAFAwK2WexxG2FE4Zt5O/HQUQbwPmP3m/wCdHI2tOQ6Wbv4Ys1sqKA==
X-Received: by 2002:a62:aa13:: with SMTP id e19mr8936377pff.37.1566627205661;
        Fri, 23 Aug 2019 23:13:25 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id o9sm3691360pgv.19.2019.08.23.23.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:13:24 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [RFC PATCH v2 3/3] x86/mm/tlb: Avoid deferring PTI flushes on shootdown
Date:   Fri, 23 Aug 2019 15:52:48 -0700
Message-Id: <20190823225248.15597-4-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823225248.15597-1-namit@vmware.com>
References: <20190823225248.15597-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a shootdown is initiated, the initiating CPU has cycles to burn as
it waits for the responding CPUs to receive the IPI and acknowledge it.
In these cycles it is better to flush the user page-tables using
INVPCID, instead of deferring the TLB flush.

The best way to figure out whether there are cycles to burn is arguably
to expose from the SMP layer when an acknowledgment is received.
However, this would break some abstractions.

Instead, use a simpler solution: the initiating CPU of a TLB shootdown
would not defer PTI flushes. It is not always a win, relatively to
deferring user page-table flushes, but it prevents performance
regression.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/tlbflush.h |  1 +
 arch/x86/mm/tlb.c               | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index da56aa3ccd07..066b3804f876 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -573,6 +573,7 @@ struct flush_tlb_info {
 	unsigned int		initiating_cpu;
 	u8			stride_shift;
 	u8			freed_tables;
+	u8			shootdown;
 };
 
 #define local_flush_tlb() __flush_tlb()
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 31260c55d597..ba50430275d4 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -592,8 +592,13 @@ static void flush_tlb_user_pt_range(u16 asid, const struct flush_tlb_info *f)
 
 	/*
 	 * We can defer flushes as long as page-tables were not freed.
+	 *
+	 * However, if there is a shootdown the initiating CPU has cycles to
+	 * spare, while it waits for the other cores to respond. In this case,
+	 * deferring the flushing can cause overheads, so avoid it.
 	 */
-	if (IS_ENABLED(CONFIG_X86_64) && !f->freed_tables) {
+	if (IS_ENABLED(CONFIG_X86_64) && !f->freed_tables &&
+	    (!f->shootdown || f->initiating_cpu != smp_processor_id())) {
 		flush_user_tlb_deferred(asid, start, end, stride_shift);
 		return;
 	}
@@ -861,6 +866,7 @@ static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 	info->freed_tables	= freed_tables;
 	info->new_tlb_gen	= new_tlb_gen;
 	info->initiating_cpu	= smp_processor_id();
+	info->shootdown		= false;
 
 	return info;
 }
@@ -903,6 +909,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	 * flush_tlb_func_local() directly in this case.
 	 */
 	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
+		info->shootdown = true;
 		flush_tlb_multi(mm_cpumask(mm), info);
 	} else if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
 		lockdep_assert_irqs_enabled();
@@ -970,6 +977,7 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	 * flush_tlb_func_local() directly in this case.
 	 */
 	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
+		info->shootdown = true;
 		flush_tlb_multi(&batch->cpumask, info);
 	} else if (cpumask_test_cpu(cpu, &batch->cpumask)) {
 		lockdep_assert_irqs_enabled();
-- 
2.17.1

