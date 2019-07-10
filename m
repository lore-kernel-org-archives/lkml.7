Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94697C73C6D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE9320693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QvHVOdXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfGJHIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:08:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33761 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfGJHIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:08:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so654374pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 00:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l6Pj1C/JhLO9pIuL0o6GitOicJcsYgk0aas0LOHb1To=;
        b=QvHVOdXMpWGBXu6BQw2jb5hQWR/4IGqs4UNl0MT4bqGhu5Iajbok3zWGlXLBLlAlA9
         262x1usDPZZzrmJK/3Rcc1CmfG+FofUbFhNMjNYCW/5S2inZrI0tZc+5f/Yr3ArqOg1U
         UezUTifar1c9zaRSMgeuuMvYvOFH23m9ls4vM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l6Pj1C/JhLO9pIuL0o6GitOicJcsYgk0aas0LOHb1To=;
        b=DY5mWIF+kLa05U+Rx+CGtLPBL3bqMePIvb743ckyHqG/2iH/i9hjodToxLgsmNO6xX
         sDyboW5ETy0lNV388nY2R0aUcZbNnsei9mLVWD/05KH3XKClDARQ8JvvGComl3v9Mr+t
         BtA8AD1yJ7JalJFnMLX7CAOAVIhEcgPAP+81LUBIyXCBXeBq4F1dQOXDQeGlYkLuLYhm
         5mXvZgfbtH+CyEU+7PLP/712dI2Mg2+p63Sxt85tj31vUFIcCOdoR6WdYT50qxHAfQBW
         iJwWFYsn8TfiYL/qdqNzojo2otVqgncRiUgPnQNyckufgBqaXkh2VNyn2qRah1uxWqpG
         8D+w==
X-Gm-Message-State: APjAAAVjzejEUyf9NGVbwP502HaSyrLkG+TJZq0DPu9OrcjPkCtJH9sS
        lLlV0+n7CP9OusVXJ6ZCJZtJrKYdXJo=
X-Google-Smtp-Source: APXvYqyptBK3QFmyTbtCBUlG3BZ20BDJXUXcje4pWPJB6gSPNpTgfvwvrkqkt0izgOTaBRL2tpwJwQ==
X-Received: by 2002:a65:500d:: with SMTP id f13mr34874390pgo.151.1562742491443;
        Wed, 10 Jul 2019 00:08:11 -0700 (PDT)
Received: from localhost ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id h9sm1150976pgk.10.2019.07.10.00.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 00:08:10 -0700 (PDT)
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
Subject: [PATCH v2 0/4] Add HDMI jack support on RK3288
Date:   Wed, 10 Jul 2019 15:07:47 +0800
Message-Id: <20190710070751.260061-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
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

Changes from v1 to v2:
- hdmi-codec.c: cleanup the sequence of hdmi_codec_jack_report and
  hdmi_codec_set_jack_detect.
- dw-hdmi.c: change argument of hdmi_codec_plugged_cb so it takes a generic
  device which has hdmi_codec_priv in its drvdata.
- dw-hdmi.c: add a helper function handle_plugged_change to check audio
  platform device and codec platform device before calling callback.
- dw-hdmi-c: avoid setting callback function if audio platform device or
  codec platform device is missing.
- rockchip_max98090: fix the checking of return code when setting sysclk
  on cpu_dai and codec_dai. cpu_dai error should be reported. For HDMI
  codec_dai, there is no need to set sysclk.

Cheng-Yi Chiang (4):
  ASoC: hdmi-codec: Add an op to set callback function for plug event
  drm: bridge: dw-hdmi: Report connector status using callback
  ASoC: rockchip_max98090: Add dai_link for HDMI
  ASoC: rockchip_max98090: Add HDMI jack support

 .../gpu/drm/bridge/synopsys/dw-hdmi-audio.h   |   3 +
 .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   |  10 ++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  55 ++++++++-
 include/sound/hdmi-codec.h                    |  16 +++
 sound/soc/codecs/hdmi-codec.c                 |  45 +++++++
 sound/soc/rockchip/rockchip_max98090.c        | 116 ++++++++++++++----
 6 files changed, 221 insertions(+), 24 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

