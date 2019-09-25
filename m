Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7D1C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CE321D82
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RmY/xOXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442447AbfIYHDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:03:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41782 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442434AbfIYHDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 03:03:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id q7so2811179pfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 00:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QtDjGuT6GYExoPUWAryXx0/SjRXtIy1CTdSczN1NQCM=;
        b=RmY/xOXe2eKL26y3uj55F1Fit+H+0WrrZaOHcLMNCDSNoi2kMXrhnE0ucEForuiEA+
         JyRluTVi28yl+sTJGSRelaPvSKuza6Hk+Q9GRAPSRoAwq1VWLfr4h3eTKtsojFr+xrG8
         zaY9vImby+VTXEwcWMmtB7mGhtQcEn/Gbn+gOrIIVg6zcpp/o2JX2j313Dln/oC0dVVe
         dwrSa+J5kDasv/Awru0qA99xL8YL5AZEQYzOpVkazBCDdADqsEzMLVdWX8iGhVjqi5wq
         IYNJJ7jeetpPukK/+WzB7j4TGb2RgEWr7x1WdwwyLnhmEJcVT6h0hfP3bpj7kkLXXnLb
         GK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QtDjGuT6GYExoPUWAryXx0/SjRXtIy1CTdSczN1NQCM=;
        b=eAiQ+0cFoheFBKZryd9rCINGs4GqnFRokB3kd2c8/oFl1jGpfZZI1DKHJgk2SLGS8N
         /fM94UcNNBl0+4rYUBmBfn5NfFnXOlLWDvVCECr0QOD5v9Gd7xDwoJ8JgU1qAjU2mwCT
         7NGKqxMosZKWD14d1wekgxph8iS1cFwCfC5vZg5cMvQ1zWpHKfx4SrKrEkAdqtQ9nmfz
         Mz/O35Wg/v2boAoqhKzCQoYlnCGka+nqnRXZD+nUc3YhcGbZwCMqitXXkhph+c+OwRFg
         6OS5wUT86jV0wtY/FOkQugD4RI/B+VktsQqAUxuPVmfdJeywEbqrZ8U2HmrRQ89yo5RK
         OyBw==
X-Gm-Message-State: APjAAAUc9irMvdIpur5cvCgjcQoEaZb+PKjP3R1FqjwkIcpmvjv7WEYY
        273bvTGHZfN1utEaqbfvta/vC15Ujt8=
X-Google-Smtp-Source: APXvYqwK0vMFcB0zMbrgYeYbjpMtEMvsl5ew0HFiuRMmFs5VRtF6LUvKhv2I9PfhGnJ3lD3U/s/nHg==
X-Received: by 2002:a17:90a:fa02:: with SMTP id cm2mr4735395pjb.133.1569395011749;
        Wed, 25 Sep 2019 00:03:31 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t3sm1541054pje.7.2019.09.25.00.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 00:03:31 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] arm64: dts: qcom: c630: Enable adsp, cdsp and mpss
Date:   Wed, 25 Sep 2019 00:03:28 -0700
Message-Id: <20190925070328.13554-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
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
index ded120d3aef5..d3c841628d66 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -20,6 +20,11 @@
 	};
 };
 
+&adsp_pas {
+	firmware-name = "qcom/c630/qcadsp850.mbn";
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
+	firmware-name = "qcom/c630/qccdsp850.mbn";
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
+	firmware-name = "qcom/c630/qcdsp1v2850.mbn", "qcom/c630/qcdsp2850.mbn";
+};
+
 &qup_i2c12_default {
 	drive-strength = <2>;
 	bias-disable;
-- 
2.18.0

