Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE51C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134C22068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WohFdDSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfLIOuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:50:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41682 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIOuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:50:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so16517857wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 06:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kbWhKztcZroEY9HZuAqBCwxCkxfV0uGPkkrZZcpYU3k=;
        b=WohFdDSSvA/Lq0puBHpDkCHxitGoNFR5CPbiG8Gh21dQjYBEkHxEkHz5pt/EggFEGl
         MSvwQoA3HUt5LeOuCAVKw8u5l406d5KYqeeFyIeFPzsckZ7tZdkPITK7DSVqTN1HmmUa
         4jlRRbP20cLG2MJQUkku/EcxdimGb9pe30RNy/jg0N4fqT4rcp/oaGhGBcw66COjVv4U
         n50RxnFr9la4TIBdU9QlX9rBxSD5HoaS24xeu/PXIeqCxzva7HkNTNabB1YAzLW4TQbo
         JVFhCRcEHP3Lt66CiAAt32vwjUldm1KWQS2w2y2cDLyiBjRCa1/c7hKvPAxw2E9zGn5z
         zU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kbWhKztcZroEY9HZuAqBCwxCkxfV0uGPkkrZZcpYU3k=;
        b=Nr1wxLFwuVEfi5vItIEhExmLCNxvuKsi1jSPZXiyIdEvkmTbvqCiN4j7FTKoLvZlKM
         X3grCRdOssZn/w15lkq1Vtdo3NJ17w9wj2EHHQz2n5v6eduCh4Lp8mZJvEdfftU37718
         P84vvzgGzKbNDcZi90jBW7kAx80R/HYIWjNQnPRxE/47J8cgUcoBD6SZdlyXEDRFyO9e
         igXZFpG0VjiI/+TjCbYDnTq1APmqwpzT62f5Jjj8Tifz5bSSqa3bmKc6v3dP4sufYPqn
         +2Y60xUIg0lyzR94UUETP3hTfRbWt1nLBoi5CezLtojfzmF/O8ftZwbFNL1eieWTf2dA
         b47A==
X-Gm-Message-State: APjAAAWRmYiTJsXGz/IAPmdkKBqTPqPcjqvpdY0MJggQO4GVYmy/D427
        zkXmjOjhsYXxAsmCSFzSI/U=
X-Google-Smtp-Source: APXvYqzhZIggnLvtoyIgmYrF5RPdWaQ6t5xLlPHAXblTPP1Yw9lYQBIUb9qRPlNBGVW4ZHPpf+YYAg==
X-Received: by 2002:a5d:50d2:: with SMTP id f18mr2616447wrt.366.1575903012744;
        Mon, 09 Dec 2019 06:50:12 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id u205sm10174718wmu.35.2019.12.09.06.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 06:50:11 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] iommu: Implement iommu_put_resv_regions_simple()
Date:   Mon,  9 Dec 2019 15:50:03 +0100
Message-Id: <20191209145007.2433144-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191209145007.2433144-1-thierry.reding@gmail.com>
References: <20191209145007.2433144-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Implement a generic function for removing reserved regions. This can be
used by drivers that don't do anything fancy with these regions other
than allocating memory for them.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/iommu.c | 19 +++++++++++++++++++
 include/linux/iommu.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index db7bfd4f2d20..a46d3bcafa06 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2229,6 +2229,25 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 		ops->put_resv_regions(dev, list);
 }
 
+/**
+ * iommu_put_resv_regions_simple - Reserved region driver helper
+ * @dev: device for which to free reserved regions
+ * @list: reserved region list for device
+ *
+ * IOMMU drivers can use this to implement their .put_resv_regions() callback
+ * for simple reservations. Memory allocated for each reserved region will be
+ * freed. If an IOMMU driver allocates additional resources per region, it is
+ * going to have to implement a custom callback.
+ */
+void iommu_put_resv_regions_simple(struct device *dev, struct list_head *list)
+{
+	struct iommu_resv_region *entry, *next;
+
+	list_for_each_entry_safe(entry, next, list, list)
+		kfree(entry);
+}
+EXPORT_SYMBOL(iommu_put_resv_regions_simple);
+
 struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
 						  size_t length, int prot,
 						  enum iommu_resv_type type)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1b4fbe703950..a249aa55596b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -477,6 +477,8 @@ extern void iommu_set_fault_handler(struct iommu_domain *domain,
 
 extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
 extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
+extern void iommu_put_resv_regions_simple(struct device *dev,
+					  struct list_head *list);
 extern int iommu_request_dm_for_dev(struct device *dev);
 extern int iommu_request_dma_domain_for_dev(struct device *dev);
 extern void iommu_set_default_passthrough(bool cmd_line);
-- 
2.23.0

