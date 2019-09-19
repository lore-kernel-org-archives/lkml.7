Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D74C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AD421907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932470;
	bh=TGRMB95YGQkQ03FI3rbztcHl2l8WMOmLww0pLVy6bpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rB6CTEKHBuW4+M0TTwUm0jx2QxI1e5yzfrt0j5QBtOW3JgMBkGlzv3s8Y1BsNjvkf
	 jOU0DsmnaTv6DUfpJEXEdmf3PiQSKf7adJVB6LJmqafiZCY1SwyVCUCxkCQS9sykeT
	 9Y4O+LZgKAsQWfF0ecAMGFJyqJFaBwim5VwbQZmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405478AbfISWJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405454AbfISWJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:09:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5845621D81;
        Thu, 19 Sep 2019 22:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568930974;
        bh=TGRMB95YGQkQ03FI3rbztcHl2l8WMOmLww0pLVy6bpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x7lu99U37UaJvtZLQ711yU0rJFr0nuGETdQtLdTddp96IB/J+OHW5rDiWFEyfJNev
         4ZzEHXQu/qL3CZf/8n3iVibD8t/azWDjy1rArFeJGedbpV6tlLESd/TV6lujK1BMLe
         UHwZQv4JivAy2ZEdfxWHo1IZw5lHWe6ingYcfP9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anup Patel <anup.patel@wdc.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 083/124] RISC-V: Fix FIXMAP area corruption on RV32 systems
Date:   Fri, 20 Sep 2019 00:02:51 +0200
Message-Id: <20190919214822.038690311@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <Anup.Patel@wdc.com>

[ Upstream commit a256f2e329df0773022d28df2c3d206b9aaf1e61 ]

Currently, various virtual memory areas of Linux RISC-V are organized
in increasing order of their virtual addresses is as follows:
1. User space area (This is lowest area and starts at 0x0)
2. FIXMAP area
3. VMALLOC area
4. Kernel area (This is highest area and starts at PAGE_OFFSET)

The maximum size of user space aread is represented by TASK_SIZE.

On RV32 systems, TASK_SIZE is defined as VMALLOC_START which causes the
user space area to overlap the FIXMAP area. This allows user space apps
to potentially corrupt the FIXMAP area and kernel OF APIs will crash
whenever they access corrupted FDT in the FIXMAP area.

On RV64 systems, TASK_SIZE is set to fixed 256GB and no other areas
happen to overlap so we don't see any FIXMAP area corruptions.

This patch fixes FIXMAP area corruption on RV32 systems by setting
TASK_SIZE to FIXADDR_START. We also move FIXADDR_TOP, FIXADDR_SIZE,
and FIXADDR_START defines to asm/pgtable.h so that we can avoid cyclic
header includes.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Tested-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/fixmap.h  |  4 ----
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index c207f6634b91c..15b3edaabc280 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -25,10 +25,6 @@ enum fixed_addresses {
 	__end_of_fixed_addresses
 };
 
-#define FIXADDR_SIZE		(__end_of_fixed_addresses * PAGE_SIZE)
-#define FIXADDR_TOP		(VMALLOC_START)
-#define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)
-
 #define FIXMAP_PAGE_IO		PAGE_KERNEL
 
 #define __early_set_fixmap	__set_fixmap
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index f7c3f7de15f27..e6faa469c133b 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -408,14 +408,22 @@ static inline void pgtable_cache_init(void)
 #define VMALLOC_END      (PAGE_OFFSET - 1)
 #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
 
+#define FIXADDR_TOP      VMALLOC_START
+#ifdef CONFIG_64BIT
+#define FIXADDR_SIZE     PMD_SIZE
+#else
+#define FIXADDR_SIZE     PGDIR_SIZE
+#endif
+#define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
+
 /*
- * Task size is 0x40000000000 for RV64 or 0xb800000 for RV32.
+ * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
  */
 #ifdef CONFIG_64BIT
 #define TASK_SIZE (PGDIR_SIZE * PTRS_PER_PGD / 2)
 #else
-#define TASK_SIZE VMALLOC_START
+#define TASK_SIZE FIXADDR_START
 #endif
 
 #include <asm-generic/pgtable.h>
-- 
2.20.1



