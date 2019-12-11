Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9E3C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D988F206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mMm9OjJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfLKAga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 19:36:30 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38964 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfLKAg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 19:36:29 -0500
Received: by mail-pj1-f66.google.com with SMTP id v93so8172676pjb.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 16:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FP/zf8K1mqQfn8K0ftqgHZHJkSfo2eQNHAUrAnf9xJs=;
        b=mMm9OjJqHaCdZ8bw5nQR5ALK6Vvq1vvnOx/1JoAZq+nyus+8xOU3LLEqdKoJlDDBpT
         k0ouqFNdxes2yTJ5conUr5xMaJ0GVpw6NQYsh+ghC21UfebkirgvIMkF+nPRVUkAwzl6
         o2++Q32flzjDaXapq5Iqowm5PmrJBJYiWOoC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FP/zf8K1mqQfn8K0ftqgHZHJkSfo2eQNHAUrAnf9xJs=;
        b=c67caO33jho8zBdy6JFDnza/e5fkDXzkJcwf/iIE0vinzvb3gsX/YjV88vRL6UOzrV
         WJ1oiOR+NaMvrf4WpkEhJaYAkXyTyl3q5kGkUG+D4zZjaMV5YaAlMFbDUuHCRjnmff8Y
         LvVXvJMKo7vqmGASFOTngeEUyTHFKNr6DQM2LHexpUluv5K/iP8aAghs8ROlzlzdv0KE
         /N0LxULVLt7/8ZoHkaVQGUFpYv806g75iEnj1Z2S71BtyUbR+eBXKLoJ9ILpSstyQNDF
         w4p/rgJdMuVUnZws3aueAStmzJFFBbU1tFHODcIe02oYsjhT6Mc3YT15R4Vq5Z1u+zQ/
         RwIw==
X-Gm-Message-State: APjAAAWUr2YbLykd3qGy4YESj+7q7R67bKoL3nBwnFCwrHkM3bmGGmE5
        T9cMdWEbVQpxBRcZj5STFcR8RA==
X-Google-Smtp-Source: APXvYqyyMYn3eEkOXOSpuNWtCY++KZHNmwUrop6lejJN8jyCdg0iqPJPyizJpEsGK/R5di1B2iynhg==
X-Received: by 2002:a17:902:7c88:: with SMTP id y8mr299401pll.104.1576024589168;
        Tue, 10 Dec 2019 16:36:29 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d38sm159954pgd.59.2019.12.10.16.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 16:36:28 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     mka@chromium.org, Roja Rani Yarubandi <rojay@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/2] arm64: dts: sc7180: Fix indentation/ordering of qspi nodes in sc7180-idp
Date:   Tue, 10 Dec 2019 16:35:39 -0800
Message-Id: <20191210163530.1.I69a6c29e08924229d160b651769c84508a07b3c6@changeid>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qspi pinctrl nodes had the wrong intentation and sort ordering and
the main qspi node was placed down in the pinctrl section.  Fix.

Fixes: ba3fc6496366 ("arm64: dts: sc7180: Add qupv3_0 and qupv3_1")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180-idp.dts | 73 +++++++++++++------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index 189254f5ae95..5eab3a282eba 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -232,6 +232,20 @@ vreg_bob: bob {
 	};
 };
 
+&qspi {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi_clk &qspi_cs0 &qspi_data01>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <25000000>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -250,6 +264,29 @@ &uart8 {
 
 /* PINCTRL - additions to nodes defined in sc7180.dtsi */
 
+&qspi_clk {
+	pinconf {
+		pins = "gpio63";
+		bias-disable;
+	};
+};
+
+&qspi_cs0 {
+	pinconf {
+		pins = "gpio68";
+		bias-disable;
+	};
+};
+
+&qspi_data01 {
+	pinconf {
+		pins = "gpio64", "gpio65";
+
+		/* High-Z when no transfers; nice to park the lines */
+		bias-pull-up;
+	};
+};
+
 &qup_i2c2_default {
 	pinconf {
 		pins = "gpio15", "gpio16";
@@ -364,39 +401,3 @@ pinconf {
 	};
 };
 
-&qspi {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&qspi_clk &qspi_cs0 &qspi_data01>;
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <25000000>;
-		spi-tx-bus-width = <2>;
-		spi-rx-bus-width = <2>;
-	};
-};
-
-&qspi_cs0 {
-		pinconf {
-			pins = "gpio68";
-			bias-disable;
-		};
-};
-
-&qspi_clk {
-		pinconf {
-			pins = "gpio63";
-			bias-disable;
-		};
-};
-
-&qspi_data01 {
-		pinconf {
-			pins = "gpio64", "gpio65";
-
-			/* High-Z when no transfers; nice to park the lines */
-			bias-pull-up;
-		};
-};
-- 
2.24.0.525.g8f36a354ae-goog

