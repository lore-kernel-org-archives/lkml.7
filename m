Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C4CC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D416D206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfD0PP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:15:29 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60764 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726817AbfD0PPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:12 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2k-0000zM-G3; Sat, 27 Apr 2019 16:15:10 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004QN-UB; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Heiko Carstens" <heiko.carstens@de.ibm.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.498629332@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 035/202] s390/mm: always force a load of the primary
 ASCE on context switch
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

commit a38662084c8bdb829ff486468c7ea801c13fcc34 upstream.

The ASCE of an mm_struct can be modified after a task has been created,
e.g. via crst_table_downgrade for a compat process. The active_mm logic
to avoid the switch_mm call if the next task is a kernel thread can
lead to a situation where switch_mm is called where 'prev == next' is
true but 'prev->context.asce == next->context.asce' is not.

This can lead to a situation where a CPU uses the outdated ASCE to run
a task. The result can be a crash, endless loops and really subtle
problem due to TLBs being created with an invalid ASCE.

Fixes: 53e857f30867 ("s390/mm,tlb: race of lazy TLB flush vs. recreation")
Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
[bwh: Backported to 3.16:
 - Keep the updates of mm_context_t::attach_count conditional on prev != next
 - Keep the update of mm_context_t::cpu_attach_mask conditional on both
   MACHINE_HAS_TLB_LC and prev != next
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -69,17 +69,17 @@ static inline void switch_mm(struct mm_s
 {
 	int cpu = smp_processor_id();
 
-	if (prev == next)
-		return;
 	if (MACHINE_HAS_TLB_LC)
 		cpumask_set_cpu(cpu, &next->context.cpu_attach_mask);
 	/* Clear old ASCE by loading the kernel ASCE. */
 	__ctl_load(S390_lowcore.kernel_asce, 1, 1);
 	__ctl_load(S390_lowcore.kernel_asce, 7, 7);
-	atomic_inc(&next->context.attach_count);
-	atomic_dec(&prev->context.attach_count);
-	if (MACHINE_HAS_TLB_LC)
-		cpumask_clear_cpu(cpu, &prev->context.cpu_attach_mask);
+	if (prev != next) {
+		atomic_inc(&next->context.attach_count);
+		atomic_dec(&prev->context.attach_count);
+		if (MACHINE_HAS_TLB_LC)
+			cpumask_clear_cpu(cpu, &prev->context.cpu_attach_mask);
+	}
 	S390_lowcore.user_asce = next->context.asce_bits | __pa(next->pgd);
 }
 

