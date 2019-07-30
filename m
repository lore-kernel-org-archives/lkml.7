Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF851C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869D6216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+GZOYya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfG3Q73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:59:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52027 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbfG3Q6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:58:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so57855432wma.1;
        Tue, 30 Jul 2019 09:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCQNSQK+2muyk726fUJhk7VrSnWFFmbUV5XprGSciK8=;
        b=c+GZOYyaQp1JNvHftjK98BENDh2w8pUzm5vCs4vyLNbkbGCv9ybiUHSyIOBZolaRdd
         3UGLwUT4uDO3sr+VWmNltbi3OKwX5Wi5cSciqzAE/qOaxDdV9a4K+ONItqtvA9pCHL4d
         DyKvNtDPVOW20kQO7dciyVNCJrUNdvd+1+ksEBF5OaIg1BTzmDUfU9R9LSOnZasHN6FD
         nu/kt9BJ95moviNv4CSGmtRoYljcMAwqFVYU8YR8yKvDF7E1tDnxszIfT9fAIl2IzSM3
         JdhZt6K0lBWLzIFvjju+rC6Vq3ydVYheKGAXq1AKUjefuyzXB4hCAK05o1ly6yR5rl2z
         a1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCQNSQK+2muyk726fUJhk7VrSnWFFmbUV5XprGSciK8=;
        b=JjrZdMx4gxcFfLjUoWAZIFrQvDRGOECkLjMUNTvCcQp7wf9TeIxdXMOopypKlpk9Xf
         FffjTm7esv2JGkEiEYC9Sbce/cDIRuCVUQiwuEO6s/JonJqdKt3FY/yh1KusFlJssrbv
         pNORAyqbuj2ZcMgMuW9bFim7FDAVOLbHICNAMozK+pRHIpX1qbNVwihdj6JYo8Exx5rd
         9UMYB0MqFaNcy2AYtEorHIaAwQ/gEmdZA2du593pUFhlvgblW34yMKiGL3VGhDpvX+hV
         MUqdZKqBQiZH0pEN0RVI/QNUZ0Nb4lLTG5cIcJok8nLHatrJsguKP+n253oyu7w37vAP
         73Pg==
X-Gm-Message-State: APjAAAWcFpzC2AFiFK3n9h2IaTvRClf+A+UUWgSvHJrDBBkE2Ny0NII2
        VErthnUglWbDOkJm4vCEqoZ8Vx3W
X-Google-Smtp-Source: APXvYqygO5NFFLsYp4WhWLD7ZVP7KsagNkXt1AlKjvyVhfvh5FZn9qOXup11dkmNVQ8635QgU2BYxA==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr108948548wmb.129.1564505892259;
        Tue, 30 Jul 2019 09:58:12 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id r5sm70845040wmh.35.2019.07.30.09.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:58:11 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 03/15] memory: tegra20-emc: Adapt for clock driver changes
Date:   Tue, 30 Jul 2019 19:56:06 +0300
Message-Id: <20190730165618.10122-4-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730165618.10122-1-digetx@gmail.com>
References: <20190730165618.10122-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now Terga20 and Tegra30 EMC drivers should provide clock-rounding
functionality using the new Tegra-CLK driver API.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 50 ++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index da8fa592b071..b519f02b0ee9 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk/tegra.h>
 #include <linux/completion.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -421,6 +422,44 @@ static int emc_setup_hw(struct tegra_emc *emc)
 	return 0;
 }
 
+static long emc_round_rate(unsigned long rate,
+			   unsigned long min_rate,
+			   unsigned long max_rate,
+			   void *arg)
+{
+	struct emc_timing *timing = NULL;
+	struct tegra_emc *emc = arg;
+	unsigned int i;
+
+	min_rate = min(min_rate, emc->timings[emc->num_timings - 1].rate);
+
+	for (i = 0; i < emc->num_timings; i++) {
+		if (emc->timings[i].rate < rate && i != emc->num_timings - 1)
+			continue;
+
+		if (emc->timings[i].rate > max_rate) {
+			i = max(i, 1u) - 1;
+
+			if (emc->timings[i].rate < min_rate)
+				break;
+		}
+
+		if (emc->timings[i].rate < min_rate)
+			continue;
+
+		timing = &emc->timings[i];
+		break;
+	}
+
+	if (!timing) {
+		dev_err(emc->dev, "no timing for rate %lu min %lu max %lu\n",
+			rate, min_rate, max_rate);
+		return -EINVAL;
+	}
+
+	return timing->rate;
+}
+
 static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
@@ -477,21 +516,28 @@ static int tegra_emc_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	tegra20_clk_set_emc_round_callback(emc_round_rate, emc);
+
 	emc->clk = devm_clk_get(&pdev->dev, "emc");
 	if (IS_ERR(emc->clk)) {
 		err = PTR_ERR(emc->clk);
 		dev_err(&pdev->dev, "failed to get emc clock: %d\n", err);
-		return err;
+		goto unset_cb;
 	}
 
 	err = clk_notifier_register(emc->clk, &emc->clk_nb);
 	if (err) {
 		dev_err(&pdev->dev, "failed to register clk notifier: %d\n",
 			err);
-		return err;
+		goto unset_cb;
 	}
 
 	return 0;
+
+unset_cb:
+	tegra20_clk_set_emc_round_callback(NULL, NULL);
+
+	return err;
 }
 
 static const struct of_device_id tegra_emc_of_match[] = {
-- 
2.22.0

