Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1165BC31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE0D2087F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSRSWdUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfFPXgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 19:36:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43690 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfFPXgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 19:36:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id 16so7467660ljv.10;
        Sun, 16 Jun 2019 16:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qSGWfyGgts7/ACGUx3NwBZ4EU3S1UppuppDAwYa+a/0=;
        b=BSRSWdUKGozsTDN4tXaeO4A7jbuKpBt71UNSuQo/xNKqwqmoTGSiTL2ddHSA3wA92/
         4i8jqm0zSsnqkOB6pffvf4jiF4j1Ev1GCCN5bm8iTFBw5OX/TiqSFdnPl8SRLFXUJe24
         zWnyLiCHFIVgigjnuq3z0+golgy0aO4BrFwzwucjvRWRHyJy9cvjiHGT3GWJNNOKkigp
         UslUpzhtIctQuile3kX8OgTB1+heUUdIoQ8Xu32SwXhPG+uDQaJp7mw5GjylSq2oQeie
         IIgKh3no3AuBzrh89c03H+Gh6PvZNcD1isnDi0YMiCvf4wSEYzqjuzsUyefO3f4MFjaR
         65tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qSGWfyGgts7/ACGUx3NwBZ4EU3S1UppuppDAwYa+a/0=;
        b=MBITJmuW5OZK8JzwkC5XB3rwvbeQpP7LidEdb/EsiYMN1IRwI/ed/WYfqaOIMONwJ2
         LbAO4ON44OgrTKGz2mzX+pWqJy+HigCEuayC36Edc2xFPmwAgnPW/tQh8iJedm6r34mo
         VT+6/fZBwIOCdN3t5f/0rvzRunk1yw95aCDD9vufwRxvXR1kvHSV4CdcQUiluTA4NCj1
         y235tsKGh6yxjJahe9NM+0wmp0J1y0fm4zFGBEmH4dK71U4z4OjIx423aVn+jxgmdh9i
         HM8MPocz46efzBew5PCwaHOMQ+fwPQljgaYFSgQ+LAtoM1b5nJrNk8roHAUWaLGs6KwI
         DxUA==
X-Gm-Message-State: APjAAAVl0WYNI3dv9hM7dU6ujFiKH1pcm2FbDZ2p7eWw5VQWb/N4ETur
        308iuTcgg24x8FAzbOm5YyM=
X-Google-Smtp-Source: APXvYqwSkmBdIBpprG/cKABiWTNsfDQOuRSS4JhueH2eCr04/WhLzruIsne2m/uF5EoJdNIWW3mP4Q==
X-Received: by 2002:a2e:87d0:: with SMTP id v16mr160701ljj.24.1560728170254;
        Sun, 16 Jun 2019 16:36:10 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id q4sm2008377lje.99.2019.06.16.16.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 16:36:09 -0700 (PDT)
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
Subject: [PATCH v4 05/10] memory: tegra20-emc: Replace clk_get_sys with devm_clk_get
Date:   Mon, 17 Jun 2019 02:35:46 +0300
Message-Id: <20190616233551.6838-6-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190616233551.6838-1-digetx@gmail.com>
References: <20190616233551.6838-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no problem for drivers to request pll_m and pll_p clocks for
the device, hence there is no need to use clk_get_sys() and it could be
replaced with devm_clk_get() for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 43aef3614b65..527aa4b90e95 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -527,33 +527,29 @@ static int tegra_emc_probe(struct platform_device *pdev)
 		goto unset_cb;
 	}
 
-	emc->pll_m = clk_get_sys(NULL, "pll_m");
+	emc->pll_m = devm_clk_get(&pdev->dev, "pll_m");
 	if (IS_ERR(emc->pll_m)) {
 		err = PTR_ERR(emc->pll_m);
 		dev_err(&pdev->dev, "failed to get pll_m clock: %d\n", err);
 		goto unset_cb;
 	}
 
-	emc->backup_clk = clk_get_sys(NULL, "pll_p");
+	emc->backup_clk = devm_clk_get(&pdev->dev, "pll_p");
 	if (IS_ERR(emc->backup_clk)) {
 		err = PTR_ERR(emc->backup_clk);
 		dev_err(&pdev->dev, "failed to get pll_p clock: %d\n", err);
-		goto put_pll_m;
+		goto unset_cb;
 	}
 
 	err = clk_notifier_register(emc->clk, &emc->clk_nb);
 	if (err) {
 		dev_err(&pdev->dev, "failed to register clk notifier: %d\n",
 			err);
-		goto put_backup;
+		goto unset_cb;
 	}
 
 	return 0;
 
-put_backup:
-	clk_put(emc->backup_clk);
-put_pll_m:
-	clk_put(emc->pll_m);
 unset_cb:
 	tegra20_clk_set_emc_round_callback(NULL, NULL);
 
-- 
2.22.0

