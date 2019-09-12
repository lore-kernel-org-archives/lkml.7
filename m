Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00292C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 01:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76342089F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 01:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyBrC6i6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfILBfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 21:35:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44348 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbfILBfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 21:35:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id k1so10975769pls.11;
        Wed, 11 Sep 2019 18:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cWsYbqUsjfWBFB132P+70l3TxUklV7bh1JoltYP6jwg=;
        b=MyBrC6i6+1kxrLbsnlfDDL0aEm1Fz6LZLVW02g8qpEjAZEbXFhu+a4lUt5nEfn3fSJ
         C022VdB7gVPIsWueyYSZ2cJ67LaHIrWe/M9mI0isacZYZ3hSYQ385tvAh6IILbIS6h/G
         YHrxvf+UMUovoXwvmgC4b6q3f6EE144Y4fkdMozx07UFo2fEvcJkGmnt3aMg1HendhGN
         9fCju6kGaOFWbGslerMN9XUP5ql9RV9cEr6Q5k1PAX8edmdzpigLHPoOnYoIFjxHzLKz
         QpbH9o74zrX0Dik9n3VyNG7QUjXZQppgJc0rUbnW91i153mK9ekm2ioEgSdFmJYb1MfC
         2k1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cWsYbqUsjfWBFB132P+70l3TxUklV7bh1JoltYP6jwg=;
        b=Fxzw1AbywGZ/Ij6hDkR/+5d/nvHe35XQMfydjVixZFafk93zGhyuK14dVDdNbUxQJx
         gXM6BN81Fw5y8R+PuSoyYOTIpKh2/0ths6hEMx5WC1U/g/Xbc98egIlL+lx5Eg3RJ0LA
         xcfFPVIKoQDyywMxWq4/hae1NgI+OvUNAzq46w/aACdz8cPCsQRdMw6fcrnJ2c2fDr+3
         jt33+TUoaWCYp1Zd8RyHITkXGHAjJYUIVWqpdiY6JgPOeW/hRpCHRzu3bOx3YGc4u3td
         zgbcFo2/gXPHVjEqeH6mJaVUKceMp6+ZJ15QxrewGFrG2fmtgGbFc6FWzkwS/0VjELng
         WtsQ==
X-Gm-Message-State: APjAAAWDZ+9mlYwJnZ+9QU4ARvMWic/S1QjtHFLIQCkHsSP0gGi5njuO
        4EbsaaXzP0IqR35gwwcE+Wg=
X-Google-Smtp-Source: APXvYqxP8kYJiqLOH5C7TMGvcDrnUub31FEEbsJFEjj+MFaxYXeE07zi+1Gc4Vv0muSp00W8t23JLQ==
X-Received: by 2002:a17:902:b70f:: with SMTP id d15mr40679643pls.285.1568252104542;
        Wed, 11 Sep 2019 18:35:04 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id b126sm35248236pfa.177.2019.09.11.18.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 18:35:03 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 12/12] thermal: qoriq: Add hwmon support
Date:   Wed, 11 Sep 2019 18:34:47 -0700
Message-Id: <20190912013447.2977-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912013447.2977-1-andrew.smirnov@gmail.com>
References: <20190912012920.29601-1-andrew.smirnov@gmail.com>
 <20190912013447.2977-1-andrew.smirnov@gmail.com>
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
index 48853192514a..e907f0d2103f 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -13,6 +13,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
+#include "thermal_hwmon.h"
 
 #define SITES_MAX	16
 
@@ -118,6 +119,11 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
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
2.21.0

