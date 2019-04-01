Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCA7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D61621852
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TcX442vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbfDARRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:17:55 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35815 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731039AbfDARRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:17:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id p19so4819359plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=glsr5s+XdI5E8OElKXrSOhJG5EzpWyBtwSQUCs3zmgY=;
        b=TcX442vkjfWQpxQC70BHgRkRbkU2/tJqvgUdcir+UEaQiLz9977Gd3m+QPVVBaVLK0
         1xQ7lajs0jQFLxCMjF5ayNeGMo055Fw0EOLamNSmSsMj4tnG/ucDbGqlNaVk4Gkpmspl
         zprv+7Il9sh3cfyfLV2wRaP5h+TCH5jVle6to=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=glsr5s+XdI5E8OElKXrSOhJG5EzpWyBtwSQUCs3zmgY=;
        b=FM1+akCgfC2Aan9aCoG1dvtOaTODqLoz7WIVffRCHXtfXEY5RwgzB6Ip32pmPRGOas
         s/KBums0iXDc3jVpKOQsHvk6ZGy+2efycRiLlnzHJUDbnB7HappLTduObAz8yYD3rnxq
         SFSHsp7wOz3AtxToflan4BdkNneocN76q1G5P12VS0DqZVXHDMDby0e/Bc6cI4mkx1ah
         ohifB39pRw2Ac0czIPNE+RdigkuqVymJ3XFuZnNd4eiNflt06CQcVfosViKQGwa1LrX4
         LE6S0JBmqChr8AzwMqj4i/mTgCKdzQ2xAjnMUJKxiYmE/pcezz5ZOSMYM4t1L3PWT+t8
         HTkw==
X-Gm-Message-State: APjAAAW2QkQ72iYPbopB5ROqD7ooEej6A1YzjE8aVfk8uoz66quJZlbw
        AqwNV+JZZB6/9BSOozGcdrNWixNL7r8=
X-Google-Smtp-Source: APXvYqx7wUIzLLe7Nyc479/ioHCQ6EnzrtmezVmxgg8KZIhRgA3BwDqQ/+5CWD1TGc3ev+3Aa0LIPg==
X-Received: by 2002:a17:902:e508:: with SMTP id ck8mr3655525plb.96.1554139073184;
        Mon, 01 Apr 2019 10:17:53 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id y12sm31370112pgq.64.2019.04.01.10.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 10:17:52 -0700 (PDT)
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
Subject: [PATCH v5 1/7] dt-bindings: Add panel-timing subnode to simple-panel
Date:   Mon,  1 Apr 2019 10:17:18 -0700
Message-Id: <20190401171724.215780-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190401171724.215780-1-dianders@chromium.org>
References: <20190401171724.215780-1-dianders@chromium.org>
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
Changes in v5:
 - Removed bit about OS may ignore (Rob/Ezequiel)

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

 .../bindings/display/panel/simple-panel.txt   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/simple-panel.txt b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
index b2b872c710f2..93882268c0b9 100644
--- a/Documentation/devicetree/bindings/display/panel/simple-panel.txt
+++ b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
@@ -15,6 +15,16 @@ Optional properties:
   (hot plug detect) signal, but the signal isn't hooked up so we should
   hardcode the max delay from the panel spec when powering up the panel.
 
+panel-timing subnode
+--------------------
+
+This optional subnode is for devices which require a mode differing
+from the panel's "typical" display timing.
+
+Format information on the panel-timing subnode can be found in
+display-timing.txt.
+
+
 Example:
 
 	panel: panel {
@@ -25,4 +35,16 @@ Example:
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

