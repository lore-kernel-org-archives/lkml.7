Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66453C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A92F20685
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zave381f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfCRTlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:41:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44248 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbfCRTk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:40:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id w2so18414757wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 12:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iYcbdw0SobNZ1DKEtyOsg/AhnPu/CmThFhgWWs7DOwA=;
        b=Zave381f6F6eYXUT5XE8kYOOwujnnpASeD67mm7RFLbGbsjITUf2fUwDUipX5c2jSj
         OdBWKis4xAPiNst8Ut6f2EcApUFinBFLLvGPFIek6CrwuelpHoRJH6duE1Dfo7TJhHm2
         CJOqQcxCdoFUrwYGKNQrH/vbpe/xWMNezLEF4kSfh3W/iDg9dhwnlpdlW1X75ZGOEr7m
         w3E95sEwUSUYTj09Y8A5xGWJIBnxdEIF7/Y66RxxUyimmX44WKgcxB2ew1LndlqGWUnP
         7H/WiI+WTpwDcLdDE+1vABKwGIMnoAMpMrPxqu1gP1/9qD/x/XtFwjcwoWdDHMNSKs6e
         H37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iYcbdw0SobNZ1DKEtyOsg/AhnPu/CmThFhgWWs7DOwA=;
        b=ZWPVkRADt/wt2hWoJgXuJdrErVs7ObIa5BEDBrDHeAy4W3ad/MsOmAtgENMZeZghG0
         KLxd7CiosEqaqUW78W9/XC0O5t43H14jgaPdRFYmsC2cma7mUgYcyYgRe7UEDSVVOmyI
         MadaRpYuXTn/52aUs3ZDpxfoLIwx5AV5E3SzG3BSAiHQ4fsMCUvsTmajxTM9kYq1yUs9
         Py3C+K6fA8t/Uc7R33CCOco9Q8TceURqx7Uu5b9kzzLSyXUhuxCji18+58+svcf2mMjl
         iAjCR9jT56twOh7KK+2fHLn77ijHcuh8vyCT8g2ivAMTNrBvb5PgJYPzQf0CTLfEfsxa
         s7KA==
X-Gm-Message-State: APjAAAU9WqXNe1HaJTh4rLm5NxhGeULz6k6mv4oWSW42Fcb+jbtKYfaS
        tXGDfyht9E8yhqgll3vxTBO4hw==
X-Google-Smtp-Source: APXvYqxDhFz9Mg6jRME+Pb5JgnyOr8wtDzca5R7ayCiHcrg9EPTTNaVUtjBUnOW4nepUdFmTI19jkA==
X-Received: by 2002:adf:e2ca:: with SMTP id d10mr13102295wrj.250.1552938057398;
        Mon, 18 Mar 2019 12:40:57 -0700 (PDT)
Received: from localhost.localdomain (cpc89244-aztw30-2-0-cust4998.18-1.cable.virginm.net. [86.31.179.135])
        by smtp.gmail.com with ESMTPSA id s10sm4583941wrv.56.2019.03.18.12.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 12:40:56 -0700 (PDT)
From:   Peter Griffin <peter.griffin@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, p.zabel@pengutronix.de, xuwei5@hisilicon.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     john.stultz@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        yuq825@gmail.com
Subject: [PATCH v1 3/6] arm64: dts: hisilicon: Add Mali-450 MP4 GPU DT entry
Date:   Mon, 18 Mar 2019 19:38:48 +0000
Message-Id: <1552937931-23050-4-git-send-email-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552937931-23050-1-git-send-email-peter.griffin@linaro.org>
References: <1552937931-23050-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi6220 has a Mali450 MP4 so lets add it into the DT.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 38 +++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 108e2a4..2072b63 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -260,6 +260,7 @@
 			compatible = "hisilicon,hi6220-aoctrl", "syscon";
 			reg = <0x0 0xf7800000 0x0 0x2000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		sys_ctrl: sys_ctrl@f7030000 {
@@ -1021,6 +1022,43 @@
 			clock-names = "apb_pclk";
 			cpu = <&cpu7>;
 		};
+
+		mali: gpu@f4080000 {
+			compatible = "hisilicon,hi6220-mali", "arm,mali-450";
+			reg = <0x0 0xf4080000 0x0 0x00040000>;
+			interrupt-parent = <&gic>;
+			interrupts =	<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "gp",
+					  "gpmmu",
+					  "pp",
+					  "pp0",
+					  "ppmmu0",
+					  "pp1",
+					  "ppmmu1",
+					  "pp2",
+					  "ppmmu2",
+					  "pp3",
+					  "ppmmu3";
+			clocks = <&media_ctrl HI6220_G3D_CLK>,
+				 <&media_ctrl HI6220_G3D_PCLK>;
+			clock-names = "core", "bus";
+			assigned-clocks = <&media_ctrl HI6220_G3D_CLK>,
+					  <&media_ctrl HI6220_G3D_PCLK>;
+			assigned-clock-rates = <500000000>, <144000000>;
+			reset-names = "ao_g3d", "media_g3d";
+			resets = <&ao_ctrl AO_G3D>, <&media_ctrl MEDIA_G3D>;
+		};
 	};
 };
 
-- 
2.7.4

