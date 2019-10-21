Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944D4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A5D2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9EG7QY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfJUKg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:36:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35957 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbfJUKg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:36:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so8180547pfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=iVqqU2LAVSCsGxONMpzjN5OaSzKTS+PP+RlrbsDHeMo=;
        b=S9EG7QY/ZgkmqHhRziKbvL3c/VYqOHXyxeTbUYe3phmidMNW6VBcGWA5qYT94oVvwV
         FcDAXIrZHnwKaZPodf4BPLNtpvyHt05p/WPYzzGomf3ic9a1bgRqcT47c3YQX1kTBzTP
         TPm2ahWz0pTsWGK1/SUEJ7Eq8+CeuaX+8RSWgQaP+HdnHfbZfdDo2skD2ZdD0OnEMidt
         mKa3+5D7lLpBUC5WYONM+bjVgGtcN/CH+LHb3+baXgPFR+unyWMICbOgLOWfzCi/Od3z
         +zswnyNg6Q+4KhQqLJbYtWR5WeASo8JWdwRweB759Abf+83GPYHQHcfBc+UQYlQBDpIa
         FLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=iVqqU2LAVSCsGxONMpzjN5OaSzKTS+PP+RlrbsDHeMo=;
        b=jIynyJ8n49ur8RDRXK5hqLIk3DrpiyxVOo8L/iDOyQyiZUR5TqcUHOUay7+GaW9Ghk
         QCqcXs7hKa2diXoWMD19TlHE1d8kcyHUpqhMTGFEjvI0YJGsGpehj0Bz9ExV2GRIcfmO
         ZPJL17gC0n4oXS1pz5Vka7xHuYouWRdIvMFJeZxQANVpso+MZtG3In2RiXg1ZVNlNAB2
         /09tu4SdvpLjyaIA6p67gfrkyDHeXlX9Dz2eAFmw3xYT9Hd5sB3aNwbFgQUn0H9jzUpx
         LK4NADpPF/QEPBvIg23w8hjDrbP6WckW61RB6Eti4KatZ8g/Vu++qrrXgQrrViFWzG4h
         EYWQ==
X-Gm-Message-State: APjAAAVF9x7Brgjgw9ai4Ijl49TAD+fDZ4aDEGK1yC27x/+ZDFEEsPYr
        ptKDj5ceUY1PyACdVVPl8zIJvgo6+NENSA==
X-Google-Smtp-Source: APXvYqzEHGDZ6oIR4ZkTsgaawzrSiWXv0qd13sPs8zKa+jMYleM9/V8ML0gtBkC0Oq7Pc4bCnCZdKw==
X-Received: by 2002:a63:cc4a:: with SMTP id q10mr11017952pgi.221.1571654185644;
        Mon, 21 Oct 2019 03:36:25 -0700 (PDT)
Received: from localhost ([49.248.62.222])
        by smtp.gmail.com with ESMTPSA id e192sm15379176pfh.83.2019.10.21.03.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 03:36:25 -0700 (PDT)
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
Subject: [PATCH v6 12/15] arm: dts: msm8974: thermal: Add interrupt support
Date:   Mon, 21 Oct 2019 16:05:31 +0530
Message-Id: <a2a70ff28e72a14b163a9a9b93ef474ab0836398.1571652874.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register upper-lower interrupt for the tsens controller.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Brian Masney <masneyb@onstation.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 33c534370fd5c..c1a3a7d7161cd 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -531,6 +531,8 @@
 			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
 			nvmem-cell-names = "calib", "calib_backup";
 			#qcom,sensors = <11>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

