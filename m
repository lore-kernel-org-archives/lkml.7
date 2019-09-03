Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838A6C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5751622D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P1oBBtns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfICJc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:32:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56380 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbfICJcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Zf8uC4BpoAEZ0vekk3VAeUa/YfaPmpYKl4FzjvT/7zY=; b=P1oBBtns5jh3Kx3ti7BeZ/17qp
        miaM0mGy/J/AGScDYmad9wo0eaTq0iK0Lhf2Bl9hZdGSoTOvjGqmSae5y/RJS/xfnhan+kPAdK6X9
        aXwoOQd9KpwBtej7u5+46u9ZG7UxNhKou+efqOvl2nc7gNjaPluuV0JckRzqqtdYIsxi0c7ko1409
        QjdgE7VUBE7E3nTnKWnR+ITqxf8edFWNZi4N6gxjD7w/Dpa41tbNOqva9nnxUeRD3JO00SRSHBoAj
        wb6SzH/jD7k/uly7Gt/GVSZhcrWneVVXqLHmr+0rBVY7SZAHOxWLVODr84zNVWKbDuI5Dyn4+x1dv
        3KyxZjow==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i55BE-0004P4-OW; Tue, 03 Sep 2019 09:32:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>
Subject: [PATCH 05/20] riscv: cleanup riscv_cpuid_to_hartid_mask
Date:   Tue,  3 Sep 2019 11:32:24 +0200
Message-Id: <20190903093239.21278-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903093239.21278-1-hch@lst.de>
References: <20190903093239.21278-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the initial clearing of the mask from the callers to
riscv_cpuid_to_hartid_mask, and remove the unused !CONFIG_SMP stub.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/smp.h      | 6 ------
 arch/riscv/include/asm/tlbflush.h | 1 -
 arch/riscv/kernel/smp.c           | 1 +
 arch/riscv/mm/cacheflush.c        | 1 -
 4 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index c6ed4d691def..a83451d73a4e 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -61,11 +61,5 @@ static inline unsigned long cpuid_to_hartid_map(int cpu)
 	return boot_cpu_hartid;
 }
 
-static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
-					      struct cpumask *out)
-{
-	cpumask_set_cpu(cpuid_to_hartid_map(0), out);
-}
-
 #endif /* CONFIG_SMP */
 #endif /* _ASM_RISCV_SMP_H */
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 4d9bbe8438bf..df31fe2ed09c 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -47,7 +47,6 @@ static inline void remote_sfence_vma(struct cpumask *cmask, unsigned long start,
 {
 	struct cpumask hmask;
 
-	cpumask_clear(&hmask);
 	riscv_cpuid_to_hartid_mask(cmask, &hmask);
 	sbi_remote_sfence_vma(hmask.bits, start, size);
 }
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index a3715d621f60..3836760d7aaf 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -56,6 +56,7 @@ void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)
 {
 	int cpu;
 
+	cpumask_clear(out);
 	for_each_cpu(cpu, in)
 		cpumask_set_cpu(cpuid_to_hartid_map(cpu), out);
 }
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 9ebcff8ba263..3f15938dec89 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -47,7 +47,6 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 	cpumask_andnot(&others, mm_cpumask(mm), cpumask_of(cpu));
 	local |= cpumask_empty(&others);
 	if (mm != current->active_mm || !local) {
-		cpumask_clear(&hmask);
 		riscv_cpuid_to_hartid_mask(&others, &hmask);
 		sbi_remote_fence_i(hmask.bits);
 	} else {
-- 
2.20.1

