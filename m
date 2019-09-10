Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55327C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9E32168B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/FgOeOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437070AbfIJROx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:14:53 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42135 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437036AbfIJROp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:14:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id f13so17785032qkm.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 10:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AU+QsjQ4gYWceRGENzlR0Louo13bejD+8gOVOvF6PUY=;
        b=m/FgOeOkaOKNggzNTPEtFXREeobHykEFFFvTpQDO0RpQvNSHhp2AtqgVHN+UjyG80W
         WWG3b1uQfUUzTJ0Qo0bdgjfsRy05PbvlFclgN1DETTKoJ7t0Wb5bOc7w1Fpe/jxitCOY
         p49Ll9S6JRw2bxMrZ9pnvQuhK8+28N+ndBI64dUvqY0TO34orTLL+Rh9f+jACW4cQ2pN
         SZrMhm6B3WoK9PQjDXnZ9/yDV3xkCZb83uJsXllPYdERjtYsYUDvl3Oh1VG8p8TtRgbv
         Jire4fF4GaSvB0FgRhk+IkaXFKDd82DB8Q9WOysgl/zMV8MGI+jeCrGm5beLdXCgtnl/
         t4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AU+QsjQ4gYWceRGENzlR0Louo13bejD+8gOVOvF6PUY=;
        b=izJ0IO2CVaRCiMnpaTwrDI8iAM/HkCrhGFWVXjBPhLCKbNi2HIfnLHbjw927euQszl
         B/LoQFem0BybWfbvAO3aSUf6e2oXIOKJZErABltZ4G+1IyimebQSDrxV7vMxbSv0Nm1v
         Og54cptg5MxLV1fQ6teVcgS6UwVFyc4zc+xm4RcgAyq1TjqWDlqQeCUZ+iEIAiq0flba
         /8xgIF06/Sq9j7Dxo+XnpSbVTkQh9lv+o1v2uc9mv5YLvqiLc0IDFC4nox5QuwBBeogW
         wjBvY3UJA79lOjvEzybouIbus5Z3qPtGZxbU5M++9wazgRkTZdAIky5yLPUdKD417/dy
         0l4g==
X-Gm-Message-State: APjAAAV8Et0Loe/kVnbcmMW7+Ph4ORg9GRUnB9EZ8BY/pcwcHxANwLUu
        AqxPaTGD5dkF58JRK6cNQjvEMQ==
X-Google-Smtp-Source: APXvYqw+xpOzKxIVVLJuA0LAVrvCMbzacPqVJ0yzoUiedeQ7QczZNA+XJZNiz9ALbYhsjyobVyeQXw==
X-Received: by 2002:a37:660c:: with SMTP id a12mr30467195qkc.70.1568135684689;
        Tue, 10 Sep 2019 10:14:44 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id g45sm3400713qtc.9.2019.09.10.10.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Sep 2019 10:14:44 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: qcom: Add node for RPMH power domain warming device on sdm845.
Date:   Tue, 10 Sep 2019 13:14:36 -0400
Message-Id: <1568135676-9328-6-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1568135676-9328-1-git-send-email-thara.gopinath@linaro.org>
References: <1568135676-9328-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPMh hosts power domains that can be used to warm up the SoC.
Add nodes for these domains on sdm845 (mx power
domain).

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
v1->v2:
	- Change the dt-entries to reflect the newly introduced
	generic power domain warming device.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index f406a43..0a83263 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3284,6 +3284,13 @@
 		};
 	};
 
+	thermal_wdev: rpmhpd_mx_wdev {
+		compatible = "thermal-power-domain-wdev";
+		#cooling-cells = <2>;
+		power-domains =  <&rpmhpd SDM845_MX>;
+		power-domain-names = "mx";
+	};
+
 	thermal-zones {
 		cpu0-thermal {
 			polling-delay-passive = <250>;
-- 
2.1.4

