Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CF2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87853218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEuGO2Qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfCUOnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:43:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43228 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbfCUOno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:43:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id d17so6875995wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7P3PdNNqKMof5g9sOz3AHdBdnqk7YOX4LLBH/cO3iik=;
        b=YEuGO2QjOipEx235sMZf6+mrHv1HGsFAFsm1hZWjgHnTODDxzXR8rn1wa/2rYE3MQQ
         25XYYntY/MPuTDSNJpoCG391DrChB/potVpM1oHtYTUvvtEQkZdDqTdZTWId6bGF51dX
         3xmTUzEerX9Ev70gwRkFBf9GQQaqzFBSPX0mY6m8/ab6+qvR7xEDBfCIhjKBaZWfIW0P
         gyWYJ1tTl4GF4c6o4JQsOT9v1nn8sZ1TYHh9tYmWYWe6jh3jGuyZ0nOuBFG5xcuEZp4C
         qgj/EANJu1+fXoGTyfIGO4/jJEZEflXuRvXL1mrMZJn4UE4q76OMsVYP9Ui/bPxrJKb9
         hOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7P3PdNNqKMof5g9sOz3AHdBdnqk7YOX4LLBH/cO3iik=;
        b=Va7UUWlSRjHmHCnNmJqW5e+Muv4i4EJTGSXPwP8gxkX3gpvA3J583sEv4yUGoBPrLi
         gfnAiAFUYG/tdRq58uwEGiAj2PkxrgX1/MpSA+iNijoxRFKwRUZVdqOph3f/xWGHBTZY
         0JnLPxIY1HORijgLVloh3HCw3qebbNEaBF9gmJDbKglCXAr1rxnO9UUPCtAN+JSyExIw
         chtTdehI8qn3QU1hae/CBEO7JXDZurTByGpkjP2w56m/5Ko+ZcBsWGzIodf5gZHTY/dK
         KmkO1zwGPuSwals0BxvMwxeIz6gwJIEmjZ0J9aUj5U7AnPJECu4mE19cwO/f/kOqD9GI
         jBgA==
X-Gm-Message-State: APjAAAXtc4h7MVgVB7QO/QZoFDsoO1ZzHkaAIfK3+KlN6MC7a9kTqBqV
        XMbLCWh6nXSSJ1GXz6gCDCdbMz0H
X-Google-Smtp-Source: APXvYqw/D7l5hPn2RYGZiZ3z/nGjvlC5M4kwH7GO4FrJpqnmwY8UOEJXgK8Z3U3cWLwf4lbRIqUouA==
X-Received: by 2002:adf:dc07:: with SMTP id t7mr2777243wri.290.1553179422390;
        Thu, 21 Mar 2019 07:43:42 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id g3sm5075409wmk.32.2019.03.21.07.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 07:43:41 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Dalit Ben Zoor <dbenzoor@habana.ai>
Subject: [PATCH 2/2] habanalabs: allow user to modify TPC clock relaxation value
Date:   Thu, 21 Mar 2019 16:43:35 +0200
Message-Id: <20190321144335.32299-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190321144335.32299-1-oded.gabbay@gmail.com>
References: <20190321144335.32299-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dalit Ben Zoor <dbenzoor@habana.ai>

This patch allows the user to modify the TPC PLL clock relaxation value
on-the-fly in order to reduce power consumption.

To enable this, the patch removes the protection from the specific
register that controls this behavior.

Signed-off-by: Dalit Ben Zoor <dbenzoor@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya_security.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya_security.c b/drivers/misc/habanalabs/goya/goya_security.c
index 9d2dee67e46f..d95d1b2f860d 100644
--- a/drivers/misc/habanalabs/goya/goya_security.c
+++ b/drivers/misc/habanalabs/goya/goya_security.c
@@ -2160,6 +2160,8 @@ static void goya_init_protection_bits(struct hl_device *hdev)
 	 * Bits 7-11 represents the word offset inside the 128 bytes.
 	 * Bits 2-6 represents the bit location inside the word.
 	 */
+	u32 pb_addr, mask;
+	u8 word_offset;
 
 	goya_pb_set_block(hdev, mmPCI_NRTR_BASE);
 	goya_pb_set_block(hdev, mmPCI_RD_REGULATOR_BASE);
@@ -2238,6 +2240,14 @@ static void goya_init_protection_bits(struct hl_device *hdev)
 	goya_pb_set_block(hdev, mmPCIE_AUX_BASE);
 	goya_pb_set_block(hdev, mmPCIE_DB_RSV_BASE);
 	goya_pb_set_block(hdev, mmPCIE_PHY_BASE);
+	goya_pb_set_block(hdev, mmTPC0_NRTR_BASE);
+	goya_pb_set_block(hdev, mmTPC_PLL_BASE);
+
+	pb_addr = (mmTPC_PLL_CLK_RLX_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC_PLL_CLK_RLX_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC_PLL_CLK_RLX_0 & 0x7C) >> 2);
+
+	WREG32(pb_addr + word_offset, mask);
 
 	goya_init_mme_protection_bits(hdev);
 
@@ -2295,8 +2305,8 @@ void goya_init_security(struct hl_device *hdev)
 	u32 lbw_rng10_base = 0xFCC60000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
 	u32 lbw_rng10_mask = 0xFFFE0000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
 
-	u32 lbw_rng11_base = 0xFCE00000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
-	u32 lbw_rng11_mask = 0xFFFFC000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+	u32 lbw_rng11_base = 0xFCE02000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+	u32 lbw_rng11_mask = 0xFFFFE000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
 
 	u32 lbw_rng12_base = 0xFE484000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
 	u32 lbw_rng12_mask = 0xFFFFF000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
-- 
2.17.1

