Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5F0C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2D5218C3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="do1Mrgmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfDWQba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:31:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45624 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbfDWQb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0RFKXT+769rKHtvqN8mP3Igw2OsH7+hhKlZxW0exa+0=; b=do1MrgmothI00rTmttfcC5nqz8
        ce9dzfOZr+FRYZ0pywXANatw78c7kIjjC0iiz04EQ9Kf1b8de0FJAhuauuyyIPUgnGdk35qATk+zU
        NuwoFd9jsyGSUg7sVmmVXnTQDH6pg8UbW3K3yuU2XJ8l6aFR6K8tGPwZcPa7hY1sdGFUdwR7XiuI5
        K/MgyL8oaFWvkxmF2SaSdtwiImI8CtcTgLb1GqI5Nm7Q/qFQGyKHBj/eYjUPtff9t/qolPKJVTIKx
        ihjlJG66YS3Cs4dv5xQw6zikxBBIdQPQAFQNo1WPkayM7nYtBPo/Awb8o+0Nj9t4E1JHqAxGTKIiY
        YvPFqmEg==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIyKN-00042B-Sg; Tue, 23 Apr 2019 16:31:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: provide a print_vma_addr stub for !CONFIG_MMU
Date:   Tue, 23 Apr 2019 18:30:58 +0200
Message-Id: <20190423163059.8820-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423163059.8820-1-hch@lst.de>
References: <20190423163059.8820-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6b10c21630f5..969185079ae4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2676,7 +2676,13 @@ extern int randomize_va_space;
 #endif
 
 const char * arch_vma_name(struct vm_area_struct *vma);
+#ifdef CONFIG_MMU
 void print_vma_addr(char *prefix, unsigned long rip);
+#else
+static inline void print_vma_addr(char *prefix, unsigned long rip)
+{
+}
+#endif
 
 void *sparse_buffer_alloc(unsigned long size);
 struct page *sparse_mem_map_populate(unsigned long pnum, int nid,
-- 
2.20.1

