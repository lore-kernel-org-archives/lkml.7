Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C74C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A35820830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AVh2m9Un"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389824AbfIMVOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 17:14:09 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:38299 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389788AbfIMVOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 17:14:09 -0400
Received: by mail-qt1-f202.google.com with SMTP id l22so33046222qtq.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 14:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=56KrmM3jsP1ylNPMao+1Ncr53Vf5WUg4lsorzdUmeHY=;
        b=AVh2m9UnB5SFFUZYvRUnT+rndmul1kP3D0u534bk7IzfJehZ1F2HqDbSbGW4rWbcJX
         XTKfmAIe7kFlaTrh1vEDlK8NC3loT1nuIEF0kT48Q9qHox2nxjyluKgDXfU9eqg0aWhb
         76FmautjQMEoo1otyWIRGPikXRfson/9eRuUJCuLUsnwJfHIVc/KVvC1a86kHNpDt6xQ
         4+H32Mq19LfvFBpNYl05WDOBicgjdwkb2KE3K4e8p//q83r6p+TGwobF8w6R6RjPojZx
         fQpXAsA7F5omjlpXDSjSfih8GwXd5H08/y9HqN7+oY7X6RIcZ8WhuKRJrcf36JOvvDpe
         eXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=56KrmM3jsP1ylNPMao+1Ncr53Vf5WUg4lsorzdUmeHY=;
        b=aVNKae/sIPZYLFcekCtZfeEhass+cOT0du5oE4wXlX7Ge1i7yCqpa28yBsPdljlphP
         ESYhmL5kV2qIsq3ZMNJohU2On7eJ7CGcWBuF17W7Z3+EM9jODVgOVtGdYNksIU1+BsGZ
         NNgGCMelxwWVZRurXWzLNr5cz74eAAucHpCY9xxa+D1/KUxA1Nm0gRw7id8qCb00WeA/
         kPEeHu+1tCDQJcsCUS3KqavsLEIxxOCC8MSubGT4aX5nawmHJRqlABgFDFOqbFrW0McV
         5MUjFsvayguQChbi7q6Wprs4tKTaCix6u+8WimNYAv8DhAvQdJsqKt2DrURCuIwUfwQB
         JrWA==
X-Gm-Message-State: APjAAAVasBA/l7fGfMOO7sdVN9ek72cRemr1d/OtsTYGwsWI7g/G0FlQ
        JpvB4Ns4bRNKWWr+N+z6vXu06RvLo+Dp8YxXZJc=
X-Google-Smtp-Source: APXvYqyEV8g3R0AzxZTla6YC1n84umf2i5Xvy7/Y6kpLBb4mARgKEaTEVEsk13RYK3gVoo9S4oUr3OWAdtddOjmXWuc=
X-Received: by 2002:a0c:d60d:: with SMTP id c13mr8823948qvj.53.1568409246536;
 Fri, 13 Sep 2019 14:14:06 -0700 (PDT)
Date:   Fri, 13 Sep 2019 14:14:02 -0700
Message-Id: <20190913211402.193018-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [PATCH] x86: use the correct function type for native_set_fixmap
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We call native_set_fixmap indirectly through the function pointer
struct pv_mmu_ops::set_fixmap, which expects the first parameter to be
'unsigned' instead of 'enum fixed_addresses'. This patch changes the
function type for native_set_fixmap to match the pointer, which fixes
indirect call mismatches with Control-Flow Integrity (CFI) checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/include/asm/fixmap.h | 2 +-
 arch/x86/mm/pgtable.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index 9da8cccdf3fb..6a295acd3de6 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -157,7 +157,7 @@ extern pte_t *kmap_pte;
 extern pte_t *pkmap_page_table;
 
 void __native_set_fixmap(enum fixed_addresses idx, pte_t pte);
-void native_set_fixmap(enum fixed_addresses idx,
+void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
 		       phys_addr_t phys, pgprot_t flags);
 
 #ifndef CONFIG_PARAVIRT_XXL
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 44816ff6411f..d0ad35e3de74 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -647,8 +647,8 @@ void __native_set_fixmap(enum fixed_addresses idx, pte_t pte)
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
2.23.0.237.gc6a4ce50a0-goog

