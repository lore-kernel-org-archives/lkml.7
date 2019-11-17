Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC5CC43215
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EFE2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DjU0C/ID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfKQN77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 08:59:59 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:44952 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfKQN77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 08:59:59 -0500
Received: by mail-wr1-f53.google.com with SMTP id f2so16350600wrs.11;
        Sun, 17 Nov 2019 05:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AI7oneBVr9Sh8KI/EU2QuzQzAJVjV4haI51WvzEvAjc=;
        b=DjU0C/ID1NfUiIWc88ECCm8hYmVDymKmODomd9NlTEsQA8kBmsbs9Yaj+kV6+S3A5Y
         cVEOSM45iyG8La96kCE9baDwHRe7utZmIwOLfBjEvaTeUIvE5zqLB02xRFbOfu2VCHU8
         dSreasOblG5NC6BNBkl60rb8ag1Et8+4ALPBseCMh438x6pL4cnq9B/li7a9Ss5gfygZ
         SgnQxzr7dY1oFI26nE4jTwDuvXdIyYdjNLcMhNr4pTdUXSMwE7IfUzkVgkjtKrLpscEL
         xeru+GS5Jn/GLwnLZdcdvCOH4y70Yvft70eW4Y1ZXWfkp5kmSZrEWNiLBHGLU6CyZMrG
         6OLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AI7oneBVr9Sh8KI/EU2QuzQzAJVjV4haI51WvzEvAjc=;
        b=bZMPBcxaHd2eAENk6IlqugwNl2okQXR7CU0kiIKZxantIJArxFyABQ5nloAX6hDtyi
         scFS1BYZEWUY90lYZeecepgpMUCPj+dGWuzDDiqyxSZh2DFXEfQUhM00ABnDzNBSGC5l
         1MeLnipzDnL46Xmq4XCwXGmZT7EfwwO9A2K/UmGAO2fBSmrCj3gUcCff7JVLVLQH68Xk
         M6D4EQ918ezqGeAE4s0XWRe4i3SjBtwv6eu+tKlb3Ete78x3Rawz8sG/zg8GNNmBjhjK
         QQO/5onyzGW0BGJ/YdKYpYA6SJIdPs4NzfGPpNOWWd6ab3IWQBZ00BdKvCLd1JARoYdl
         afDQ==
X-Gm-Message-State: APjAAAVMjwGNF3MXgozyNc2uLTxNNOdWFIA6taxBhejk8bZN2N22RYYV
        dkZaa/dwKCHWh7yI3ZhXFaI=
X-Google-Smtp-Source: APXvYqxuh9+V3F0zaSkPtijZBTMVQwPp1ojlde26tDjEtxtx16d/NlKmKiJeZpZDN+YTugtSvMi/+A==
X-Received: by 2002:a5d:42c8:: with SMTP id t8mr20309817wrr.87.1573999196558;
        Sun, 17 Nov 2019 05:59:56 -0800 (PST)
Received: from localhost.localdomain (p200300F1371CB100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371c:b100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id n65sm18004803wmf.28.2019.11.17.05.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 05:59:56 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/5] dt-bindings: clock: meson8b: add the clock inputs
Date:   Sun, 17 Nov 2019 14:59:23 +0100
Message-Id: <20191117135927.135428-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191117135927.135428-1-martin.blumenstingl@googlemail.com>
References: <20191117135927.135428-1-martin.blumenstingl@googlemail.com>
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

Reviewed-by: Rob Herring <robh@kernel.org>
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
2.24.0

