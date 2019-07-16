Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5549C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 11:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0262173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 11:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ktGe9+lA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbfGPL5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 07:57:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42785 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfGPL5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 07:57:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id t132so9325509pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 04:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IeXE1WNIbLgZbuXjaQOxWA+uaePxQPbUYQ3+kYNaWMc=;
        b=ktGe9+lAGPHwFi/wlz8lD76+AeIaTQtERkWK4VsGnh1JYg9WPux230jP1y7OvF1kD+
         ZXbjD8fqqdXuMjOOoKBf0pLRsxEuM6VZC4+OvbNncs/GBXHHvW2rt6ldjj/ebR3ZDpu+
         XNugwN2hk34e+scqI+o0eCXzJhj5hbsMCDaiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IeXE1WNIbLgZbuXjaQOxWA+uaePxQPbUYQ3+kYNaWMc=;
        b=uFpTS/RJ4WAPPS9vgffyRBX4h02zwIGq2oC1mp+Xgz0MFk7PwIIdQDzZBumbdDFq4U
         CWqbZ7AaaTyZWxKgHmlcuRUsLLf+CGxRGHu+DtjY0kn+7hIri5rYEEhLnngufJdD81uC
         iKPUkIduIQQxQAlQ0kYjs8vMjkoEapHVs5/wd/pIp9KFSjINAz0ykiGFwm8SkPXHlVML
         waIVGFHOCqV7wa2Fznt+LyrsJDQCH2JGKU0K+YfmlrviyHUooIy2yDaKy4ad+uqigdyd
         ZnWx+0I8fo1Nw7aqlsQkcwxDVChEoPvUMLWG49S4TLM4RlG2e46fYtF4JkKmPjoOC8xW
         TlgA==
X-Gm-Message-State: APjAAAUXiDvToLAmSAuWOcolPfUCn03qeSq5ZpMbx4qIx9/4neuBz/Qk
        +1QmoR+fEAbDZ9XtWp2H+ZP/LhsXpR0=
X-Google-Smtp-Source: APXvYqxZI85uD2GdvaU3cmn0bFXHmYYOfFV7BJ7eG6YxMTU8Do/1HOLml+Z27bIuOXPOuQu/8HZpFg==
X-Received: by 2002:a63:1215:: with SMTP id h21mr33096297pgl.221.1563278255748;
        Tue, 16 Jul 2019 04:57:35 -0700 (PDT)
Received: from localhost ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id e10sm21197516pfi.173.2019.07.16.04.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 04:57:34 -0700 (PDT)
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
Subject: [PATCH v4 0/5] Add HDMI jack support on RK3288
Date:   Tue, 16 Jul 2019 19:57:20 +0800
Message-Id: <20190716115725.66558-1-cychiang@chromium.org>
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

Changes from v3 to v4:
- hdmi-codec.h: Modify the hook_plugged_cb ops to take an additional argument,
  that is, the pointer to struct device for codec device.
- dw-hdmi-i2s-audio.c: Simplify the registration of callback so it uses
  dw_hdmi_set_plugged_cb exported by dw-hdmi.c.
- dw-hdmi.c: Simplify the flow to invoke callback since now dw_hdmi has a
  pointer to codec device as callback argument. There is no need to rely
  on driver data of other driver.
- dw-hdmi.c: Minor change for readability.
- synopsys/Kconfig: Fix the dependency of hdmi-codec in Kconfig.
- Fixed the incorrect FROMLIST title of patch 5/5.

Cheng-Yi Chiang (5):
  ASoC: hdmi-codec: Add an op to set callback function for plug event
  drm: bridge: dw-hdmi: Report connector status using callback
  drm: dw-hdmi-i2s: Use fixed id for codec device
  ASoC: rockchip_max98090: Add dai_link for HDMI
  ASoC: rockchip_max98090: Add HDMI jack support

 drivers/gpu/drm/bridge/synopsys/Kconfig       |   2 +-
 .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   |  13 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  41 ++++++-
 include/drm/bridge/dw_hdmi.h                  |   4 +
 include/sound/hdmi-codec.h                    |  17 +++
 sound/soc/codecs/hdmi-codec.c                 |  46 +++++++
 sound/soc/rockchip/Kconfig                    |   3 +-
 sound/soc/rockchip/rk3288_hdmi_analog.c       |   3 +-
 sound/soc/rockchip/rockchip_max98090.c        | 116 ++++++++++++++----
 9 files changed, 217 insertions(+), 28 deletions(-)

-- 
2.22.0.510.g264f2c817a-goog

