Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4648ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8AC21925
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408898AbfJXJiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:38:25 -0400
Received: from foss.arm.com ([217.140.110.172]:44670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408936AbfJXJiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:38:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF28F7B9;
        Thu, 24 Oct 2019 02:38:06 -0700 (PDT)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 658623F71F;
        Thu, 24 Oct 2019 02:38:04 -0700 (PDT)
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
Subject: [PATCH v13 13/22] mm: pagewalk: Add test_p?d callbacks
Date:   Thu, 24 Oct 2019 10:37:07 +0100
Message-Id: <20191024093716.49420-14-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024093716.49420-1-steven.price@arm.com>
References: <20191024093716.49420-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is useful to be able to skip parts of the page table tree even when
walking without VMAs. Add test_p?d callbacks similar to test_walk but
which are called just before a table at that level is walked. If the
callback returns non-zero then the entire table is skipped.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 include/linux/pagewalk.h | 11 +++++++++++
 mm/pagewalk.c            | 24 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 12004b097eae..df424197a25a 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -24,6 +24,11 @@ struct mm_walk;
  *			"do page table walk over the current vma", returning
  *			a negative value means "abort current page table walk
  *			right now" and returning 1 means "skip the current vma"
+ * @test_pmd:		similar to test_walk(), but called for every pmd.
+ * @test_pud:		similar to test_walk(), but called for every pud.
+ * @test_p4d:		similar to test_walk(), but called for every p4d.
+ *			Returning 0 means walk this part of the page tables,
+ *			returning 1 means to skip this range.
  *
  * p?d_entry callbacks are called even if those levels are folded on a
  * particular architecture/configuration.
@@ -46,6 +51,12 @@ struct mm_walk_ops {
 			     struct mm_walk *walk);
 	int (*test_walk)(unsigned long addr, unsigned long next,
 			struct mm_walk *walk);
+	int (*test_pmd)(unsigned long addr, unsigned long next,
+			pmd_t *pmd_start, struct mm_walk *walk);
+	int (*test_pud)(unsigned long addr, unsigned long next,
+			pud_t *pud_start, struct mm_walk *walk);
+	int (*test_p4d)(unsigned long addr, unsigned long next,
+			p4d_t *p4d_start, struct mm_walk *walk);
 };
 
 /**
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 4139e9163aee..43acffefd43f 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -34,6 +34,14 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
 
+	if (ops->test_pmd) {
+		err = ops->test_pmd(addr, end, pmd_offset(pud, 0UL), walk);
+		if (err < 0)
+			return err;
+		if (err > 0)
+			return 0;
+	}
+
 	pmd = pmd_offset(pud, addr);
 	do {
 again:
@@ -85,6 +93,14 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
 
+	if (ops->test_pud) {
+		err = ops->test_pud(addr, end, pud_offset(p4d, 0UL), walk);
+		if (err < 0)
+			return err;
+		if (err > 0)
+			return 0;
+	}
+
 	pud = pud_offset(p4d, addr);
 	do {
  again:
@@ -128,6 +144,14 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
 
+	if (ops->test_p4d) {
+		err = ops->test_p4d(addr, end, p4d_offset(pgd, 0UL), walk);
+		if (err < 0)
+			return err;
+		if (err > 0)
+			return 0;
+	}
+
 	p4d = p4d_offset(pgd, addr);
 	do {
 		next = p4d_addr_end(addr, end);
-- 
2.20.1

