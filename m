Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6C8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F957206CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxkPlG2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391162AbfIFCaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 22:30:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41685 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfIFCap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 22:30:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so2566129pgg.8;
        Thu, 05 Sep 2019 19:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0a/Ttcv1b84BQ/BKZwWZSK7rdmYU6EM1Hc5Czp/KOEk=;
        b=UxkPlG2WM83W1pxPHvlBQybqMy/Ip+uOUKj9BojUJh1kRjXsIuycCD4K8m+SMOCESi
         Lqmz2Zl4X+e97nFYKqNfnryHkvtqRuFRqk0B7LcanYGX7WDdDEboErSzvySOZPIIHEYH
         nE5tCa99wN6qoo/Oh34Qp++ltMBIphkQNW685B1orE/uChL1YQdnvc+b78vlFbFXDMCs
         3ajHZxoGC9Q6XpDVDO7xC3+frmotedXB/gQUrwAVxJA9CHu7QR7NO//nGWUIBaqMIbih
         q2Ffph6mF7Q1fjljvVquHgc93cH0tL5T5OaUnqsiFFpN+VmNXO1fYuzP+YcYE6H5YUs8
         IXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0a/Ttcv1b84BQ/BKZwWZSK7rdmYU6EM1Hc5Czp/KOEk=;
        b=uNgRTLQB6cY3ldN4cdnKa5x8crOGDGQQ4sYGw5qtGJyS5L4GhZqs+IxaR+22fP8ieB
         3tYtZ4wDXhlSYwO+Lh5b2aY61kBSy+VIMzOLqfO7YD0fUQc8vaxcl9BK7e+yQmCChOV1
         GDhI3GaaLPvT+U00FQ15ga8LYr4Bn0BFQrmRWX1bXi8opFvz4ALy/RG1JDDk0YXAWkrm
         MGyVWQTNlWvz6kPMbtwasXyEeg0B7mPUWCaaqgJ+UDAahWJGhqnuK9NzIQRsR9tC2LJx
         FACq/aVj3SGj+FgCyiiQvu+y960XB+UoU4QCx808dGfkvYAQ08Gj9PvcC46LzgcR2qpB
         YqAA==
X-Gm-Message-State: APjAAAXfFD3ecppZBYv1jYnfVZUNhXCL+m4exfPPyXrdtWWNYl8YmYUV
        4TjfyUsVvaSw88v11L9LFJ4=
X-Google-Smtp-Source: APXvYqwm4tjf7WnLpHEUc9EpYP827c7f4BjQ4DfBF1iTCTT7lk1ufs65JFqjDHatpY10182Jj7vmSg==
X-Received: by 2002:a17:90a:1150:: with SMTP id d16mr7548068pje.2.1567737045194;
        Thu, 05 Sep 2019 19:30:45 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id o129sm4228000pfg.1.2019.09.05.19.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 19:30:44 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V8 1/5] mmc: sdhci: Change timeout of loop for checking internal clock stable
Date:   Fri,  6 Sep 2019 10:30:53 +0800
Message-Id: <0c090d866e2b4cd7966672b1b6cf5667a5ce39dd.1567734321.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567734321.git.benchuanggli@gmail.com>
References: <cover.1567734321.git.benchuanggli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

According to section 3.2.1 internal clock setup in SD Host Controller
Simplified Specifications 4.20, the timeout of loop for checking
internal clock stable is defined as 150ms.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 59acf8e3331e..bed0760a6c2a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1636,8 +1636,8 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 	clk |= SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
-	/* Wait max 20 ms */
-	timeout = ktime_add_ms(ktime_get(), 20);
+	/* Wait max 150 ms */
+	timeout = ktime_add_ms(ktime_get(), 150);
 	while (1) {
 		bool timedout = ktime_after(ktime_get(), timeout);
 
-- 
2.23.0

