Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DABBC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4396208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gnB13sR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfFXFoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 01:44:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfFXFoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Oojq5kWgKyQ3wQ3E9C05rFdmIhyLa9IRTYHnqrokUgc=; b=gnB13sR18GLBVsZsJwTxXb3EoD
        RRnxn3LyhiZ85fsirsfi0/PTcHqG5BX2kl6hnhlYAvACZsBMRqnU+VN9heGqIyOqfKj4Y+DzHF+qG
        FBpb826uJvdE6kBG30tQDqbcLaDAhuht4VzYt3QALTZCTBJhCAkz8UDaWDpUfi5AIuFQpWwXtxyG6
        YGXhaX2RwwRQHYabQiatM/eh/PDre8svDzJ+cA31dr1wLXLgknNIgtU7bLY+iowRrA+Wj8GYC+7g2
        dPge0M3eqUFDdQ5vFL5GoOX9SQe6x9QwhNG54tBvjS0aGNkmO/ULNw0ib5I6lzxS0y3gwcdSxTuZs
        5QY+sAXg==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfHlx-0006wG-E0; Mon, 24 Jun 2019 05:44:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/17] riscv: clear the instruction cache and all registers when booting
Date:   Mon, 24 Jun 2019 07:43:10 +0200
Message-Id: <20190624054311.30256-17-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624054311.30256-1-hch@lst.de>
References: <20190624054311.30256-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we get booted we want a clear slate without any leaks from previous
supervisors or the firmware.  Flush the instruction cache and then clear
all registers to known good values.  This is really important for the
upcoming nommu support that runs on M-mode, but can't really harm when
running in S-mode either.  Vaguely based on the concepts from opensbi.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/kernel/head.S | 85 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index a4c170e41a34..74feb17737b4 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -11,6 +11,7 @@
 #include <asm/thread_info.h>
 #include <asm/page.h>
 #include <asm/csr.h>
+#include <asm/hwcap.h>
 
 __INIT
 ENTRY(_start)
@@ -19,6 +20,12 @@ ENTRY(_start)
 	csrw CSR_XIP, zero
 
 #ifdef CONFIG_M_MODE
+	/* flush the instruction cache */
+	fence.i
+
+	/* Reset all registers except ra, a0, a1 */
+	call reset_regs
+
 	/*
 	 * The hartid in a0 is expected later on, and we have no firmware
 	 * to hand it to us.
@@ -168,6 +175,84 @@ relocate:
 	j .Lsecondary_park
 END(_start)
 
+#ifdef CONFIG_M_MODE
+ENTRY(reset_regs)
+	li	sp, 0
+	li	gp, 0
+	li	tp, 0
+	li	t0, 0
+	li	t1, 0
+	li	t2, 0
+	li	s0, 0
+	li	s1, 0
+	li	a2, 0
+	li	a3, 0
+	li	a4, 0
+	li	a5, 0
+	li	a6, 0
+	li	a7, 0
+	li	s2, 0
+	li	s3, 0
+	li	s4, 0
+	li	s5, 0
+	li	s6, 0
+	li	s7, 0
+	li	s8, 0
+	li	s9, 0
+	li	s10, 0
+	li	s11, 0
+	li	t3, 0
+	li	t4, 0
+	li	t5, 0
+	li	t6, 0
+	csrw	sscratch, 0
+
+#ifdef CONFIG_FPU
+	csrr	t0, misa
+	andi	t0, t0, (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D)
+	bnez	t0, .Lreset_regs_done
+
+	li	t1, SR_FS
+	csrs	sstatus, t1
+	fmv.s.x	f0, zero
+	fmv.s.x	f1, zero
+	fmv.s.x	f2, zero
+	fmv.s.x	f3, zero
+	fmv.s.x	f4, zero
+	fmv.s.x	f5, zero
+	fmv.s.x	f6, zero
+	fmv.s.x	f7, zero
+	fmv.s.x	f8, zero
+	fmv.s.x	f9, zero
+	fmv.s.x	f10, zero
+	fmv.s.x	f11, zero
+	fmv.s.x	f12, zero
+	fmv.s.x	f13, zero
+	fmv.s.x	f14, zero
+	fmv.s.x	f15, zero
+	fmv.s.x	f16, zero
+	fmv.s.x	f17, zero
+	fmv.s.x	f18, zero
+	fmv.s.x	f19, zero
+	fmv.s.x	f20, zero
+	fmv.s.x	f21, zero
+	fmv.s.x	f22, zero
+	fmv.s.x	f23, zero
+	fmv.s.x	f24, zero
+	fmv.s.x	f25, zero
+	fmv.s.x	f26, zero
+	fmv.s.x	f27, zero
+	fmv.s.x	f28, zero
+	fmv.s.x	f29, zero
+	fmv.s.x	f30, zero
+	fmv.s.x	f31, zero
+	csrw	fcsr, 0
+#endif /* CONFIG_FPU */
+.Lreset_regs_done:
+	ret
+END(reset_regs)
+#endif /* CONFIG_M_MODE */
+
 __PAGE_ALIGNED_BSS
 	/* Empty zero page */
 	.balign PAGE_SIZE
-- 
2.20.1

