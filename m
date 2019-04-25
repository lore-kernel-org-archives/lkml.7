Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC55C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09ADF20811
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJRtOUBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfDYLf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:35:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35592 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730275AbfDYLf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:35:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id z26so2161548ljj.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 04:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v3TdseDHlXpvn66ru+hD44JJlRv76RtBk6sjy6NJ3BQ=;
        b=BJRtOUBDKWNx4CAK8xmNVWevdil9EnDJk1GjWV3wqDeJt0JweUDKvbseOpVf+55Cc0
         2KubrIKonCVyx7RcjFt/Cff9VcUV9sb1OczdjHZ6nKMItHeC/thwgWPez8hnpsa5By36
         30Z6F9tn0U/GVaQssvHTxGrrLdQddkozAnnk+71vrsRynrJTqx7duRgyaemgVnQpf/Ts
         iJDGaMtUPin5ppzDFn8VD3W2K1uDRqG9hkJBXuh929fx2VcYzxDSz8j1vVCNZzjATl2/
         vFYCK1oY6Rl4PGLS2aN6IG152iqoTk3X4rVVZCQsz6SSCaZEVONW4LKJ5ilTKXqYYxdJ
         IOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v3TdseDHlXpvn66ru+hD44JJlRv76RtBk6sjy6NJ3BQ=;
        b=gTMCNQ3/d70vCLrzM/4rLlbCz0FR/CHytVAy1/QTq+DUMyWfN0wN453WX+6PCHlbpb
         IrtAUgBd18ch8fCqzZZj2XKA21ExwLYshKEpHlwvyA4D9+ZEY+RgTot6YgnpjvoOFq8B
         64TwH8urxHZ0V+5K0iTqIkKXEk10ZhzPxxPEi+sY6rzTfT2wv0CwsdBdvSGRpzXcBZ5S
         prYm6pasJsGtENZ8VjRQZMManyke4Kt3dBeKzYfTd4fXmjqbgNVSDCxR4TTuOI8En9j1
         5SId+NQHTpLL1laYWqA5ElPODI7248CoxRSnR3T+PevvO4dUHcUCj8iH4Pr/Y7Cpy1wX
         r3Vg==
X-Gm-Message-State: APjAAAX3QBOYM4FvKTz52vzaFbHzcNtu9da2KpzPk+5IhTolGmjY2MOI
        NbbnOLHkByphcgBCa9UTThI/zA==
X-Google-Smtp-Source: APXvYqwzWdeRvBap2TyOdJ8PVoAHxGApUGgCXhRsFEklLZCLgC/avJc26LQ4s3sWHRtuj8TVlFO/Gg==
X-Received: by 2002:a2e:86c5:: with SMTP id n5mr15087401ljj.184.1556192127118;
        Thu, 25 Apr 2019 04:35:27 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-72.NA.cust.bahnhof.se. [158.174.22.72])
        by smtp.gmail.com with ESMTPSA id w12sm909416ljj.11.2019.04.25.04.35.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 04:35:26 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: pms405: increase s3 max voltage
Date:   Thu, 25 Apr 2019 13:34:29 +0200
Message-Id: <20190425113429.14321-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase s3 max voltage in accordance to QCS404 CPR Fusing Guide Rev 6.0

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 2c3127167e3c..6910fc663fe1 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -64,7 +64,7 @@
 		regulator-boot-on;
 		regulator-name = "vdd_apc";
 		regulator-min-microvolt = <1048000>;
-		regulator-max-microvolt = <1352000>;
+		regulator-max-microvolt = <1384000>;
 	};
 };
 
-- 
2.20.1

