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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD59DC17443
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11A020818
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uaO3/rC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfKJVzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 16:55:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38830 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfKJVzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:55:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id z19so11306567wmk.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 13:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2JxfIEcfcxkTnQ/bobYtLVeCuySIY9RZYQQJTed7N8c=;
        b=uaO3/rC0vxx2c8bxKvu8vHWU5QU8Rh2Q+7am4NqYkMDDSSYNUr21EupkOXlWVFDzJC
         IN3IWPORO4pHucXs39MoqM07+bijAJ6zhbm6sFOEWGUvQgTcndnsEHBD6pFINuiClV79
         TliQUJtG00ArcgBV1D7sme+UBu4q5wl2MdbdOklojgVuSP/wvH5WJC01ksnBX2J8fYJh
         pyIq5axjPEB/LpW3Tw8uAIeVeqhsJpFFaBy16ItGt0Cj+gihzD6QqF22fXhliiBiFqFv
         aTc+MDV9sjDbQp+DDcqtBCfxOR7YYrBX9yyEo5Is01Rz3xbqUSCeId8V6JnbBsSBU+hP
         xHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2JxfIEcfcxkTnQ/bobYtLVeCuySIY9RZYQQJTed7N8c=;
        b=f2dki6ZioCBgu9eqtOrl5v4riHjkun4vD9t3RZkYTNmXHRpFfskHghwe8ZBRA6lBzI
         BPjuwPmNsmpVkxkNeQN0IqYp+XZLzALXMMo0syPDMaptQf8XNAcyZgpBuepq6XdjpYPs
         FZJfilrmXFLvKhlShbr4J7zasfO36QfN+DG/PVZHq0U8TeGBzYNhiURlZxH7cHBh89E0
         3jDxlXyOd7AEZGEbqXX9UQ9bvjaMtJlAtPYUnkmpAeN8vKc9s6u4ihqQntz7xSW282PU
         3EAw83aS4v8dwcK9pV60GP9TjVmi4kbLPooCdA+RMa1/mCgKOcTDZ9MqOTZGqYTLm0vq
         NMLw==
X-Gm-Message-State: APjAAAWjRRzzMWxbZ1Xuy5Zrq8/ytufilkopINXtfaJv8cZTh742KmSn
        H9KJKJRm4k1bT6KWm/fPF95+MZQhDcg=
X-Google-Smtp-Source: APXvYqyZhEXV/U/P8+DjWlah2oQ2KiFiiQ/Rkr6DCDIggo/2jenuG7dW1iTu5nrPCHSDyNEecKaT7g==
X-Received: by 2002:a1c:f415:: with SMTP id z21mr18061663wma.140.1573422937977;
        Sun, 10 Nov 2019 13:55:37 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id d11sm14555824wrn.28.2019.11.10.13.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 13:55:37 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 3/6] habanalabs: set ETR as non-secured
Date:   Sun, 10 Nov 2019 23:55:30 +0200
Message-Id: <20191110215533.754-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191110215533.754-1-oded.gabbay@gmail.com>
References: <20191110215533.754-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ETR should always be non-secured as it is used by the users to record
profiling/trace data.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya_coresight.c              | 4 +++-
 drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/habanalabs/goya/goya_coresight.c
index 16bcd60b111f..c1ee6e2b5dff 100644
--- a/drivers/misc/habanalabs/goya/goya_coresight.c
+++ b/drivers/misc/habanalabs/goya/goya_coresight.c
@@ -8,6 +8,7 @@
 #include "goyaP.h"
 #include "include/goya/goya_coresight.h"
 #include "include/goya/asic_reg/goya_regs.h"
+#include "include/goya/asic_reg/goya_masks.h"
 
 #include <uapi/misc/habanalabs.h>
 
@@ -425,7 +426,8 @@ static int goya_config_etr(struct hl_device *hdev,
 		WREG32(mmPSOC_ETR_BUFWM, 0x3FFC);
 		WREG32(mmPSOC_ETR_RSZ, input->buffer_size);
 		WREG32(mmPSOC_ETR_MODE, input->sink_mode);
-		WREG32(mmPSOC_ETR_AXICTL, 0x700);
+		WREG32(mmPSOC_ETR_AXICTL,
+				0x700 | PSOC_ETR_AXICTL_PROTCTRLBIT1_SHIFT);
 		WREG32(mmPSOC_ETR_DBALO,
 				lower_32_bits(input->buffer_address));
 		WREG32(mmPSOC_ETR_DBAHI,
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h
index 8618891d5afa..3c44ef3a23ed 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h
@@ -260,4 +260,6 @@
 #define DMA_QM_3_GLBL_CFG1_DMA_STOP_SHIFT DMA_QM_0_GLBL_CFG1_DMA_STOP_SHIFT
 #define DMA_QM_4_GLBL_CFG1_DMA_STOP_SHIFT DMA_QM_0_GLBL_CFG1_DMA_STOP_SHIFT
 
+#define PSOC_ETR_AXICTL_PROTCTRLBIT1_SHIFT                           1
+
 #endif /* ASIC_REG_GOYA_MASKS_H_ */
-- 
2.17.1

