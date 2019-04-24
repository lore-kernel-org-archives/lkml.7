Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65352C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6DB20835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKB3ZIT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbfDXGti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:49:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46312 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730012AbfDXGt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:49:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id o7so6537466pll.13;
        Tue, 23 Apr 2019 23:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xu8QRQ7N0Vlct8X3Tzy6lVv4yUD77Qnl/IfULmtdP6o=;
        b=jKB3ZIT2oyT7HvTnR8iI1O4vAGyGsQL0CP15DDnGvMpyZWay23w9SKwnLUOCSj33UV
         Q4FfdwbqNvKCN0Y+clAVbXNiLPb14HkaYQUgLlI6JhBl7jhQzglw9Nn5eJSq2wwrhWcK
         PmFnnhSdapN/kgv6ctFBi94YQHPAQiF+nYIA+OuWK3Zw3gGlhv0QwgHkJbDMQB6uYBxx
         Pu5Eex98TZSu/UtCc7CFV7QWYeHGMPm3YrxpSrQk7AKGRxzyDDDMzrYXuiyd8040GyL1
         tkTSxRdyaFx0elrMyVpXB4Q7XOCSQQ9KQqgcorMSUrque2B0dA/6cAxNDNYYE85MIuBD
         DCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xu8QRQ7N0Vlct8X3Tzy6lVv4yUD77Qnl/IfULmtdP6o=;
        b=CTUhw9d9GDObbG1mqtkT0uDe+vR8wLCSsLFbWOg8AF7cqw1d8Wy6wHVRT0/5WdOGa6
         RtCy8d73hyyA7dAXgW0UnbKcNGCRKJmny7AUMShl1GroylzvoAuGDEtbz763GBEubNaP
         RxwYozeHNw4M1C9xxmzVswcgA8UgxzRGF/dTe5hli2nbkyJY9lFKRIDCF27XnXgZkemw
         +RGoHnZLqvaCz7Bzpjc2VXrOWEOqZNEf3ttyQKOHBO/cfZsboDs6gRd8vNQkKnsqxTf1
         T1VKYIoSBZQHcGFVjmXekgEJTuQlT6187JW6aU1aNMb/mVC7U4Ma/owoTuVP8nilo7lx
         /fIg==
X-Gm-Message-State: APjAAAVmsE66jAfrVVlJV2x1m1et+9H9aWIivXpqx+b/ZeflSFg4Scdu
        HyuW/LFTsTSROox2geY1osJWOBJrQAI=
X-Google-Smtp-Source: APXvYqySaRZAy0bIrPlcwU9FEqGBi59kJzO10WlmXNWk8xbB2b8CjNzIYRkNh/zMadzWDdkhQK+9UQ==
X-Received: by 2002:a17:902:2:: with SMTP id 2mr31093522pla.61.1556088565266;
        Tue, 23 Apr 2019 23:49:25 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e13sm26332457pgb.37.2019.04.23.23.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 23:49:24 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/12] thermal: qoriq: Add hwmon support
Date:   Tue, 23 Apr 2019 23:48:30 -0700
Message-Id: <20190424064830.18179-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424064830.18179-1-andrew.smirnov@gmail.com>
References: <20190424064830.18179-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose thermal readings as a HWMON device, so that it could be
accessed using lm-sensors.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index f97d0cc82b2b..c93732639f78 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -12,6 +12,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
+#include "thermal_hwmon.h"
 
 #define SITES_MAX	16
 
@@ -96,6 +97,11 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
 			return ret;
 		}
+
+		if (devm_thermal_add_hwmon_sysfs(tzd))
+			dev_warn(dev,
+				 "Failed to add hwmon sysfs attributes\n");
+
 	}
 
 	return 0;
-- 
2.20.1

