Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36766C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F872086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D5+yRbsO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390298AbfFJWQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 18:16:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53590 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390192AbfFJWQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 18:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+l3vwi8bsor/tja9ZheW5y8DiiO/mW8k6zhZ4E83rTI=; b=D5+yRbsO/hXCqiKm2GvUbz94il
        /dNuqNwQmY5OQ3Ooit1Dab7teOpa5SiJPGelycZTu9GahSBTZF7KAFO9aMS7Yo9vzp0wvNnWU2YER
        Jl7nJeGUXhv5mckZ3JshZ19lrBeL58sJoBq2DLT2uxLb8B6TB8Zr9w0Z887+4PacERH+davU/yhMM
        z+BBG3Q5yD28cUJNPYcQRP35undVWKo6/Cex9urNZAd/SsQEgP+rFv9s+c44hRMWRFy/uH1/gXTh3
        XRU+FrgIA9iSjaJISHcDOy2bJYZRaw4jhH+9wiNBGMzFOzx+VmfFWBnSZTanK5IzjjNwXvyb3mhZr
        /l1MDpMg==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haSai-0002vE-Ng; Mon, 10 Jun 2019 22:16:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, uclinux-dev@uclinux.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/17] riscv: use CSR_SATP instead of the legacy sptbr name in switch_mm
Date:   Tue, 11 Jun 2019 00:16:09 +0200
Message-Id: <20190610221621.10938-6-hch@lst.de>
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

Switch to our own constant for the satp register instead of using
the old name from a legacy version of the privileged spec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/mm/context.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 89ceb3cbe218..beeb5d7f92ea 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -57,12 +57,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	cpumask_clear_cpu(cpu, mm_cpumask(prev));
 	cpumask_set_cpu(cpu, mm_cpumask(next));
 
-	/*
-	 * Use the old spbtr name instead of using the current satp
-	 * name to support binutils 2.29 which doesn't know about the
-	 * privileged ISA 1.10 yet.
-	 */
-	csr_write(sptbr, virt_to_pfn(next->pgd) | SATP_MODE);
+	csr_write(CSR_SATP, virt_to_pfn(next->pgd) | SATP_MODE);
 	local_flush_tlb_all();
 
 	flush_icache_deferred(next);
-- 
2.20.1

