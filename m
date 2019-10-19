Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFD2CA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 22:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4FA21D7C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 22:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMqU8AmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfJSWM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 18:12:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46126 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfJSWMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 18:12:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id e15so5317549pgu.13;
        Sat, 19 Oct 2019 15:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GfOewpLHGX+dzk9mg7++bvsjADScpIlodI4RprwqfC4=;
        b=mMqU8AmXmMj9wx7BTAit1++7cUEmbP+mFUE9BBSX05UjmvFFUnShcyxspOHPql5YcU
         Hd4s1I9/gE4EyHkuynU0Z/Kl833fz7XWRw92gOq6QKT1g6MW/O8TN3iouYx+fVX6Eebe
         OV6MdFxMTSOzXIUNiu5jdtTNht7KvhjvWglQmXjmaSXnBLZCNTX8LYMqno9Uf3OkMQcn
         rvLl9bKXWHqiF9B7+NkIhZ7UUP1EHHHfHbier1Wpbt++zFbiSaPEJ645x4Bygqj91CEb
         YqT+Qy3HDib5eifmHsI3MVrVf/xYVBvqfiqz9z6AXWEfnH1rTBAjBFjDoquLnj7klXmt
         ajEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GfOewpLHGX+dzk9mg7++bvsjADScpIlodI4RprwqfC4=;
        b=Z+hVKS1p7Rt58Jej1QM7+wOpHuloCXAcp5qALE9LzvkRu4MW06ZnCq2gi/B7gPL3Cx
         e7LU/cabv//rNdu5rL+VW2bufEAxwtTImM2Cz+epAXulvgqvi+BdH6zRWN1ribA+jREB
         C385XdxhrIlX+1S3j99Jx+jRw2rHfpXhwILvbTmGWs3B3xDqfKK6T9Rk5OW1WQxXbX0/
         xNXRndl0vN+T4R+O6pGWpViwo+vcmPKqyJv0ewotCP9m6neyzaiuL1D7dOCOJigkqYHf
         GYbWabYSnF7Tc3FRQCaJ2WDMxsRw4neH59XZ86s/zY48dC70SiDNp5zVoesHgewm+tKp
         ww1w==
X-Gm-Message-State: APjAAAXCLBzaYsUvajJEnbnzrN2y62eEXKbykmb+3eXeeZaiHGMgGvP5
        qarwMcu0EGfw6aesg5mnEiTqDBxf
X-Google-Smtp-Source: APXvYqxtJv5Y38sSrZp0BxPCpqRRvkcQUbOu3nagjBlnrapXcaKu9JuZyQ4TtD13Dvaoe5Q2egyxRg==
X-Received: by 2002:a63:495b:: with SMTP id y27mr17279766pgk.438.1571523144756;
        Sat, 19 Oct 2019 15:12:24 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id bx18sm8522324pjb.26.2019.10.19.15.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 15:12:24 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH] arm64: dts: qcom: msm8998: Fixup uart3 gpio config for bluetooth
Date:   Sat, 19 Oct 2019 15:12:17 -0700
Message-Id: <20191019221217.1432-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that the wcn3990 can float the gpio lines during bootup, etc
which will result in the uart core thinking there is incoming data.  This
results in the bluetooth stack getting garbage.  By applying a bias to
match what wcn3990 would drive, the issue is corrected.

Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 .../boot/dts/qcom/msm8998-clamshell.dtsi      | 31 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi     | 31 +++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
index ab24d415acc0..7e02cb6c8e07 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
@@ -74,6 +74,37 @@
 	};
 };
 
+&blsp1_uart3_on {
+	/delete-node/ config;
+
+	pinconf-cts {
+		/*
+		 * Configure a pull-down on 47 (CTS) to match the pull
+		 * of the Bluetooth module.
+		 */
+		pins = "gpio47";
+		bias-pull-down;
+	};
+
+	pinconf-rts-tx {
+		/* We'll drive 48 (RFR) and 45 (TX), so no pull */
+		pins = "gpio45", "gpio48";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	pinconf-rx {
+		/*
+		 * Configure a pull-up on 45 (RX). This is needed to
+		 * avoid garbage data when the TX pin of the Bluetooth
+		 * module is in tri-state (module powered off or not
+		 * driving the signal yet).
+		 */
+		pins = "gpio45";
+		bias-pull-up;
+	};
+};
+
 &dsi0 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index 1a1836ed1052..17f51af5e999 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -37,6 +37,37 @@
 	};
 };
 
+&blsp1_uart3_on {
+	/delete-node/ config;
+
+	pinconf-cts {
+		/*
+		 * Configure a pull-down on 47 (CTS) to match the pull
+		 * of the Bluetooth module.
+		 */
+		pins = "gpio47";
+		bias-pull-down;
+	};
+
+	pinconf-rts-tx {
+		/* We'll drive 48 (RFR) and 45 (TX), so no pull */
+		pins = "gpio45", "gpio48";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	pinconf-rx {
+		/*
+		 * Configure a pull-up on 45 (RX). This is needed to
+		 * avoid garbage data when the TX pin of the Bluetooth
+		 * module is in tri-state (module powered off or not
+		 * driving the signal yet).
+		 */
+		pins = "gpio45";
+		bias-pull-up;
+	};
+};
+
 &blsp2_uart1 {
 	status = "okay";
 };
-- 
2.17.1

