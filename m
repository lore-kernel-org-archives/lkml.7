Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06F9C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4A12085A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSQryLlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfHJMaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 08:30:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39123 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfHJMaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 08:30:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so10471010wra.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 05:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cdFqBFBufTN82PZwZEC+Ofd7tczydux0cmgP6YoJpMI=;
        b=OSQryLlgOC56c1xvFiFA5jY+XHKPhjIuvHWYeH+kACZx95nd22sEC0LnLJcMiE1289
         sNSbXZT9VVFbNqzmc1KCl8BG/BXiMYzbcVf6mVj1strmxDCB51lxl2YTQBpJBPxM6FN8
         cMmYprs+CELVIJ/9v67m45/lHszkgjil7GO/Ur3eEwV82rlUZibOaj6KwUD35xE5GobM
         +z3l5YmpQ+h+jxWGLLBXp/WG5wf3rDacNZ3t0SsdvfGIE0w1DtPLEP1rYzEFgeUSaGgy
         a8ELt+HNZ+oVIMrExvH15lDBH3l6pD5Z9q5cB0zoDvf5iKBBwqpNMQt0aOdRB4QGUw8J
         uHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cdFqBFBufTN82PZwZEC+Ofd7tczydux0cmgP6YoJpMI=;
        b=RHk6BH/byDBzL477d2p9G9QM2uncuE5H2ghtmygarVfEEAm789KNKinyFZi+QCq3eh
         uTF3Tf6TkPbjYqg9y6qGIrr3qBq/1jsOfM15cite/IAtxX7lEPfdi230RgHY+CDMpd6/
         X/8zcfoE2l6Q2yE+Z/xJqZKpB09P4ztI7VdYhGR2OB8fSGJy58XYzyemxhcOWy1KnWNa
         gpCxQK4lgr0sa8yAD68KQu8Az9G4my3uDbjy0j41/myxhNtxdQy6e6mGet2dRzJj5VIB
         gObr3159x7GcQM7gEEV74rmh4YCuwlVikkkhr9ej0VWld6fp1b69RyBFsh6GsZFYaK0G
         Ja+g==
X-Gm-Message-State: APjAAAW1j4o3Gao/U88DVOP6+iJKYRBjMzPgFLLQ5CUoIJACQfopzeQG
        hcyBcoB7pK1BGRVYDoqLbF8LvbsfIGw=
X-Google-Smtp-Source: APXvYqzPBfEH9cqWCETyehep3WM335fJCkDotSKeAnaWWgWt2uMdojQ1IJ+F1ahqBp5c9KdDNoGtaA==
X-Received: by 2002:adf:ce05:: with SMTP id p5mr29759210wrn.197.1565440197685;
        Sat, 10 Aug 2019 05:29:57 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id k9sm48340057wrd.46.2019.08.10.05.29.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 05:29:57 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Ben Segal <bpsegal20@gmail.com>
Subject: [PATCH 2/2] habanalabs: fix device IRQ unmasking for BE host
Date:   Sat, 10 Aug 2019 15:29:46 +0300
Message-Id: <20190810122946.28641-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810122946.28641-1-oded.gabbay@gmail.com>
References: <20190810122946.28641-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Segal <bpsegal20@gmail.com>

When unmasking IRQs inside the ASIC, the driver passes an array of all the
IRQ to unmask. The ASIC's CPU is working in LE so when running in a BE
host, the driver needs to do the proper endianness swapping when preparing
this array.

In addition, this patch also fixes the endianness of a couple of kernel log
debug messages that print values of packets

