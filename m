Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C284C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185932195D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QpJ3VuEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfCXRUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:20:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40355 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXRUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:20:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so4726479pfc.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 10:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rsdBtwWghaHouWdIXmkjzHG+6U7OuZ/QvuUZmh2Rbpo=;
        b=QpJ3VuEd3lx6zOeCgZG4fzZpBZpZMklA64yclCyvrDXOV/7i2wQA2Ock5SiRCvn7UD
         vcYRb9p0YRSwalG3KN7sEnbIaBDaQVBNnoAggqVV+KI/lt9qBAkLjcQIS0lhRCN44Vvr
         9q4j/hqcr5WCBTB3ubp1AoMcu51I/gQCeK93KxVIXjix+NYGWsRmMT97tvmnwcIkWa+W
         lshqRdKLH4vOmF8/Mu76kLeLyf3vWPquPldBZ/iVXBsjraBuKSawEkg9sOy54LtlaKMI
         HsGmczoRFZkJq3AgQDBmxxHLlDmJmUSJBVXmLn0IYoOCyluAokKBpwCHFH5RmPpzvN5i
         /Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rsdBtwWghaHouWdIXmkjzHG+6U7OuZ/QvuUZmh2Rbpo=;
        b=XMMnIr2yAYP1h3nBs1pdDP724uA+/mUoY5FIm0nmz55XAQPQtbHAXWebOV6yd1Nnwg
         mNzA97R3N9KVL/okjb4ufJJZJBt0i2DFbFobWFA49Egq6vdD8sQTrAMGcgxqpf/riFk2
         jTEY60C4EWwO+q6rj1aMRZjHA0XjSQ2irf4nLfnaPQrbDn2BmsHYgK+eLkzPO+Qiy0WR
         YdlKNvRmwyN3MSkplm0CXc1M/ACpQ/AJ0MO5jp1KppwxuF/H++TnuJIgPVncyYwPuIPA
         EMTX1nOSF9pvXk3apa1uzojM9Xoc+hjXt4lyRT8NSD2gOghoTVcB0a1it8ZNpaPFjimy
         65/A==
X-Gm-Message-State: APjAAAXFkvGbWb9MpAhkrU2YVNK4Iu+e0oNC27nIBjONNJqbt3hoVUwR
        9luwsyp6xmGv0GUhu6SH+okCAg==
X-Google-Smtp-Source: APXvYqzkla8oJA80R1Zo2GLoSxftJ031wFLWR9UhK1A0jDTdpZHj3ysUTQAmH7JV8/CoWSB1I8ZYmA==
X-Received: by 2002:a63:8142:: with SMTP id t63mr14207714pgd.63.1553448020819;
        Sun, 24 Mar 2019 10:20:20 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g6sm20382713pgq.54.2019.03.24.10.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 10:20:20 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>, Vinod Koul <vkoul@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: qcs404: Add turingcc node
Date:   Sun, 24 Mar 2019 10:20:15 -0700
Message-Id: <20190324172016.1195-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190324172016.1195-1-bjorn.andersson@linaro.org>
References: <20190324172016.1195-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node describing the Turing Clock Controller of the QCS404. Given
the default access restriction the node is left disabled.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 298a6053c3e0..f62cd09d965e 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-qcs404.h>
+#include <dt-bindings/clock/qcom,turingcc-qcs404.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
 
 / {
@@ -264,6 +265,17 @@
 		ranges = <0 0 0 0xffffffff>;
 		compatible = "simple-bus";
 
+		turingcc: clock-controller@800000 {
+			compatible = "qcom,qcs404-turingcc";
+			reg = <0x00800000 0x30000>;
+			clocks = <&gcc GCC_CDSP_CFG_AHB_CLK>;
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+
+			status = "disabled";
+		};
+
 		rpm_msg_ram: memory@60000 {
 			compatible = "qcom,rpm-msg-ram";
 			reg = <0x00060000 0x6000>;
-- 
2.18.0

