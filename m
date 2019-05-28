Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77F3C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E582075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Y4ConJGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfE1VbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:31:03 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44051 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfE1VbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:31:03 -0400
Received: by mail-qk1-f193.google.com with SMTP id w187so61886qkb.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 14:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WaEhEdCDX7uVq9EdlB8MxNmxyl6leWtk/aFuLl2SSoI=;
        b=Y4ConJGHbioYv9N8Mp37Mj8nKajpa5ftjec2jpdjMUbE27zB3Tu7iMV1rU3diBPTtJ
         M8VPPdZZogxpMM7rutYD3+rpwFECxAYTGVoAjXcIUtqaQjdlLUbzSRbbRh+Z7t0xlDd6
         EcxoA1KiFZKpjVfAas/YfbwO0+IpPbLqlbnhGL7UlP5cJdXcmF98E7M7ScQPtCpj02qh
         4u+A45QoHERFkt1mES+PfsKkbzkFct8oYodaFXg4b6H6rTC9cNjE1rodn7BxT+HAH1fW
         PA9Mgm+QPz8NRecEbMvD9qIJT/RI7ToVft4fSarxQ9hDovoTYpnkNFco6/p3jlyh3kYh
         l/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WaEhEdCDX7uVq9EdlB8MxNmxyl6leWtk/aFuLl2SSoI=;
        b=adEzX/myYzCqUJLywZMdCtcAaV05tZ9YbxGCMRjrLjts32cFB/J206VgwhjT8t2n+D
         poyHif0cVU0/9kigVHwHOUCixH1XCqtAR+GAyDkUGhBmxLREYt1koD3ZdFcPizbJVYnq
         80V06/YZKYZfCoAFLbhovaDJLs07SVThj/T2eetImmjtn7sseimPkkxpGTulA4BKh4Ru
         RuGnBSqY08l9sQxzCCK6NMlje1jRb1TcEBCvu6NcRwkvLJcZK5U5WxkubHaNVLpAxusG
         BS5r3oWUi9k2YpZYaRx0SDqq0kJdS5QI/4e0VkT0Dc5XlCFTlTTNK0VJbpKfg1jJI3TI
         Qb7Q==
X-Gm-Message-State: APjAAAXI+CUONm7B+D5CYmQkWbndwFj2FAy7Rl1kMxP1I0HIwdt7a5tg
        /SkkVSbvHX/XRb7suUFzoEemhEser5E=
X-Google-Smtp-Source: APXvYqxV1hnwlMudTqV/qXWNvA3YNO35Xwlomr1L0uUD4+Itqbe5e4yQQHoskQMtRgPPNjLXahIUOQ==
X-Received: by 2002:a37:a854:: with SMTP id r81mr12066985qke.53.1559079062257;
        Tue, 28 May 2019 14:31:02 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 6sm4669423qtt.72.2019.05.28.14.31.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 14:31:01 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     jroedel@suse.de
Cc:     akpm@linux-foundation.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] dma: replace single-char identifiers in macros
Date:   Tue, 28 May 2019 17:30:41 -0400
Message-Id: <1559079041-525-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few macros in DMA have single-char identifiers make the code
hard to read. Replace them with meaningful names.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/linux/dma-mapping.h | 24 ++++++++++++++++--------
 include/linux/dmar.h        | 14 ++++++++------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 6309a721394b..2f0151dcfa4e 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -602,14 +602,22 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
 	return dma_sync_single_for_device(dev, addr + offset, size, dir);
 }
 
-#define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
-#define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
-#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
-#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
-#define dma_map_page(d, p, o, s, r) dma_map_page_attrs(d, p, o, s, r, 0)
-#define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
-#define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, 0)
-#define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, 0)
+#define dma_map_single(dev, ptr, size, direction)			\
+	dma_map_single_attrs(dev, ptr, size, direction, 0)
+#define dma_unmap_single(dev, addr, size, direction)			\
+	dma_unmap_single_attrs(dev, addr, size, direction, 0)
+#define dma_map_sg(dev, sg, mapped_ents, direction)			\
+	dma_map_sg_attrs(dev, sg, mapped_ents, direction, 0)
+#define dma_unmap_sg(dev, sg, mapped_ents, direction)			\
+	dma_unmap_sg_attrs(dev, sg, mapped_ents, direction, 0)
+#define dma_map_page(dev, page, offset, size, direction)		\
+	dma_map_page_attrs(dev, page, offset, size, direction, 0)
+#define dma_unmap_page(dev, addr, size, direction)			\
+	dma_unmap_page_attrs(dev, addr, size, direction, 0)
+#define dma_get_sgtable(dev, sgt, cpu_addr, dma_addr, size)		\
+	dma_get_sgtable_attrs(dev, sgt, cpu_addr, dma_addr, size, 0)
+#define dma_mmap_coherent(dev, vma, cpu_addr, dma_addr, size)		\
+	dma_mmap_attrs(dev, vma, cpu_addr, dma_addr, size, 0)
 
 extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index f8af1d770520..eb634912f475 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -104,12 +104,14 @@ static inline bool dmar_rcu_check(void)
 
 #define	dmar_rcu_dereference(p)	rcu_dereference_check((p), dmar_rcu_check())
 
-#define	for_each_dev_scope(a, c, p, d)	\
-	for ((p) = 0; ((d) = (p) < (c) ? dmar_rcu_dereference((a)[(p)].dev) : \
-			NULL, (p) < (c)); (p)++)
-
-#define	for_each_active_dev_scope(a, c, p, d)	\
-	for_each_dev_scope((a), (c), (p), (d))	if (!(d)) { continue; } else
+#define for_each_dev_scope(devs, cnt, i, tmp)				\
+	for ((i) = 0; ((tmp) = (i) < (cnt) ?				\
+	    dmar_rcu_dereference((devs)[(i)].dev) : NULL, (i) < (cnt)); \
+	    (i)++)
+
+#define for_each_active_dev_scope(devs, cnt, i, tmp)			\
+	for_each_dev_scope((devs), (cnt), (i), (tmp))			\
+		if (!(tmp)) { continue; } else
 
 extern int dmar_table_init(void);
 extern int dmar_dev_scope_init(void);
-- 
1.8.3.1

