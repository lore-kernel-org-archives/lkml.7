Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8990EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5767F206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ATRO1aTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfFDXpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:45:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35320 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfFDXpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:45:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id s27so5677088pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 16:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cHnNg4XtFEYoLnQEw/XfFsePIT8BBPSNq7MudRDS36k=;
        b=ATRO1aTs6+299taKxHTHEoxOHK2BN/NbivR1BwD6wUmG4PXRnMzshBWZ7GdSKo8FAB
         o1rNGCpuN6Uf27POpOroJ+GELrQ9q4JrhaqlEOj+pK0Qz9vAkiseXnK5XTZvlK+PGj+c
         ITLnJzW3gXi/8R8ctVGRoXbuDafR7RYGUuff4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cHnNg4XtFEYoLnQEw/XfFsePIT8BBPSNq7MudRDS36k=;
        b=Ni7Usbw5jvkRX3biG6lOYlmRMFK5b2vL1ip9aFsyL2zJzpPknaaFCxmzlkcdHZTgMM
         OivVfEjn9WCeTochfWIV24TptEDI23SoxCl7Onk7WQD8U5dvSTRRh82T2QY+Y2MibbmQ
         ON2l11SPYP+RcrMUpuF2l5rCicjXTbLWalflkqQUDRz7RMmmx1JHwWjm5jDTfRhFnvtZ
         Fb8SN27rs8zr5scWSCjs4WDh27SsYBXz2IQ0TCzZTJQPTPSx9OeitVb9C9MwhyERC4CI
         K+lfvv+X7WEjV9NYfqQ0uMKkQeW+U+4wae3rwDvrPrigwxskTQ63+m94KFRCRH7GgCvk
         zE7Q==
X-Gm-Message-State: APjAAAWv0KTAUTyZgoq4c5xrdfOjOcYQhNVYoHMxVJoPFHOxDbvAw2qT
        pvaSW1rNrg8KM75SMN0ibV3dTA==
X-Google-Smtp-Source: APXvYqwRmQzJ5TBEJwVont89XoUey1p+VXvdgxkaWsqZQp5vr0bJX3e08W1uskVC0tV7Le8blSEzbQ==
X-Received: by 2002:a65:48c3:: with SMTP id o3mr409690pgs.351.1559691913611;
        Tue, 04 Jun 2019 16:45:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c142sm20929180pfb.171.2019.06.04.16.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 16:45:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] x86/asm: Pin sensitive CR0 bits
Date:   Tue,  4 Jun 2019 16:44:22 -0700
Message-Id: <20190604234422.29391-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604234422.29391-1-keescook@chromium.org>
References: <20190604234422.29391-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With sensitive CR4 bits pinned now, it's possible that the WP bit for
CR0 might become a target as well. Following the same reasoning for
the CR4 pinning, this pins CR0's WP bit (but this can be done with a
static value).

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/special_insns.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 284a77d52fea..9c9fd3760079 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -31,7 +31,22 @@ static inline unsigned long native_read_cr0(void)
 
 static inline void native_write_cr0(unsigned long val)
 {
-	asm volatile("mov %0,%%cr0": : "r" (val), "m" (__force_order));
+	unsigned long bits_missing = 0;
+
+set_register:
+	if (static_branch_likely(&cr_pinning))
+		val |= X86_CR0_WP;
+
+	asm volatile("mov %0,%%cr0": "+r" (val), "+m" (__force_order));
+
+	if (static_branch_likely(&cr_pinning)) {
+		if (unlikely((val & X86_CR0_WP) != X86_CR0_WP)) {
+			bits_missing = X86_CR0_WP;
+			goto set_register;
+		}
+		/* Warn after we've set the missing bits. */
+		WARN_ONCE(bits_missing, "CR0 WP bit went missing!?\n");
+	}
 }
 
 static inline unsigned long native_read_cr2(void)
-- 
2.17.1

