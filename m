Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139D5C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAA020861
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4XbwT/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfFPXgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 19:36:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43700 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfFPXgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 19:36:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id 16so7467761ljv.10;
        Sun, 16 Jun 2019 16:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t2V7RCk27WCmUusM85nZL0QgT3ShS/tiovCYzrgWfsY=;
        b=o4XbwT/zpwZwYLrQ4m8YDgj621PjLQfcjEol41vgybx8ypDk40VFypufhxsC/bgDRi
         ogWG90ShNvIF9kvf/1zS256dZjMc78CjxsD+BlzXdPVC95eS5tHjOrUkfEOZYGznxPpK
         KIJOUYY8J3nAWTpr6Dp9QFu+bMZOTgNM+TwkCzYWkkdROqor/yEMOQw3RtYLpmAm5ht2
         FhgUt71iu/G0jWWB5IjjOzT6GiBZQO36sve+4kIP1HybGAMpd9bau40ruS1EnY9aAgRG
         r37zepZlaXLrxv/t2SgpiMLdxl0MGntkzYIvPfW5+XVdfi0/Lek084GFXE0JIbPVChRb
         SVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t2V7RCk27WCmUusM85nZL0QgT3ShS/tiovCYzrgWfsY=;
        b=PGyY2etGVcr9W4JM0Jf/5Tvpgv6zwXqM+cm5ax+99ZgoywnZikNMaz+EQE62He6x27
         4OYkq7MWAydwbeMkr/H6gdDZCnbHvRq2itdY+J65ds6SdUaxWHN0kPGsJk8LGzY4H7rA
         TfiMhd7IW1vAA7UTy0Mi5xknYLYp0BJntGjq1kNHST/+bYWBdVl9CxReDokFbdcGdQVH
         5MdbsjGD4hoC0zNZIEhXNA6VxCI7wFf2AnYkWN8mu8paWHqoU3Ei2R6/4I2YBVlYETuU
         Lya73C6wgeoLSGVqZLbSSvGzch/eQGAeQ+uol+x+tJ5NexSWQLriH5xMUKMPG+8TfNus
         UwMw==
X-Gm-Message-State: APjAAAXWXckgHnIllcU1Dq/n0dvWd8Wxvo+V8ruBb9rfKgQ/UR3YxmdA
        0YE725kqGB9IuEcebsXMZ+E=
X-Google-Smtp-Source: APXvYqwOcczRwLkBHBL5rDESBQ+g3ZJMJA4SKCrxSh6v46W43ahnBQFMHehiS8PlLWBeH+RWY/X46Q==
X-Received: by 2002:a2e:9cd4:: with SMTP id g20mr6704131ljj.205.1560728174046;
        Sun, 16 Jun 2019 16:36:14 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id q4sm2008377lje.99.2019.06.16.16.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 16:36:13 -0700 (PDT)
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
Subject: [PATCH v4 08/10] memory: tegra: Ensure timing control debug features are disabled
Date:   Mon, 17 Jun 2019 02:35:49 +0300
Message-Id: <20190616233551.6838-9-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190616233551.6838-1-digetx@gmail.com>
References: <20190616233551.6838-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timing control debug features should be disabled at a boot time, but you
never now and hence it's better to disable them explicitly because some of
those features are crucial for the driver to do a proper thing.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 3 +++
 drivers/memory/tegra/mc.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index eaebe371625c..4c1492c653e1 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -660,6 +660,9 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	} else
 #endif
 	{
+		/* ensure that debug features are disabled */
+		mc_writel(mc, 0x00000000, MC_TIMING_CONTROL_DBG);
+
 		err = tegra_mc_setup_latency_allowance(mc);
 		if (err < 0) {
 			dev_err(&pdev->dev,
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 0720a1d2023e..abc565b42225 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -33,6 +33,8 @@
 #define MC_EMEM_ARB_OVERRIDE				0xe8
 #define MC_EMEM_ARB_OVERRIDE_EACK_MASK			0x3
 
+#define MC_TIMING_CONTROL_DBG				0xf8
+
 #define MC_TIMING_CONTROL				0xfc
 #define MC_TIMING_UPDATE				BIT(0)
 
-- 
2.22.0

