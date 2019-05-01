Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F0FC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 23:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016AC2089E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 23:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vD3YaRW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfEAXmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 19:42:16 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40194 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfEAXmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 19:42:13 -0400
Received: by mail-it1-f196.google.com with SMTP id k64so339370itb.5;
        Wed, 01 May 2019 16:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c/LJqNqccNSr34Z2GOKtQr7/VI/W6wdUURuTwqlUb9Y=;
        b=vD3YaRW2AQTqnynJjlisC0Ju3qPbd1+ohMflouQrgjGDz42qbsb4++ZCuLEJbKy1RK
         3y9FIWcK0UMjeXhCZi63F3lsLKQQjRtvpWNb5Bx2qaG3aS7Py8uZmJM//CeuTXVndTZ8
         wfzE/nBphC31gbguUuOUHIIIfq86TLuhmDmGJ+l42bkzB0iqJOMd7dxoroga/Ws5LgSJ
         0BOBuQfOBgzVlKI96WwEB0Hvgu3v46HNJbMUN5ABX4POzRRZb7K5RtyX8gwOUZWZxYqG
         ySwfulNmo3Qy6sBN4efTGNb0J2TkwT0VZ3AnnyMj404ZaX0n3pyMglBQ7OMscZwwBRtI
         zvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c/LJqNqccNSr34Z2GOKtQr7/VI/W6wdUURuTwqlUb9Y=;
        b=salmjk0gcF5SREqYbZw0+AYezLetHSZkBkaZYRYnTnnyeeqyjgD5Rjb+rCNTTtv9Ml
         LrGbMmuMYK+f2WG8FAO/SIUkD0h2ZlNi4M1rvI1hY7bbYgHWy/k5EzrT9tX1vWj3VDTY
         9lo1+Wh7+DEiRL+4dslSYZngOXvznwrcxzMF27RjLqe9smfpKHons8rqbtr4xOpMbZQK
         aWgiDnftYzGGDtd/2G2sCMflASJoF/fgWNqg5Flj9PLaRMvWEhfDHHZTtxzQSylyyhYt
         IEZwxqPSgyDoLDLSVuFmrNGGFwEQoKUjUwz9ZUyupnv8QPQ35b6zgnfPehMALWBYejpj
         hZEg==
X-Gm-Message-State: APjAAAWmlGrEfbFQoD2IABQH1/F4fvy8WJhB1BGiX/m54JHnpe6//sn2
        1xj524VgOTshNFnP/hesfos=
X-Google-Smtp-Source: APXvYqxjmVGeDLJ+wSi7y4E2SRHC9/emyw7kMiz9WTmAmNeSA/Dhff+R6gSJqzVL+6IzICLrEVqrwQ==
X-Received: by 2002:a24:9b8b:: with SMTP id o133mr237170itd.74.1556754132684;
        Wed, 01 May 2019 16:42:12 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m3sm2392507ion.69.2019.05.01.16.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:42:12 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/16] PM / devfreq: tegra: Support Tegra30
Date:   Thu,  2 May 2019 02:38:12 +0300
Message-Id: <20190501233815.32643-14-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devfreq driver can be used on Tegra30 without any code change and
it works perfectly fine, the default Tegra124 parameters are good enough
for Tegra30.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/Kconfig         | 4 ++--
 drivers/devfreq/tegra-devfreq.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index a78dffe603c1..56db9dc05edb 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -92,8 +92,8 @@ config ARM_EXYNOS_BUS_DEVFREQ
 	  This does not yet operate with optimal voltages.
 
 config ARM_TEGRA_DEVFREQ
-	tristate "Tegra DEVFREQ Driver"
-	depends on ARCH_TEGRA_124_SOC
+	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
+	depends on ARCH_TEGRA
 	select PM_OPP
 	help
 	  This adds the DEVFREQ driver for the Tegra family of SoCs.
diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 2d9d53daedd8..dd0fbd2c8e04 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -738,6 +738,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id tegra_devfreq_of_match[] = {
+	{ .compatible = "nvidia,tegra30-actmon" },
 	{ .compatible = "nvidia,tegra124-actmon" },
 	{ },
 };
-- 
2.21.0

