Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8375C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E0D2053B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHzIGGfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfGCBID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:08:03 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:38630 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfGCBIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:08:02 -0400
Received: by mail-oi1-f202.google.com with SMTP id u8so363384oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 18:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kOX/b18nZuUFLUmGmTpl546hS1EqehWOvqAy79HryjA=;
        b=PHzIGGfXetYTXGzyTnFKvYWj/S64EJ84TRcojkaEZ3zefgwEC4LsicdhwrkL2ldmKB
         gLAW7FqH4fV0fpD5nRCgP2WElmI4pBZ/bAxq8fzbpmZBPLR1WKxd5oKCsf/crj/4jdmt
         naAfJALZxW8RSMccuFYHpwcKTyChfjibhUexOeeOVyiukx4Qzs0d00o8Po9sq0lQhsZc
         bm/KmFcPSVoxiXPQBDZhlN7bv5zwQM8qNbDTCdGKs3xItoELX3CvzNDL5wVT124uTSa/
         lgeB7jg/Jrdoqhn89hRdD8AY7lVg4ofRKcOwK/vqZ25QdXZj1E42OnQVfw8QJyKJo1bo
         Nv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kOX/b18nZuUFLUmGmTpl546hS1EqehWOvqAy79HryjA=;
        b=Xim+ij1htI45lPV5I9O53/E8RM0QKBS4xaUmsjaieUzQ3fsUbGIDGdQtMriVUaNY3g
         xMiUJEtemSjtgMnLjQG8Z9r+OQFSTo9JAu9hhP+VubtVKafYFfuRtNhSopY247+gNNve
         tNZ34a1OGFYI5D9H1YokaCxahZK/Kj/LhCpjkqBgChZUUaP0dqfgWdWt3lzqEmL63ro1
         oN+26uTuGrc2U/rSPTNVbuO3LeLnY1502dQVivY2hOybYvMC0Z2I4y0fChl4iLd2UUMk
         7PSJWnQ4I3sTElD5fNpx/eW58zmC2JHQK12AwRGmCEiTV4mW2ahoqh0BtfLRcaGO1OZA
         tsCg==
X-Gm-Message-State: APjAAAVgHy9JHVpSBYYmdXdATgqfSNlE5PU6P+jEA6Z/0Ks1bgFPOHqS
        vDZhh22QsDqavn6gb/VbEx3K7AjTAg==
X-Google-Smtp-Source: APXvYqy7Ahm6xsIBAxbvahe7MpZfFhmQrJUfui7MRkmuGNA2r+KtX7OKAP2SMxHgy3LSHG1zLsGv5aFPcA==
X-Received: by 2002:a63:bd0a:: with SMTP id a10mr18703895pgf.55.1562109188555;
 Tue, 02 Jul 2019 16:13:08 -0700 (PDT)
Date:   Tue,  2 Jul 2019 16:13:02 -0700
Message-Id: <20190702231302.60727-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] arm64: mm: Fix dead assignment of old_pte
From:   Nathan Huckleberry <nhuck@google.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When analyzed with the clang static analyzer the
following warning occurs

line 251, column 2
Value stored to 'old_pte' is never read

This warning is repeated every time pgtable.h is
included by another file and produces ~3500
extra warnings.

Moving old_pte into preprocessor guard.

Cc: clang-built-linux@googlegroups.com
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 arch/arm64/include/asm/pgtable.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index fca26759081a..42ca4fc67f27 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -238,8 +238,6 @@ extern void __sync_icache_dcache(pte_t pteval);
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
-	pte_t old_pte;
-
 	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
 		__sync_icache_dcache(pte);
 
@@ -248,8 +246,11 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	 * hardware updates of the pte (ptep_set_access_flags safely changes
 	 * valid ptes without going through an invalid entry).
 	 */
+	#if IS_ENABLED(CONFIG_DEBUG_VM)
+	pte_t old_pte;
+
 	old_pte = READ_ONCE(*ptep);
-	if (IS_ENABLED(CONFIG_DEBUG_VM) && pte_valid(old_pte) && pte_valid(pte) &&
+	if (pte_valid(old_pte) && pte_valid(pte) &&
 	   (mm == current->active_mm || atomic_read(&mm->mm_users) > 1)) {
 		VM_WARN_ONCE(!pte_young(pte),
 			     "%s: racy access flag clearing: 0x%016llx -> 0x%016llx",
@@ -258,6 +259,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			     "%s: racy dirty state clearing: 0x%016llx -> 0x%016llx",
 			     __func__, pte_val(old_pte), pte_val(pte));
 	}
+	#endif
 
 	set_pte(ptep, pte);
 }
-- 
2.22.0.410.gd8fdbe21b5-goog

