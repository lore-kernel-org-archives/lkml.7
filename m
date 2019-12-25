Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B43C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 13:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185E020722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 13:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hat9SJDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfLYNT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 08:19:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34532 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfLYNTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 08:19:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id c127so3553974wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Dec 2019 05:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gko1scD4L8Lrs1A77xEXZ+qwxNBxN0Emm901Nv0Qg+I=;
        b=hat9SJDJ12WQ2XhpVS3I7xjmDuUinxdTmZ4BBTKZxtxgZ27S7knqze+jZx1+XtSq5T
         ++kcqKuaBaxFBA1ROoUjoxE9DQIDOfFm9atRkBKhMLNC0kqKvrrgqxkUAnu77Q4UxgnP
         RVPXi1qbmCcRQDbkW89s3hk1dSO/95EpzEYchm25Kvkw/wXH/bZBDfqtxPTwrCO8Pg64
         ODERT1p+PSjYfrTphj2BqYnlOPT6G3WMNO2ISYG6J68gHH6uR/9k/VH4VPWeZ4p+7fwm
         9NQJz5iGGB4iygnB62kFOYRj2oOc4r/paw4nsDdqkza0YG+RUe2UhRRHssE1gkhwpXEo
         0PWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gko1scD4L8Lrs1A77xEXZ+qwxNBxN0Emm901Nv0Qg+I=;
        b=XNSwnLxfAxe3FqScEm1L6y4cQUzvy8rs0fvYAcg1IwlPa8meufxHAM23ywz/mWFj0C
         88EmTt/ItWgkZz3CSNHs68/OzUy8kkWcbnrqLegMTmwQqbNwAWsjdqTxwone/QpBdYeS
         uNFFam+T+ypJZuyudr0nwWC/cXTYvKFgdvVQ5pI6T6PX5rHmyCoD6Nlf/KmBlOHYqxie
         ZgO0DuD1by2h23FG36B1kIlZLZX41l1/i9p+leC4ReU8JT6kOosSi4kFGeFU+54iN3ya
         23OhSUBZO5zNaTNcli1xWyOo42Aec5EUhuwVaLgoFUw7lGIeAYgi4mnbCmWDohP+m6x+
         D4Pg==
X-Gm-Message-State: APjAAAURPcpyA8653Gd0Lp7h3+rsJ81ePhN2HoA9EOfWHekcJgWe+BeH
        8Jeo0NkadXZ/NXBM4SzgPkw7g9HtGSE=
X-Google-Smtp-Source: APXvYqyQgavRLgMIBzsVCKok7sKhXBy0kJlGYJH07tEuzh+Fvp+sFgL3zlYcmLlctklVPo6ieYSnmw==
X-Received: by 2002:a1c:b603:: with SMTP id g3mr9150550wmf.133.1577279963635;
        Wed, 25 Dec 2019 05:19:23 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id x10sm26500214wrv.60.2019.12.25.05.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2019 05:19:22 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: halt the engines before hard-reset
Date:   Wed, 25 Dec 2019 15:19:21 +0200
Message-Id: <20191225131921.15343-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver must halt the engines before doing hard-reset, otherwise the
device can go into undefined state. There is a place where the driver
didn't do that and this patch fixes it.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c    |  1 +
 drivers/misc/habanalabs/goya/goya.c | 42 +++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index b155e9549076..166883b64725 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -1189,6 +1189,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	if (hdev->asic_funcs->get_hw_state(hdev) == HL_DEVICE_HW_STATE_DIRTY) {
 		dev_info(hdev->dev,
 			"H/W state is dirty, must reset before initializing\n");
+		hdev->asic_funcs->halt_engines(hdev, true);
 		hdev->asic_funcs->hw_fini(hdev, true);
 	}
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 72935851a7e8..5750294400f4 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -895,6 +895,11 @@ void goya_init_dma_qmans(struct hl_device *hdev)
  */
 static void goya_disable_external_queues(struct hl_device *hdev)
 {
+	struct goya_device *goya = hdev->asic_specific;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_DMA))
+		return;
+
 	WREG32(mmDMA_QM_0_GLBL_CFG0, 0);
 	WREG32(mmDMA_QM_1_GLBL_CFG0, 0);
 	WREG32(mmDMA_QM_2_GLBL_CFG0, 0);
