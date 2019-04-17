Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D39EC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09ECA20693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhIfB8c8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387820AbfDQWnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:43:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36797 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQWnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:43:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id z5so145948pfn.3;
        Wed, 17 Apr 2019 15:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k6Pr36LZNLjaMWytmQ2oiF4ANNpidxKFHqrr3mek8mw=;
        b=jhIfB8c8280b29Bn9iobebXWNuX4TNUhrhzSN+sLCgndes9qQpZ6rbt0RiwI186ls0
         YDEk4JxRU5Td5T3/fHCw05YEsGVdiNEYOwv3dcPqiErcGNFrYYZymWiBtv+IWLBn2Tvn
         NrNsIS1ZdiqUQvYlifHfSfb/B3eoJGrJfSezJkNCUedpWqMhIuwfBiKwkwsNIg0ZTosz
         /xHw8pgTAJBQVpx2Os1sJtQ7Tyt4iTjjAgTT7+/5y9bn6ycjHsUPKEg+cIxzcQsCr8BW
         eta5FB6UTHqFanx5ank5+XLT5emUUy3WOeZs3WVEceT3LVO0N2H9hiX8T0upHowVP3m9
         ZZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k6Pr36LZNLjaMWytmQ2oiF4ANNpidxKFHqrr3mek8mw=;
        b=Xcgll4EqGprLAjLyAWahmawjFViK229Lvk3fXmhzA2mNGCyN9Eo1y2o4+SesGSuX46
         lGnGjdr49VDnikJTw4UhcJCp1/eAVblTZaeI9oclXFt2eouuGVmoqYDnNWLo2GJ0kKFm
         Mx0kkRr3iPXBvJdQauMgkpue54F0IEJYb53oofMzn0N0CvQRXWZxqFFxLynlc5eXEUeN
         2jRQmUx/PcQ7GEk/EhUd4jL/wlHjqS9kafY0/OoBpDRNsvvtmA6qewaz4UMnq2NQb8QI
         Z/lBMoRzazs7/AhCXP5JOVIAa8OrkcP3l9bc9Kx7/MrKtMuDZheifSX7jBW/CsIw6o05
         a1/g==
X-Gm-Message-State: APjAAAVUl7Y7oLAu6MrEHQpRJGqkwNPHe/4OaRA/Oj2mi5gOGGLtqBBh
        ZXtN/vziw1Wu46W3igd9wH8=
X-Google-Smtp-Source: APXvYqxf3vzMaAPN9gDU6LKmYZABS5f0D10Z8ep1JCuWlVE+zoz1ycgLMsnNHulbiC9AnCp26EQ2uQ==
X-Received: by 2002:aa7:8c86:: with SMTP id p6mr93630321pfd.37.1555540504519;
        Wed, 17 Apr 2019 15:35:04 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l26sm281030pfb.20.2019.04.17.15.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:35:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 10/16] PM / devfreq: tegra: Mark ACTMON's governor as immutable
Date:   Thu, 18 Apr 2019 01:29:19 +0300
Message-Id: <20190417222925.5815-11-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417222925.5815-1-digetx@gmail.com>
References: <20190417222925.5815-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACTMON's governor supports only the Tegra's devfreq device and there
is no need to use any other governor, hence let's mark Tegra governor as
immutable to permanently stick it with Tegra's devfreq device.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
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
index d72c16752012..272232ce2960 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -606,6 +606,7 @@ static struct devfreq_governor tegra_devfreq_governor = {
 	.name = "tegra_actmon",
 	.get_target_freq = tegra_governor_get_target,
 	.event_handler = tegra_governor_event_handler,
+	.immutable = true,
 };
 
 static int tegra_devfreq_probe(struct platform_device *pdev)
-- 
2.21.0

