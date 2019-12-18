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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01110C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5CE21582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2l0Ln5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLRNmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:42:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35170 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfLRNmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:42:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so1966261wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 05:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SGGKIHFMLqYbZpUM3Q33U5iSErWckLEQGV1WkcVEHI8=;
        b=f2l0Ln5lReEODkQsQ2uA5VClJ+tweCe1nxxLM25wOBTPUawR+6ac4Oh9JJIQXM7izU
         279nW2ndVPAd5tnmu5o34yBm34BQ/CgXFNXfsJYRQZTwly2ugMLdHjRgJNbuOPzWgJP8
         w99o0aQmIh2BnWDic7KwjuDGuyPTQIlwxumobg6+P6U3shJ7PqzEn+FvI5yMVIcR1SH0
         EoMluYkn1DeaDPsFpZoKJQYQB+0uCRwqUzjFAdzkKEN3PWmxuSikgYRh+9y0cxoQBnLA
         lLX0ubFtEcze1SbNZtpuQDnZRGz1S1577k2poja+bugOY23uMXwe6aKHUOLM3s4LpKwx
         dlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SGGKIHFMLqYbZpUM3Q33U5iSErWckLEQGV1WkcVEHI8=;
        b=EDxq+t0/BIm++Y+s1gPygo9GreMd/xOcqu5lMJLKJrD8Shlef93jB1whNZiZk6B7tB
         f6MX5NszV/RUuY/P/ySRddrsu624q5G4sAl9qBx0U5MrCGRsgZK5akLmdnNLEX+7gCz8
         RQjKo+TmEUsAH+/l3aoTWfnpyHxMbmPpN1wegIs/37PbTSu//2t9JnkrcmwBcRvmSlRt
         sUKmMBcqp+9sDDziOqlsxuQrC0lyQYpPHc/TLmy0LhDgpp5KPeZDSxQByAdEY9zK2HdR
         IHBbHCQj2L0CB2xCa9HDl6CuXa5OIwvAwyWPhPPLKJK/lWv8KqRvfGwL55nlYRQc4Tvv
         z5Rw==
X-Gm-Message-State: APjAAAUf/SHnySoZTvchtylwXzU5Fgpt7+d1S5LB1VhM7SrC032lfrrz
        l5/4G8dsKXbpI0oNfy4ZY10=
X-Google-Smtp-Source: APXvYqzoxOysiicfnZ8kQPTnP3ixsfrrY57jj/OU+n4GiTzU41Y7nHqcI1DrYVt8Sbn788JPh2gokQ==
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr3530551wml.55.1576676537022;
        Wed, 18 Dec 2019 05:42:17 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id v20sm2459763wmj.32.2019.12.18.05.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 05:42:16 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] iommu: amd: Use generic_iommu_put_resv_regions()
Date:   Wed, 18 Dec 2019 14:42:03 +0100
Message-Id: <20191218134205.1271740-4-thierry.reding@gmail.com>
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

Use the new standard function instead of open-coding it.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/amd_iommu.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 7a6c056b9b9c..9ea6c4b8e402 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2638,15 +2638,6 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 	list_add_tail(&region->list, head);
 }
 
-static void amd_iommu_put_resv_regions(struct device *dev,
-				     struct list_head *head)
-{
-	struct iommu_resv_region *entry, *next;
-
-	list_for_each_entry_safe(entry, next, head, list)
-		kfree(entry);
-}
-
 static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
 					 struct device *dev)
 {
@@ -2685,7 +2676,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.device_group = amd_iommu_device_group,
 	.domain_get_attr = amd_iommu_domain_get_attr,
 	.get_resv_regions = amd_iommu_get_resv_regions,
-	.put_resv_regions = amd_iommu_put_resv_regions,
+	.put_resv_regions = generic_iommu_put_resv_regions,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
-- 
2.24.1

