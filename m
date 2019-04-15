Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FDEC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D46C2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldAhs1+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfDOOzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:55:48 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43839 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbfDOOzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:55:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id f18so15947003lja.10;
        Mon, 15 Apr 2019 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HonNGQBQPPume3xb4u4R8OF7EASjclWY4XMwkylki7I=;
        b=ldAhs1+hpdO8nwPNvvWeyMTgcPjA89xuvb40QAioKEVRX930OdsuI6ZykJo7jdy7HH
         xE2Fr15hi7sJzlnz2Erxp0yALw7jCP2EyQDVW+mCpsH/jIwaHgxPUM3w77SXHQl5llD4
         uma1prQWds1nxeSLino11KEanYnvHMmBCee6B5wYgrqHmDp80Ti+Ec8bqfXRVJ/Si1Sx
         UsBfSzVGeTWHAK4SuiEVPbd3n3kXbSaCrh+riJXVyhUAxMvyZAq9/5WlwF5Mzo0lpkGZ
         R1RJVfp3hlhcPMJLyDgJnlQhFQgu0ruoVg+7ddR0ELgw04TFmIhu3vpWXJ3cgfE8CkF0
         CTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HonNGQBQPPume3xb4u4R8OF7EASjclWY4XMwkylki7I=;
        b=GF9oh9a7WFrqatwsSWD+1tJUHdx7PoMPAJH1RPr7PpgmxW4Qys8iafMGT+p9+9Zi46
         c27efmCbd6feAUsoJEa3lyfhiH8njprMJtd5d9WA0tD5u41uQaQ9JbRHfmr4Rk/+qQ1L
         HQlXa84C/slmGC93ArypGqVt8WsNVf6TWIQuK2yPqcO2Nx+dvypFdWlDyDhK7hDD5JIZ
         tqw+2xpD06R6D/wgrO6/qTPXKOvRFX/+GfXh5fkgf4HvjvhG1EYxufm91CcYO4g0vFjg
         oCqbcJNg5JFPZHCFPeDd392b+yPF9ldTMi9srrd56IDY9IPPDhDRm5C9bQG0Ronfmdcx
         XPxw==
X-Gm-Message-State: APjAAAXhAJxfY94qEGMsblrJf4NlyCzrxTHVu9lQrfFcqkqZeAszbqyP
        F2K29DlQmEwbCX9SXcUHjjY=
X-Google-Smtp-Source: APXvYqz+CyArdDxY+ldT9BHf8tMnctrHeI9UAh8q9Zj7yMnXdh6hGJTqo73JB7maB91/gUhmXUdTWw==
X-Received: by 2002:a2e:b01a:: with SMTP id y26mr23079457ljk.38.1555340143822;
        Mon, 15 Apr 2019 07:55:43 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l12sm9989932lfc.61.2019.04.15.07.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:55:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 08/19] PM / devfreq: tegra: Remove OPP entries on driver removal
Date:   Mon, 15 Apr 2019 17:54:54 +0300
Message-Id: <20190415145505.18397-9-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes "_opp_is_duplicate" warning messages on driver's module reload.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index c248c18431d9..98ba27b1e2c4 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -701,7 +701,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 						 NULL);
 	if (IS_ERR(tegra->devfreq)) {
 		err = PTR_ERR(tegra->devfreq);
-		return err;
+		goto remove_opps;
 	}
 
 	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
@@ -709,10 +709,15 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	if (err) {
 		dev_err(&pdev->dev,
 			"Failed to register rate change notifier\n");
-		return err;
+		goto remove_opps;
 	}
 
 	return 0;
+
+remove_opps:
+	dev_pm_opp_remove_all_dynamic(&pdev->dev);
+
+	return err;
 }
 
 static int tegra_devfreq_remove(struct platform_device *pdev)
@@ -722,6 +727,9 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	u32 val;
 	unsigned int i;
 
+	devm_devfreq_remove_device(&pdev->dev, tegra->devfreq);
+	dev_pm_opp_remove_all_dynamic(&pdev->dev);
+
 	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
 		val = device_readl(&tegra->devices[i], ACTMON_DEV_CTRL);
 		val &= ~ACTMON_DEV_CTRL_ENB;
-- 
2.21.0

