Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD93C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648D621721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvhLVGUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfDMI2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:28:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38908 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfDMI2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:28:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so6246999pfo.5;
        Sat, 13 Apr 2019 01:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9b0tOUXrItaudN6sxbhg3XVgPHSnLKvU1HgYCYf2y2k=;
        b=JvhLVGUgw22o4ubpkmnmEdOaMkXSDDJ7NclMbBFBz9JvbWWjrumjqCNwUObDxSzwnF
         vkjQIsYEM0kUOXuxIC4cYyHuPVZISnt5yYqgrONJhl2eQ3RTflXL4TouFfLvOzJ0r7ah
         gIQ7OJrdmRN7f840sXoD43qC0UW4343jcKGYpiVsizh9SOsrUpFKXNMtCu7HaicuZkKh
         HFBqKEhbxBxJJkl3DnukBpF/EkGJRxjKsXbvv0U6NvY7PButGdsSgjhnxivuuzexL7Ie
         F9ny92wVQkaQQ+hq2OT6VMz5P6OkA/Eav5emachC4/rZVloTHfFC/HoAjfoSY72gHkNV
         VFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9b0tOUXrItaudN6sxbhg3XVgPHSnLKvU1HgYCYf2y2k=;
        b=lp0G+c99OR6W0xoNEn0Ie0GQESWtFa59Mfd7ugCPSxbaWN56F4xkqpLqyLHKdX3Pq2
         Anf/7HSAjw8Y39vhYvEnwjMiRkM7Anr6EWTeUAkORVjTFNZaDTL7F9HNFTRyEUQBvwJ8
         x8jzLIXdETwBxP8T9rASMA2CisTRIYQV/ktvM9lfwqtj///EtPuJR3QtsMgOO5LigrkL
         Fk8YrkyeW4a7oRrOcMKfNIyVSg1WEsxGGt5err1j7ZPHeBANd/igZkWbz8/PvGSq6XNZ
         oOIBIalpYUdttzMxL6LLiH7EsIq9Eq/xnWf7skz1xe9reO1qPoonl7/ypa9UsJLpJ9fE
         Bclw==
X-Gm-Message-State: APjAAAUZFd6OmO19DF0qkKxGnHakTXQIb/ktyWrml2f3KVrzY+fgW4Ho
        MQzZwOGDRw4cMyJJUAGgOXBvqiWT
X-Google-Smtp-Source: APXvYqxDA3RqESeGbbaHAhwa7ckl/AJuNE7OawPUQMaNeQK6fivmzo0doBf6ZNqpfCyol468YMdgzA==
X-Received: by 2002:a62:e304:: with SMTP id g4mr56202827pfh.71.1555144101255;
        Sat, 13 Apr 2019 01:28:21 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id z20sm58261328pgf.70.2019.04.13.01.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 01:28:19 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/12] thermal: qoriq: Add hwmon support
Date:   Sat, 13 Apr 2019 01:27:48 -0700
Message-Id: <20190413082748.29990-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190413082748.29990-1-andrew.smirnov@gmail.com>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose thermal readings as a HWMON device, so that it could be
accessed using lm-sensors.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 5c459a9d0db3..897b3424b43b 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -12,6 +12,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
+#include "thermal_hwmon.h"
 
 #define SITES_MAX	16
 
@@ -93,6 +94,10 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 		case -ENODEV:
 			continue;
 		case 0:
+			ret = devm_thermal_add_hwmon_sysfs(tzd);
+			if (ret)
+				dev_warn(dev,
+				     "Failed to add hwmon sysfs attributes\n");
 			break;
 		default:
 			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
-- 
2.20.1

