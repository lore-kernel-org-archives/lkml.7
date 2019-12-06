Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B183C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE4A2464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfLFNy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:54:59 -0500
Received: from foss.arm.com ([217.140.110.172]:45150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfLFNyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:54:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E38511FB;
        Fri,  6 Dec 2019 05:54:55 -0800 (PST)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 930B63F718;
        Fri,  6 Dec 2019 05:54:52 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH v16 25/25] mm: ptdump: Reduce level numbers by 1 in note_page()
Date:   Fri,  6 Dec 2019 13:53:16 +0000
Message-Id: <20191206135316.47703-26-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191206135316.47703-1-steven.price@arm.com>
References: <20191206135316.47703-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than having to increment the 'depth' number by 1 in
ptdump_hole(), let's change the meaning of 'level' in note_page() since
that makes the code simplier.

Note that for x86, the level numbers were previously increased by 1 in
commit 45dcd2091363 ("x86/mm/dump_pagetables: Fix printout of p4d level")
and the comment "Bit 7 has a different meaning" was not updated, so this
change also makes the code match the comment again.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/mm/dump.c          |  6 +++---
 arch/x86/mm/dump_pagetables.c | 19 ++++++++++---------
 include/linux/ptdump.h        |  1 +
 mm/ptdump.c                   | 16 ++++++++--------
 4 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 3203dd8e6d0a..4997ce244172 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -175,8 +175,7 @@ struct pg_level {
 };
 
 static struct pg_level pg_level[] = {
-	{
-	}, { /* pgd */
+	{ /* pgd */
 		.name	= "PGD",
 		.bits	= pte_bits,
 		.num	= ARRAY_SIZE(pte_bits),
@@ -256,7 +255,7 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 	if (level >= 0)
 		prot = val & pg_level[level].mask;
 
-	if (!st->level) {
+	if (st->level == -1) {
 		st->level = level;
 		st->current_prot = prot;
 		st->start_address = addr;
@@ -350,6 +349,7 @@ void ptdump_check_wx(void)
 			{ 0, NULL},
 			{ -1, NULL},
 		},
+		.level = -1,
 		.check_wx = true,
 		.ptdump = {
 			.note_page = note_page,
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 77a1332c6cd4..d3c28b3765fc 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -176,7 +176,7 @@ static struct addr_marker address_markers[] = {
 static void printk_prot(struct seq_file *m, pgprotval_t pr, int level, bool dmsg)
 {
 	static const char * const level_name[] =
-		{ "cr3", "pgd", "p4d", "pud", "pmd", "pte" };
+		{ "pgd", "p4d", "pud", "pmd", "pte" };
 
 	if (!(pr & _PAGE_PRESENT)) {
 		/* Not present */
@@ -200,12 +200,12 @@ static void printk_prot(struct seq_file *m, pgprotval_t pr, int level, bool dmsg
 			pt_dump_cont_printf(m, dmsg, "    ");
 
 		/* Bit 7 has a different meaning on level 3 vs 4 */
-		if (level <= 4 && pr & _PAGE_PSE)
+		if (level <= 3 && pr & _PAGE_PSE)
 			pt_dump_cont_printf(m, dmsg, "PSE ");
 		else
 			pt_dump_cont_printf(m, dmsg, "    ");
-		if ((level == 5 && pr & _PAGE_PAT) ||
-		    ((level == 4 || level == 3) && pr & _PAGE_PAT_LARGE))
+		if ((level == 4 && pr & _PAGE_PAT) ||
+		    ((level == 3 || level == 2) && pr & _PAGE_PAT_LARGE))
 			pt_dump_cont_printf(m, dmsg, "PAT ");
 		else
 			pt_dump_cont_printf(m, dmsg, "    ");
@@ -267,15 +267,15 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 
 	new_prot = val & PTE_FLAGS_MASK;
 
-	if (level > 1) {
-		new_eff = effective_prot(st->prot_levels[level - 2],
+	if (level > 0) {
+		new_eff = effective_prot(st->prot_levels[level - 1],
 					 new_prot);
 	} else {
 		new_eff = new_prot;
 	}
 
-	if (level > 0)
-		st->prot_levels[level - 1] = new_eff;
+	if (level >= 0)
+		st->prot_levels[level] = new_eff;
 
 	/*
 	 * If we have a "break" in the series, we need to flush the state that
@@ -285,7 +285,7 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 	cur = st->current_prot;
 	eff = st->effective_prot;
 
-	if (!st->level) {
+	if (st->level == -1) {
 		/* First entry */
 		st->current_prot = new_prot;
 		st->effective_prot = new_eff;
@@ -376,6 +376,7 @@ static void ptdump_walk_pgd_level_core(struct seq_file *m, struct mm_struct *mm,
 			.note_page	= note_page,
 			.range		= ptdump_ranges
 		},
+		.level = -1,
 		.to_dmesg	= dmesg,
 		.check_wx	= checkwx,
 		.seq		= m
diff --git a/include/linux/ptdump.h b/include/linux/ptdump.h
index a0fb8dd2be97..b28f3f2acf90 100644
--- a/include/linux/ptdump.h
+++ b/include/linux/ptdump.h
@@ -11,6 +11,7 @@ struct ptdump_range {
 };
 
 struct ptdump_state {
+	/* level is 0:PGD to 4:PTE, or -1 if unknown */
 	void (*note_page)(struct ptdump_state *st, unsigned long addr,
 			  int level, unsigned long val);
 	const struct ptdump_range *range;
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 9357ab3ecc88..39b0773b6172 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -11,7 +11,7 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
 	pgd_t val = READ_ONCE(*pgd);
 
 	if (pgd_leaf(val))
-		st->note_page(st, addr, 1, pgd_val(val));
+		st->note_page(st, addr, 0, pgd_val(val));
 
 	return 0;
 }
@@ -23,7 +23,7 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
 	p4d_t val = READ_ONCE(*p4d);
 
 	if (p4d_leaf(val))
-		st->note_page(st, addr, 2, p4d_val(val));
+		st->note_page(st, addr, 1, p4d_val(val));
 
 	return 0;
 }
@@ -35,7 +35,7 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
 	pud_t val = READ_ONCE(*pud);
 
 	if (pud_leaf(val))
-		st->note_page(st, addr, 3, pud_val(val));
+		st->note_page(st, addr, 2, pud_val(val));
 
 	return 0;
 }
@@ -47,7 +47,7 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long addr,
 	pmd_t val = READ_ONCE(*pmd);
 
 	if (pmd_leaf(val))
-		st->note_page(st, addr, 4, pmd_val(val));
+		st->note_page(st, addr, 3, pmd_val(val));
 
 	return 0;
 }
@@ -57,7 +57,7 @@ static int ptdump_pte_entry(pte_t *pte, unsigned long addr,
 {
 	struct ptdump_state *st = walk->private;
 
-	st->note_page(st, addr, 5, pte_val(READ_ONCE(*pte)));
+	st->note_page(st, addr, 4, pte_val(READ_ONCE(*pte)));
 
 	return 0;
 }
@@ -75,7 +75,7 @@ static inline int note_kasan_page_table(struct mm_walk *walk,
 {
 	struct ptdump_state *st = walk->private;
 
-	st->note_page(st, addr, 5, pte_val(kasan_early_shadow_pte[0]));
+	st->note_page(st, addr, 4, pte_val(kasan_early_shadow_pte[0]));
 	return 1;
 }
 
@@ -115,7 +115,7 @@ static int ptdump_hole(unsigned long addr, unsigned long next,
 {
 	struct ptdump_state *st = walk->private;
 
-	st->note_page(st, addr, depth + 1, 0);
+	st->note_page(st, addr, depth, 0);
 
 	return 0;
 }
@@ -147,5 +147,5 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm)
 	up_read(&mm->mmap_sem);
 
 	/* Flush out the last page */
-	st->note_page(st, 0, 0, 0);
+	st->note_page(st, 0, -1, 0);
 }
-- 
2.20.1

