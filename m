Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821B6C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5752A207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ToMamDlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfLIMUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:20:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38061 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbfLIMUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:20:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id o8so5748017pls.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 04:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jJwCq9E5sHUES1apw52pvzBBVDCgoOmF9UzMrlF+I9Y=;
        b=ToMamDlBdtGc6HWR4u6Df1/w+9GuqbMO5QPDj43TnsU66oqMIBvyqqQBbh2UErjkdE
         ndZN3Ao+3mrQd04Uw0c37+CG4AYIybK1OXP/qN4f+nd1adxV0qshJiFycPK4QMsgGIR/
         ZB/6i1hJ7AkrmqZoFw3fAHK+2qNzCedXkJjDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jJwCq9E5sHUES1apw52pvzBBVDCgoOmF9UzMrlF+I9Y=;
        b=iIVrJ5k7Dedjl7WP4wScQgxeE7b1w5XQNrGD8tb57p9KnW3OLbDD1nlbsqdR5iHMIm
         2eiS0H3Mc2Joa8cvQTkxikJRfht3VPRvEeaMCFroyYCQlIyZ2UkrnS8+A2pwN7dGpdr3
         fWCKDGu6y+SsUoiFNhqQMeVKY5mYL5jWAxe0Mu62nuluuMpGnP52NhCg172KQM8DAdpJ
         MXLGJ96ZDN1NMTJtty++7LSIUZF5y/tvZt7oF64jg2soHEcrqlSwPlnGftXkbxL+AYX6
         4izcm/97MKdOHI7TLap+a1TH6fMr4ht/2EdwC33O5YX9ykgCM0dZdpM6p/jQ0sWdGYFE
         0j9w==
X-Gm-Message-State: APjAAAVXsFQMxEIvf0o0QFEThGcmzT8HIAJspJpXizT3Y9+U6jPDK4ah
        iixrrlX2xPcQTexJrOpNCnBcXQ==
X-Google-Smtp-Source: APXvYqysHMmAFrD3m3tlj9ZX9fug8HAdxXWYvC6SD36Gi+NKgGLW+KDuHH9YvK1YhwCqLO5lC23yhQ==
X-Received: by 2002:a17:902:ac88:: with SMTP id h8mr28987310plr.131.1575894042818;
        Mon, 09 Dec 2019 04:20:42 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id p21sm26733813pfn.103.2019.12.09.04.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 04:20:42 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Thierry Reding <treding@nvidia.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Matthias Brugger <mbrugger@suse.com>, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: drm/bridge: analogix-anx78xx: support bypass GPIO
Date:   Mon,  9 Dec 2019 20:20:12 +0800
Message-Id: <20191209122013.178564-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
In-Reply-To: <20191209122013.178564-1-hsinyi@chromium.org>
References: <20191209122013.178564-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support optional feature: bypass GPIO.

Some SoC (eg. mt8173) have a hardware mux that connects to 2 ports:
anx7688 and hdmi. When the GPIO is active, the bridge is bypassed.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 .../bindings/display/bridge/anx7688.txt       | 40 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/anx7688.txt b/Documentation/devicetree/bindings/display/bridge/anx7688.txt
index 78b55bdb18f7..44185dcac839 100644
--- a/Documentation/devicetree/bindings/display/bridge/anx7688.txt
+++ b/Documentation/devicetree/bindings/display/bridge/anx7688.txt
@@ -15,10 +15,13 @@ Required properties:
 Optional properties:
 
  - Video port for HDMI input, using the DT bindings defined in [1].
+ - bypass-gpios        : External GPIO. If this GPIO is active, we assume
+ the bridge is bypassed (e.g. by a mux).
+ - pinctrl-0, pinctrl-names: the pincontrol settings to configure bypass GPIO.
 
 [1]: Documentation/devicetree/bindings/media/video-interfaces.txt
 
-Example:
+Example 1:
 
 	anx7688: anx7688@2c {
 		compatible = "analogix,anx7688";
@@ -30,3 +33,38 @@ Example:
 			};
 		};
 	};
+
+Example 2:
+
+       anx7688: anx7688@2c {
+               compatible = "analogix,anx7688";
+               status = "okay";
+               reg = <0x2c>;
+               ddc-i2c-bus = <&hdmiddc0>;
+
+               bypass-gpios = <&pio 36 GPIO_ACTIVE_HIGH>;
+               pinctrl-names = "default";
+               pinctrl-0 = <&hdmi_mux_pins>;
+
+               ports {
+                       #address-cells = <1>;
+                       #size-cells = <0>;
+
+                       port@0 { /* input */
+                               reg = <0>;
+
+                               anx7688_in: endpoint {
+                                       remote-endpoint = <&hdmi_out_anx>;
+                               };
+                       };
+
+                       port@1 { /* output */
+                               reg = <1>;
+
+                               anx7688_out: endpoint {
+                                       remote-endpoint = <&hdmi_connector_in>;
+                               };
+                       };
+               };
+       };
+
-- 
2.24.0.393.g34dc348eaf-goog

