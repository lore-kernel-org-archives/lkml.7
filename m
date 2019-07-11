Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC184C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E976216C8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Pwqtg0XD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfGKLrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 07:47:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40980 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbfGKLri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 07:47:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so2886187pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 04:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zoGUhMmcCaD8E7sO+8jLVe3f8XfkjaOQT+IWO1zQyLE=;
        b=Pwqtg0XDJ1iCbp4keDQ3o0QNyHW0ysMYobYlDf1UQldeGDgZqXdRtrX5rM647Kd5U7
         nsQVuo1vJhrEGpS76I3lFPJ4m97AggCzFrtm2cAVWnbG5CzyDEuKxjNWB+154QoomPvt
         wOqX0FFWQMFjYOXLNGdvxwwBAk2mIYJ9Onz27UVmTILte+8FMOV8wjbR8aKewtw822Th
         PbVk7OJjxAdLKEG83mTDFNB5btQ5q8oSk9zXgaw9/Cv+CnV+pmvbXxiNApJt8SS2f/XG
         Zbd9LAEwg8JlqFIrH+cyA1KyvaIRHAVGBScX/y6OMliZ2yd4Ja60jx/wGAxsRyVggAJF
         clig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zoGUhMmcCaD8E7sO+8jLVe3f8XfkjaOQT+IWO1zQyLE=;
        b=n9dFI341ibPGwgkB3CkgBW7khGvCx8DV6ZupWJABs6girCAukEk0w5KyzyTo/UKpD2
         ZBUsL83drsOAJOTd8Jr18FG/es179y380Cuu6f8nNoPtmYY/gQjdbbzRlkMRebCIYTZK
         lLjVZGE8q1HWNePffLF0kmrqXlxLnVz94P3kRKMhTwJwq88ETJVqH5gRPt26agfM3Qdo
         E6PLxwIFf3vFbBieU9aPC8lM9mwIzftj70WsFTqWJpsc2K3IL4cP+1p0XTR953igJfDI
         aMY9B8Y2B1ljiIdjkfbYpJaFVvQ1DAx+xCARsY7Ka9VpQrbTjthz2GhzcmLI/Y5rSH8k
         PAAg==
X-Gm-Message-State: APjAAAV5QJu9DuGv5ABGlVBP4HVlRkmjSR9HOsqrO54iTrVn1djZmiXh
        3pY1gmIGO4xDKC27JJEAbio=
X-Google-Smtp-Source: APXvYqz3ZLf6Dku3839fxAKXH0pKAvffKFRLkjtb66cKUKAwQ0ZTitlm4hkIlmkldW14OD2hHW3Vow==
X-Received: by 2002:a17:902:9307:: with SMTP id bc7mr4070979plb.183.1562845657758;
        Thu, 11 Jul 2019 04:47:37 -0700 (PDT)
Received: from localhost.localdomain (36-239-228-246.dynamic-ip.hinet.net. [36.239.228.246])
        by smtp.gmail.com with ESMTPSA id a15sm4116868pgw.3.2019.07.11.04.47.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 04:47:37 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: da9062: Simplify the code iterating all regulators
Date:   Thu, 11 Jul 2019 19:47:12 +0800
Message-Id: <20190711114712.31313-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's more straightforward to use for statement here.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/da9062-regulator.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 2ffc64622451..5ea8d58d28c5 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -966,8 +966,7 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 	regulators->n_regulators = max_regulators;
 	platform_set_drvdata(pdev, regulators);
 
-	n = 0;
-	while (n < regulators->n_regulators) {
+	for (n = 0; n < regulators->n_regulators; n++) {
 		/* Initialise regulator structure */
 		regl = &regulators->regulator[n];
 		regl->hw = chip;
@@ -1026,8 +1025,6 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 				regl->desc.name);
 			return PTR_ERR(regl->rdev);
 		}
-
-		n++;
 	}
 
 	/* LDOs overcurrent event support */
-- 
2.20.1

