Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AB4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E9F20679
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P4SRp8hs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbfJ1HTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:19:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38703 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730751AbfJ1HTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:19:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id c13so6289777pfp.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 00:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1kARxN4zXqzFWFi9Hzge3EGrR8GY2GeJ7Yqz9IBjLtM=;
        b=P4SRp8hsDD5IeFRKKfwF24MUFSYWQUG8Pifned/ZXWMMwEDxyNi2fo2IBqSZemeTIr
         YXzLkF57dbipVFhFy74e+kfK6A+vvnGLJ9qcYvXjfL/f0CZKSBWPERoIjFznbevPjcKy
         2Yr0AWo8FKDfZP5ZaXkh/LIexFunlbxZ+g2ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1kARxN4zXqzFWFi9Hzge3EGrR8GY2GeJ7Yqz9IBjLtM=;
        b=LrNv8vWhvI0eySUTLuBuyXFD9YfGsl5wXPsGjbrnVCjwHYAN/7yLSSJixvwib41i3J
         +fV5/JnRI9a/a5iSMP1OQLqn+esHzxrwmaod+OH+bgkMnreYs6rYUjBvQOi58p2aJmqk
         07HJkvCBl4RIJrq2S7zu7rPPx2uj6GGDJzL1cspccv2xQsxIB0wYntgHLew1Qoaofea8
         KrCWksB3VKacJouES4Fqong+fUUbdbpbZp3V1M3ZUpNLLMl9oaGWhbS6MrpjDJEMTIT/
         MAcy/Iilrveq4jhzrzrSC3mK4pGxR3V6BYOgoM+t/Oqdh+foBpkW+m8LgnkUxXKE8ntX
         rlVQ==
X-Gm-Message-State: APjAAAU3PU2C6a05hgsrVToAZ69x2nl+ZB4TVKtXpXAVdtaNUQH+tO6h
        0emLIpjJ5+atBZVn/7VMmO3l3n3NjSbPng==
X-Google-Smtp-Source: APXvYqyQ6aIEt1WbaZMUGlnrW1jFW16UZAwHLIo+j1unzlK77i3d3XcL512n21QVNwPfdFP+R7kEQQ==
X-Received: by 2002:a63:ff56:: with SMTP id s22mr19089316pgk.44.1572247179560;
        Mon, 28 Oct 2019 00:19:39 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id h28sm12513742pgn.14.2019.10.28.00.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2019 00:19:38 -0700 (PDT)
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
Subject: [PATCH v9 0/6] Add HDMI jack support on RK3288
Date:   Mon, 28 Oct 2019 15:19:24 +0800
Message-Id: <20191028071930.145899-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series supports HDMI jack reporting on RK3288, which uses
DRM dw-hdmi driver and hdmi-codec codec driver.

The previous discussion about reporting jack status using hdmi-notifier
and drm_audio_component is at

https://lore.kernel.org/patchwork/patch/1083027/

The new approach is to use a callback mechanism that is
specific to hdmi-codec.

The dependent change on hdmi-codec.c

commit 6fa5963c37a2 ("ASoC: hdmi-codec: Add an op to set callback function for plug event")

has been merged to upstream.

Changes from v8 to v9:

1. rockchip_max98090:
   Use the presence of rockchip,audio-codec to determine the presense of max98090
   in sound card.
   Use the presence of rockchip,hdmi-codec to determine the presence of HDMI in
   sound card.
   Remove the compatible strings added in v8.

2. #include <sound/hdmi-codec.h> should be in the patch of adding HDMI jack support.

Cheng-Yi Chiang (6):
  drm: bridge: dw-hdmi: Report connector status using callback
  ASoC: rockchip-max98090: Support usage with and without HDMI
  ASoC: rockchip_max98090: Optionally support HDMI use case
  ASoC: rockchip_max98090: Add HDMI jack support
  ARM: dts: rockchip: Add HDMI support to rk3288-veyron-analog-audio
  ARM: dts: rockchip: Add HDMI audio support to rk3288-veyron-mickey.dts

 .../bindings/sound/rockchip-max98090.txt      |  27 +-
 .../boot/dts/rk3288-veyron-analog-audio.dtsi  |   1 +
 arch/arm/boot/dts/rk3288-veyron-mickey.dts    |   7 +
 .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   |  11 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  41 ++-
 include/drm/bridge/dw_hdmi.h                  |   4 +
 sound/soc/rockchip/Kconfig                    |   3 +-
 sound/soc/rockchip/rockchip_max98090.c        | 313 ++++++++++++++----
 8 files changed, 338 insertions(+), 69 deletions(-)

-- 
2.24.0.rc0.303.g954a862665-goog

