Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32700C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21AA2186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+kCsyIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbfHZTqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 15:46:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39270 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbfHZTqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:46:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id y200so4774424pfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 12:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+5gWSemuxt3HHekdvm6tHeI05f3zrGiyld+SNG7Me4c=;
        b=q+kCsyIhcHwX5PX5Heefbpn6+r19P5CgbzOJ0ob5RuW98znrXBiS792y4boZ+rVNaJ
         M+ihgxSmoDQMJ+8XpYQdD+q5pt3pp7I+nn6ZxT9eKedY5mLdtrImcmHsMwIEHvhVtROe
         iZoKeSnbFOFecoRcOXPPLqnXdSS7UoKQ9i9PeHoNmDMNngrCcJE+7b5LXMB0hJkwayxz
         v9s95u8L49mXYMwLsI0dHCPJzp0cdmBXdq0JJSegSUSRKG5MvCr4ymz1OJtiLrcrykgP
         d0kCYhrhh2J3k1tV08sTrAKXExvQU1jAyYSAcMoF6J1GACPiO7ClpggY8Vvb9VM7/Jzp
         vZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+5gWSemuxt3HHekdvm6tHeI05f3zrGiyld+SNG7Me4c=;
        b=pxqgjjQjOpZa1TblI+8gzUezY/9vH1qYuKJWz3dr79R1UBF6637iSLTNzf43CaspTs
         3isXkh/iYEIy0hoIU6Gb/ZY4dUj7mqJrJl/2QMMg05N/TKMwlIns2nw5gStnpACEwHCf
         T/ZKv/DmlpczPTEe4SyJzdmjOU4jmzhb7xVlcXebw7SDh851iMcgBNzoaUXZ2+JJBpT1
         7VXtvoH8M34S8WW5iYo0JY1ncRKurkn8OVhlGiPXIsoJ+SCnlgAGGCyao6e6hXtMgqdz
         roiDPOWbfT+gJYaAV9hN1zZEsLyWIUsEV94SPTgV8BvTbcqAzdmdlDVynZDGab4eEyxK
         hDOg==
X-Gm-Message-State: APjAAAX5qyCXxSIx2JfVL5xUhlfX4ajnLLwo/3CeDMfUUPQJn6ubbvD7
        VeRT4VdzfBcqQFRrbaYNsDaqWA==
X-Google-Smtp-Source: APXvYqxQJvl5Xv1RjaA+GrKsEkiQ+ZZVKrENE/rXFhJs+p7tMSQsIT7tcUQnhRDrQlO3L6w7a1sZPw==
X-Received: by 2002:a63:9245:: with SMTP id s5mr18318356pgn.123.1566848767985;
        Mon, 26 Aug 2019 12:46:07 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c35sm13214789pgl.72.2019.08.26.12.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 12:46:07 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     suzuki.poulose@arm.com, leo.yan@linaro.org, mike.leach@arm.com
Cc:     yabinc@google.com, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] coresight: tmc: Make memory width mask computation into a function
Date:   Mon, 26 Aug 2019 13:46:03 -0600
Message-Id: <20190826194605.3791-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826194605.3791-1-mathieu.poirier@linaro.org>
References: <20190826194605.3791-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the computation of a memory mask representing the width of the memory
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

