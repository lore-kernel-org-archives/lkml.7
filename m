Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD23C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7302339D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hVazFovX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfICJdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:33:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbfICJda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ggo+8/xZL6xILiAii0UBGQ2U/BF9CVjl/pCCREz3GgU=; b=hVazFovXXDq3hCC1hnliHOrZdw
        VK+YZSRfrDwzs4u9Jm+NXWxrJ2yfrY0S1KWq72UboNlKKw3RUlO6Wlu6YJ+v1HtwSrtuhNVcW7a7k
        cBegBWFBRCleqix2OwgP9j/xT8hbU8YmqJZICM0TITAHWYYM3CvPJYZ2SGKVFCTl5ARBohK/O1hd8
        BT9fqrmw5zuL7fV2XhiBeyiDuS6Wuz2mj/E3VtLY8iKQvzpssWCoW0X0mi3rNdARvvqKzlOJxH0KE
        gErhZXlE3p4LZTRHBfMecnAfEIRqbo+HODiMX0xI3nRsk/Aetlfa6BwP90MqTdxeZW9WNwFX5K6dM
        ipD3BY8Q==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i55Bl-0004sW-0X; Tue, 03 Sep 2019 09:33:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/20] riscv: clear the instruction cache and all registers when booting
Date:   Tue,  3 Sep 2019 11:32:36 +0200
Message-Id: <20190903093239.21278-18-hch@lst.de>
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

When we get booted we want a clear slate without any leaks from previous
supervisors or the firmware.  Flush the instruction cache and then clear
all registers to known good values.  This is really important for the
upcoming nommu support that runs on M-mode, but can't really harm when
running in S-mode either.  Vaguely based on the concepts from opensbi.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/csr.h |  1 +
 arch/riscv/kernel/head.S     | 88 +++++++++++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index d0b5113e1a54..ee0101278608 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -83,6 +83,7 @@
 /* symbolic CSR names: */
 #define CSR_MHARTID		0xf14
 #define CSR_MSTATUS		0x300
+#define CSR_MISA		0x301
 #define CSR_MIE			0x304
 #define CSR_MTVEC		0x305
 #define CSR_MSCRATCH		0x340
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index e0350499d7a4..93b369342042 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -11,6 +11,7 @@
 #include <asm/thread_info.h>
 #include <asm/page.h>
 #include <asm/csr.h>
+#include <asm/hwcap.h>
 #include <asm/image.h>
 
 __INIT
@@ -51,12 +52,18 @@ _start_kernel:
 	csrw CSR_XIP, zero
 
 #ifdef CONFIG_RISCV_M_MODE
+	/* flush the instruction cache */
+	fence.i
+
+	/* Reset all registers except ra, a0, a1 */
+	call reset_regs
+
 	/*
 	 * The hartid in a0 is expected later on, and we have no firmware
 	 * to hand it to us.
 	 */
 	csrr a0, CSR_MHARTID
-#endif
+#endif /* CONFIG_RISCV_M_MODE */
 
 	/* Load the global pointer */
 .option push
@@ -201,6 +208,85 @@ relocate:
 	j .Lsecondary_park
 END(_start)
 
+#ifdef CONFIG_RISCV_M_MODE
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
+	csrr	t0, CSR_MISA
+	andi	t0, t0, (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D)
+	bnez	t0, .Lreset_regs_done
+
+	li	t1, SR_FS
+	csrs	CSR_XSTATUS, t1
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
+	/* note that the caller must clear SR_FS */
+#endif /* CONFIG_FPU */
+.Lreset_regs_done:
+	ret
+END(reset_regs)
+#endif /* CONFIG_RISCV_M_MODE */
+
 __PAGE_ALIGNED_BSS
 	/* Empty zero page */
 	.balign PAGE_SIZE
-- 
2.20.1