Signed-off-by: Ben Segal <bpsegal20@gmail.com>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 33 +++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index b39b9c98fe1d..271c5c8f53b4 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3314,9 +3314,11 @@ static int goya_validate_dma_pkt_no_mmu(struct hl_device *hdev,
 	int rc;
 
 	dev_dbg(hdev->dev, "DMA packet details:\n");
-	dev_dbg(hdev->dev, "source == 0x%llx\n", user_dma_pkt->src_addr);
-	dev_dbg(hdev->dev, "destination == 0x%llx\n", user_dma_pkt->dst_addr);
-	dev_dbg(hdev->dev, "size == %u\n", user_dma_pkt->tsize);
+	dev_dbg(hdev->dev, "source == 0x%llx\n",
+		le64_to_cpu(user_dma_pkt->src_addr));
+	dev_dbg(hdev->dev, "destination == 0x%llx\n",
+		le64_to_cpu(user_dma_pkt->dst_addr));
+	dev_dbg(hdev->dev, "size == %u\n", le32_to_cpu(user_dma_pkt->tsize));
 
 	ctl = le32_to_cpu(user_dma_pkt->ctl);
 	user_dir = (ctl & GOYA_PKT_LIN_DMA_CTL_DMA_DIR_MASK) >>
@@ -3345,9 +3347,11 @@ static int goya_validate_dma_pkt_mmu(struct hl_device *hdev,
 				struct packet_lin_dma *user_dma_pkt)
 {
 	dev_dbg(hdev->dev, "DMA packet details:\n");
-	dev_dbg(hdev->dev, "source == 0x%llx\n", user_dma_pkt->src_addr);
-	dev_dbg(hdev->dev, "destination == 0x%llx\n", user_dma_pkt->dst_addr);
-	dev_dbg(hdev->dev, "size == %u\n", user_dma_pkt->tsize);
+	dev_dbg(hdev->dev, "source == 0x%llx\n",
+		le64_to_cpu(user_dma_pkt->src_addr));
+	dev_dbg(hdev->dev, "destination == 0x%llx\n",
+		le64_to_cpu(user_dma_pkt->dst_addr));
+	dev_dbg(hdev->dev, "size == %u\n", le32_to_cpu(user_dma_pkt->tsize));
 
 	/*
 	 * WA for HW-23.
@@ -3387,7 +3391,8 @@ static int goya_validate_wreg32(struct hl_device *hdev,
 
 	dev_dbg(hdev->dev, "WREG32 packet details:\n");
 	dev_dbg(hdev->dev, "reg_offset == 0x%x\n", reg_offset);
-	dev_dbg(hdev->dev, "value      == 0x%x\n", wreg_pkt->value);
+	dev_dbg(hdev->dev, "value      == 0x%x\n",
+		le32_to_cpu(wreg_pkt->value));
 
 	if (reg_offset != (mmDMA_CH_0_WR_COMP_ADDR_LO & 0x1FFF)) {
 		dev_err(hdev->dev, "WREG32 packet with illegal address 0x%x\n",
@@ -4359,6 +4364,8 @@ static int goya_unmask_irq_arr(struct hl_device *hdev, u32 *irq_arr,
 	size_t total_pkt_size;
 	long result;
 	int rc;
+	int irq_num_entries, irq_arr_index;
+	__le32 *goya_irq_arr;
 
 	total_pkt_size = sizeof(struct armcp_unmask_irq_arr_packet) +
 			irq_arr_size;
@@ -4376,8 +4383,16 @@ static int goya_unmask_irq_arr(struct hl_device *hdev, u32 *irq_arr,
 	if (!pkt)
 		return -ENOMEM;
 
-	pkt->length = cpu_to_le32(irq_arr_size / sizeof(irq_arr[0]));
-	memcpy(&pkt->irqs, irq_arr, irq_arr_size);
+	irq_num_entries = irq_arr_size / sizeof(irq_arr[0]);
+	pkt->length = cpu_to_le32(irq_num_entries);
+
+	/* We must perform any necessary endianness conversation on the irq
+	 * array being passed to the goya hardware
+	 */
+	for (irq_arr_index = 0, goya_irq_arr = (__le32 *) &pkt->irqs;
+			irq_arr_index < irq_num_entries ; irq_arr_index++)
+		goya_irq_arr[irq_arr_index] =
+				cpu_to_le32(irq_arr[irq_arr_index]);
 
 	pkt->armcp_pkt.ctl = cpu_to_le32(ARMCP_PACKET_UNMASK_RAZWI_IRQ_ARRAY <<
 						ARMCP_PKT_CTL_OPCODE_SHIFT);
-- 
2.17.1

