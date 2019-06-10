Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44C4C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9041E21721
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DClxskAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390534AbfFJWRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 18:17:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390490AbfFJWRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 18:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4ocWky3c08iK0yepv2gQs0SBg5KjT+xunPaTv4oC5uw=; b=DClxskAqPYBFK2k3TMB5K7R+nZ
        z9U0LsZbiV3WZgHBzl0PPjdk6qWGeEdJiS1YtZ0SKEHrHuRODqonx6dexyzM7838Hd1RDMSO1GsPI
        5EP7DM/TJru3t1osBnbbuJ4pgDh64/bYNN/M2AJKc64NE8wqqi5FwaR8miqqNxK1yv+Nr7ZBLmLGY
        HyrwouU9iQMTFYKtVWSyaDqYnmdvhj3W95zAH6aUxsCJ0wqUzs3dI9TW92uoHJf+tzVaURVvyLntw
        384Ro2sNdxWU/qybRIdirBfbpimN6YNMOLxWG2AwEV39Emf87QmpodZMzd3x4MOix5y77HeGJdgd4
        ow+VBniA==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haSb7-0003jm-Gv; Mon, 10 Jun 2019 22:17:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, uclinux-dev@uclinux.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/17] riscv: poison SBI calls for M-mode
Date:   Tue, 11 Jun 2019 00:16:18 +0200
Message-Id: <20190610221621.10938-15-hch@lst.de>
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

