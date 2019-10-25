Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5859CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7969E21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VTVnd3DJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504775AbfJYNbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:31:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41684 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504765AbfJYNbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:31:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id l3so1553906pgr.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 06:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z55UMaWEIEJNVekf1KUtXJqZFUzcCvdu1bfEeskovPo=;
        b=VTVnd3DJJxvlTLtyPGznBCDcaWFHpqt3B2OWsYufUi5PjNkalSZF7zX2RHBscVJH34
         NvmlefixU2wv6mbtZk2HQh7csJV0v1aqD+k6gpFFRvJ06om6HBZe7CBPz+9dC/yss4fK
         lh1QNLMpzK6BbmRsTQuBp3GKYRt0JrHDTgHCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z55UMaWEIEJNVekf1KUtXJqZFUzcCvdu1bfEeskovPo=;
        b=gxub5cWJ+8nZYau0oyY+u2G+mt9msLm3MxNcRIORiATGGr2+SY5v238iPHgXNvCE+e
         jtXalNRAoGKH/cXZjbPWocAfT9mQRTddX0lXo3PYQpSdAArhLLD00aO8NW6MwbVVcvhy
         yDG1K88w9JHwUFxKXTC+ktar1Jc0+FzGyG13Ca2v7KwIH7piUrPoGGC9GtEtQxrwQNxZ
         1YI10BnbAuunu59MyYvk/sz2nMJQDJt/H7QaGn/ZR2P4xbBbSJNZ/zT1leW6XtyP+P7S
         RGD/knde2c7rakZk2hveF7v7gQaSp1N3EqB0+5mrP9+vSeqp/mu2QEuT8/lGZ08zOQcG
         I4yQ==
X-Gm-Message-State: APjAAAV2i72mrZ/YTD3vayk8JH5Q8nYaFl0CxonVgRJ59vvZNSoSOaNJ
        7SnGlPcD5yGlTgAIOsysqHJKqCj2iQ1fhw==
X-Google-Smtp-Source: APXvYqzEBEK954f+cnTf4ONcLs7stQK9JprT2+giiC3WqbjcH+UZmlt6EYuRfIZ58RAxo7Z4G+ogsw==
X-Received: by 2002:a17:90a:ff11:: with SMTP id ce17mr4114202pjb.110.1572010290956;
        Fri, 25 Oct 2019 06:31:30 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id z13sm3706421pgz.42.2019.10.25.06.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 06:31:30 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v8 6/6] ARM: dts: rockchip: Add HDMI audio support to rk3288-veyron-mickey.dts
Date:   Fri, 25 Oct 2019 21:30:07 +0800
Message-Id: <20191025133007.11190-7-cychiang@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191025133007.11190-1-cychiang@chromium.org>
References: <20191025133007.11190-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HDMI audio support to veyron-mickey. The sound card should expose
one audio device for HDMI.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 arch/arm/boot/dts/rk3288-veyron-mickey.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-mickey.dts b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
index aa352d40c991..98a2aee240f1 100644
--- a/arch/arm/boot/dts/rk3288-veyron-mickey.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
@@ -28,6 +28,13 @@
 		regulator-boot-on;
 		vin-supply = <&vcc33_sys>;
 	};
+
+	sound {
+		compatible = "rockchip,rockchip-audio-hdmi";
+		rockchip,model = "VEYRON-HDMI";
+		rockchip,i2s-controller = <&i2s>;
+		rockchip,hdmi-codec = <&hdmi>;
+	};
 };
 
 &cpu_thermal {
-- 
2.24.0.rc0.303.g954a862665-goog

