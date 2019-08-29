Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EA7C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2005020674
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR79jPl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfH2LSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:18:04 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34452 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbfH2LSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:18:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id s49so3676000edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 04:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LdftSop4FAsgnu90xfPUb4VrwQYO3xWAqeCbQKmpXAw=;
        b=bR79jPl4rvUQxfm/WZpDq1DyXQdI5dFimvOylxLHdkb6p1bhrXYKf9MmrYBl0/NDfV
         3V0KXZcPjjyMW0Belo7iCxQHNnIV4kIOv09BCxcK2bbYCuy695AwiO5eh4dkivJzOPKc
         AQX69shgH8Hhh9F4L157CtTqKJnmGJ20ptg1GLQUxcxxi9NIOE3VFHT/Z2pg0PENmrCs
         L2RdKj9PwDhdL3ESrxoGYFkv6tO/e0YcUDV5wGhUCm74kKP2i+6S2/9RinrAlhMWlMYf
         9324oZ4PMlQsWRAeyKt88/GdGQpGRSFGCLerBTv+jtU6zc6/5toHP64wwZubb1VwbtS6
         0pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LdftSop4FAsgnu90xfPUb4VrwQYO3xWAqeCbQKmpXAw=;
        b=qfyilwAQYaa5RXl+XfIxLF1vuGUtKXsKP01O/TtpqoN2eomDuTkYXPYhwxkp7nmPYQ
         +mzYg0+Y3xhv0DZHPONcLLYF0W1SmYhshYmH/vNWcbOZbE6RPxc1ODWUWwk5i46JbUvD
         r5ktlsthS6WE3eokgrFEQw31CXd+LTPsgUtMUhDmga/VGwkEmGVjkvReSoKCOqM6TfVu
         sXrJahZZnkfPRY0CJeAw8AYjjutMB8LPrmDir2RFUjEIDNdQNrYka/4b2JSfOyqLuBDP
         LWeqPY8Ew7g+U6igJJiXbYIXzOnQ/fxJUDxEbnP09/Ymn6lQE6qu2X4VL+Op8iLFoHRv
         Zczw==
X-Gm-Message-State: APjAAAU2BdLHBeKik++LIXh4ti6pcJroXfM1m1WMyPyqfWpjW47RtKxX
        3eS/sEcjRm5O2V9ATIgpb8Y=
X-Google-Smtp-Source: APXvYqx6xumvHaa0FS6ceR4LYkovD8dan+j5kQuVNZo88mSfLqaVgTKRmRZEKXv0Df7oSZRTvjLY2Q==
X-Received: by 2002:aa7:df03:: with SMTP id c3mr9130739edy.112.1567077479905;
        Thu, 29 Aug 2019 04:17:59 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id w3sm390212edq.12.2019.08.29.04.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 04:17:59 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] iommu: amd: Use iommu_put_resv_regions_simple()
Date:   Thu, 29 Aug 2019 13:17:50 +0200
Message-Id: <20190829111752.17513-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829111752.17513-1-thierry.reding@gmail.com>
References: <20190829111752.17513-1-thierry.reding@gmail.com>
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
index 04a9f8443344..7d8896d5fab9 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3160,15 +3160,6 @@ static void amd_iommu_get_resv_regions(struct device *dev,
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
 static void amd_iommu_apply_resv_region(struct device *dev,
 				      struct iommu_domain *domain,
 				      struct iommu_resv_region *region)
@@ -3216,7 +3207,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.remove_device = amd_iommu_remove_device,
 	.device_group = amd_iommu_device_group,
 	.get_resv_regions = amd_iommu_get_resv_regions,
-	.put_resv_regions = amd_iommu_put_resv_regions,
+	.put_resv_regions = iommu_put_resv_regions_simple,
 	.apply_resv_region = amd_iommu_apply_resv_region,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
-- 
2.22.0

