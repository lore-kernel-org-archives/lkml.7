Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7B3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7522186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MBPaO0Zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfCONI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:08:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35382 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbfCONI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:08:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id j5so6344735pfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AAGhTSDHAoMycmwWhiYuqV20infnrcRGhVpZHstA2bg=;
        b=MBPaO0Zlx6KmpReudelpodsNyJVUCGSCpbLXUCDBE4Gk4lNLmH9Q962W2iZrzcb1kI
         p7uKF6K4R+IWlpYpsYu7ulJfwNAANlIB7a9ergDTeD5hLXTBPi4l5SDkuwl0PPCAhJ17
         2+842mCm9/OLFiH12q0RCeoQIFTZ2ilmfrjjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAGhTSDHAoMycmwWhiYuqV20infnrcRGhVpZHstA2bg=;
        b=WXrjUmFRzyLp726d/jzyInXFUhgrF6jeW2jsWBlM2/nfsaTa3mRiyyfuyunc4MEFGa
         57t51MGnT67MccD5zSIxQ9avLZb7zZVUfQ8SO2duAPNZ9/VLjFw8J9GbFK5RRwTl0vZ6
         L6KTOQtKWGAlvB++Yxv33Kt2HPh4YZSfHip03LDAwe4KySFulXGPxdOzzn//EyuaF9Tg
         pPg445pxENj27i0XQQ9cAzfEhajzTmvMQuoc++ClCr8uYrui2D0dVq6jz1h3nTlHobEm
         OFpN5+Py0n3OG1UdmNP3lJRKCw4tNdOJS5mFBuUCeLa/mHkFQsHdumd41Sf0pY43yGQp
         5zAg==
X-Gm-Message-State: APjAAAW3OSOKcAgi8fP1q/TQNsVoD7JHO0KVA/8BlPGawfIqgOwYisdu
        sSUHV8TDVB6EJJvqHrL4tyDPgQ==
X-Google-Smtp-Source: APXvYqwcggiwzRNyL5wb9wjvS6uJ2yZ3aXzKDLXnQmN7h6tse4rgW0S1r+UhaABSrbJyIOG6jy4rwg==
X-Received: by 2002:a17:902:234b:: with SMTP id n11mr4218595plg.89.1552655336942;
        Fri, 15 Mar 2019 06:08:56 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.185])
        by smtp.gmail.com with ESMTPSA id e2sm854008pfa.64.2019.03.15.06.08.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 06:08:56 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 4/6] dt-bindings: display: bridge: Add ICN6211 MIPI-DSI to RGB convertor bridge
Date:   Fri, 15 Mar 2019 18:38:23 +0530
Message-Id: <20190315130825.9005-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190315130825.9005-1-jagan@amarulasolutions.com>
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
It has a flexible configuration of MIPI DSI signal input
and produce RGB565, RGB666, RGB888 output format.

Add dt-bingings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../display/bridge/chipone,icn6211.txt        | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
new file mode 100644
index 000000000000..7f13efd7ee7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
@@ -0,0 +1,36 @@
+Chipone ICN6211 MIPI-DSI to RGB Convertor Bridge
+
+ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
+It has a flexible configuration of MIPI DSI signal input
+and produce RGB565, RGB666, RGB888 output format.
+
+Required properties for RGB:
+- compatible: must be "chipone,icn6211" and one of:
+  * "bananapi,icn6211"
+- reg: the virtual channel number of a DSI peripheral
+- reset-gpios: a GPIO phandle for the reset pin
+
+The device node can contain following 'port' child nodes,
+according to the OF graph bindings defined in [1]:
+  0: DSI Input, not required, if the bridge is DSI controlled
+  1: RGB Output, mandatory
+
+[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
+
+Example:
+
+	bridge@0 {
+		compatible = "bananapi,icn6211", "chipone,icn6211";
+		reg = <0>;
+		reset-gpios = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD6 */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@1 {
+			reg = <1>;
+
+			bridge_out_ep: endpoint {
+				remote-endpoint = <&panel_ep>;
+			};
+		};
+	};
-- 
2.18.0.321.gffc6fa0e3