@@ -956,6 +961,11 @@ static int goya_stop_external_queues(struct hl_device *hdev)
 {
 	int rc, retval = 0;
 
+	struct goya_device *goya = hdev->asic_specific;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_DMA))
+		return retval;
+
 	rc = goya_stop_queue(hdev,
 			mmDMA_QM_0_GLBL_CFG1,
 			mmDMA_QM_0_CP_STS,
@@ -1744,9 +1754,18 @@ void goya_init_tpc_qmans(struct hl_device *hdev)
  */
 static void goya_disable_internal_queues(struct hl_device *hdev)
 {
+	struct goya_device *goya = hdev->asic_specific;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_MME))
+		goto disable_tpc;
+
 	WREG32(mmMME_QM_GLBL_CFG0, 0);
 	WREG32(mmMME_CMDQ_GLBL_CFG0, 0);
 
+disable_tpc:
+	if (!(goya->hw_cap_initialized & HW_CAP_TPC))
+		return;
+
 	WREG32(mmTPC0_QM_GLBL_CFG0, 0);
 	WREG32(mmTPC0_CMDQ_GLBL_CFG0, 0);
 
@@ -1782,8 +1801,12 @@ static void goya_disable_internal_queues(struct hl_device *hdev)
  */
 static int goya_stop_internal_queues(struct hl_device *hdev)
 {
+	struct goya_device *goya = hdev->asic_specific;
 	int rc, retval = 0;
 
+	if (!(goya->hw_cap_initialized & HW_CAP_MME))
+		goto stop_tpc;
+
 	/*
 	 * Each queue (QMAN) is a separate H/W logic. That means that each
 	 * QMAN can be stopped independently and failure to stop one does NOT
@@ -1810,6 +1833,10 @@ static int goya_stop_internal_queues(struct hl_device *hdev)
 		retval = -EIO;
 	}
 
+stop_tpc:
+	if (!(goya->hw_cap_initialized & HW_CAP_TPC))
+		return retval;
+
 	rc = goya_stop_queue(hdev,
 			mmTPC0_QM_GLBL_CFG1,
 			mmTPC0_QM_CP_STS,
@@ -1975,6 +2002,11 @@ static int goya_stop_internal_queues(struct hl_device *hdev)
 
 static void goya_dma_stall(struct hl_device *hdev)
 {
+	struct goya_device *goya = hdev->asic_specific;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_DMA))
+		return;
+
 	WREG32(mmDMA_QM_0_GLBL_CFG1, 1 << DMA_QM_0_GLBL_CFG1_DMA_STOP_SHIFT);
 	WREG32(mmDMA_QM_1_GLBL_CFG1, 1 << DMA_QM_1_GLBL_CFG1_DMA_STOP_SHIFT);
 	WREG32(mmDMA_QM_2_GLBL_CFG1, 1 << DMA_QM_2_GLBL_CFG1_DMA_STOP_SHIFT);
@@ -1984,6 +2016,11 @@ static void goya_dma_stall(struct hl_device *hdev)
 
 static void goya_tpc_stall(struct hl_device *hdev)
 {
+	struct goya_device *goya = hdev->asic_specific;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_TPC))
+		return;
+
 	WREG32(mmTPC0_CFG_TPC_STALL, 1 << TPC0_CFG_TPC_STALL_V_SHIFT);
 	WREG32(mmTPC1_CFG_TPC_STALL, 1 << TPC1_CFG_TPC_STALL_V_SHIFT);
 	WREG32(mmTPC2_CFG_TPC_STALL, 1 << TPC2_CFG_TPC_STALL_V_SHIFT);
@@ -1996,6 +2033,11 @@ static void goya_tpc_stall(struct hl_device *hdev)
 
 static void goya_mme_stall(struct hl_device *hdev)
 {
+	struct goya_device *goya = hdev->asic_specific;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_MME))
+		return;
+
 	WREG32(mmMME_STALL, 0xFFFFFFFF);
 }
 
-- 
2.17.1

