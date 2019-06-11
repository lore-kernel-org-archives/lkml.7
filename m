Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005A2C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E042086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5lNkx4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403960AbfFKFu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 01:50:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44587 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403879AbfFKFu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:50:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id b17so11436604wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 22:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+6GBHNOHbeGRYajrC93YAmLrtPL2AX3V/NyRmPi/SNk=;
        b=B5lNkx4P0Hv79AbXobUqSC2c8NkkWtBbLBXvJXoVAedcN0Sv6eF+sUnFlvpjWO55jN
         nuPO0NK4VeqPqdszsikkfzRLgZHpoLgdqFdHM/xzcik7vmB6wXqX41Z/BflQPxu3P781
         +vM+2P7ApQmWy1bx+QFtgU+5QXx+HjHwNOc6HDWrGinbL7W52/LP9Ceed+XcJZBasBDm
         zSbO5PDaDpSVyw2grbkdgDMhwoLqxUtFp0MHkcqBThuzl6YRoO1J2Q3F6oTxMUEkS1nL
         he1IUfMyB/u3IIwZZWIJ0wEi/PBT9B8DctbgWAqqVaJs18HqR4o1b6VbXOd5EWEdSM+c
         Qu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+6GBHNOHbeGRYajrC93YAmLrtPL2AX3V/NyRmPi/SNk=;
        b=BsebsRnfYf3yRhU29qTc2s9N7d2VRM0Rq9RZASVEuUVCtOU7Nmn9k1R5hbD8XhA6pG
         dfHBGJ70aVwIakIjg1xrwD8CQNFx/JvcfZyLprWm9O32iezgiR7ulmSh3bqQebo9vjrS
         ruJ708GICwVjoYCElMm0Bp6ZgiqHS+/PDi7S/uhNExekgA858F/l3CtRIUV1eBnZ8cTY
         2O08zUEA4g69179xhTomhvHI4UBQMcZnw0uyPGhSfjUvDi0wWXLM5ynnR6NymOIwirgL
         h/i8EPdmeqZpyFlHEsASJqBtdulTFm4enVE487Q09N15lHylha70I1VPyJLYrZE49juv
         2lCA==
X-Gm-Message-State: APjAAAW5PQait6k6QTu8izBys1khcnqbs1LQO+Ha6TS0wCUyim6/F6gS
        LLhvQiGp04cgHTRG/cYmhSs+kSnnRtk=
X-Google-Smtp-Source: APXvYqyOBVWE9QKXJinrI387fTdGjJ5aAQFBlNSjrH0u1aFHkVKXaDKQuE0j2/GDBZP3JD9auuPEvA==
X-Received: by 2002:adf:e841:: with SMTP id d1mr48575981wrn.204.1560232255278;
        Mon, 10 Jun 2019 22:50:55 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j8sm11968056wrr.64.2019.06.10.22.50.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 22:50:54 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 6/8] habanalabs: remove DMA mask hack for Goya
Date:   Tue, 11 Jun 2019 08:50:43 +0300
Message-Id: <20190611055045.15945-7-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611055045.15945-1-oded.gabbay@gmail.com>
References: <20190611055045.15945-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the non-standard DMA mask setting for Goya. Now that
the device CPU goes through the MMU, we are not limited to allocating the
CPU accessible memory area in the address space of under 39 bits.
Therefore, we don't need to set the DMA masking twice during
initialization, a practice that is not working on POWER architecture.

The patch sets the DMA mask to 48 bits once during the initialization. The
address of the CPU accessible memory area is configured to the MMU and the
matching VA is given to the device CPU.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 9f1f47770afa..e8b3a31d211f 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -472,7 +472,7 @@ static int goya_early_init(struct hl_device *hdev)
 
 	prop->dram_pci_bar_size = pci_resource_len(pdev, DDR_BAR_ID);
 
-	rc = hl_pci_init(hdev, 39);
+	rc = hl_pci_init(hdev, 48);
 	if (rc)
 		return rc;
 
@@ -669,6 +669,9 @@ static int goya_sw_init(struct hl_device *hdev)
 		goto free_dma_pool;
 	}
 
+	dev_dbg(hdev->dev, "cpu accessible memory at bus address 0x%llx\n",
+		hdev->cpu_accessible_dma_address);
+
 	hdev->cpu_accessible_dma_pool = gen_pool_create(ilog2(32), -1);
 	if (!hdev->cpu_accessible_dma_pool) {
 		dev_err(hdev->dev,
@@ -2481,25 +2484,11 @@ static int goya_hw_init(struct hl_device *hdev)
 	if (rc)
 		goto disable_queues;
 
-	/*
-	 * Check if we managed to set the DMA mask to more then 32 bits. If so,
-	 * let's try to increase it again because in Goya we set the initial
-	 * dma mask to less then 39 bits so that the allocation of the memory
-	 * area for the device's cpu will be under 39 bits
-	 */
-	if (hdev->dma_mask > 32) {
-		rc = hl_pci_set_dma_mask(hdev, 48);
-		if (rc)
-			goto disable_msix;
-	}
-
 	/* Perform read from the device to flush all MSI-X configuration */
 	val = RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
 
 	return 0;
 
-disable_msix:
-	goya_disable_msix(hdev);
 disable_queues:
 	goya_disable_internal_queues(hdev);
 	goya_disable_external_queues(hdev);
-- 
2.17.1

