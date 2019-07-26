Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A12FC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAC321994
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9SlUFOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfGZTd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:33:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45613 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfGZTdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:33:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id y8so25125268plr.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TpPvdGCU8noa4Jqc2KHUjp/D6aKm3AR84jtlXgE+aTU=;
        b=Q9SlUFOro0K20c4R1F0KqndmNFUcWEy4Ot9QJf5ZVVDRZnmKezvhT9ll8C8BuiviOn
         WO7NJyL+8Wwwv7glpLkYlQ8CVJ3sHJil4u927cjQ66afGuzmLpQ9xvTfGlZYOaumUoMZ
         oCYZcCxUfuNkoBJOG9Le8eCLlkTOonCQUsonYFTY/4JWQZGQp5zcfarlrEw93fGL9nh+
         7BTt8upu6AczH11S5r3cE8ORmsYk5ydsN9f2ht0k+GJc5AuMrVz5o479WIlnYVAqiGvD
         LLDlNw6j98gXabcmhY/As+N2HwhrAXfCMyfZGKwc81ZxQam6D0Yb5kL/8qQxVwfaNtTq
         Q6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TpPvdGCU8noa4Jqc2KHUjp/D6aKm3AR84jtlXgE+aTU=;
        b=p8jZCV0ndLBgYot3GKb1xFEvFgoT72b3bT7IUO+kU2DHr4dVTo55ch/shZIuDilFwO
         38LNpaKFCTbZkwchfGLZWjVdf75g/wCX4//ig7LjGDMiPkvoQa9W2yXi+wH44h0V1SRu
         /qRVzfk9F0HF5UO2UD90hPFzUzBUhiTkANpQuk1hf7yXtzWxUX19QV/UqzHDrGxMfzSE
         wv5jUx3CASpM+fPKdsIExoZjxOWp93b1LJMW0phbt5lu/Y+tnoIoJYSQDrcU/GWrry5k
         1dFRxOYXOAwbCIVi3XmcVGDu4LhHBIa/7sgGvX8ZZ5YOohwp1ob0bKpYW2WXrBvfVWki
         XdbQ==
X-Gm-Message-State: APjAAAUWaHvakzE41Q9e+MFYa/MtSCXFvXPNQnou2Tu/Wv3ByvZCMMcw
        KJOLw0odISDWG5wguFJJbPY=
X-Google-Smtp-Source: APXvYqzjmBuivtSTxSAMgxOo+MZv7QN75d1Ch6hvJ7R2s3ZcyIPZGfSs50w+j07CMDSQ0OlPPv68rw==
X-Received: by 2002:a17:902:bf09:: with SMTP id bi9mr91912022plb.143.1564169632450;
        Fri, 26 Jul 2019 12:33:52 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e189sm31824212pgc.15.2019.07.26.12.33.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 12:33:52 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     dafna.hirschfeld@collabora.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dma-contiguous: page-align the size in dma_free_contiguous()
Date:   Fri, 26 Jul 2019 12:34:33 -0700
Message-Id: <20190726193433.12000-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726193433.12000-1-nicoleotsuka@gmail.com>
References: <20190726193433.12000-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the original dma_direct_alloc_pages() code:
{
	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;

	if (!dma_release_from_contiguous(dev, page, count))
		__free_pages(page, get_order(size));
}

The count parameter for dma_release_from_contiguous() was page
aligned before the right-shifting operation, while the new API
dma_free_contiguous() forgets to have PAGE_ALIGN() at the size.

So this patch simply adds it to prevent any corner case.

Fixes: fdaeec198ada ("dma-contiguous: add dma_{alloc,free}_contiguous() helpers")
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/contiguous.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index ea8259f53eda..2bd410f934b3 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -267,7 +267,8 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
  */
 void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
 {
-	if (!cma_release(dev_get_cma_area(dev), page, size >> PAGE_SHIFT))
+	if (!cma_release(dev_get_cma_area(dev), page,
+			 PAGE_ALIGN(size) >> PAGE_SHIFT))
 		__free_pages(page, get_order(size));
 }
 
-- 
2.17.1

