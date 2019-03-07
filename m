Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44649C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BD720840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WrfwCJ8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfCGPNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:13:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38636 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfCGPNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:13:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id g12so17854226wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o5XEdwpDX11r9A87w3stM5IV0M/gayIT+SRuFG7e6Us=;
        b=WrfwCJ8BCOUDT7aZTmwMIPbmA8q1v4b54YOtZaezz78B504KuEY9DykUQddhdB5SQa
         /vWT2RT+GeLV/Hw2ugUzZw7aTWISgL2FbGcAVfsH1yVP6vztT3n60SQyX+LVfCJyTT/J
         jVRLfh8hu/MbFSAiLThJB0uE6a9Db+cPcbQR8v/k6Pl/5h1AyrUen/9y9NkLzNqdtLDO
         prjoBGxsL1v1QKRA5U+aVA0l/sAqklL89xYk06NKk16oL4CuQ8x6e8eowvp2VrAKp9Lo
         h2qnOaQO0op1p4tDE1Cyq/l5w77JW2eOsMxGJ2fXZYKsNncETHFMXDDbYqHQViqOBju2
         g+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o5XEdwpDX11r9A87w3stM5IV0M/gayIT+SRuFG7e6Us=;
        b=trN2wfDpD1fkhD+gHbNU8LY4UdEDAP93OLdfR+9PTLaW9EaPECSJVMZr92fdDR/Yfc
         aeNUyTTOcMfcXW5X2hTOSr7VWnemH82r9PcveLlMI5mmOf/KMqzZMtfrSb8ymPl2sspu
         3alH79z3UWNLiXTnCdWI5u92r+N1MYbD0GRkWHl8m4dzSpSDRuj7lticiUB3zGhZudQz
         dH+kVGzx0NjOzpGIqVl11vMNv7HjJqjhevJBXoMjiV3Xl+I00H8jb8jHd4hR1a23u0B1
         uGglbtgYeTJsQMyoavUSp9YSKFpsrbByRQCebLRBVrWeAUXiezJ2Cb2Ziw/75gfATRr0
         RvUw==
X-Gm-Message-State: APjAAAX+emvuR/aw2eak6mDiVBGLI7yqewzdOB/AfvzIoCixekNFjXzv
        Pqeok9NrQgN4ALC9k0XepWn7nA==
X-Google-Smtp-Source: APXvYqy277dgVFlzsKDF/aVIaUHzXa37oZcGXrXImL0Oo6jVAMWbpKSACNU2iWMFTQLk9hQuiYWuYA==
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr7018064wrm.291.1551971624762;
        Thu, 07 Mar 2019 07:13:44 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r15sm5756563wrt.37.2019.03.07.07.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 07:13:44 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 1/9] arm64: dts: meson: g12a: Add AO Clock + Reset Controller support
Date:   Thu,  7 Mar 2019 16:13:33 +0100
Message-Id: <20190307151342.7381-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307151342.7381-1-narmstrong@baylibre.com>
References: <20190307151342.7381-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes and properties for the AO Clocks and Resets.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 191d31db9853..0eb5220da82c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -122,6 +122,23 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
 
+			rti: sys-ctrl@0 {
+				compatible = "amlogic,meson-gx-ao-sysctrl",
+					     "simple-mfd", "syscon";
+				reg = <0x0 0x0 0x0 0x1000>;
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges = <0x0 0x0 0x0 0x0 0x0 0x1000>;
+
+				clkc_AO: clock-controller {
+					compatible = "amlogic,meson-g12a-aoclkc";
+					#clock-cells = <1>;
+					#reset-cells = <1>;
+					clocks = <&xtal>, <&clkc CLKID_CLK81>;
+					clock-names = "xtal", "mpeg-clk";
+				};
+			};
+
 			uart_AO: serial@3000 {
 				compatible = "amlogic,meson-gx-uart",
 					     "amlogic,meson-ao-uart";
-- 
2.20.1

