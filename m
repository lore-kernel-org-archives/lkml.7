Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA7EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78B123774
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pdmx9KoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfICJdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:33:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57362 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfICJdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5Q8lZON7PHXLo9s0eo0DiHQm7hbQiEJjd1r4/mRBF0Y=; b=Pdmx9KoT48xfKta6LsUt0JguPn
        z2z6BtnoXF/IYYwNVXfM+1c/a2DDlhJCEs5IfU+GSyZWa15X56b5LHDLcI0zHVniMhHdurgMjbfZo
        MTUJAwWRi4SyH2f7QaCp5AnysdjUOqd80JoXakl9h/6x5NiKHRoGUebR7aK6L5u0XEvYKYJGLulRj
        RwHoGcHfGhGULf5Ti0ekLD3vf+nIvsTbyXK4sRV9SdEhBz0hsFusTZ/iDaBbNJeiwX+BlhZmPwsDi
        C/cT9R8seYPDSS1FthaoGgCzQD6KySRUHYl25A8jmWrNp5CmaJwOu82Vi5lj7OFzPT1GIalY3xZRk
        fQxb2Rfg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i55BQ-0004cN-U0; Tue, 03 Sep 2019 09:33:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/20] riscv: poison SBI calls for M-mode
Date:   Tue,  3 Sep 2019 11:32:29 +0200
Message-Id: <20190903093239.21278-11-hch@lst.de>
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

There is no SBI when we run in M-mode, so fail the compile for any code
trying to use SBI calls.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/sbi.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 21134b3ef404..b167af3e7470 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -8,6 +8,7 @@
 
 #include <linux/types.h>
 
+#ifdef CONFIG_RISCV_SBI
 #define SBI_SET_TIMER 0
 #define SBI_CONSOLE_PUTCHAR 1
 #define SBI_CONSOLE_GETCHAR 2
@@ -93,5 +94,5 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 {
 	SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
 }
-
-#endif
+#endif /* CONFIG_RISCV_SBI */
+#endif /* _ASM_RISCV_SBI_H */
-- 
2.20.1

