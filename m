Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0F2C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65668222C5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="za0v+vrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbfKFN3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 08:29:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42390 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKFN3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 08:29:08 -0500
Received: by mail-pl1-f195.google.com with SMTP id j12so9478299plt.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 05:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2xqYXv9mzaQHwdDh6j/4ycM4TkgLqd6VvlhGxQOhNwg=;
        b=za0v+vrOAYFsK6XXgXtbLMXEk/0Jo14oKAfvmttgjG9v8GTN3APeKjjkysHBIo/MaD
         yu1fZQ8H+NAJ/MF1Jb65S7HsNdTp52aIe2OqV7nU/fr3/e2KDfBJa5HMfkeSVHMiPaWW
         pjJ7GrAUvONFXEc2cWBBFXzetevUlhXpioV7h5PS917zag1508jFEetnjK0914bqqzdY
         z6myjrjljlOZOD3qORGAP0lciZJSobhzFPoJYYF8KE3t7m1+Vd6KhBJI37QGCM7tU7m3
         xlR68RTUxYR9NhAjBoSmKY60c6bglrGlJ6+UZkW0SU5UkzgR2LFnaqY85S8gIQnGTaEs
         7vDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2xqYXv9mzaQHwdDh6j/4ycM4TkgLqd6VvlhGxQOhNwg=;
        b=YOtZ93TWem9lkZlHScy1l/lB1bczfhbJ3pLxPbIbD090cW3oZLWeUUcj6qCrY+aQL1
         FSrgg245SmTkdQSoXJ4C3vDHIgQnLo4Stv+zRz7j1jp2m8KdPHEotihLGBIC9JvqgMVT
         t++/w5N5bSHwntuAuCmLlwWZXdwGnxmPpwcVHVfvhSE40iHMg7rFg6Do4G5F/JJZnwXK
         WCIsNSiSQyNOZOw9idR5FKBN3xzul7biXuuA+w56QkaY6dt6GpCJaeJZKhIV7VpeHyTH
         BIpPpcFPjQZOk67q3QyW/F3hCNmc1qz0jHjAm2+FZJ7Qrg0OWZm+rOVV3iXsusqpveE8
         MDbQ==
X-Gm-Message-State: APjAAAUtD6M2Pdux2GZ/JdWFGekr9QBDUhLQ4AABWl8z+RJQTEk2aI2u
        uPFBHqPAMtfOa5eJaVXgucAaLCi0Ryr+ww==
X-Google-Smtp-Source: APXvYqzdD6PP3zR2WOpA7wbJdtG8RYdi6t7S3j+JCo3E8AwHpvLtfylSKI497txtjQISu6lCPm6v2A==
X-Received: by 2002:a17:902:8309:: with SMTP id bd9mr1678528plb.153.1573046947813;
        Wed, 06 Nov 2019 05:29:07 -0800 (PST)
Received: from localhost ([49.248.202.230])
        by smtp.gmail.com with ESMTPSA id g7sm23243544pgr.52.2019.11.06.05.29.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 05:29:07 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/11] thermal: samsung: Appease the kernel-doc deity
Date:   Wed,  6 Nov 2019 18:58:24 +0530
Message-Id: <ef268335454e96e6ee3d13deb1cb89af0d0a3b61.1573046440.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up the following warning when compiled with make W=1:

linux.git/drivers/thermal/mtk_thermal.c:374: warning: cannot understand function prototype: 'const struct mtk_thermal_data mt8173_thermal_data = '
linux.git/drivers/thermal/mtk_thermal.c:413: warning: cannot understand function prototype: 'const struct mtk_thermal_data mt2701_thermal_data = '
linux.git/drivers/thermal/mtk_thermal.c:443: warning: cannot understand function prototype: 'const struct mtk_thermal_data mt2712_thermal_data = '
linux.git/drivers/thermal/mtk_thermal.c:499: warning: cannot understand function prototype: 'const struct mtk_thermal_data mt8183_thermal_data = '
linux.git/drivers/thermal/mtk_thermal.c:529: warning: Function parameter or member 'sensno' not described in 'raw_to_mcelsius'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index fb2c55123a99e..8193b66a3f831 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -138,7 +138,7 @@ enum soc_type {
 
 /**
  * struct exynos_tmu_data : A structure to hold the private data of the TMU
-	driver
+ *			    driver
  * @id: identifier of the one instance of the TMU controller.
  * @base: base address of the single instance of the TMU controller.
  * @base_second: base address of the common registers of the TMU controller.
@@ -162,8 +162,11 @@ enum soc_type {
  *	0 < reference_voltage <= 31
  * @regulator: pointer to the TMU regulator structure.
  * @reg_conf: pointer to structure to register with core thermal.
+ * @tzd: pointer to thermal_zone_device structure
  * @ntrip: number of supported trip points.
  * @enabled: current status of TMU device
+ * @tmu_set_trip_temp: SoC specific method to set trip (rising threshold)
+ * @tmu_set_trip_hyst: SoC specific to set hysteresis (falling threshold)
  * @tmu_initialize: SoC specific TMU initialization method
  * @tmu_control: SoC specific TMU control method
  * @tmu_read: SoC specific TMU temperature read method
-- 
2.17.1

