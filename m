Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B70C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050B1218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Um7cIxVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfLRNmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:42:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54430 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfLRNmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:42:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id b19so1880776wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 05:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hsSJEdQqIlVTuRxaI5pZ056JoQciAS3rF+M0zjO6p6Y=;
        b=Um7cIxVKrCL+GblkgV5cWPFKTxMRq1sqlSkP97BUTJnao5yxvGJ1mxC17XJpzKbyBu
         ikiHm0Px1UB7chSLij+ETIXF3g2taubWqshSlFmQ0pTYzni5QhviUHOA8jDeht2fLhfR
         R+zQLmjcn+GvltAQv3pZPK35vxxWFUTXrdU6i4OIHBh9WMyCCi176mTn5nuSGa7xcT5M
         vVkmD+w9VTYX1pt/WqNIAft+tEQ1hp+7VHHQGnU6U0uk1xCw48nPJJI+v1wMc1e8+UDa
         nTpbLq34/DFx/HL1vn38IhkVj85px0hpMZkHza8QfXo3oHIRlb2l/lXnxVyi1tHnX/HC
         0YLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hsSJEdQqIlVTuRxaI5pZ056JoQciAS3rF+M0zjO6p6Y=;
        b=jf3/WPQuUGs82JoYSqH7BMR4y+/FSFcEKYyVQ+YZmfQ7BoMWIS4OLME+oILM8gPs8u
         HRhoJh+msHrD4gcQZ4oAX2IeOfr8l8PAobBqT2oD1OuuyhXudlmTi4PPsHPsvjx3HFvD
         nMqRHtIukuCE8+XOnqz+emDolG0uXFzxz8uooO2E2MNJRDtpO1KE2ZI/r6rygzyr5bu9
         KyQwQYECIEq38A9doA9MR5OTupIoi+69Uh1UdyUaSW0wdjOBJW/ZUAv7ndu6KPGQ8P9Z
         c9SpoCAjUPALsSf0q2mNKKLT8gdfVYpCgdGPJUwxul+wz2L4+mObSrRQdgN4l4Ixvz0i
         SOEQ==
X-Gm-Message-State: APjAAAVYum4Qxrx3iFTrsqjssPDHW94rL6IGmjEyNUt0GH6dW6gqdhiN
        Z1YjQI4GJbjAfy4DFY7YTRI=
X-Google-Smtp-Source: APXvYqxRFC4I+BCYSiyF2qywZ62vBWbBCIeFguxaUfSMQB/i5OtCkbkLGzOCIMSKTyOiyj0m7omV0w==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr3247759wmj.37.1576676533311;
        Wed, 18 Dec 2019 05:42:13 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id y6sm2578671wrl.17.2019.12.18.05.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 05:42:12 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] iommu: Implement generic_iommu_put_resv_regions()
Date:   Wed, 18 Dec 2019 14:42:01 +0100
Message-Id: <20191218134205.1271740-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218134205.1271740-1-thierry.reding@gmail.com>
References: <20191218134205.1271740-1-thierry.reding@gmail.com>
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
index fdd40756dbc1..101f2d68eb6e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2229,6 +2229,25 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 		ops->put_resv_regions(dev, list);
 }
 
+/**
+ * generic_iommu_put_resv_regions - Reserved region driver helper
+ * @dev: device for which to free reserved regions
+ * @list: reserved region list for device
+ *
+ * IOMMU drivers can use this to implement their .put_resv_regions() callback
+ * for simple reservations. Memory allocated for each reserved region will be
+ * freed. If an IOMMU driver allocates additional resources per region, it is
+ * going to have to implement a custom callback.
+ */
+void generic_iommu_put_resv_regions(struct device *dev, struct list_head *list)
+{
+	struct iommu_resv_region *entry, *next;
+
+	list_for_each_entry_safe(entry, next, list, list)
+		kfree(entry);
+}
+EXPORT_SYMBOL(generic_iommu_put_resv_regions);
+
 struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
 						  size_t length, int prot,
 						  enum iommu_resv_type type)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1b4fbe703950..2e06b31579c2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -477,6 +477,8 @@ extern void iommu_set_fault_handler(struct iommu_domain *domain,
 
 extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
 extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
+extern void generic_iommu_put_resv_regions(struct device *dev,
+					   struct list_head *list);
 extern int iommu_request_dm_for_dev(struct device *dev);
 extern int iommu_request_dma_domain_for_dev(struct device *dev);
 extern void iommu_set_default_passthrough(bool cmd_line);
-- 
2.24.1

