Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C405FCA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9078B20862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="NR2y36ZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfJaAcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 20:32:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40047 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJaAcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 20:32:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so4111714wmm.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 17:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DP8EUpBnJhrMMlR35AJ4qBuW5AAWrThlGdUysZgbcoM=;
        b=NR2y36ZZEfoJ5Txna6kcEQ7KMDEZfJ5uEOOUqUBeEw5/YOd91gpyFb21BmcEkeTPDL
         VYKz4WaVu+sf+6lxOOq1rkeXeFVj2T9AQ7Ov5PCc6o318lrWSxiqeem6ihBc1IHDaVdx
         +gEByoBqajrE0ByG/eUxCaJt70X6wt7p89/Yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DP8EUpBnJhrMMlR35AJ4qBuW5AAWrThlGdUysZgbcoM=;
        b=T/GCsW0UgK3NQ3O2DJy9n4ezrfSLEysvqc5EgOImtl1B5OLuFhTl6UDOyNs4U7CpGq
         jpQJ4nwEIqkxW64JN99TwBkv2HAvXgqBylJ4Oed3c8EniHslhrSrMoGKr0jreLmqQtlx
         1/SsxgG8Ea1u7Dpgf5zfBPGikzuq66uaXGzibxqOP9EekPWyhjpBQ/NnAarj5G99/7oQ
         xb6aiW5JJONnWsSOq8RpcVoHbLv6VJP2EmKv7qkIBXtwk42PWXY7cZhFFbkUK9Wqn+F3
         HSN6U904xWzqNJmR4vRQs6YiSi0SwffK06xjaf+Cv3kWoJxnrns6esL6rRXQwRTawGJe
         IzWQ==
X-Gm-Message-State: APjAAAWkXEZy13JGn0k647toOJvQTMEKufOvl0A6DkAJ5uQgAc6zUKUt
        r7pj7/l5mtvFvhWmrtGqh85kCQ==
X-Google-Smtp-Source: APXvYqzxz++sN38GMY6qBbfTvoPZ3oZC6iyvGo/uRS0b9BlQq1tFkpv4AxeUqwoKyzUF2DucLQzJEw==
X-Received: by 2002:a1c:f317:: with SMTP id q23mr1976912wmq.74.1572481922962;
        Wed, 30 Oct 2019 17:32:02 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id r13sm2357111wra.74.2019.10.30.17.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 17:32:02 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 2/5] asm-generic: employ "ifndef foo; define foo foo" idiom in iomap.h
Date:   Thu, 31 Oct 2019 01:31:51 +0100
Message-Id: <20191031003154.21969-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
References: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible for an architecture to include asm-generic/iomap.h
without necessarily getting all the external declarations for
iowrite32 and friends. For example, the architecture could (maybe just
in some configurations) provide static inline versions of some or all
of these, but still use asm-generic/iomap.h for the
ARCH_HAS_IOREMAP_WT/WC logic.

This will be used on powerpc.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/asm-generic/iomap.h | 94 ++++++++++++++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 5f8321e8fea9..1b247d3b9fbb 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -26,47 +26,105 @@
  * in the low address range. Architectures for which this is not
  * true can't use this generic implementation.
  */
+#ifndef ioread8
+#define ioread8 ioread8
 extern unsigned int ioread8(void __iomem *);
+#endif
+#ifndef ioread16
+#define ioread16 ioread16
 extern unsigned int ioread16(void __iomem *);
+#endif
+#ifndef ioread16be
+#define ioread16be ioread16be
 extern unsigned int ioread16be(void __iomem *);
+#endif
+#ifndef ioread32
+#define ioread32 ioread32
 extern unsigned int ioread32(void __iomem *);
+#endif
+#ifndef ioread32be
+#define ioread32be ioread32be
 extern unsigned int ioread32be(void __iomem *);
+#endif
 #ifdef CONFIG_64BIT
+#ifndef ioread64
+#define ioread64 ioread64
 extern u64 ioread64(void __iomem *);
+#endif
+#ifndef ioread64be
+#define ioread64be ioread64be
 extern u64 ioread64be(void __iomem *);
 #endif
+#endif /* CONFIG_64BIT */
 
 #ifdef readq
+#ifndef ioread64_lo_hi
 #define ioread64_lo_hi ioread64_lo_hi
-#define ioread64_hi_lo ioread64_hi_lo
-#define ioread64be_lo_hi ioread64be_lo_hi
-#define ioread64be_hi_lo ioread64be_hi_lo
 extern u64 ioread64_lo_hi(void __iomem *addr);
