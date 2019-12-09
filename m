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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F125C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C85C2068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMW40Gli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLIOu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:50:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45579 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfLIOuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:50:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so16459240wrj.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 06:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v6i9DrODxvVzc7sEu1n26IoTawSzw3EOrGL5427sW0Q=;
        b=qMW40Glimuk8RCsOpQuJ/pexDlbz4FJLVtFyjhBvedGJfjxS4yJweoEhUs42NkR8ym
         ceaQO7flrjft3Ema57FQ4RUg5SaisdUyht8l2r3bp27a3Yqvf9KqWMFIb5hcuQD0MDck
         6aTI0aVh5Kx5Gs/FBgPYx3Vvu043B0vg+XvmlVjhhNE/JHmgzKamOdPGvIxNv21VtyoU
         YBqmv46iNclra+yjNW58pyG8B0uXyXVQM2HgfWVZlMvZMgNNKD8zTu5wRNc6W7Fsb2oH
         sL+3hR/RGv9m+EYzbye8FGIEJijiVk6ee10zp4cGSW8cLTfwtxrCZ41IRcihwAKbQ30G
         xo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v6i9DrODxvVzc7sEu1n26IoTawSzw3EOrGL5427sW0Q=;
        b=gAdX1CrsE+izSrUQK9P9e9zXjCtl9y+Ky3pZ8/vfPyH+DkoXG4cgZLxr9IjcEQHal2
         BLEyjf//Dyc0f21A+d/3m7q21cWC+YdeOd2ENEABsc4JGP/P/1uZkxgxCmhLkUZr1N7Z
         CH2Jl8ri+/pEmKBh7XVTc0/rJDvy7IHE1OeZCba3s2AIImURCBtMyyv9MgbMLJr5rMCM
         zLEIZbzsqBldpeoqtVfa3ZaN26XIaPOJYud2AM+mZodfy1ixzHwD2+oQQrvLey0ELA6A
         XlWJPAvm2zmpSZMk7w8+IE1CKamrfBLiESufWicLQ7v5BhvKTD6AbRbKZIV2QSAoTxfV
         BqOA==
X-Gm-Message-State: APjAAAV6bKbd3YB6aNqMt56VRhWhlF4I9aTeIvsIoXpQJ0FaSUnwo7FR
        nXOZ2ZQrDHxvClPO6eKObuw=
X-Google-Smtp-Source: APXvYqycPV9EZHFU8VN58XAVcMErrL4NDZbeMSU6cPaHd0nxxJDiVJbBvYMs0iBbchsEY0d1dIwJOQ==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr2576924wrp.167.1575903020783;
        Mon, 09 Dec 2019 06:50:20 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id a16sm26990396wrt.37.2019.12.09.06.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 06:50:19 -0800 (PST)
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
Subject: [PATCH v2 5/5] iommu: virtio: Use iommu_put_resv_regions_simple()
Date:   Mon,  9 Dec 2019 15:50:07 +0100
Message-Id: <20191209145007.2433144-6-thierry.reding@gmail.com>
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

Use the new standard function instead of open-coding it.

Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- change subject prefix to 'iommu: virt:' to 'iommu: virtio:'

 drivers/iommu/virtio-iommu.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 315c7cc4f99d..834e56a28d4d 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -837,14 +837,6 @@ static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
 	iommu_dma_get_resv_regions(dev, head);
 }
 
-static void viommu_put_resv_regions(struct device *dev, struct list_head *head)
-{
-	struct iommu_resv_region *entry, *next;
-
-	list_for_each_entry_safe(entry, next, head, list)
-		kfree(entry);
-}
-
 static struct iommu_ops viommu_ops;
 static struct virtio_driver virtio_iommu_drv;
 
@@ -914,7 +906,7 @@ static int viommu_add_device(struct device *dev)
 err_unlink_dev:
 	iommu_device_unlink(&viommu->iommu, dev);
 err_free_dev:
-	viommu_put_resv_regions(dev, &vdev->resv_regions);
+	iommu_put_resv_regions_simple(dev, &vdev->resv_regions);
 	kfree(vdev);
 
 	return ret;
@@ -932,7 +924,7 @@ static void viommu_remove_device(struct device *dev)
 
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&vdev->viommu->iommu, dev);
-	viommu_put_resv_regions(dev, &vdev->resv_regions);
+	iommu_put_resv_regions_simple(dev, &vdev->resv_regions);
 	kfree(vdev);
 }
 
@@ -961,7 +953,7 @@ static struct iommu_ops viommu_ops = {
 	.remove_device		= viommu_remove_device,
 	.device_group		= viommu_device_group,
 	.get_resv_regions	= viommu_get_resv_regions,
-	.put_resv_regions	= viommu_put_resv_regions,
+	.put_resv_regions	= iommu_put_resv_regions_simple,
 	.of_xlate		= viommu_of_xlate,
 };
 
-- 
2.23.0

