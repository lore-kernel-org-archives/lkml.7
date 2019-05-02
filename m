Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0443FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57C42085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1oS+CDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfEBMwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:52:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50618 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfEBMwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:52:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id p21so2670247wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MMGpjKoOQxaFbczjnBaLl3GvrIXhaf+yLzIld7oDBt0=;
        b=M1oS+CDKfQgLLQocLNzgUE1Zg2K8e/Ek7MgsPvB0Kc4XYlkLOBvlBeZLfuxyHptSIq
         LlfTUfXVVSwmHaYiU0vSV6Efn/FU4zgftkV6OlFe0aSNRyf9YN+7ZZAA17k0yFfNpZJS
         klU+wGnYXfnPyYXSoJV2XzarEMM9SR59dFV+vUyD+Y50TLG5kdyD4D1HNpnW5nDOkOtq
         luxDfotBmKROJmWNemZ10s3mo++a/pDDeWSuLPWcmfsiBkD7F26E1/jD6DhsUqoZtyI0
         KInEOEfrRTu/Gzj8wJ3tBZxS999UKvN0jF+X2DkhPTjt5PSHddAu2qQG06xsXVY31ayp
         Omlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MMGpjKoOQxaFbczjnBaLl3GvrIXhaf+yLzIld7oDBt0=;
        b=LRtwRmTOBmgOXhdnV6lKhB2DGksHtATQeMfVo06EEcf80qIl6R0ojOhkgo4dxyprmg
         uj/5X4acooC0UtxtmrZ48BLr1kfV4agJE1ZX/SxMenTe6BseDHLcg00DzJqRIwnYb9bx
         cRF66KFJbP6BHaaBSxSy9Xz0HRQGyDFhV730XfwDoTc0KraieN57H743h+3oos7zDl3s
         CzjP+3aRnH0C6jp37UXUYPgrZZxFTl8DRHTmws1epXdYcyacpzYvHAa68lVAOWZrSCxP
         TzQxe1KhWC6M9HPVpqrQjanjE+4FGoyA1BA56B4wViDk5HMzJZa4rjSeN6VVrB9jP8RI
         wyrA==
X-Gm-Message-State: APjAAAW66qyueEO487HXWBywzoQihyTcuMTw5gKLlrdBmOlApsf77+4y
        37lVK7mGFoEPXaL6y+5RDA0iLb3f
X-Google-Smtp-Source: APXvYqzRZvyN95eCmIrb3qxGaMoDD3Kx0H/RfMTB5FrLmSSxB+9+oxy0i2ua9BXxsbgPuAJfWes4VQ==
X-Received: by 2002:a7b:c218:: with SMTP id x24mr2215464wmi.57.1556801573127;
        Thu, 02 May 2019 05:52:53 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id r2sm9473342wmh.31.2019.05.02.05.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 05:52:52 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH] habanalabs: Update CPU DMA pool label name
Date:   Thu,  2 May 2019 15:52:49 +0300
Message-Id: <20190502125249.11036-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

The CPU accessible DMA pool is general and not used only for PQ.
Accordingly, this patch rename the "free_cpu_pq_pool" label with
"free_cpu_accessible_dma_pool".

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 9bf572a2d292..0fa0bdd7c852 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -670,14 +670,14 @@ static int goya_sw_init(struct hl_device *hdev)
 		dev_err(hdev->dev,
 			"Failed to add memory to CPU accessible DMA pool\n");
 		rc = -EFAULT;
-		goto free_cpu_pq_pool;
+		goto free_cpu_accessible_dma_pool;
 	}
 
 	spin_lock_init(&goya->hw_queues_lock);
 
 	return 0;
 
-free_cpu_pq_pool:
+free_cpu_accessible_dma_pool:
 	gen_pool_destroy(hdev->cpu_accessible_dma_pool);
 free_cpu_pq_dma_mem:
 	hdev->asic_funcs->asic_dma_free_coherent(hdev,
-- 
2.17.1

