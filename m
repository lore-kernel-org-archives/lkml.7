Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E167C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E81C206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vl66ov/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfC1RR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:17:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38832 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfC1RR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:17:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id g37so5257414plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DBM+pB4CxpDj9X9ckxHYOhoSP8yGYbHTSKQhNQ0sly0=;
        b=Vl66ov/rhi5WwNbU6h29eVKCrE9SYA5S7w092zAxp0qnZ/RAev8buplTe4QwSImPVn
         Nwub8mYhk+gmVd1IoRtKYMBXyH9n00HMixzzFFTZuOQJrC/6Xr/tDLXeDyd5/yIEOwmS
         BxRzOyKq+0v8okUlkF8GKhwM6u+20WSF6c60M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DBM+pB4CxpDj9X9ckxHYOhoSP8yGYbHTSKQhNQ0sly0=;
        b=KMWK7udZ4RM+BChqz0/WFEJdg1Yt1m0tsZTnXbxoZLyE3lzzrsAkBXnpDrsxESYbOi
         sgLgj7C9l6++OLA+7YSqJZTSrCQ7bNcj6GdDYX8cvteLd/iDetC9BF8Hf8E+ShjQPztW
         dwoIWBsbAtBlQMxxEV4lD/9EHr67zxALyjpzKPy1j+3tg2081Ic2OiTLwLTyecL3LJze
         2jiwA69thpP3lAOh/oTk7NtxqD1WRUUQPNqXLqGg6MxTmeJ3q4QeDjlvGG5Oncl8XymR
         19oO34V9Mu/mG8dq4Se09usiCBhG1N6VvN0aQkL3AU/AdPxdpljUZW8whnxxvFzZpgG+
         vhCQ==
X-Gm-Message-State: APjAAAUE4exHh0wkoxm2FqW/boL6C6XyHyXSDluKCLg02hnVJHzBT0uw
        qnoBNg2e5cWiN2xmGH3jS3N1WA==
X-Google-Smtp-Source: APXvYqwbitXH3ctsAeFOy7juR1bSYPkUK/OS67IB2OrZTp/oTxmqvWQJISOi6pjRnGsrAkbO/dpwsg==
X-Received: by 2002:a17:902:7d81:: with SMTP id a1mr36554619plm.202.1553793475964;
        Thu, 28 Mar 2019 10:17:55 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id r10sm31699414pfn.188.2019.03.28.10.17.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 10:17:55 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>
Cc:     linux-rockchip@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        =?UTF-8?q?Enric=20Balletb=C3=B2?= <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, mka@chromium.org,
        Doug Anderson <dianders@chromium.org>,
        Eric Anholt <eric@anholt.net>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v4 1/7] dt-bindings: Add panel-timing subnode to simple-panel
Date:   Thu, 28 Mar 2019 10:17:04 -0700
Message-Id: <20190328171710.31949-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190328171710.31949-1-dianders@chromium.org>
References: <20190328171710.31949-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

This patch adds a new subnode to simple-panel allowing us to override
the typical timing expressed in the panel's display_timing.

Changes in v2:
 - Split out the binding into a new patch (Rob)
 - display-timings is a new section (Rob)
 - Use the full display-timings subnode instead of picking the timing
   out (Rob/Thierry)
Changes in v3:
 - Go back to using the timing subnode directly, but rename to
   panel-timing (Rob)
Changes in v4:
 - Simplify desc. for when override should be used (Thierry/Laurent)
 - Removed Rob H review since it's been a year and wording changed

Cc: Doug Anderson <dianders@chromium.org>
Cc: Eric Anholt <eric@anholt.net>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Stéphane Marchesin <marcheu@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../bindings/display/panel/simple-panel.txt   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/simple-panel.txt b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
index b2b872c710f2..6157f86ddce4 100644
--- a/Documentation/devicetree/bindings/display/panel/simple-panel.txt
+++ b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
@@ -15,6 +15,18 @@ Optional properties:
   (hot plug detect) signal, but the signal isn't hooked up so we should
   hardcode the max delay from the panel spec when powering up the panel.
 
+panel-timing subnode
+--------------------
+
+This optional subnode is for devices which require a mode differing
+from the panel's "typical" display timing.  The panel timings provided
+here will be ignored if they are found to be outside of allowable
+ranges for the given panel.
+
+Format information on the panel-timing subnode can be found in
+display-timing.txt.
+
+
 Example:
 
 	panel: panel {
@@ -25,4 +37,16 @@ Example:
 		enable-gpios = <&gpio 90 0>;
 
 		backlight = <&backlight>;
+
+		panel-timing {
+			clock-frequency = <266604720>;
+			hactive = <2400>;
+			hfront-porch = <48>;
+			hback-porch = <84>;
+			hsync-len = <32>;
+			vactive = <1600>;
+			vfront-porch = <3>;
+			vback-porch = <120>;
+			vsync-len = <10>;
+		};
 	};
-- 
2.21.0.392.gf8f6787159e-goog

