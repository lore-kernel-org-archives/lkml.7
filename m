Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E08C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46735217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKVblKbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387668AbfDQWlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:41:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46741 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731857AbfDQWlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:41:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id 9so122241pfj.13;
        Wed, 17 Apr 2019 15:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QgAlvPXLOPPvqeePDR0VxoNM/ii/ZZ0PATgQsPuV3J8=;
        b=vKVblKbLKav0IYfwhBOE+vDWoC8eq8HC1DG+BoYOU+YxzWEOgz2Dh83Hmls4K7o4Fe
         SSfi51UrRrVFgh+b5+DewbA76BlB5kjAawggizIfa00XoRtHPxgO75CrinShb0D5flqt
         zXHbemWXo0AEABxixicnxV9ryYXZUK5ppgPHaT2UnQFftaWdlWZs1GzM1icQQY7jXcNE
         J6sIaoBFOvVw3uUIsO8Hk6xNvfXGLSNNrHMSLX65NvPLKVSiYwjc2SfJCHlNf0uI83NG
         k1dF14p27os0wOKycjeUskGvdK2hmGUepDPLY3yffM65DCdAZQxtAzPxX858VTP26bRJ
         2Xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QgAlvPXLOPPvqeePDR0VxoNM/ii/ZZ0PATgQsPuV3J8=;
        b=ttogM7wH0Xco1dTgjQqTflmjFB+GB6NXtqGFHB3IPfFMavS+wVY6T/Sr5FzdhnUHgQ
         QYLzQStnFbADiV1b7zwxmkCReYiyi2ThBwPDYuZ0URWriA5bbCI2PNWpjiRiTU6XpRmn
         Dy7xArhWfSnvPL96Y94RbXsCL5IQ0opqS60TnMSzzeedYG9LqRbwDQftaE0qe3rgXPs2
         NVfQ0pjtY5nZzmsc8xJJpKEcCLznWDxPfjKM2Nsm6oMOfaet91M5aYdU884KU6a7lpb4
         5IFRE9foQsgFj+uoL8A7ZO2ElDGQIPQNcLFTi0kGX64Xph4JrRnorbAcyPspmprnoLyr
         Bmjg==
X-Gm-Message-State: APjAAAXD+a33Rp9AJiHTD0ePml79XnwSi2vDaf+iE8EIsXzXOfWoQO8C
        00RmvCbn5DDUXk1cx4F9i8Y=
X-Google-Smtp-Source: APXvYqxKP1r6Akq/mQoseI7Bpurspbu75oPeQlGDu0DdM3dQKoxwwaDx2T7owfvq633BGfpHapXAPw==
X-Received: by 2002:a63:6a43:: with SMTP id f64mr52497357pgc.366.1555540524801;
        Wed, 17 Apr 2019 15:35:24 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l26sm281030pfb.20.2019.04.17.15.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:35:24 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 13/16] PM / devfreq: tegra: Support Tegra30
Date:   Thu, 18 Apr 2019 01:29:22 +0300
Message-Id: <20190417222925.5815-14-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417222925.5815-1-digetx@gmail.com>
References: <20190417222925.5815-1-digetx@gmail.com>
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
index e9ab49394d35..029afc5fb6a9 100644
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

