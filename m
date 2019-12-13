Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A99C751E1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D80247CC
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJSd4RbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfLMQFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:05:54 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:47026 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbfLMQFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:05:53 -0500
Received: by mail-yb1-f193.google.com with SMTP id v15so932446ybp.13;
        Fri, 13 Dec 2019 08:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+VnUOz+8D3V2uKNqlxwDzqgg2+EXtUFjH7t7xpLJ+2k=;
        b=OJSd4RbR4A1qe4EmWcAK5phI498i9Zr0SDiK6+YbkjrNCjzLgglR4miia93Tl0KE5D
         dhc9HDuU/T7vqbpOxN6K+Vki4L622Gm0bWuCieWjqJyloY3eNXP5ouN1+fumHz1bHy19
         fqZE98HtZ9ht9b9s3nueTUf3u3Lbz/eyL4ksPDPq/PBMZ/fx0Bo+MICSYzUnKf949b6r
         eR06o96BwwKrVtQEVicodx91aPfHQMf6bRyWUmZnq6IDzlFni5MdkZwsRISCEE/h+82M
         yxJ9vAtFCphgEA90dT0sRC9tOPsg23JO1ZyyEshVlolOjR1HRukqQht35BW8eDiBfhDx
         H9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+VnUOz+8D3V2uKNqlxwDzqgg2+EXtUFjH7t7xpLJ+2k=;
        b=GtKcNe8pEdo7bsCwvs9jBcygMx7Jh1xwjxta4umA0j+9uu4/sm2msS5nXqSctALuc1
         BwLQnJ1oEHtGT4gxQpGYyPkf3tAWM8LmH3QC8ol/iNCOD2+Rs4CCR9o3Xumn+wW52m6w
         jFx5zZEjCbyLs+p7yFw84YxuTzKtqIjADv8qRGqUCT2T9teHhVAy9W6YTjQAjxssEU+f
         tZnbRwc+eG4RtibnIfvUMHD5tWurXv9rLM9Dkvy0BMjaF0v3fAFBBWwy+Jw4J1lxbrKm
         hjMttfrvDia/gyXuB96fr1iyKiZP4px71c8vTx4fO12yIknVC1yl2qYq/ErmSr1q35ic
         OeVQ==
X-Gm-Message-State: APjAAAXaADYWimRLoFL2/Hk1WPE08MH0fCCVgsjqVamv6r0srwBfXVSi
        nYH4UFf+Wvzxlt/YbKixYZw=
X-Google-Smtp-Source: APXvYqyH3cGVtkwoXj9l+rC5v9ceK5lYYEdVaYLTgOykQHR8iMWh+Pf+vCEY+WRK1WooF03tCRXT6w==
X-Received: by 2002:a25:b108:: with SMTP id g8mr9228296ybj.518.1576253152035;
        Fri, 13 Dec 2019 08:05:52 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id v38sm3984694ywh.63.2019.12.13.08.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 08:05:51 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     peng.fan@nxp.com, ping.bai@nxp.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/7] soc: imx: gpcv2: Rename imx8mq-power.h to imx8m-power.h
Date:   Fri, 13 Dec 2019 10:05:36 -0600
Message-Id: <20191213160542.15757-2-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213160542.15757-1-aford173@gmail.com>
References: <20191213160542.15757-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to add support for i.MX8M Mini, this renames
the existing file to be more generic, so it doesn't become
necessary to include multiple files to accomplish the same
task in the future.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  No Change

 arch/arm64/boot/dts/freescale/imx8mq.dtsi                   | 2 +-
 drivers/soc/imx/gpcv2.c                                     | 2 +-
 include/dt-bindings/power/{imx8mq-power.h => imx8m-power.h} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 55a3d1c4bdf0..f73045539fb1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -5,7 +5,7 @@
  */
 
 #include <dt-bindings/clock/imx8mq-clock.h>
-#include <dt-bindings/power/imx8mq-power.h>
+#include <dt-bindings/power/imx8m-power.h>
 #include <dt-bindings/reset/imx8mq-reset.h>
 #include <dt-bindings/gpio/gpio.h>
 #include "dt-bindings/input/input.h"
diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index b0dffb06c05d..250f740d2314 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -15,7 +15,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <dt-bindings/power/imx7-power.h>
-#include <dt-bindings/power/imx8mq-power.h>
+#include <dt-bindings/power/imx8m-power.h>
 
 #define GPC_LPCR_A_CORE_BSC			0x000
 
diff --git a/include/dt-bindings/power/imx8mq-power.h b/include/dt-bindings/power/imx8m-power.h
similarity index 100%
rename from include/dt-bindings/power/imx8mq-power.h
rename to include/dt-bindings/power/imx8m-power.h
-- 
2.20.1

