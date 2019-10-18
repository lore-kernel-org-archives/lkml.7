Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075B2CA9EA2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F4921925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qqJwU622"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504138AbfJRF5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:57:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33029 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733227AbfJRF5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:57:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so3181752pfl.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Js+iQqRt+tyVvDa8T2+59UNIVU1o5cqdHzqCUWKNHTw=;
        b=qqJwU622nloSCo+eDDdWSnXALFxYQYLLjz8aa6hvAtj2seJgktKl3vd4aabmeSwhGb
         OyGXhneGLvb3zcZz5YnXVa1ueCFO6a4SXOOnXCSMvfNNt05L71C9df3cqbXSzMk9yX3j
         lzl9kbUGj6FD5mDzCsiD7CbPIZE1e+3ZJkU3zvAOxG7OO41kZtXTwqk3r3R/YB6ZxWsR
         ooy4DuMsAPqlnUEjkB8aCLuGfDzy3WGKvXzOOFQBAVL9/RwDcK+KX4eUwcAMX7VsFjRC
         ZAoFnKs87Rf9fY/98feemSfbKPRQFdsMq0Ile4Pgb0f6vy7adqEoeovJ83oskUUAs/1Z
         45eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Js+iQqRt+tyVvDa8T2+59UNIVU1o5cqdHzqCUWKNHTw=;
        b=Lraw+fBXUrRXPkVH8r0M1I9XYiF3anEIGZyZGVbUYXZn7ZxXMDnnCwIXdogkAYzUpE
         T2kROjDai1mtsXhFCYt4tGijtFr5099C95lxnf8fVbSsMKdY61fkObpaLKhQWGDsWtBb
         jMrm13BRz6xMSW1gn2kQCdNCtEOBwr/nWfeaMDuI0EBEtVuEcj4x1px/piYcydFxgHhi
         OlJjHSuklCzOZ8YcQkHAJ1QmsoPQazDM1qC0yt5pQ5rrIiwIrgl37x1nWzBYJSbQRUXg
         92Kuqv75WHF8PsaY7rD1owgaLhIgRotgwrftluSACPVz0cMnbw7JLBBOCbUruEVcqhVs
         PVuA==
X-Gm-Message-State: APjAAAU63iT9mOx1f5jpCOx7503RW772rGO8ubC/gQCw1XjG8y+K6F0o
        BCyKujxJy/B2HJeIeUAWigWjDEBQYw4=
X-Google-Smtp-Source: APXvYqx+ArUOcJehPBAHXaUzSzo4RpxB23gWZCK+k/SVPFm4zblI2hb6HPl7/FJ4Y5BPypzM93yIwg==
X-Received: by 2002:a62:e90d:: with SMTP id j13mr4734628pfh.237.1571378230140;
        Thu, 17 Oct 2019 22:57:10 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a11sm4467587pfo.165.2019.10.17.22.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 22:57:09 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: c630: Enable adsp, cdsp and mpss
Date:   Thu, 17 Oct 2019 22:57:06 -0700
Message-Id: <20191018055706.3729469-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the firmware-name for the adsp, cdsp and mpss and enable the
nodes.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index ded120d3aef5..13dc619687f3 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -20,6 +20,11 @@
 	};
 };
 
+&adsp_pas {
+	firmware-name = "qcom/LENOVO/81JL/qcadsp850.mbn";
+	status = "okay";
+};
+
 &apps_rsc {
 	pm8998-rpmh-regulators {
 		compatible = "qcom,pm8998-rpmh-regulators";
@@ -229,6 +234,11 @@
 	status = "disabled";
 };
 
+&cdsp_pas {
+	firmware-name = "qcom/LENOVO/81JL/qccdsp850.mbn";
+	status = "okay";
+};
+
 &gcc {
 	protected-clocks = <GCC_QSPI_CORE_CLK>,
 			   <GCC_QSPI_CORE_CLK_SRC>,
@@ -296,6 +306,10 @@
 	};
 };
 
+&mss_pil {
+	firmware-name = "qcom/LENOVO/81JL/qcdsp1v2850.mbn", "qcom/LENOVO/81JL/qcdsp2850.mbn";
+};
+
 &qup_i2c12_default {
 	drive-strength = <2>;
 	bias-disable;
-- 
2.23.0

