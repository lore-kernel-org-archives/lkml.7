Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DE4ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE314205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tBSkEVcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388366AbfJANXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:23:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35607 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388322AbfJANXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:23:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id y21so3252927wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xHg72LNjCpgWpTQNdjLMrLB1+jZKsE9cWHPET5xMEc4=;
        b=tBSkEVcsW6oFX/En1CD0+X90T8EZ2yuruEKZS2svB/OqS6t266RUlcVeUtyOGhPvPe
         CJBZ5YaWz6x/uZzh58KAL9T/L+YxCeD+ZjU4rd4WEYonqle0AV3rIinnqU2OBuEcp0QW
         0BaMt55o+J0mC+/+/MfJkE64V4hlMArfxvBl+Gkw2aVMjE/kvbERBqcAyCkjYGTEijVr
         w1/y0xICSXsVSo/otMvM969/3rfmBpN9V0VJPI/KD3dMP3Xvxt0hZGH/4DVrnSuTCz30
         5DGBlmsdmPI4vedlC0DWDgC/tjMG0TpnXA3UCWxiGPym5EiVHzsnO3nzbDHCEWFg5V5U
         6k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHg72LNjCpgWpTQNdjLMrLB1+jZKsE9cWHPET5xMEc4=;
        b=t5pR1zU4uVSocoQBMbpkDU+H8dfTT+firNql5AT4YjOxOmjrHHHLHcJGP7tEM3qdu2
         Vzwt1JYZEoJU8Q2RLYB3FEQIFtBYz+Ve2SbqFAUQK1XwTr0OJ/wegDkQj2dTJgYEOVEG
         K1dydrByBjhIeS31n+7NtyD6aWI5B6h6czOfKs61SeIyCvgU7OAeyrrUWK3pgxkUTCiu
         Y75aoekz/K43Os/35Ti60qKLbGYnZWOKCf/BJl06TmRzpFpDLpIGanifNQPQlQKqqrPv
         Qc0DgeA5brThSOHqraoQM9NKm7j7Mt2QFhYxKpFGTByAktzCiyaG07lF1lzjfDdyoE0i
         WRcA==
X-Gm-Message-State: APjAAAXgVP+UXEOEARs8yuC32+tFzCvTMcEyBQT53cjahYaibM18hYsL
        SZYUjNfcgnPlsZe0UhLa4ulg9Q==
X-Google-Smtp-Source: APXvYqzdDFS+yo16VHfh45jtAQUaOFj5qTHmjpTnTyXMTwrt6M9CMkxbZDgrJlNyRNEpgNw/dOm9HA==
X-Received: by 2002:a7b:cd99:: with SMTP id y25mr3756001wmj.152.1569936224974;
        Tue, 01 Oct 2019 06:23:44 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id o22sm41847990wra.96.2019.10.01.06.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 06:23:44 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/3] ahci: tegra: use regulator_bulk_set_supply_names()
Date:   Tue,  1 Oct 2019 15:23:31 +0200
Message-Id: <20191001132333.20146-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001132333.20146-1-brgl@bgdev.pl>
References: <20191001132333.20146-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the new regulator helper instead of a for loop.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/ata/ahci_tegra.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index e3163dae5e85..cb55ebc1725b 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -483,7 +483,6 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 	struct tegra_ahci_priv *tegra;
 	struct resource *res;
 	int ret;
-	unsigned int i;
 
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
@@ -543,8 +542,9 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 	if (!tegra->supplies)
 		return -ENOMEM;
 
-	for (i = 0; i < tegra->soc->num_supplies; i++)
-		tegra->supplies[i].supply = tegra->soc->supply_names[i];
+	regulator_bulk_set_supply_names(tegra->supplies,
+					tegra->soc->supply_names,
+					tegra->soc->num_supplies);
 
 	ret = devm_regulator_bulk_get(&pdev->dev,
 				      tegra->soc->num_supplies,
-- 
2.23.0

