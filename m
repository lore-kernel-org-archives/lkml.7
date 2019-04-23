Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1567C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41C3218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI9TjAH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfDWWtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:49:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40422 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbfDWWtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:49:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so14985225ljq.7;
        Tue, 23 Apr 2019 15:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cKcAZCZmHBkOFZOBdJVKsgxHPiEdHR2uf5o4k8h8weQ=;
        b=LI9TjAH2Xp9ixng6oGKtwlyVvGBV0Fx3cil6kEE6VDXWbDUjU1XTGg+FizGETTXW67
         YDDoDxm8MTqseKi0zaxuiRK2QkBETCd3LXSkrO8o0AAVmU1wKb0uzbx/e2n9y6DGgl9j
         8UMIzPXDtHKc6OqVsWU7Bmf2+bDoP/FiqxXVtX8g53Mzzy2aKTVrQyjH7q13qJX4JlpM
         pquXrOjO0L9MnrXj1DsHdnKU3+LzhEq9U73nSXz6JQ/jmi4za/p31L1RM6d9flYT3j2D
         M5VNynMz37LEji78Td9OOkWz1p9CuZG5xgPonZloenFwKbZvLRZ6sd3eCVBp6MpZR+76
         968g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cKcAZCZmHBkOFZOBdJVKsgxHPiEdHR2uf5o4k8h8weQ=;
        b=cuGFJkxC3kMfkDEqHpDPepuv+gxaNg1vA5NJ9/9D0XR2Qf+gPVFj5UmuemXMPr5T4c
         vkQ12T8YihmXw5yq1OFj3+PmvSpCxGx+/MpiU/dketJEhJOQHNo84FuZfqYsjFx7w9pO
         5CnsFdVoLocNnlul3v9AYZEu+i+zpkGqgcy0US+fXa1w5aTbV+8E1CDJil/iwtuK9PH1
         9WlqFi4nZlXOTAdMf7j37mKmTf3oaI/oxTIETSsn22vTLvrvnsqMaEUw7KOGHvytP2NU
         iCi7+arwdwpwBpRcTYDhMfsRgcuwU7nA/jVCY2AV5BiGDcKpWY4rA1wAcbEDOZzr04cN
         QU4w==
X-Gm-Message-State: APjAAAXEa8jEr+9sicc8YFmfQ2ydEbkqkTvJ4KuS8lsaECWf6pny4NUu
        PY1rQNCNXfCAfr+6thKptr8=
X-Google-Smtp-Source: APXvYqyAXeBiz4mUBF6HYRBCUA5Zqa5vUYs5oJ1JyAbZ+J454fbF0zypcDVYEV6KCeBX8Hm2mj46vA==
X-Received: by 2002:a2e:97da:: with SMTP id m26mr8576895ljj.115.1556059777939;
        Tue, 23 Apr 2019 15:49:37 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id w2sm4904722lfa.63.2019.04.23.15.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:49:37 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Huacai Chen <chenhc@lemote.com>,
        Stefan Agner <stefan@agner.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Juergen Gross <jgross@suse.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 10/12] mips: Print the kernel virtual mem layout on debugging
Date:   Wed, 24 Apr 2019 01:47:46 +0300
Message-Id: <20190423224748.3765-11-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423224748.3765-1-fancer.lancer@gmail.com>
References: <20190423224748.3765-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is useful at least for debugging to have the kernel virtual
memory layout printed at boot time so to have the full information
about the booted kernel. Make the printing optional and available
only when DEBUG_KERNEL config is enabled so not to leak a sensitive
kernel information.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/mm/init.c | 49 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index bbb196ad5f26..c338bbd03b2a 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -31,6 +31,7 @@
 #include <linux/gfp.h>
 #include <linux/kcore.h>
 #include <linux/initrd.h>
+#include <linux/sizes.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cachectl.h>
@@ -56,6 +57,53 @@ unsigned long empty_zero_page, zero_page_mask;
 EXPORT_SYMBOL_GPL(empty_zero_page);
 EXPORT_SYMBOL(zero_page_mask);
 
+/*
+ * Print out the kernel virtual memory layout
+ */
+#define MLK(b, t) (void *)b, (void *)t, ((t) - (b)) >> 10
+#define MLM(b, t) (void *)b, (void *)t, ((t) - (b)) >> 20
+#define MLK_ROUNDUP(b, t) (void *)b, (void *)t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
+static void __init mem_print_kmap_info(void)
+{
+#ifdef CONFIG_DEBUG_KERNEL
+	pr_notice("Kernel virtual memory layout:\n"
+		  "    lowmem  : 0x%px - 0x%px  (%4ld MB)\n"
+		  "      .text : 0x%px - 0x%px  (%4td kB)\n"
+		  "      .data : 0x%px - 0x%px  (%4td kB)\n"
+		  "      .init : 0x%px - 0x%px  (%4td kB)\n"
+		  "      .bss  : 0x%px - 0x%px  (%4td kB)\n"
+		  "    vmalloc : 0x%px - 0x%px  (%4ld MB)\n"
+#ifdef CONFIG_HIGHMEM
+		  "    pkmap   : 0x%px - 0x%px  (%4ld MB)\n"
+#endif
+		  "    fixmap  : 0x%px - 0x%px  (%4ld kB)\n",
+		  MLM(PAGE_OFFSET, (unsigned long)high_memory),
+		  MLK_ROUNDUP(_text, _etext),
+		  MLK_ROUNDUP(_sdata, _edata),
+		  MLK_ROUNDUP(__init_begin, __init_end),
+		  MLK_ROUNDUP(__bss_start, __bss_stop),
+		  MLM(VMALLOC_START, VMALLOC_END),
+#ifdef CONFIG_HIGHMEM
+		  MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE)),
+#endif
+		  MLK(FIXADDR_START, FIXADDR_TOP));
+
+	/* Check some fundamental inconsistencies. May add something else? */
+#ifdef CONFIG_HIGHMEM
+	BUILD_BUG_ON(VMALLOC_END < PAGE_OFFSET);
+	BUG_ON(VMALLOC_END < (unsigned long)high_memory);
+	BUILD_BUG_ON((PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE) < PAGE_OFFSET);
+	BUG_ON((PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE) <
+		(unsigned long)high_memory);
+#endif
+	BUILD_BUG_ON(FIXADDR_TOP < PAGE_OFFSET);
+	BUG_ON(FIXADDR_TOP < (unsigned long)high_memory);
+#endif /* CONFIG_DEBUG_KERNEL */
+}
+#undef MLK
+#undef MLM
+#undef MLK_ROUNDUP
+
 /*
  * Not static inline because used by IP27 special magic initialization code
  */
@@ -479,6 +527,7 @@ void __init mem_init(void)
 	setup_zero_pages();	/* Setup zeroed pages.  */
 	mem_init_free_highmem();
 	mem_init_print_info(NULL);
+	mem_print_kmap_info();
 
 #ifdef CONFIG_64BIT
 	if ((unsigned long) &_text > (unsigned long) CKSEG0)
-- 
2.21.0

