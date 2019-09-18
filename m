Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DF7C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 10:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3516214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 10:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DOnXq/J2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbfIRKjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 06:39:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34579 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbfIRKjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 06:39:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so3823783pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 03:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJMTj/Fq70plK6xajf5o6p+A1XUkzJJscq2WFg4Ok1g=;
        b=DOnXq/J274NOWRNt1DTh/uPChnrXdFihmCSYcMmvTR3F5sIF+5JU3PBEyH0UObAUCY
         rHI4PA/azQA+0lFnPqx5pZUjyVOmGPdE4qNRPR6A9nGVKXaytQMXT2bbpywkcpc8WZUW
         N5nlrUbLa8eVJtUGyQb5cSCEPadblD/PbsW6O7ajoALlDrFBavFGNXcZZ2oeyumOpRSe
         2UNzbRSwRXbi9ccsqKI931OZJf6ZtqmZO+gNVI3Gal1pk5RoUjLcuo8lYiZwvhrOVejK
         Vw4M6SN6zBG34yV4l/r/p2APdt1mdGc7KZWQ07as1lPEiTYGQudUQDys3byry8JjSuwJ
         I+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJMTj/Fq70plK6xajf5o6p+A1XUkzJJscq2WFg4Ok1g=;
        b=K3/APfsChth+fJ1qoiEXWyQkihTHfD6+Qwv5cLrMOHZmsiC96vXmyLHC7aBNUkrmD8
         bChrZuq2A9w13iu+a+GMFZZjS5xOA+RpmoChILRpx3wc04bOwcPTfuOFqEPSKDQ1/ayW
         W3kCr9SwxKsPf3bbo7QxnDma4jmr9fZxAR+6i3w8piZjpUPjc2v+qkpW/c9SfJFoG0IM
         0xs7b4leMGnwL0wHNE8SL3to4mIopwrySC+MWNTk2axkR+bGvUagPdDa6qSOHTF7XWZe
         xVmq95A78coSdD6sNUXEBqHO+IenjYO8qbDzBBF1ZthwNbS3XrFVsQnxXQ+xcue++6j2
         6E6w==
X-Gm-Message-State: APjAAAU2rDSWi/jSns+3Tb5mxh5sD4pYCktSYkqehyITDhtlCn3F4kbU
        70kleqTSjSeAU33/fy1ZFyl4KA==
X-Google-Smtp-Source: APXvYqwT7yE8ZvtiPNDu0qZs9cEmt2AKc8FFBPrLCdbKTMHPu+9h5U5gAJn9fIaC/1yIDkmIDWiqtQ==
X-Received: by 2002:a17:90a:a6e:: with SMTP id o101mr3072132pjo.71.1568803157898;
        Wed, 18 Sep 2019 03:39:17 -0700 (PDT)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id 31sm5751587pgr.55.2019.09.18.03.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 03:39:17 -0700 (PDT)
From:   greentime.hu@sifive.com
To:     greentime.hu@sifive.com, green.hu@gmail.com,
        paul.walmsley@sifive.com, linux-hackers@sifive.com,
        palmer@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: Fix building error when CONFIG_SPARSEMEM_MANUAL=y
Date:   Wed, 18 Sep 2019 18:38:24 +0800
Message-Id: <20190918103825.8694-1-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greentime Hu <greentime.hu@sifive.com>

To adjust the place of VMALLOC_* and FIXADDR_* defined location to let VMEMMAP_*
get it.

  CC      init/main.o
In file included from ./include/linux/mm.h:99,
                 from ./include/linux/ring_buffer.h:5,
                 from ./include/linux/trace_events.h:6,
                 from ./include/trace/syscall.h:7,
                 from ./include/linux/syscalls.h:85,
                 from init/main.c:21:
./arch/riscv/include/asm/pgtable.h: In function ‘pmd_page’:
./arch/riscv/include/asm/pgtable.h:95:24: error: ‘VMALLOC_START’ undeclared (first use in this function); did you mean ‘VMEMMAP_START’?
 #define VMEMMAP_START (VMALLOC_START - VMEMMAP_SIZE)
                        ^~~~~~~~~~~~~

Fixes: d95f1a542c3d ("RISC-V: Implement sparsemem")
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/pgtable.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 80905b27ee98..4f4162d90586 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -83,6 +83,18 @@ extern pgd_t swapper_pg_dir[];
 #define __S110	PAGE_SHARED_EXEC
 #define __S111	PAGE_SHARED_EXEC
 
+#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
+#define VMALLOC_END      (PAGE_OFFSET - 1)
+#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
+
+#define FIXADDR_TOP      VMALLOC_START
+#ifdef CONFIG_64BIT
+#define FIXADDR_SIZE     PMD_SIZE
+#else
+#define FIXADDR_SIZE     PGDIR_SIZE
+#endif
+#define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
+
 /*
  * Roughly size the vmemmap space to be large enough to fit enough
  * struct pages to map half the virtual address space. Then
@@ -429,18 +441,6 @@ static inline void pgtable_cache_init(void)
 	/* No page table caches to initialize */
 }
 
-#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
-#define VMALLOC_END      (PAGE_OFFSET - 1)
-#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
-
-#define FIXADDR_TOP      VMALLOC_START
-#ifdef CONFIG_64BIT
-#define FIXADDR_SIZE     PMD_SIZE
-#else
-#define FIXADDR_SIZE     PGDIR_SIZE
-#endif
-#define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
-
 /*
  * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
-- 
2.17.1

