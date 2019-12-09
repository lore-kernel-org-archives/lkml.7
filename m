Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119BBC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE98207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FoiOPgQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfLIOvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:51:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43726 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfLIOvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:51:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id b1so7226732pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 06:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGLkt56MhFh8o5EiPOGN5Gs/bQLSYtcgRKiESMUAAEg=;
        b=FoiOPgQcYmkXm/tZqxmuOTlheNX0AgdOI/2MZIVoyVaDZ2omAlNpvjC5J7UkXZjHkN
         w/FEIk9KLjFC9aKhMHaRz6mznpSflD0o8I0Gq9L9AKEzN5+Ft6j7taGzy5nEO8JDQzdE
         SXjPxv1lzNd1yp0r/THRyWzyCzs5KLo3RQEv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGLkt56MhFh8o5EiPOGN5Gs/bQLSYtcgRKiESMUAAEg=;
        b=gw+wUbMXvXPKJDf6Aox/E23UE9928dITyC4DW4l/jpQwPSMhuLPzrBe/d9EL6VFIZT
         GvXPmViRXTAyhaW9rlC7NygYKYxi/24GxliZ8MwY4xZJF3PChOb2BdQV4825Zq3IZmss
         /KfG1P7psZsUNFf/UZ61wp8ADUrAoOWcK3bhu3qbWFCtASH7hLvFd7S6AmpVsIFVjhk5
         jXwO3F5atNuFTK69kQH/38Lpi5k71903Vk/n94/+F2fLxby+/5H8cWBZ5hRH5u5O/ShC
         mMklLEopx55Q+Hf2T7VHTpfrDZw9NWGjM4LLVZ43dXNsJFoUZkHg/f1oXTeyjYoZvwpf
         JhgA==
X-Gm-Message-State: APjAAAVQBRyB1WHQZ6V4uH4paRTRgwWhiIZxFXAfQ6Qq4NTAhaEXF3uT
        Igskudec8mjrlOyQxTrDMrws5w==
X-Google-Smtp-Source: APXvYqwdFN4BDi6/3J9nybGN70nDZ2haqNMPr+4STLfU6yafWcXmeyYw7k9dIphwuYdoFrfoWNCktQ==
X-Received: by 2002:a63:93:: with SMTP id 141mr18975594pga.411.1575903097523;
        Mon, 09 Dec 2019 06:51:37 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id k16sm29143119pfh.97.2019.12.09.06.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 06:51:37 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Archit Taneja <architt@codeaurora.org>, p.zabel@pengutronix.de,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RESEND 1/4] dt-bindings: drm/bridge: analogix-anx7688: Add ANX7688 transmitter binding
Date:   Mon,  9 Dec 2019 22:50:13 +0800
Message-Id: <20191209145016.227784-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
In-Reply-To: <20191209145016.227784-1-hsinyi@chromium.org>
References: <20191209145016.227784-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

