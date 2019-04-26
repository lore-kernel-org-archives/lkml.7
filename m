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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32769C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03038208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K41kvx1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfD0Gnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:43:39 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36876 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfD0Gnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:43:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id z8so2581418pln.4;
        Fri, 26 Apr 2019 23:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PMP2Cxb893S0prGS0vCi085zHCDPTtmjtSNHdboWACs=;
        b=K41kvx1t6SFhhfzncmYY1HeK2Igm+/jVQYVM/IJLmHXShsg5nGe8rTKsYo4rZoZPC/
         6zju36lQj+i8uBKtds/aE0HT690JXiZHzsJ4iG2ZVbGtv1+m8Rexp2qGC4WzKGij4mJY
         pS0wLymSfhipDrS8/jIS0cMHQRk/GDuPBjL2K/M1OnR2vxv4YrIebnQ2xexSNHS3XdIV
         svsj4+MI3xf9ZC2zePDJQy6e/n2bUI0eeL3ftgtEvNDNqK6/0DUPSoZt2Ss6m6/VX3rn
         2cMMuSy1cr6XBfOuPS4wxZ/91yZ1FLcgw2kClZNZEQvPCdnBiT4UNc5YyXetyq58UhjO
         W5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PMP2Cxb893S0prGS0vCi085zHCDPTtmjtSNHdboWACs=;
        b=j20FDOW5Ahy3U0xDGbq1l5ASXgb260iaFJYHPbvV7r8WZWs8fx5LYP1eT/5afxfvWs
         gK40HIGKiTec7Ndpel1y9TsJ+vTdOFrLoDlTwibbZoG0BxEkikoTLGcz/eCinVjYJwKY
         roc0uecXOFtHdxFwWgoNh8q93kqZCMhn71C7MlVfExpiqkfU9MmGHLj/LJNyoC6Tzgrq
         4zKtvZzjKze9Xmvv5pPJLSQ8J8Xt1qz1+uGb0Y81RJPHATeII66x4Aa1fvnAd3KUt+tB
         1Q7pjnl4Gg26YKa+IxWYkmxdwf6R9VWZ0rpCOBGudJiGGu8lYECdkBS4LQfNhyB+pzKb
         7mXw==
X-Gm-Message-State: APjAAAWynlB0FkttH7kkZXm9A0SWByNweiXJBqeBDsyEx+JozViZafef
        Y7gF5v+eQLA9uJzDjZT86oo=
X-Google-Smtp-Source: APXvYqzt81NaHzE4N6lgOn1CEEv66yygls114EGZnoMMrIlsI1R4+4jwMYRUYyyw4vMJxMCD0c6n8g==
X-Received: by 2002:a17:902:f094:: with SMTP id go20mr50490988plb.159.1556347414288;
        Fri, 26 Apr 2019 23:43:34 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j22sm36460145pfn.129.2019.04.26.23.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 23:43:33 -0700 (PDT)
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
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v6 21/24] x86/kprobes: Use vmalloc special flag
Date:   Fri, 26 Apr 2019 16:23:00 -0700
Message-Id: <20190426232303.28381-22-nadav.amit@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426232303.28381-1-nadav.amit@gmail.com>
References: <20190426232303.28381-1-nadav.amit@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

Use new flag VM_FLUSH_RESET_PERMS for handling freeing of special
permissioned memory in vmalloc and remove places where memory was set NX
and RW before freeing which is no longer needed.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/kprobes/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 1591852d3ac4..136695e4434a 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -434,6 +434,7 @@ void *alloc_insn_page(void)
 	if (!page)
 		return NULL;
 
+	set_vm_flush_reset_perms(page);
 	/*
 	 * First make the page read-only, and only then make it executable to
 	 * prevent it from being W+X in between.
@@ -452,12 +453,6 @@ void *alloc_insn_page(void)
 /* Recover page to RW mode before releasing it */
 void free_insn_page(void *page)
 {
-	/*
-	 * First make the page non-executable, and only then make it writable to
-	 * prevent it from being W+X in between.
-	 */
-	set_memory_nx((unsigned long)page, 1);
-	set_memory_rw((unsigned long)page, 1);
 	module_memfree(page);
 }
 
-- 
2.17.1

