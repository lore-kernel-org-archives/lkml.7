Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B73DC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A322077C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAq5nLtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfKJVzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 16:55:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51362 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfKJVzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:55:40 -0500
Received: by mail-wm1-f65.google.com with SMTP id q70so11326167wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 13:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FPknVP1pzsawPJP1ZdjlTvX6W+VJFOTosELnN1o3VuM=;
        b=gAq5nLtmVWiri8ovlL09VrRaEX2jKQ9ohB0PmKd4Fn2UTBiOdUZbn7d9E/+JY662/W
         bCECnxvwPoC5YVQQLq/TS5sfMrAP2R1PsugaFJI/9dbMCpZJUmKr94KryaYJQAWzvFam
         7XNJLHUxuungjI2F4n0vDaldQLBzSsW1/durZEl4dtw2htl8VnQcKXzledwbPcfKARwf
         Ms527SyRdKf7B00AbbZNLQSybsJWdTpWin9U0KTqNP3MuK9UHujVzu3wQXMrXWibT9B0
         SSbP6GwE1w0JdJgOyjqrdVXSd9E/+p9XjMulIuIdrW79IicKrnvt0ggahjGjBVYJvkiI
         DhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FPknVP1pzsawPJP1ZdjlTvX6W+VJFOTosELnN1o3VuM=;
        b=PXy+RnIagf6dlpw0IlZHGjvoq7A7P/ux429fkHeeKonNAgJgUvUWjOUcz/zafy7d+f
         NfJb4gpShUf2GNd1VlrrBl8P6Ign9m+Hv6ZhY/hdyFzgOeBVa/mUBtTXzkXGsEE/1+No
         cqqKL1wqFCP44eBY6cbPjNtRhsBRVOKeEQ3SDDvjppdoiZ+vRudXJJrrimic6+yrzBsJ
         Uas7vkb9vhPlZ9vXgqV75oMMZIXjUtRHzRQl03xxxLJ4NU+fmF1KuhO1MUw4AdigR5uf
         ztdGf6pccGmon0HvjJZqSUe2DF3jYA8/4nVHMH6oHKcyqL7/RONxNn5pXZQVKqrLt8Sh
         Oqiw==
X-Gm-Message-State: APjAAAXgJRb4pp51XK+V9yPT55O0hdjIWCQqZ6FUURQwNleIRsVOrtjD
        Cznaf6yE03o3MCmEepuncdhXR+K0Gnw=
X-Google-Smtp-Source: APXvYqyUr+gkD3r9NUFJe2PsF3bFb/2OGSeXd1mTLU8IzCSIU74wPgnyx7ceJESHo7adaXQujYZgfw==
X-Received: by 2002:a1c:67d7:: with SMTP id b206mr17058850wmc.68.1573422936814;
        Sun, 10 Nov 2019 13:55:36 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id d11sm14555824wrn.28.2019.11.10.13.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 13:55:36 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/6] habanalabs: use registers name defines for ETR block
Date:   Sun, 10 Nov 2019 23:55:29 +0200
Message-Id: <20191110215533.754-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191110215533.754-1-oded.gabbay@gmail.com>
References: <20191110215533.754-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a single ETR block in the SOC, so use explicit register
name defines for initializing this block. This makes it more readable and
maintainable.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya_coresight.c |  51 ++++----
 .../include/goya/asic_reg/goya_regs.h         |   1 +
 .../include/goya/asic_reg/psoc_etr_regs.h     | 114 ++++++++++++++++++
 3 files changed, 140 insertions(+), 26 deletions(-)
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_etr_regs.h

diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/habanalabs/goya/goya_coresight.c
index b4d406af1bed..16bcd60b111f 100644
--- a/drivers/misc/habanalabs/goya/goya_coresight.c
+++ b/drivers/misc/habanalabs/goya/goya_coresight.c
@@ -377,33 +377,32 @@ static int goya_config_etr(struct hl_device *hdev,
 		struct hl_debug_params *params)
 {
 	struct hl_debug_params_etr *input;
-	u64 base_reg = mmPSOC_ETR_BASE - CFG_BASE;
 	u32 val;
 	int rc;
 
-	WREG32(base_reg + 0xFB0, CORESIGHT_UNLOCK);
+	WREG32(mmPSOC_ETR_LAR, CORESIGHT_UNLOCK);
 
-	val = RREG32(base_reg + 0x304);
+	val = RREG32(mmPSOC_ETR_FFCR);
 	val |= 0x1000;
-	WREG32(base_reg + 0x304, val);
+	WREG32(mmPSOC_ETR_FFCR, val);
 	val |= 0x40;
-	WREG32(base_reg + 0x304, val);
+	WREG32(mmPSOC_ETR_FFCR, val);
 
-	rc = goya_coresight_timeout(hdev, base_reg + 0x304, 6, false);
+	rc = goya_coresight_timeout(hdev, mmPSOC_ETR_FFCR, 6, false);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to %s ETR on timeout, error %d\n",
 				params->enable ? "enable" : "disable", rc);
 		return rc;
 	}
 
