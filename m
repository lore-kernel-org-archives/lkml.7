Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681D1C742B3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E155208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h5gkWOal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfGLKE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 06:04:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43067 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfGLKE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 06:04:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so4093448pfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 03:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+TShMWhLwN8SmBiAr6bXkiOWeqpu2JFdqFTK8VDDlU=;
        b=h5gkWOale1JKC7q3JJ5JGsYnwMF4rXg9ycUc8TyqSYhtPfDqhRXMww1hVtAmCVuclM
         LrU9dKHZvAhoV+SbdlPevRw4Qlz2t+djP0eaF314TPHOrJvU4wceLVI+L6oX3xV1R5CI
         ZLa7NiOko2q8t5XjCYGa2NgeIkOrLKeiErpTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+TShMWhLwN8SmBiAr6bXkiOWeqpu2JFdqFTK8VDDlU=;
        b=N1f6nNp/wQjIrIXwaRXJSBCGX2ulYdCdr+Evq0tEkrakpJO6b42/F3/v5z+Grst8zA
         uOrrDz4MFiqvS7ftNzT3kt9SyGv1r0KK6QbN/OJXSwYtA6vCdUzrEO0sK0FFSttY7jP4
         0dbIU5NT8BHeCQ6FyQ061G6X2OAfu20sp4S2zB8QqUYPMdUaT280/AB+wK09hZdnoBbL
         DSGwmGbD6tl1/UAjhljNKHLPo40kq0SKpZHHrluehz46m81yhN1WVOo83weJ+1Bghsys
         YAEPCX/QpT1JYBKhQViu5uaYc+FtIQbiHfSOo5sLnwAJzNNkgpu5ZYvkTauRWYAd3V6d
         +9JA==
X-Gm-Message-State: APjAAAXEzwnMh//jlqlTKAE8LM0mDX6ZGcu9eW70SPLD+ye9bA9KDIdQ
        9DtqNwJjBbIzd/AlGu6vLPvlqRgKzUk=
X-Google-Smtp-Source: APXvYqwATmqfXzDCdurIM9yTmyaXPTBgWhe7CgwnZbiAoCvMtazQjnDbkVjRZW0J7jvst+vKxiVZOQ==
X-Received: by 2002:a63:e807:: with SMTP id s7mr9495461pgh.194.1562925895786;
        Fri, 12 Jul 2019 03:04:55 -0700 (PDT)
Received: from localhost ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id v3sm7501412pfm.188.2019.07.12.03.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 03:04:54 -0700 (PDT)
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
Subject: [PATCH v3 0/5] Add HDMI jack support on RK3288
Date:   Fri, 12 Jul 2019 18:04:38 +0800
Message-Id: <20190712100443.221322-1-cychiang@chromium.org>
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

Changes from v2 to v3:
- dw-hdmi-i2s-audio.c: Use fixed ID instead of auto ID.
- rk3288_hdmi_analog.c: Use the fixed name hdmi-audio-codec for codec device.
- rockchip_max98090: Use the fixed name hdmi-audio-codec for codec device.
- rockchip_max98090: Fix the dependency of hdmi-codec in Kconfig.

Cheng-Yi Chiang (5):
  ASoC: hdmi-codec: Add an op to set callback function for plug event
  drm: bridge: dw-hdmi: Report connector status using callback
  drm: dw-hdmi-i2s: Use fixed id for codec device
  ASoC: rockchip_max98090: Add dai_link for HDMI
  FROMLIST: ASoC: rockchip_max98090: Add HDMI jack support

 .../gpu/drm/bridge/synopsys/dw-hdmi-audio.h   |   3 +
 .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   |  12 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  55 ++++++++-
 include/sound/hdmi-codec.h                    |  16 +++
 sound/soc/codecs/hdmi-codec.c                 |  45 +++++++
 sound/soc/rockchip/Kconfig                    |   3 +-
 sound/soc/rockchip/rk3288_hdmi_analog.c       |   3 +-
 sound/soc/rockchip/rockchip_max98090.c        | 116 ++++++++++++++----
 8 files changed, 226 insertions(+), 27 deletions(-)

-- 
2.22.0.510.g264f2c817a-goog

