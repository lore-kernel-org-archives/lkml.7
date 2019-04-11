Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47728C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101DF2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBXlxXu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfDKWEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:04:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40750 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfDKWE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:04:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id q66so6976640ljq.7;
        Thu, 11 Apr 2019 15:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUHPgW7dZuGazhrcakTZtDm+HbJ3DjUZGyh8GwQB52k=;
        b=rBXlxXu1ngSTXolx+1g1Qbtc98vDj83c9p3TnOhgzb1aJsdBct67YPD7Z9Uv479cln
         eEzqaQFWcqcZ70IAgZgfp7xpzirscZPo85WNsbKhOb2mUn0P8rLiGAbuA1FTHB3rCwJe
         oZgUnRSyFHQ8DWdb6+CvD2E5Hyyxq8sVXGbCGKHGHfqJTS7R9e/UzA8rIkUgqrA6Rp0t
         51005Vuyz67R+P9V6TyUNBJDdEVtjbKOfY2Li7tuxpjAL/t5XuuRMRGAx3NXcKhdrUU+
         xNxTDzGd6ZgY1Vm+HD/Wg8jIzqJNfeJ+L6CE4/GR2bArLb9do9WDEW68hkYK2+bHkFew
         SuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUHPgW7dZuGazhrcakTZtDm+HbJ3DjUZGyh8GwQB52k=;
        b=Pf19nd5F/KmEHomdF3/Er7QamoLoP2tKK6Q2VVmsTgoKudXgDduPKKFTX0u4l/5eCB
         JputHijRJCK4wIgUKwERj/VI1CeB2pKE/cIizL2LoZNCI/Olf7MfoknMpgvDNPax0O+2
         T+GktUVKwHweGvsiOXnsvf+neuGliQcJdK7yAtK1PXZIf0FGt47k5Pw/xv89vOsH1uJT
         5VzBOYK5iizUYoFyejVDHORu/lRUH7okRD0XFFRbMOsBRBMAUCqHvzhOJpOCL2qiF+3R
         pmhbgaWsyc/sy2+UZXDXCFsOCo7XaUnhz2ga5553BqCq6drxFOKnMS6V+uQdsTjjL8nu
         4d0Q==
X-Gm-Message-State: APjAAAXpt18GDXy0qiQBZ+Q2q39+bch29ZAs/0tKSHBCslenk/JUEvZN
        4k81EYu6Yp0vgJ//oB8oGb4=
X-Google-Smtp-Source: APXvYqy7gf7R3PaXZFHz6LIH8cHWlCsEVHbWo+4ffZQ7CYDryxGOfUgBP5k2b1hOMP/WjCm0Hu7ikw==
X-Received: by 2002:a2e:9703:: with SMTP id r3mr18999423lji.88.1555020265933;
        Thu, 11 Apr 2019 15:04:25 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id e18sm7887808ljb.12.2019.04.11.15.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:04:25 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] clk: tegra: emc: Fix EMC max-rate clamping
Date:   Fri, 12 Apr 2019 01:02:28 +0300
Message-Id: <20190411220230.21726-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411220230.21726-1-digetx@gmail.com>
References: <20190411220230.21726-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a clk user requests rate that is higher than the maximum possible,
the rate shall be clamped to the maximum and not to the current value.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-emc.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
index 28068584ff6e..9a0179235939 100644
--- a/drivers/clk/tegra/clk-emc.c
+++ b/drivers/clk/tegra/clk-emc.c
@@ -121,7 +121,7 @@ static int emc_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 	struct tegra_clk_emc *tegra;
 	u8 ram_code = tegra_read_ram_code();
 	struct emc_timing *timing = NULL;
-	int i, k;
+	int i, k, t;
 
 	tegra = container_of(hw, struct tegra_clk_emc, hw);
 
@@ -130,12 +130,17 @@ static int emc_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 			break;
 	}
 
-	for (i = k; i < tegra->num_timings; i++) {
-		if (tegra->timings[i].ram_code != ram_code)
+	for (t = k; t < tegra->num_timings; t++) {
+		if (tegra->timings[t].ram_code != ram_code)
 			break;
+	}
 
+	for (i = k; i < t; i++) {
 		timing = tegra->timings + i;
 
+		if (timing->rate < req->rate && i != t - 1)
+			continue;
+
 		if (timing->rate > req->max_rate) {
 			i = max(i, k + 1);
 			req->rate = tegra->timings[i - 1].rate;
@@ -145,10 +150,8 @@ static int emc_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 		if (timing->rate < req->min_rate)
 			continue;
 
-		if (timing->rate >= req->rate) {
-			req->rate = timing->rate;
-			return 0;
-		}
+		req->rate = timing->rate;
+		return 0;
 	}
 
 	if (timing) {
-- 
2.21.0

