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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCBFC2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C146B21582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEeDzlSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfLRNmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:42:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35698 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfLRNmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:42:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so2364398wro.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 05:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bI3H7fJjyT7cwzCxHkg0RoSKkE9h3LIoHk3spnZ/1k8=;
        b=ZEeDzlSAHcJKgSJOBltLwZ4gctZ6heHgw5D7C16qSZBk0BcEIRlw39Zy3UGuZ5UuhO
         PUkGJ+hbZ8GuYnGixq5JfQcbK9y3iacQnUbN45Dj83R2TbSGfhv8hxmkZnTY9dQhjmBt
         pLk01WPXEkN5usMHdmfX2wqWXb9nuXp7+6uOdVviLBNEtMIwl+bjUWAvisdSjbPCSkb2
         myvcPvaDT+lDArGcX3+Vcpd/20s6Anoh6oTnsULQhHWClvkwIMrVWERJAp7Cos8HgvNw
         U+DuKeNl9frs6LPgcheIIcwph6gsYFw+Kj1z4PNBcVkJWdlNdrqclvlakWsrSaiKxn4X
         fjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bI3H7fJjyT7cwzCxHkg0RoSKkE9h3LIoHk3spnZ/1k8=;
        b=WmstF/B61P9p7yPc9/hFJnGLKQS/HkaoU/HbTwBd00gBHix7yQ8/h4CHwwucrR2aF9
         BIg5wKvSXDQXZcskbep5f3T9wIt1XvieY53jgVi0cOFk3NeOReBSCgnqvFDaC+ix2Bbg
         bJGeg8ogPhzJVzhZFuwv0r1DatFZwX4rK5+yUvXjDbk+dGOOO6zNbj9ShXH2cxVOyrHD
         1NydDd0woVvicwfoLm8L1JpxX76rq68R8c7lvI3G2PAtJMhxKxxD0Km/abAu04GDInuw
         Elauga5bxg6Sox8zq072I5diY6AmLQIe+OHvF1tI7tPTxhcP/3RQkgiOSaeuKyuhVOJe
         m36Q==
X-Gm-Message-State: APjAAAX7CeInbWhp19T1Mej7L8KFqRFjI21mzOjADGdngXlVn6zmGgpc
        O1daucBc+JsGdDmuR8+ilEs=
X-Google-Smtp-Source: APXvYqxraiIdHwEwu7ywFCdkxr9EHQN/eL8hSbyjl1Dfiv6tPoPwpVi8bvtLx2DxzSSf+A+feHN7FQ==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr2853607wrq.331.1576676540324;
        Wed, 18 Dec 2019 05:42:20 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id e16sm2547391wrs.73.2019.12.18.05.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 05:42:19 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] iommu: virtio: Use generic_iommu_put_resv_regions()
Date:   Wed, 18 Dec 2019 14:42:05 +0100
Message-Id: <20191218134205.1271740-6-thierry.reding@gmail.com>
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

Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtualization@lists.linux-foundation.org
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/virtio-iommu.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 315c7cc4f99d..cce329d71fba 100644
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
+	generic_iommu_put_resv_regions(dev, &vdev->resv_regions);
 	kfree(vdev);
 
 	return ret;
@@ -932,7 +924,7 @@ static void viommu_remove_device(struct device *dev)
 
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&vdev->viommu->iommu, dev);
-	viommu_put_resv_regions(dev, &vdev->resv_regions);
+	generic_iommu_put_resv_regions(dev, &vdev->resv_regions);
 	kfree(vdev);
 }
 
@@ -961,7 +953,7 @@ static struct iommu_ops viommu_ops = {
 	.remove_device		= viommu_remove_device,
 	.device_group		= viommu_device_group,
 	.get_resv_regions	= viommu_get_resv_regions,
-	.put_resv_regions	= viommu_put_resv_regions,
+	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.of_xlate		= viommu_of_xlate,
 };
 
-- 
2.24.1

