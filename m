Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C48C282E4
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7539520859
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQRNHZfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfDURt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:49:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40111 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfDURt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 13:49:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id d31so4804624pgl.7;
        Sun, 21 Apr 2019 10:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wxo1mTlnG7HCW7qNviKHVt088dVN4BbKUg558KqhhM4=;
        b=DQRNHZfcTLNcWOSv346WJull5dw9sMyei1Wonj4xR28oM7ZTMc43RkwK8tjAxX8XJ7
         IPtlkrKte03KD9cpJsHmhVghy76yploA9Ng35A7ybJbPU0QhXJohOcXsPNEsDC5Lp2rC
         tNZvZqT208s7V7zUVvcAOR5TorWc/fVB1ubOCiR32uBIG51fKakcbuaxpvgTwM1q50zT
         lK/Ozs12uvqBuOOtejE1UfLVPNZLWtePhglZpgfm1xVLy6RDvl59cSIEfTNAUl8u67sG
         231eXiI9oRzeJg3hnAXnRQtyJz5xc1wW9tgZw21Ur6befKelwr7+VT0oyjihJX5qtJ39
         ufBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wxo1mTlnG7HCW7qNviKHVt088dVN4BbKUg558KqhhM4=;
        b=J5ttbk8kPsFauwyEQVQ1Q4kodZUnkxYnFy+R8flIZHAOk1fJ18bOE3omtFo2cAhe5L
         TxQBhhoULM3OTf8elbJotWDVUHkObL7zBTOv6rlQ6fXQl2/hLJqHEvWZfEiPzHDxhI3O
         Lf5YM1uHE6SPQiq0z1ohdgxFz25rIi6/7at8L2mOfwuuUiP8BBLOroQf4A6B2kb0wgek
         av371IDVgtUCQ+lipNCXD1Li5JlwmqC2hK61QX1X/Z+RCobLHoGa0CpcZ7LDbvmdHjD4
         UOWGC5RZ26HpEjaDc8/vdsAJwnr4TEMHbItTN5LT9o6Z2U/zDhbEfx6d9TOVBQvBKp2/
         Dq/w==
X-Gm-Message-State: APjAAAX4zfLSX0/w8A7sRWWmZv6+51rgMhYptFhRyisq0DGDDxysn89b
        YE27mKYqI6x7bRA4kJPELaU=
X-Google-Smtp-Source: APXvYqwx+tX7N5p2kovsYjvWs5dzijzuzDCu/RrHTGks+fet4olVb1uEXrZDO1R1I+vKSTcRIdex7A==
X-Received: by 2002:a63:de0a:: with SMTP id f10mr5331886pgg.418.1555868967155;
        Sun, 21 Apr 2019 10:49:27 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id g63sm16279233pfc.127.2019.04.21.10.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 10:49:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] mfd: max77620: Fix swapped FPS_PERIOD_MAX_US values
Date:   Sun, 21 Apr 2019 20:48:30 +0300
Message-Id: <20190421174834.9366-2-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190421174834.9366-1-digetx@gmail.com>
References: <20190421174834.9366-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FPS_PERIOD_MAX_US definitions are swapped for MAX20024 and MAX77620,
fix it.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/mfd/max77620.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/max77620.h b/include/linux/mfd/max77620.h
index ad2a9a852aea..b4fd5a7c2aaa 100644
--- a/include/linux/mfd/max77620.h
+++ b/include/linux/mfd/max77620.h
@@ -136,8 +136,8 @@
 #define MAX77620_FPS_PERIOD_MIN_US		40
 #define MAX20024_FPS_PERIOD_MIN_US		20
 
-#define MAX77620_FPS_PERIOD_MAX_US		2560
-#define MAX20024_FPS_PERIOD_MAX_US		5120
+#define MAX20024_FPS_PERIOD_MAX_US		2560
+#define MAX77620_FPS_PERIOD_MAX_US		5120
 
 #define MAX77620_REG_FPS_GPIO1			0x54
 #define MAX77620_REG_FPS_GPIO2			0x55
-- 
2.21.0

