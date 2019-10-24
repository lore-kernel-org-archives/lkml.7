Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3181CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865D520684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408981AbfJXJia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:38:30 -0400
Received: from foss.arm.com ([217.140.110.172]:44730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408933AbfJXJi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:38:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4A0D95E;
        Thu, 24 Oct 2019 02:38:12 -0700 (PDT)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A2E03F71F;
        Thu, 24 Oct 2019 02:38:09 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     linux-mm@kvack.org
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
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v13 15/22] x86: mm: Point to struct seq_file from struct pg_state
Date:   Thu, 24 Oct 2019 10:37:09 +0100
Message-Id: <20191024093716.49420-16-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024093716.49420-1-steven.price@arm.com>
References: <20191024093716.49420-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm/dump_pagetables.c passes both struct seq_file and struct pg_state
down the chain of walk_*_level() functions to be passed to note_page().
Instead place the struct seq_file in struct pg_state and access it from
struct pg_state (which is private to this file) in note_page().

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/x86/mm/dump_pagetables.c | 69 ++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index ab67822fd2f4..4dc6f4df40af 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -36,6 +36,7 @@ struct pg_state {
 	bool to_dmesg;
 	bool check_wx;
 	unsigned long wx_pages;
+	struct seq_file *seq;
 };
 
 struct addr_marker {
@@ -265,11 +266,12 @@ static void note_wx(struct pg_state *st)
  * of PTE entries; the next one is different so we need to
  * print what we collected so far.
  */
-static void note_page(struct seq_file *m, struct pg_state *st,
-		      pgprot_t new_prot, pgprotval_t new_eff, int level)
+static void note_page(struct pg_state *st, pgprot_t new_prot,
+		      pgprotval_t new_eff, int level)
 {
 	pgprotval_t prot, cur, eff;
 	static const char units[] = "BKMGTPE";
+	struct seq_file *m = st->seq;
 
 	/*
 	 * If we have a "break" in the series, we need to flush the state that
@@ -354,8 +356,8 @@ static inline pgprotval_t effective_prot(pgprotval_t prot1, pgprotval_t prot2)
 	       ((prot1 | prot2) & _PAGE_NX);
 }
 
-static void walk_pte_level(struct seq_file *m, struct pg_state *st, pmd_t addr,
-			   pgprotval_t eff_in, unsigned long P)
+static void walk_pte_level(struct pg_state *st, pmd_t addr, pgprotval_t eff_in,
+			   unsigned long P)
 {
 	int i;
 	pte_t *pte;
@@ -366,7 +368,7 @@ static void walk_pte_level(struct seq_file *m, struct pg_state *st, pmd_t addr,
 		pte = pte_offset_map(&addr, st->current_address);
 		prot = pte_flags(*pte);
 		eff = effective_prot(eff_in, prot);
-		note_page(m, st, __pgprot(prot), eff, 5);
+		note_page(st, __pgprot(prot), eff, 5);
 		pte_unmap(pte);
 	}
 }
@@ -379,22 +381,20 @@ static void walk_pte_level(struct seq_file *m, struct pg_state *st, pmd_t addr,
  * us dozens of seconds (minutes for 5-level config) while checking for
  * W+X mapping or reading kernel_page_tables debugfs file.
  */
-static inline bool kasan_page_table(struct seq_file *m, struct pg_state *st,
-				void *pt)
+static inline bool kasan_page_table(struct pg_state *st, void *pt)
 {
 	if (__pa(pt) == __pa(kasan_early_shadow_pmd) ||
 	    (pgtable_l5_enabled() &&
 			__pa(pt) == __pa(kasan_early_shadow_p4d)) ||
 	    __pa(pt) == __pa(kasan_early_shadow_pud)) {
 		pgprotval_t prot = pte_flags(kasan_early_shadow_pte[0]);
-		note_page(m, st, __pgprot(prot), 0, 5);
+		note_page(st, __pgprot(prot), 0, 5);
 		return true;
 	}
 	return false;
 }
 #else
-static inline bool kasan_page_table(struct seq_file *m, struct pg_state *st,
-				void *pt)
+static inline bool kasan_page_table(struct pg_state *st, void *pt)
 {
 	return false;
 }
@@ -402,7 +402,7 @@ static inline bool kasan_page_table(struct seq_file *m, struct pg_state *st,
 
 #if PTRS_PER_PMD > 1
 
-static void walk_pmd_level(struct seq_file *m, struct pg_state *st, pud_t addr,
+static void walk_pmd_level(struct pg_state *st, pud_t addr,
 			   pgprotval_t eff_in, unsigned long P)
 {
 	int i;
@@ -416,27 +416,27 @@ static void walk_pmd_level(struct seq_file *m, struct pg_state *st, pud_t addr,
 			prot = pmd_flags(*start);
 			eff = effective_prot(eff_in, prot);
 			if (pmd_large(*start) || !pmd_present(*start)) {
-				note_page(m, st, __pgprot(prot), eff, 4);
-			} else if (!kasan_page_table(m, st, pmd_start)) {
-				walk_pte_level(m, st, *start, eff,
+				note_page(st, __pgprot(prot), eff, 4);
+			} else if (!kasan_page_table(st, pmd_start)) {
+				walk_pte_level(st, *start, eff,
 					       P + i * PMD_LEVEL_MULT);
 			}
 		} else
-			note_page(m, st, __pgprot(0), 0, 4);
+			note_page(st, __pgprot(0), 0, 4);
 		start++;
 	}
 }
 
 #else
-#define walk_pmd_level(m,s,a,e,p) walk_pte_level(m,s,__pmd(pud_val(a)),e,p)
+#define walk_pmd_level(s,a,e,p) walk_pte_level(s,__pmd(pud_val(a)),e,p)
 #define pud_large(a) pmd_large(__pmd(pud_val(a)))
 #define pud_none(a)  pmd_none(__pmd(pud_val(a)))
 #endif
 
 #if PTRS_PER_PUD > 1
 
-static void walk_pud_level(struct seq_file *m, struct pg_state *st, p4d_t addr,
-			   pgprotval_t eff_in, unsigned long P)
+static void walk_pud_level(struct pg_state *st, p4d_t addr, pgprotval_t eff_in,
+			   unsigned long P)
 {
 	int i;
 	pud_t *start, *pud_start;
@@ -450,33 +450,33 @@ static void walk_pud_level(struct seq_file *m, struct pg_state *st, p4d_t addr,
 			prot = pud_flags(*start);
 			eff = effective_prot(eff_in, prot);
 			if (pud_large(*start) || !pud_present(*start)) {
-				note_page(m, st, __pgprot(prot), eff, 3);
-			} else if (!kasan_page_table(m, st, pud_start)) {
-				walk_pmd_level(m, st, *start, eff,
+				note_page(st, __pgprot(prot), eff, 3);
+			} else if (!kasan_page_table(st, pud_start)) {
+				walk_pmd_level(st, *start, eff,
 					       P + i * PUD_LEVEL_MULT);
 			}
 		} else
-			note_page(m, st, __pgprot(0), 0, 3);
+			note_page(st, __pgprot(0), 0, 3);
 
 		start++;
 	}
 }
 
 #else
-#define walk_pud_level(m,s,a,e,p) walk_pmd_level(m,s,__pud(p4d_val(a)),e,p)
+#define walk_pud_level(s,a,e,p) walk_pmd_level(s,__pud(p4d_val(a)),e,p)
 #define p4d_large(a) pud_large(__pud(p4d_val(a)))
 #define p4d_none(a)  pud_none(__pud(p4d_val(a)))
 #endif
 
-static void walk_p4d_level(struct seq_file *m, struct pg_state *st, pgd_t addr,
-			   pgprotval_t eff_in, unsigned long P)
+static void walk_p4d_level(struct pg_state *st, pgd_t addr, pgprotval_t eff_in,
+			   unsigned long P)
 {
 	int i;
 	p4d_t *start, *p4d_start;
 	pgprotval_t prot, eff;
 
 	if (PTRS_PER_P4D == 1)
-		return walk_pud_level(m, st, __p4d(pgd_val(addr)), eff_in, P);
+		return walk_pud_level(st, __p4d(pgd_val(addr)), eff_in, P);
 
 	p4d_start = start = (p4d_t *)pgd_page_vaddr(addr);
 
@@ -486,13 +486,13 @@ static void walk_p4d_level(struct seq_file *m, struct pg_state *st, pgd_t addr,
 			prot = p4d_flags(*start);
 			eff = effective_prot(eff_in, prot);
 			if (p4d_large(*start) || !p4d_present(*start)) {
-				note_page(m, st, __pgprot(prot), eff, 2);
-			} else if (!kasan_page_table(m, st, p4d_start)) {
-				walk_pud_level(m, st, *start, eff,
+				note_page(st, __pgprot(prot), eff, 2);
+			} else if (!kasan_page_table(st, p4d_start)) {
+				walk_pud_level(st, *start, eff,
 					       P + i * P4D_LEVEL_MULT);
 			}
 		} else
-			note_page(m, st, __pgprot(0), 0, 2);
+			note_page(st, __pgprot(0), 0, 2);
 
 		start++;
 	}
@@ -529,6 +529,7 @@ static void ptdump_walk_pgd_level_core(struct seq_file *m, pgd_t *pgd,
 	}
 
 	st.check_wx = checkwx;
+	st.seq = m;
 	if (checkwx)
 		st.wx_pages = 0;
 
@@ -542,13 +543,13 @@ static void ptdump_walk_pgd_level_core(struct seq_file *m, pgd_t *pgd,
 			eff = prot;
 #endif
 			if (pgd_large(*start) || !pgd_present(*start)) {
-				note_page(m, &st, __pgprot(prot), eff, 1);
+				note_page(&st, __pgprot(prot), eff, 1);
 			} else {
-				walk_p4d_level(m, &st, *start, eff,
+				walk_p4d_level(&st, *start, eff,
 					       i * PGD_LEVEL_MULT);
 			}
 		} else
-			note_page(m, &st, __pgprot(0), 0, 1);
+			note_page(&st, __pgprot(0), 0, 1);
 
 		cond_resched();
 		start++;
@@ -556,7 +557,7 @@ static void ptdump_walk_pgd_level_core(struct seq_file *m, pgd_t *pgd,
 
 	/* Flush out the last page */
 	st.current_address = normalize_addr(PTRS_PER_PGD*PGD_LEVEL_MULT);
-	note_page(m, &st, __pgprot(0), 0, 0);
+	note_page(&st, __pgprot(0), 0, 0);
 	if (!checkwx)
 		return;
 	if (st.wx_pages)
-- 
2.20.1

