Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3F2ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1E720835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rC3YTB0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfJGUv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:51:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44039 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbfJGUvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:51:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so9383832pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 13:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6g6bAI8I8EYsK43cwBiTTXy4oB3NYybaiwTag+iFJPA=;
        b=rC3YTB0+hOcmaDXUspN39GIY0nApX+Rt/+I0TvKqqeA1Xaq9WCzVeeUHweQW7m6Pav
         VjVX19Qmr1nFoSTKu7/G6DQWha2WEgEh9X5NhuHzHKkws8lYbSCkIoU+t0BqIK7KBmpH
         2+6UkWqL088G7ZOhAa5TGMmTTT0fyUdlaVFSiVJuBYLnKPYCcW0VfSzNdZa62BKIpJuB
         qIexWIG7LzL9jmw5euiECych+ZLh6dexPW2I/F09tthZ/k8q3QBZcPsD7+GUiXJsTfr7
         x+74QhULu49un+22fuw0md1lVwbPHpRnJDYtVwgQFbqrXiVVhfXWf3NeOyUNTCGDScua
         NkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6g6bAI8I8EYsK43cwBiTTXy4oB3NYybaiwTag+iFJPA=;
        b=Qgot7CxrtugZVRdu+kDGDBpxRwzl3imEHLfN6sZP/10uaObl3OhPozUtWOKK9Q0f8n
         UDb9bPuZxBQn4oVovCL1EdFX3OL+xsPTRGIQ9z5bRhI1Bn4j8GDdcXKN5j91Np8ZvRjX
         bqSz96P895SlfC5wzyaPNWJd/c2Dr3CpIEtR/MSMpl9ajHZiYal26YgK4vXWI1Xh1RYa
         wUOUPzgCTjL4hLw5Zwh3d3dO8M0od77hP487Tru8/ZB1A/hgWTymPSXUXPrX6CdXljJY
         nHqvRn7fTIdYF1+8veuEKOpy1EiNZx55FK1SkHoF0b3q+ExluFVl/S1cXsBc1EZ5XQCy
         4UMQ==
X-Gm-Message-State: APjAAAWkXDHN/edVqdrMDNuM8JKQ7bHUJVKPnZ6UuXGXjZIUao7XLlvN
        dpRzVrPnmbXXvwlI73Dyono=
X-Google-Smtp-Source: APXvYqy3GawUaKDtynbkxOmrvUe78E4CqvoIysRE+NXAUd0BUstCS0iAwnenFUJnuEigjkBPuOqTiw==
X-Received: by 2002:a63:60e:: with SMTP id 14mr5830612pgg.179.1570481484414;
        Mon, 07 Oct 2019 13:51:24 -0700 (PDT)
Received: from localhost ([100.118.89.196])
        by smtp.gmail.com with ESMTPSA id e192sm17789132pfh.83.2019.10.07.13.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 13:51:23 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     iommu@lists.linux-foundation.org
Cc:     freedreno@lists.freedesktop.org,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Clark <robdclark@chromium.org>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iommu/arm-smmu: fix "hang" when games exit
Date:   Mon,  7 Oct 2019 13:49:06 -0700
Message-Id: <20191007204906.19571-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <418d8426-f299-1269-2b2e-f86677cf22c2@arm.com>
References: <418d8426-f299-1269-2b2e-f86677cf22c2@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

When games, browser, or anything using a lot of GPU buffers exits, there
can be many hundreds or thousands of buffers to unmap and free.  If the
GPU is otherwise suspended, this can cause arm-smmu to resume/suspend
for each buffer, resulting 5-10 seconds worth of reprogramming the
context bank (arm_smmu_write_context_bank()/arm_smmu_write_s2cr()/etc).
To the user it would appear that the system just locked up.

A simple solution is to use pm_runtime_put_autosuspend() instead, so we
don't immediately suspend the SMMU device.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
v1: original
v2: unconditionally use autosuspend, rather than deciding based on what
    consumer does

 drivers/iommu/arm-smmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 3f1d55fb43c4..b7b41f5001bc 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -289,7 +289,7 @@ static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
 static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
 {
 	if (pm_runtime_enabled(smmu->dev))
-		pm_runtime_put(smmu->dev);
+		pm_runtime_put_autosuspend(smmu->dev);
 }
 
 static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
@@ -1445,6 +1445,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	/* Looks ok, so add the device to the domain */
 	ret = arm_smmu_domain_add_master(smmu_domain, fwspec);
 
+	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
+	pm_runtime_use_autosuspend(smmu->dev);
+
 rpm_put:
 	arm_smmu_rpm_put(smmu);
 	return ret;
-- 
2.21.0

