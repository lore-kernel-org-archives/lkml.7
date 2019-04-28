Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03054C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 23:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B5E20675
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 23:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="D9YnoNnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfD1Xrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 19:47:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43285 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfD1Xrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 19:47:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id j20so7595285edq.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 16:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id;
        bh=bXeviVN/ZLMlwpdgsgv+FliQqyuSE4iSxUS5o6dbCfo=;
        b=D9YnoNndfaQcnsCQdsyY3nJ6b8HcYhha7zzeQlvqDnrDQo+0v61hKiHYppvNtj38D9
         Se/83ut/iOtHQXlukQZdR/26XukjBlApoF8Akjh5aJP6Qj6NJXqD9WrYqvoyxIJVGk0/
         HwgHzJ4KEtGIdUvYgNGQRgeOcyTqf9dTSc/Aqd8es1dv8BZ7Ayknegb135B7Uun+bcVJ
         IB6Q2XLNYUJsODpHOU7l+uPiMMo1L5P7MMgDdxm98UO8r65/aXNW3NLP8dQyPPQQAbCF
         EAn2pqqkTpewU4/07j5fRPAJfJjt7PifUGQlRqKIl9gEQ0iGEfr51iW0guu1e7znLoDP
         lx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bXeviVN/ZLMlwpdgsgv+FliQqyuSE4iSxUS5o6dbCfo=;
        b=k5ZTBwE4dm2AG+wsHc9z3/2syac3GgDmccKcd+TX3RTtHwkMmy3I7IUOj1dOEVrW0S
         zkiBPGfKny24LwgYWca3uw0YKvxTnPNrBLDqVV2iZtJoT1DYFexQUyH6h8F4OA812yLL
         IUtJJ/kV7qkhTEPaRMOcuj4RrZHLxFep4rAfrFbMs+2boMlspZWuUKZOQoQxl89+48Y2
         4xq5/NNerXVLzM0u5ygK9rZAgexkEggHw+Z5Ts8MGcoR5jphosYUytwoy6wFkIuw+g0h
         A76F75XWj9AqP62b7zm09hLtXh3/5ixcKrJ3Vrt5f5HOn+549t+xAnxvNaoNTLLIMCWe
         kLBQ==
X-Gm-Message-State: APjAAAV3N1Z4+cntg2VTczn5ESiRQT86ElmLLUqd9Uwy08+I+Xc0EyS+
        LQFDBc2EgK9BI6QQbFaqGzSWAg==
X-Google-Smtp-Source: APXvYqyCVyX7ZF3yL+6Y/e7edBMF4Ntj2BSdISS4KMOP0HAb7eCMCQ94iY/HEDZuwaY39z8KvKj6iQ==
X-Received: by 2002:a50:8a8b:: with SMTP id j11mr21628737edj.212.1556495264804;
        Sun, 28 Apr 2019 16:47:44 -0700 (PDT)
Received: from localhost.localdomain ([37.228.251.87])
        by smtp.gmail.com with ESMTPSA id p18sm5513219ejm.4.2019.04.28.16.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 16:47:44 -0700 (PDT)
From:   Tom Murphy <tmurphy@arista.com>
To:     iommu@lists.linux-foundation.org
Cc:     murphyt7@tcd.ie, Tom Murphy <tmurphy@arista.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iommu/amd: flush not present cache in iommu_map_page
Date:   Mon, 29 Apr 2019 00:47:02 +0100
Message-Id: <20190428234703.13697-1-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check if there is a not-present cache present and flush it if there is.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f7cdd2ab7f11..ebd062522cf5 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1307,6 +1307,16 @@ static void domain_flush_complete(struct protection_domain *domain)
 	}
 }
 
+/* Flush the not present cache if it exists */
+static void domain_flush_np_cache(struct protection_domain *domain,
+		dma_addr_t iova, size_t size)
+{
+	if (unlikely(amd_iommu_np_cache)) {
+		domain_flush_pages(domain, iova, size);
+		domain_flush_complete(domain);
+	}
+}
+
 
 /*
  * This function flushes the DTEs for all devices in domain
@@ -2435,10 +2445,7 @@ static dma_addr_t __map_single(struct device *dev,
 	}
 	address += offset;
 
-	if (unlikely(amd_iommu_np_cache)) {
-		domain_flush_pages(&dma_dom->domain, address, size);
-		domain_flush_complete(&dma_dom->domain);
-	}
+	domain_flush_np_cache(&dma_dom->domain, address, size);
 
 out:
 	return address;
@@ -2617,6 +2624,8 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 		s->dma_length   = s->length;
 	}
 
+	domain_flush_np_cache(domain, s->dma_address, s->dma_length);
+
 	return nelems;
 
 out_unmap:
@@ -3101,6 +3110,8 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
 	mutex_unlock(&domain->api_lock);
 
+	domain_flush_np_cache(domain, iova, page_size);
+
 	return ret;
 }
 
-- 
2.17.1

