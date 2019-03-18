Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43374C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1032087C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="u1lFVoEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbfCRJ7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:59:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55925 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfCRJ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:58:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so12251439wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gW6aA78DkLc8bNvO4THAoRegreuRYuXVAD8A6LBYhxo=;
        b=u1lFVoELp6WaVPX4WCAZ+1L6pyvWJjR6UGjDDUGEOj3L2ua8eDkYMRNTxYD1wnDjKE
         Lli7IVmlwqBkOUTCFx272/BBBoCUXrUqrg9v/bEpwuwLU3sOQJ7IEGni/q7sMsbaW7Dg
         MOkKbShHod9AKhG05vSzteDL4NgRHlW3xgaPdtEAWrA3mudwoWQWBN9etRhjVJWn7lKU
         grFS5J88gX2spEEDdAJBo1wm5NhtA9JSXxty9ptI/jZE+efmhLpF0iD8bYQH6JzkTHp/
         vjm8JFtq/Y7tdzbIN9NP6fK/b2oI/czRyghxYrHiNQhd2qJIWiy7VYyuCkiqLhp35tqU
         BsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gW6aA78DkLc8bNvO4THAoRegreuRYuXVAD8A6LBYhxo=;
        b=RWYwEGxy31+AcpaRFqGkkQrgi8Gvgj1vl0nrtHhOvW+EbdAZFnJTwJh+g+k1pNUOIG
         eqVckFoMp7vy5Pri5WycrXa7T3sdpuEtoEm1IMf+yYHJJYtXNGS84wVR3tAHw03lf2Gb
         vYAIQ6D9JjkJ/oZj/oF0zVAi7HZlLB/SdO7sMlTsjUNKk4mrsEcNPkgQZ6RgqfUHhAy+
         uICxNrUegz4MVkzkS1ZepUoh/XzVkbp/2tiJdCnu544sE9gyKeacbsAbuMhnbTHR8hXd
         RCmAqQSKLK5Deo8AdbZ65zCEe3JYr0SRtzF+cS4RnjlZTDaBQw/KzGnK/kqzSRf7UFyR
         g21w==
X-Gm-Message-State: APjAAAUa4RgL+T7rxboj6LMVS0YhukMEzHm9tLFLjE0DJS/3U7u8EtO1
        lKN0v/o6hN6SPfnPmvv/SiXWDQ==
X-Google-Smtp-Source: APXvYqzHotNEq5LncXeT0eIauOBrgU5fKe1nKlJDVJj4FZrZRFVObLov5jICRQE+bhscHn5nR6ME3w==
X-Received: by 2002:a1c:7c0c:: with SMTP id x12mr10423779wmc.38.1552903135161;
        Mon, 18 Mar 2019 02:58:55 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g8sm5459034wro.77.2019.03.18.02.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 02:58:54 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 1/8] arm64: dts: meson: g12a: Add AO Clock + Reset Controller support
Date:   Mon, 18 Mar 2019 10:58:44 +0100
Message-Id: <20190318095851.4062-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318095851.4062-1-narmstrong@baylibre.com>
References: <20190318095851.4062-1-narmstrong@baylibre.com>
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
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 31ddf9444b3e..5c0983edf837 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/g12a-clkc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -122,6 +123,23 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
 
+			rti: sys-ctrl@0 {
+				compatible = "amlogic,meson-gx-ao-sysctrl",
+					     "simple-mfd", "syscon";
+				reg = <0x0 0x0 0x0 0x100>;
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges = <0x0 0x0 0x0 0x0 0x0 0x100>;
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
 			sec_AO: ao-secure@140 {
 				compatible = "amlogic,meson-gx-ao-secure", "syscon";
 				reg = <0x0 0x140 0x0 0x140>;
-- 
2.20.1

