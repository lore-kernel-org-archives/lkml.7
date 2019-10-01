Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFF0ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662CA2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PMFyjHJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfJASfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:35:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46153 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfJASfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:35:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so10235492pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 11:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6OmoG9nmfnxp1hTQSnSmg1pG2i9ciIUjtqDNmRYZw6w=;
        b=PMFyjHJwQLR9BN/b+vKadsnTfwLbbJmf2zBAgtox4/WCysbzBXr8UFaVyYm7ToqSKi
         r6Ats7g3lDQbweDGfkQYRnWxPKkcAFEaLonbBCGxWk/H/hDrDIpoO7n/ZQAT+ZUKDIcl
         NCmCrRgDiNaxWHyAAkV4ByoKEOW8XuYmdTpyW95FhtBf0t4cnbtPLDHeX4q9lCutRRR4
         JgGIhWuy/PonjWTOqUK9YdqMDaWfllC7lt1SvYnMVr9vWxEtuMC1uqAjscmjmaMgVMTE
         25nwLkmrQwphR2/y53BHm6iCbd0QsDV1f5fjQi+HUaLbog1hbM5wBs4+lBDwWysejKqS
         m5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6OmoG9nmfnxp1hTQSnSmg1pG2i9ciIUjtqDNmRYZw6w=;
        b=nAJ6cYsNg1knCegtaS+K0MMYkB4wOvkHqnwF5AhUug4a6h/BrdyjA223qSzV5y6VT9
         EiMx9Z80tnXVwdPAhY/qU2Q2z7t/gkpRkug7kK50ZLTRFSHTnaEHUYcVpJAd/21bFh03
         s3IW8eKQrr+KfTAGTpXQ81hl2xzx5YRMaZPO+3eFQCGmW3/x6ZziL3iJYdhOGRuoDv8A
         XFsMAMElGUVlKpKzZfGje18JElvcbqLdvaS78EBGVo5WPndnk+L1I5L26cUhkzT0jc29
         Y8D3ij+WECff6lt0CUfV8TH/i5y5mCvF/IlU1KbjONzQizHlto2N+FuYkyjgLg1o2rxG
         yl+g==
X-Gm-Message-State: APjAAAW4XB4/m0sdSRphoSoa7EKkcKQU7oV29DU5e2DG/iZ2xRGuu+8t
        MHpNXZPqcLDg4MFrcFQRCLAyTncNGME=
X-Google-Smtp-Source: APXvYqwufTWDovtqMSDCdgIffp1MdomqxuofdL0vq4XG3lfejHVLVq3PhYVe2oAkWLjpOOUbVa2DRw==
X-Received: by 2002:a17:90a:178d:: with SMTP id q13mr7189954pja.134.1569954939726;
        Tue, 01 Oct 2019 11:35:39 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j10sm16803222pfn.128.2019.10.01.11.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 11:35:38 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Peter Griffin <peter.griffin@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH] arm64: dts: hisilicon: Add Mali-450 MP4 GPU DT entry
Date:   Tue,  1 Oct 2019 18:35:35 +0000
Message-Id: <20191001183535.70835-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Griffin <peter.griffin@linaro.org>

hi6220 has a Mali450 MP4 so lets add it into the DT.

Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 38 +++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 108e2a4227f6..2072b637b5af 100644
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
2.17.1

