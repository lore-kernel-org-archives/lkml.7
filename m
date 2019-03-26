Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE87C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14A52084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf+3cv8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbfCZSlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:41:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37562 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732505AbfCZSlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:41:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so14105941wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PvUQahNJhYf+gTU/ujRm8uJG/+oIHhtjoLH2yi6xPx0=;
        b=Hf+3cv8yV87ozjaVp33QeQP7MyzPkt385zd31qv5HFxMpu2sbyKlOwpxhnDdafG2g5
         oNfJDJn4a5tCCxACjIh305F0dyEqJeiU28SlA2xVA5fCCfZ/5KxWEVPjoO9YZoDfbQ91
         /PmyK/51a3F7uOaP9cuK5sntvKBfsyjAcfetaI6o7MwVz9mllbePzeWDnWv9Wj5smzMn
         rkuoJnvT8pxaPAH+I+KNh+4a1h+J18yUE9gcmrOvXPHvYMj9ZLBwuWv88MaAfo3O1htZ
         hZDPBOIbsUlt1wDFkq1OQc/lIlsfFZT6L+HLsFjP6wcr/SIRCMjMM2LmSN5p3GAaVvPh
         DJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PvUQahNJhYf+gTU/ujRm8uJG/+oIHhtjoLH2yi6xPx0=;
        b=Hz2m1pOAzXIeFVC77Ngyc7v8BBIvfTR5B4FQ4iPIIzZj7V/W2Bb7sqBPQUfPK++s13
         rO+zqtyyRJXEFFBYIdQSJyyK2eCvFSLb1ZKpz/7HBm9MEOTN3Ko8P+PN2dA6TFttG4KP
         eksXwN/i+8e3irkm32pxPykl9Fc8Zdgn7HzOjpmq7uTeLc1vw91WSVRpoUb3ckfVH5nh
         QwRkFtlXv40/2uviUhomPFwyVOnWbLJ1uIZs+plAM9BbwdVDlrYhKxCMuFVmagR4knNX
         HUlT/PT9s3QRtCyL9ILw4r5CL9u9P3TKW5/xNWj2LARnRBhV/VlS4jW3zAV4SiNTbMzE
         u5Hw==
X-Gm-Message-State: APjAAAXMqf0FBnyFNl+7M60UnsXH+86hf0TVHHr6DZGowEKtEgMXiq7l
        bUCbig5OINjxMkWO182v4Xfy3iXu
X-Google-Smtp-Source: APXvYqxaQCTUNvlLbneCoJhkpkR1ipISQbXSCgrWto8HUiDtpm3W+6aZiL4OTyF/Uhj0bV79+Pai2w==
X-Received: by 2002:a7b:c446:: with SMTP id l6mr12145261wmi.80.1553625699916;
        Tue, 26 Mar 2019 11:41:39 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id 84sm33097893wme.43.2019.03.26.11.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 11:41:39 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: do not limit credits of DMA #0
Date:   Tue, 26 Mar 2019 20:41:37 +0200
Message-Id: <20190326184137.22354-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because DMA #0 is now used by the user, remove the limitation of credits
from this channel. Without this patch, this channel is pretty much
unusable due to its very low bandwidth configuration.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index ea979ebd62fb..3c509e19d69d 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -1688,12 +1688,11 @@ static void goya_init_golden_registers(struct hl_device *hdev)
 
 	/*
 	 * Workaround for H2 #HW-23 bug
-	 * Set DMA max outstanding read requests to 240 on DMA CH 1. Set it
-	 * to 16 on KMD DMA
-	 * We need to limit only these DMAs because the user can only read
+	 * Set DMA max outstanding read requests to 240 on DMA CH 1.
+	 * This limitation is still large enough to not affect Gen4 bandwidth.
+	 * We need to only limit that DMA channel because the user can only read
 	 * from Host using DMA CH 1
 	 */
-	WREG32(mmDMA_CH_0_CFG0, 0x0fff0010);
 	WREG32(mmDMA_CH_1_CFG0, 0x0fff00F0);
 
 	goya->hw_cap_initialized |= HW_CAP_GOLDEN;
@@ -3693,7 +3692,7 @@ static int goya_validate_dma_pkt_mmu(struct hl_device *hdev,
 	 * WA for HW-23.
 	 * We can't allow user to read from Host using QMANs other than 1.
 	 */
-	if (parser->hw_queue_id > GOYA_QUEUE_ID_DMA_1 &&
+	if (parser->hw_queue_id != GOYA_QUEUE_ID_DMA_1 &&
 		hl_mem_area_inside_range(le64_to_cpu(user_dma_pkt->src_addr),
 				le32_to_cpu(user_dma_pkt->tsize),
 				hdev->asic_prop.va_space_host_start_address,
-- 
2.17.1

