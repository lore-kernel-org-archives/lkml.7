Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0A3C49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020B821835
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OVKi08S5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438068AbfIUPMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 11:12:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39095 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438034AbfIUPMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 11:12:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so9604766wrj.6;
        Sat, 21 Sep 2019 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WfQ1e9LFDFE1Z5maZrDyEq/WutECQBCS0m0ceOAIqa0=;
        b=OVKi08S50hGEiRw9dBzGluGTGgtg+pKlp3xygMsU4spmhQ51+dAU5e6bPO31NbjcRR
         q0OHBrM3S3waNNWWw51OjK4uchrcrc/TFylItNLLqgi75Q2j3h1n/b9QPljojXbD1kFP
         NevFD8TLX1GtPO4cyMTxRaMDfy6etU+ilLKB75FaAUt2Pvbf3IS5Bdzhjx2BfgpEjLh8
         CeF5cq5Jf6S2DvnGXC8y7wlDNsHaWtg8KZpJubtEYTSE5VvPEh8fDbR+zaInW3CuqHfY
         Upb+8JbbcoYmzMttXpMdnx3SU2WOmZ3YFxH9/HGGMzlC2MdmHep1XsWA7hrJI9S4SH21
         inHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WfQ1e9LFDFE1Z5maZrDyEq/WutECQBCS0m0ceOAIqa0=;
        b=PzmZ0Ij7dmEGXzcBnGJBn7D7zeb3B9jyAFAXpsKY91oOVvUCURrTFpsVfxiH557RC0
         7pR2meHCtvHfaodchgfy9+alJuRo8yr//K0E3c0szkEit4/bqRi3+xfrnE9qWLzaOISX
         e24FGqwD+3oUKyxRe2WPbPkPvCIBh8msm2NGld3SL6NC9VuDX1lphUQbvwjPVq0yovxG
         9JGU+AZ8tClPbISBbNCzrHW9jLZi0NBxgFa6pED6yPUm8GaA7cuRJMPAuEUbbBQrdg63
         GdChDEytvLbVfS31SPNoneRbbTHkFCETs7g9NmcMdWLzPtIUubEIjmBeuzxNtqtdfBTF
         2X0Q==
X-Gm-Message-State: APjAAAX/+MWMHcS55+TbM+8scic8WJyDgjrZT1ve3/drkQlRctzRq1m8
        LEX36B3LLCO4+Rc6GD959CI=
X-Google-Smtp-Source: APXvYqz97gwP1YJzwvQCqfcq+Gp85bKA2r8M6d+E7PYadTAilKiby2e0S8TKyZPdPmgnhDeAvWVe6A==
X-Received: by 2002:a5d:40d2:: with SMTP id b18mr15977793wrq.4.1569078765019;
        Sat, 21 Sep 2019 08:12:45 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133CE0B0028BAA8C744A6F562.dip0.t-ipconnect.de. [2003:f1:33ce:b00:28ba:a8c7:44a6:f562])
        by smtp.googlemail.com with ESMTPSA id y186sm10712491wmb.41.2019.09.21.08.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 08:12:44 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/5] dt-bindings: clock: meson8b: add the clock inputs
Date:   Sat, 21 Sep 2019 17:12:19 +0200
Message-Id: <20190921151223.768842-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190921151223.768842-1-martin.blumenstingl@googlemail.com>
References: <20190921151223.768842-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock controller on Meson8/Meson8b/Meson8m2 has three (known)
inputs:
- "xtal": the main 24MHz crystal
- "ddr_pll": some of the audio clocks use the output of the DDR PLL as
  input
- "clk_32k": an optional clock signal which can be connected to GPIOAO_6
  (which then has to be switched to the CLK_32K_IN function)

Add the inputs to the documentation so we can wire up these inputs in a
follow-up patch.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/clock/amlogic,meson8b-clkc.txt       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt
index 4d94091c1d2d..cc51e4746b3b 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt
@@ -11,6 +11,11 @@ Required Properties:
 	- "amlogic,meson8m2-clkc" for Meson8m2 (S812) SoCs
 - #clock-cells: should be 1.
 - #reset-cells: should be 1.
+- clocks: list of clock phandles, one for each entry in clock-names
+- clock-names: should contain the following:
+  * "xtal": the 24MHz system oscillator
+  * "ddr_pll": the DDR PLL clock
+  * "clk_32k": (if present) the 32kHz clock signal from GPIOAO_6 (CLK_32K_IN)
 
 Parent node should have the following properties :
 - compatible: "amlogic,meson-hhi-sysctrl", "simple-mfd", "syscon"
-- 
2.23.0

