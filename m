Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F1FC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED33D2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u07hBvEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfDOO4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:56:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45675 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbfDOOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:55:57 -0400
Received: by mail-lf1-f67.google.com with SMTP id t11so8834640lfl.12;
        Mon, 15 Apr 2019 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g0f7ZY8i9j16DUYrPZZdyFK1eNQfLvrcOqHQkH44N70=;
        b=u07hBvEI/ohUU5TejR5qm25pW8QnVlYDQzsx/uHzvV0zD/MHA0KopG1c0MZPoFlaf9
         NV1lfx5uby7efXJZ7nYx4pZzO5KFMkBNuh+nF+wIIY1hfSKqne9z4unZziVLAp/rBGa/
         DYKZBgCX1rZqYyHdANUiChrCrqOuxGHzmysLE+rNH75xUdiwI5HwtkMpY9btb6aKjsYg
         WopzmSYAcLvIim2WJXCyv5R/vP5GHGZAKKH7Y48EkewW7u5J/w5Ih5ryR7reQt1FDLEb
         HDZd4oga8Q+Z+PAdS3mCKkMvulItml079qFbnvEnhHeBdGSOLJax3eHQTDAVeNhB0BFI
         Rnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g0f7ZY8i9j16DUYrPZZdyFK1eNQfLvrcOqHQkH44N70=;
        b=GgGM0isGy17hgZoIsKGju5nHpATzr3XjVcs5NnAPj+OkAG6wunwl5mN/1FpC0Zm/Fz
         SbTmHN3Y8c7rXiK19Sb4i+kO+j5WxILuFW5QN+SGIYrg8GdNYfL606EU2aSnp/4q47Ms
         9q1O+rmXT38cy7uiKM0wdr1ViMT+zTg6/plsfF3JZ5kpq2AoiSStv4xZ2BRCG0HtKNWw
         fe1Kjj1Ysl7nkIshcd+sxIsQhGZFNkAzC3EcuRNxS+OaHry3a880I1syLBIu0XBJD3no
         mdNlPV2LCLZQZPXU8rHCOnaGVAWilFLopwEqrIkW3al54SiBzyuXF8UdftEuFayWnm6j
         cU5g==
X-Gm-Message-State: APjAAAVHnD/4YwcURASkOzCO8Vo/KXKl1Y4al74G6pNgjZDBxdDJS2YS
        P4EgdOlN8DxlolMx50WCmso=
X-Google-Smtp-Source: APXvYqySM9jFFINKlp3uqbBSNF+ZqMSqTASBVLo7t+umXcB1LyInE1iBBqHUnSBWMyFajAlHRmIXlw==
X-Received: by 2002:ac2:5495:: with SMTP id t21mr3442247lfk.3.1555340154409;
        Mon, 15 Apr 2019 07:55:54 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l12sm9989932lfc.61.2019.04.15.07.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:55:53 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 17/19] PM / devfreq: tegra: Support Tegra30
Date:   Mon, 15 Apr 2019 17:55:03 +0300
Message-Id: <20190415145505.18397-18-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devfreq driver can be used on Tegra30 without any code change and
it works perfectly fine, the default Tegra124 parameters are good enough
for Tegra30.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/Kconfig         | 4 ++--
 drivers/devfreq/tegra-devfreq.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index a78dffe603c1..78c33ddd4eea 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -92,8 +92,8 @@ config ARM_EXYNOS_BUS_DEVFREQ
 	  This does not yet operate with optimal voltages.
 
 config ARM_TEGRA_DEVFREQ
-	tristate "Tegra DEVFREQ Driver"
-	depends on ARCH_TEGRA_124_SOC
+	tristate "NVIDIA Tegra30+ DEVFREQ Driver"
+	depends on ARCH_TEGRA
 	select PM_OPP
 	help
 	  This adds the DEVFREQ driver for the Tegra family of SoCs.
diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index f0711d5ad27d..0a2465a58cf5 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -719,6 +719,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id tegra_devfreq_of_match[] = {
+	{ .compatible = "nvidia,tegra30-actmon" },
 	{ .compatible = "nvidia,tegra124-actmon" },
 	{ },
 };
-- 
2.21.0

