Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AEBC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E428621D7A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iWJDh8Ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbfISNz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:55:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42255 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbfISNz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:55:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id z12so1951755pgp.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 06:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hcI+2qu3SHO1kkNhBRtR499gEhJVXFuDOb0iaJPJu1o=;
        b=iWJDh8AorH8nEJumZm/WKDcQuo+qYc151hnc2ynZHB08lu8t45FcSFc3XK8W4mnp1c
         T3000UZZfeJmfDdnixCbXHBmimTrjln/Z/hDuuTKRAyWMnJ9IL3M2Pgs8uVYZ8Okmtj9
         olBky5YGCY5LZ6wfafMKw7O8qXwRl3ZWMAZ34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hcI+2qu3SHO1kkNhBRtR499gEhJVXFuDOb0iaJPJu1o=;
        b=pqoADJk7IhHYbtey0m9wbB9SLNEH/C8LErxiCSYsyJ0aJpYdCOHUMYwuevs5TqPvxJ
         T38QZ9TEPMAZQPEFSF4v/GXewDC9DdgkPIkvQoZJzoI8AKq5Wf73sqhRTYxlXge2NCTW
         nAbjov6HQHlUvnJwGYxc/ToGpu0+bri/oINk02h4mBpDvYgBxa5M2MhRw/i9XYR6sAAO
         gaKOgVtC6lhisVLxMJUCEF/VrlaYu4E1+filnsrtF2FevPpPl6woioa2hJAZ6V7Znh+Q
         r9IfQ9GyxcXM0Sn6X774pBb2vyYbl9pJ0xW+voT833QjcSm28bFoQKEEox8NmQfputDX
         SKaQ==
X-Gm-Message-State: APjAAAUxbxQZCdkmLO+0hzJ8+aoGmLP3oHKT6gewGeNeM3KHpXec6hrb
        w3dU3CSol9qdcM95Bdd/3HylyZacxpI=
X-Google-Smtp-Source: APXvYqxyO8jD+PyDoTHkQIAYtp40Pex0/Mt27q7YWzADpFPuYqtJNqaFngWeKrfqiIca+BqjDGsIqA==
X-Received: by 2002:aa7:8acf:: with SMTP id b15mr4201816pfd.191.1568901324804;
        Thu, 19 Sep 2019 06:55:24 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id q88sm6395907pjq.9.2019.09.19.06.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 06:55:24 -0700 (PDT)
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
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v7 2/4] ASoC: rockchip-max98090: Add description for rockchip,hdmi-codec
Date:   Thu, 19 Sep 2019 21:54:48 +0800
Message-Id: <20190919135450.62309-3-cychiang@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
In-Reply-To: <20190919135450.62309-1-cychiang@chromium.org>
References: <20190919135450.62309-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for HDMI codec in rockchip-max98090.
Let user specify HDMI device node in DTS so machine driver can find
hdmi-codec device node for codec DAI.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 Documentation/devicetree/bindings/sound/rockchip-max98090.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-max98090.txt b/Documentation/devicetree/bindings/sound/rockchip-max98090.txt
index a805aa99ad75..97fc838458f7 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-max98090.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-max98090.txt
@@ -7,6 +7,7 @@ Required properties:
   connected to the CODEC
 - rockchip,audio-codec: The phandle of the MAX98090 audio codec
 - rockchip,headset-codec: The phandle of Ext chip for jack detection
+- rockchip,hdmi-codec: The phandle of HDMI device for HDMI codec.
 
 Example:
 
@@ -16,4 +17,5 @@ sound {
 	rockchip,i2s-controller = <&i2s>;
 	rockchip,audio-codec = <&max98090>;
 	rockchip,headset-codec = <&headsetcodec>;
+	rockchip,hdmi-codec = <&hdmi>;
 };
-- 
2.23.0.237.gc6a4ce50a0-goog

