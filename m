Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10BAC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF85220818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4Uloyev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfDOOzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:55:55 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33414 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfDOOzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:55:52 -0400
Received: by mail-lf1-f65.google.com with SMTP id j11so13356661lfm.0;
        Mon, 15 Apr 2019 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WGyPSf1K0bwZ7WuY0uWEI/50dRfbYW5Q/niDp699c2A=;
        b=J4UloyevIRDg2O1zufZ1NDyjqymXpw16FBIWr+1GvAp5gXwV/bhnYWE4oUxqj9LDgu
         qTWwsWOFoJGbEdpA6ScJsO+kQ+xGU4erPS0JdDJ0KfejkmMXmh9+4q3wbZ8dhmFinNq0
         M6Y5B/+NZd8mbTNgflUPIe9nPlgkUZDx0XiZVJpC/xite+3WQvdsJZ/O0qdeZLx1hEit
         BE7Opuj3lCXn4xL2Bo9vCElUyO3lItndAFw0gIGexnaYiitlIqNNmOKrYycVgkYhkkKZ
         oMgSr+6PfWIrv0HghOlWP9evCjs01QkKa6mIvWk+efuWzMhL2Ej7TqOssBY7xqLAxrQh
         d3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WGyPSf1K0bwZ7WuY0uWEI/50dRfbYW5Q/niDp699c2A=;
        b=noOD/8DchxPHQUvBX3IJxx0yR3+9st3w0imh6ZLm1qSQgKXXoY69jqeKQETdL/Juto
         rx4Y4c0cKzaehqarOSUdXF1WVp0qRav8l38eBLRigvv0JdhU4GgGIK7dg88NhFbTK2iF
         GTJ2AF2sx4pHIgIRirkxthMH6m+vz9I12sqA7cmqAXG4bdGrxsM9jXVfbyCaduQZxgQV
         akWK1b1sDAUGT4UBsK00/S2dRrWQ9PE00SCasSsDitEoF68DK0FFq5VZpCu+K/B93wlC
         4iuw4IDSbymcTH+dV5ZA/CQ/p51i8rW58rSruZp4cUkeKuVK53eEw1JGr1+4c0CULkvp
         TUow==
X-Gm-Message-State: APjAAAW6QR6CL4mcNUJk1JwNekEbEUrZv3K9mFIlnCHv4wLtfZ74vQwr
        W8BkUmDeRta6gW5y5lqnn64=
X-Google-Smtp-Source: APXvYqzhvHZzlPFFCmkuJuL4+pFjlzsCPWSxZybBRKdXMEBSiaUBDlk0d8kp1dOU/zOBJ7Ro2qWAWA==
X-Received: by 2002:ac2:51da:: with SMTP id u26mr5780373lfm.32.1555340149641;
        Mon, 15 Apr 2019 07:55:49 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l12sm9989932lfc.61.2019.04.15.07.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:55:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 13/19] PM / devfreq: tegra: Mark ACTMON's governor as immutable
Date:   Mon, 15 Apr 2019 17:54:59 +0300
Message-Id: <20190415145505.18397-14-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACTMON's governor supports only the Tegra's devfreq device and there
is no need to use any other governor, hence let's mark Tegra governor as
immutable to permanently stick it with Tegra's devfreq device.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/Kconfig         | 1 -
 drivers/devfreq/tegra-devfreq.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 6a172d338f6d..a78dffe603c1 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -94,7 +94,6 @@ config ARM_EXYNOS_BUS_DEVFREQ
 config ARM_TEGRA_DEVFREQ
 	tristate "Tegra DEVFREQ Driver"
 	depends on ARCH_TEGRA_124_SOC
-	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select PM_OPP
 	help
 	  This adds the DEVFREQ driver for the Tegra family of SoCs.
diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index f1a6f951813a..832e4f5aa11b 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -593,6 +593,7 @@ static struct devfreq_governor tegra_devfreq_governor = {
 	.name = "tegra_actmon",
 	.get_target_freq = tegra_governor_get_target,
 	.event_handler = tegra_governor_event_handler,
+	.immutable = true,
 };
 
 static int tegra_devfreq_probe(struct platform_device *pdev)
-- 
2.21.0

