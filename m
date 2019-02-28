Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82076C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEA62171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jm83M5a4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbfB1Iqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:46:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38429 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731482AbfB1Iqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:46:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id g12so8876781wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 00:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=3HcwGGGGs+aYARpU4q2390f66wakgUREzlbZnWahlCc=;
        b=Jm83M5a4P4V4ZR/QZA7wzx1K0isDjTYwu2lxiADr12IbSb5TeqVYUhSDAHVcDOXBZh
         t409hj5hDoRFDaWCRqvHghwU9FpINSU9ILVlGdENwJCv+OBPv8eGyIz5i4I18NsiPPU+
         OgAEF6sW1DQCssAUzeZQET35aCnPeZobSbFJ16b8uYK8hxoo4JomoOHy9vkPAEaG6z4Z
         7pa/WsBCSU2rTLRc4LfcET/puSs2wXGOOLVgi2t0rRMfLIPcuWkfKAsC7s4Qd961HvHA
         6BXVyE6S8C+HQkdTj8vVRdWpq7YAaBAttEMdggwSQAau7QOk/yDQrFgXxDK2b9CK/5Y1
         W/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=3HcwGGGGs+aYARpU4q2390f66wakgUREzlbZnWahlCc=;
        b=TjZMshXpCmNpDXj+Di/p8KhDzCqjhbrp3gMj0kjsZjeRT2dV5okELqrt43hEyOhg0O
         posChb1EFgTYmhGcVDbhNeORgcoefGkurmspZlnTHU0GFydUj9ZY5L9D26IiTUEFl7lL
         n78wy/RcPKOi6YCjSsIXI6XBYJUJuv/GVWUHT/z6mAqvuzpu9T475imjRCm5l8Gg6vuL
         0W0YoGAFzBktBnMbM0kALMcezTQjMzq/lqNSEMEd9CekBzSJCmjBpJ8U04FY90kvNwrg
         3GYZ0aUmdzH6b3snW1ixSbV9ry+6sU4mjX+9CvEu4sXO9tOiktvvbP0YizbyWfs59Lav
         l6Kw==
X-Gm-Message-State: APjAAAXJ3kPFU/TWdGenkKxxH4wHgR+rM+ccNkHYn3dDRbNLvVV/Dgmh
        gk6ez7wVPn/u/sO64fTXvCybnXIb
X-Google-Smtp-Source: APXvYqyEHs7JspcTR82f9JAjJp9ZeldQaOjFJ5Jd5yX21ZmMbWWmEif8zn3onl6HCH7Y8pODgP+y8Q==
X-Received: by 2002:adf:e98c:: with SMTP id h12mr5662676wrm.302.1551343601217;
        Thu, 28 Feb 2019 00:46:41 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h126sm4409305wmf.2.2019.02.28.00.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 00:46:40 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] habanalabs: set DMA0 completion to SOB 1007
Date:   Thu, 28 Feb 2019 10:46:15 +0200
Message-Id: <20190228084624.25288-7-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228084624.25288-1-oded.gabbay@gmail.com>
References: <20190228084624.25288-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a bug where DMA channel 0 completion address wasn't
initialized by the driver.

The patch sets the address to Sync Object no. 1007

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c                | 14 +++++++-------
 .../habanalabs/include/goya/asic_reg/goya_regs.h   |  1 +
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 6f0075c4e935..578e4bdc3a49 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -1036,15 +1036,15 @@ static void goya_init_dma_ch(struct hl_device *hdev, int dma_id)
 	WREG32(mmDMA_CH_0_ERRMSG_WDATA + reg_off,
 			GOYA_ASYNC_EVENT_ID_DMA0_CH + dma_id);
 
-	if (dma_id) {
+	if (dma_id)
 		sob_addr = CFG_BASE + mmSYNC_MNGR_SOB_OBJ_1000 +
 				(dma_id - 1) * 4;
-		WREG32(mmDMA_CH_0_WR_COMP_ADDR_LO + reg_off,
-				lower_32_bits(sob_addr));
-		WREG32(mmDMA_CH_0_WR_COMP_ADDR_HI + reg_off,
-				upper_32_bits(sob_addr));
-		WREG32(mmDMA_CH_0_WR_COMP_WDATA + reg_off, 0x80000001);
-	}
+	else
+		sob_addr = CFG_BASE + mmSYNC_MNGR_SOB_OBJ_1007;
+
+	WREG32(mmDMA_CH_0_WR_COMP_ADDR_LO + reg_off, lower_32_bits(sob_addr));
+	WREG32(mmDMA_CH_0_WR_COMP_ADDR_HI + reg_off, upper_32_bits(sob_addr));
+	WREG32(mmDMA_CH_0_WR_COMP_WDATA + reg_off, 0x80000001);
 }
 
 /*
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h
index a3c746849f02..6cb0b6e54d41 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h
@@ -108,6 +108,7 @@
 #define mmSYNC_MNGR_MON_PAY_ADDRL_0                                  0x113000
 #define mmSYNC_MNGR_SOB_OBJ_0                                        0x112000
 #define mmSYNC_MNGR_SOB_OBJ_1000                                     0x112FA0
+#define mmSYNC_MNGR_SOB_OBJ_1007                                     0x112FBC
 #define mmSYNC_MNGR_SOB_OBJ_1023                                     0x112FFC
 #define mmSYNC_MNGR_MON_STATUS_0                                     0x114000
 #define mmSYNC_MNGR_MON_STATUS_255                                   0x1143FC
-- 
2.17.1

