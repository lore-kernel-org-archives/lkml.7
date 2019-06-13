Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F0BC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AC820B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ECdMR7ns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfFMSyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:54:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45638 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfFMSyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:54:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id bi6so8129570plb.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6lwM3RQ6rY++wgw7yn5WUFBlppvdw3r+F1ViBjDeHCs=;
        b=ECdMR7nsipHVwpuR1tty9HburkoT+7g1MO15MFZjZnEJZmdzoLMuz4qU32PXk398ag
         dQXE/W/Ky1zTaiZvfsHfrtHdez1m4Jn1hXKc+Z43+YdH/+3HToRbQCYVTj+kT4hRt0X2
         Q/qiHEfPhbDBevTUyrBjoTziUZ39wS6hvPfkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6lwM3RQ6rY++wgw7yn5WUFBlppvdw3r+F1ViBjDeHCs=;
        b=Nv7F5AGkKYerZTW+lqvoxRQ/6jWcKuHHHNuL8Z4kH928X+E0p1kS67Xju+g0Xwsjm/
         QJeZw7QWEdD+BH2BPmH2AKWil97W9TpfmVUIvcekQrvdVoXnIU/asnrFFVsE6Xk+4hYC
         5ej1arCM5XuBKmHX+YTHgDv2BPTjfRVODFmTzT/ScSOsD5xPR7b5+pg4OfJ0u+vvyXHL
         ORgLFJAwgQevxqDXfd4oVH2S82weqx8ftxYazk69pgXcUaBa5EHnMBeaDcBJZoUIuopQ
         1MpMVJDn0NLB5AdX7jVnGwoNZyNoaDespeQa5UoTPtDWJ2OCUKTfQ6kOio1e+HSGPJ7g
         n/OQ==
X-Gm-Message-State: APjAAAW7hBMo31so1tnJx+DoFQqq6Ba73BgEVSEOEyzAIJRvj13n87Zf
        BLbKuUwEpR4DfRakwSV04AaFNw==
X-Google-Smtp-Source: APXvYqwrSEcwAiyWJov4mOAq0qxt+AHhKCRfAadeR4vw9EKNHl7WARJKCDYcPqUSKwH+A1yGV7auMQ==
X-Received: by 2002:a17:902:6a88:: with SMTP id n8mr83133009plk.266.1560452055157;
        Thu, 13 Jun 2019 11:54:15 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.18])
        by smtp.gmail.com with ESMTPSA id p43sm946314pjp.4.2019.06.13.11.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 11:54:14 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 6/9] dt-bindings: sun6i-dsi: Add R40 MIPI-DSI compatible (w/ A64 fallback)
Date:   Fri, 14 Jun 2019 00:22:38 +0530
Message-Id: <20190613185241.22800-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190613185241.22800-1-jagan@amarulasolutions.com>
References: <20190613185241.22800-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI controller on Allwinner R40 is similar on
the one on A64 like doesn't associate any DSI_SCLK gating.

So, add R40 compatible and append A64 compatible as fallback.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index d0ce51fea103..438f1f999aeb 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -13,6 +13,7 @@ Required properties:
   - compatible: value must be one of:
     * allwinner,sun6i-a31-mipi-dsi
     * allwinner,sun50i-a64-mipi-dsi
+    * allwinner,sun8i-r40-mipi-dsi, allwinner,sun50i-a64-mipi-dsi
   - reg: base address and size of memory-mapped region
   - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the DSI encoder
-- 
2.18.0.321.gffc6fa0e3

