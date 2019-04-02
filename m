Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C98AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B7520856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbfDBNq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:46:27 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43122 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731418AbfDBNkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:05 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdv-0002nJ-Np; Tue, 02 Apr 2019 14:39:59 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdu-0004sM-GU; Tue, 02 Apr 2019 14:39:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jiwei Sun" <jiwei.sun@windriver.com>, linux-mips@vger.kernel.org,
        "Paul Burton" <paul.burton@mips.com>,
        "Yu Huabing" <yhb@ruijie.com.cn>, "James Hogan" <jhogan@kernel.org>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.659673533@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 24/99] MIPS: Expand MIPS32 ASIDs to 64 bits
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit ff4dd232ec45a0e45ea69f28f069f2ab22b4908a upstream.

ASIDs have always been stored as unsigned longs, ie. 32 bits on MIPS32
kernels. This is problematic because it is feasible for the ASID version
to overflow & wrap around to zero.

We currently attempt to handle this overflow by simply setting the ASID
version to 1, using asid_first_version(), but we make no attempt to
account for the fact that there may be mm_structs with stale ASIDs that
have versions which we now reuse due to the overflow & wrap around.

Encountering this requires that:

  1) A struct mm_struct X is active on CPU A using ASID (V,n).

  2) That mm is not used on CPU A for the length of time that it takes
     for CPU A's asid_cache to overflow & wrap around to the same
     version V that the mm had in step 1. During this time tasks using
     the mm could either be sleeping or only scheduled on other CPUs.

  3) Some other mm Y becomes active on CPU A and is allocated the same
     ASID (V,n).

  4) mm X now becomes active on CPU A again, and now incorrectly has the
     same ASID as mm Y.

Where struct mm_struct ASIDs are represented above in the format
(version, EntryHi.ASID), and on a typical MIPS32 system version will be
24 bits wide & EntryHi.ASID will be 8 bits wide.

The length of time required in step 2 is highly dependent upon the CPU &
workload, but for a hypothetical 2GHz CPU running a workload which
generates a new ASID every 10000 cycles this period is around 248 days.
Due to this long period of time & the fact that tasks need to be
scheduled in just the right (or wrong, depending upon your inclination)
way, this is obviously a difficult bug to encounter but it's entirely
possible as evidenced by reports.

In order to fix this, simply extend ASIDs to 64 bits even on MIPS32
builds. This will extend the period of time required for the
hypothetical system above to encounter the problem from 28 days to
around 3 trillion years, which feels safely outside of the realms of
possibility.

The cost of this is slightly more generated code in some commonly
executed paths, but this is pretty minimal:

                         | Code Size Gain | Percentage
  -----------------------|----------------|-------------
    decstation_defconfig |           +270 | +0.00%
        32r2el_defconfig |           +652 | +0.01%
        32r6el_defconfig |          +1000 | +0.01%

I have been unable to measure any change in performance of the LMbench
lat_ctx or lat_proc tests resulting from the 64b ASIDs on either
32r2el_defconfig+interAptiv or 32r6el_defconfig+I6500 systems.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Suggested-by: James Hogan <jhogan@kernel.org>
References: https://lore.kernel.org/linux-mips/80B78A8B8FEE6145A87579E8435D78C30205D5F3@fzex.ruijie.com.cn/
References: https://lore.kernel.org/linux-mips/1488684260-18867-1-git-send-email-jiwei.sun@windriver.com/
Cc: Jiwei Sun <jiwei.sun@windriver.com>
Cc: Yu Huabing <yhb@ruijie.com.cn>
Cc: linux-mips@vger.kernel.org
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -39,7 +39,7 @@ struct cache_desc {
 #define MIPS_CACHE_PINDEX	0x00000020	/* Physically indexed cache */
 
 struct cpuinfo_mips {
-	unsigned long		asid_cache;
+	u64			asid_cache;
 
 	/*
 	 * Capability and feature descriptor structure for MIPS CPU
--- a/arch/mips/include/asm/mmu.h
+++ b/arch/mips/include/asm/mmu.h
@@ -2,7 +2,7 @@
 #define __ASM_MMU_H
 
 typedef struct {
-	unsigned long asid[NR_CPUS];
+	u64 asid[NR_CPUS];
 	void *vdso;
 } mm_context_t;
 
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -85,15 +85,15 @@ static inline void enter_lazy_tlb(struct
  *  All unused by hardware upper bits will be considered
  *  as a software asid extension.
  */
-#define ASID_VERSION_MASK  ((unsigned long)~(ASID_MASK|(ASID_MASK-1)))
-#define ASID_FIRST_VERSION ((unsigned long)(~ASID_VERSION_MASK) + 1)
+#define ASID_VERSION_MASK  (~(u64)(ASID_MASK | (ASID_MASK - 1)))
+#define ASID_FIRST_VERSION ((u64)(~ASID_VERSION_MASK) + 1)
 
 /* Normal, classic MIPS get_new_mmu_context */
 static inline void
 get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
 {
 	extern void kvm_local_flush_tlb_all(void);
-	unsigned long asid = asid_cache(cpu);
+	u64 asid = asid_cache(cpu);
 
 	if (! ((asid += ASID_INC) & ASID_MASK) ) {
 		if (cpu_has_vtag_icache)
@@ -103,8 +103,6 @@ get_new_mmu_context(struct mm_struct *mm
 #else
 		local_flush_tlb_all();	/* start new asid cycle */
 #endif
-		if (!asid)		/* fix version if needed */
-			asid = ASID_FIRST_VERSION;
 	}
 
 	cpu_context(cpu, mm) = asid_cache(cpu) = asid;
--- a/arch/mips/mm/c-r3k.c
+++ b/arch/mips/mm/c-r3k.c
@@ -244,7 +244,7 @@ static void r3k_flush_cache_page(struct
 	pmd_t *pmdp;
 	pte_t *ptep;
 
-	pr_debug("cpage[%08lx,%08lx]\n",
+	pr_debug("cpage[%08llx,%08lx]\n",
 		 cpu_context(smp_processor_id(), mm), addr);
 
 	/* No ASID => no such page in the cache.  */

