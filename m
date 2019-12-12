Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55071C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF442253D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XfhnylYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbfLLTgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:36:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42318 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730675AbfLLTgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:36:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id x13so1077123plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 11:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9lBMtFL9Z5icRxLop3LLb6oDnFoI6ElCPHqhjraXO9E=;
        b=XfhnylYKjhMJsSQEUHNlA8miXb6TZ1WBwAaGjKiKWZvaRUM4r6KA8hEfJkaeiLnQS0
         kEWTAu0XumkznVLHHipEC9ziIFbbnebvMJWz52tTcrUNvtiMc2XtqfZ1M7Dj/i1j4J7C
         VTPMI+Dp1WOL1lT+2QBBW6B4gvZOGsBMqGflQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9lBMtFL9Z5icRxLop3LLb6oDnFoI6ElCPHqhjraXO9E=;
        b=F0Fe4FYvMVCnce7OSoQO58+ZPzPGlyNpB7Fai9gRysOSTP+1WZQjPdGMqi3ULt6XaB
         uLyjiNfvn+nS2ywZQtzUrPuvZ1S4Exc5byI6nSTqXbtkvHquIzewoaj7uBkiX6//y8fn
         /6m3E64dCXkVSy5h5S3fJ5dbUN9mNutqOgHZyo+ApWvp5MsmCBs8TD2Ji0nI1bVtVQLw
         FpuVLhJIslT+uW7iU5JoD7Tt9iK7I+Eww6GSn7tc29LmLrrgnizMiYdzu1uo94WeFSCg
         1y4EvHF4UJUqgTVGQNZj1LiI4sdJy0nsjEBi+Wcrh0BMjJbPQMCOyci9swgoIuzSfzFg
         WLmQ==
X-Gm-Message-State: APjAAAXdoDq500cF6PKR1UMwHALTRoX+qQJbT/DA8vbpK7LcatNTV/kI
        P1eYRXFxtRyZHG8BoAI9bd2WeQ==
X-Google-Smtp-Source: APXvYqwH2Orm4MWO7tGMP8Tttd7dqIu91Ux9k7g1LMyOoTM4ZVPVjW6/er8/IXzFvv3m0iWdBdMkvQ==
X-Received: by 2002:a17:90a:bd8f:: with SMTP id z15mr11691370pjr.54.1576179378761;
        Thu, 12 Dec 2019 11:36:18 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id m34sm7568302pgb.26.2019.12.12.11.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 11:36:18 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        mka@chromium.org, Sandeep Maheswaram <sanm@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/7] arm64: dts: qcom: sc7180: Rename gic-its node to msi-controller
Date:   Thu, 12 Dec 2019 11:35:38 -0800
Message-Id: <20191212113540.2.Ibad7d3b0bea02957e89047942c61cc6c0aa61715@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191212193544.80640-1-dianders@chromium.org>
References: <20191212193544.80640-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running `make dtbs_check` yells:

  arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml: interrupt-controller@17a00000: gic-its@17a40000: False schema

From "arm,gic-v3.yaml" we can grok that this is explained by the
comment "msi-controller is preferred".  Switch to the preferred name
so that dtbs_check stops yelling.

Fixes: 90db71e48070 ("arm64: dts: sc7180: Add minimal dts/dtsi files for SC7180 soc")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 01bbb58ae516..1b2bb0b9c9e8 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1189,7 +1189,7 @@ intc: interrupt-controller@17a00000 {
 			      <0 0x17a60000 0 0x100000>;    /* GICR * 8 */
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 
-			gic-its@17a40000 {
+			msi-controller@17a40000 {
 				compatible = "arm,gic-v3-its";
 				msi-controller;
 				#msi-cells = <1>;
-- 
2.24.1.735.g03f4e72817-goog

