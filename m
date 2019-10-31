Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7AFC47E49
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C243F20874
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dSAbWiy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfJaAcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 20:32:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35938 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfJaAcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 20:32:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id w18so4364402wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 17:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YGjLcdx9KXKhg9YECWTpZ9bCIGLdak4UGDzKAXAAeDM=;
        b=dSAbWiy17OZMli/VazTnjYLhJ/fBH4XviqbTVhDYKWDZTRAbfb5lfbbwzHTia3qwyX
         SaCCsfFF5LMCBCXV1wkM4COyJ97bWFwoUrVXsDrqTPiM4PW4a4uqUepJ0JmXeJcGK4qH
         Ab0vWhCeoL9vXwoVAOl/ZHoSAWRg+U+jWoy5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YGjLcdx9KXKhg9YECWTpZ9bCIGLdak4UGDzKAXAAeDM=;
        b=FYaYnlbfv3s+0m1eARvIr69Mud9zimeuBuDJlLYpG+EO44urmjpCgUucghcMS938vq
         EdKF4cCsdgxkJZd5ALPkU1tSh3gAC6Nv7CCc27aQBU7GdC/Ykc68zb2CsMAD6rUlMv2f
         s/TvE8Tilj0MJ69rVR245Xg3JClBRXWAUFSWwxs0ZTp+SrXz4wTZ4o/29kWky1NR2n5C
         wdcfr0yljfjc0ZvsklTlz+Fordg7q/OCKc0o1Gxc5me2KD7ZR5BXhv79HZzqrDZQIyN6
         gSQidoyeazS+QnKt7ROmGjMjVeKViaaMnbQhe/458boZHm3EVonqwEO/xHUTKOhuDujk
         XqEw==
X-Gm-Message-State: APjAAAUgCN+++WOg4YO/WZ36BAMhS0tnOQ3caDbTAA8hNVvBRzDM0gzd
        g20ei+3o9sAKj53ZJTbXolMGug==
X-Google-Smtp-Source: APXvYqwVUehvwoFgGnD9cecxRxGad/kVRBBgTLONSUGtsGz+C8YNoj+GJyg21DvBYXFJy2LNkBhEjQ==
X-Received: by 2002:adf:ea01:: with SMTP id q1mr2437079wrm.240.1572481925942;
        Wed, 30 Oct 2019 17:32:05 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id r13sm2357111wra.74.2019.10.30.17.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 17:32:05 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 5/5] powerpc: make iowrite32 and friends static inline when no indirection
Date:   Thu, 31 Oct 2019 01:31:54 +0100
Message-Id: <20191031003154.21969-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
References: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When porting a powerpc-only driver to work on another architecture,
one has to change e.g. out_be32 to iowrite32be. Unfortunately, while
the other target architecture (in my case arm) may have static inline
definitions of iowrite32 and friends, this change pessimizes the
existing powerpc users of that driver since out_be32() is inline while
iowrite32be() is out-of-line.

When neither CONFIG_PPC_INDIRECT_PIO or CONFIG_PPC_INDIRECT_MMIO are
set (e.g. all of PPC32), there's no reason for those to be out-of-line
as they compile to just two or three instructions. So copy the
definitions from iomap.c into io.h, make them static inline, and add
the self-define macro boilerplate to prevent asm-generic/iomap.h from
providing extern declarations.

This means that kernel/iomap.c is now only compiled when
!CONFIG_PPC_INDIRECT_PIO && CONFIG_PPC_INDIRECT_MMIO - a combination I
don't think currently exists. So it's possible that file could simply
be deleted.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/include/asm/io.h | 172 ++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/Makefile  |   2 +-
 2 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index a63ec938636d..a59310620067 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -638,6 +638,178 @@ static inline void name at					\
 #define writel_relaxed(v, addr)	writel(v, addr)
 #define writeq_relaxed(v, addr)	writeq(v, addr)
 
