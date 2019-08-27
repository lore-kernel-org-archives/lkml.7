Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B84C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29374206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vr3HfuBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfH0Ack (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 20:32:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41240 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfH0Acj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 20:32:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so10845334pls.8;
        Mon, 26 Aug 2019 17:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kyP8YtTFMbDNG7qsSo2w5pZq5BUurmqPvqGOvI+33I4=;
        b=Vr3HfuBBvU+CvPCGdWp3sLwJb2EtL3a9crXIjuQJSWLjl5ksVMgCgkQNSbaHfaCgo1
         4nfBkArMmecu23vp5/O6l0b6QwewovlkmdsPr5K+025s1D+TeJE19WvYtWYy/O9Qzvn9
         JatA0M6TBp9aWACMyhrP6RPT+DKL1YP0HkDf/cggIQNR6bgaKLsX10Q7R64XSeQeyoAz
         h4hHMg83fEt4ogVHkfndekQJSxP0niAuzDW0/uzDhMJIF5Kpmr2QHomtV0JF/0tEDRQw
         GdXqNiD6KogTLeuPK/1R4vFN0+6MSnq5ikb/pElZ/3TadmgpmkWxNMpksCw3QXGQSYma
         Y7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kyP8YtTFMbDNG7qsSo2w5pZq5BUurmqPvqGOvI+33I4=;
        b=nmVFPLiypy2JIFLj4MYqAec+izWC6itsjoEEx+YX845l3sH2AZwy+WhL2cTbA+3YvU
         VurK40F3AxIftXJ76m1yHWRveqYWoh05QYLus5uvPJrUI9LNI0ZlBladUyjg4rPA4dZL
         iL2afecsBp/gstPPNQyVc45u150YQcT8bTvdOXexWJaUVF9ldheU4M9BuXq0pSiqALxP
         C9Avugt/LOtP3ND+zOW934WN/TJd2x+Rq0Y0m2LV4SQ1bk4E0asY6/EKCw1/3dM6VESS
         F08sX/NJlclAkvtYdnOZyHWcvIfIyzJklTTfzk2kJihNRU/RXAWFfw2AiJu07xi3ZnMu
         qPaA==
X-Gm-Message-State: APjAAAVIocUJlDAZG6KOzOwrB0A1pbI8cQ5CgESzNJOn8XFc8xihQk3o
        4hyTAI7x6S3LtymO15hYbig=
X-Google-Smtp-Source: APXvYqz3ZmR1zugYM2VmnZ+ecV9ZHk+8pBBQ39SEGbJDivdoJ7PQszjh2Nwlp3kG0uQUU22i6Tfntw==
X-Received: by 2002:a17:902:a706:: with SMTP id w6mr6406893plq.166.1566865959290;
        Mon, 26 Aug 2019 17:32:39 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id e13sm14828075pfl.130.2019.08.26.17.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 17:32:38 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V6 1/5] mmc: sdhci: Change timeout of loop for checking internal clock stable
Date:   Tue, 27 Aug 2019 08:32:42 +0800
Message-Id: <20190827003242.2298-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.22.1
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
2.22.1

