Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19614C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9435208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r5n6pCeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfFXFoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 01:44:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfFXFoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4ocWky3c08iK0yepv2gQs0SBg5KjT+xunPaTv4oC5uw=; b=r5n6pCeH/gadzSXK5KdI2Tqxv8
        YODK6eN48ucCegAYBApmU91XF9qDbVsH6tKFA77OewDRe6wqTI7SOkxxGuNy9Sqic+I0WUPShkgI5
        Q1lzoYmneNbpVbOUPj+V3mJQXEi+aDzQsaS8iujdNcz5g+2YOFVvO09khJr31WiotohZZLvZ1sZxX
        Au7/D6AWMmPm2BTMHXivfuRi7XYiZI3SmPmvmgQznl97DnHs/ShMX+Jt4xrDoWzclv6O8NDl/VF15
        MEZtZEouwgD3Ybb8UXfWgU8hWoGgN6ZUV08QMBzBJNpFVg/90QTwtKFUM9bKrgLFEMLNGW7/C5meg
        uw+VkyYQ==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfHln-0006kL-1n; Mon, 24 Jun 2019 05:43:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] riscv: poison SBI calls for M-mode
Date:   Mon, 24 Jun 2019 07:43:07 +0200
Message-Id: <20190624054311.30256-14-hch@lst.de>
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

There is no SBI when we run in M-mode, so fail the compile for any code
trying to use SBI calls.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/sbi.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 21134b3ef404..1e17f07eadaf 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -8,6 +8,7 @@
 
 #include <linux/types.h>
 
+#ifndef CONFIG_M_MODE
 #define SBI_SET_TIMER 0
 #define SBI_CONSOLE_PUTCHAR 1
 #define SBI_CONSOLE_GETCHAR 2
@@ -94,4 +95,5 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 	SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
 }
 
-#endif
+#endif /* CONFIG_M_MODE */
+#endif /* _ASM_RISCV_SBI_H */
-- 
2.20.1

