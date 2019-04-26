Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B64FC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF68208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q470hKxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfD0Gnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:43:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44684 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfD0Gnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:43:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id y12so2555205plk.11;
        Fri, 26 Apr 2019 23:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=03x8MyH4ONo6RL8TDAuJcYQYBUTk8Xfu5EMEl5vv8zs=;
        b=Q470hKxCA0zkhL+IQMRmPe5UQg42Gi+l2RRmW947taZyL//Jesf10pqg7iknajn5cM
         6MahwRUBormFC9ROtXZzOCBPO1osFE8XuHCncIgLvsCHxLcNuXntyLIPTNUxNKWwnbuS
         YivKpxFXT45f055xbj7gqKyZeZCL6izznlo4y+QcynGiNpgPJSJn6cIDoQUEWR8q3NIV
         QQ28y5mhdxTCv3ZGyzW3vgvH+5eRIAil3M9uo1sFkym+2/eXjUEbYhGGuoRIn6PGQ204
         szqozT+L1TEHgWXr+gjrabBNVx0fQWsxwFBogU0RCWe7qqaev2wbboj0cmVtOcpDQP9M
         I7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=03x8MyH4ONo6RL8TDAuJcYQYBUTk8Xfu5EMEl5vv8zs=;
        b=kFXVFkmMXdfC7/oyY9p08Z7JSxqpYcZyQXqA7qOk+GmXBUx4XCdSEEQfabP3VDscEw
         XYUiOpAJ9qgVsjuTMWBMF9dWTB3eR2EPG0o5HsYFGm2RuWy18KBoMpjPk/W6Q55gDUEZ
         /yXEcJpM1vWwfKgdtB0VcVDqwtCCJKkhKdSWsIEBoMb21Gx1RbanstNE+Lq4Ff1GTgn1
         4LSgoBV2TwgzPwS/07KkaCpObWFVjW+EqHTaz3DpZlmpShydFKvbr0khcvp6TPbF6AI7
         F1lk3ftEh3U0kyTyhKvLVIqEJs0rGzAN3HiqvR+LaXxZZatwK0M+uM31woJamc7Asa0J
         n58w==
X-Gm-Message-State: APjAAAVYmRZkXlb/YFXP4ss3DSpub5Jw2FTlBbGOVhXXbBvN1/5Y3gGr
        8ToK/3zPdRmEHoKNHgIv8mY=
X-Google-Smtp-Source: APXvYqwS9mBb6vrC0DhVyMmyRT5ZRdKwezrJErmAVG/FEmt+6AsmQkMSAz9lRez80K2MggQYstDNlg==
X-Received: by 2002:a17:902:bd0c:: with SMTP id p12mr17355851pls.50.1556347411683;
        Fri, 26 Apr 2019 23:43:31 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j22sm36460145pfn.129.2019.04.26.23.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 23:43:31 -0700 (PDT)
From:   nadav.amit@gmail.com
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v6 19/24] bpf: Use vmalloc special flag
Date:   Fri, 26 Apr 2019 16:22:58 -0700
Message-Id: <20190426232303.28381-20-nadav.amit@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426232303.28381-1-nadav.amit@gmail.com>
References: <20190426232303.28381-1-nadav.amit@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

Use new flag VM_FLUSH_RESET_PERMS for handling freeing of special
permissioned memory in vmalloc and remove places where memory was set RW
before freeing which is no longer needed. Don't track if the memory is RO
anymore because it is now tracked in vmalloc.

Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 include/linux/filter.h | 17 +++--------------
 kernel/bpf/core.c      |  1 -
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 14ec3bdad9a9..7d3abde3f183 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -20,6 +20,7 @@
 #include <linux/set_memory.h>
 #include <linux/kallsyms.h>
 #include <linux/if_vlan.h>
+#include <linux/vmalloc.h>
 
 #include <net/sch_generic.h>
 
@@ -503,7 +504,6 @@ struct bpf_prog {
 	u16			pages;		/* Number of allocated pages */
 	u16			jited:1,	/* Is our filter JIT'ed? */
 				jit_requested:1,/* archs need to JIT the prog */
-				undo_set_mem:1,	/* Passed set_memory_ro() checkpoint */
 				gpl_compatible:1, /* Is filter GPL compatible? */
 				cb_access:1,	/* Is control block accessed? */
 				dst_needed:1,	/* Do we need dst entry? */
@@ -733,27 +733,17 @@ bpf_ctx_narrow_access_ok(u32 off, u32 size, u32 size_default)
 
 static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
 {
-	fp->undo_set_mem = 1;
+	set_vm_flush_reset_perms(fp);
 	set_memory_ro((unsigned long)fp, fp->pages);
 }
 
-static inline void bpf_prog_unlock_ro(struct bpf_prog *fp)
-{
-	if (fp->undo_set_mem)
-		set_memory_rw((unsigned long)fp, fp->pages);
-}
-
 static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
 {
+	set_vm_flush_reset_perms(hdr);
 	set_memory_ro((unsigned long)hdr, hdr->pages);
 	set_memory_x((unsigned long)hdr, hdr->pages);
 }
 
-static inline void bpf_jit_binary_unlock_ro(struct bpf_binary_header *hdr)
-{
-	set_memory_rw((unsigned long)hdr, hdr->pages);
-}
-
 static inline struct bpf_binary_header *
 bpf_jit_binary_hdr(const struct bpf_prog *fp)
 {
@@ -789,7 +779,6 @@ void __bpf_prog_free(struct bpf_prog *fp);
 
 static inline void bpf_prog_unlock_free(struct bpf_prog *fp)
 {
-	bpf_prog_unlock_ro(fp);
 	__bpf_prog_free(fp);
 }
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ff09d32a8a1b..c605397c79f0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -848,7 +848,6 @@ void __weak bpf_jit_free(struct bpf_prog *fp)
 	if (fp->jited) {
 		struct bpf_binary_header *hdr = bpf_jit_binary_hdr(fp);
 
-		bpf_jit_binary_unlock_ro(hdr);
 		bpf_jit_binary_free(hdr);
 
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
-- 
2.17.1

