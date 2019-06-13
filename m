Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1B1C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2728121537
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="Mo5DuFV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfFMWFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 18:05:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40094 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfFMWFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 18:05:16 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so391971eds.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 15:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+8FvL87Ik+dUxncoVW6eXP+WAOS+Kbo5uxd7wggC77c=;
        b=Mo5DuFV4W+iqjVJHcaknEsCoQX+9r9R3zkQZn92xWa05rjFhhkC0HtClNh4vf71yy8
         nby6fhcDhR8VsAd7ZPwydTtJgdbnXiLYbbfT0JM9g7Ntp8qz9yxbZ+cjEvktrR/9ErsF
         rr7cbJqNEqC0GZ2uv7Msi0fwVmBsGgXqZsDHKF3V7RWq1znSnzINiITvElO9BaXA4J5m
         MCv9yuVn+IUyfIeZJCmorxS8maTflpd2d7t8VKW4MQmd8b7JR2sYDUP3+zVuetFaTg0y
         +SGBQ7RyKF3YQFlqsD+HhU5gAssHvs6O2yPrAEhkMKNkV/QGhXxhznwljopC2Sgbaax/
         I+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+8FvL87Ik+dUxncoVW6eXP+WAOS+Kbo5uxd7wggC77c=;
        b=O0FnsEvbDtVn6raf7zdTTYxeA2gRZemMt9TJlPRmDs0s9ZL/qHBwO4SvEWXRaeWUmG
         un7iLueyBii84KN3V6XeYx2bsix7Af81NRGWk5kXnzhwZb+VaICKBM0F2FMoR3vilAR6
         AO6v9VdsiZflUgVyvVAhIuT5VLTbC0DilcmVeadIJFxkIl9VdvCCED8nIEGib+8Xidtu
         WtXjnPWSomLKsCQAnsR9U73ltK6gX/1kOHRNZYY3m47BrXdl1exoqArxnHodmGmkssC2
         O7yiZ9dmQOJf8Z2iK3IktOs6qH8/phC1G4/dW11N4lGivBPQoxA9YBbD532uFpTfTCGb
         EGsg==
X-Gm-Message-State: APjAAAUEg3ULPYW+hmuPmRo7dh0Cg2BeSCtkvaPK/GSYQVc6ZF4dlgOB
        dUBQsIsUcr/mvxWeTGgAgS693Q==
X-Google-Smtp-Source: APXvYqzRh8XRpIEzGGrVqaF3sGuE8RkE68bfw601NWT0H/WwJBa9FMPJcilB7GxE0YJ1BE/C6buV5g==
X-Received: by 2002:a17:906:2641:: with SMTP id i1mr1020153ejc.9.1560463514055;
        Thu, 13 Jun 2019 15:05:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:a0:bc00:8042:d435:a754:1f22])
        by smtp.googlemail.com with ESMTPSA id c26sm272089edb.40.2019.06.13.15.05.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 15:05:13 -0700 (PDT)
From:   Tom Murphy <murphyt7@tcd.ie>
To:     iommu@lists.linux-foundation.org
Cc:     Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] iommu/amd: Flush not present cache in iommu_map_page
Date:   Thu, 13 Jun 2019 23:04:55 +0100
Message-Id: <20190613220455.6599-1-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check if there is a not-present cache present and flush it if there is.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
v3:
--applied Qian Cai's "iommu/amd: fix a null-ptr-deref in map_sg()" fix

 drivers/iommu/amd_iommu.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f5d4a0011d25..73740b969e62 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1295,6 +1295,16 @@ static void domain_flush_complete(struct protection_domain *domain)
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
@@ -2377,10 +2387,7 @@ static dma_addr_t __map_single(struct device *dev,
 	}
 	address += offset;
 
-	if (unlikely(amd_iommu_np_cache)) {
-		domain_flush_pages(&dma_dom->domain, address, size);
-		domain_flush_complete(&dma_dom->domain);
-	}
+	domain_flush_np_cache(&dma_dom->domain, address, size);
 
 out:
 	return address;
@@ -2559,6 +2566,9 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 		s->dma_length   = s->length;
 	}
 
+	if (s)
+		domain_flush_np_cache(domain, s->dma_address, s->dma_length);
+
 	return nelems;
 
 out_unmap:
@@ -3039,6 +3049,8 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
 	mutex_unlock(&domain->api_lock);
 
+	domain_flush_np_cache(domain, iova, page_size);
+
 	return ret;
 }
 
-- 
2.20.1

