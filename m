Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EB0CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C40A21D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ALs7cBkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504687AbfJYNan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:30:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39781 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439018AbfJYNan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:30:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17so1244561plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 06:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cSyCYud2FH3n+k9xbUM5DyhXCO7gVkxyPIn3KZPMoVk=;
        b=ALs7cBkQVNo8Fjg8m921Llfxbt4MVCf1rdkYs1AcXTM9C09gmEnNUXT7yWsplEi+Mf
         Fyejp8alA8EbzYFsN56GPkbqtFESHfu6RZQUVFLVTT3/korWMFAnqfvBBovvWHUxiL25
         PgbWjppTeshaG6YvdyZkW8o7x6NOK7A5YAYGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cSyCYud2FH3n+k9xbUM5DyhXCO7gVkxyPIn3KZPMoVk=;
        b=n+wQEV9BIgP1lrPsjFD0argjsjfmh0hBt9xYbZSVvGiOIC8v4/+nO3G7ychM6yc4Rz
         xfSQhz0170+D9PGPopaKrA3tG+yUUTziGtburfQKgiGYraCtqQGLUFjVlySE4FmnCfDy
         DmutHzo8usezNsuWzhEehLlJN8XMRdsW/ov9r9jGpLukswR7f1/lhfs7Kt6VCayDuXuE
         NPgD5g9P2bhBCQ92HXaKn3J/u96nf8rh/RmkJTgR9Dpeu1qBp/3JiLMluDMlQDswJRUJ
         BFhryU+jkEha4oyFEEqJqBhsoCVXgN/aDGcEUAn5X3/aDWAxRmvE7fcEGrU29m+ykaqw
         e+dA==
X-Gm-Message-State: APjAAAW1Wja0myadAlT1VbmZbkqkOHD4euw5j25bCD6WRunqxErfRvG+
        9PBuvWCMF8NYDssJJauXaUhRQbBKHGkQSA==
X-Google-Smtp-Source: APXvYqycQHeVv2f79P4vAiHHa3Pb9F7SMzCFxXTSqpZwuyvYWP563v5bjWFJjMgio5zv8hLxW+r38w==
X-Received: by 2002:a17:902:ab89:: with SMTP id f9mr3842331plr.295.1572010241727;
        Fri, 25 Oct 2019 06:30:41 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id p2sm384312pfn.140.2019.10.25.06.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 06:30:41 -0700 (PDT)
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
Subject: [PATCH v8 2/6] ASoC: rockchip-max98090: Support usage with and without HDMI
Date:   Fri, 25 Oct 2019 21:30:03 +0800
Message-Id: <20191025133007.11190-3-cychiang@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191025133007.11190-1-cychiang@chromium.org>
References: <20191025133007.11190-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There will be multiple boards sharing this machine driver.
Use compatible string to specify the use case.

"rockchip,rockchip-audio-max98090" for max98090-only.
"rockchip,rockchip-audio-hdmi" for HDMI-only
"rockchip,rockchip-audio-max98090-hdmi" for max98090 plus

Move these properties to optional because they are not needed for
HDMI-only use case.
"rockchip,audio-codec": The phandle of the MAX98090 audio codec
"rockchip,headset-codec": The phandle of Ext chip for jack detection

The machine driver change will add support for HDMI codec in
rockchip-max98090.
Add one optional property "rockchip,hdmi-codec" to let user specify HDMI
device node in DTS so machine driver can find hdmi-codec device node for
codec DAI.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 .../bindings/sound/rockchip-max98090.txt      | 38 +++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-max98090.txt b/Documentation/devicetree/bindings/sound/rockchip-max98090.txt
index a805aa99ad75..75f438741ca6 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-max98090.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-max98090.txt
@@ -1,15 +1,29 @@
 ROCKCHIP with MAX98090 CODEC
 
 Required properties:
-- compatible: "rockchip,rockchip-audio-max98090"
+- compatible: Set this property to one of the strings below depending on the
+              usage on the board:
+              "rockchip,rockchip-audio-max98090" for max98090-only.
+              "rockchip,rockchip-audio-hdmi" for HDMI-only
+              "rockchip,rockchip-audio-max98090-hdmi" for max98090 plus HDMI.
 - rockchip,model: The user-visible name of this sound complex
 - rockchip,i2s-controller: The phandle of the Rockchip I2S controller that's
   connected to the CODEC
-- rockchip,audio-codec: The phandle of the MAX98090 audio codec
-- rockchip,headset-codec: The phandle of Ext chip for jack detection
+
+Optional properties:
+- rockchip,audio-codec: The phandle of the MAX98090 audio codec. This is
+                        required if compatible string is set to the one
+                        with max98090.
+- rockchip,headset-codec: The phandle of Ext chip for jack detection. This is
+                          required if compatible string is set to the one
+                          with max98090.
+- rockchip,hdmi-codec: The phandle of HDMI device for HDMI codec. This is
+                       required if compatible string is set to the one with
+                       HDMI.
 
 Example:
 
+/* For max98090-only board. */
 sound {
 	compatible = "rockchip,rockchip-audio-max98090";
 	rockchip,model = "ROCKCHIP-I2S";
@@ -17,3 +31,21 @@ sound {
 	rockchip,audio-codec = <&max98090>;
 	rockchip,headset-codec = <&headsetcodec>;
 };
+
+/* For HDMI-only board. */
+sound {
+	compatible = "rockchip,rockchip-audio-hdmi";
+	rockchip,model = "ROCKCHIP-I2S";
+	rockchip,i2s-controller = <&i2s>;
+	rockchip,hdmi-codec = <&hdmi>;
+};
+
+/* For max98090 plus HDMI board. */
+sound {
+	compatible = "rockchip,rockchip-audio-max98090-hdmi";
+	rockchip,model = "ROCKCHIP-I2S";
+	rockchip,i2s-controller = <&i2s>;
+	rockchip,audio-codec = <&max98090>;
+	rockchip,headset-codec = <&headsetcodec>;
+	rockchip,hdmi-codec = <&hdmi>;
+};
-- 
2.24.0.rc0.303.g954a862665-goog

