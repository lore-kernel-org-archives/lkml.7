Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99079C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668C72081C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn/kHLMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfEARoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 13:44:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46268 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfEARot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 13:44:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so5657789wrr.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 10:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u+Ql5mHSMk+0fTV1OjTlpH+o3EUFvYfu0ZLtx/m3LZE=;
        b=Rn/kHLMk1rIsG0yFXA4VWx7uwELTv5x9d/ypmEX/n0KXoi0g5sBRJ0MwpstrDIQkjS
         knZI4xyiYzTnmBcv+zqc+WQiVVancadD6X9atgK2lNrtChnZEarmiRpm12N6woUiIwHt
         vv1+WmmraQLnk7NhROnOrnWMDrzfDJuEJu4f8AyVkRaspPeC1IAi9k1KjC5FYyPal5z7
         LXLOFMhGDfMun8iPJsq5b0REh9xueO0JM0bTo/QEZMSU64S6R0eGwBdSijWYDKakjUFI
         /Z3J1uO8tcW51WCb4PtySEfiPlB70AXRZnQPzA5Q0BIHXIh1HXu0ghd2CuiiAaD/EGoo
         M/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u+Ql5mHSMk+0fTV1OjTlpH+o3EUFvYfu0ZLtx/m3LZE=;
        b=GGYPH0LY/v7r40BxN16Ii4HuuohbiC9X8433q93/XQCoL97YNR+pPPIBosAz/i5qPC
         vFjz/U2fdYvHbB5/Q5AiapEelNAzZQbDOBT6ZZf2M8nmztWd085SzAd8fUMCkv10kqoo
         +lnTCRj2mBO13Yx0XvekkKUcb0uGBXSaDqo6YqAxSFOxhqtb7/37ZPh+tGVgnGEv9WDr
         cLD8V2L7VfFSQ1i6KSsOwtGKBIG/LsDeYy95n89owPSjyW00Mznyyl+Fbz4uq/oCVsdv
         UTh14EDEUK6YwCoPqZ8c6a9vDp7siJ2wjTF01/XFrtVwy+qKPgI+3BPQy5viCLHjMk8a
         i/Cw==
X-Gm-Message-State: APjAAAXvBlhz6ZvKU3hzTnp8MC/qoQOyzXv23iOtgjXloEtTdbROtMJK
        YqlvzOLY3T+Y9AZiZpaCLcs9sKc+
X-Google-Smtp-Source: APXvYqw2KUaUDqblwd3WBpIAuORUY6HRHOQFBNPvG4i7pYN2NDzY2zKXcfp5U/hia/yph7ZPvnEtDQ==
X-Received: by 2002:a05:6000:145:: with SMTP id r5mr11679984wrx.19.1556732687283;
        Wed, 01 May 2019 10:44:47 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h81sm9923329wmf.33.2019.05.01.10.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 10:44:46 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Dalit Ben Zoor <dbenzoor@habana.ai>
Subject: [PATCH 3/3] habanalabs: increase timeout if working with simulator
Date:   Wed,  1 May 2019 20:44:40 +0300
Message-Id: <20190501174440.28557-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501174440.28557-1-oded.gabbay@gmail.com>
References: <20190501174440.28557-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dalit Ben Zoor <dbenzoor@habana.ai>

Where there is a spike in the CPU consumption, it may cause
random failures in the C/I since the KMD timeout for CPU
and/or QMAN0 jobs expires and it stops communicating to the simulator.
This commit fixes it by increasing timeout on polling functions
if working with simulator.

Signed-off-by: Dalit Ben Zoor <dbenzoor@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c     | 8 +++++++-
 drivers/misc/habanalabs/habanalabs.h | 7 ++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 0e0b9ec71c80..91a9e47a3482 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -1147,7 +1147,13 @@ int hl_poll_timeout_memory(struct hl_device *hdev, u64 addr,
 	 * either by the direct access of the device or by another core
 	 */
 	u32 *paddr = (u32 *) (uintptr_t) addr;
-	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us);
+	ktime_t timeout;
+
+	/* timeout should be longer when working with simulator */
+	if (!hdev->pdev)
+		timeout_us *= 10;
+
+	timeout = ktime_add_us(ktime_get(), timeout_us);
 
 	might_sleep();
 
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 0da80e8eab42..71243b319920 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1042,7 +1042,12 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 
 #define hl_poll_timeout(hdev, addr, val, cond, sleep_us, timeout_us) \
 ({ \
-	ktime_t __timeout = ktime_add_us(ktime_get(), timeout_us); \
+	ktime_t __timeout; \
+	/* timeout should be longer when working with simulator */ \
+	if (hdev->pdev) \
+		__timeout = ktime_add_us(ktime_get(), timeout_us); \
+	else \
+		__timeout = ktime_add_us(ktime_get(), (timeout_us * 10)); \
 	might_sleep_if(sleep_us); \
 	for (;;) { \
 		(val) = RREG32(addr); \
-- 
2.17.1