+#endif
+#ifndef ioread64_hi_lo
+#define ioread64_hi_lo ioread64_hi_lo
 extern u64 ioread64_hi_lo(void __iomem *addr);
+#endif
+#ifndef ioread64be_lo_hi
+#define ioread64be_lo_hi ioread64be_lo_hi
 extern u64 ioread64be_lo_hi(void __iomem *addr);
+#endif
+#ifndef ioread64be_hi_lo
+#define ioread64be_hi_lo ioread64be_hi_lo
 extern u64 ioread64be_hi_lo(void __iomem *addr);
 #endif
+#endif /* readq */
 
+#ifndef iowrite8
+#define iowrite8 iowrite8
 extern void iowrite8(u8, void __iomem *);
+#endif
+#ifndef iowrite16
+#define iowrite16 iowrite16
 extern void iowrite16(u16, void __iomem *);
+#endif
+#ifndef iowrite16be
+#define iowrite16be iowrite16be
 extern void iowrite16be(u16, void __iomem *);
+#endif
+#ifndef iowrite32
+#define iowrite32 iowrite32
 extern void iowrite32(u32, void __iomem *);
+#endif
+#ifndef iowrite32be
+#define iowrite32be iowrite32be
 extern void iowrite32be(u32, void __iomem *);
+#endif
 #ifdef CONFIG_64BIT
+#ifndef iowrite64
+#define iowrite64 iowrite64
 extern void iowrite64(u64, void __iomem *);
+#endif
+#ifndef iowrite64be
+#define iowrite64be iowrite64be
 extern void iowrite64be(u64, void __iomem *);
 #endif
+#endif /* CONFIG_64BIT */
 
 #ifdef writeq
+#ifndef iowrite64_lo_hi
 #define iowrite64_lo_hi iowrite64_lo_hi
-#define iowrite64_hi_lo iowrite64_hi_lo
-#define iowrite64be_lo_hi iowrite64be_lo_hi
-#define iowrite64be_hi_lo iowrite64be_hi_lo
 extern void iowrite64_lo_hi(u64 val, void __iomem *addr);
+#endif
+#ifndef iowrite64_hi_lo
+#define iowrite64_hi_lo iowrite64_hi_lo
 extern void iowrite64_hi_lo(u64 val, void __iomem *addr);
+#endif
+#ifndef iowrite64be_lo_hi
+#define iowrite64be_lo_hi iowrite64be_lo_hi
 extern void iowrite64be_lo_hi(u64 val, void __iomem *addr);
+#endif
+#ifndef iowrite64be_hi_lo
+#define iowrite64be_hi_lo iowrite64be_hi_lo
 extern void iowrite64be_hi_lo(u64 val, void __iomem *addr);
 #endif
+#endif /* writeq */
 
 /*
  * "string" versions of the above. Note that they
@@ -79,19 +137,43 @@ extern void iowrite64be_hi_lo(u64 val, void __iomem *addr);
  * memory across multiple ports, use "memcpy_toio()"
  * and friends.
  */
+#ifndef ioread8_rep
+#define ioread8_rep ioread8_rep
 extern void ioread8_rep(void __iomem *port, void *buf, unsigned long count);
+#endif
+#ifndef ioread16_rep
+#define ioread16_rep ioread16_rep
 extern void ioread16_rep(void __iomem *port, void *buf, unsigned long count);
+#endif
+#ifndef ioread32_rep
+#define ioread32_rep ioread32_rep
 extern void ioread32_rep(void __iomem *port, void *buf, unsigned long count);
+#endif
 
+#ifndef iowrite8_rep
+#define iowrite8_rep iowrite8_rep
 extern void iowrite8_rep(void __iomem *port, const void *buf, unsigned long count);
+#endif
+#ifndef iowrite16_rep
+#define iowrite16_rep iowrite16_rep
 extern void iowrite16_rep(void __iomem *port, const void *buf, unsigned long count);
+#endif
+#ifndef iowrite32_rep
+#define iowrite32_rep iowrite32_rep
 extern void iowrite32_rep(void __iomem *port, const void *buf, unsigned long count);
+#endif
 
 #ifdef CONFIG_HAS_IOPORT_MAP
 /* Create a virtual mapping cookie for an IO port range */
+#ifndef ioport_map
+#define ioport_map ioport_map
 extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
+#endif
+#ifndef ioport_unmap
+#define ioport_unmap ioport_unmap
 extern void ioport_unmap(void __iomem *);
 #endif
+#endif /* CONFIG_HAS_IOPORT_MAP */
 
 #ifndef ARCH_HAS_IOREMAP_WC
 #define ioremap_wc ioremap_nocache
-- 
2.23.0

