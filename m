Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD40CA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE95214B2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUTwTSiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfJUKgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:36:08 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34398 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbfJUKgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:36:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id k7so6428715pll.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=yL7Qj8/ghjeqWsofoPv2csuJJiKJS+BI17hOcKQw/eM=;
        b=MUTwTSiGPdDBbvXmQKHZ9DYnyo8AkHQ6po0q7qSA0A63lmxlrWVYQVW6dQ+0gCiH3m
         sYL/hBJQD3b3uapKL8Sdcbls+DjVmN3NC1dDncnZEGI3csHkBuekxHMaXDct/MQrcf5f
         WMvKbQj/u50owK5QeuO/W1L6PtHynq8RaHyJsZcWj0aS1eeZ4/paNOf7Kc0aygVABnlf
         g93iKUL7pkhiML2CJeV2sdtTk28rK37GI/eNQgVzwIcG5h/vDdCDqslmp45Zc0uTHWYx
         iKUWFq0nPT/RIx7y3mE8kyqJQ2gGmiWyhGjUhXsPdUjJTI8qdQv+jd0fr2QfD92hGHaE
         WfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=yL7Qj8/ghjeqWsofoPv2csuJJiKJS+BI17hOcKQw/eM=;
        b=Kb6Vle/IBQmCJyqqEghA9ZX2ag2DdHIXfrCAwTm1ZSup6Nfd6kllYHdAw+OfoRvGAq
         yKV1pCto/tA9hhfcl8Z3uO0HntTH5o3zptm5vuEhPZK9fmvgLNw5tWRrlitnYXDrz/2P
         5yev+YOkRsczxQ5Cp1asxiNsB+ieWgCKOKuNMyMEz9VEV1B2jZGOAa/MYG6AyOIOpU+O
         esN0jUhf745vsHx3+/AcMcjSBIz2os1rWFQsPb4WGlaxfcB/Xc4gZ9LIHbeURvejM8hy
         keTYeAAN8OoeHAPm/IHckSaoptQeRNo8/IopZNgc8hnhh8Vdnf/ek79TP+h58n6LYNjY
         lhfA==
X-Gm-Message-State: APjAAAXvXUOzWCh4YQlrsgS+ZHf9SXJfZASncfSytGrZsvhPIBrL8Fwx
        ydEm5cSybrvNJJ2h6SPK2T3ocOO96mbsIA==
X-Google-Smtp-Source: APXvYqypBgv4+h2xzB6x2jro1gPLklFWjP4MlREzwJSLMBdhp7BPHn4y/qfxqstKhCBbnv49m/G4rQ==
X-Received: by 2002:a17:902:6acb:: with SMTP id i11mr24852585plt.16.1571654163559;
        Mon, 21 Oct 2019 03:36:03 -0700 (PDT)
Received: from localhost ([49.248.62.222])
        by smtp.gmail.com with ESMTPSA id y15sm22091643pfp.111.2019.10.21.03.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 03:36:03 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org, julia.lawall@lip6.fr,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v6 06/15] arm64: dts: msm8916: thermal: Fixup HW ids for cpu sensors
Date:   Mon, 21 Oct 2019 16:05:25 +0530
Message-Id: <1726fdbf7cf7200ac5dc2a4c811aaee7edc47fd5.1571652874.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm8916 uses sensors 0, 1, 2, 4 and 5. Sensor 3 is NOT used. Fixup the
device tree so that the correct sensor ID is used and as a result we can
actually check the temperature for the cpu2_3 sensor.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 5ea9fb8f2f87d..8686e101905cc 100644
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

