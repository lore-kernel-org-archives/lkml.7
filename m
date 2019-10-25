Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEEDCA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AC621D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cgKZg2IA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504763AbfJYNbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:31:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44923 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504752AbfJYNbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:31:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so1576213pfn.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 06:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oNSnTAXUPLhOggYZsXmByzoHissc2cQrcW1ijnP3ewc=;
        b=cgKZg2IA8rLE/Gb1Fea2/UKtImFx1r+3/oLrUJKGJkgq3mqfzGP0fCzY87EqP9S0+0
         WQXRy0BralqXwRQgIPwF2wZyUs5/mIyBfACB/94kBYzmDeud7Zq9bMrWbAL3xy6flbQs
         pc4pHa+WCeiKDem2XAefpAmHZf6J9Dozhans0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oNSnTAXUPLhOggYZsXmByzoHissc2cQrcW1ijnP3ewc=;
        b=qBiA8kjRV543R0gMoFY3ctE+PJonotvrnxu571Bj9gkClRChUsyAdkmb8yAUNXiaZV
         N4dXN5JlOwPVv+YyyAw8QEScRAFpuQSx2B7ZlmNXiWHdxJ0GGLLVNc6DvjK1gJLAl9Ss
         x1yIRPwbSr+GcvZ0TBNHAvGnNuyLdISjLcc04ekV6vaFZyOnRBgoymfTIZ7Tu7iQhlhn
         FHFPaslihPjoCVVvJfI2F7fXuwC8XEDT4cvR+qSBhu61Bc3jsyyj5Sgyy3LFfWTIcSpP
         DIt5rnZu5BY7zejVoY43dEKNOhcheeUVT9JMqMZgNn/3tBeRQOJsAgwGdSsfl+Gnxoxl
         ObfA==
X-Gm-Message-State: APjAAAWHK9wNZ176skElP5+TFIB8pnDo3oi2CVKw7fO9XCJkXwKZShbz
        3OgppyLXa63jPpPwL/ENLpJ7wrULrloINQ==
X-Google-Smtp-Source: APXvYqzbwsXWBs3ky/vHamL+ysr3yMSuWsGovFl/YV0ZreeaOiOp90nD6ACzcZJAlWwB0QQOpZKsVA==
X-Received: by 2002:a63:4525:: with SMTP id s37mr4571578pga.148.1572010278731;
        Fri, 25 Oct 2019 06:31:18 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id y36sm2379120pgk.66.2019.10.25.06.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 06:31:17 -0700 (PDT)
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
Subject: [PATCH v8 5/6] ARM: dts: rockchip: Add HDMI support to rk3288-veyron-analog-audio
Date:   Fri, 25 Oct 2019 21:30:06 +0800
Message-Id: <20191025133007.11190-6-cychiang@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191025133007.11190-1-cychiang@chromium.org>
References: <20191025133007.11190-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All boards using rk3288-veyron-analog-audio.dtsi have HDMI audio.
Specify the support of HDMI audio on machine driver using compatible
string so machine driver creates HDMI audio device.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi b/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
index 445270aa136e..92ea623401e9 100644
--- a/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
@@ -8,7 +8,7 @@
 
 / {
 	sound {
-		compatible = "rockchip,rockchip-audio-max98090";
+		compatible = "rockchip,rockchip-audio-max98090-hdmi";
 		pinctrl-names = "default";
 		pinctrl-0 = <&mic_det>, <&hp_det>;
 		rockchip,model = "VEYRON-I2S";
@@ -17,6 +17,7 @@
 		rockchip,hp-det-gpios = <&gpio6 RK_PA5 GPIO_ACTIVE_HIGH>;
 		rockchip,mic-det-gpios = <&gpio6 RK_PB3 GPIO_ACTIVE_LOW>;
 		rockchip,headset-codec = <&headsetcodec>;
+		rockchip,hdmi-codec = <&hdmi>;
 	};
 };
 
-- 
2.24.0.rc0.303.g954a862665-goog

