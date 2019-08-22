Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E6DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3081121744
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0bI2oyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393834AbfHVWJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 18:09:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41614 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393808AbfHVWJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 18:09:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so4475430pgg.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 15:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vEgIQCU90XTwHLlVQoE1B9Sv6mWqmfOra2UuJPbbnMA=;
        b=s0bI2oyU4D4LGRqL3L4oWxTMWxl1Xmj1zX5FLuRWYQ+O4zKd809t3z2LEBZzszmiJJ
         4oCrt0Y1pQDKb1bnNGqx9tNBS6S/clAr0wLlvwJNEY8NTwRQJIx8gW+ddJE3ScdKrdx7
         sQna52Gf37nwK9fxIGoaPLwBcINutlBU5Tx5b++jEO3hAGGHZwY+0CLFMHOnMhZJtFDn
         uN0xdQIm4twMIiobXvVK18SCUVK+tPnYTaYizjwEX24d9yMqJmyoZXBL1hckRqL3fFhs
         /UTdFhhpO200S2uKFfx4RmC/6FTaezLo9sPqoJO63dyb72W0LgGxnJ8JKJc5Not9ITPS
         8LgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vEgIQCU90XTwHLlVQoE1B9Sv6mWqmfOra2UuJPbbnMA=;
        b=Kf1/Zb8uDPPa/JBo1x4L9EM0zQQGJsrwlJhYRBghCjb9iqnGCB0RMz5SIKw2BS96bI
         sqTGjpFNWRHM1k94IxeoJixmxg8VbCo65h2Nx+ktcKtvLBWeYTW7JvZ7jAKc03b0g2Gs
         PPrcnk3tfumSahr3bpzCliTuMhrYfngh9DDDXj3y68349xDmlqU9oWDDYc5rbxlDBJua
         tvBCfBoWpVzVlqs0jFe0oSfcpOzVg5hRo4SfCHNiBfcQo30DlSzKqq3VYHV7W9x09smB
         mRq9ZDXPiwSb6s6SohYy7WkJnCapwyAAAk0jdbWjZrI0+5XR/ZqXIEy0Mzm7+DOHcH9p
         /WCw==
X-Gm-Message-State: APjAAAXYAcY2B7HtANIOmxHyp+lgFUndAkz54WuH16H6WZhnSFY21xHe
        R4WTgPz7NSNMgO0bTJ3BS67uwA==
X-Google-Smtp-Source: APXvYqyxZDB7o+zf0OrkF1TQSDCbWMGz7mhgZUglKfI/is8tYAHTvH17iLyrw6kY+NDYcFXyU8uu1A==
X-Received: by 2002:a63:9318:: with SMTP id b24mr1177376pge.31.1566511758623;
        Thu, 22 Aug 2019 15:09:18 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id s7sm377432pfb.138.2019.08.22.15.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 15:09:18 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     yabinc@google.com, suzuki.poulose@arm.com, leo.yan@linaro.org
Cc:     mike.leach@arm.com, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] coresight: tmc: Make memory width mask computation into a function
Date:   Thu, 22 Aug 2019 16:09:14 -0600
Message-Id: <20190822220915.8876-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822220915.8876-1-mathieu.poirier@linaro.org>
References: <20190822220915.8876-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the computation of a memory ask representing the width of the memory
bus into a function so that it can be re-used by the ETR driver.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-tmc-etf.c   | 23 ++-------------
 drivers/hwtracing/coresight/coresight-tmc.c   | 28 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h   |  1 +
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 23b7ff00af5c..807416b75ecc 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -479,30 +479,11 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 	 * traces.
 	 */
 	if (!buf->snapshot && to_read > handle->size) {
-		u32 mask = 0;
-
-		/*
-		 * The value written to RRP must be byte-address aligned to
-		 * the width of the trace memory databus _and_ to a frame
-		 * boundary (16 byte), whichever is the biggest. For example,
-		 * for 32-bit, 64-bit and 128-bit wide trace memory, the four
-		 * LSBs must be 0s. For 256-bit wide trace memory, the five
-		 * LSBs must be 0s.
-		 */
-		switch (drvdata->memwidth) {
-		case TMC_MEM_INTF_WIDTH_32BITS:
-		case TMC_MEM_INTF_WIDTH_64BITS:
-		case TMC_MEM_INTF_WIDTH_128BITS:
-			mask = GENMASK(31, 4);
-			break;
-		case TMC_MEM_INTF_WIDTH_256BITS:
-			mask = GENMASK(31, 5);
-			break;
-		}
+		u32 mask = tmc_get_memwidth_mask(drvdata);
 
 		/*
 		 * Make sure the new size is aligned in accordance with the
-		 * requirement explained above.
+		 * requirement explained in function tmc_get_memwidth_mask().
 		 */
 		to_read = handle->size & mask;
 		/* Move the RAM read pointer up */
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 3055bf8e2236..1cf82fa58289 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -70,6 +70,34 @@ void tmc_disable_hw(struct tmc_drvdata *drvdata)
 	writel_relaxed(0x0, drvdata->base + TMC_CTL);
 }
 
+u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata)
+{
+	u32 mask = 0;
+
+	/*
+	 * When moving RRP or an offset address forward, the new values must
+	 * be byte-address aligned to the width of the trace memory databus
+	 * _and_ to a frame boundary (16 byte), whichever is the biggest. For
+	 * example, for 32-bit, 64-bit and 128-bit wide trace memory, the four
+	 * LSBs must be 0s. For 256-bit wide trace memory, the five LSBs must
+	 * be 0s.
+	 */
+	switch (drvdata->memwidth) {
+	case TMC_MEM_INTF_WIDTH_32BITS:
+	/* fallthrough */
+	case TMC_MEM_INTF_WIDTH_64BITS:
+	/* fallthrough */
+	case TMC_MEM_INTF_WIDTH_128BITS:
+		mask = GENMASK(31, 4);
+		break;
+	case TMC_MEM_INTF_WIDTH_256BITS:
+		mask = GENMASK(31, 5);
+		break;
+	}
+
+	return mask;
+}
+
 static int tmc_read_prepare(struct tmc_drvdata *drvdata)
 {
 	int ret = 0;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 9dbcdf453e22..71de978575f3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -255,6 +255,7 @@ void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
 void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
 void tmc_enable_hw(struct tmc_drvdata *drvdata);
 void tmc_disable_hw(struct tmc_drvdata *drvdata);
+u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata);
 
 /* ETB/ETF functions */
 int tmc_read_prepare_etb(struct tmc_drvdata *drvdata);
-- 
2.17.1

