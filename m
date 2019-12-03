Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F037C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F8D2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kfohgtuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfLCFYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 00:24:14 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38821 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfLCFYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:24:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id o8so1214187pls.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 21:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=XTs9jOzk9TL0hbRB6PjchZQOiZjWYWm9M+GqSi78t2E=;
        b=Kfohgtuot4VMjzMiYs1RTN4CFr9Jv/O7n0D/sGYRNzskj2k00jCBksRHVQfvnqUxAA
         2IbaRwkzM9ZN4Ci0TmKQ5Q2rUPnUKyEP8UtqkpfbOdifaxkbf92SIpyTA6bGOPeCHzku
         g5zteQaD96IhVul8m2Qn2/GwP1eh8em5lJ6jLEQzFmP6bc7XWnohjp2YYIyeZbkbE3MI
         ZnE3VIXaj3BwDiLB7VM60MzzpHGCZ0qMfHYlziNEzGnNBj15NuHbf035kLSiPA80k74E
         pWvKpE4Ql/uLYJ3e4ggEFrEVbGcTigkR+E8s/rYckZ+ZT++oeDFcO/pG/zALFSPy+oAL
         t0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=XTs9jOzk9TL0hbRB6PjchZQOiZjWYWm9M+GqSi78t2E=;
        b=n+3EnyrwaL5M0qcucW8mYD6/gc3vRj/CX6abXxhWaej4BekA5cHKugBL/gUq5KBZK/
         Be/G5Ci1IACmhXKQyRtcVQZ94Qr6yEYe2DBPZJNUQyIJ2SIrZKAtJqTSjlHAzxLa1e4j
         g4JOCvL+azP3Z9zHAf5BpDSS0gNWAPkGZ1qRLc3SJB5Qvb1iOh4TL22pBqujo5cL2ZR7
         9kPb6qOc73cRGZBAv/NA0zUhNdNd4vvPsqrNSq/9Tc/1Z7+isDCQTlAWx/Eg3aQplbBy
         z2TUku/ETW38WQCXAGkO/rLdqFKtGgOkkZKWjurVr4rVQHdAnmzXblW/OhRUAMSk4QAi
         r9VA==
X-Gm-Message-State: APjAAAUK4xO6sC4MUVRhy/egx2wxhd5OXVGgIw2l2PIQaY6xC1LUlZL7
        +4hxplVEiyI/dK/4CRxru0fcs06FtyesHQ==
X-Google-Smtp-Source: APXvYqy8GFCzB0hsgDh30sxoG3uiLFI3/zW3FYzh5VBo//Uenr05GQzjstP9U+bCmlG9zacc6MVthg==
X-Received: by 2002:a17:902:bd97:: with SMTP id q23mr3255257pls.310.1575350650547;
        Mon, 02 Dec 2019 21:24:10 -0800 (PST)
Received: from localhost ([14.96.109.134])
        by smtp.gmail.com with ESMTPSA id j17sm1449689pfr.2.2019.12.02.21.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 21:24:10 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 9/9] arm64: dts: msm8998: thermal: Add critical interrupt support
Date:   Tue,  3 Dec 2019 10:53:30 +0530
Message-Id: <3ef309a98ca6445c1982ec3ff1a70db39b18f415.1575349416.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register critical interrupts for each of the two tsens controllers

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index fc7838ea9a010..4b786b8651a90 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -817,8 +817,9 @@
 			reg = <0x010ab000 0x1000>, /* TM */
 			      <0x010aa000 0x1000>; /* SROT */
 			#qcom,sensors = <14>;
-			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "uplow";
+			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -827,8 +828,9 @@
 			reg = <0x010ae000 0x1000>, /* TM */
 			      <0x010ad000 0x1000>; /* SROT */
 			#qcom,sensors = <8>;
-			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "uplow";
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

