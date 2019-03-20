Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6655C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841BA2186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QxWhhvs9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfCTNUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:20:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43476 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfCTNUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:20:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so1915436pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=GVi7i1fu8KbnbyWsTfjd8QUIqgKKnoJhlGlhThXxZVI=;
        b=QxWhhvs9fzVqRx7Kpd8qxvYSOFIiZlI3DXyPaoP0NSjKnJUun+4YUbo5VdJyXnPVws
         UKHzV/uLAG1e09tvwe+uuA9XnEBDkTxg6Sl0EHYEEvuZxffgVv57v8Rg52KEXYHuf7Ia
         qrAk41s7BbbjRbus1etKoTIZKoPL8YMIIuWun+pjNRQh/hTe0LYzVG3D6XFgYIgSARbT
         zXpNnc2AsL6HbGherrKtQoLthSo0YXpzSkY9j3YnBfRPByjLkJosVbehfzil8ox/dlPg
         6rWhqjEdXO2+1UN/lyn7HIkGj47aUWhCEwZ2J4bOhovjwxzqz7f8CSdWAgfpc+aFNGTD
         tS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=GVi7i1fu8KbnbyWsTfjd8QUIqgKKnoJhlGlhThXxZVI=;
        b=LTF+zNjU+jVOU3QoOg4bl7batLtWYwoDWHQe2K3fL5HeXlEBRlxnWylA8oVFHKmOPT
         b/j43Sfd8xRV3AX0gTTtE942x75joiEgegjo+7DLeTjchyfB1JTd4cfHVZd+Ro5hXLrk
         8cMzSTo7d/5tzlrZq5elj2x+gtHO/YqX2d9qrJsJphpYEa05ftst7k9KXfg5X/rhlgW/
         LHyMA8d4dYWKXwaPbGTv3So5wZ+KBhJnPBqzfvshykJpMLlw6GQ86rRvRdnxT7PjVEpr
         J0qh2zLv91YTPTQbNhyLFM58E0mh1EKU89Qu2+sQZ1FLtXZcmt/voZMhtnDmMYIJBxDx
         ZyJA==
X-Gm-Message-State: APjAAAXiFhcs/7IZHcpVlXMxx6gBT5jU5Equ7t8kYF1xxVi4meiYH0U5
        V+LLMezPgKKFDNUK6M72H625ITAXXqo=
X-Google-Smtp-Source: APXvYqwGQDJqpi5jq4nOBFjDzzXx2YA18F/nzb2+DQMMWmk2stZu07fKXk7xjErUTVmpeTHT00Xx/g==
X-Received: by 2002:a17:902:8d93:: with SMTP id v19mr31497487plo.271.1553088003936;
        Wed, 20 Mar 2019 06:20:03 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id o38sm3577958pgm.36.2019.03.20.06.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:20:02 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCHv3 23/23] drivers: thermal: tsens: Move calibration constants to header file
Date:   Wed, 20 Mar 2019 18:48:03 +0530
Message-Id: <4e32e37db0a62dbf399dce6e7f7927823313d281.1553086065.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow calibration routines to correctly include the constants
from anywhere and allow more code sharing.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 5 -----
 drivers/thermal/qcom/tsens.h        | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 92747ccb2850..928e8e81ba69 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -12,11 +12,6 @@
 #include <linux/regmap.h>
 #include "tsens.h"
 
-#define CAL_DEGC_PT1		30
-#define CAL_DEGC_PT2		120
-#define SLOPE_FACTOR		1000
-#define SLOPE_DEFAULT		3200
-
 char *qfprom_read(struct device *dev, const char *cname)
 {
 	struct nvmem_cell *cell;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index d648fba235cf..eefe3844fb4e 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -9,6 +9,11 @@
 #define ONE_PT_CALIB		0x1
 #define ONE_PT_CALIB2		0x2
 #define TWO_PT_CALIB		0x3
+#define CAL_DEGC_PT1		30
+#define CAL_DEGC_PT2		120
+#define SLOPE_FACTOR		1000
+#define SLOPE_DEFAULT		3200
+
 
 #include <linux/thermal.h>
 #include <linux/regmap.h>
-- 
2.17.1

