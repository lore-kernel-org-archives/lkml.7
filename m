Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E595C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B3F20818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RD8M6nun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfGQIdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:33:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34487 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQIdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:33:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so10488233pfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 01:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xi/I3CroR7sIGb/RSMeX63hsRQQZqTXzOZE3S6HZ8ZY=;
        b=RD8M6nunAIi1kjnoYpVPNjZL741NzPqIoh1uWt5E5r6urvKBD5w/QXtHFHOWkKP7rU
         eDsE9C26mS+c6F9BsjN7Sldy2EKwIdp+wSVCSX2fTTKK8nRLbbtA6GlxK16zRW/fm06H
         NZfy1y4+ZGSX3EopmPRAj88diV1ho2PkxjqX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xi/I3CroR7sIGb/RSMeX63hsRQQZqTXzOZE3S6HZ8ZY=;
        b=RDmJkdsdB11UnYBEFkg/PB62uimNFx3kwkIfrk4o0oTDj7aauCsbjpfZiaJrwwhbtA
         yVe0qUnOgIzglmQdk6TQrgGR9G9mfI6mU8JNnWTUnH/YnlrJClv832PnPc99OHqEXuB+
         3i0hr5kWy969vBjGpH+0Ksj1C11QI3LXlBDux52Kt+MuiAW9L6R0m1vii8fKC0ahEaii
         cyY0Qk2Zou+rRCsRaf45uFqqhyHkgCf38VBmx/gAmtIbuKljtP42IBkdKv0ipfaZ/0UU
         M6VzMV9ILx02F5uXSPOYzjgl3XiGY9yIBKFPgVw6woa1bGBSzSKkitssuvbqnPquAdiM
         nzxQ==
X-Gm-Message-State: APjAAAXA5qRtfPOYI9Ll0jIAMECsjqM7WexQT/WdCLnsteITQv6v4QaX
        oOLk+bqMBnCACY5ma85iWSi4kGmktx8=
X-Google-Smtp-Source: APXvYqzYyxaOAPwCDczy1nF4W7TyzTBcE11lWgiyzwF6LECNndF7weCTc6ymyZwVNBlIDSpFxsBrbA==
X-Received: by 2002:a63:506:: with SMTP id 6mr39061533pgf.434.1563352414509;
        Wed, 17 Jul 2019 01:33:34 -0700 (PDT)
Received: from localhost ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id r2sm33193385pfl.67.2019.07.17.01.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 01:33:33 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, Mark Brown <broonie@kernel.org>,
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
Subject: [PATCH v5 0/5] Add HDMI jack support on RK3288
Date:   Wed, 17 Jul 2019 16:33:22 +0800
Message-Id: <20190717083327.47646-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
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

Changes from v4 to v5:
- synopsys/Kconfig: Remove the incorrect dependency change in v4.
- rockchip/Kconfig: Add dependency of hdmi-codec when it is really need
  for jack support.

Cheng-Yi Chiang (5):
  ASoC: hdmi-codec: Add an op to set callback function for plug event
  drm: bridge: dw-hdmi: Report connector status using callback
  drm: dw-hdmi-i2s: Use fixed id for codec device
  ASoC: rockchip_max98090: Add dai_link for HDMI
  ASoC: rockchip_max98090: Add HDMI jack support

 .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   |  13 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  41 ++++++-
 include/drm/bridge/dw_hdmi.h                  |   4 +
 include/sound/hdmi-codec.h                    |  17 +++
 sound/soc/codecs/hdmi-codec.c                 |  46 +++++++
 sound/soc/rockchip/Kconfig                    |   3 +-
 sound/soc/rockchip/rk3288_hdmi_analog.c       |   3 +-
 sound/soc/rockchip/rockchip_max98090.c        | 116 ++++++++++++++----
 8 files changed, 216 insertions(+), 27 deletions(-)

-- 
2.22.0.510.g264f2c817a-goog