-	rc = goya_coresight_timeout(hdev, base_reg + 0xC, 2, true);
+	rc = goya_coresight_timeout(hdev, mmPSOC_ETR_STS, 2, true);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to %s ETR on timeout, error %d\n",
 				params->enable ? "enable" : "disable", rc);
 		return rc;
 	}
 
-	WREG32(base_reg + 0x20, 0);
+	WREG32(mmPSOC_ETR_CTL, 0);
 
 	if (params->enable) {
 		input = params->input;
@@ -423,25 +422,25 @@ static int goya_config_etr(struct hl_device *hdev,
 			return -EINVAL;
 		}
 
-		WREG32(base_reg + 0x34, 0x3FFC);
-		WREG32(base_reg + 0x4, input->buffer_size);
-		WREG32(base_reg + 0x28, input->sink_mode);
-		WREG32(base_reg + 0x110, 0x700);
-		WREG32(base_reg + 0x118,
+		WREG32(mmPSOC_ETR_BUFWM, 0x3FFC);
+		WREG32(mmPSOC_ETR_RSZ, input->buffer_size);
+		WREG32(mmPSOC_ETR_MODE, input->sink_mode);
+		WREG32(mmPSOC_ETR_AXICTL, 0x700);
+		WREG32(mmPSOC_ETR_DBALO,
 				lower_32_bits(input->buffer_address));
-		WREG32(base_reg + 0x11C,
+		WREG32(mmPSOC_ETR_DBAHI,
 				upper_32_bits(input->buffer_address));
-		WREG32(base_reg + 0x304, 3);
-		WREG32(base_reg + 0x308, 0xA);
-		WREG32(base_reg + 0x20, 1);
+		WREG32(mmPSOC_ETR_FFCR, 3);
+		WREG32(mmPSOC_ETR_PSCR, 0xA);
+		WREG32(mmPSOC_ETR_CTL, 1);
 	} else {
-		WREG32(base_reg + 0x34, 0);
-		WREG32(base_reg + 0x4, 0x400);
-		WREG32(base_reg + 0x118, 0);
-		WREG32(base_reg + 0x11C, 0);
-		WREG32(base_reg + 0x308, 0);
-		WREG32(base_reg + 0x28, 0);
-		WREG32(base_reg + 0x304, 0);
+		WREG32(mmPSOC_ETR_BUFWM, 0);
+		WREG32(mmPSOC_ETR_RSZ, 0x400);
+		WREG32(mmPSOC_ETR_DBALO, 0);
+		WREG32(mmPSOC_ETR_DBAHI, 0);
+		WREG32(mmPSOC_ETR_PSCR, 0);
+		WREG32(mmPSOC_ETR_MODE, 0);
+		WREG32(mmPSOC_ETR_FFCR, 0);
 
 		if (params->output_size >= sizeof(u64)) {
 			u32 rwp, rwphi;
@@ -451,8 +450,8 @@ static int goya_config_etr(struct hl_device *hdev,
 			 * the buffer is set in the RWP register (lower 32
 			 * bits), and in the RWPHI register (upper 8 bits).
 			 */
-			rwp = RREG32(base_reg + 0x18);
-			rwphi = RREG32(base_reg + 0x3c) & 0xff;
+			rwp = RREG32(mmPSOC_ETR_RWP);
+			rwphi = RREG32(mmPSOC_ETR_RWPHI) & 0xff;
 			*(u64 *) params->output = ((u64) rwphi << 32) | rwp;
 		}
 	}
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h
index 19b0f0ef1d0b..fce490e6a231 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h
@@ -84,6 +84,7 @@
 #include "tpc6_rtr_regs.h"
 #include "tpc7_nrtr_regs.h"
 #include "tpc0_eml_cfg_regs.h"
+#include "psoc_etr_regs.h"
 
 #include "psoc_global_conf_masks.h"
 #include "dma_macro_masks.h"
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/psoc_etr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/psoc_etr_regs.h
new file mode 100644
index 000000000000..b7c33e025db5
--- /dev/null
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/psoc_etr_regs.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+/************************************
+ ** This is an auto-generated file **
+ **       DO NOT EDIT BELOW        **
+ ************************************/
+
+#ifndef ASIC_REG_PSOC_ETR_REGS_H_
+#define ASIC_REG_PSOC_ETR_REGS_H_
+
+/*
+ *****************************************
+ *   PSOC_ETR (Prototype: ETR)
+ *****************************************
+ */
+
+#define mmPSOC_ETR_RSZ                                               0x2C43004
+
+#define mmPSOC_ETR_STS                                               0x2C4300C
+
+#define mmPSOC_ETR_RRD                                               0x2C43010
+
+#define mmPSOC_ETR_RRP                                               0x2C43014
+
+#define mmPSOC_ETR_RWP                                               0x2C43018
+
+#define mmPSOC_ETR_TRG                                               0x2C4301C
+
+#define mmPSOC_ETR_CTL                                               0x2C43020
+
+#define mmPSOC_ETR_RWD                                               0x2C43024
+
+#define mmPSOC_ETR_MODE                                              0x2C43028
+
+#define mmPSOC_ETR_LBUFLEVEL                                         0x2C4302C
+
+#define mmPSOC_ETR_CBUFLEVEL                                         0x2C43030
+
+#define mmPSOC_ETR_BUFWM                                             0x2C43034
+
+#define mmPSOC_ETR_RRPHI                                             0x2C43038
+
+#define mmPSOC_ETR_RWPHI                                             0x2C4303C
+
+#define mmPSOC_ETR_AXICTL                                            0x2C43110
+
+#define mmPSOC_ETR_DBALO                                             0x2C43118
+
+#define mmPSOC_ETR_DBAHI                                             0x2C4311C
+
+#define mmPSOC_ETR_FFSR                                              0x2C43300
+
+#define mmPSOC_ETR_FFCR                                              0x2C43304
+
+#define mmPSOC_ETR_PSCR                                              0x2C43308
+
+#define mmPSOC_ETR_ITMISCOP0                                         0x2C43EE0
+
+#define mmPSOC_ETR_ITTRFLIN                                          0x2C43EE8
+
+#define mmPSOC_ETR_ITATBDATA0                                        0x2C43EEC
+
+#define mmPSOC_ETR_ITATBCTR2                                         0x2C43EF0
+
+#define mmPSOC_ETR_ITATBCTR1                                         0x2C43EF4
+
+#define mmPSOC_ETR_ITATBCTR0                                         0x2C43EF8
+
+#define mmPSOC_ETR_ITCTRL                                            0x2C43F00
+
+#define mmPSOC_ETR_CLAIMSET                                          0x2C43FA0
+
+#define mmPSOC_ETR_CLAIMCLR                                          0x2C43FA4
+
+#define mmPSOC_ETR_LAR                                               0x2C43FB0
+
+#define mmPSOC_ETR_LSR                                               0x2C43FB4
+
+#define mmPSOC_ETR_AUTHSTATUS                                        0x2C43FB8
+
+#define mmPSOC_ETR_DEVID                                             0x2C43FC8
+
+#define mmPSOC_ETR_DEVTYPE                                           0x2C43FCC
+
+#define mmPSOC_ETR_PERIPHID4                                         0x2C43FD0
+
+#define mmPSOC_ETR_PERIPHID5                                         0x2C43FD4
+
+#define mmPSOC_ETR_PERIPHID6                                         0x2C43FD8
+
+#define mmPSOC_ETR_PERIPHID7                                         0x2C43FDC
+
+#define mmPSOC_ETR_PERIPHID0                                         0x2C43FE0
+
+#define mmPSOC_ETR_PERIPHID1                                         0x2C43FE4
+
+#define mmPSOC_ETR_PERIPHID2                                         0x2C43FE8
+
+#define mmPSOC_ETR_PERIPHID3                                         0x2C43FEC
+
+#define mmPSOC_ETR_COMPID0                                           0x2C43FF0
+
+#define mmPSOC_ETR_COMPID1                                           0x2C43FF4
+
+#define mmPSOC_ETR_COMPID2                                           0x2C43FF8
+
+#define mmPSOC_ETR_COMPID3                                           0x2C43FFC
+
+#endif /* ASIC_REG_PSOC_ETR_REGS_H_ */
-- 
2.17.1

