Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECAAC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E779720663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfCFWd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:33:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50929 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfCFWd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:33:57 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x26MXnMq1911751
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 6 Mar 2019 14:33:49 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x26MXnpm1911748;
        Wed, 6 Mar 2019 14:33:49 -0800
Date:   Wed, 6 Mar 2019 14:33:49 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qian Cai <tipbot@zytor.com>
Message-ID: <tip-24c41220659ecc5576c34c6f23537f8d3949fb05@git.kernel.org>
Cc:     cai@lca.pw, hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, cai@lca.pw, linux-kernel@vger.kernel.org,
          mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20190301152924.94762-1-cai@lca.pw>
References: <20190301152924.94762-1-cai@lca.pw>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Remove unused variable 'old_pte'
Git-Commit-ID: 24c41220659ecc5576c34c6f23537f8d3949fb05
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  24c41220659ecc5576c34c6f23537f8d3949fb05
Gitweb:     https://git.kernel.org/tip/24c41220659ecc5576c34c6f23537f8d3949fb05
Author:     Qian Cai <cai@lca.pw>
AuthorDate: Fri, 1 Mar 2019 10:29:24 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Mar 2019 23:24:53 +0100

x86/mm: Remove unused variable 'old_pte'

The commit 3a19109efbfa ("x86/mm: Fix try_preserve_large_page() to
handle large PAT bit") fixed try_preserve_large_page() by using the
corresponding pud/pmd prot/pfn interfaces, but left a variable unused
because it no longer used pte_pfn().

Later, the commit 8679de0959e6 ("x86/mm/cpa: Split, rename and clean up
try_preserve_large_page()") renamed try_preserve_large_page() to
__should_split_large_page(), but the unused variable remains.

arch/x86/mm/pageattr.c: In function '__should_split_large_page':
arch/x86/mm/pageattr.c:741:17: warning: variable 'old_pte' set but not
used [-Wunused-but-set-variable]

Fixes: 3a19109efbfa ("x86/mm: Fix try_preserve_large_page() to handle large PAT bit")
Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: dave.hansen@linux.intel.com
Cc: luto@kernel.org
Cc: peterz@infradead.org
Cc: toshi.kani@hpe.com
Cc: bp@alien8.de
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20190301152924.94762-1-cai@lca.pw

---
 arch/x86/mm/pageattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 14e6119838a6..4c570612e24e 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -738,7 +738,7 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 {
 	unsigned long numpages, pmask, psize, lpaddr, pfn, old_pfn;
 	pgprot_t old_prot, new_prot, req_prot, chk_prot;
-	pte_t new_pte, old_pte, *tmp;
+	pte_t new_pte, *tmp;
 	enum pg_level level;
 
 	/*
@@ -781,7 +781,7 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	 * Convert protection attributes to 4k-format, as cpa->mask* are set
 	 * up accordingly.
 	 */
-	old_pte = *kpte;
+
 	/* Clear PSE (aka _PAGE_PAT) and move PAT bit to correct position */
 	req_prot = pgprot_large_2_4k(old_prot);
 
