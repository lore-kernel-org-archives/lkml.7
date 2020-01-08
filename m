Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3803BC33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D68E2081E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H333vNfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgAHF6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 00:58:21 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40064 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgAHF6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 00:58:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so1047556pfh.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 21:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Phg8y1R5IYTau943Qj+6UR9d0/QPUMjq7ucLEIys45A=;
        b=H333vNfZtn+CPBYRjGbjwSoCT6UolP+k7JjY/9asLzrEum+Btp3wL1m7q67xG9iGPf
         XquHXjAFfeRx0GVmDLB1X3jGI7QpLZrAVE1WxWF+1/+XvPmzqdhDqG60iBECVosP1Ip5
         2inpz0OIyrJMg2sn2YyodCPiRHsixi650TJQvcT6nBIrFOk1uTWvfaoC5kOpAP2Wc4lC
         0JdKgrBhgH1MlnFTLbFyn0Dg4xmUXSDGN0GJdHEQUw3Ge+TLu6WDjrNoh1WUpHTNjE8w
         8DQdXrVP6SracHU7feuKSJY2KrzxKgb+LHgS9cxd8vway5DAW42eoQIYfByid70zpkRS
         96Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Phg8y1R5IYTau943Qj+6UR9d0/QPUMjq7ucLEIys45A=;
        b=e5UsSn14JSJ1kYktrRjvsHR1jUjWloATS7Wtrz285wAClYeUpNf9crpO3JirBLvQJj
         vKEkcyNfWuQUGkEZEUqpcSV6tNOpn6j048gY/VKb1dfh3fQa9n87qyQKp9nyYRbvoDeY
         S46JNNR4cOck+LQh6w1us/UXlb6sG9eMDt5yktNAadsmHMjtlU7vadN58xyDl/U18SrU
         YIWwX+BrQCXklxUiBPhFC0GhNTD2yhejFzakn4o76kUWqw5rRWWohfgjS2KTO7VXKa+h
         +loXXwsbn3zRFhAFs0mKCgLUruef+AgBG3XRiQ7CA5IhT5/bVX0t8CXTCdXP4A9GeFrP
         thoQ==
X-Gm-Message-State: APjAAAX3XqnexbhCWbEww3XEoPxf50xAxv7fYdT8Fv28Vv+w/sL8TsHa
        qnS1h8AwHHgK354RPKvYpB1RRw==
X-Google-Smtp-Source: APXvYqw5E7G1glzJF9cSgW+HhcYIsPSmF8DMa0JFZyZ0P4dKjH3ejvmGwwAQ4C12DLkT42EFOq/tnw==
X-Received: by 2002:aa7:824d:: with SMTP id e13mr3266032pfn.247.1578463100112;
        Tue, 07 Jan 2020 21:58:20 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b12sm1577546pfi.157.2020.01.07.21.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 21:58:19 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: db410c: Update firmware-name for wcnss and mpss
Date:   Tue,  7 Jan 2020 21:57:35 -0800
Message-Id: <20200108055735.660475-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the mpss remoteproc node and specify the firmware-name for this
and the wcnss remoteproc on the Dragonboard 410c.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi     | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 037e26b3f8d5..298684c62cc1 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -494,6 +494,7 @@
 
 		wcnss@a21b000 {
 			status = "okay";
+			firmware-name = "qcom/msm8916/wcnss.mdt";
 		};
 	};
 
@@ -538,6 +539,11 @@
 	};
 };
 
+&mpss {
+	status = "okay";
+	firmware-name = "qcom/msm8916/mba.mbn", "qcom/msm8916/modem.mdt";
+};
+
 &spmi_bus {
 	pm8916_0: pm8916@0 {
 		pon@800 {
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 9c4d89319e7c..1ced09a61531 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1054,7 +1054,7 @@
 		};
 
 
-		hexagon@4080000 {
+		mpss: remoteproc@4080000 {
 			compatible = "qcom,q6v5-pil";
 			reg = <0x04080000 0x100>,
 			      <0x04020000 0x040>;
-- 
2.24.0

