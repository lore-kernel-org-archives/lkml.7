Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B19C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A03E208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HYzdqScq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390512AbfFJWRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 18:17:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55730 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390378AbfFJWRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 18:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QKrZKqm9xX7/gKntli3kjDV0bZW8VwVWFoBUswi6ZbI=; b=HYzdqScqmkY7UiWle5zIbeTQxB
        xAaMr/ZfGK4+A4BsJ5aOUoSPqE28fsB+yMZOlybdB1UXrqELmw+bYb4UkDygioEZJLyLXzSwu5b9T
        RR3p1S0mfl5j4HUD5uC7CVBybbIA70S1ijnk2verWrm7Kv+GloqVOyxM0s6R8ttKoZ5gVXgqe+0GW
        G8CVSJ8/f8L3eNpcK7/RXE+2tTBTpjjHMSHnXuvHBrLtpcjJ3j0GVBhVwxnb2HU3xQpytpJg5wQ7i
        AgQEsDxj3AVOp2HN3Mx75AHv9Ot77lIpZcF79Vptpno7EtiUhExdJ63JzCYn/We9DAD4KLv90G55B
        M8X8Gapw==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haSb4-0003fy-NB; Mon, 10 Jun 2019 22:16:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, uclinux-dev@uclinux.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] riscv: implement remote sfence.i natively for M-mode
Date:   Tue, 11 Jun 2019 00:16:17 +0200
Message-Id: <20190610221621.10938-14-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610221621.10938-1-hch@lst.de>
References: <20190610221621.10938-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V ISA only supports flushing the instruction cache for the local
CPU core.  For normal S-mode Linux remote flushing is offloaded to
machine mode using ecalls, but for M-mode Linux we'll have to do it
ourselves.  Use the same implementation as all the existing open source
SBI implementations by just doing an IPI to all remote cores to execute
th sfence.i instruction on every live core.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/mm/cacheflush.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 9ebcff8ba263..10875ea1065e 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -10,10 +10,35 @@
 
 #include <asm/sbi.h>
 
+#ifdef CONFIG_M_MODE
+static void ipi_remote_fence_i(void *info)
+{
+	return local_flush_icache_all();
+}
+
+void flush_icache_all(void)
+{
+	on_each_cpu(ipi_remote_fence_i, NULL, 1);
+}
+
+static void flush_icache_cpumask(const cpumask_t *mask)
+{
+	on_each_cpu_mask(mask, ipi_remote_fence_i, NULL, 1);
+}
+#else /* CONFIG_M_MODE */
 void flush_icache_all(void)
 {
 	sbi_remote_fence_i(NULL);
 }
+static void flush_icache_cpumask(const cpumask_t *mask)
+{
+	cpumask_t hmask;
+
+	cpumask_clear(&hmask);
+	riscv_cpuid_to_hartid_mask(mask, &hmask);
+	sbi_remote_fence_i(hmask.bits);
+}
+#endif /* CONFIG_M_MODE */
 
 /*
  * Performs an icache flush for the given MM context.  RISC-V has no direct
@@ -28,7 +53,7 @@ void flush_icache_all(void)
 void flush_icache_mm(struct mm_struct *mm, bool local)
 {
 	unsigned int cpu;
-	cpumask_t others, hmask, *mask;
+	cpumask_t others, *mask;
 
 	preempt_disable();
 
@@ -47,9 +72,7 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 	cpumask_andnot(&others, mm_cpumask(mm), cpumask_of(cpu));
 	local |= cpumask_empty(&others);
 	if (mm != current->active_mm || !local) {
-		cpumask_clear(&hmask);
-		riscv_cpuid_to_hartid_mask(&others, &hmask);
-		sbi_remote_fence_i(hmask.bits);
+		flush_icache_cpumask(&others);
 	} else {
 		/*
 		 * It's assumed that at least one strongly ordered operation is
-- 
2.20.1

