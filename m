Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005D5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFBF20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdr8AeRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfDKWaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:30:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36986 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKWaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:30:03 -0400
Received: by mail-lf1-f66.google.com with SMTP id o19so1594899lfl.4;
        Thu, 11 Apr 2019 15:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WokcBo1o8Ro3gmFuXtVf3i+xJdgKysQp45IPb83S2aE=;
        b=bdr8AeRKmx/gug0Lq5ZEfIYsUHUheSqXgq6exUvMdxv/bzCk4LmErQViNN1Dx+0Bxd
         l04XAysh1+pO9PCaEDC+61AaYTomrc2V4blv49dhFBjN0FXoNeIu1E6PK1IGPxsUM5Ty
         TNj2pasLhjBFG+caxkSCy9k4SPY2+l8r4XU3eLLbJFJAN9LfspEt6GD4d9XySQb4F5zw
         toj99cvrgII5fLMMXNvPCzPDRa8gGGM14bQL21qP78cAbvy9ZwuRFmD1FBp3+Mf+/rfa
         POOvq/8ZW5/0heK6Z166q79blOJrwNr6h3iAnhcgEdQuatRUSIG+EE0MT+f/QkxQETz7
         HDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WokcBo1o8Ro3gmFuXtVf3i+xJdgKysQp45IPb83S2aE=;
        b=cELGvhwS65rHzM/JtuZT6zjumewNkTIk3C/PWsq0pHHeNxa5GO8YhgWSpRPmlDh43R
         /fJ2n73sSE+Fv9kKjbneubZXVstgZgFt6AKl0kf2TDbgMxPNwceq6isgt2ra5RoYH2EA
         Dn6QIA/ZyZxHa/pTrKq/gFoXqV08sMliTetRbb6steogxkcZF6C6W21Oqk4vxWMdm4fn
         Y/U1jwdun7E2lUel0vI9iX1OiDyfegWvWGKrmhs4uap8DmHQx2v2/9UL3YtsZoJNrez3
         hr9UC4Feud5e96xTaq6Fy/+7ZNKShh0OuFG7fbnMeNZb0GhFk9mOmndZ+0eGLdQ/frJB
         UYmg==
X-Gm-Message-State: APjAAAWG8Su5XDC40+aFiYGxaxwtcVaR/PRfCRLcyu7OLrbh09PUpWvC
        beatHlM6zN+czpgBYKPtooA=
X-Google-Smtp-Source: APXvYqyqCMO9u2KoDRJqbHss3nM2+aCpE10RowI6w4fTWN4Yug7SDiX4ZbFJzlABbrzT7luE/EK98Q==
X-Received: by 2002:a19:c216:: with SMTP id l22mr3495317lfc.112.1555021800710;
        Thu, 11 Apr 2019 15:30:00 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id d13sm1646000lfa.40.2019.04.11.15.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:30:00 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 2/8] PM / devfreq: tegra: Replace readl-writel with relaxed versions
Date:   Fri, 12 Apr 2019 01:29:08 +0300
Message-Id: <20190411222914.25539-3-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411222914.25539-1-digetx@gmail.com>
References: <20190411222914.25539-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to insert memory barrier on each readl/writel
invocation, hence use the relaxed versions.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index ec4ff55f5eea..d749399f67ae 100644
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

