Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219DEC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22DA21744
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDAh3g1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfLECTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:19:47 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38085 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbfLECTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:19:44 -0500
Received: by mail-yb1-f196.google.com with SMTP id l129so875783ybf.5;
        Wed, 04 Dec 2019 18:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ihtlFABPBnoy2P/0nme6IxjB8k8abDvHtlVFp7u9UbU=;
        b=BDAh3g1xK+Dp/INnYnBHccAOCjdoDmNH2LUb6rnU1ddHgXY/FfDQcOHo+IZMytIrYY
         Iz707zpP3MFrvY9oUzNC+U6u+SRRU1mCidaJrbJe3Ws2wFreNL0ACLouRbtcBZSXcjiU
         DZgC48HC0ffaqLNfulk58wxYNEowiaTAC1AEH3be2v/H9BV5JuX7UUH9J+MGPwJLpfaK
         UvhHKENBybEbxXkNbaQeq1CTOavGJRIQTAZQnzWSPChQYgmRVhHQsEA7rXn17fHz5p5K
         IOC1Xh39Vo4PCMSjfP9JC/Q5f1bznBFhwTGOCjCKveo3D74IFP+6Sr5SQZtU37emCg35
         iyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ihtlFABPBnoy2P/0nme6IxjB8k8abDvHtlVFp7u9UbU=;
        b=SGsabYxuX7n7/dUczIxGKdoQAOl3CPfa/XmaG8oG7iprKIiEvdv8yUNc+zVU1eK8Ba
         Q4wGtUp/o7N3LyriYK44EP7+3nw/PacI6RgTfnB1xCmeXygy12LaIMnNsB0nENVFM0cG
         exY8m8pIdkmWXXi3/xrbFjQt8ikEJ5LXRgFDCTt8CkLQWXy2Okh0kgMz+Umchr8zf8oW
         Jj2lunATwawae1yiMlV2ayCW+wi+cOwC+MWHBhwDTe5EqSe2v3u5ByUUGqfdYWFD+QAB
         CwcYzPFJvjgnJu2tw7nTtWGQYX2Dv2goIK9MMaVkIfdy+t2Ba29eVzLl75IcaVr5WGXx
         Ag3g==
X-Gm-Message-State: APjAAAVBsKlDDG3a45v+rfK/17crCXqbz+FMMChJjDll+5GQCCaJ7iQn
        PAwt7TDJLSSmSHQFtpQ/Uy0=
X-Google-Smtp-Source: APXvYqxF86DnJ8ZxbtvUU5bmlYrvbRlVOwxtkpTsyn3N9R3JEX3DO5SwegbiASSWbFKP3wcWDE/MGA==
X-Received: by 2002:a25:5788:: with SMTP id l130mr4227810ybb.334.1575512382963;
        Wed, 04 Dec 2019 18:19:42 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id l6sm4188449ywa.39.2019.12.04.18.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 18:19:42 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] soc: imx: gpcv2: Rename imx8mq-power.h to imx8m-power.h
Date:   Wed,  4 Dec 2019 20:19:17 -0600
Message-Id: <20191205021924.25188-2-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191205021924.25188-1-aford173@gmail.com>
References: <20191205021924.25188-1-aford173@gmail.com>
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

