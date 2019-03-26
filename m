Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A96C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3AB2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msqo3md2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbfCZWuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:50:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46312 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732513AbfCZWuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:50:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id q1so768993pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 15:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xR2fAcbi08dJ1U/q08SNwZuhqDiyYfroDhLUIQLycmU=;
        b=msqo3md2sAcMz6GQ64ybELtPm5q20Ot5oUTlPMh0Oebc+foeYulBl+nKNO+5O8wfNN
         vW16df9fGdyuriIUKnQzh2QYAeA2NtXWiMTYY+q48kxmviKbNHreRXftpGksrMXG7iZL
         xrgiynkXN3R9uy2J7m5IzKws0dim0cKbybsejXhNsybr6ijdzXzF6gN/iQa6uWoB8Hs0
         RSfkbCu4hjBD+mwvaLcyn34KRjI2U61I3efqFXgsrueWydJ7PlRtBsC0AGC7+Sq+vU99
         ZBAHmbX4usg6pB4SNPZaDPE3cFZrd7DNIvHLDkiH3zhnypGs9A64vtHDD1RUuKZRLnvw
         U9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xR2fAcbi08dJ1U/q08SNwZuhqDiyYfroDhLUIQLycmU=;
        b=PJWhLRJvjD2mQqbkIZm93MMKywVVtOG/wdu1b2F/OBxt2mOpW04Sgm2dpS2TnbxaJl
         a8LYz/7UrWfU3eC2hBAXBWL4VqGct/undCyG3wGD8q7nZKKL9qmRflqczfqweXt7NFq3
         uX3/Bqi6iUE8XW2xcGreeMhRT/mMKUUCWDZmhJIqyQLyYZyLhkxd9vUJw8gw8m2z7PiL
         gMY9cPU/e/HBVPnwcVD5bXIER99uFqbW/LH6CygydkALeqSQ652R98Z6z37px640GTxI
         Ibaf1CInlr9PyBFi83nm3YXxQecd3j0b0mW3qxuhCFFgG5YUMsHi9U0r8ivTZ3Zl5iPM
         ZOHA==
X-Gm-Message-State: APjAAAUCJG4eJMs4+So9LudxIaPZV3j0NqqC1ARq/VQiRTg7xgRXPrrS
        h/k1JndJYNLgwO4aysiw/Ok=
X-Google-Smtp-Source: APXvYqxZpKGQj6dfGYHbCUIDZUHCWq8Wq5nlbTjsOZ9r7c3obGfooVatp/mh5wpzMEIihl6DSdIuGw==
X-Received: by 2002:a63:6949:: with SMTP id e70mr31096833pgc.89.1553640613149;
        Tue, 26 Mar 2019 15:50:13 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 8sm56937368pfs.50.2019.03.26.15.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 15:50:12 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, tony@atomide.com
Subject: [PATCH RFC/RFT 5/5] dma-contiguous: Do not allocate a single page from CMA area
Date:   Tue, 26 Mar 2019 15:49:59 -0700
Message-Id: <20190326224959.9656-6-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326224959.9656-1-nicoleotsuka@gmail.com>
References: <20190326224959.9656-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addresses within a single page are always contiguous, so it's
not so necessary to always allocate one single page from CMA area.
Since the CMA area has a limited predefined size of space, it may
run out of space in heavy use cases, where there might be quite a
lot CMA pages being allocated for single pages.

However, there is also a concern that a device might care where a
page comes from -- it might expect the page from CMA area and act
differently if the page doesn't.

This patch tries to skip of one-page size allocations and returns
NULL so as to let callers allocate normal pages unless the device
has its own CMA area. This would save resources from the CMA area
for more CMA allocations. And it'd also reduce CMA fragmentations
resulted from trivial allocations.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 kernel/dma/contiguous.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index b2a87905846d..09074bd04793 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -186,16 +186,32 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
  *
  * This function allocates memory buffer for specified device. It uses
  * device specific contiguous memory area if available or the default
- * global one. Requires architecture specific dev_get_cma_area() helper
- * function.
+ * global one.
+ *
+ * However, it skips one-page size of allocations from the global area.
+ * As the addresses within one page are always contiguous, so there is
+ * no need to waste CMA pages for that kind; it also helps reduce the
+ * fragmentations in the CMA area. So a caller should be the rebounder
+ * in such case to allocate a normal page upon NULL return value.
+ *
+ * Requires architecture specific dev_get_cma_area() helper function.
  */
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 				       unsigned int align, bool no_warn)
 {
+	struct cma *cma;
+
 	if (align > CONFIG_CMA_ALIGNMENT)
 		align = CONFIG_CMA_ALIGNMENT;
 
-	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
+	if (dev && dev->cma_area)
+		cma = dev->cma_area;
+	else if (count > 1)
+		cma = dma_contiguous_default_area;
+	else
+		return NULL;
+
+	return cma_alloc(cma, count, align, no_warn);
 }
 
 /**
-- 
2.17.1

