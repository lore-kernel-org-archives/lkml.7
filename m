Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864C0C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 03:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0AE2080A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 03:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YfjvWjsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgAHD0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 22:26:33 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36273 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgAHD0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 22:26:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id x184so891540pfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 19:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1xOSp/kO5RUHbhgM95X1/1jyAywCmLEOyBUx87fFFtw=;
        b=YfjvWjsaaKSbVwMhWV4e2o2UhVmKdwk3YsOZGjWpCogvoGsPWrQNsyJorRN6s8wfgN
         A85ZEmclMJYvt2/41/sVuGiUkdi/SXwXQY6qW7HuF+q9QkWp2hRZRITST6+4z4vW9W3c
         SONMWPY5/FwsyIQDvtO00HuOxmyjd1HOhKXis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1xOSp/kO5RUHbhgM95X1/1jyAywCmLEOyBUx87fFFtw=;
        b=BqxWf+Ha9/wcwDM6vBBSUCqL68/ECkdbA/MMcAO8fd/OlqZkC82sHQLDzbOw+jwqn9
         e4/Ol/VPJggd5DJ+rDbWmekQtBjHxcMYNykXMVMzJI1drU0ymzfkgl9iIpEcVH3/nRLr
         BEeOpcSCMtDZAo2y6jJNi5OhkgvBFNflEDq64K21onv9+mLdTC8XQAINbn3d9DZmTVnU
         7/aXJseSgMmNqGwk/SuNngpIvmurellFKoi7amGf06f9xjQjIVZ/HBFmEqF6jEM8TCEG
         9I9PtBiI9TiMCJ1AX3/D6uRfF6Lz83j8AZERVEqpELqVpc8hiPG6qId6fFqbbARO/Kjh
         /ggQ==
X-Gm-Message-State: APjAAAVaE4hw6fm0XcPVgWFM+vJfhzxRcFFCo8iDeI/SQ8YH+sczjNrI
        vLcYj/0XZBuoksho34F9DDBFog==
X-Google-Smtp-Source: APXvYqyUT6VsXxCtYuElv5Y3o6IQMdGzsPCyousxOHbeS/ntlyTO3M2XSD2NtvvArGznvirU2k991Q==
X-Received: by 2002:a62:3086:: with SMTP id w128mr2755138pfw.58.1578453992605;
        Tue, 07 Jan 2020 19:26:32 -0800 (PST)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id 80sm1056157pfw.123.2020.01.07.19.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 19:26:31 -0800 (PST)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v2] arm64: dts: qcom: add Venus firmware node on Cheza
Date:   Wed,  8 Jan 2020 12:26:23 +0900
Message-Id: <20200108032623.113921-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cheza boards require this node to probe, so add it.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 6 ++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi       | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index 9a4ff57fc877..8c2e3aeacac4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -1279,3 +1279,9 @@ config {
 		};
 	};
 };
+
+&venus {
+	video-firmware {
+		iommus = <&apps_smmu 0x10b2 0x0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index ddb1f23c936f..8f1d19c5a098 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2567,7 +2567,7 @@ usb_2_dwc3: dwc3@a800000 {
 			};
 		};
 
-		video-codec@aa00000 {
+		venus: video-codec@aa00000 {
 			compatible = "qcom,sdm845-venus";
 			reg = <0 0x0aa00000 0 0xff000>;
 			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.24.1.735.g03f4e72817-goog

