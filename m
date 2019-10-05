Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13591C47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 06:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7B62133F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 06:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQFNKp3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfJEG6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 02:58:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40638 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfJEG6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 02:58:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so797129wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 23:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=suLS1tXQsXw4I8OWBfVO0nqihjsDo6neLg/xhQgKVN0=;
        b=eQFNKp3y1ZPgItvgnh4Z7wvxg4+lIrETkGUwdZ7ordeKUKu9FUu2D86v6ajm556zSM
         dFS0k68YSgjZx7Jeb6htWJOgzfyrfkT+vJkVctr3vxEyDDSYEUFGhovCMg3iJsPqliGX
         BmyQ8JSc6SnW8RkrpBkMSWiu2IQ5+UyJM99WDwqmB/pkp7PW7WkPjjulAY9gyZWOpH0G
         wTJwLGLsDZlil2DpglB07RpujTDYKnBW/X3UKVWTXdIfpIwF0qiypBXV8oKD8rm8Q3AZ
         f1/GWRBQmVbbV8gqQTXF3Kcu6TDa/ptVMhDCGKE6aVujlHuTddC7Kj0I/NgtOlrbfKbL
         mUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=suLS1tXQsXw4I8OWBfVO0nqihjsDo6neLg/xhQgKVN0=;
        b=Crte55Uu6lInYBJNWSNMIPeT2gjOhJpEnWgY6bYCJe6ELMzl6dkeg85x8cxYKUtC6g
         mxUlWr7ohW0+3zJEzROaCADTBKVJNNceKGCYX6LYK+qrVkGz4AO3hxav7tbMamnuHle6
         2whu4IgoJGzQqnCWg5hZnBFG072dWJoqjgqS5C7cEh1pni+OoVTULzUWksDQhoOP9wd7
         wnQuRnRoEfb917QNFdwK9t1PgbodJYhN7yjO5748mIFlPiWKDBfW5fGsmpZwY6Fc5Cl0
         ZU/nzt4mV9VfNaVo70rlAu8f6gKeP3ibmdD2vc/yqhP4dmY7BMqRJu2apfahfRT6xehs
         /S2g==
X-Gm-Message-State: APjAAAWB4M2LZn4w4JKoa2bwEUED8Sdq3/FRN4QNMRcZ1+LLYk1Ea6uy
        vUjFAI27cVVRYTDd68gUMZnc0KQs
X-Google-Smtp-Source: APXvYqy5Sc3ZM+/7gaJex1/huPQnUV+un//+oYPZidIIWnnxjl26Ru3RyDJTSz9louiKGxrvLH2dKQ==
X-Received: by 2002:adf:e341:: with SMTP id n1mr9985708wrj.133.1570258708540;
        Fri, 04 Oct 2019 23:58:28 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id f20sm7015712wmb.6.2019.10.04.23.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 23:58:28 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: set TPC Icache to 16 cache lines
Date:   Sat,  5 Oct 2019 09:58:26 +0300
Message-Id: <20191005065826.3878-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce latency to memory during TPC kernel execution.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c  | 3 +++
 drivers/misc/habanalabs/habanalabs.h | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 0b40915bede2..d49f5ecd903b 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -1457,6 +1457,9 @@ static void goya_init_golden_registers(struct hl_device *hdev)
 				1 << TPC0_NRTR_SCRAMB_EN_VAL_SHIFT);
 		WREG32(mmTPC0_NRTR_NON_LIN_SCRAMB + offset,
 				1 << TPC0_NRTR_NON_LIN_SCRAMB_EN_SHIFT);
+
+		WREG32_FIELD(TPC0_CFG_MSS_CONFIG, offset,
+				ICACHE_FETCH_LINE_NUM, 2);
 	}
 
 	WREG32(mmDMA_NRTR_SCRAMB_EN, 1 << DMA_NRTR_SCRAMB_EN_VAL_SHIFT);
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 371d1ec15697..91445371b08b 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1062,9 +1062,10 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 
 #define REG_FIELD_SHIFT(reg, field) reg##_##field##_SHIFT
 #define REG_FIELD_MASK(reg, field) reg##_##field##_MASK
-#define WREG32_FIELD(reg, field, val)	\
-	WREG32(mm##reg, (RREG32(mm##reg) & ~REG_FIELD_MASK(reg, field)) | \
-			(val) << REG_FIELD_SHIFT(reg, field))
+#define WREG32_FIELD(reg, offset, field, val)	\
+	WREG32(mm##reg + offset, (RREG32(mm##reg + offset) & \
+				~REG_FIELD_MASK(reg, field)) | \
+				(val) << REG_FIELD_SHIFT(reg, field))
 
 /* Timeout should be longer when working with simulator but cap the
  * increased timeout to some maximum
-- 
2.17.1

