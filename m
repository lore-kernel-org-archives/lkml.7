Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE36C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCFA233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="MgNQWIW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfH1Tit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 15:38:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33838 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfH1Tiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:38:46 -0400
Received: by mail-ed1-f65.google.com with SMTP id s49so1328721edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 12:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mGPxPtRA1D+C9Lx3ecKYNHdNJ8rQlVmAMJe2O6XMN1o=;
        b=MgNQWIW5jaNIZ+v28n88Cf6T294svtLxJZdXwXVamUX/+sr9l91TkrXK+FgKlMwbry
         EPaEnzysbWIwA9j35sHyxxlGI2AlqJcLv0DksYPfmu7kxL5kj7JFqM770Ja98lKj9cBN
         KHajg8E52NCpTHC1oRWQ+WJyyNZAroXzHXP8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mGPxPtRA1D+C9Lx3ecKYNHdNJ8rQlVmAMJe2O6XMN1o=;
        b=GMpmi9bnk9iRKeGlIMLSfYSBX3XEaYNo87AEhKsoz+ilozdGuUwA08towg798cYUPz
         jUrLKfiS3Xma8DczNlbhX4HuCBKDqoa9/WK/g4bkcaB8kdQGOetSPMEgGnoME7iw2DcS
         bmPthni35Iy/hDgvQG0lIEUznvvIlPOWtG+DZVZMbD/w5oVuMH8eVGlalZoCTmcTqGJJ
         4jqZ8G5rafpEM1tF2AuVu+f3I2xpAglvr3dk9rXio6m7SM7s/FNzJbL/6tU3xV8V+Wv1
         n/yc1v6Xlne9tH8cp3EfudOpcQIuflSoeVDi8RekgmdUK3O3FYU4+LVIPRRUBhea5AxM
         X8UA==
X-Gm-Message-State: APjAAAXAfsvLULnSKG5xYDZY5Rek7oOFqkHxe993I1h7dJfDUVypttHz
        dAitxFasA+i8WetOvHsE0yktQgQRdOSi4lb8
X-Google-Smtp-Source: APXvYqwZUHjFu8iHpa+MkvhDT19gzuQxbNAf7mpdYtbc6V4wQUM1HtedjY+kAqqFhFCfI0Jctp83Cw==
X-Received: by 2002:a50:fc12:: with SMTP id i18mr6036132edr.23.1567021124863;
        Wed, 28 Aug 2019 12:38:44 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id ni7sm38990ejb.57.2019.08.28.12.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 12:38:44 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86: mmu.h: move mm_context_t::ia32_compat member a bit down
Date:   Wed, 28 Aug 2019 21:38:36 +0200
Message-Id: <20190828193836.16791-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828193836.16791-1-linux@rasmusvillemoes.dk>
References: <20190828193836.16791-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=n, there's both a
6-byte hole after ia32_compat as well as a 4-byte hole after
perf_rdpmc_allowed. So rearranging things a bit we cut 8 bytes of
sizeof(struct mm_struct).

For a CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y kernel, this patch
just moves the 6-byte hole to another place in mm_context_t.

Putting the ia32_compat member after the pkey members is deliberate to
keep the latter two (when present) in the same 4-byte unit.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/x86/include/asm/mmu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index b1bb47a3577b..ba3d22fcd507 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -32,10 +32,6 @@ typedef struct {
 	struct ldt_struct	*ldt;
 	struct mutex		lock;
 #endif
-#ifdef CONFIG_X86_64
-	/* True if mm supports a task running in 32 bit compatibility mode. */
-	unsigned short ia32_compat;
-#endif
 
 	void __user *vdso;			/* vdso base address */
 	const struct vdso_image *vdso_image;	/* vdso image in use */
@@ -49,6 +45,10 @@ typedef struct {
 	u16 pkey_allocation_map;
 	s16 execute_only_pkey;
 #endif
+#ifdef CONFIG_X86_64
+	/* True if mm supports a task running in 32 bit compatibility mode. */
+	unsigned short ia32_compat;
+#endif
 #ifdef CONFIG_X86_INTEL_MPX
 	/* address of the bounds directory */
 	void __user *bd_addr;
-- 
2.20.1