+#if !defined(CONFIG_PPC_INDIRECT_PIO) && !defined(CONFIG_PPC_INDIRECT_MMIO)
+
+#define ioread8 ioread8
+static inline unsigned int ioread8(void __iomem *addr)
+{
+	return readb(addr);
+}
+#define ioread16 ioread16
+static inline unsigned int ioread16(void __iomem *addr)
+{
+	return readw(addr);
+}
+#define ioread16be ioread16be
+static inline unsigned int ioread16be(void __iomem *addr)
+{
+	return readw_be(addr);
+}
+#define ioread32 ioread32
+static inline unsigned int ioread32(void __iomem *addr)
+{
+	return readl(addr);
+}
+#define ioread32be ioread32be
+static inline unsigned int ioread32be(void __iomem *addr)
+{
+	return readl_be(addr);
+}
+#ifdef __powerpc64__
+#define ioread64 ioread64
+static inline u64 ioread64(void __iomem *addr)
+{
+	return readq(addr);
+}
+#define ioread64_lo_hi ioread64_lo_hi
+static inline u64 ioread64_lo_hi(void __iomem *addr)
+{
+	return readq(addr);
+}
+#define ioread64_hi_lo ioread64_hi_lo
+static inline u64 ioread64_hi_lo(void __iomem *addr)
+{
+	return readq(addr);
+}
+#define ioread64be ioread64be
+static inline u64 ioread64be(void __iomem *addr)
+{
+	return readq_be(addr);
+}
+#define ioread64be_lo_hi ioread64be_lo_hi
+static inline u64 ioread64be_lo_hi(void __iomem *addr)
+{
+	return readq_be(addr);
+}
+#define ioread64be_hi_lo ioread64be_hi_lo
+static inline u64 ioread64be_hi_lo(void __iomem *addr)
+{
+	return readq_be(addr);
+}
+#endif /* __powerpc64__ */
+
+#define iowrite8 iowrite8
+static inline void iowrite8(u8 val, void __iomem *addr)
+{
+	writeb(val, addr);
+}
+#define iowrite16 iowrite16
+static inline void iowrite16(u16 val, void __iomem *addr)
+{
+	writew(val, addr);
+}
+#define iowrite16be iowrite16be
+static inline void iowrite16be(u16 val, void __iomem *addr)
+{
+	writew_be(val, addr);
+}
+#define iowrite32 iowrite32
+static inline void iowrite32(u32 val, void __iomem *addr)
+{
+	writel(val, addr);
+}
+#define iowrite32be iowrite32be
+static inline void iowrite32be(u32 val, void __iomem *addr)
+{
+	writel_be(val, addr);
+}
+#ifdef __powerpc64__
+#define iowrite64 iowrite64
+static inline void iowrite64(u64 val, void __iomem *addr)
+{
+	writeq(val, addr);
+}
+#define iowrite64_lo_hi iowrite64_lo_hi
+static inline void iowrite64_lo_hi(u64 val, void __iomem *addr)
+{
+	writeq(val, addr);
+}
+#define iowrite64_hi_lo iowrite64_hi_lo
+static inline void iowrite64_hi_lo(u64 val, void __iomem *addr)
+{
+	writeq(val, addr);
+}
+#define iowrite64be iowrite64be
+static inline void iowrite64be(u64 val, void __iomem *addr)
+{
+	writeq_be(val, addr);
+}
+#define iowrite64be_lo_hi iowrite64be_lo_hi
+static inline void iowrite64be_lo_hi(u64 val, void __iomem *addr)
+{
+	writeq_be(val, addr);
+}
+#define iowrite64be_hi_lo iowrite64be_hi_lo
+static inline void iowrite64be_hi_lo(u64 val, void __iomem *addr)
+{
+	writeq_be(val, addr);
+}
+#endif /* __powerpc64__ */
+
+/*
+ * These are the "repeat read/write" functions. Note the
+ * non-CPU byte order. We do things in "IO byteorder"
+ * here.
+ *
+ * FIXME! We could make these do EEH handling if we really
+ * wanted. Not clear if we do.
+ */
+#define ioread8_rep ioread8_rep
+static inline void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
+{
+	readsb(addr, dst, count);
+}
+#define ioread16_rep ioread16_rep
+static inline void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
+{
+	readsw(addr, dst, count);
+}
+#define ioread32_rep ioread32_rep
+static inline void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
+{
+	readsl(addr, dst, count);
+}
+
+#define iowrite8_rep iowrite8_rep
+static inline void iowrite8_rep(void __iomem *addr, const void *src, unsigned long count)
+{
+	writesb(addr, src, count);
+}
+#define iowrite16_rep iowrite16_rep
+static inline void iowrite16_rep(void __iomem *addr, const void *src, unsigned long count)
+{
+	writesw(addr, src, count);
+}
+#define iowrite32_rep iowrite32_rep
+static inline void iowrite32_rep(void __iomem *addr, const void *src, unsigned long count)
+{
+	writesl(addr, src, count);
+}
+
+#define ioport_map ioport_map
+static inline void __iomem *ioport_map(unsigned long port, unsigned int len)
+{
+	return (void __iomem *) (port + _IO_BASE);
+}
+
+#define ioport_unmap ioport_unmap
+static inline void ioport_unmap(void __iomem *addr)
+{
+	/* Nothing to do */
+}
+
+#endif /* !defined(CONFIG_PPC_INDIRECT_PIO) && !defined(CONFIG_PPC_INDIRECT_MMIO) */
+
 #include <asm-generic/iomap.h>
 
 static inline void iosync(void)
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index a7ca8fe62368..0991b3cd007b 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -143,7 +143,7 @@ obj-$(CONFIG_PPC_IO_WORKAROUNDS)	+= io-workarounds.o
 obj-y				+= trace/
 
 ifneq ($(CONFIG_PPC_INDIRECT_PIO),y)
-obj-y				+= iomap.o
+obj-$(CONFIG_PPC_INDIRECT_MMIO)	+= iomap.o
 endif
 
 obj64-$(CONFIG_PPC_TRANSACTIONAL_MEM)	+= tm.o
-- 
2.23.0

