Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1FDC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87A3206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x0Stg7Yr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfCGACj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:02:39 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45664 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfCGACe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:02:34 -0500
Received: by mail-pf1-f196.google.com with SMTP id v21so9909594pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZbPJjxSoYcl81yQ1wEFQrBqpLWhgT90XsJgxTUaDTjI=;
        b=x0Stg7YrNUiHiDFMZVrLIf4dg3dIguNoxLz9GoEjKz81Lp8qb0LAJrVbJbBclfg+bZ
         Is9fiGZw5CrfI7xHIYKOKfxhdXWt4y+YDGdFd3TL8IDJZdK60NzTHg5ISMEEaVtF/VfE
         ujxt7s/vonSA+3lv5r1M9Wstrm/5uWdyxTmz5CdWs+bmX1hI+KFJ+zdJy2/EaWISWm47
         H0VpMv+CR4+1HdMAZ2NFBpE/UWXSphD/Xc7A7o5X15sF219jgMX9mFm3dmR9PROsRE8o
         Navu5XWl+DDLKPp1z9+8e5lFO3F1uiIMePVcv5m4PG373i6GZ03SV7aSYB56cn5w3iGv
         RpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZbPJjxSoYcl81yQ1wEFQrBqpLWhgT90XsJgxTUaDTjI=;
        b=kyNDHfe2GorC0L2TGSsv58Kty8yNv07MdTF0E8bto9EhOjoeMHR0ECL7a6vYXGf2vL
         GD29uQmtb7wiUx9gWQvOkTNnXNK8+8khi1RwFTwqHjH4YljY3tnmPfh4nUk8bNaRuv/t
         9AKSXziFHL1Zq5QXrXaPsFgEFIRLR5S53xpLDFpxKk84P9Kc6Ar76gdNIcGwH2Wulsmt
         5secghhyQOWpqjP3/uqyt4PIs5hbIt9xbTba3kQHpQ93N98QMCMICT96qe08bhVefplz
         jVOaQPU6dLb/IWWBjL6SSljWKrrLitMYgHGiw81IjtxJ/8VrXQDDRANZcqL7WwyuG5On
         pg3w==
X-Gm-Message-State: APjAAAVMwc4Jfd8/7Cjv1B4JRUYxdkS5RHo3A9hmZsJ2YXHmhyiApppl
        xX8DyiSHusN8f7wLseoWAwSCZA==
X-Google-Smtp-Source: APXvYqwdnPW/y9So1gIGyOR8jQDF5+ug0ciRCC8Hqqf5gKIvxcay45WltY76fJ2iU72L4F2snRXL1A==
X-Received: by 2002:a65:6642:: with SMTP id z2mr8802824pgv.196.1551916953013;
        Wed, 06 Mar 2019 16:02:33 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n10sm4105589pfa.139.2019.03.06.16.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 16:02:32 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: remoteproc: Rename and amend Hexagon v56 binding
Date:   Wed,  6 Mar 2019 16:03:17 -0800
Message-Id: <20190307000318.1750-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190307000318.1750-1-bjorn.andersson@linaro.org>
References: <20190307000318.1750-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDM845 Audio DSP peripheral image loader binding describes the
properties needed to load and boot firmware on a Hexagon v56. Rename the
file and add the Compute DSP (CDSP) found in QCS404 to the binding.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 ...qcom,adsp-pil.txt => qcom,hexagon-v56.txt} | 34 +++++++++++++------
 1 file changed, 24 insertions(+), 10 deletions(-)
 rename Documentation/devicetree/bindings/remoteproc/{qcom,adsp-pil.txt => qcom,hexagon-v56.txt} (74%)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt b/Documentation/devicetree/bindings/remoteproc/qcom,hexagon-v56.txt
similarity index 74%
rename from Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
rename to Documentation/devicetree/bindings/remoteproc/qcom,hexagon-v56.txt
index 66af2c30944f..8011f88f7c1f 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,hexagon-v56.txt
@@ -1,12 +1,13 @@
-Qualcomm Technology Inc. ADSP Peripheral Image Loader
+Qualcomm Technology Inc. Hexagon v56 Peripheral Image Loader
 
 This document defines the binding for a component that loads and boots firmware
-on the Qualcomm Technology Inc. ADSP Hexagon core.
+on the Qualcomm Technology Inc. Hexagon v56 core.
 
 - compatible:
 	Usage: required
 	Value type: <string>
 	Definition: must be one of:
+		    "qcom,qcs404-cdsp-pil",
 		    "qcom,sdm845-adsp-pil"
 
 - reg:
@@ -28,10 +29,10 @@ on the Qualcomm Technology Inc. ADSP Hexagon core.
 - clocks:
 	Usage: required
 	Value type: <prop-encoded-array>
-	Definition:  List of 8 phandle and clock specifier pairs for the adsp.
+	Definition:  List of phandles and clock specifier pairs for the Hexagon.
 
 - clock-names:
-	Usage: required
+	Usage: required for SDM845 ADSP
 	Value type: <stringlist>
 	Definition: List of clock input name strings sorted in the same
 		    order as the clocks property. Definition must have
@@ -39,6 +40,14 @@ on the Qualcomm Technology Inc. ADSP Hexagon core.
 		    "lpass_ahbm_aon_cbcr", "qdsp6ss_xo", "qdsp6ss_sleep"
 		    and "qdsp6ss_core".
 
+- clock-names:
+	Usage: required for QCS404 CDSP
+	Value type: <stringlist>
+	Definition: List of clock input name strings sorted in the same
+		    order as the clocks property. Definition must have
+		    "xo", "sway", "tbu", "bimc", "ahb_aon", "q6ss_slave",
+		    "q6ss_master", "q6_axim".
+
 - power-domains:
 	Usage: required
 	Value type: <phandle>
@@ -47,28 +56,33 @@ on the Qualcomm Technology Inc. ADSP Hexagon core.
 - resets:
 	Usage: required
 	Value type: <phandle>
-	Definition: reference to the list of 2 reset-controller for the adsp.
+	Definition: reference to the list of resets for the Hexagon.
 
 - reset-names:
-        Usage: required
+        Usage: required for SDM845 ADSP
         Value type: <stringlist>
         Definition: must be "pdc_sync" and "cc_lpass"
 
+- reset-names:
+        Usage: required for QCS404 CDSP
+        Value type: <stringlist>
+        Definition: must be "restart"
+
 - qcom,halt-regs:
 	Usage: required
 	Value type: <prop-encoded-array>
 	Definition: a phandle reference to a syscon representing TCSR followed
-			by the offset within syscon for lpass halt register.
+		    by the offset within syscon for Hexagon halt register.
 
 - memory-region:
 	Usage: required
 	Value type: <phandle>
-	Definition: reference to the reserved-memory for the ADSP
+	Definition: reference to the reserved-memory for the firmware
 
 - qcom,smem-states:
 	Usage: required
 	Value type: <phandle>
-	Definition: reference to the smem state for requesting the ADSP to
+	Definition: reference to the smem state for requesting the Hexagon to
 		    shut down
 
 - qcom,smem-state-names:
@@ -79,7 +93,7 @@ on the Qualcomm Technology Inc. ADSP Hexagon core.
 
 = SUBNODES
 The adsp node may have an subnode named "glink-edge" that describes the
-communication edge, channels and devices related to the ADSP.
+communication edge, channels and devices related to the Hexagon.
 See ../soc/qcom/qcom,glink.txt for details on how to describe these.
 
 = EXAMPLE
-- 
2.18.0

