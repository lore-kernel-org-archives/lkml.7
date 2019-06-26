Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C013C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF2C2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="V+JVQhA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfFZF2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 01:28:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48935 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfFZF2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 01:28:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5Q5SHJx3963940
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 22:28:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5Q5SHJx3963940
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561526898;
        bh=p0bSEYHh9QvmFUWXJlBfp5ge8/2RGlPNQCmXR7RF7JI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=V+JVQhA4rMXNqsiXzivOABQIhRBRTZAEuoGB/bcPXN+1uE6CiGB8xvoeuRFAGKwuV
         6GCklE26aWNXD1Y84XfXVHYrJTSl6F35RHEqq8h9u7UeSh6U1W3v0+vPifnvK7v3Ep
         G6WPmb8kSdYwFyv2D5JU/uAeTVu1wM97e9WauOAbggegZtQeP2JFEDtyG2LBAoRR0a
         U2urQk9sz+e2ezksFoowTfxyCcuBqGBnKr7ZlA737SVfgftzArggwxmVXrI69NuWFI
         fgxK22WOc5uOmX3sYskADof/CAy+ToAwCbhsxUb1E0C0n49Uws9KJ/D6bA+fq/SBDt
         WpXwEWb3qZHSQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5Q5SGWZ3963937;
        Tue, 25 Jun 2019 22:28:16 -0700
Date:   Tue, 25 Jun 2019 22:28:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-81c7ed296dcd02bc0b4488246d040e03e633737a@git.kernel.org>
Cc:     kirill@shutemov.name, bp@alien8.de, luto@kernel.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, dave.hansen@linux.intel.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hpa@zytor.com
Reply-To: bp@alien8.de, luto@kernel.org, mingo@kernel.org,
          kirill@shutemov.name, hpa@zytor.com,
          kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, peterz@infradead.org,
          dave.hansen@linux.intel.com
In-Reply-To: <20190620112345.28833-1-kirill.shutemov@linux.intel.com>
References: <20190620112345.28833-1-kirill.shutemov@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot/64: Fix crash if kernel image crosses
 page table boundary
Git-Commit-ID: 81c7ed296dcd02bc0b4488246d040e03e633737a
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

Commit-ID:  81c7ed296dcd02bc0b4488246d040e03e633737a
Gitweb:     https://git.kernel.org/tip/81c7ed296dcd02bc0b4488246d040e03e633737a
Author:     Kirill A. Shutemov <kirill@shutemov.name>
AuthorDate: Thu, 20 Jun 2019 14:23:45 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 07:25:09 +0200

x86/boot/64: Fix crash if kernel image crosses page table boundary

A kernel which boots in 5-level paging mode crashes in a small percentage
of cases if KASLR is enabled.

This issue was tracked down to the case when the kernel image unpacks in a
way that it crosses an 1G boundary. The crash is caused by an overrun of
the PMD page table in __startup_64() and corruption of P4D page table
allocated next to it. This particular issue is not visible with 4-level
paging as P4D page tables are not used.

But the P4D and the PUD calculation have similar problems.

The PMD index calculation is wrong due to operator precedence, which fails
to confine the PMDs in the PMD array on wrap around.

The P4D calculation for 5-level paging and the PUD calculation calculate
the first index correctly, but then blindly increment it which causes the
same issue when a kernel image is located across a 512G and for 5-level
paging across a 46T boundary.

This wrap around mishandling was introduced when these parts moved from
assembly to C.

Restore it to the correct behaviour.

Fixes: c88d71508e36 ("x86/boot/64: Rewrite startup_64() in C")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190620112345.28833-1-kirill.shutemov@linux.intel.com

---
 arch/x86/kernel/head64.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 16b1cbd3a61e..7df5bce4e1be 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -190,18 +190,18 @@ unsigned long __head __startup_64(unsigned long physaddr,
 		pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;
 		pgd[i + 1] = (pgdval_t)p4d + pgtable_flags;
 
-		i = (physaddr >> P4D_SHIFT) % PTRS_PER_P4D;
-		p4d[i + 0] = (pgdval_t)pud + pgtable_flags;
-		p4d[i + 1] = (pgdval_t)pud + pgtable_flags;
+		i = physaddr >> P4D_SHIFT;
+		p4d[(i + 0) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
+		p4d[(i + 1) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
 	} else {
 		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
 		pgd[i + 0] = (pgdval_t)pud + pgtable_flags;
 		pgd[i + 1] = (pgdval_t)pud + pgtable_flags;
 	}
 
-	i = (physaddr >> PUD_SHIFT) % PTRS_PER_PUD;
-	pud[i + 0] = (pudval_t)pmd + pgtable_flags;
-	pud[i + 1] = (pudval_t)pmd + pgtable_flags;
+	i = physaddr >> PUD_SHIFT;
+	pud[(i + 0) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
+	pud[(i + 1) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
 
 	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
 	/* Filter out unsupported __PAGE_KERNEL_* bits: */
@@ -211,8 +211,9 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	pmd_entry +=  physaddr;
 
 	for (i = 0; i < DIV_ROUND_UP(_end - _text, PMD_SIZE); i++) {
-		int idx = i + (physaddr >> PMD_SHIFT) % PTRS_PER_PMD;
-		pmd[idx] = pmd_entry + i * PMD_SIZE;
+		int idx = i + (physaddr >> PMD_SHIFT);
+
+		pmd[idx % PTRS_PER_PMD] = pmd_entry + i * PMD_SIZE;
 	}
 
 	/*
