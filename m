Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC2AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D13120880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUW0GXnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfDOO5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:57:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44560 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfDOOzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:55:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id h18so13308888lfj.11;
        Mon, 15 Apr 2019 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNaJ9hj6M7iqP6WyQLdsWMm4ZczqztWmMwaK15IRnNA=;
        b=aUW0GXnj7HeNFEGsBRqtx0kL/kSSdDftx86JC3HEvoyYEg1M+kfxpW5FFmsRDdmQyw
         0KNbzyH32j410QsOt9JGsddNDpUfO7SDTBmOX+pdSUomafytryJOsJV/G4jQ5cjS4/Qi
         QSdthJ4y6OMlExlX+Qn8/vIqVmy8epbpHgKJbnLOQg+F49SFaLnLizmSZ9uZFv1Y4bA0
         Wh+bzgRXPgdIFxhA+g2ewmeSxf/Z0V4KEC7zLVOzd6ik1Gl1HrqJEPASWzwQEnOK1xDj
         1cA1Mbct1JBvXOjKM8wncXWvCAZvJ/Wm2rROPjetGqjID/r07byMDWg0ABYpjUTJQU1H
         GN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNaJ9hj6M7iqP6WyQLdsWMm4ZczqztWmMwaK15IRnNA=;
        b=N3uvI1oqUGH4/E4GLOcbMbnwYBRr7ppwvY6XjwONpJNKaxZLPeg+ARgzhg/6n7zDW6
         42pk0irP11olmpD72pFPRFTvcKwcLJ14aeOuwMrKqN8Z7VpqJoWBeFzxyvdHQHjqnyVg
         kTTW5ms4gKRGUjkwfzlj+5tzwTdvdoKpLLpqnRgfSDhgNAc5ZZYhfB8YlBRNWYaLt/VU
         xyTSHiQM6F9CpNEIhCzigOjf9FY8jg7KCQUsdxGyMLQW0lf5BlKPpp1HIwwHA+ezV0us
         P1XOjGm+aWqEeYfnN6Q6KGrbrQNCsvfp+ugJeFbTr/VB3Vi7GCMQhZGx4KniNyyE+soV
         Vigg==
X-Gm-Message-State: APjAAAXlrE79pH3rhffQDUnhVm4V5OxAKASgcnyryxqd1LFq5r8pHO0g
        hx9vKrfxIdDZIL30Z1ENOy4=
X-Google-Smtp-Source: APXvYqyJ+kMwwmrHOUvzAntTQUwoUr3z/0RjrvGMaTxXT5zjaAxzlf82SrBcLB5RfqgmGtrN4Ov4GA==
X-Received: by 2002:ac2:4ad1:: with SMTP id m17mr7115049lfp.86.1555340145025;
        Mon, 15 Apr 2019 07:55:45 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l12sm9989932lfc.61.2019.04.15.07.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:55:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 09/19] PM / devfreq: tegra: Change interrupt request order
Date:   Mon, 15 Apr 2019 17:54:55 +0300
Message-Id: <20190415145505.18397-10-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt should be requested after devfreq initialization because
interrupt handler uses the devfreq, otherwise interrupt handler will
crash if interrupt fires before the initialization. This shouldn't
happen in practice, but it's more correct to have interrupt available
after all of interrupt prerequisites are ready.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 98ba27b1e2c4..2a1464098200 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -686,14 +686,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tegra);
 
-	err = devm_request_threaded_irq(&pdev->dev, irq, actmon_isr,
-					actmon_thread_isr, IRQF_SHARED,
-					"tegra-devfreq", tegra);
-	if (err) {
-		dev_err(&pdev->dev, "Interrupt request failed\n");
-		return err;
-	}
-
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
 	tegra->devfreq = devm_devfreq_add_device(&pdev->dev,
 						 &tegra_devfreq_profile,
@@ -701,6 +693,14 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 						 NULL);
 	if (IS_ERR(tegra->devfreq)) {
 		err = PTR_ERR(tegra->devfreq);
+		return err;
+	}
+
+	err = devm_request_threaded_irq(&pdev->dev, irq, actmon_isr,
+					actmon_thread_isr, IRQF_SHARED,
+					"tegra-devfreq", tegra);
+	if (err) {
+		dev_err(&pdev->dev, "Interrupt request failed\n");
 		goto remove_opps;
 	}
 
-- 
2.21.0

