Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AE9C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD62420679
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NrH9CP3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfG2U0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:26:12 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:43466 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfG2U0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:26:12 -0400
Received: by mail-pl1-f201.google.com with SMTP id t2so33809533plo.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 13:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=InkWYbyakoin4kW7joWmSnOT6nnJvOIEoZKfiSX6FXM=;
        b=NrH9CP3j3IaEZeQTRPUpaINe6R+O0NeUPVTiKEqR6ZRIdxWO6b0hnLm51vp8WpodBt
         b6YZ/M3SVAVCFf3UurTkKgjdqsG/kQ8nQYh7BWrOOjkRKhtlE1ly2pEUBUWxk6GGbYm8
         1ArC7a1eS8zanTLR4ftZoAMpPBBnZ9ajFP2RpwM+A1dCeK8QIzBW1wpVAYqB7Uuom3Lo
         CoBW1LSDZajNANwdP5yg7IcmAWWiInk7VkArgc5DgBwQrWjtWw6B0CmJ+6WQc8lHqx03
         m3b2v59YP42soakHigmlcSIQP5KCqXM6lb/979S2CV6wnYKKJK5lJX989prCYbKth+Ai
         M+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=InkWYbyakoin4kW7joWmSnOT6nnJvOIEoZKfiSX6FXM=;
        b=gNuVQOcWbP7+Av0gXOsjlzkbqiVAPMYiqONG4IPDyXVQqb86Ob9gAuicqeax0ESd70
         BWvrVDIdPD4w7SGOSk4u128+LU5AqQ48xLYpT/7zLeNNWrGiKD2/Pys42OU3bA6LomRw
         5tvSXXaIaZim0U0CRoAgEPnm2/Di7vTUwqhotkfZYek0yD4Z9Rt88l3V4gP4cbISdGNT
         4tLCfItYYv7B5zTqdFRYNDJ4PdmYon2cPCm28E5ZN9wCL70K921qv5Y9CgVQJJyXl8pw
         tNws+vFrs9M1t+Vc2Uv4M4jC8nXIQ7GQ04bLONDfdJv7UHgPlKqZFhSNcZ/RORjao5Ql
         MYjw==
X-Gm-Message-State: APjAAAUfDNKhVft+VenBz2qPXHXXiEZBiLhQCjD6G94vv+O7LGRKeNm3
        kdINWR5gtEbXcv8CpvFUzS1kxmFvPLDk7/Rgg68=
X-Google-Smtp-Source: APXvYqzbqjK6rfCZn+o56AxaIOeOmnCvc2eWfzYd3XaqtryKtAIfNfxTDSqVXK8CEHfxuNI/ij2rwh8wRg9LWpZl+Y0=
X-Received: by 2002:a63:5b52:: with SMTP id l18mr106138942pgm.21.1564431971070;
 Mon, 29 Jul 2019 13:26:11 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:25:41 -0700
Message-Id: <20190729202542.205309-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH] powerpc: workaround clang codegen bug in dcbz
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     mpe@ellerman.id.au
Cc:     christophe.leroy@c-s.fr, segher@kernel.crashing.org, arnd@arndb.de,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kbuild test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6c5875843b87 ("powerpc: slightly improve cache helpers") exposed
what looks like a codegen bug in Clang's handling of `%y` output
template with `Z` constraint. This is resulting in panics during boot
for 32b powerpc builds w/ Clang, as reported by our CI.

Add back the original code that worked behind a preprocessor check for
__clang__ until we can fix LLVM.

Further, it seems that clang allnoconfig builds are unhappy with `Z`, as
reported by 0day bot. This is likely because Clang warns about inline
asm constraints when the constraint requires inlining to be semantically
valid.

Link: https://bugs.llvm.org/show_bug.cgi?id=42762
Link: https://github.com/ClangBuiltLinux/linux/issues/593
Link: https://lore.kernel.org/lkml/20190721075846.GA97701@archlinux-threadripper/
Debugged-by: Nathan Chancellor <natechancellor@gmail.com>
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Reported-by: kbuild test robot <lkp@intel.com>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Alternatively, we could just revert 6c5875843b87. It seems that GCC
generates the same code for these functions for out of line versions.
But I'm not sure how the inlined code generated would be affected.

 arch/powerpc/include/asm/cache.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index b3388d95f451..72983da94dce 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -105,6 +105,30 @@ extern void _set_L3CR(unsigned long);
 #define _set_L3CR(val)	do { } while(0)
 #endif
 
+/*
+ * Workaround for https://bugs.llvm.org/show_bug.cgi?id=42762.
+ */
+#ifdef __clang__
+static inline void dcbz(void *addr)
+{
+	__asm__ __volatile__ ("dcbz 0, %0" : : "r"(addr) : "memory");
+}
+
+static inline void dcbi(void *addr)
+{
+	__asm__ __volatile__ ("dcbi 0, %0" : : "r"(addr) : "memory");
+}
+
+static inline void dcbf(void *addr)
+{
+	__asm__ __volatile__ ("dcbf 0, %0" : : "r"(addr) : "memory");
+}
+
+static inline void dcbst(void *addr)
+{
+	__asm__ __volatile__ ("dcbst 0, %0" : : "r"(addr) : "memory");
+}
+#else
 static inline void dcbz(void *addr)
 {
 	__asm__ __volatile__ ("dcbz %y0" : : "Z"(*(u8 *)addr) : "memory");
@@ -124,6 +148,7 @@ static inline void dcbst(void *addr)
 {
 	__asm__ __volatile__ ("dcbst %y0" : : "Z"(*(u8 *)addr) : "memory");
 }
+#endif /* __clang__ */
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_CACHE_H */
-- 
2.22.0.709.g102302147b-goog

