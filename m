Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882ADECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BAA220854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eFrfxwuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390382AbfJPHfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:35:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39705 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389906AbfJPHfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:35:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so14158057pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=aMdrJzILxuSr5g6YT+uoh2+W6L6BuGxRIbKk0lFLJqE=;
        b=eFrfxwuX98m0mVPWQgy0cowYXczi0HbPFwOzG0WXPWDMKhxZNa2L/BnbDyE8HZFs6p
         1d3qJ+Oyockzuq8VqIuYGZPTvcKemsVj3el1JZ9vK/pt0K8Twj4ysuhMHIBDJ8ZYSOk/
         L+eWvz006UruJo4tnbK0GyQKVPmSD/7O+EyqoKrifnBP+uO0sT7fHmCs0C2+fEVqyu/s
         5lloeBdzKA46Vja3aVGdGAnoTe7EEtvl+7AcP2yGDSXUxOF+uGlrZrCRawPY53gD7G0O
         a9K7iXwWZj6osIOEXgS8vMp8NJdpBD6G1hA9BiOoDDyqeaEPDQko0FJLQbkD1QBe46jz
         HHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=aMdrJzILxuSr5g6YT+uoh2+W6L6BuGxRIbKk0lFLJqE=;
        b=cQudQ/+dDaWG8B0RxD35pzlYqtgWZbcPDFPK3lWzhTs4oR7pLZFJv7l18UVJNkC0Mv
         nI83jMtTK5fAIiPbq4qa6sr6SjNQNIq1ZsiqvdA8E3K3YVeXvSPkA6hUChC7Ab9sBcRF
         Xry3OXozxK9pWjS215KSt2BxN+vsWFS3pFzx+QpQ8BdhGh67SiSPTyn+98yN7ENCaLgf
         AAn5XMX/4jJPGloHM4nfmmfdbYdyiQAaXZ/DOi2OW0BYEb/KOJfVHaT6UIY/hOvFWRCF
         7+39k+lhjJf5zLbbZrZoacOi4wMm7g8oYKMQEIGi3UqGZFKFI83Iw7jgSks0odU2ozXi
         k2aA==
X-Gm-Message-State: APjAAAU1sJ6kqA3Y+Cj9CyYZRlSNjKh5ejfp6XPuUAqVn7FZjA3Ztly9
        TuFj6VdF7Fo/5CJO1KPsUun9AUhmrVQN4w==
X-Google-Smtp-Source: APXvYqxVG9NAkBqkoExE8mqtLpk30e1uae5egg5SfnPaBqxGtmxrby6ezxyMeLYuZDb9VA2YQtT39Q==
X-Received: by 2002:a63:5520:: with SMTP id j32mr2064328pgb.162.1571211302908;
        Wed, 16 Oct 2019 00:35:02 -0700 (PDT)
Received: from localhost ([49.248.175.127])
        by smtp.gmail.com with ESMTPSA id t13sm21590605pfh.12.2019.10.16.00.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 00:35:02 -0700 (PDT)
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
Subject: [PATCH 11/15] arm64: dts: qcs404: thermal: Add interrupt support
Date:   Wed, 16 Oct 2019 13:04:10 +0530
Message-Id: <63d6b0b8bba0d217c2f7bb4240c587ead933b6be.1571210269.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571210269.git.amit.kucheria@linaro.org>
References: <cover.1571210269.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571210269.git.amit.kucheria@linaro.org>
References: <cover.1571210269.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register upper-lower interrupt for the tsens controller.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index a97eeb4569c0..b6a4e6073936 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -290,6 +290,8 @@
 			nvmem-cells = <&tsens_caldata>;
 			nvmem-cell-names = "calib";
 			#qcom,sensors = <10>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

