Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6959FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F4B20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZp9sJmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfDKWaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:30:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38949 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfDKWaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:30:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id l7so7015238ljg.6;
        Thu, 11 Apr 2019 15:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1HudX0mRMZTxhiwJx52xCjzdCBR5YKpsZl6gpZ5B83Q=;
        b=RZp9sJmMe+4jTC+cpJjCDCPlm5iZaxdVIrkDonUYfiTVZrv7EJaEXWTEy574ofjgMK
         wolosJznGc7R/2Ckh3aX296O2a94DGI5x0HQNd3f7KxVbzOcQWkwKiB7v/gBaBHthTjz
         tVC2O0mb7uoGrjfmcHuTNpetkR7DRKyQ13Ft1Uk9AI9HuOX5DnPCt6IoEFamYLFhTkc0
         ymjV/612pSdR0phg4nz/WnU+JFgE2bawY6J/USr4Gn03XvezJFvTosh7UBxgxvN7d6r0
         WR0qQEFjw402asaoinJCmuyMUwKitdKzJbe2eFyc4HcXKli3dsaWtIE1bQfhOqxNt28w
         ENIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1HudX0mRMZTxhiwJx52xCjzdCBR5YKpsZl6gpZ5B83Q=;
        b=Rd7/nn3Xl5MSUHsdCS5Tu5d+zX6gU4vmnuOyvJT1/Sxr62+LaoJNtG/dkwcHxSlENE
         9SMJEIAuOYOWXzMulzJUykA190Awo/Tu0HMc43gHhIwBT5yIdCSvi0z0gNJhjdtc5m1e
         HNv+S975Q2ASFzcRN1oNj0dH2VnZ0XSQ5ltuXQkQe+StbpfpS/juHnztZH8+xqyjzv3+
         zuHvnuW6TitOhBnLqufEMT4Osn1VGUkfMePWLUaY5ieGssWA3gpBXH0ybTHGs/pMzgRX
         L9hWCjLtcAmQeGvykODA0orCqMFu1KM/LZbEtTV+97gX7f/PS5ZkzOqG1ETeHyuRaULc
         cA6A==
X-Gm-Message-State: APjAAAUzlvAXqbw8NvpjIHZ9wQsOvl2m7EFnMDVOihTy5AX2Un+G2pNG
        JpG/irCpDn9Nga/Oty+s1wU=
X-Google-Smtp-Source: APXvYqyoRHoFCKHC1+IxfWE2NI9oKEymmwu4IDeIbpfrvoh3ZqToCPrZVxT+8VfYPmMFjFvtkV41ig==
X-Received: by 2002:a2e:8787:: with SMTP id n7mr27797885lji.31.1555021799597;
        Thu, 11 Apr 2019 15:29:59 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id d13sm1646000lfa.40.2019.04.11.15.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:29:59 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 1/8] PM / devfreq: tegra: Fix kHz to Hz conversion
Date:   Fri, 12 Apr 2019 01:29:07 +0300
Message-Id: <20190411222914.25539-2-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411222914.25539-1-digetx@gmail.com>
References: <20190411222914.25539-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kHz to Hz is incorrectly converted in a few places in the code,
this results in a wrong frequency being calculated because devfreq core
uses OPP frequencies that are given in Hz to clamp the rate, while
tegra-devfreq gives to the core value in kHz and then it also expects to
receive value in kHz from the core. In a result memory freq is always set
to a value which is close to ULONG_MAX because of the bug. Hence the EMC
frequency is always capped to the maximum and the driver doesn't do
anything useful. Let's provide OPP with rates in kHz since this eliminates
few multiplies and divisions in the code. This patch was tested on Tegra30
and Tegra124 SoC's, EMC frequency scaling works properly now.

Cc: <stable@vger.kernel.org>
Tested-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index c89ba7b834ff..ec4ff55f5eea 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -394,7 +394,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 
 	tegra = container_of(nb, struct tegra_devfreq, rate_change_nb);
 
-	tegra->cur_freq = data->new_rate / KHZ;
+	tegra->cur_freq = data->new_rate;
 
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
 		dev = &tegra->devices[i];
@@ -486,21 +486,19 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
 	struct dev_pm_opp *opp;
-	unsigned long rate = *freq * KHZ;
+	unsigned long rate;
 
-	opp = devfreq_recommended_opp(dev, &rate, flags);
+	opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(opp)) {
 		dev_err(dev, "Failed to find opp for %lu KHz\n", *freq);
 		return PTR_ERR(opp);
 	}
-	rate = dev_pm_opp_get_freq(opp);
+	rate = dev_pm_opp_get_freq(opp) * KHZ;
 	dev_pm_opp_put(opp);
 
 	clk_set_min_rate(tegra->emc_clock, rate);
 	clk_set_rate(tegra->emc_clock, 0);
 
-	*freq = rate;
-
 	return 0;
 }
 
@@ -682,7 +680,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
 		rate = clk_round_rate(tegra->emc_clock, rate);
-		dev_pm_opp_add(&pdev->dev, rate, 0);
+		dev_pm_opp_add(&pdev->dev, rate / KHZ, 0);
 	}
 
 	irq = platform_get_irq(pdev, 0);
-- 
2.21.0

