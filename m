Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F42CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A17214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BqHa/HYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfJ1MLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:11:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388833AbfJ1MLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FfHTH2MzgCNMlB911N0xzbdycSELsFzQxnUpR37uB5E=; b=BqHa/HYYU8hKVBJPG41y6F4nqW
        YinPjxgFg1YcCPurdSskPQgeokypK0qqENAVm6Uu0HLmyCe/zRi15vhNzeACnmnhShbsIwUQ52cgP
        Ev27azsmorlxDX4rWgfrL2Kq6jq3IcNMSMStprKyxBYFqGBJ9v9Jl2nrWNLwTPb+Or07MjSipVTVZ
        QrBYlDZ90YQR9fZKUKv6f3ulmAbIUsEAvNFgrUwDVAvKeLjvOhE1HaQAexoTQVu6fk+Xekc0k6gFh
        lBD7OyDLUEQoP65A1jOHLZCDxUth6+P4BeCW80eKB+O3nag6Spz8MrHhGNP6domEgmNeg1d8XBEUz
        TDiBfaog==;
Received: from [2001:4bb8:18c:c7d:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP3rP-0006kB-Ka; Mon, 28 Oct 2019 12:11:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH 05/12] riscv: implement remote sfence.i using IPIs
Date:   Mon, 28 Oct 2019 13:10:36 +0100
Message-Id: <20191028121043.22934-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028121043.22934-1-hch@lst.de>
References: <20191028121043.22934-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V ISA only supports flushing the instruction cache for the
local CPU core.  Currently we always offload the remote TLB flushing to
the SBI, which then issues an IPI under the hoods.  But with M-mode
we do not have an SBI so we have to do it ourselves.   IPI to the
other nodes using the existing kernel helpers instead if we have
native clint support and thus can IPI directly from the kernel.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/sbi.h |  3 +++
 arch/riscv/mm/cacheflush.c   | 24 ++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index b167af3e7470..0cb74eccc73f 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -94,5 +94,8 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 {
 	SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
 }
+#else /* CONFIG_RISCV_SBI */
+/* stub to for code is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
+void sbi_remote_fence_i(const unsigned long *hart_mask);
 #endif /* CONFIG_RISCV_SBI */
 #endif /* _ASM_RISCV_SBI_H */
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 3f15938dec89..794c9ab256eb 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -10,9 +10,17 @@
 
 #include <asm/sbi.h>
 
+static void ipi_remote_fence_i(void *info)
+{
+	return local_flush_icache_all();
+}
+
 void flush_icache_all(void)
 {
-	sbi_remote_fence_i(NULL);
+	if (IS_ENABLED(CONFIG_RISCV_SBI))
+		sbi_remote_fence_i(NULL);
+	else
+		on_each_cpu(ipi_remote_fence_i, NULL, 1);
 }
 
 /*
@@ -28,7 +36,7 @@ void flush_icache_all(void)
 void flush_icache_mm(struct mm_struct *mm, bool local)
 {
 	unsigned int cpu;
-	cpumask_t others, hmask, *mask;
+	cpumask_t others, *mask;
 
 	preempt_disable();
 
@@ -46,10 +54,7 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 	 */
 	cpumask_andnot(&others, mm_cpumask(mm), cpumask_of(cpu));
 	local |= cpumask_empty(&others);
-	if (mm != current->active_mm || !local) {
-		riscv_cpuid_to_hartid_mask(&others, &hmask);
-		sbi_remote_fence_i(hmask.bits);
-	} else {
+	if (mm == current->active_mm && local) {
 		/*
 		 * It's assumed that at least one strongly ordered operation is
 		 * performed on this hart between setting a hart's cpumask bit
@@ -59,6 +64,13 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 		 * with flush_icache_deferred().
 		 */
 		smp_mb();
+	} else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
+		cpumask_t hartid_mask;
+
+		riscv_cpuid_to_hartid_mask(&others, &hartid_mask);
+		sbi_remote_fence_i(cpumask_bits(&hartid_mask));
+	} else {
+		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
 	}
 
 	preempt_enable();
-- 
2.20.1

