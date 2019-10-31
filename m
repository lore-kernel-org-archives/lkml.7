Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4334CA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB0F20862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="P8q6ecGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfJaAcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 20:32:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55982 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfJaAcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 20:32:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id g24so4060949wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 17:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nviaR21RiU1nk2LZ5kFcjxEatw3WuqbBoBTo8fSflGU=;
        b=P8q6ecGkOH1cz6KavvYnvhkldy2tb8GnfywHDNOSmTJurUs0VpLx+KuDDNh7MPM44L
         5e0MnvX5DsJLANeS+IemAzatJQb4T0LUS6sA2On5F0pFAuLI6/uos7sX+kGwmdNe2rhz
         ZoQU3hea1E0m/TW45ofs64T/Ul8kX5U8MdK/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nviaR21RiU1nk2LZ5kFcjxEatw3WuqbBoBTo8fSflGU=;
        b=Y/VKCO37dSbk7XG+r5u2Nh1+BLxlC1XH+EjnXTTEiLAafGOWPR8HsMfFFhSXD6CuuR
         RoDdrdHltVt2iMgvtweiK3RORyQD8MdiggPrLhrWYqTCTt1FYwBRXHPSlNhFrN/iN2vv
         eSvwl115pn6aI3iZSUZJDnUYwE1AKom7oycYdT9AH7Fia3sAODqcBQhFbTp9Rs9kQvV1
         eczNkAUtUz1qwlCzYJ2BwV4z2kLxsGdQ3YLcqHVdwR5Uyu+81KZRu4dGuO1QPyLFBnuU
         OmpzlnWWFHNsLgE/OHr03VT6jDEZC0hO6FOkm1a6DHlWpSHtdhfwtHTLQCuIBEXGrIVe
         U7fA==
X-Gm-Message-State: APjAAAWFyyQFJZ7ibbbg1pmgOI+ZHX0bacFDu+FbM29jKTYskc1lih8t
        3fub9w1v2hugev24u8d3Aq5QBw==
X-Google-Smtp-Source: APXvYqw3+GGNKPWfeYgL+Q1AJ6aouq9nqy+A5TiFT/Z3iyOgjPBzEBNst1ROKUpNxsiK1ff/4oXKsA==
X-Received: by 2002:a1c:558a:: with SMTP id j132mr2103148wmb.21.1572481921871;
        Wed, 30 Oct 2019 17:32:01 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id r13sm2357111wra.74.2019.10.30.17.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 17:32:01 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 1/5] asm-generic: move pcu_iounmap from iomap.h to pci_iomap.h
Date:   Thu, 31 Oct 2019 01:31:50 +0100
Message-Id: <20191031003154.21969-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
References: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_iounmap seems misplaced in iomap.h. Move it to where its cousins
live. Since iomap.h includes pci_iomap.h, anybody relying on getting
the declaration through iomap.h will still get it.

It would be natural to put the static inline version inside the

#elif defined(CONFIG_GENERIC_PCI_IOMAP)

Since GENERIC_IOMAP selects GENERIC_PCI_IOMAP, that would be ok for
those who select GENERIC_IOMAP. However, I fear there are some that
select GENERIC_PCI_IOMAP without GENERIC_IOMAP, and which perhaps have
their own pci_iounmap stub definition somewhere. So for now at least,
define the static inline version under the same conditions as it were
in iomap.h.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/asm-generic/iomap.h     | 10 ----------
 include/asm-generic/pci_iomap.h |  7 +++++++
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index a008f504a2d0..5f8321e8fea9 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -101,16 +101,6 @@ extern void ioport_unmap(void __iomem *);
 #define ioremap_wt ioremap_nocache
 #endif
 
-#ifdef CONFIG_PCI
-/* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
-struct pci_dev;
-extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
-#elif defined(CONFIG_GENERIC_IOMAP)
-struct pci_dev;
-static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
-{ }
-#endif
-
 #include <asm-generic/pci_iomap.h>
 
 #endif
diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
index d4f16dcc2ed7..c2f78db2420e 100644
--- a/include/asm-generic/pci_iomap.h
+++ b/include/asm-generic/pci_iomap.h
@@ -18,6 +18,8 @@ extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
 extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
 					unsigned long offset,
 					unsigned long maxlen);
+/* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
+extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 /* Create a virtual mapping cookie for a port on a given PCI device.
  * Do not call this directly, it exists to make it easier for architectures
  * to override */
@@ -52,4 +54,9 @@ static inline void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
 }
 #endif
 
+#if !defined(CONFIG_PCI) && defined(CONFIG_GENERIC_IOMAP)
+static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
+{ }
+#endif
+
 #endif /* __ASM_GENERIC_IO_H */
-- 
2.23.0

