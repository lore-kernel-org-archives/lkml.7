Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E1CC04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D94A207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RafgoOWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfLIMUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:20:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46400 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfLIMUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:20:37 -0500
Received: by mail-pl1-f194.google.com with SMTP id k20so5728792pll.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 04:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJLNZ5TvbBRTBk5/byYcKg9wRzpXt/4CUjn6xa6Yk2k=;
        b=RafgoOWy81f3KsyNV6b4nwN0KnXLBvQ2HkyA6S5LLq6ZloyClLVD6VZ3NTwKfu8iS7
         xNS4VsiadFrWaWJdsza8CA0c0+9EnC6YoLu6W1EmnaO/6Kt9HzfGkS/2AP0xcnHE9Eyb
         r3H8KhlDnRb7GWWP63ARzFFZfUL6r8ziuokYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJLNZ5TvbBRTBk5/byYcKg9wRzpXt/4CUjn6xa6Yk2k=;
        b=aWOQAtnCgwvOsRneOVH8NTCafuQoZYj27q7CxPyeWLiePucxb+lPA92Fna7uZYVwhH
         UWAD5VU1hnNwyjTNU5Y6XQuDqphg6QQZ4A1rPK1z464jXpxoUGjEKOclOlG4ytGDA9pM
         QMfsjVPDUaCfiqsUI5tWSBcAldgk6brkmYqsiw6hVtgPsxD6Bxdzh8B6OUuoLhqnXV9z
         7rL9ftuXNiZFisOXm/cKuieyfKm8TpJGL1L09V/rk2q5ZDtxxiEXXjuE+TZPfbEwq55c
         wJDKgFC4CpSkxwrPL6onQjr6AMef4/Bi6hSTYeRj6O2kQC+CBvlOY6D1Vg8Pn/N9Q5MZ
         dd+g==
X-Gm-Message-State: APjAAAWpjoxZzoA/agRSDhsuALrD4Thnl8/G6Qojmtgd4yIuMB+ei2eR
        GQSRkyGql3KHs9Ql8Uoezhn3Zw==
X-Google-Smtp-Source: APXvYqxoMr3FbIpijNOEPSqLNXh6fn576z9LQ1rBetbAQMOnnockF3VNaxXXJ4ojvMAG7toh5y6XzQ==
X-Received: by 2002:a17:902:760e:: with SMTP id k14mr5360485pll.198.1575894036563;
        Mon, 09 Dec 2019 04:20:36 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id p21sm26733813pfn.103.2019.12.09.04.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 04:20:36 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Thierry Reding <treding@nvidia.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Matthias Brugger <mbrugger@suse.com>, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: drm/bridge: analogix-anx7688: Add ANX7688 transmitter binding
Date:   Mon,  9 Dec 2019 20:20:10 +0800
Message-Id: <20191209122013.178564-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
In-Reply-To: <20191209122013.178564-1-hsinyi@chromium.org>
References: <20191209122013.178564-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Boichat <drinkcat@chromium.org>

From: Nicolas Boichat <drinkcat@chromium.org>

Add support for analogix,anx7688

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 .../bindings/display/bridge/anx7688.txt       | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx7688.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/anx7688.txt b/Documentation/devicetree/bindings/display/bridge/anx7688.txt
new file mode 100644
index 000000000000..78b55bdb18f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/anx7688.txt
@@ -0,0 +1,32 @@
+Analogix ANX7688 SlimPort (Single-Chip Transmitter for DP over USB-C)
+---------------------------------------------------------------------
+
+The ANX7688 is a single-chip mobile transmitter to support 4K 60 frames per
+second (4096x2160p60) or FHD 120 frames per second (1920x1080p120) video
+resolution from a smartphone or tablet with full function USB-C.
+
+This binding only describes the HDMI to DP display bridge.
+
+Required properties:
+
+ - compatible          : "analogix,anx7688"
+ - reg                 : I2C address of the device (fixed at 0x2c)
+
+Optional properties:
+
+ - Video port for HDMI input, using the DT bindings defined in [1].
+
+[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
+
+Example:
+
+	anx7688: anx7688@2c {
+		compatible = "analogix,anx7688";
+		reg = <0x2c>;
+
+		port {
+			anx7688_in: endpoint {
+				remote-endpoint = <&hdmi0_out>;
+			};
+		};
+	};
-- 
2.24.0.393.g34dc348eaf-goog

