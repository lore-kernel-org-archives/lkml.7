Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D07C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F0520873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xx6xD6kV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389898AbfJPHfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:35:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36310 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389821AbfJPHe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:34:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id 23so13770705pgk.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4K812X2lC+GYM/4odmaRwgr1rxs2vpAuXCpq25weRAs=;
        b=Xx6xD6kVfeR3/JFqZsiOJQRbB4MJyUPL5aomJ+HRatBXvwNIGYCZjEjWCS80qXfNha
         hNqIwJsDPgQdeKOb32Dg77GT22ekUALjj76wpjLT9ABAIEL+/gUSPy+GRMmPvjkpfTA3
         n5D9wn7VRoQxvbYu6jbl2nIIch1FgwueJwQuxGi29QBC0pam23Lhv0dJV8hG2bfZWCDp
         iBRqu6DCgCVSaCnonaxu/YYl542PtlaI3LO1O7TkjAmbsY6JEPgi9eECLZy6DjB4gW8U
         DDexwG4JUORqW+tF2aTQr7okJCJFMmVirrMncKV5ty2XEIOqeIe1K7c0yymYkDnLTHME
         XxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4K812X2lC+GYM/4odmaRwgr1rxs2vpAuXCpq25weRAs=;
        b=tu+qaIWTzPmV5fNW1/PaNonHx7MGlwGwlvPVvGwscdsDGx3ZjjqcFxeSXYkG24W2nK
         RYjCm5eZnu3eWdYYlPs7h+McjdW9x1HoFCZ5O0j1Ih9NGBZuxeAD8NwWKQAotAVP2gRK
         KjE6qYdksU6sX7FCcTxgPqBbpFTMTbtZHU8MxnydSWDL6v8InSf2v0XRbQbF2R1KSICf
         WG1ClQmES2bxqYP35GSOk/zPko55DahzY5TXWFngBJl3O/wArwdCB1ZFbbR90oP37g3J
         zSIQO4KVr8ADxLwxpYRFnNw6+naTgyS9WxAj9exN6O5DAcRJ2Ag9o46ijqZjPk59p10r
         2JIA==
X-Gm-Message-State: APjAAAV0B7oL7s2OTdcgFAI8i8ZahbfuEFzYu9LCfsdu8QORfQJHrLEZ
        iuA3O6n75W7HbVfHTVYs6zcX6MTIhlcNJQ==
X-Google-Smtp-Source: APXvYqwsNRx3WNxoT4VeviLzs1ILoUNER9h+t26mhtuQLy5POR2lX08st0WtdhT1VWFsmu6NgDru2A==
X-Received: by 2002:a63:b907:: with SMTP id z7mr5209236pge.142.1571211295665;
        Wed, 16 Oct 2019 00:34:55 -0700 (PDT)
Received: from localhost ([49.248.175.127])
        by smtp.gmail.com with ESMTPSA id h70sm22045544pgc.48.2019.10.16.00.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 00:34:55 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH 09/15] arm64: dts: msm8996: thermal: Add interrupt support
Date:   Wed, 16 Oct 2019 13:04:08 +0530
Message-Id: <b42e18096b81abaaabe1822e75f1882781467c71.1571210269.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571210269.git.amit.kucheria@linaro.org>
References: <cover.1571210269.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571210269.git.amit.kucheria@linaro.org>
References: <cover.1571210269.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register upper-lower interrupts for each of the two tsens controllers.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 87f4d9c1b0d4..4ca2e7b44559 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -591,6 +591,8 @@
 			reg = <0x4a9000 0x1000>, /* TM */
 			      <0x4a8000 0x1000>; /* SROT */
 			#qcom,sensors = <13>;
+			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -599,6 +601,8 @@
 			reg = <0x4ad000 0x1000>, /* TM */
 			      <0x4ac000 0x1000>; /* SROT */
 			#qcom,sensors = <8>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

