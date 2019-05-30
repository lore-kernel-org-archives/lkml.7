Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962F1C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 00:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B88243BD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 00:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnIAhEAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfE3Azi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 20:55:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40927 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3Azi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 20:55:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id d30so911224pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 17:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=j+S8VH4EYGO4/qvjEKOLjTRlvJPXtPKggpnmCuwYCJk=;
        b=hnIAhEAw1B8+HSc8nBdWkvnzdk8JnD7G3XYLuJBXKpPwdofWkmlKry4oTqv+eCRfIw
         AWVq6NO+DTSJFdxnY24J3LI/0pjWkRqZltSgfEVJh1yFk43ZkCkn/f9f0mrxFH9G2fqT
         bxS3d0SymmwS0yM/8EwfMgyB2TVJPRmiBTyVAVpOl9Xqz/xSiZC5G1BadL+K10JCniUu
         yxIXfVwptGqpPMKI6Gu2mhgCQyTZfQ7VIdV/+jUWW/QTyKXu0nsXsRiJgAZPIYjm55O2
         ZpEmUrzUwfGMhn82kpSq98ms7bPhVYvIMWvn8s7kXolT63MjlLDfSl/GKRXEGet7pG4D
         Wurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j+S8VH4EYGO4/qvjEKOLjTRlvJPXtPKggpnmCuwYCJk=;
        b=FCo3GkHM5mEAfCKeImWgkRy5SpsW9Eq1cT/6JVGdnCb5byCAO+xhjniq6uVk/tjgxy
         CbHFrcc3a5cbl9AvZJq1nBWtTPfQmd6tn3Gn4Tglw7KvPDWZUFyafRHqiDhb4aGjLmD5
         hOC8IvzQOFB+XbQs5k/kxOY4xHf8Oi/y8a66x6szWfREpbb3DPbTYSJENQ/wd7sdoxds
         Xil5TgyVWQva7NVePbuv9PZUEA2cetSKYWQwih/SIyZ+aG6o0jjTh1gBo7n/pfTudMnP
         fnn3gdSeqyvz10dSUzM7GP1CD1IXc/V0S7/MaFwmRizOVIgZ6UZDW+xVj9f3WBeaiTU1
         cHVQ==
X-Gm-Message-State: APjAAAUzTOAIg6gwBPhntYSZDoMB6aVKLLf4Y7oFxgqV9utW0djeNMD9
        s2bTx/isQpjqqnrI06f15dU=
X-Google-Smtp-Source: APXvYqxtuX8YgbcCnGunpbCj925iJH5WENQwQbWXCUKu3KUBzqJBUASxoDUJLPWti79LI/QU+rkNGg==
X-Received: by 2002:a62:5103:: with SMTP id f3mr684368pfb.146.1559177737572;
        Wed, 29 May 2019 17:55:37 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id l12sm490223pgq.26.2019.05.29.17.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 17:55:37 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com, m.szyprowski@samsung.com,
        natechancellor@gmail.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com,
        joro@8bytes.org, dwmw2@infradead.org, tony@atomide.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com,
        wsa+renesas@sang-engineering.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        dann.frazier@canonical.com
Subject: [PATCH] dma-contiguous: Fix !CONFIG_DMA_CMA version of dma_{alloc,free}_contiguous()
Date:   Wed, 29 May 2019 17:54:25 -0700
Message-Id: <20190530005425.7184-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fdaeec198ada ("dma-contiguous: add dma_{alloc,free}_contiguous()
helpers") adds a pair of new helper functions so as to abstract code in
the dma-direct (and other places in the future), however it breaks QEMU
boot feature using x86_64 defconfig.

That's because x86_64 defconfig has CONFIG_DMA_CMA=n so those two newly
introduced helper functions are empty in their !CONFIG_DMA_CMA version,
while previously the platform independent dma-direct code had fallback
alloc_pages_node() and __free_pages().

So this patch fixes it by adding alloc_pages_node() and __free_pages()
in the !CONFIG_DMA_CMA version of the two helper functions.

Tested with below QEMU command:
  qemu-system-x86_64 -m 512m \
      -drive file=images/x86_64/rootfs.ext4,format=raw,if=ide \
      -append 'console=ttyS0 root=/dev/sda' -nographic \
      -kernel arch/x86_64/boot/bzImage

with the rootfs from the below link:
  https://github.com/ClangBuiltLinux/continuous-integration/raw/master/images/x86_64/rootfs.ext4

Fixes: fdaeec198ada ("dma-contiguous: add dma_{alloc,free}_contiguous() helpers")
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 include/linux/dma-contiguous.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index 428f3b7b1c42..c05d4e661489 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -50,6 +50,7 @@
 #ifdef __KERNEL__
 
 #include <linux/device.h>
+#include <linux/mm.h>
 
 struct cma;
 struct page;
@@ -155,15 +156,20 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
 	return false;
 }
 
+/* Use fallback alloc() and free() when CONFIG_DMA_CMA=n */
 static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
 		gfp_t gfp)
 {
-	return NULL;
+	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
+	size_t align = get_order(PAGE_ALIGN(size));
+
+	return alloc_pages_node(node, gfp, align);
 }
 
 static inline void dma_free_contiguous(struct device *dev, struct page *page,
 		size_t size)
 {
+	__free_pages(page, get_order(size));
 }
 
 #endif
-- 
2.17.1

