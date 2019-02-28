Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD7DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA39218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEqhqFbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731939AbfB1Iqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:46:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37033 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731833AbfB1Iqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:46:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so7994291wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 00:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LGIzJpJvXuJ3oVbc6oLVhFAATUbTP/Cf/RKodfADNmc=;
        b=iEqhqFbl6jY2rYRs/d37LxWxgWv2U+i+LboWckhtEMqjqcsyYV3LccGwgptT3EGH9A
         lqjY4R18FQw67F1Kf++ggoMtxDPoeYWOZrJRVcHy2LvJrrYYegohY5CwKNrmBcKd/fqG
         aO3p6xC4LkA8mb8OyICojs87bu+X9oM/zo+k4hUG2PmaWPkFTYyNDkpyZRfmDHwOWWVA
         RQY4q28o8lPv+pVtnyNTzO7bc6ail7Sscleh4DBnUNUk1ndbL9SH+3SGzHHIG+RRgYEE
         HccFzUXsqB3RbtwSB/OYONPsQLxblJbuG4ZbZbWDNtfIfooA/jwqOna3p5sFWeLLrKy9
         KHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LGIzJpJvXuJ3oVbc6oLVhFAATUbTP/Cf/RKodfADNmc=;
        b=cxX2RRawxLFlbn8riXOz8l+pfRFbDSiNSzbpE/l4IND7iix4kCJPPuQAiCBX3Rrpdk
         4YQDs7Uo1r+d7bhbaz/DueOW2WIcDOt9AV28S2uw1QIeD+sPrNGh1gKGc2SBGt5qhTqV
         2YjvfXXMtfNHwvsTjpceElkC2zuO889GB1cGFHerbelvnov/CxSGv8NDlzU+YjFT45If
         udDUPMw6ZTw0FMGljgYChM7hAAY9IqbJ/hYvtcq+kAlRGtbA7jfnJBqPBRYRXD3J5Us5
         Wz80CCK1xqqQo8NdQSIicr3OvvdL/jAG8+8Nb0icBWwNagv7fq3ueOkV1uY1XnG7YHMO
         DPPw==
X-Gm-Message-State: AHQUAubu4e58drSAnA/YqhYKBcd0wfIjWboOABCpPfLwrBi164KdbGHQ
        xPVrJNM0meDpVDcWZalYQ3/3PmcK
X-Google-Smtp-Source: APXvYqx6OST/TLCvHRgpstsMpgZwcK6GzHLLx7wzHtBi3fi/q2cF9HOdIFhCfMyno4UYEPPv6p31dg==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr2162398wma.40.1551343603721;
        Thu, 28 Feb 2019 00:46:43 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h126sm4409305wmf.2.2019.02.28.00.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 00:46:43 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 07/15] habanalabs: extend QMAN0 job timeout
Date:   Thu, 28 Feb 2019 10:46:16 +0200
Message-Id: <20190228084624.25288-8-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228084624.25288-1-oded.gabbay@gmail.com>
References: <20190228084624.25288-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

This patch fix a bug where the timeout for sending a job on QMAN0 by KMD
wasn't enough in palladium environment.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 578e4bdc3a49..13923f4127af 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -83,6 +83,7 @@
 #define GOYA_CPU_TIMEOUT_USEC		10000000	/* 10s */
 #define GOYA_TEST_QUEUE_WAIT_USEC	100000		/* 100ms */
 #define GOYA_PLDM_MMU_TIMEOUT_USEC	(MMU_CONFIG_TIMEOUT_USEC * 100)
+#define GOYA_PLDM_QMAN0_TIMEOUT_USEC	(HL_DEVICE_TIMEOUT_USEC * 30)
 
 #define GOYA_QMAN0_FENCE_VAL		0xD169B243
 
@@ -3126,9 +3127,14 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 	u32 *fence_ptr;
 	dma_addr_t fence_dma_addr;
 	struct hl_cb *cb;
-	u32 tmp;
+	u32 tmp, timeout;
 	int rc;
 
+	if (hdev->pldm)
+		timeout = GOYA_PLDM_QMAN0_TIMEOUT_USEC;
+	else
+		timeout = HL_DEVICE_TIMEOUT_USEC;
+
 	if (!hdev->asic_funcs->is_device_idle(hdev)) {
 		dev_err_ratelimited(hdev->dev,
 			"Can't send KMD job on QMAN0 if device is not idle\n");
@@ -3175,8 +3181,8 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 		goto free_fence_ptr;
 	}
 
-	rc = hl_poll_timeout_memory(hdev, (u64) (uintptr_t) fence_ptr,
-					HL_DEVICE_TIMEOUT_USEC, &tmp);
+	rc = hl_poll_timeout_memory(hdev, (u64) (uintptr_t) fence_ptr, timeout,
+					&tmp);
 
 	hl_hw_queue_inc_ci_kernel(hdev, GOYA_QUEUE_ID_DMA_0);
 
-- 
2.17.1

