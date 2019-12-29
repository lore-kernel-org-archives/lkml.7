Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D8CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2AF222C3
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641636;
	bh=MkNcUybdADWvdamOB6zS++HxLBROXBRnhT7JYiimUjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GhP2MyJ11PKik8se82Ia/QZRUGEvFJmY80uoSPWv2g5QiKLvdx7+ecu5zHfjCdw4J
	 /8KBi2KtI33og0g7Qh6owKr5FaOmXphNuQNV/F2xeIB9IQOXI/3vd4fVAzpdVqZOk8
	 XaF9I8elqu/IjqC3j4LR+DFsRlUjjubPABuVkWvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbfL2RrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:47:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731191AbfL2RrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:47:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1A9D206DB;
        Sun, 29 Dec 2019 17:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641624;
        bh=MkNcUybdADWvdamOB6zS++HxLBROXBRnhT7JYiimUjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IkxS4Fcd/unKN2KQ6RvGuO6jownTuVbkwc7omb6TVWMCTO8t//2tdHKiA4nSUDyHu
         ZQRzpd/2JQcFndsmBUpOhKTx1XtCXCspxvEgLMPY8cVKobyGMvtPO07wPnCt1ZDF6x
         W8TTrO9BTYP5CRjJmghyAG1tM4SA7sHMOef18vbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 141/434] x86/mm: Use the correct function type for native_set_fixmap()
Date:   Sun, 29 Dec 2019 18:23:14 +0100
Message-Id: <20191229172711.098355004@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sami Tolvanen <samitolvanen@google.com>

[ Upstream commit f53e2cd0b8ab7d9e390414470bdbd830f660133f ]

We call native_set_fixmap indirectly through the function pointer
struct pv_mmu_ops::set_fixmap, which expects the first parameter to be
'unsigned' instead of 'enum fixed_addresses'. This patch changes the
function type for native_set_fixmap to match the pointer, which fixes
indirect call mismatches with Control-Flow Integrity (CFI) checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190913211402.193018-1-samitolvanen@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/fixmap.h | 2 +-
 arch/x86/mm/pgtable.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index 0c47aa82e2e2..28183ee3cc42 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -156,7 +156,7 @@ extern pte_t *kmap_pte;
 extern pte_t *pkmap_page_table;
 
 void __native_set_fixmap(enum fixed_addresses idx, pte_t pte);
-void native_set_fixmap(enum fixed_addresses idx,
+void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
 		       phys_addr_t phys, pgprot_t flags);
 
 #ifndef CONFIG_PARAVIRT_XXL
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 3e4b9035bb9a..7bd2c3a52297 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -643,8 +643,8 @@ void __native_set_fixmap(enum fixed_addresses idx, pte_t pte)
 	fixmaps_set++;
 }
 
-void native_set_fixmap(enum fixed_addresses idx, phys_addr_t phys,
-		       pgprot_t flags)
+void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
+		       phys_addr_t phys, pgprot_t flags)
 {
 	/* Sanitize 'prot' against any unsupported bits: */
 	pgprot_val(flags) &= __default_kernel_pte_mask;
-- 
2.20.1



