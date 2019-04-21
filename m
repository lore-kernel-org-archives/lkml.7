Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363EFC282E1
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 19:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0414F2087B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 19:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAFi47os"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfDUTin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 15:38:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51177 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfDUTim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 15:38:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so12305168wmi.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dWoJ2ylhC6lOG4UHtK392ndHfnAdnEHTuXwru9rHZcQ=;
        b=XAFi47osu3+aak7CTfyFagCbldNOyXdgnMnIXrBoHkWI+ImErOvz1XRUTjL/bzs886
         W/TtWISkAUTdTkOeo5WcVBsVAFxwr83YtRJldeq6ySpEhitW08inGSWBd/yuLynmTkOU
         wKKX4fbBO9+EgfsNwhzVd7Erbs0IpRTOnb0L9zb6AGLJ3YinuoihsWAEIGeaBMFKRrni
         YIbVETbdMlaza7z1AmECOHQ3OmIAhD8XrSvsiAqwceFGrDJUeo4ZozyisGNM6BlgSW9b
         06Cd0+/gaNTdqSDm/PT5ql0q7INnQFEccps38QuwiWGQdkSnnguT69OxZitxOS8VFXUK
         Ywqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dWoJ2ylhC6lOG4UHtK392ndHfnAdnEHTuXwru9rHZcQ=;
        b=mLNB7P9A5H+OIVM85wlP38sziiAcJDDv3WfSb1pcj99gTs5IwvQEwLB+HErKUU8Cbu
         sOj+NDu5mPx5PsbIqk/tIxEczRGdtsEdRFIBOLgOBlYuZKgc523TpP6nHmS+i4fK7FGT
         D25ijX+orlhV5ypd0MGfuYnY01HjQnvqy9VFpurFaXrrEOdAGq9TNIKunFP0giWJszyn
         Pkv5qbs3F07qlq5d3lmfszipzvUUS0k421nxS7xwyXoLFIteGtGxiqHFPxpTuGGmtd97
         BS6r89joPl8sFoSipCqaJwoXZe0GW59dRbF6ZSgsw1ax46/tCBrTVQ/RWbAufRDv/cQd
         5WPA==
X-Gm-Message-State: APjAAAW3A0Ah5bEnKahB/zqa3QHR9P2XU1A3EAGgEACJoRJy+3paeDT3
        +Q1uE7SaWqS1b0rouF8LtbZmW90H
X-Google-Smtp-Source: APXvYqz4NJftl589t8Ah4jCAvuFC61lf8xMvRAcLsWyiSe0FBlIeA+AUALlMkH/6RpboN3nnRvDD8Q==
X-Received: by 2002:a1c:b088:: with SMTP id z130mr9458990wme.5.1555875520325;
        Sun, 21 Apr 2019 12:38:40 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id v192sm10342571wme.24.2019.04.21.12.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 12:38:39 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/2] uapi/habanalabs: add missing fields in bmon params
Date:   Sun, 21 Apr 2019 22:38:37 +0300
Message-Id: <20190421193837.24289-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190421193837.24289-1-oded.gabbay@gmail.com>
References: <20190421193837.24289-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing fields of start address 0 and 1 in the bmon
parameter structure that is received from the user in the debug IOCTL.

Without these fields, the functionality of the bmon trace is broken,
because there is no configuration of the base address of the filter of the
bus monitor.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya_coresight.c | 16 ++++++++++++----
 include/uapi/misc/habanalabs.h                |  9 ++++++---
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/habanalabs/goya/goya_coresight.c
index 68726fb4c56a..1ac951f52d1e 100644
--- a/drivers/misc/habanalabs/goya/goya_coresight.c
+++ b/drivers/misc/habanalabs/goya/goya_coresight.c
@@ -459,10 +459,14 @@ static int goya_config_bmon(struct hl_device *hdev,
 		if (!input)
 			return -EINVAL;
 
-		WREG32(base_reg + 0x208, lower_32_bits(input->addr_range0));
-		WREG32(base_reg + 0x20C, upper_32_bits(input->addr_range0));
-		WREG32(base_reg + 0x248, lower_32_bits(input->addr_range1));
-		WREG32(base_reg + 0x24C, upper_32_bits(input->addr_range1));
+		WREG32(base_reg + 0x200, lower_32_bits(input->start_addr0));
+		WREG32(base_reg + 0x204, upper_32_bits(input->start_addr0));
+		WREG32(base_reg + 0x208, lower_32_bits(input->addr_mask0));
+		WREG32(base_reg + 0x20C, upper_32_bits(input->addr_mask0));
+		WREG32(base_reg + 0x240, lower_32_bits(input->start_addr1));
+		WREG32(base_reg + 0x244, upper_32_bits(input->start_addr1));
+		WREG32(base_reg + 0x248, lower_32_bits(input->addr_mask1));
+		WREG32(base_reg + 0x24C, upper_32_bits(input->addr_mask1));
 		WREG32(base_reg + 0x224, 0);
 		WREG32(base_reg + 0x234, 0);
 		WREG32(base_reg + 0x30C, input->bw_win);
@@ -482,8 +486,12 @@ static int goya_config_bmon(struct hl_device *hdev,
 		WREG32(base_reg + 0x100, 0x11);
 		WREG32(base_reg + 0x304, 0x1);
 	} else {
+		WREG32(base_reg + 0x200, 0);
+		WREG32(base_reg + 0x204, 0);
 		WREG32(base_reg + 0x208, 0xFFFFFFFF);
 		WREG32(base_reg + 0x20C, 0xFFFFFFFF);
+		WREG32(base_reg + 0x240, 0);
+		WREG32(base_reg + 0x244, 0);
 		WREG32(base_reg + 0x248, 0xFFFFFFFF);
 		WREG32(base_reg + 0x24C, 0xFFFFFFFF);
 		WREG32(base_reg + 0x224, 0xFFFFFFFF);
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 613d431da783..8ac292cf4d00 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -374,9 +374,12 @@ struct hl_debug_params_stm {
 };
 
 struct hl_debug_params_bmon {
-	/* Transaction address filter */
-	__u64 addr_range0;
-	__u64 addr_range1;
+	/* Two address ranges that the user can request to filter */
+	__u64 start_addr0;
+	__u64 addr_mask0;
+
+	__u64 start_addr1;
+	__u64 addr_mask1;
 
 	/* Capture window configuration */
 	__u32 bw_win;
-- 
2.17.1

