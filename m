Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01725C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44ED22CBA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rjqSM1l7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfGYWTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 18:19:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39447 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfGYWTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:19:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so23709526pgi.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WG9jq4WFZwEP3lX+wKYMJWPnRtojYdkiNvJJ73qOjsI=;
        b=rjqSM1l76RZ1jsgxJIxswc2R+VHTmGOHJOCRSKds3bO1rK3+jD5av0SQg7lQ/qY93L
         AWS9BEh5BGPlZpMJmA1VRC15/ta9xntous7ck3TQu5Itkb6PmcmXORv/9nyz7ocBhbMg
         Xq4KyuptPJGvtvp6USAhDTichdcKUZSIpygMRUTw7tWtUDRr2Sy+kpBsUzfSSPQuFbLM
         mk6hVIvbV1y+PNBJAdp3dOthn8iR+giucgIxPiXTarWNqW8F5IjfOrdrsfRwRGWzWO6Q
         bxye46/UvGQeW3DdKoiF7wGR67J46zL00CrrrQ1g31TRYb5kvMd1VfTZ5DGJBi1uztdL
         SeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WG9jq4WFZwEP3lX+wKYMJWPnRtojYdkiNvJJ73qOjsI=;
        b=svhQlwpRN19XczzlayRRF66aWI+OqOWg6hjqnqhqQNXx94yR71sJm3xVP10jt8KEfD
         cLAhoLHfIaHFzxVThs2tis/UNyDhJLmYd/8S9EIky5WXT6nQHzixYoN7Iv1svKYODrmF
         lUhHO6IZAQpxIpK6ViE6nP0thHpafrBrMe6psiwrMFlk+3+jW6MRk9bxmzdHeSpp8a6d
         4HwI9LLUxv/moj2gSmCV2JhXlo4A+NJHKmboNHDhhRyWwEuQPKWV1BgM7xey8TtNn9js
         gy9GX0XPv7Ogn9/WdO2ISoGhxVMKDpY7w4t0Ohb68JHezL0ZjBkmKzjAQH0VRUpXcY27
         r9hw==
X-Gm-Message-State: APjAAAW/yU/X6XGpXEkB+c7+fH5RKwgqplz7r4Tv4ywovhN2aNHnCtxR
        /BJanzn6Kh9fz1Cw1jK5Gnt9waJMCgdMaQ==
X-Google-Smtp-Source: APXvYqxPqiX346K5fLm+YKUdWqqZ0RfvQQz85OU/QHZ3lIOrrzBJdoV2XqG7BvGkEmU0TD8l92sy1A==
X-Received: by 2002:a63:2148:: with SMTP id s8mr86318468pgm.336.1564093160295;
        Thu, 25 Jul 2019 15:19:20 -0700 (PDT)
Received: from localhost ([49.248.170.216])
        by smtp.gmail.com with ESMTPSA id z13sm45986147pfa.94.2019.07.25.15.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 15:19:19 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH 06/15] arm64: dts: msm8916: thermal: Fixup HW ids for cpu sensors
Date:   Fri, 26 Jul 2019 03:48:41 +0530
Message-Id: <5d86bfcdfd118294122e2182f3328fe823bc985d.1564091601.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm8916 uses sensors 0, 1, 2, 4 and 5. Sensor 3 is NOT used. Fixup the
device tree so that the correct sensor ID is used and as a result we can
actually check the temperature for the cpu2_3 sensor.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 5ea9fb8f2f87..8686e101905c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -179,7 +179,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens 4>;
+			thermal-sensors = <&tsens 5>;
 
 			trips {
 				cpu0_1_alert0: trip-point@0 {
@@ -209,7 +209,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens 3>;
+			thermal-sensors = <&tsens 4>;
 
 			trips {
 				cpu2_3_alert0: trip-point@0 {
-- 
2.17.1

