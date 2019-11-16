Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64564C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 10:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3037B20715
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 10:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJUXAxnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKPKdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 05:33:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36798 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfKPKde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 05:33:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so13666115wrx.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 02:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qNVGXN+GDJA59Rb9ctl+x+5UfCct52bd8ygJlsl5jNg=;
        b=ZJUXAxnOzruLmUIgDcjoIs1v9fc/CD0ZdLw6KIkHmkB7oRA7OkdITj9hb2tiv9Cb0i
         Ly7p1EKEaJYZFU69mrHm+rKKI46pWL56J2Dayc4e2gLiAZxdjeHrfru+at61Qjfz33bF
         OyI5YEfwgVsuhCxMFGLiZIHfta34itunGzIvgP8dYRWS6ufSV1OhoK5V3nuy7WcpLWG3
         5dmXpA0dTHy8ze5O8KZFVAVR4PHs6IlAYARPnjV/Xpl+jm48B6d1A8OcAgsrbPh23VWe
         OPUlyk+X2Y1gXLzwrWyFW1eqY8mxO28CNAQ1s+65VQrhghyh4GoEUsRM3E1gJOSYUXJR
         gROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qNVGXN+GDJA59Rb9ctl+x+5UfCct52bd8ygJlsl5jNg=;
        b=bxhw1DTd+MI8rcCv2qHHu6VxtKsxGv4ySXvGqtAN//9isdrISM+sREr1brTQeuJ6oF
         Z7Wkjy29s2xKr3FqDzi0OuJkqkyAsZIJLhxPxhKDpgm8g/kqFUVczWu638rmNTJVUT+9
         Pur9jGgPTFvEiYNOD4qBzGRQIQIoEN8NqOX3CpuJCGID8mI75uOgCkrM5uJEGHHOm20J
         KMOndwQGos5DowgSJCRMVxTAttfCjkw8x5orM5HgNunZ2kMHXEmpfwM0SBVi6CqGFlqy
         dtGCz2DtH4w9G7IQlZMKtghxZySgg+yWnOMjAeCpoFD1+ryUrVSZP/v2sPskZmvU6//N
         DLfg==
X-Gm-Message-State: APjAAAW+1KvXQnm9Yg8p6pa5V67ajrnY/sqyLrQ+d9cV1nCMv185UZtq
        jjZYSoWU6dQU8yAuJD1/4cM33jJXYOk=
X-Google-Smtp-Source: APXvYqx41798O9HsgFjjABijiq/ld2pY8LBMzutsE1bOuO7o/CsKrymurotKtf2txDgwW+QJFCdEyw==
X-Received: by 2002:adf:f50b:: with SMTP id q11mr6885610wro.343.1573900412143;
        Sat, 16 Nov 2019 02:33:32 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id t14sm14680522wrw.87.2019.11.16.02.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 02:33:31 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/3] habanalabs: remove prints on successful device initialization
Date:   Sat, 16 Nov 2019 12:33:27 +0200
Message-Id: <20191116103329.30171-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Successful device initialization is mentioned in kernel log with the
message "Successfully added device to habanalabs driver". There is no point
of spamming the log with additional messages about successful queue
testing, which are implied by the above mentioned message.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/firmware_if.c | 5 +----
 drivers/misc/habanalabs/goya/goya.c   | 3 ---
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/firmware_if.c b/drivers/misc/habanalabs/firmware_if.c
index ea2ca67fbfbf..f5bd03171dac 100644
--- a/drivers/misc/habanalabs/firmware_if.c
+++ b/drivers/misc/habanalabs/firmware_if.c
@@ -143,10 +143,7 @@ int hl_fw_test_cpu_queue(struct hl_device *hdev)
 			sizeof(test_pkt), HL_DEVICE_TIMEOUT_USEC, &result);
 
 	if (!rc) {
-		if (result == ARMCP_PACKET_FENCE_VAL)
-			dev_info(hdev->dev,
-				"queue test on CPU queue succeeded\n");
-		else
+		if (result != ARMCP_PACKET_FENCE_VAL)
 			dev_err(hdev->dev,
 				"CPU queue test failed (0x%08lX)\n", result);
 	} else {
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 2935e84fe7d8..70bdaeffb6ce 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3006,9 +3006,6 @@ int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 			"H/W queue %d test failed (scratch(0x%08llX) == 0x%08X)\n",
 			hw_queue_id, (unsigned long long) fence_dma_addr, tmp);
 		rc = -EIO;
-	} else {
-		dev_info(hdev->dev, "queue test on H/W queue %d succeeded\n",
-			hw_queue_id);
 	}
 
 free_pkt:
-- 
2.17.1

