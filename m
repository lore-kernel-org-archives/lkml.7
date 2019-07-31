Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E0BC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB1D20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H77GUufa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbfGaKA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 06:00:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42731 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387668AbfGaKA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:00:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so30306301plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 03:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=i+zcdOKM4uEsoBGbIg99q0zdIYp2a4lDHZin2ZyV6Ts=;
        b=H77GUufatg+2unukyfaUu5mIxtf9dK45weuozY3ifgIb2dgL2u+aeUCplrl82Pq2sP
         b2RX+7J/p/p2zmCozRuWIf8QArtB5MJKTKSI2W5+wf5MGGRL9fquoTMXWRZQeETW5oNG
         9AyOc2po9ajcww/AZ4Gk49nuuQezsh8pG3bp8pmqo6iV+urV4s2bkTAOF5lSjIztR9Cu
         qZOES5sOtvdtqd4j4eaANh/hLCDVHh9kULIB9iwNmy8npgfW4MWuOq18H202bivWBtxy
         ONuRYh2HtoahAfiLP7XBvyHSsMKGMpLWD+kd5UMYrtfkNLBu6fIixasyARHKZFxhCrrX
         zrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=i+zcdOKM4uEsoBGbIg99q0zdIYp2a4lDHZin2ZyV6Ts=;
        b=Et4jQxKHUAf2I83SRjq5Im+G2zNztOhUOg0TNz0mp4CSU6Qu0ctmU7C50/JuayBik/
         GKvGUPreuGGXSWu4Zfi0S6PC12dX6cggU74h7hEEaxm1/y6XkfTwEo/caGaT7pywZvC2
         BLZUvIjapPAdXxzlWbuzR9K0cg33qnWIQRlwW8xeFMwof7fuiX/+i5EFrJU0HMWRU4NO
         RIFNjJjYe7DwdDJP4mbwVbJmIX91M51KxP6N8icDmWizJhEy5i82KG7B+ILJLPlcLu9g
         PQPWrIzEIyQQ/egm5f5PPwhiMZoIy5CvwSTwfa7sozKsAit9LLUB/gGmmfEci9f8d52i
         5HQg==
X-Gm-Message-State: APjAAAUDjeaCIGGzideARV/CRzsrZ3YvPOht/mW/oanTutT/OGpyqz0y
        lYPjqZZchByvAPL5c8JpIqtf8Q==
X-Google-Smtp-Source: APXvYqz0L0q/H6Aaq2C1hNAQC/UTqvaSD7TJO7dRD0vFgnlVqXzm0SKiN+S5lJQxC+3inAVkr70i1g==
X-Received: by 2002:a17:902:4401:: with SMTP id k1mr96016005pld.193.1564567255904;
        Wed, 31 Jul 2019 03:00:55 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m6sm68611352pfb.151.2019.07.31.03.00.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 03:00:55 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] power: supply: sc27xx: Fix conditon to enable the FGU interrupt
Date:   Wed, 31 Jul 2019 18:00:24 +0800
Message-Id: <84abc5a002dcc29e51bf6525aee0ca2aace8e30a.1564566425.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1564566425.git.baolin.wang@linaro.org>
References: <cover.1564566425.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1564566425.git.baolin.wang@linaro.org>
References: <cover.1564566425.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

We should allow to enable FGU interrupt to adjust the battery capacity,
when charging status is POWER_SUPPLY_STATUS_DISCHARGING.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 2fe97ae..ca7b73e 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -1098,7 +1098,8 @@ static int sc27xx_fgu_suspend(struct device *dev)
 	 * If we are charging, then no need to enable the FGU interrupts to
 	 * adjust the battery capacity.
 	 */
-	if (status != POWER_SUPPLY_STATUS_NOT_CHARGING)
+	if (status != POWER_SUPPLY_STATUS_NOT_CHARGING &&
+	    status != POWER_SUPPLY_STATUS_DISCHARGING)
 		return 0;
 
 	ret = regmap_update_bits(data->regmap, data->base + SC27XX_FGU_INT_EN,
-- 
1.7.9.5

