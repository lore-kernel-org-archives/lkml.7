Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DA7C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D832F2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi76d3v8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfEMLcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:32:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34318 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbfEMLco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:32:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id j187so381858wma.1;
        Mon, 13 May 2019 04:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N3vik7kpNTRsh9J9JkdfJ7K6hkNP+zMhP7dl5wnKl8s=;
        b=Qi76d3v88ocTYTCeV0AfqxPxLEUoZsoX3hkDUIgiYFqdlyRcMDO65M4cRs8h9NpMEZ
         LJuySd9GY2AEdUoSqpEXoj5GDn2omBnCUyg6P5GyQwbOAYL/e6LAuLZ33vXmZuQOZ8+m
         oVl6LIXL2B1rYPFarJ21X3WfUu8sgKaHj2FrLy0Pwmfc/QGfL/3Wmw38ubqS4hsIPzyq
         bTas3hE+l6miSrOkBWQWXfF5I3YZ8/6APE/fz5z3XaFK9xb/Iu5hRI9MErNvCeowD4E9
         vYR92gHiAJ7u3QHPxaJxqK2hbm5iUJzlnK95PoNqe1jh1+yIdQlUnBZDAaKaZg15P2uv
         h37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N3vik7kpNTRsh9J9JkdfJ7K6hkNP+zMhP7dl5wnKl8s=;
        b=Gja8YOcfPDSL9Xl0m+R0K+ecDKjkXOlN+Mz/qH6I/BuFzRV4fWQE6ylijaQjhL5/6Y
         YfAhP9WlVyuj4ejLPhzXEKyunfbWMIudgoczOGnmZCU+IIFRDvbwGeg+rbDlViinV61y
         DiRVg4X4K0zRrRlfd8ZM2tLZ8Juunfp/xtS5LoKWr4tW6dYKA1T50FXqLi+kGOASfu7j
         /F2VC987QEHPVnNJYQUX+aajBWVhctLRP+khH4jLxk6y747pfgEOct375RUrkC5QCUvw
         h8rfwzcZWggdUQf4DgwbrbAHyewHLz9ZgULzaZE2Lf6lh9HOrIl19e26Ukjq/KCdolJY
         Sy3w==
X-Gm-Message-State: APjAAAXC/sSGtoQ67xSgtjI9ZohXfSNkc10dKH9lK26ZKiL7jGZfXsJq
        3rZpbp/lJLjc1pgfGB4X4sVKGhZB
X-Google-Smtp-Source: APXvYqyYyD6s1aVp6uZBLdmwopzTtyrO5j2w+tKQdDKQ0lz6v13YWVg0CYZRe3bMLP52qwSQJGZkWg==
X-Received: by 2002:a1c:f311:: with SMTP id q17mr15514866wmq.144.1557747161635;
        Mon, 13 May 2019 04:32:41 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id n15sm15989536wmi.42.2019.05.13.04.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 04:32:40 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Tomer Tayar <ttayar@habana.ai>,
        stable@vger.kernel.org
Subject: [PATCH] habanalabs: Avoid using a non-initialized MMU cache mutex
Date:   Mon, 13 May 2019 14:32:37 +0300
Message-Id: <20190513113237.22425-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

The MMU cache mutex is used in the ASIC hw_init() functions, but it is
initialized only later in hl_mmu_init().
This patch prevents it by moving the initialization to the
device_early_init() function.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/misc/habanalabs/device.c | 2 ++
 drivers/misc/habanalabs/mmu.c    | 8 +-------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 91a9e47a3482..0b19d3eefb98 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -231,6 +231,7 @@ static int device_early_init(struct hl_device *hdev)
 
 	mutex_init(&hdev->fd_open_cnt_lock);
 	mutex_init(&hdev->send_cpu_message_lock);
+	mutex_init(&hdev->mmu_cache_lock);
 	INIT_LIST_HEAD(&hdev->hw_queues_mirror_list);
 	spin_lock_init(&hdev->hw_queues_mirror_lock);
 	atomic_set(&hdev->in_reset, 0);
@@ -260,6 +261,7 @@ static int device_early_init(struct hl_device *hdev)
  */
 static void device_early_fini(struct hl_device *hdev)
 {
+	mutex_destroy(&hdev->mmu_cache_lock);
 	mutex_destroy(&hdev->send_cpu_message_lock);
 
 	hl_cb_mgr_fini(hdev, &hdev->kernel_cb_mgr);
diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/mmu.c
index 533d9315b6fb..10aee3141444 100644
--- a/drivers/misc/habanalabs/mmu.c
+++ b/drivers/misc/habanalabs/mmu.c
@@ -404,15 +404,12 @@ int hl_mmu_init(struct hl_device *hdev)
 
 	/* MMU H/W init was already done in device hw_init() */
 
-	mutex_init(&hdev->mmu_cache_lock);
-
 	hdev->mmu_pgt_pool =
 			gen_pool_create(__ffs(prop->mmu_hop_table_size), -1);
 
 	if (!hdev->mmu_pgt_pool) {
 		dev_err(hdev->dev, "Failed to create page gen pool\n");
-		rc = -ENOMEM;
-		goto err_pool_create;
+		return -ENOMEM;
 	}
 
 	rc = gen_pool_add(hdev->mmu_pgt_pool, prop->mmu_pgt_addr +
@@ -436,8 +433,6 @@ int hl_mmu_init(struct hl_device *hdev)
 
 err_pool_add:
 	gen_pool_destroy(hdev->mmu_pgt_pool);
-err_pool_create:
-	mutex_destroy(&hdev->mmu_cache_lock);
 
 	return rc;
 }
@@ -459,7 +454,6 @@ void hl_mmu_fini(struct hl_device *hdev)
 
 	kvfree(hdev->mmu_shadow_hop0);
 	gen_pool_destroy(hdev->mmu_pgt_pool);
-	mutex_destroy(&hdev->mmu_cache_lock);
 
 	/* MMU H/W fini will be done in device hw_fini() */
 }
-- 
2.17.1

