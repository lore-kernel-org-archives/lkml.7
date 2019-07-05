Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1274EC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CCD20856
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FH7xwm41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfGEE0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 00:26:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36609 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfGEE0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 00:26:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so3728399pfl.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 21:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ensoF4e5rXwj74hLBAIVZsxBBZL6nZ0Z+cRMEnh3LdU=;
        b=FH7xwm41hWZcz/bAm+ebH7WH/5qVUe7aIauNjE+VqhgU4DONdUYDjR6z3/jLVCpfFL
         +ZyqOEs/+VQDuVAKFfcSwZkA8O1zp5vb1wdIIFfnHLEfwZVUyvh2eD1eewv/HY0dGTZy
         hOrcbDsGJEEK2DJUNTWxd/2vDfa0hfcJ7qHBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ensoF4e5rXwj74hLBAIVZsxBBZL6nZ0Z+cRMEnh3LdU=;
        b=lZap2oJRJZIbLebmUjmcx0Zdl3u1FYTN9l0sUZ2qku0ia0bf9xyBqdXzoR7HvcpTIK
         x2gh1rSjBpOTTi+kt6czmPbtAWcim9frGsDWXNkdzMDOlMvWfIFtddiL/x2Svc1zSVw9
         73Fij8Um/qpbLtHrpnbZzbbNiefTzRhX2gnGFh9jAGWA7bhNvTFk4ydg9ZmdJiwLBP2O
         ZHpQpKHmW1XUhQR5+Z4nekgTDB2NxyHAXoizIyc/o65zuPtMNXGo8RCQIDH/RpTEo8L2
         q9mRGedAQ5klp1Ba6hJEAD07luwNdf7SjZJ45NGPBKbSvnLhst9UZGuRoK7m11tU0ufX
         2DKg==
X-Gm-Message-State: APjAAAV99sVxpqMGsBkgzgE22YKj9m/Q5dfXCuR94NaBElwMaCTgvABf
        B8LXR0wR+Y6uKG9cmdHPvAXAEGYzlTk=
X-Google-Smtp-Source: APXvYqyf2nrb7RrUXLJ76qJyQDgKtq5/C+VLUCT/21TfLnfPJ/m2mK68NmzbeQqbgUJDJTJaH+v/mQ==
X-Received: by 2002:a17:90a:e38f:: with SMTP id b15mr2098527pjz.85.1562300791713;
        Thu, 04 Jul 2019 21:26:31 -0700 (PDT)
Received: from localhost ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id q3sm6050507pgv.21.2019.07.04.21.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 21:26:30 -0700 (PDT)
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
Subject: [PATCH 0/4] Add HDMI jack support on RK3288
Date:   Fri,  5 Jul 2019 12:26:19 +0800
Message-Id: <20190705042623.129541-1-cychiang@chromium.org>
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

Cheng-Yi Chiang (4):
  ASoC: hdmi-codec: Add an op to set callback function for plug event
  drm: bridge: dw-hdmi: Report connector status using callback
  ASoC: rockchip_max98090: Add dai_link for HDMI
  ASoC: rockchip_max98090: Add HDMI jack support

 .../gpu/drm/bridge/synopsys/dw-hdmi-audio.h   |   3 +
 .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   |  10 ++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  32 ++++-
 include/sound/hdmi-codec.h                    |  16 +++
 sound/soc/codecs/hdmi-codec.c                 |  52 ++++++++
 sound/soc/rockchip/rockchip_max98090.c        | 112 ++++++++++++++----
 6 files changed, 201 insertions(+), 24 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

