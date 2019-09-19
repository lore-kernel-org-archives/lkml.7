Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C3DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEAB21D7A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FmYK84Ry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390737AbfISNzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:55:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46467 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388949AbfISNzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:55:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so1936331pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 06:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QcejNC9fZ/NTUQ3FSm9GGJHJUw8LFfPEgVCIpwJsA9I=;
        b=FmYK84RyOgnliQ31WHT/B2X1rhvCHXNKlvyGmlVRO6Gpnzh/yL+0IWnFuePQCs0YK7
         +EYn5B+vPDFY2t1doWxyw/Wd/JDH+PBoa7As7ehNNs/LaWfDv5hH9QpdJZvm+Yb2diYP
         DvCuozGD+FhcOyRrTAaTNxWnzHPNP9l0BEObg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QcejNC9fZ/NTUQ3FSm9GGJHJUw8LFfPEgVCIpwJsA9I=;
        b=uAww9HLVnE3fbESpsaquKwWDTqT858Ztj9tttQq/pvWAsV18Ghv2wmh0KroCd22FYS
         E4kfJgvWx3ysptm1eychxDAFVfWzrfCNZCmDwK0DndNXm3JGeZmXQGW8y4mY17SsCXq3
         Y+y23g92iXJDK/l8ZB5VraoAQDW+QUEmCnqr/5Hg4iL1aTb9yxCx6MoErvL3v/gWsz+F
         /XZu1qAPohX++CcKpoTziE+SLins/glVuonYgMsWcP4bKNf1pkphTd3ZZKSEiV24UE9s
         ZRjed+xlyZW+KdfAGZ1J09Uiz1msHVFEUky5PDeS3MJ6UkpdWxlAV3Ns54d96P4BK36M
         NuhQ==
X-Gm-Message-State: APjAAAVdwdeNp/HJpbtLe36KHWDZDWTyrSHKiNuEsKYHWENupukZgh96
        PcQcW2jXoGysaBfRhWkc61XsNWUJT/8=
X-Google-Smtp-Source: APXvYqwzVnj7vxmA6CmoajQ5DhGoNUc4s8peBeQOyXU+7fwt6n3lmQmFbq+8zRi0BN2hVeUmT9gckw==
X-Received: by 2002:a17:90a:9dc1:: with SMTP id x1mr3790773pjv.98.1568901304488;
        Thu, 19 Sep 2019 06:55:04 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id o195sm13065184pfg.21.2019.09.19.06.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 06:55:03 -0700 (PDT)
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
Subject: [PATCH v7 0/4] Add HDMI jack support on RK3288
Date:   Thu, 19 Sep 2019 21:54:46 +0800
Message-Id: <20190919135450.62309-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
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

https://patchwork.kernel.org/patch/11047447

has been picked up by Mark Brown in ASoC tree for-5.4 branch.

Changes from v6 to v7:

1. rockchip_max98090: Use phandle of HDMI from DTS to find
   codec_dai. With this we don't need to set fixed id for the
   created hdmi-audio-codec device.

Cheng-Yi Chiang (4):
  drm: bridge: dw-hdmi: Report connector status using callback
  ASoC: rockchip-max98090: Add description for rockchip,hdmi-codec
  ASoC: rockchip_max98090: Add dai_link for HDMI
  ASoC: rockchip_max98090: Add HDMI jack support

 .../bindings/sound/rockchip-max98090.txt      |   2 +
 .../boot/dts/rk3288-veyron-analog-audio.dtsi  |   1 +
 .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   |  11 ++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  41 ++++-
 include/drm/bridge/dw_hdmi.h                  |   4 +
 sound/soc/rockchip/Kconfig                    |   3 +-
 sound/soc/rockchip/rockchip_max98090.c        | 149 ++++++++++++++----
 7 files changed, 182 insertions(+), 29 deletions(-)

-- 
2.23.0.237.gc6a4ce50a0-goog

