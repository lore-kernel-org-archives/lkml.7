Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CF6C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 19:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D8F2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 19:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6HW/JGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfELTAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 15:00:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33576 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfELTAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 15:00:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id d9so4462537wrx.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 12:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4urwEDJQNqPEwhN1b/gF1MpSofPjWEyq6Rjkj7dblW4=;
        b=I6HW/JGtea1AyPWuAHywMQmHgAR1WzZjj19gzl2M9VrKaD/QenUUlT7QDLSWdNyAz4
         ro16I/axl4DNwDeHBzXgWBDKPeDDZdn3Qt94JS4zpBLkP8waCIBCRALXpgLrHAVEx4o6
         HkoMRkT6I1xCCCdbvSd/D2nXaI6XbYyDqRAsmXxBkOfnchTh5Tz7GmEfIq4iRIRdzXiI
         UKFOKsGH1eZB6A+ifARD9UbBnAeQ0MxXkf3Rz4WYr7UbzGnFVB+b/jAcKdERD7HxxgyA
         kEG+2uf1P3R+4PHPtsa+FJWiFHjJNDCtSxnt6RT4dA5IhCAZMvykXCvkgb0BJsAzjTmz
         6k0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4urwEDJQNqPEwhN1b/gF1MpSofPjWEyq6Rjkj7dblW4=;
        b=ITvYiMFNq6aFIUaKyDcAS2A854AFOrKzKWaHJHzf96oAPZAktde6aDlsMW7va4E8K0
         ySpm8+/vqGQQrnZ/WWAWLyrY/esQpFqJ+/GggNgsL1gEpCmi6JqqMO/TYiyqCCsbmh07
         rggXy3ziUFMY3bTFzQScse4pOC/BNi+tUPNyqWJJ0Iimatx9Q5834UF3Y6f5lPMAjWUk
         jEr5yER7nLNEJzj4MAwIlb2WPDVLnXIcf5NHioc7HeDrV53/u1qklYpKTK7fPx3efijW
         oq3H4X+E8UhD+OW/dI8I2NacRe+33r/sVpgt1uKBywn7p+3PjCYTMXkeB9S8x0Tmj7dc
         bbBQ==
X-Gm-Message-State: APjAAAUiccXBWV89E75M5zoQ9X04+RR9g4Lsi1uSZao183D0mDN3983s
        N0WrvTG51ehQv7d4D0FOcsWnI4Pb
X-Google-Smtp-Source: APXvYqyVFEkEErr3BUr+jQtvZtrsnakW/LGJXtYcJZsBuX76jUXL7PHMr/5hyo5SfRurfv38ly98vw==
X-Received: by 2002:adf:f208:: with SMTP id p8mr8356099wro.160.1557687635045;
        Sun, 12 May 2019 12:00:35 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id i17sm10421862wrr.46.2019.05.12.12.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 12:00:34 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: pass device pointer to asic-specific function
Date:   Sun, 12 May 2019 22:00:32 +0300
Message-Id: <20190512190032.31443-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new parameter that is passed to the
add_end_of_cb_packets() asic-specific function.

The parameter is the pointer to the driver's device structure. The
function needs this pointer for future ASICs.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c  | 4 ++--
 drivers/misc/habanalabs/goya/goyaP.h | 4 ++--
 drivers/misc/habanalabs/habanalabs.h | 5 +++--
 drivers/misc/habanalabs/hw_queue.c   | 2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index ffc7997d4898..0c8e8bc7fb6e 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3888,8 +3888,8 @@ int goya_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser)
 		return goya_parse_cb_no_mmu(hdev, parser);
 }
 
-void goya_add_end_of_cb_packets(u64 kernel_address, u32 len, u64 cq_addr,
-				u32 cq_val, u32 msix_vec)
+void goya_add_end_of_cb_packets(struct hl_device *hdev, u64 kernel_address,
+				u32 len, u64 cq_addr, u32 cq_val, u32 msix_vec)
 {
 	struct packet_msg_prot *cq_pkt;
 	u32 tmp;
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index c83cab0d641e..066b1d306977 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -214,8 +214,8 @@ int goya_resume(struct hl_device *hdev);
 void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry);
 void *goya_get_events_stat(struct hl_device *hdev, u32 *size);
 
-void goya_add_end_of_cb_packets(u64 kernel_address, u32 len, u64 cq_addr,
-				u32 cq_val, u32 msix_vec);
+void goya_add_end_of_cb_packets(struct hl_device *hdev, u64 kernel_address,
+				u32 len, u64 cq_addr, u32 cq_val, u32 msix_vec);
 int goya_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser);
 void *goya_get_int_queue_base(struct hl_device *hdev, u32 queue_id,
 				dma_addr_t *dma_handle,	u16 *queue_len);
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 00b3339f4828..2941838c04c1 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -543,8 +543,9 @@ struct hl_asic_funcs {
 				enum dma_data_direction dir);
 	u32 (*get_dma_desc_list_size)(struct hl_device *hdev,
 					struct sg_table *sgt);
-	void (*add_end_of_cb_packets)(u64 kernel_address, u32 len, u64 cq_addr,
-					u32 cq_val, u32 msix_num);
+	void (*add_end_of_cb_packets)(struct hl_device *hdev,
+					u64 kernel_address, u32 len,
+					u64 cq_addr, u32 cq_val, u32 msix_num);
 	void (*update_eq_ci)(struct hl_device *hdev, u32 val);
 	int (*context_switch)(struct hl_device *hdev, u32 asid);
 	void (*restore_phase_topology)(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index 2894d8975933..e3b5517897ea 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -265,7 +265,7 @@ static void ext_hw_queue_schedule_job(struct hl_cs_job *job)
 	cq = &hdev->completion_queue[q->hw_queue_id];
 	cq_addr = cq->bus_address + cq->pi * sizeof(struct hl_cq_entry);
 
-	hdev->asic_funcs->add_end_of_cb_packets(cb->kernel_address, len,
+	hdev->asic_funcs->add_end_of_cb_packets(hdev, cb->kernel_address, len,
 						cq_addr,
 						__le32_to_cpu(cq_pkt.data),
 						q->hw_queue_id);
-- 
2.17.1

