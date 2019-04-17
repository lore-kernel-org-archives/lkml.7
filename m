Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89CBC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BBE217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZUf0MJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387626AbfDQWlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:41:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35617 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbfDQWlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:41:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so181274plp.2;
        Wed, 17 Apr 2019 15:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MfIFaN/cDvep9inRd5PqDA7WzNgKemRCq9lkW6WG194=;
        b=gZUf0MJLz1hjZN+HLg990m7oIWJZwioScKmoZ88SXDUEZ/pLHcZK+AHFo4AgMLf5Ha
         qKB50yzy9zN0wrxyYFrpXlgJLl9x69HK1Go4+VmoUypMcQZi3ycXt8t+DwHiOKZCTbXt
         sAni1PVSAcN9rEqGC0grl0qSChFuVMnYKyjcNZYnUqIfe2J0Weq0R7+JUm5oZ/gDgSNd
         VCiGUNF58NDS5a2tD47oql9kB3yjykY+/kWe4M+XYL7XProLgXr+cw2DYyf2hXQlQpVb
         6R1mLYblCDiQuJSbTc8QUqSxSqbTmQ6QvTU4ZsiAOvfcpiw0O9YpPzA9OV7InV/0ZWkL
         GqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MfIFaN/cDvep9inRd5PqDA7WzNgKemRCq9lkW6WG194=;
        b=gFinQks6IdqmcGVmzi5oVW79Cpn6A9/L/aKdItiyNCrUN9VVWRTLCi/myeDIgvNety
         /w6HKCb/+ABxVadPm7LisnIPWTvrA2V8PTGM7WRsMbvmr2/3UKh9esotXURDVwYDK+IW
         JNLDZTsqi8eV7K/pkDXF3y1hg3SW7Npu8QVZDB318tm9WG7kWnHCO5SQdGFLpXJkOxw1
         SDKRkusgvnD0EvxagNoMXX/aMALaEUMhr7b1Cdd/QBCIaKfRXXxKT5Z+SUszFDZo58MC
         84YlQpQ8hseULwYBDjMnomiE3eUseOV+bCr1DYKrUv0/2xWjRpkNyMyN6CNu6tmjG97C
         b8pw==
X-Gm-Message-State: APjAAAVlReXQa2vxWJx+tcJjF9N3C6wKTw0XwAygfkmZuNBcTv7h+myJ
        GHPoXQmkC8hoQjgp/PVP9rg=
X-Google-Smtp-Source: APXvYqxD8zyDfsyd12cU9lZENFvoXgXHm2vw//SmJBRxzO3RVC2nGtjX3VZzavkaxuzwgXId/24qEg==
X-Received: by 2002:a17:902:b94a:: with SMTP id h10mr92452463pls.82.1555540450496;
        Wed, 17 Apr 2019 15:34:10 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l26sm281030pfb.20.2019.04.17.15.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:34:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 02/16] PM / devfreq: tegra: Replace readl-writel with relaxed versions
Date:   Thu, 18 Apr 2019 01:29:11 +0300
Message-Id: <20190417222925.5815-3-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417222925.5815-1-digetx@gmail.com>
References: <20190417222925.5815-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to insert memory barrier on each readl/writel
invocation, hence use the relaxed versions.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 43cd1233f87b..f7378a42d184 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -191,23 +191,23 @@ static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
 
 static u32 actmon_readl(struct tegra_devfreq *tegra, u32 offset)
 {
-	return readl(tegra->regs + offset);
+	return readl_relaxed(tegra->regs + offset);
 }
 
 static void actmon_writel(struct tegra_devfreq *tegra, u32 val, u32 offset)
 {
-	writel(val, tegra->regs + offset);
+	writel_relaxed(val, tegra->regs + offset);
 }
 
 static u32 device_readl(struct tegra_devfreq_device *dev, u32 offset)
 {
-	return readl(dev->regs + offset);
+	return readl_relaxed(dev->regs + offset);
 }
 
 static void device_writel(struct tegra_devfreq_device *dev, u32 val,
 			  u32 offset)
 {
-	writel(val, dev->regs + offset);
+	writel_relaxed(val, dev->regs + offset);
 }
 
 static unsigned long do_percent(unsigned long val, unsigned int pct)
-- 
2.21.0

