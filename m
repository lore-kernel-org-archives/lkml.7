Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3A5C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C094A2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FiFMhsDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbfHMPr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:47:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43298 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfHMPr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pknLE1TtKxJ6/rcx/PvasOsKhUJ+pwFGGkkvEq/kpZA=; b=FiFMhsDCQ0sFT3HotO2BOzXDkc
        4LjNDVOrLDwi6hE8bmpnlyhD931FoOhSSZGBofNzZbnwZiQbeNRvjWOM8d1pknF7vwF/5UykgtX80
        xFuyBLkxgX63jlEqrSYUHN3YGm1yJgyLiVwtQB60FUotxGkJCLUmrMJLDWXHB4mzN2y7ZWpW+uiyA
        OnHK+Xfs2nSPlGx99U2pe12sROiKn4x/jHV+hxY+pzzbnbsf6EEpu+9i63E17XW05i3WieCteAmdu
        POoz6NdzfS9zfZuAZyXLOZ+EkbbJ1ZikA6I26YJIxscFRlgcGRTBVaoFM7ITWf0g3v3X+G6o1e7sY
        Qfa0aggA==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxZ1e-0004ix-Lx; Tue, 13 Aug 2019 15:47:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>
Subject: [PATCH 02/15] riscv: use CSR_SATP instead of the legacy sptbr name in switch_mm
Date:   Tue, 13 Aug 2019 17:47:34 +0200
Message-Id: <20190813154747.24256-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813154747.24256-1-hch@lst.de>
References: <20190813154747.24256-1-hch@lst.de>
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
Reviewed-by: Atish Patra <atish.patra@wdc.com>
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

