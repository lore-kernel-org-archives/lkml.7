Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26298C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB78B2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="K6AoFmOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfCKNhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:37:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39036 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbfCKNht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:37:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id h8so4061494pgp.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ckydVo2IPZQfXMKYGz1uqlUzm7n70fMIZ1xjq1PJknE=;
        b=K6AoFmOsvBeSoy2R9DvjoRG7CUz9NhugeLSTFnXh5vpwCDZYIV8lGEcUiR2sAlBTSn
         kvaIY0jm9r+/lG25xMEZt97rjCnzNtxofViiTGd+pQAR3KZG0Un6FKhC1BP/kifjBk3p
         lumikLZr3bM59um6hFxPED3u5YW6EBvja0Jzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ckydVo2IPZQfXMKYGz1uqlUzm7n70fMIZ1xjq1PJknE=;
        b=IPwx0LAQFcrQv4+c/NPjWKxje8hJH9NJxQzCJzUUSrKcpkwShegKUCNB0cvInmvlvS
         cbC13iVF7dRNGdlUZtPj/OilqFjvRTUlqH6XQJ2CwqOUj8YFsOpmJprwBC/UzEILtERX
         iuEIhxl95G+YnWl6h2wwEFbNLrIb3iBMXxoGSqIJBw+szirIIaz0wGQLDWD1TTby2S8V
         x4IPV39KUM2dRi8or7xApYY5KIx7KT4xyn77JgVsT5yN/cUjwnGBC+AQEGrRyJWramvg
         XghZCUxVEFIFJ0WJrMICKxIlwTUefwTcAvOPcNRFMC/Xuq+W/F8Jyiwrb7dFXCYssXL4
         5kJw==
X-Gm-Message-State: APjAAAUEjd5lE4EOQ36gupCWEjlC5i5NzGutTEBLkVuzVutWgZZgI30M
        RyFyFjXtIBWxMVdHMWi/2Rbb3A==
X-Google-Smtp-Source: APXvYqzwHorUX7e1L/skEZltcHC2vUfcxzbugCU38pVqLg5d2V/TJNegSrveDVfPq6SNbUBDJtnOlw==
X-Received: by 2002:a63:c0e:: with SMTP id b14mr30183128pgl.236.1552311469128;
        Mon, 11 Mar 2019 06:37:49 -0700 (PDT)
Received: from localhost.localdomain ([183.82.224.199])
        by smtp.gmail.com with ESMTPSA id s79sm9960397pfa.61.2019.03.11.06.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 06:37:48 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 07/15] dt-bindings: sun6i-dsi: Add A64 MIPI-DSI compatible
Date:   Mon, 11 Mar 2019 19:06:29 +0530
Message-Id: <20190311133637.18334-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190311133637.18334-1-jagan@amarulasolutions.com>
References: <20190311133637.18334-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI controller in Allwinner A64 is similar to A33.

But unlike A33, A64 doesn't have DSI_SCLK gating so it is valid
to with separate compatible for A64 on the same driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index 1cc40663b7a2..9877398be69a 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -12,6 +12,7 @@ The DSI Encoder generates the DSI signal from the TCON's.
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun6i-a31-mipi-dsi
+    * allwinner,sun50i-a64-mipi-dsi
   - reg: base address and size of memory-mapped region
   - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the DSI encoder
-- 
2.18.0.321.gffc6fa0e3

