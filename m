Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71D0C28CC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB05208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V0jQzMib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfE2K4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:56:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45587 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfE2K4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:56:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id w34so1137369pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 03:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ckydVo2IPZQfXMKYGz1uqlUzm7n70fMIZ1xjq1PJknE=;
        b=V0jQzMibWyqWK10H6MvY76fJcwPWlGrRY8e7Df827n8zYmV9xEN/F62M7y906QKzhy
         xoeISZnEqS7mw55e65yCWO7PijGBgJGHsLydsQoE9PlcgzZ466LkuT5qH+47NCdA5P9Z
         1YRFF+E28l166xBoI+WV7zEvpSlDNH63GJ2Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ckydVo2IPZQfXMKYGz1uqlUzm7n70fMIZ1xjq1PJknE=;
        b=ZNEkOMEYVYHO66Htx4e8hPJ7ivpDH100p7ueTQLwJrPU3c+ly8gSdESVoilVtZwi6c
         j/Cr3F6k23zoxN2PQJofxEb1Kk9YNuL6k0JxLMy6I8zJzWZkhpXSMiDD2q9AtrvJZPlI
         LLJCRcaqikMpJmEk2Io8kyxcLKtahDWbnNoSCqkArWpOR/5+sc1DgxRWNvhDJIGYfraw
         iWxX6OrPSsB1O5vsOEaFO1EQUBUK3ymNgOz2gJB1V5qFWxQm8Et1ir9zbuob0qj4IuG9
         odyeOCUzMOlnKwVTeW/dMgq7KA+HO3z+5SbG5vafgDNwle/YBQ6MnRasncf5o5adaC6D
         perw==
X-Gm-Message-State: APjAAAUrrZNXiSbGUPGYCdzjjoSTYMeTWIrpTmng3TgKKJ1LJJYSvtYl
        rAcTicmKPuejFkQKoJDCNIRfcg==
X-Google-Smtp-Source: APXvYqxAqeyPUCEfsLpzPpNkG6VxtpiEQSBzycYxUZb/YK7f/rdLKTkrj+3tN8YOGJs1FXUIwvLy1A==
X-Received: by 2002:a63:4d56:: with SMTP id n22mr110949138pgl.307.1559127406146;
        Wed, 29 May 2019 03:56:46 -0700 (PDT)
Received: from localhost.localdomain ([49.206.202.218])
        by smtp.gmail.com with ESMTPSA id 184sm18974479pfa.48.2019.05.29.03.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 03:56:45 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com,
        Sergey Suloev <ssuloev@orpaltech.com>,
        Ryan Pannell <ryan@osukl.com>, bshah@mykolab.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v9 1/9] dt-bindings: sun6i-dsi: Add A64 MIPI-DSI compatible
Date:   Wed, 29 May 2019 16:26:07 +0530
Message-Id: <20190529105615.14027-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190529105615.14027-1-jagan@amarulasolutions.com>
References: <20190529105615.14027-1-jagan@amarulasolutions.com>
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

